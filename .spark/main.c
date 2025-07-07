
#include <Uefi.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiRuntimeServicesTableLib.h>
#include <Library/UefiLib.h>
#include <Library/DevicePathLib.h>
#include <Library/MemoryAllocationLib.h>
#include <Library/BaseMemoryLib.h>
#include <Protocol/SimpleFileSystem.h>
#include <Protocol/LoadedImage.h>
#include <Guid/FileInfo.h>
#include <Guid/GlobalVariable.h>

#define BOX_WIDTH     60
#define BOX_PADDING   2

typedef struct {
  CHAR16 Title[128];
  CHAR16 Path [128];
} ENTRY;

EFI_HANDLE                   gImageHandle;
EFI_LOADED_IMAGE_PROTOCOL   *gLoadedImage;
EFI_EVENT                    TimerEvent;

extern EFI_SYSTEM_TABLE      *gST;
extern EFI_BOOT_SERVICES     *gBS;
extern EFI_RUNTIME_SERVICES  *gRT;

EFI_STATUS
ReadSparkScfg(
  ENTRY *Entries,
  UINTN *Count
) {
  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL *Fs;
  EFI_FILE_PROTOCOL               *Root, *File;
  EFI_FILE_INFO                   *Info;
  UINTN                            InfoSize, FileSize;
  CHAR8                           *Buffer, *Line;
  UINTN                            Index = 0;
  EFI_STATUS                       Status;

  // 1) Locate loaded image protocol
  Status = gBS->HandleProtocol(
    gImageHandle,
    &gEfiLoadedImageProtocolGuid,
    (VOID**)&gLoadedImage
  );
  if (EFI_ERROR(Status)) return Status;

  // 2) Open volume
  Status = gBS->HandleProtocol(
    gLoadedImage->DeviceHandle,
    &gEfiSimpleFileSystemProtocolGuid,
    (VOID**)&Fs
  );
  if (EFI_ERROR(Status)) return Status;
  Status = Fs->OpenVolume(Fs, &Root);
  if (EFI_ERROR(Status)) return Status;

  // 3) Open config file
  Status = Root->Open(
    Root, &File,
    L"\\EFI\\Spark\\Spark.scfg",
    EFI_FILE_MODE_READ, 0
  );
  if (EFI_ERROR(Status)) return Status;

  // 4) Get file size
  InfoSize = SIZE_OF_EFI_FILE_INFO + 200;
  Info     = AllocatePool(InfoSize);
  if (!Info) {
    File->Close(File);
    return EFI_OUT_OF_RESOURCES;
  }
  Status = File->GetInfo(File, &gEfiFileInfoGuid, &InfoSize, Info);
  if (EFI_ERROR(Status)) {
    FreePool(Info);
    File->Close(File);
    return Status;
  }
  FileSize = Info->FileSize;
  FreePool(Info);

  // 5) Read into buffer
  Buffer = AllocatePool(FileSize + 1);
  if (!Buffer) {
    File->Close(File);
    return EFI_OUT_OF_RESOURCES;
  }
  Status = File->Read(File, &FileSize, Buffer);
  File->Close(File);
  if (EFI_ERROR(Status)) {
    FreePool(Buffer);
    return Status;
  }
  Buffer[FileSize] = '\0';

  // 6) Parse lines "key=value"
  Line = Buffer;
  for (UINTN i = 0; i <= FileSize; i++) {
    if (Buffer[i] == '\n' || Buffer[i] == '\0') {
      Buffer[i] = '\0';
      CHAR8 *Eq = AsciiStrStr(Line, "=");
      if (Eq) {
        *Eq = '\0';
        if (AsciiStrCmp(Line, "title") == 0) {
          AsciiStrToUnicodeStrS(
            Eq+1,
            Entries[Index].Title,
            sizeof(Entries[Index].Title)/sizeof(CHAR16)
          );
        } else if (AsciiStrCmp(Line, "path") == 0) {
          AsciiStrToUnicodeStrS(
            Eq+1,
            Entries[Index].Path,
            sizeof(Entries[Index].Path)/sizeof(CHAR16)
          );
          Index++;
        }
      }
      Line = Buffer + i + 1;
    }
  }
  FreePool(Buffer);
  *Count = Index;
  return EFI_SUCCESS;
}

EFI_STATUS
GetFsForPath(
  CHAR16 *Path,
  EFI_HANDLE *DeviceHandle,
  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL **OutFs
) {
  EFI_HANDLE *Handles = NULL;
  UINTN HandleCount;
  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL *Fs;
  EFI_FILE_PROTOCOL *Root, *F;
  EFI_STATUS Status;

  Status = gBS->LocateHandleBuffer(
    ByProtocol,
    &gEfiSimpleFileSystemProtocolGuid,
    NULL,
    &HandleCount,
    &Handles
  );
  if (EFI_ERROR(Status)) return Status;

  for (UINTN i = 0; i < HandleCount; i++) {
    if (EFI_ERROR(gBS->HandleProtocol(
      Handles[i],
      &gEfiSimpleFileSystemProtocolGuid,
      (VOID**)&Fs
    ))) continue;
    if (EFI_ERROR(Fs->OpenVolume(Fs, &Root))) continue;
    Status = Root->Open(Root, &F, Path, EFI_FILE_MODE_READ, 0);
    if (!EFI_ERROR(Status)) {
      F->Close(F);
      *DeviceHandle = Handles[i];
      *OutFs = Fs;
      break;
    }
  }
  FreePool(Handles);
  return EFI_SUCCESS;
}

VOID DrawMenu(
  ENTRY *Entries,
  UINTN Count,
  UINTN Selected,
  EFI_TIME *Time
) {
  UINTN Columns, Rows;
  gST->ConOut->QueryMode(
    gST->ConOut,
    gST->ConOut->Mode->Mode,
    &Columns,
    &Rows
  );
  UINTN BoxH     = Count + BOX_PADDING*2 + 4;
  UINTN StartCol = (Columns - BOX_WIDTH) / 2;
  UINTN StartRow = (Rows - BoxH) / 2;

  for (UINTN r = 0; r < BoxH; r++) {
    for (UINTN c = 0; c < BOX_WIDTH; c++) {
      gST->ConOut->SetCursorPosition(
        gST->ConOut,
        StartCol + c,
        StartRow + r
      );
      if (r == 0 || r == BoxH-1) {
        Print(
          L"%c",
          (c == 0 || c == BOX_WIDTH-1) ? L'+' : L'-'
        );
      } else if (c == 0 || c == BOX_WIDTH-1) {
        Print(L"|");
      } else {
        Print(L" ");
      }
    }
  }

  gST->ConOut->SetCursorPosition(
    gST->ConOut,
    StartCol + BOX_PADDING,
    StartRow + 1
  );
  Print(
    L" Spark Boot Loader        %02d:%02d:%02d  ",
    Time->Hour,
    Time->Minute,
    Time->Second
  );

  for (UINTN i = 0; i < Count; i++) {
    UINTN row = StartRow + 3 + i;
    gST->ConOut->SetCursorPosition(
      gST->ConOut,
      StartCol + BOX_PADDING,
      row
    );
    if (i == Selected) {
      gST->ConOut->SetAttribute(
        gST->ConOut,
        EFI_BLACK | EFI_BACKGROUND_CYAN
      );
    } else {
      gST->ConOut->SetAttribute(
        gST->ConOut,
        EFI_LIGHTGRAY
      );
    }
    Print(L" %s", Entries[i].Title);
  }
  gST->ConOut->SetAttribute(gST->ConOut, EFI_LIGHTGRAY);
}

EFI_STATUS
EFIAPI
UefiMain(
  EFI_HANDLE        ImageHandle,
  EFI_SYSTEM_TABLE *SystemTable
) {
  gST          = SystemTable;
  gBS          = SystemTable->BootServices;
  gRT          = SystemTable->RuntimeServices;
  gImageHandle = ImageHandle;

  // Read config entries
  ENTRY Entries[17];
  UINTN Count;
  EFI_STATUS Status = ReadSparkScfg(Entries, &Count);
  if (EFI_ERROR(Status) || Count == 0) {
    Print(L"No valid entries in Spark.scfg: %r\n", Status);
    gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
    return Status;
  }

  // Add UEFI Settings option
  StrCpyS(Entries[Count].Title, 128, L"UEFI Settings");
  Entries[Count].Path[0] = '\0';
  Count++;

  Status = gBS->CreateEvent(
    EVT_TIMER,
    TPL_CALLBACK,
    NULL,
    NULL,
    &TimerEvent
  );
  if (EFI_ERROR(Status)) {
    Print(L"Failed to create timer event: %r\n", Status);
    gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
    return Status;
  }
  gBS->SetTimer(TimerEvent, TimerPeriodic, 10000000);

  // Main menu loop
  EFI_EVENT WaitList[2] = { gST->ConIn->WaitForKey, TimerEvent };
  EFI_INPUT_KEY Key;
  EFI_TIME Time;
  UINTN Selected;

  while (TRUE) {
    // Flush any leftover keystrokes to avoid double-enter
    EFI_INPUT_KEY FlushKey;
    while (gST->ConIn->ReadKeyStroke(gST->ConIn, &FlushKey) == EFI_SUCCESS) {
      ;
    }

    gST->ConOut->ClearScreen(gST->ConOut);
    Selected = 0;
    gRT->GetTime(&Time, NULL);
    DrawMenu(Entries, Count, Selected, &Time);

    for (;;) {
      UINTN idx;
      gBS->WaitForEvent(2, WaitList, &idx);
      if (idx == 0) {
        gST->ConIn->ReadKeyStroke(gST->ConIn, &Key);
        if (Key.ScanCode == SCAN_UP && Selected > 0) Selected--;
        else if (Key.ScanCode == SCAN_DOWN && Selected + 1 < Count) Selected++;
        else if (Key.UnicodeChar == CHAR_CARRIAGE_RETURN) break;
      } else {
        gRT->GetTime(&Time, NULL);
      }
      DrawMenu(Entries, Count, Selected, &Time);
    }

    // UEFI Settings
    if (StrCmp(Entries[Selected].Title, L"UEFI Settings") == 0) {
      UINT64 Indications = EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
      Status = gRT->SetVariable(
        L"OsIndications",
        &gEfiGlobalVariableGuid,
        EFI_VARIABLE_BOOTSERVICE_ACCESS |
        EFI_VARIABLE_RUNTIME_ACCESS  |
        EFI_VARIABLE_NON_VOLATILE,
        sizeof(Indications),
        &Indications
      );
      if (EFI_ERROR(Status)) {
        Print(L"❌ Failed to set OsIndications: %r\n", Status);
        gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
        return Status;
      }
      gST->ConOut->ClearScreen(gST->ConOut);
      Print(L"Booting to UEFI Settings...\n");
      gBS->SetTimer(TimerEvent, TimerCancel, 0);
      gRT->ResetSystem(EfiResetCold, EFI_SUCCESS, 0, NULL);
      return EFI_DEVICE_ERROR;
    }

    // Launch entry
    EFI_HANDLE FsHandle;
    EFI_SIMPLE_FILE_SYSTEM_PROTOCOL *Fs;
    Status = GetFsForPath(Entries[Selected].Path, &FsHandle, &Fs);
    if (EFI_ERROR(Status)) {
      Print(L"Cannot find %s: %r\n", Entries[Selected].Path, Status);
      gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
      return Status;
    }
    EFI_FILE_PROTOCOL *Root, *File;
    Fs->OpenVolume(Fs, &Root);
    Status = Root->Open(Root, &File, Entries[Selected].Path,
                        EFI_FILE_MODE_READ, 0);
    if (EFI_ERROR(Status)) {
      Print(L"Open failed: %r\n", Status);
      gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
      return Status;
    }
    EFI_DEVICE_PATH_PROTOCOL *Dp = FileDevicePath(FsHandle, Entries[Selected].Path);
    EFI_HANDLE Img;
    Status = gBS->LoadImage(FALSE, gImageHandle, Dp, NULL, 0, &Img);
    File->Close(File);
    if (EFI_ERROR(Status)) {
      Print(L"LoadImage failed: %r\n", Status);
      gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
      return Status;
    }

    EFI_STATUS ImgStatus = gBS->StartImage(Img, NULL, NULL);
    if (EFI_ERROR(ImgStatus)) {
      Print(L"❌ StartImage failed: %r\n", ImgStatus);
    } else {
      Print(L"✅ StartImage returned: %r\n", ImgStatus);
    }
    Print(L"Press any key to return to menu...\n");
    gBS->WaitForEvent(1, &gST->ConIn->WaitForKey, NULL);
    // Loop back to redraw menu
  }

  return EFI_SUCCESS;
}
