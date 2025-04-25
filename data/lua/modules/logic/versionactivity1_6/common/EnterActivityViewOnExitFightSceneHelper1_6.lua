module("modules.logic.versionactivity1_6.common.EnterActivityViewOnExitFightSceneHelper1_6", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.enterActivity11610(slot0, slot1)
	slot2 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if not slot1 and slot2 and not slot2:isBattleSuccess() then
		GameSceneMgr.instance:closeScene(nil, , , true)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, slot2)

		return
	end

	slot3 = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	V1a6_CachotController.instance:enterMap(true)
end

function slot0.enterActivity11605(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			ActQuNiangController.instance:openLevelView({
				needShowFight = true
			})
		end, nil, ActQuNiangEnum.ActivityId)
	end)
end

function slot0.enterActivity11606(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			ActGeTianController.instance:openLevelView({
				needShowFight = true
			})
		end, nil, ActGeTianEnum.ActivityId)
	end)
end

function slot0.enterActivity11602(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivity11602, slot0, slot1)
end

function slot0._enterActivity11602(slot0, slot1)
	slot2 = slot1.episodeId
	slot3 = slot1.episodeCo

	if uv0.sequence then
		uv0.sequence:destroy()

		uv0.sequence = nil
	end

	slot4 = false

	if DungeonModel.instance.curSendEpisodePass then
		slot4 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapView)
	else
		slot4 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapLevelView)
	end

	slot5 = FlowSequence.New()

	slot5:addWork(OpenViewWork.New({
		openFunction = uv0.open2_5ReactivityEnterView,
		openFunctionObj = (slot6 and slot6.isRetroAcitivity == 1 and VersionActivity2_5EnterController or VersionActivity1_6EnterController).instance,
		waitOpenViewName = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Dungeon) and slot6.isRetroAcitivity == 1 and ViewName.VersionActivity2_5EnterView or ViewName.VersionActivity1_6EnterView
	}))
	slot5:registerDoneListener(function ()
		if uv0 then
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					episodeId = uv0
				})
			end, nil)
		else
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		end
	end)
	slot5:start()

	uv0.sequence = slot5
end

function slot0.open2_5ReactivityEnterView()
	VersionActivity2_5EnterController.instance:directOpenVersionActivityEnterView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function slot0.enterActivity11609(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonBossView)

		if ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.DungeonBossRush) and slot0.isRetroAcitivity == 1 then
			VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened()
		else
			VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened()
		end

		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, VersionActivity1_6DungeonEnum.DungeonBossEpisodeId, function ()
			VersionActivity1_6DungeonController.instance:openDungeonBossView(true)
		end, nil)
	end)
end

function slot0.enterActivity11600(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11600, slot0, slot1)
end

function slot0.checkFightAfterStory11600(slot0, slot1, slot2)
	if (uv0.recordMO and uv0.recordMO.fightResult) ~= 1 then
		return
	end

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot4) or slot5.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if Activity104Model.instance:isEpisodeAfterStory(Activity104Model.instance:getCurSeasonId(), Activity104Model.instance:getBattleFinishLayer()) then
		return
	end

	if not SeasonConfig.instance:getSeasonEpisodeCo(slot7, slot6) or slot8.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(slot8.afterStoryId, nil, slot0, slot1, slot2)

	return true
end

function slot0._enterActivityDungeonAterFight11600(slot0, slot1)
	slot3 = slot1.exitFightGroup

	if not slot1.episodeId then
		return
	end

	slot4 = Activity104Model.instance:getBattleFinishLayer()

	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , Activity104Model.instance:getCurSeasonId())

	slot6 = uv0.recordMO and uv0.recordMO.fightResult
	slot8 = DungeonConfig.instance:getEpisodeCO(slot2) and slot7.type
	slot9 = Activity104Model.instance:canPlayStageLevelup(slot6, slot8, slot3, slot5, slot4)
	slot10, slot11 = nil

	if Activity104Model.instance:canMarkFightAfterStory(slot6, slot8, slot3, slot5, slot4) then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(slot5, slot4)
	end

	if slot7 then
		if not slot6 or slot6 == -1 or slot6 == 0 then
			if slot8 == DungeonEnum.EpisodeType.Season then
				slot10 = Activity104Enum.JumpId.Market
				slot11 = {
					tarLayer = slot4
				}
			elseif slot8 == DungeonEnum.EpisodeType.SeasonRetail then
				slot10 = Activity104Enum.JumpId.Retail
			elseif slot8 == DungeonEnum.EpisodeType.SeasonSpecial then
				slot10 = Activity104Enum.JumpId.Discount
				slot11 = {
					defaultSelectLayer = slot4,
					directOpenLayer = slot4
				}
			end
		elseif slot6 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if slot8 == DungeonEnum.EpisodeType.Season then
					if not slot9 and SeasonConfig.instance:getSeasonEpisodeCo(slot5, slot4 + 1) then
						slot10 = Activity104Enum.JumpId.Market
						slot11 = {
							tarLayer = slot13
						}
					end
				elseif slot8 == DungeonEnum.EpisodeType.SeasonRetail then
					slot10 = Activity104Enum.JumpId.Retail
				elseif slot8 == DungeonEnum.EpisodeType.SeasonSpecial then
					slot10 = Activity104Enum.JumpId.Discount
					slot11 = {
						defaultSelectLayer = slot4
					}
				end
			end

			if slot12 and slot4 == 2 then
				slot10, slot11 = nil
			end
		elseif slot8 == DungeonEnum.EpisodeType.SeasonSpecial then
			slot10 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", slot2))
	end

	slot13 = nil

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, SeasonViewHelper.getViewName(slot5, (slot10 ~= Activity104Enum.JumpId.Market or Activity104Enum.ViewName.MarketView) and (slot10 ~= Activity104Enum.JumpId.Retail or Activity104Enum.ViewName.RetailView) and (slot10 ~= Activity104Enum.JumpId.Discount or Activity104Enum.ViewName.SpecialMarketView) and Activity104Enum.ViewName.MainView, true))
	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = slot9,
		jumpId = slot10,
		jumpParam = slot11
	})
end

function slot0.enterFightAgain11600()
	slot2 = Activity104Model.instance:getCurSeasonId()
	slot3 = Activity104Model.instance:getBattleFinishLayer()

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.SeasonRetail then
		slot3 = 0

		return false
	end

	if FightController.instance:isReplayMode(slot0) and not slot3 then
		if slot1.type == DungeonEnum.EpisodeType.Season then
			for slot9, slot10 in pairs(SeasonConfig.instance:getSeasonEpisodeCos(slot2)) do
				if slot10.episodeId == slot0 then
					slot3 = slot10.layer

					break
				end
			end
		elseif slot1.type == DungeonEnum.EpisodeType.SeasonRetail then
			slot3 = 0
		elseif slot1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			for slot9, slot10 in pairs(SeasonConfig.instance:getSeasonSpecialCos(slot2)) do
				if slot10.episodeId == slot0 then
					slot3 = slot10.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(slot3)
	end

	GameSceneMgr.instance:closeScene(nil, , , true)
	Activity104Model.instance:enterAct104Battle(slot0, slot3)

	return true
end

function slot0.enterActivity11604(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = uv0,
				layer = uv1
			})
		end, nil, VersionActivity1_6Enum.ActivityId.BossRush)
	end)
end

function slot0.activate()
end

return slot0
