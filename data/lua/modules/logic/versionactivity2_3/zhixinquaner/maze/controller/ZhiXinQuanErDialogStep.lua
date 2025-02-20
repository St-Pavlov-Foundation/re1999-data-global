module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErDialogStep", package.seeall)

slot0 = class("ZhiXinQuanErDialogStep", BaseWork)

function slot0.initData(slot0, slot1)
	slot0._data = slot1
	slot0._dialogueId = tonumber(slot1.param)
end

function slot0.onStart(slot0, slot1)
	if slot0._data.param == 0 then
		return slot0:onDone(true)
	end

	slot0:beginPlayDialog()
end

function slot0.beginPlayDialog(slot0)
	if not Activity176Config.instance:getBubbleCo(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, slot0._dialogueId) then
		logError("纸信圈儿对话配置不存在" .. slot0._dialogueId)
		slot0:onDone(true)

		return
	end

	PuzzleMazeDrawController.instance:registerCallback(PuzzleEvent.OnFinishDialog, slot0._onFinishDialog, slot0)

	slot2, slot3 = slot0:_getDialogPos()

	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnStartDialog, {
		co = slot1,
		dialogPosX = slot2,
		dialogPosY = slot3
	})
end

function slot0._getDialogPos(slot0)
	slot1, slot2 = PuzzleMazeDrawController.instance:getLastPos()
	slot3, slot4 = PuzzleMazeDrawModel.instance:getObjectAnchor(slot1, slot2)

	return slot3, slot4 + 100
end

function slot0._onFinishDialog(slot0)
	PuzzleMazeDrawController.instance:unregisterAllCallback(PuzzleEvent.OnFinishDialog, slot0._onFinishDialog, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	PuzzleMazeDrawController.instance:unregisterCallback(PuzzleEvent.OnFinishDialog, slot0._onFinishDialog, slot0)
end

return slot0
