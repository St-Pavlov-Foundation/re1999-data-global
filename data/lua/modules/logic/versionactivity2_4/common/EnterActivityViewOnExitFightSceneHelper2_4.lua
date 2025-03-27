module("modules.logic.versionactivity2_4.common.EnterActivityViewOnExitFightSceneHelper2_4", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.activate()
end

function slot0.enterActivity12404(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4EnterView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_4Enum.ActivityId.Pinball, true)
	end)
end

function slot0.enterActivity12405(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4EnterView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_4Enum.ActivityId.MusicGame, true)
	end)
end

function slot0.enterActivity12400(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight12400, slot0, slot1)
end

function slot0._enterActivityDungeonAterFight12400(slot0, slot1)
	slot3 = slot1.exitFightGroup

	if not slot1.episodeId then
		return
	end

	if not Season166Model.instance:getBattleContext() then
		return false
	end

	slot5 = slot4.trainId
	slot7 = slot4.actId
	slot8 = uv0.recordMO and uv0.recordMO.fightResult
	slot11, slot12 = nil

	if slot9 then
		if not slot8 or slot8 == -1 or slot8 == 0 then
			if (DungeonConfig.instance:getEpisodeCO(slot2) and slot9.type) == DungeonEnum.EpisodeType.Season166Base then
				slot11 = Season166Enum.JumpId.BaseSpotEpisode
				slot12 = {
					baseId = slot4.baseId
				}
			elseif slot10 == DungeonEnum.EpisodeType.Season166Train then
				slot11 = Season166Enum.JumpId.TrainEpisode
				slot12 = {
					trainId = slot5
				}
			elseif slot10 == DungeonEnum.EpisodeType.Season166Teach then
				slot11 = Season166Enum.JumpId.TeachView
			end
		elseif slot8 == 1 then
			if slot10 == DungeonEnum.EpisodeType.Season166Base then
				slot11 = Season166Enum.JumpId.MainView
			elseif slot10 == DungeonEnum.EpisodeType.Season166Train then
				slot11 = Season166Enum.JumpId.TrainView
			elseif slot10 == DungeonEnum.EpisodeType.Season166Teach then
				slot11 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", slot2))
	end

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		Season166Controller.instance:openSeasonView({
			actId = uv0,
			jumpId = uv1,
			jumpParam = uv2
		})
	end, nil, VersionActivity2_4Enum.ActivityId.Season)
end

function slot0.enterActivity12402(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivity12402, slot0, slot1)
end

function slot0._enterActivity12402(slot0, slot1)
	slot2 = slot1.episodeId

	if not slot1.episodeCo then
		return
	end

	if uv0.sequence then
		uv0.sequence:destroy()

		uv0.sequence = nil
	end

	slot4 = false

	if DungeonModel.instance.curSendEpisodePass then
		slot4 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4DungeonMapView)
	else
		slot4 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4DungeonMapLevelView)
	end

	slot5 = FlowSequence.New()

	slot5:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_4EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_4EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_4EnterView
	}))
	slot5:registerDoneListener(function ()
		if uv0 then
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					episodeId = uv0
				})
			end, nil)
		else
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		end
	end)
	slot5:start()

	uv0.sequence = slot5
end

function slot0.enterActivity12410(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = uv0,
				layer = uv1
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return slot0
