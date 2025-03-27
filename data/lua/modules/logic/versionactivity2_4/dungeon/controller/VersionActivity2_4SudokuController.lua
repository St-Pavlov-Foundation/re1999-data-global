module("modules.logic.versionactivity2_4.dungeon.controller.VersionActivity2_4SudokuController", package.seeall)

slot0 = class("VersionActivity2_4SudokuController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openSudokuView(slot0)
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	VersionActivity2_4SudokuModel.instance:selectKeyboardItem(nil)
	VersionActivity2_4SudokuModel.instance:clearCmd()
	ViewMgr.instance:openView(ViewName.VersionActivity2_4SudokuView)
	slot0:initStatData()
end

function slot0.excuteNewCmd(slot0, slot1)
	VersionActivity2_4SudokuModel.instance:pushCmd(slot1)
	slot0:dispatchEvent(VersionActivity2_4DungeonEvent.DoSudokuCmd, slot1)
end

function slot0.excuteLastCmd(slot0)
	if VersionActivity2_4SudokuModel.instance:popCmd() then
		slot1:undo()
		slot0:dispatchEvent(VersionActivity2_4DungeonEvent.DoSudokuCmd, slot1)
		slot0:addUndoCount()
	else
		slot0:resetGame()
	end
end

function slot0.resetGame(slot0)
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	VersionActivity2_4SudokuModel.instance:selectKeyboardItem(nil)
	slot0:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuReset)
	slot0:setStatResult("reset")
	slot0:sendStat()
	slot0:initStatData()
end

function slot0.initStatData(slot0)
	slot0._statMo = VersionActivity2_4SudokuMo.New()
end

function slot0.setStatResult(slot0, slot1)
	slot0._statMo:setResult(slot1)
end

function slot0.addUndoCount(slot0)
	slot0._statMo:addUndoCount()
end

function slot0.addErrorCount(slot0)
	slot0._statMo:addErrorCount()
end

function slot0.sendStat(slot0)
	slot0._statMo:sendStatData()
end

slot0.instance = slot0.New()

return slot0
