module("modules.logic.versionactivity.common.EnterActivityViewOnExitFightSceneHelper1_1", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.enterActivity11104(slot0, slot1)
	slot2 = DungeonModel.instance.curSendChapterId
	slot3 = DungeonModel.instance.curSendEpisodeId

	if not slot1 and FightController.instance:isReplayMode(slot3) then
		if FightSuccView.checkRecordFarmItem(slot3, JumpModel.instance:getRecordFarmItem()) then
			if not (slot6.quantity <= ItemModel.instance:getItemQuantity(slot6.type, slot6.id)) then
				GameSceneMgr.instance:closeScene(nil, , , true)
				DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot3).chapterId, slot3, DungeonModel.instance.curSelectTicketId)

				return
			end
		else
			GameSceneMgr.instance:closeScene(nil, , , true)
			DungeonFightController.instance:enterFight(slot5.chapterId, slot3, DungeonModel.instance.curSelectTicketId)

			return
		end
	end

	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
		PermanentController.instance:jump2Activity(VersionActivityEnum.ActivityId.Act105)

		if uv0.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = uv1
			uv1 = DungeonConfig.instance:getElementFightEpisodeToNormalEpisodeId(uv0)

			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(uv2, uv1, function ()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					episodeId = uv0
				})
			end)
		end
	end)
end

function slot0.enterActivity11103(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
		Activity109ChessController.instance:openGameAfterFight(uv0)
	end)
end

function slot0.enterActivity11100(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11100, slot0, slot1)
end

function slot0.checkFightAfterStory11100(slot0, slot1, slot2)
	if (uv0.recordMO and uv0.recordMO.fightResult) ~= 1 then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) or slot5.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if Activity104Model.instance:isEpisodeAfterStory(Activity104Enum.SeasonType.Season1, Activity104Model.instance.battleFinishLayer) then
		return
	end

	if not SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season1, slot6) or slot7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(slot7.afterStoryId, nil, slot0, slot1, slot2)

	return true
end

function slot0._enterActivityDungeonAterFight11100(slot0, slot1)
	VersionActivityController.instance:directOpenVersionActivityEnterView()

	slot2 = Activity104Model.instance.battleFinishLayer
	slot3 = Activity104Enum.SeasonType.Season1
	slot4 = uv0.recordMO and uv0.recordMO.fightResult
	slot6 = slot1.exitFightGroup
	slot8 = DungeonConfig.instance:getEpisodeCO(slot1.episodeId) and slot7.type

	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = Activity104Model.instance:canPlayStageLevelup(slot4, slot8, slot6, slot3, slot2)
	})

	if Activity104Model.instance:canMarkFightAfterStory(slot4, slot8, slot6, slot3, slot2) then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(slot3, slot2)
	end

	if not slot7 then
		logError("找不到对应关卡表,id:" .. slot5)

		return
	end

	if not slot4 or slot4 == -1 or slot4 == 0 then
		if slot8 == DungeonEnum.EpisodeType.Season then
			Activity104Controller.instance:openSeasonMarketView({
				tarLayer = slot2
			})

			return
		elseif slot8 == DungeonEnum.EpisodeType.SeasonRetail then
			Activity104Controller.instance:openSeasonRetailView({})

			return
		elseif slot8 == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSpecialMarketView({
				defaultSelectLayer = slot2,
				directOpenLayer = slot2
			})

			return
		end
	end

	if slot4 == 1 then
		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) then
			return
		end

		if slot8 == DungeonEnum.EpisodeType.Season then
			if slot9 then
				return
			end

			if not SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season1, slot2 + 1) then
				return
			end

			Activity104Controller.instance:openSeasonMarketView({
				tarLayer = slot10
			})

			return
		end

		if slot8 == DungeonEnum.EpisodeType.SeasonRetail then
			Activity104Controller.instance:openSeasonRetailView({})

			return
		end

		if slot8 == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSpecialMarketView({
				defaultSelectLayer = slot2
			})

			return
		end
	end

	if slot8 == DungeonEnum.EpisodeType.SeasonSpecial then
		Activity104Controller.instance:openSeasonSpecialMarketView()
	end
end

function slot0.enterFightAgain11100()
	slot2 = Activity104Enum.SeasonType.Season1
	slot3 = Activity104Model.instance.battleFinishLayer

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.SeasonRetail then
		slot3 = 0

		return false
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(slot2, slot3, slot0, uv0.enterFightAgain11100RpcCallback, nil)

	return true
end

function slot0.enterFightAgain11100RpcCallback(slot0, slot1, slot2)
	if slot1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		uv0.enterFightAgain()
	end
end

function slot0.activate()
end

return slot0
