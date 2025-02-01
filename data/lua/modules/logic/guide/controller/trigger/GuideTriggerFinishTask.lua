module("modules.logic.guide.controller.trigger.GuideTriggerFinishTask", package.seeall)

slot0 = class("GuideTriggerFinishTask", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, slot0._checkStartGuide, slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0._checkStartGuide, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._checkStartGuide, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return TaskModel.instance:getTaskById(tonumber(slot2)) and slot4.config.maxFinishCount <= slot4.finishCount
end

function slot0._onMainScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:checkStartGuide()
	end
end

function slot0._checkStartGuide(slot0)
	slot0:checkStartGuide()
end

return slot0
