module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.DungeonMapInteractive1_3ItemComp", package.seeall)

slot0 = class("DungeonMapInteractive1_3ItemComp", DungeonMapInteractiveItem)

function slot0._editableInitView(slot0)
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "rotate/bg/#txt_info")

	uv0.super._editableInitView(slot0)
end

function slot0._loadBgImage(slot0)
	slot0._simagebgimage:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeoninteractive_panelbg.png")
end

return slot0
