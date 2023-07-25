# General Adams View Modifications

## Installation

### Step 1
Clone this repo and place it adjacent to your adams installation directory(s). For example:
```
📂Adams
└──📂2021_1_801488
|      📂acar
|      📂adamssdk
|      ...
|      📂win64
└──📂aview_mods_gen   <--- **Place repo here**
|      📜aviewBS.cmd
|      ...
|      📜menu.mnu
```
### Step 2
Replace the **aview.pth** file in your aview (**$top_dir**/aview/) directory with [aview.pth](aview.pth) from this repo.

### Step 3
Delete the **aviewAS.cmd** file in your aview (**$top_dir**/aview/) directory.

### Step 4
Create custom elements (macros, dialog boxes, menus, etc.) and add to your local **aview_mods_gen** directory.

### Step 5
Update the **aviewBS.cmd** script to load your customizations. This **aviewBS.cmd** script  will run **B**efore **S**tartup (BS) of every Adams View session. 

> Note: Other **aviewBS.cmd** scripts which may normally run during startup (e.g. **$HOME/aviewBS.cmd**) will not run unless you explicitly run them from this new **aviewBS.cmd** script.

## Adding windows context menu options for opening Adams
### Step 1
Set a **ADAMS_LAUNCH_COMMAND** environment variable equal to the path to your **mdi.bat** script (e.g. **C:\Program Files\Adams\2021_1_801488\common\mdi.bat**).

### Step 2
Run [add_windows_context_menus.bat](add_windows_context_menus.bat) as an administrator.
> Note: This will modify the windows registry. You may want to backup your current registry values.
