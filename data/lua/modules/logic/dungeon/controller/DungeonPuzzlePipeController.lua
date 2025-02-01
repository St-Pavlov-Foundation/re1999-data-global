module("modules.logic.dungeon.controller.DungeonPuzzlePipeController", package.seeall)

slot0 = class("DungeonPuzzlePipeController", BaseController)

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

slot1 = DungeonPuzzleEnum.dir.left
slot2 = DungeonPuzzleEnum.dir.right
slot3 = DungeonPuzzleEnum.dir.down
slot4 = DungeonPuzzleEnum.dir.up

function slot0.release(slot0)
	slot0._rule = nil
end

function slot0.checkInit(slot0)
	slot0._rule = slot0._rule or DungeonPuzzlePipeRule.New()
	slot1, slot2 = DungeonPuzzlePipeModel.instance:getGameSize()

	slot0._rule:setGameSize(slot1, slot2)
end

function slot0.openGame(slot0, slot1)
	DungeonPuzzlePipeModel.instance:initByElementCo(slot1)
	slot0:checkInit()
	slot0:randomPuzzle()
	ViewMgr.instance:openView(ViewName.DungeonPuzzlePipeView)
end

function slot0.resetGame(slot0)
	DungeonPuzzlePipeModel.instance:initByElementCo(DungeonPuzzlePipeModel.instance:getElementCo())
	slot0:randomPuzzle()
end

function slot0.changeDirection(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0:refreshConnection(slot0._rule:changeDirection(slot1, slot2))
	end
end

function slot0.randomPuzzle(slot0)
	slot1 = slot0._rule:getRandomSkipSet()
	slot2, slot3 = DungeonPuzzlePipeModel.instance:getGameSize()

	for slot7 = 1, slot2 do
		for slot11 = 1, slot3 do
			if not slot1[DungeonPuzzlePipeModel.instance:getData(slot7, slot11)] then
				for slot17 = 1, math.random(0, 3) do
					slot0._rule:changeDirection(slot7, slot11)
				end
			end
		end
	end

	slot0:refreshAllConnection()
	slot0:updateConnection()
end

function slot0.refreshAllConnection(slot0)
	slot1, slot2 = DungeonPuzzlePipeModel.instance:getGameSize()

	for slot6 = 1, slot1 do
		for slot10 = 1, slot2 do
			slot0:refreshConnection(DungeonPuzzlePipeModel.instance:getData(slot6, slot10))
		end
	end
end

function slot0.refreshConnection(slot0, slot1)
	slot2 = slot1.x
	slot3 = slot1.y

	slot0._rule:setSingleConnection(slot2 - 1, slot3, uv0, uv1, slot1)
	slot0._rule:setSingleConnection(slot2 + 1, slot3, uv1, uv0, slot1)
	slot0._rule:setSingleConnection(slot2, slot3 + 1, uv2, uv3, slot1)
	slot0._rule:setSingleConnection(slot2, slot3 - 1, uv3, uv2, slot1)
end

function slot0.updateConnection(slot0)
	DungeonPuzzlePipeModel.instance:resetEntryConnect()

	slot1, slot2 = slot0._rule:getReachTable()

	slot0._rule:_mergeReachDir(slot1)
	slot0._rule:_unmarkBranch()
	DungeonPuzzlePipeModel.instance:setGameClear(slot0._rule:isGameClear(slot2))
end

function slot0.checkDispatchClear(slot0)
	if DungeonPuzzlePipeModel.instance:getGameClear() then
		slot0:dispatchEvent(DungeonPuzzleEvent.PipeGameClear)
	end
end

function slot0.getIsEntryClear(slot0, slot1)
	return slot0._rule:getIsEntryClear(slot1)
end

slot0.instance = slot0.New()

return slot0
