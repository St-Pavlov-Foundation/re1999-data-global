module("modules.logic.versionactivity1_4.common.EnterActivityViewOnExitFightSceneHelper1_4", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.enterActivity11407(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11407, slot0, slot1)
end

function slot0._enterActivityDungeonAterFight11407(slot0, slot1)
	VersionActivity1_4EnterController.instance:directOpenVersionActivityEnterView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = 11407
	})
end

function slot0.enterActivity11400(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11400, slot0, slot1)
end

function slot0.enterActivity11414(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened()
		BossRushController.instance:openMainView({
			isOpenLevelDetail = true,
			stage = uv0,
			layer = uv1
		})
	end)
end

function slot0.checkFightAfterStory11400(slot0, slot1, slot2)
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

function slot0._enterActivityDungeonAterFight11400(slot0, slot1)
	slot3 = slot1.exitFightGroup

	if not slot1.episodeId then
		return
	end

	VersionActivity1_4EnterController.instance:directOpenVersionActivityEnterView()

	slot4 = Activity104Model.instance:getBattleFinishLayer()
	slot5 = Activity104Model.instance:getCurSeasonId()
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

function slot0.enterFightAgain11400()
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

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(slot2, slot3, slot0, uv0.enterFightAgain11400RpcCallback, nil)

	return true
end

function slot0.enterFightAgain11400RpcCallback(slot0, slot1, slot2)
	if slot1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		uv0.enterFightAgain()
	end
end

function slot0.enterActivity11403(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11403, slot0, slot1)
end

function slot0._enterActivityDungeonAterFight11403(slot0, slot1)
	PermanentController.instance:jump2Activity(VersionActivity1_4Enum.ActivityId.EnterView)
	Activity131Controller.instance:openActivity131LevelView({
		exitFromBattle = true,
		episodeId = Activity131Model.instance:getCurEpisodeId()
	})
	Activity131Controller.instance:openActivity131GameView({
		exitFromBattle = true
	})
end

function slot0.activate()
end

return slot0
