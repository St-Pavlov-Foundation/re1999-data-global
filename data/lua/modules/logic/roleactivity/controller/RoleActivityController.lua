module("modules.logic.roleactivity.controller.RoleActivityController", package.seeall)

slot0 = class("RoleActivityController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.OnUpdateDungeonInfo, slot0)
end

function slot0.OnUpdateDungeonInfo(slot0, slot1)
	if slot1 then
		RoleActivityModel.instance:checkFinishLevel(slot1.episodeId, slot1.star)
	end
end

function slot0.enterActivity(slot0, slot1)
	if ActivityConfig.instance:getActivityCo(slot1).storyId > 0 and not StoryModel.instance:isStoryFinished(slot3) then
		StoryController.instance:playStory(slot3, nil, slot0._drirectOpenLevelView, slot0, {
			_actId = slot1
		})
	else
		slot0:_drirectOpenLevelView({
			_actId = slot1
		})
	end
end

function slot0.openLevelView(slot0, slot1)
	if ViewMgr.instance:isOpen(RoleActivityEnum.LevelView[slot1.actId]) then
		return
	end

	ViewMgr.instance:openView(slot2, slot1)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function slot0._drirectOpenLevelView(slot0, slot1)
	ViewMgr.instance:openView(RoleActivityEnum.LevelView[slot1._actId])
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function slot0.delayReward(slot0, slot1, slot2)
	slot0.actId = RoleActivityTaskListModel.instance:getActivityId()

	if slot0._actTaskMO == nil and slot2 and slot0.actId then
		slot0._actTaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._actTaskMO = nil

	if slot0._actTaskMO and (slot1.id == 0 or slot1.hasFinished) then
		RoleActivityTaskListModel.instance:preFinish(slot1)

		slot0._actTaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, RoleActivityEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._actTaskId = nil

	if slot0._actTaskId then
		if slot1 == 0 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, , , , slot0.actId)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end

	slot0.actId = nil
end

slot0.instance = slot0.New()

return slot0
