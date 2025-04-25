module("modules.logic.versionactivity1_8.common.EnterActivityViewOnExitFightSceneHelper1_8", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.enterActivity11804(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivity11804, slot0, slot1)
end

function slot0._enterActivity11804(slot0, slot1)
	slot2 = slot1.episodeId
	slot3 = slot1.episodeCo

	if uv0.sequence then
		uv0.sequence:destroy()

		uv0.sequence = nil
	end

	slot4 = false

	if slot3.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = slot2

		if VersionActivity1_8DungeonModel.instance:getLastEpisodeId() then
			VersionActivity1_8DungeonModel.instance:setLastEpisodeId(nil)
		else
			slot2 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(slot3, VersionActivity1_8DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		slot4 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	else
		slot4 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapLevelView)
	end

	PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)

	slot5 = FlowSequence.New()

	slot5:addWork(OpenViewWork.New({
		openFunction = uv0.open2_4ReactivityEnterView,
		waitOpenViewName = ViewName.VersionActivity2_4EnterView
	}))
	slot5:registerDoneListener(function ()
		if uv0 then
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					episodeId = uv0
				})
			end, nil)
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		end
	end)
	slot5:start()

	uv0.sequence = slot5
end

function slot0.open2_4ReactivityEnterView()
	VersionActivity2_4EnterController.instance:directOpenVersionActivityEnterView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function slot0.enterActivity11806(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		if ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila) and slot0.isRetroAcitivity == 2 then
			PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)
			ActWeilaController.instance:openLevelView({
				needShowFight = true
			})
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8EnterView)
			VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
				ActWeilaController.instance:openLevelView({
					needShowFight = true
				})
			end, nil, VersionActivity1_8Enum.ActivityId.Weila)
		end
	end)
end

function slot0.enterActivity11807(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		if ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila) and slot0.isRetroAcitivity == 2 then
			PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)
			ActWindSongController.instance:openLevelView({
				needShowFight = true
			})
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8EnterView)
			VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
				ActWindSongController.instance:openLevelView({
					needShowFight = true
				})
			end, nil, VersionActivity1_8Enum.ActivityId.WindSong)
		end
	end)
end

function slot0.enterActivity11812(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = uv0,
				layer = uv1
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function slot0.enterActivity11811(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11811, slot0, slot1)
end

function slot1()
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot0) then
		return false
	end

	if not Season123Model.instance:getBattleContext() then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, slot0, slot1, slot2
end

function slot0._enterActivityDungeonAterFight11811(slot0, slot1)
	slot3 = slot1.exitFightGroup

	if not slot1.episodeId then
		return
	end

	if not Season123Model.instance:getBattleContext() then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	slot6 = slot4.stage
	slot7 = slot4.actId
	slot8 = uv0.recordMO and uv0.recordMO.fightResult
	slot11, slot12 = nil

	if slot9 then
		if not slot8 or slot8 == -1 or slot8 == 0 then
			if (DungeonConfig.instance:getEpisodeCO(slot2) and slot9.type) == DungeonEnum.EpisodeType.Season123 then
				slot11 = Activity123Enum.JumpId.MarketNoResult
				slot12 = {
					tarLayer = slot4.layer
				}
			elseif slot10 == DungeonEnum.EpisodeType.Season123Retail then
				slot11 = Activity123Enum.JumpId.Retail
			end
		elseif slot8 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if slot10 == DungeonEnum.EpisodeType.Season123 then
				if Season123Config.instance:getSeasonEpisodeCo(slot7, slot6, slot5 + 1) then
					slot11 = Activity123Enum.JumpId.Market
					slot12 = {
						tarLayer = slot13
					}
				else
					slot11 = Activity123Enum.JumpId.MarketStageFinish
					slot12 = {
						stage = slot6
					}
				end
			elseif slot10 == DungeonEnum.EpisodeType.Season123Retail then
				slot11 = Activity123Enum.JumpId.Retail
				slot12 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", slot2))
	end

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		Season123Controller.instance:openSeasonEntry({
			actId = uv0,
			jumpId = uv1,
			jumpParam = uv2
		})
	end, nil, VersionActivity1_8Enum.ActivityId.Season)
end

function slot0.checkFightAfterStory11811(slot0, slot1, slot2)
	if (uv0.recordMO and uv0.recordMO.fightResult) ~= 1 then
		return
	end

	slot4, slot5, slot6, slot7 = uv1()

	if not slot4 or slot6.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	if Season123Model.instance:isEpisodeAfterStory(slot7.actId, slot7.stage, slot7.layer) then
		return
	end

	if not Season123Config.instance:getSeasonEpisodeCo(slot9, slot10, slot8) or slot11.afterStoryId == nil or slot11.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(slot11.afterStoryId, nil, slot0, slot1, slot2)

	return true
end

function slot0.enterFightAgain11811()
	slot0, slot1, slot2, slot3 = uv0()

	if not slot0 or slot2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	if FightController.instance:isReplayMode(slot1) and not slot3.layer then
		if slot2.type == DungeonEnum.EpisodeType.Season123 then
			if not Season123Config.instance:getSeasonEpisodeStageCos(slot3.actId, slot3.stage) then
				return false
			end

			for slot12, slot13 in pairs(slot8) do
				if slot13.episodeId == slot1 then
					slot4 = slot13.layer

					break
				end
			end
		elseif slot2.type == DungeonEnum.EpisodeType.Season123Retail then
			slot4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, , , true)
	Season123EpisodeDetailController.instance:startBattle(slot6, slot5, slot4, slot1)

	return true
end

function slot0.activate()
end

return slot0
