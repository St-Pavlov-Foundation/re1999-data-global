module("modules.logic.versionactivity2_2.common.EnterActivityViewOnExitFightSceneHelper2_2", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.activate()
end

function slot0.enterActivity12210(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight12210, slot0, slot1)
end

function slot0.enterActivity12203(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_2EnterView)
		VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_2Enum.ActivityId.TianShiNaNa, true)
	end)
end

function slot1()
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot0) then
		return false
	end

	if not Season166Model.instance:getBattleContext() then
		return false
	end

	return true, slot0, slot1, slot2
end

function slot0._enterActivityDungeonAterFight12210(slot0, slot1)
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

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		Season166Controller.instance:openSeasonView({
			actId = uv0,
			jumpId = uv1,
			jumpParam = uv2
		})
	end, nil, VersionActivity2_2Enum.ActivityId.Season)
end

function slot0.enterActivity12204(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_2EnterView)

		slot0 = nil

		if DungeonModel.instance.lastSendEpisodeId == Activity168Model.instance:getCurBattleEpisodeId() then
			function slot0()
				LoperaController.instance:openLoperaMainView()
			end
		end

		VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(slot0, nil, VersionActivity2_2Enum.ActivityId.Lopera)
	end)
end

function slot0.enterActivity12209(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = uv0,
				layer = uv1
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return slot0
