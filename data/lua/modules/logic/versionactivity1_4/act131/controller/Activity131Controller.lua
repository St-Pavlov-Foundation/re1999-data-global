module("modules.logic.versionactivity1_4.act131.controller.Activity131Controller", package.seeall)

slot0 = class("Activity131Controller", BaseController)

function slot0.openActivity131GameView(slot0, slot1)
	if slot1 and slot1.episodeId then
		if not Activity131Model.instance:isEpisodeUnlock(slot1.episodeId) then
			GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

			return
		else
			Activity131Model.instance:setCurEpisodeId(slot1.episodeId)
		end
	end

	uv0.instance:dispatchEvent(Activity131Event.ShowLevelScene, false)
	ViewMgr.instance:openView(ViewName.Activity131GameView, slot1)
end

function slot0.enterActivity131(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act131OpenTips) or PlayerPrefsHelper.getNumber(PlayerPrefsKey.Version1_4_Act131Tips .. "#" .. tostring(VersionActivity1_4Enum.ActivityId.Role6) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), 0) == 1 then
		slot0:_getActInfoBeforeEnter()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function ()
		PlayerPrefsHelper.setNumber(uv0, 1)
		uv1:_getActInfoBeforeEnter()
	end, nil, , , , , DungeonController.getEpisodeName(DungeonConfig.instance:getEpisodeCO(OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act131OpenTips).episodeId)))
end

function slot0._getActInfoBeforeEnter(slot0)
	Activity131Rpc.instance:sendGet131InfosRequest(VersionActivity1_4Enum.ActivityId.Role6, slot0._onReceiveInfo, slot0)
end

function slot0._onReceiveInfo(slot0, slot1, slot2, slot3)
	slot0:openActivity131LevelView()
end

function slot0.openActivity131LevelView(slot0, slot1)
	if ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role6).storyId > 0 and not StoryModel.instance:isStoryFinished(slot2) then
		StoryController.instance:playStory(slot2, nil, function ()
			uv0:_realOpenLevelView(uv1)
		end, nil)

		return
	end

	slot0:_realOpenLevelView(slot1)
end

function slot0._realOpenLevelView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity131LevelView, slot1)
end

function slot0.openActivity131DialogView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity131DialogView, slot1)
end

function slot0.openActivity131TaskView(slot0)
	ViewMgr.instance:openView(ViewName.Activity131TaskView)
end

function slot0.delayReward(slot0, slot1, slot2)
	if slot0._act131TaskMO == nil and slot2 then
		slot0._act131TaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._act131TaskMO = nil

	if slot0._act131TaskMO and (slot1.id == Activity131Enum.TaskMOAllFinishId or slot1:alreadyGotReward()) then
		Activity131TaskListModel.instance:preFinish(slot1)

		slot0._act131TaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, Activity131Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._act131TaskId = nil

	if slot0._act131TaskId then
		if slot1 == Activity131Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity131)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

function slot0.oneClaimReward(slot0, slot1)
	for slot6, slot7 in pairs(Activity131TaskListModel.instance:getList()) do
		if slot7:alreadyGotReward() and slot7.id ~= Activity131Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(slot7.id)
		end
	end
end

function slot0.enterFight(slot0, slot1)
	slot3 = slot1.id
	slot4 = slot1.battleId

	if slot1.chapterId and slot3 and slot4 then
		DungeonFightController.instance:enterFightByBattleId(slot2, slot3, slot4)
	else
		logError("副本关卡表配置错误,%s的chapterId或battleId为空", slot3)
	end
end

function slot0.openLogView(slot0)
	ViewMgr.instance:openView(ViewName.Activity131LogView)
end

slot0.instance = slot0.New()

return slot0
