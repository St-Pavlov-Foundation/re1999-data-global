module("modules.logic.dungeon.controller.DungeonPuzzleChangeColorController", package.seeall)

slot0 = class("DungeonPuzzleChangeColorController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterDecryptChangeColor(slot0, slot1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleChangeColorView, slot1)
end

function slot0.openDecryptTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.DecryptPropTipView, slot1)
end

slot0.instance = slot0.New()

return slot0
