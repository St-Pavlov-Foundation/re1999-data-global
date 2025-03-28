module("modules.logic.versionactivity1_6.getian.controller.ActGeTianController", package.seeall)

slot0 = class("ActGeTianController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, slot0.OnUpdateDungeonInfo, slot0)
end

function slot0.OnUpdateDungeonInfo(slot0, slot1)
	if slot1 then
		ActGeTianModel.instance:checkFinishLevel(slot1.episodeId, slot1.star)
	end
end

function slot0.delayReward(slot0, slot1, slot2)
	if slot0._actTaskMO == nil and slot2 then
		slot0._actTaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._actTaskMO = nil

	if slot0._actTaskMO and (slot1.id == ActGeTianEnum.TaskMOAllFinishId or slot1:alreadyGotReward()) then
		ActGeTianTaskListModel.instance:preFinish(slot1)

		slot0._actTaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, ActGeTianEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._actTaskId = nil

	if slot0._actTaskId then
		if slot1 == ActGeTianEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, , , , ActGeTianEnum.ActivityId)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

function slot0.oneClaimReward(slot0, slot1)
	for slot6, slot7 in pairs(ActGeTianTaskListModel.instance:getList()) do
		if slot7:alreadyGotReward() and slot7.id ~= ActGeTianEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(slot7.id)
		end
	end
end

function slot0.enterActivity(slot0)
	if ActivityConfig.instance:getActivityCo(ActGeTianEnum.ActivityId).storyId > 0 and not StoryModel.instance:isStoryFinished(slot2) then
		StoryController.instance:playStory(slot2, nil, slot0.storyCallback, slot0)
		ActGeTianModel.instance:setFirstEnter()
	else
		slot0:_drirectOpenLevelView()
	end
end

function slot0.storyCallback(slot0)
	slot0:_drirectOpenLevelView()
end

function slot0.openLevelView(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.ActGeTianLevelView) then
		if slot1 ~= nil then
			slot0:dispatchEvent(ActGeTianEvent.TabSwitch, slot1.needShowFight)
		end
	else
		slot0:_drirectOpenLevelView(slot1)
	end
end

function slot0._drirectOpenLevelView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ActGeTianLevelView, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_open)
end

slot0.instance = slot0.New()

return slot0
