module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.DungeonMapInteractive1_3ItemComp", package.seeall)

local var_0_0 = class("DungeonMapInteractive1_3ItemComp", DungeonMapInteractiveItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/bg/#txt_info")

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0._loadBgImage(arg_2_0)
	arg_2_0._simagebgimage:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeoninteractive_panelbg.png")
end

return var_0_0
