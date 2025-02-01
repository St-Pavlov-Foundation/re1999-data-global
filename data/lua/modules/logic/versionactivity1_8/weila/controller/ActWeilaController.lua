module("modules.logic.versionactivity1_8.weila.controller.ActWeilaController", package.seeall)

slot0 = class("ActWeilaController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.OnUpdateDungeonInfo, slot0)
end

function slot0.OnUpdateDungeonInfo(slot0, slot1)
	if slot1 then
		ActWeilaModel.instance:checkFinishLevel(slot1.episodeId, slot1.star)
	end
end

function slot0.enterActivity(slot0)
	if ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila).storyId > 0 and not StoryModel.instance:isStoryFinished(slot2) then
		StoryController.instance:playStory(slot2, nil, slot0._drirectOpenLevelView, slot0)
	else
		slot0:_drirectOpenLevelView()
	end
end

function slot0.openLevelView(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.ActWeilaLevelView) then
		if slot1 ~= nil then
			slot0:dispatchEvent(ActWeilaEvent.TabSwitch, slot1.needShowFight)
		end
	else
		slot0:_drirectOpenLevelView(slot1)
	end
end

function slot0._drirectOpenLevelView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ActWeilaLevelView, slot1)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
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

	if slot0._actTaskMO and (slot1.id == 0 or slot1.hasFinished) then
		ActWeilaTaskListModel.instance:preFinish(slot1)

		slot0._actTaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, ActWeilaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._actTaskId = nil

	if slot0._actTaskId then
		if slot1 == 0 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, , , , VersionActivity1_8Enum.ActivityId.Weila)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

slot0.instance = slot0.New()

return slot0
