module("modules.logic.versionactivity1_4.act130.controller.Activity130Controller", package.seeall)

slot0 = class("Activity130Controller", BaseController)

function slot0.openActivity130GameView(slot0, slot1)
	if slot1 and slot1.episodeId then
		if not Activity130Model.instance:isEpisodeUnlock(slot1.episodeId) then
			GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

			return
		else
			Activity130Model.instance:setCurEpisodeId(slot1.episodeId)
		end
	end

	uv0.instance:dispatchEvent(Activity130Event.ShowLevelScene, false)
	ViewMgr.instance:openView(ViewName.Activity130GameView, slot1, true)
end

function slot0.openPuzzleView(slot0, slot1)
	Role37PuzzleModel.instance:setErrorCnt(0)
	ViewMgr.instance:openView(ViewName.Role37PuzzleView, slot1)
end

function slot0.enterActivity130(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act130OpenTips) or PlayerPrefsHelper.getNumber(PlayerPrefsKey.Version1_4_Act130Tips .. "#" .. tostring(VersionActivity1_4Enum.ActivityId.Role37) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), 0) == 1 then
		slot0:_getActInfoBeforeEnter()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function ()
		PlayerPrefsHelper.setNumber(uv0, 1)
		uv1:_getActInfoBeforeEnter()
	end, nil, , , , , DungeonController.getEpisodeName(DungeonConfig.instance:getEpisodeCO(OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act130OpenTips).episodeId)))
end

function slot0._getActInfoBeforeEnter(slot0)
	Activity130Rpc.instance:sendGet130InfosRequest(VersionActivity1_4Enum.ActivityId.Role37, slot0.openActivity130LevelView, slot0)
end

function slot0.openActivity130LevelView(slot0)
	if ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId > 0 and not StoryModel.instance:isStoryFinished(slot1) then
		StoryController.instance:playStory(slot1, nil, function ()
			Activity130Model.instance:setNewFinishEpisode(0)
			Activity130Model.instance:setNewUnlockEpisode(1)
			uv0:_realOpenLevelView({
				episodeId = 0
			})
		end, nil)

		return
	end

	slot0:_realOpenLevelView()
end

function slot0._realOpenLevelView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity130LevelView, slot1)
end

function slot0.openActivity130DialogView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity130DialogView, slot1)
end

function slot0.openActivity130CollectView(slot0)
	ViewMgr.instance:openView(ViewName.Activity130CollectView)
end

function slot0.openActivity130TaskView(slot0)
	ViewMgr.instance:openView(ViewName.Activity130TaskView)
end

function slot0.delayReward(slot0, slot1, slot2)
	if slot0._act130TaskMO == nil and slot2 then
		slot0._act130TaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._act130TaskMO = nil

	if slot0._act130TaskMO and (slot1.id == Activity130Enum.TaskMOAllFinishId or slot1:alreadyGotReward()) then
		Activity130TaskListModel.instance:preFinish(slot1)

		slot0._act130TaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, Activity130Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._act130TaskId = nil

	if slot0._act130TaskId then
		if slot1 == Activity130Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity130)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

function slot0.oneClaimReward(slot0, slot1)
	for slot6, slot7 in pairs(Activity130TaskListModel.instance:getList()) do
		if slot7:alreadyGotReward() and slot7.id ~= Activity130Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(slot7.id)
		end
	end
end

slot0.instance = slot0.New()

return slot0
