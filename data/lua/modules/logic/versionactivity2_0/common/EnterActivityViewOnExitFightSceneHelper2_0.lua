module("modules.logic.versionactivity2_0.common.EnterActivityViewOnExitFightSceneHelper2_0", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.enterActivity12003(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivity12003, slot0, slot1)
end

function slot0._enterActivity12003(slot0, slot1)
	slot2 = slot1.episodeId
	slot3 = slot1.episodeCo

	if uv0.sequence then
		uv0.sequence:destroy()

		uv0.sequence = nil
	end

	slot4 = false

	if slot3.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = slot2

		if VersionActivity2_0DungeonModel.instance:getLastEpisodeId() then
			VersionActivity2_0DungeonModel.instance:setLastEpisodeId(nil)
		else
			slot2 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(slot3, VersionActivity2_0DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		slot4 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	else
		slot4 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapLevelView)
	end

	slot5 = FlowSequence.New()

	slot5:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_0EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_0EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_0EnterView
	}))
	slot5:registerDoneListener(function ()
		if uv0 then
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					episodeId = uv0
				})
			end, nil)
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		end
	end)
	slot5:start()

	uv0.sequence = slot5
end

function slot0.enterActivity12009(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	slot2 = VersionActivity2_0Enum.ActivityId.Mercuria

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0EnterView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = uv0
			})
		end, nil, uv0)
	end)
end

function slot0.enterActivity12008(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	slot2 = VersionActivity2_0Enum.ActivityId.Joe

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0EnterView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = uv0
			})
		end, nil, uv0)
	end)
end

function slot0.activate()
end

function slot0.enterActivity12013(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = uv0,
				layer = uv1
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function slot0.enterActivity12006(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight12006, slot0, slot1)
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

function slot0._enterActivityDungeonAterFight12006(slot0, slot1)
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

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		Season123Controller.instance:openSeasonEntry({
			actId = uv0,
			jumpId = uv1,
			jumpParam = uv2
		})
	end, nil, VersionActivity2_0Enum.ActivityId.Season)
end

function slot0.checkFightAfterStory12006(slot0, slot1, slot2)
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

function slot0.enterFightAgain12006()
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

return slot0
