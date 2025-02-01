module("modules.logic.versionactivity1_2.common.EnterActivityViewOnExitFightSceneHelper1_2", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.activate()
end

function slot0.enterFightAgain11208()
	slot0 = DungeonModel.instance.curSendEpisodeId
	slot1 = DungeonConfig.instance:getEpisodeCO(slot0)

	if FightController.instance:isReplayMode(slot0) then
		if VersionActivity1_2DungeonModel.instance.newSp and tabletool.len(VersionActivity1_2DungeonModel.instance.newSp) > 0 then
			VersionActivity1_2DungeonModel.instance.newSp = nil

			return false
		else
			uv0.enterFightAgain()
		end
	else
		uv0.enterFightAgain()
	end

	return true
end

function slot0.enterActivity11208(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11208, slot0, slot1)
end

function slot0._enterActivityDungeonAterFight11208(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(slot1.episodeId) then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_2DungeonView)
	PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)

	if slot3.chapterId == 12701 or slot3.chapterId == 12102 then
		VersionActivity1_2DungeonController.instance:openDungeonView()
	else
		VersionActivity1_2DungeonController.instance:openDungeonView(slot3.chapterId, slot2)
	end
end

function slot0.enterActivity11203(slot0, slot1)
	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.YaXianMapView)
		PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)
		Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, function ()
			ViewMgr.instance:openView(ViewName.YaXianMapView, {
				chapterId = YaXianModel.instance:getCurrentMapInfo() and slot0.episodeCo.chapterId
			})
			YaXianDungeonController.instance:openGameAfterFight()
		end)
	end)
end

function slot0.enterActivity11200(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight11200, slot0, slot1)
end

function slot0.checkFightAfterStory11200(slot0, slot1, slot2)
	if (uv0.recordMO and uv0.recordMO.fightResult) ~= 1 then
		return
	end

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot4) or slot5.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if Activity104Model.instance:isEpisodeAfterStory(Activity104Enum.SeasonType.Season2, Activity104Model.instance:getBattleFinishLayer()) then
		return
	end

	if not SeasonConfig.instance:getSeasonEpisodeCo(slot7, slot6) or slot8.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(slot8.afterStoryId, nil, slot0, slot1, slot2)

	return true
end

function slot0._enterActivityDungeonAterFight11200(slot0, slot1)
	slot3 = slot1.exitFightGroup

	if not slot1.episodeId then
		return
	end

	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()

	slot4 = Activity104Model.instance:getBattleFinishLayer()
	slot5 = Activity104Enum.SeasonType.Season2
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
					if not slot9 and SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season2, slot4 + 1) then
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

	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = slot9,
		jumpId = slot10,
		jumpParam = slot11
	})
end

function slot0.enterFightAgain11200()
	slot2 = Activity104Enum.SeasonType.Season2
	slot3 = Activity104Model.instance:getBattleFinishLayer()

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.SeasonRetail then
		slot3 = 0

		return false
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(slot2, slot3, slot0, uv0.enterFightAgain11200RpcCallback, nil)

	return true
end

function slot0.enterFightAgain11200RpcCallback(slot0, slot1, slot2)
	if slot1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		uv0.enterFightAgain()
	end
end

function slot0.enterActivity11202(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity114View)
		PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)

		slot0 = nil

		if Activity114Model.instance.serverData.isEnterSchool and Activity114Model.instance.serverData.battleEventId <= 0 then
			slot0 = {
				defaultTabIds = {
					[2] = Activity114Enum.TabIndex.MainView
				}
			}
		end

		ViewMgr.instance:openView(ViewName.Activity114View, slot0)
	end)
end

function slot0.enterActivity11206(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		Activity119Controller.instance:openAct119View()
	end)
end

return slot0
