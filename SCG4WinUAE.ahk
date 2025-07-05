;@Ahk2Exe-SetMainIcon Boing.ico
;@Ahk2Exe-SetMainIcon Boing.ico
;@Ahk2Exe-SetDescription Swift Configuration Generator for WinUAE
;@Ahk2Exe-SetProductName SCG4WinUAE
;@Ahk2Exe-SetVersion 1.3.7
;@Ahk2Exe-AddResource SCG4WinUAE.txt

/*@Ahk2Exe-Keep
FileInstall, SCG4WinUAE.txt, SCG4WinUAE.txt, 1
*/

;#NoEnv
#NoTrayIcon
#SingleInstance Ignore
SetWorkingDir %A_ScriptFullPath%
SetBatchLines 5ms
ListLines Off

SysGet, Area, MonitorWorkArea, 0
Width := Round(AreaBottom * 1.25)
;For interger:- Factor := Round(AreaBottom * 1.25 / 320) | Width := 320 * Factor
Offset := Floor((AreaRight - Width) / 2)
;ARTest:= Width / AreaBottom
;msgbox, Width %Width%`nHeight %AreaBottom%`nOffset %Offset%`n%ARTest%

RegRead, WinUAE, HKEY_CURRENT_USER\Software\SCG4WinUAE, WinUAE
RegRead, CPU, HKEY_CURRENT_USER\Software\SCG4WinUAE, CPU
RegRead, Model, HKEY_CURRENT_USER\Software\SCG4WinUAE, Model
RegRead, Mode, HKEY_CURRENT_USER\Software\SCG4WinUAE, Mode
RegRead, JIT, HKEY_CURRENT_USER\Software\SCG4WinUAE, JIT
RegRead, 2X, HKEY_CURRENT_USER\Software\SCG4WinUAE, 2X
RegRead, ConfPath, HKEY_CURRENT_USER\Software\SCG4WinUAE, ConfPath
RegRead, KSPath, HKEY_CURRENT_USER\Software\SCG4WinUAE, KSPath
RegRead, DSPath, HKEY_CURRENT_USER\Software\SCG4WinUAE, DSPath
RegRead, Joy, HKEY_CURRENT_USER\Software\SCG4WinUAE, JoyStick

Gui -MaximizeBox -MinimizeBox
Gui, Font, s8, Verdana
If (WinUAE = "") {
	Gosub, 1stScan
	Return
}
Menu, JoystickMenu, Add, &JoyKey Mapping, Legend
Menu, JoystickMenu, Add
Menu, JoystickMenu, Add, &Disabled, NoJoy
Menu, JoystickMenu, Add, &Standard, JoyStk
Menu, JoystickMenu, Add, &CDTV/CD32, JoyPad
Menu, JoystickMenu, Add
Menu, JoystickMenu, Add, &Two Player, 2Play
If (Joy = 0) {
Gosub, NoJoy
}
If (Joy = 1 || Joy = "") {
Gosub, JoyStk
}
If (Joy = 2) {
Gosub, Joypad
}
If (Joy = 3) {
Gosub, 2Play
}
Menu, EditMenu, Add, &Re-Scan WinUAE Location, Scan
Menu, EditMenu, Add,
Menu, EditMenu, Add, &Media Images Folder, DSPath
Menu, EditMenu, Add, &Kickstart ROM Images Folder, KSPath
Menu, EditMenu, Add, &Configurations Folder, ConfPath
Menu, EditMenu, Add,
Menu, EditMenu, Add, &Reset All Settings, Reset
Menu, FileMenu, Add, &Launch WinUAE, WUAERUN
Menu, FileMenu, Add, &Open Configurations Folder, Folder
Menu, FileMenu, Add,
Menu, FileMenu, Add, &Quit SCG4WinUAE, Quit
Menu, MainMenu, Add, &File, :FileMenu
Menu, MainMenu, Add, &Edit, :EditMenu
Menu, MainMenu, Add, &Joystick, :JoyStickMenu
Menu, MainMenu, Add, &About, About, +Right
Gui, Menu, MainMenu
Gui, Add, GroupBox, h120 w100, 68k/Chipset:
If (CPU = "OCS00" || CPU = "") {
	Gui, Add, Radio, vOCS00 Checked yp+18 xp+10, 68000/OCS
}
Else {
	Gui, Add, Radio, vOCS00 yp+18 xp+10, 68000/OCS
}
OCS00_TT := "Optimized A1000/Early A500 Systems.`n`nMost commonly combined with the A1000`nBootstrap ROM & Kickstart 1.x/1.3"
If (CPU = "ECS10") {
	Gui, Add, Radio, vECS10 Checked, 68010/ECS
}
Else {
	Gui, Add, Radio, vECS10, 68010/ECS
}
ECS10_TT := "Optimized Later A500/A500+/A600 Systems.`n`nMost commonly combined with Kickstart 1.3/2.04 & 2.05`n`nThis option is also recommended for the CDTV Kickstart ROM."
If (CPU = "AGA20") {
	Gui, Add, Radio, vAGA20 Checked, 68020/AGA
}
Else {
	Gui, Add, Radio, vAGA20, 68020/AGA
}
AGA20_TT := "Optimized A1200 System.`n`nMost commonly combined with Kickstart 3.0 & 3.1`n`nThis option is also recommended for the CD32 Kickstart ROM."
If (CPU = "ECS30") {
	Gui, Add, Radio, vECS30 Checked, 68030/ECS
}
Else {
	Gui, Add, Radio, vECS30, 68030/ECS
}
ECS30_TT := "Optimized A3000 System.`n`nMost commonly combined with it's own`nversions of Kickstart 1.3/2.x & 3.1"
If (CPU = "AGA40") {
	Gui, Add, Radio, vAGA40 Checked, 68040/AGA
}
Else {
	Gui, Add, Radio, vAGA40, 68040/AGA
}
AGA40_TT := "Optimized A4000 System.`n`nMost commonly combined with it's own`nversions of Kickstart 3.0 & 3.1"

Gui, Add, GroupBox, ys ym+0 h60 w95, Screen Mode:
If (Mode = "Win" || Mode = "" || Model = "") {
	Gui, Add, Radio, vWin Checked yp+18 xp+10, Windowed
}
Else {
	Gui, Add, Radio, vWin yp+18 xp+10, Windowed
}
Win_TT := "Runs the emulation in a borderless window scaled`nto the desktop space on which it was created."
If (Mode = "Full") {
	Gui, Add, Radio, vFull Checked, Fullscreen
}
Else {
	Gui, Add, Radio, vFull, Fullscreen
}
Full_TT := "Runs the emulation in Fullscreen with`nthe resolution on which it was created."
If (JIT = "1") {
	Gui, Add, Checkbox, vJIT Checked yp+42 xp+15, JIT
}
Else {
	Gui, Add, Checkbox, vJIT yp+42 xp+15, JIT
}
JIT_TT := "Enables the Just-In-Time compiler which greatly`nspeeds up the emulation speed on 68020+ systems.`n`nMay be incompatible with a number of games"
If (2X = "1") {
	Gui, Add, Checkbox, v2X Checked yp+20, XBR
}
Else {
	Gui, Add, Checkbox, v2X yp+25, XBR
}
2X_TT := "This setting modifies the display so that the XBR shader can`nsmooth pixels rather than simply countering scaling blurriness.`n`nCompatible with Low resolution, that is, most Games."
Gui, Add, GroupBox, h155 w205 yp+27 xm+0, Optional:
Gui, Add, Button, xs w150 xp+17 yp+20 gLoadKS vBKS
BKS_TT := "Add a Kickstart ROM to your system, otherwise`nthe AROS Kickstart ROM will be used instead."
Gui, Add, Button, x+5 gEjectKS vEjKS,
EjKS_TT := "Remove Kickstart ROM Image"
Gui, Add, Button, w150 xs+17 yp+34 gLoadFD vBFD
BFD_TT := "Add any number of Floppy disk Images by`nhighlighting them in the selection window.`n`nIn WinUAE go to 'Disk Swapper'`nto manage the Images in the drives."
Gui, Add, Button, x+5 gEjectFD vEjFD,
EjFD_TT := "Eject Floppy Disk Image/s"
Gui, Add, Button, w150 xs+17 yp+34 gLoadHD vBHD
BHD_TT := "Add any number of Hard disk Images by`nhighlighting them in the selection window."
Gui, Add, Button, x+5 gEjectHD vEjHD,
EjHD_TT := "Eject Hard Disk Image/s"
Gui, Add, Button, w150 xs+17 yp+34 gLoadCD vBCD
BCD_TT := "Add a Compact disk Image to your`nAROS, CDTV or CD32 system."
Gui, Add, Button, x+5 gEjectCD vEjCD,
EjCD_TT := "Eject Compact Disk Image"
Gui, Add, Button, w120 xs+43 yp+40 gGenerate vBGen, Generate
BGen_TT =
Gui, Add, Checkbox, yp+27 vRun, Open with WinUAE
Run_TT := "Enable this to run your generated configuration on WinUAE.`n`nLeaving this Disabled means the file will be saved in`nthe 'configuration' folder for later use.`n`nPress 'F12' during emulation to open the WinUAE options."
OnMessage(0x0200, "WM_MOUSEMOVE")
Gui, Show, w226 h345 Center, SCG4WinUAE 1.3.5
Settimer, GUI
Return

GUI:
If (KS != "") {
	Splitpath, KS,,,, ROMN
	ROMN:= StrSplit(ROMN, "` ",, 4)
	ROMN.Delete(4)
	If (ROMN.1 ~= "i)Kick[1-3]|amiga-os-") || (KS ~= "i)Bootstrap|Kick.rom|Kick.zip|Kick.7z") {
		ROMN = Kickstart Loaded
		}
	Else If (ROMN.1 ~= "i)^Kick$") && (ROMN.2 ~= "[1-3]") {
		ROMN = Kickstart Loaded
		}
	Else If (ROMN.1 ~= "i)^Kickstart$") && (ROMN.2 ~= "[1-3]") && (ROMN.3 ~= "[0-9]") {
		ROMN := "Kickstart " . ROMN.2 . " " . ROMN.3
		}
	Else If (ROMN.1 ~= "i)^Kickstart$") && (ROMN.2 ~= "[1-3]") {
		ROMN := "Kickstart " . ROMN.2
		}
	Else {
		ROMN = Unrecognized ROM
	}
		GuiControl, Text, Button13, %ROMN%
		GuiControl, Enable, Button14
}
Else {
	GuiControl, Text, Button13, AROS Kickstart
	GuiControl, Disable, Button14
}

If (FD != "") {
	GuiControl, Text, Button15, Floppy Disk/s Added
	GuiControl, Enable, Button16
}
Else {
	GuiControl, Text, Button15, Add Floppy Disk/s
	GuiControl, Disable, Button16
}
If (HD != "") {
	GuiControl, Text, Button17, Hard Disk/s Added
	GuiControl, Enable, Button18
}
Else {
	GuiControl, Text, Button17, Add Hard Disk/s
	GuiControl, Disable, Button18
}
If (CD != "") {
	GuiControl, Text, Button19, Compact Disk Added
	GuiControl, Enable, Button20
}
Else {
	GuiControl, Text, Button19, Add Compact Disk
	GuiControl, Disable, Button20
}

GuiControlGet, Button2
GuiControlGet, Button3
GuiControlGet, Button4
GuiControlGet, Button5
GuiControlGet, Button6

If (Button4 = 1 || Button5 = 1 || Button6 = 1) {
	GuiControl, Enable, Button10
}
Else {
	GuiControl, Disable, Button10
}

If (Ext ~= "i)CDTV|CD32" && Ext != KS) || (Strlen(KS) = 0) {
	GuiControl, Enable, Button19
}
Else {
	GuiControl, Disable, Button19
	GuiControl, Disable, Button20
}

If (ConfPath = "") {
	ConfPath = %A_ScriptDir%\
}
Return

WM_MOUSEMOVE()
{
    static CurCtrl, PrvCtrl, _TT
    CurCtrl := A_GuiControl
    If (CurCtrl != PrvCtrl and not InStr(CurCtrl, " "))
    {
        ToolTip
        SetTimer, DTT, 250
        PrvCtrl := CurCtrl
    }
    Return

    DTT:
    SetTimer, DTT, Off
    ToolTip % %CurCtrl%_TT
    SetTimer, RTT, 5000
    Return

    RTT:
    SetTimer, RTT, Off
    ToolTip
    Return
}

About:
Gui, About:+owner1 -MaximizeBox -MinimizeBox
Gui, Font, s8, Verdana
Gui, +Disabled
Gui, About:Add, Picture, ym+20 Icon1, %A_ScriptFullPath%
Gui, About:Add, Link, ys ym+0, The Swift Configuration Generator for WinUAE`nis a companion program aimed to make life`neasier for the Amiga emulation scene.`n`nMore information can be found in the included`n<a href="SCG4WinUAE.txt">instructions</a> manual.`n`nWritten by Rodney Caruana (2022-23)`n`nSpecial Thanks to Toni Wilen, Bernd Schmidt,`nBrian King, Mathias Ortmann, Bernd Meyer`nand all <a href="http://www.winuae.com">WinUAE</a> contributors.
Gui, About:Show, AutoSize Center, About SCG4WinUAE
WinGetPos, PX, PY,,, SCG4WinUAE 1.3.5
Winmove, About SCG4WinUAE,, PX-(60*A_ScreenDPI/96), PY+(105*A_ScreenDPI/96)
Return

AboutGuiClose:
Gui, 1:-Disabled
Gui, Destroy
Return

Reset:
RegDelete, HKEY_CURRENT_USER\SOFTWARE\SCG4WinUAE
Reload
Return

Quit:
ExitApp
Return

1stscan:
Gui, WC:-0x800000
Gui, WC:Font, s8, Verdana
Gui, WC:Color, DDDDDD
Gui, +Disabled
Gui, WC:Add, Text, xm+35, Welcome to SCG4WinUAE`n
Gui, WC:Add, Text, xm+2,The program will make a 1st time scan`nfor the WinUAE's location and when (if)`nfound, complete it's setup.`n`nPlease be patient as this process may`ntake a couple of minutes at the most.`n
Gui, WC:Font, s8 Bold, Verdana
Gui, WC:Add, Button, w40 gScan xm+30, Proceed
Gui, WC:Add, Button, w60 gGuiClose xp+90, Ugh, No!
Gui, WC:Show, w235, Welcome
Return

Scan:
Gui, WC:Destroy
RegDelete, HKEY_CURRENT_USER\Software\SCG4WinUAE, WinUAE
Gui, Hide
DriveGet, Ptg, List, FIXED
Pth := StrSplit(Ptg)
Gui, Scan:+owner1 -0x800000
Gui, Scan:Font, Bold
Gui, +Disabled
Gui, Scan:Add, Text, w110
Gui, Scan:Show, AutoSize Center, Scanning WinUAE Location
For index, Nx in Pth {
	Sch := Pth[A_Index]
	Loop,  Files,  %Sch%:\win*.exe,  R
		{
		GuiControl, Scan:Text, static1, Scanning Folder: %A_Index%
		If (A_LoopFileName ~= "i)^winuae|^winuae64") {
			WinUAE = %A_LoopFileFullPath%
			XBRF = %A_LoopFileDir%
			FileCreateDir, %XBRF%\Plugins\Filtershaders\direct3d
			FileInstall, xBR-Level2-SmartRes.fx, %XBRF%\Plugins\Filtershaders\direct3d\xBR-Level2-SmartRes.fx, 1
			RegRead, ConfPath, HKEY_CURRENT_USER\Software\SCG4WinUAE, ConfPath
			RegRead, RelPath, HKEY_CURRENT_USER\SOFTWARE\Arabuusimiehet\WinUAE, RelativePaths
			If (ConfPath = "") {
				RegRead, ConfPath, HKEY_CURRENT_USER\SOFTWARE\Arabuusimiehet\WinUAE, ConfigurationPath
				If (Relpath = 0) {
					ConfPath := RTrim(ConfPath, "\")
					RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, ConfPath, %ConfPath%
				}
				Else {
					DCPath = %A_LoopFileDir%%ConfPath%
					DCPath := RTrim(StrReplace(DCPath, .,""), "\")
					RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, ConfPath, %DCPath%
				}
			}
			If (KSPath = "") {
				RegRead, KSPath, HKEY_CURRENT_USER\SOFTWARE\Arabuusimiehet\WinUAE, KickstartPath
				If (Relpath = 0) {
					KSPath := RTrim(KSPath, "\")
					RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, KSPath, %KSPath%
				}
				Else {
					DKPath = %A_LoopFileDir%%KSPath%
					DKPath := RTrim(StrReplace(DKPath, .,""), "\")
					RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, KSPath, %DKPath%
				}
			}
			If (DSPath = "") {
				RegRead, DSPath, HKEY_CURRENT_USER\SOFTWARE\Arabuusimiehet\WinUAE, FloppyPath
				DSPath := RTrim(DSPath, "\")
				RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, DSPath, %DSPath%
			}
			RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, WinUAE, %WinUAE%
			GuiControl, Scan:Text, static1, WinUAE was Found
			Sleep 3000
			Reload
		}
	}
}
If (Strlen(WinUAE) = 0) {
	GuiControl, Scan:Text, static1, WinUAE not Found. Exiting
	Sleep 3000
	ExitApp
}
Return

WUAERUN:
If (File = "") {
	Note = Launching WinUAE
	Gosub, Notice
}
Gui, Hide
Runwait, "%WinUAE%" "%File%", , UseErrorLevel
if (ErrorLevel = "ERROR")
	Msgbox,, Guru Meditation, WinUAE could not be launched.`n`nCheck your WinUAE installation and`nScan again from the Edit menu.
WinSet, Bottom,, %A_ScriptFullPath%
Gui, Show
Return

ScanGuiClose:
If (Strlen(WinUAE) = 0) {
ExitApp
}
Else {
Reload
}
Return

GuiClose:
RegDelete, HKEY_CURRENT_USER\Software\SCG4WinUAE, Kickstart
RegDelete, HKEY_CURRENT_USER\Software\SCG4WinUAE, Extended
ExitApp

ConfPath:
FileSelectFolder, ConfPath,, 0, Select Configurations Folder
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, ConfPath, %ConfPath%
Return

KSPath:
FileSelectFolder, KSPath,, 0, Select Kickstart ROM Images Folder
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, KSPath, %KSPath%
Return

DSPath:
FileSelectFolder, DSPath,, 0, Select Media Images Folder
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, DSPath, %DSPath%
Return

Folder:
Run, %ConfPath%
Return

LoadKS:
FileSelectFile, Kick, 3, %KSPath%, Select Kickstart ROM Image to use, ROM Image (*.rom; *.roz; *.a500; *.a600; *.a1200; *.a4000; *.zip; *.7z)
If (Errorlevel = 1) {
}
Else {
KS = %Kick%
If (KS ~= "i)CDTV|CD32") && (KS ~= "i)Ext") {
	KS =
	Gosub, Guru
}
Else If (KS ~= "i)CDTV|CD32") {
	Gosub, Askext
	}
Else {
	Ext =
	}
}

If (CDON = 1) {
GuiControl, Enable, Button19
}
Return

Guru:
Gui, Guru:+owner1 -0x800000
Gui, Guru:Font, s8, Verdana
Gui, Guru:Color, DDDDDD
Gui, +Disabled
Gui, Guru:Add, Text, xm+10, Load the main Kickstart ROM first.`n`nKickstart 1.3 34.5 For CDTV`nKickstart 3.1 40.60 For CD32`n
Gui, Guru:Font, s8 Bold, Verdana
Gui, Guru:Add, Button, xm+70 vMeh gMeh, Donkey!
Meh :=
Gui, Guru:Show, w226, Guru
WinGetPos, PX, PY,,, SCG4WinUAE 1.3.5
Winmove, Guru,, PX, PY+(220*A_ScreenDPI/96)
Return

Meh:
Gui, 1:-Disabled
Gui, Destroy
Gosub, LoadKS
Return

AskExt:
Gui, Ext:+owner1 -0x800000
Gui, Ext:Font, s8, Verdana
Gui, Ext:Color, DDDDDD
Gui, +Disabled
Gui, Ext:Add, Text, xm+10, Do you want to add a CDTV/CD32`nKickstart Extension ROM Image?`n
Gui, Ext:Font, s8 Bold, Verdana
Gui, Ext:Add, Button, w40 gYes xm+55, Yeah
Gui, Ext:Add, Button, w40 xp+50 gNo, Nope
Gui, Ext:Show, w226, Extend
WinGetPos, PX, PY,,, SCG4WinUAE 1.3.5
Winmove, Extend,, PX, PY+(220*A_ScreenDPI/96)
Return

Yes:
FileSelectFile, Ext, 3, %KSPath%, Select CDTV or CD32 Extension ROM Image to use, ROM Image (*.rom; *.roz; *.a500; *.a600; *.a1200; *.a4000; *.zip; *.7z;)
If (Ext ~= "i)CDTV|CD32") && (Ext ~= "i)Ext") {
	Ext = %Ext%
	CDON = 1
}
Gui, 1:-Disabled
Gui, Destroy
Return

No:
Ext =
Gui, 1:-Disabled
Gui, Destroy
Return

EjectKS:
KS =
Return

LoadFD:
FileSelectFile, FDisks, M3, %DSPath%, Select Floppy Disk Image to use, Floppy Image (*.adf; *.adz; *.gz; *.dms; *.ipf; *.scp; *.fdi; *.exe; *.zip; *.7z)
If (Errorlevel = 1) {
}
Else {
If (Fdisks != "") {
	Drv := []
	Loop, Parse, FDisks, `n
		{
		If (A_Index = 1) {
		DF = %A_Loopfield%
		}
		If (A_Index > 1) {
			Num := DF . "\" . A_Loopfield
			Drv.push(Num)
			If (A_Index = 2) {
				SplitPath, Num,,,, FD
				Gui, +Disabled
				Inputbox, FD, Configuration Name: Floppy Disk Section,,,, 100,,,,, %FD%
				Winactivate, SCG4WinUAE
				Gui, -Disabled
			}
		}
	}
}
Else {
	FD =
}
}
Return

EjectFD:
FD =
Return

LoadHD:
FileSelectFile, HDisks, M3, %DSPath%, Select Hard Disk Image to use, HD Image (*.hdf; *.vhd; *.rdf; *.hdz; *.rdz; *.chd; *.zip; *.7z)
If (Errorlevel = 1) {
}
Else {
If (Hdisks != "") {
	HDrv := []
	Loop, Parse, HDisks, `n
		{
		If (A_Index = 1) {
		HF = %A_Loopfield%
		}
		If (A_Index > 1) {
			Num := HF . "\" . A_Loopfield
			HDrv.push(Num)
			If (A_Index = 2) {
				SplitPath, Num,,,, HD
				Gui, +Disabled
				Inputbox, HD, Configuration Name: Hard Disk Section,,,, 100,,,,, %HD%
				Winactivate, SCG4WinUAE
				Gui, -Disabled
			}
		}
	}
}
Else {
	HD =
}
}
Return

EjectHD:
HD =
Return

LoadCD:
FileSelectFile, CDisk, 3, %DSPath%, Select Compact Disk Image to use, CD Image (*.cue; *.ccd; *.mds; *.iso; *.chd; *.nrg; *.zip; *.7z)
If (Errorlevel = 1) {
}
Else {
If (CDisk != "") {
	SplitPath, CDisk,,,, CD
	Gui, +Disabled
	Inputbox, CD, Configuration Name: Compact Disk Section,,,, 100,,,,, %CD%
	Winactivate, SCG4WinUAE
	Gui, -Disabled
}
Else {
	CD =
}
}
Return

EjectCD:
CD =
Return

NoJoy:
Menu, JoystickMenu, Check, &Disabled
Menu, JoystickMenu, Uncheck, &Standard
Menu, JoystickMenu, Uncheck, &CDTV/CD32
Menu, JoystickMenu, Uncheck, &Two Player
Ctrl = joyport1=none`n
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, JoyStick, 0
Joy = 0
Return

JoyStk:
Menu, JoystickMenu, Uncheck, &Disabled
Menu, JoystickMenu, Check, &Standard
Menu, JoystickMenu, Uncheck, &CDTV/CD32
Menu, JoystickMenu, Uncheck, &Two Player
Ctrl = joyport1=custom0`njoyportcustom0=k.0.b.29.0=JOY2_FIRE_BUTTON k.0.b.56.0=JOY2_2ND_BUTTON k.0.b.157.0=JOY2_FIRE_BUTTON k.0.b.184.0=JOY2_2ND_BUTTON k.0.b.200.0=JOY2_UP k.0.b.203.0=JOY2_LEFT k.0.b.205.0=JOY2_RIGHT k.0.b.208.0=JOY2_DOWN k.0.b.219.3=JOY2_FIRE_BUTTON`n
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, JoyStick, 1
Joy = 1
Return

JoyPad:
Menu, JoystickMenu, Uncheck, &Disabled
Menu, JoystickMenu, Uncheck, &Standard
Menu, JoystickMenu, Check, &CDTV/CD32
Menu, JoystickMenu, Uncheck, &Two Player
Ctrl = joyport1=custom0`njoyportcustom0=k.0.b.30.0=JOY2_CD32_GREEN k.0.b.31.0=JOY2_CD32_YELLOW k.0.b.44.0=JOY2_CD32_RED k.0.b.45.0=JOY2_CD32_BLUE k.0.b.200.0=JOY2_UP k.0.b.203.0=JOY2_LEFT k.0.b.205.0=JOY2_RIGHT k.0.b.208.0=JOY2_DOWN k.0.b.219.3=JOY2_CD32_RED`n
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, JoyStick, 2
Joy = 2
Return

2Play:
Menu, JoystickMenu, Uncheck, &Disabled
Menu, JoystickMenu, Uncheck, &Standard
Menu, JoystickMenu, Uncheck, &CDTV/CD32
Menu, JoystickMenu, Check, &Two Player
Ctrl = joyport0=custom0`njoyport1=custom1`njoyportcustom0=k.0.b.17.0=JOY2_UP k.0.b.29.0=JOY2_FIRE_BUTTON k.0.b.30.0=JOY2_LEFT k.0.b.31.0=JOY2_DOWN k.0.b.32.0=JOY2_RIGHT k.0.b.42.0=JOY2_2ND_BUTTON`njoyportcustom1=k.0.b.54.0=JOY1_2ND_BUTTON k.0.b.157.0=JOY1_FIRE_BUTTON k.0.b.200.0=JOY1_UP k.0.b.203.0=JOY1_LEFT k.0.b.205.0=JOY1_RIGHT k.0.b.208.0=JOY1_DOWN`n
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, JoyStick, 3
Joy = 3
Return

Legend:
Gui, About:+owner1 -MaximizeBox -MinimizeBox
Gui, Font, s8, Verdana
Gui, +Disabled
Gui, About:Add, Text,, Disabled:`nNo Joystick Attached`n`nEnabled (One Player) -`nArrow keys, WINkey (Autofire)`n`nStandard:`nLeft or Right Ctrl (Primary Fire)`nLeft or Right Alt (Secondary Fire)`n`nCDTV/CD32:`nZ (Red/Primary Fire), A (Green)`nX (Blue/Secondary Fire), S (Yellow)`n`nTwo Player:`nPlayer One - WSAD`nLeft Ctrl (Primary Fire)`nLeft Shift (Secondary Fire)`n`nPlayer Two - Arrow Keys`nRight Ctrl (Primary Fire)`nRight Shift (Secondary Fire)
Gui, About:Show, AutoSize Center, JoyKey Mapping
WinGetPos, PX, PY,,, SCG4WinUAE 1.3.5
Winmove, JoyKey Mapping,, PX+(20*A_ScreenDPI/96), PY+(50*A_ScreenDPI/96)
Return

LegendGuiClose:
Gui, 1:-Disabled
Gui, Destroy
Return

Notice:
Gui, XX:+owner1 -0x800000
Gui, XX:Font, s8 Bold, Verdana
Gui, XX:Color, DDDDDD
Gui, XX:Add, Text,, %Note%
Gui, XX:Show,, Notice
WinGetPos, PX, PY,,, SCG4WinUAE 1.3.5
Winmove, Notice,, PX+(50*A_ScreenDPI/96), PY+(220*A_ScreenDPI/96)
Sleep, 500
Gui, XX:-Disabled
Gui, XX:Destroy
Return

Generate:
Gui, Submit, NoHide

If (OCS00 = 1) {
	CPU = OCS00
	Model = A500
	If (KS ~= "i)Bootstrap") {
	Model = A1000
	}
	CS = OCS
}
If (ECS10 = 1) {
	CPU = ECS10
	Model = A500+
	If (KS ~= "i)1\.3|13") {
		Model = A500
	}
	If (KS ~= "i)2\.05|205") {
		Model = A600
	}
	CS = ECS
}
If (AGA20 = 1) {
	CPU = AGA20
	Model = A1200
	CS = AGA
}
If (ECS30 = 1) {
	CPU = ECS30
	Model = A3000
	CS = ECS
}
If (AGA40 = 1) {
	CPU = AGA40
	Model = A4000
	CS = AGA
}
If (KS = "") {
Model = Generic
}
If (KS ~= "i)CDTV" && (Ext ~= "i)CDTV" && Ext != KS)) {
	Model = CDTV
}
If (KS ~= "i)CD32" && (Ext ~= "i)CD32" && Ext != KS)) {
	Model = CD32
}

If (OCS00 = 1 || ECS10 = 1) {
	If (Win = 1) {
		File = %CPU% (W
	}
	If (Full = 1) {
		File = %CPU% (F
	}
}
If (AGA20 = 1 || ECS30 = 1 || AGA40 = 1) {
	If (Win = 1 && JIT = 1) {
		File = %CPU% JIT (W
	}
	If (Full = 1 && JIT = 1) {
		File = %CPU% JIT (F
	}
	If (Win = 1 && JIT = 0) {
		File = %CPU% (W
	}
	If (Full = 1 && JIT = 0) {
		File = %CPU% (F
	}
}
If (2X = 1) {
	File = %File% · XBR)
}
If (2X = 0) {
	File = %File%)
}
If (Joy = 3) {
	File = %File% · 2 Player
}
If (Drv.1 != "" && Strlen(FD) > 0) {
	File = %FD% · %File%
}
If (CDisk != "" && Strlen(CD) > 0) {
	File = %CD% · %File%
}
If (HDrv.1 != "" && Strlen(HD) > 0) {
	File = %HD% · %File%
}
File = %ConfPath%\%File%
File = %File%.uae

RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, CPU, %CPU%
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, Model, %Model%
FileDelete, %File%

FileAppend, -- File Generated using SCG4WinUAE --`n`n%Ctrl%input.autoswitch=0`n`ngfx_filter_autoscale=scale`ngfx_filter_keep_autoscale_aspect=1`ngfx_flickerfixer=true`ngfx_filter_aspect_ratio=-1:-1`n, %File%

If (Win = 1) {
	RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, Mode, Win
	FileAppend, win32.borderless=true`ngfx_width=%Width%`ngfx_height=%Areabottom%`ngfx_top_windowed=%Offset%`n`n, %File%
}
	If (Full = 1) {
	RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, Mode, Full
	FileAppend, gfx_fullscreen_amiga=fullwindow`ngfx_width_fullscreen=native`ngfx_height_fullscreen=native`n`n, %File%
}

If (2X = 1) {
	RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, 2X, 1
	FileAppend, gfx_filter=D3D:xBR-Level2-SmartRes.fx`ngfx_filter_bilinear=true`n`n, %File%
}
Else {
	RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, 2X, 0
}

FileAppend, chipset=%CS%`nchipset_compatible=%Model%`n`n, %File%

If (OCS00 = 1 || ECS10 = 1) {
	If (ECS10 = 1) {
		FileAppend, cpu_model=68010`n`nchipmem_size=2`n, %File%
	}
	FileAppend, bogomem_size=0`nfastmem_size_k=512`n`ncpu_multiplier=4`n`n, %File%
}

If (AGA20 = 1 || ECS30 = 1 || AGA40 = 1) {
	If (AGA20 = 1) {
		FileAppend, cpu_model=68020`nfpu_model=68882`n`nchipmem_size=4`n, %File%
		If (JIT = 1 && Model != "CD32") {
			FileAppend, z3mem_size=4`n, %File%
			}
		Else {
			FileAppend, fastmem_size=4`n, %File%
			}
		}
	If (ECS30 = 1 || AGA40 = 1) {
		If (ECS30 = 1) {
			FileAppend, cpu_model=68030`nfpu_model=68882`n`nchipmem_size=4`n, %File%
			If (Model != "CD32") {
				FileAppend, fastmem_size=2`nz3mem_size=2`n, %File%
				}
			}
		If (AGA40 = 1) {
			FileAppend,cpu_model=68040`nfpu_model=68040`n`nchipmem_size=4`n, %File%
			If (Model != "CD32") {
				FileAppend, z3mem_size=4`n, %File%
				}
			}
			If (Model = "CD32") {
				FileAppend, fastmem_size=4`n, %File%
				}
		}

	FileAppend, bogomem_size=0`nfpu_strict=true`nwaiting_blits=automatic`n`n, %File%

	If (JIT = 0) {
		RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, JIT, 0
		FileAppend, cpu_multiplier=8`n`n, %File%
		If (ECS30 = 1) {
			FileAppend, mmu_model=68030`n, %File%
			}
		If (AGA40 = 1) {
			FileAppend, mmu_model=68040`n, %File%
			}
		If (AGA20 != 1) {
			FileAppend, cpu_data_cache=true`ncpu_24bit_addressing=false`nuaeboard=full+indirect`n`n, %File%
			}
		}
	If (JIT = 1) {
			RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\SCG4WinUAE, JIT, 1
			FileAppend, cpu_speed=max`ncycle_exact=false`ncpu_24bit_addressing=false`ncachesize=16384`n`n, %File%
		}
}

If (KS != "") {
	FileAppend, kickstart_rom_file=%KS%`n, %File%
	If (Ext != "" && Ext != KS) {
		If (Ext ~= "i)CDTV|CD32") {
			FileAppend, kickstart_ext_rom_file=%Ext%`n, %File%
		}
	}
	FileAppend, `n, %File%
}

If (KS = "") {
	FileAppend, kickstart_rom_file=:AROS`n`n, %File%
}

If (Drv.1 != "" && Strlen(FD) > 0) {
	Num := 0
	for index, SW in Drv {
			flvl = diskimage%Num%=%SW%`nfloppy%Num%=%SW%
			If (A_Index < 3) {
				FileAppend, %flvl%`n, %File%
			}
			If (A_Index >= 3 && A_Index < 5) {
				FileAppend, %flvl%`nfloppy%Num%type=0`nfloppy%Num%sound=1`nfloppy%Num%soundvolume_empty=100`n, %File%
			}
			If (A_Index >= 5 && A_Index <= 20) {
				FileAppend, diskimage%Num%=%SW%`n, %File%
		}
	Num += 1
	}
}

FileAppend, floppy_volume=95`nfloppy_speed=800`nfloppy0sound=1`nfloppy0soundvolume_empty=100`n, %File%

If (Drv.2 = "" && HDrv.1 = "") {
	FileAppend, floppy1type=-1`n`n, %File%
}
Else {
	FileAppend, floppy1sound=1`nfloppy1soundvolume_empty=100`n`n, %File%
}

If (HDrv.1 != "" && Strlen(HD) > 0) {
	HNum := 0
	for index, HW in HDrv {
		If (A_Index < 30) {
			FileAppend, hardfile2=rw`,DH%HNum%:%HW%`,32`,1`,2`,512`,0`,`,uae%HNum%`n, %File%
			HNum += 1
		}
	}
FileAppend, `n, %File%
}


If (Model ~= "i)CDTV|CD32") || (KS = "") {
	If (CDisk != "" && Strlen(CD) > 0) {
		FileAppend, cdimage0=%CDisk%`n, %File%
	}
	FileAppend, cd_speed=0`n`n, %File%
}

If (Run = 1) {
	Note = Launching WinUAE
	Gosub, Notice
	Gosub, WUAERUN
}
Else {
	Note = -  Generating  -
	Gosub, Notice
}

File =
Return
