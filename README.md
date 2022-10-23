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
Replace the **aview.pth** file in your aview (**$top_dir**/aview/aview.pth) directory with [aview.pth](aview.pth) from this repo.

### Step 3
Create custom elements (macros, dialog boxes, menus, etc.) and add to your local **aview_mods_gen** directory.

### Step 4
Update the **aviewBS.cmd** script to load your customizations. This **aviewBS.cmd** script  will run **b**efore **s**tartup (BS) of every Adams View session. 

> Note: Other **aviewBS.cmd** scripts which may normally run during startup (e.g. **$HOME/aviewBS.cmd**) will not run unless you explicitly run them from this new **aviewBS.cmd** script.