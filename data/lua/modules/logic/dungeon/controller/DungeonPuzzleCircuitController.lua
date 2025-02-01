module("modules.logic.dungeon.controller.DungeonPuzzleCircuitController", package.seeall)

slot0 = class("DungeonPuzzleCircuitController", BaseController)

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openGame(slot0, slot1)
	DungeonPuzzleCircuitModel.instance:initByElementCo(slot1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleCircuitView)
end

slot0.instance = slot0.New()

return slot0
