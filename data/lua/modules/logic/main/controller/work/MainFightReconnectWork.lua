module("modules.logic.main.controller.work.MainFightReconnectWork", package.seeall)

slot0 = class("MainFightReconnectWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main or GameSceneMgr.instance:isClosing() then
		FightModel.instance.needFightReconnect = false

		slot0:onDone(true)

		return
	end

	if FightModel.instance.needFightReconnect then
		if FightModel.instance:getFightReason().type == FightEnum.FightReason.None then
			FightRpc.instance:sendEndFightRequest(false)
			slot0:onDone(true)
		else
			if slot2.type == FightEnum.FightReason.Dungeon then
				slot3 = slot0

				GameFacade.showMessageBox(MessageBoxIdDefine.FightSureToReconnect, MsgBoxEnum.BoxType.Yes_No, function ()
					uv0:_onConfirm()
				end, function ()
					uv0:_onCancel()
				end)

				return
			end

			if slot2.type == FightEnum.FightReason.DungeonRecord then
				GameFacade.showMessageBox(MessageBoxIdDefine.FightSureToReconnect, MsgBoxEnum.BoxType.Yes_No, function ()
					FightReplayModel.instance:setReconnectReplay(true)
					uv0:_onConfirm()
				end, function ()
					uv0:_onCancel()
				end)
			else
				logError("reconnect type not implement: " .. (slot2.type or "nil"))
				slot0:_onCancel()

				FightModel.instance.needFightReconnect = false
			end
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onConfirm(slot0)
	TaskDispatcher.runDelay(slot0._onDelayDone, slot0, 20)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, slot0._onEnterFightScene, slot0)

	slot2 = FightModel.instance:getFightReason().episodeId

	DungeonModel.instance:SetSendChapterEpisodeId(nil, slot2)

	if DungeonConfig.instance:getEpisodeCO(slot2).type == DungeonEnum.EpisodeType.TowerPermanent and TowerModel.instance:getCurPermanentMo() then
		TowerPermanentModel.instance:setLocalPassLayer(slot4.passLayerId)
	end

	if DungeonConfig.instance:isLeiMiTeBeiChapterType(slot3) then
		FightController.instance:setFightParamByEpisodeId(slot2, slot1.type == FightEnum.FightReason.DungeonRecord, slot1.multiplication)
	elseif slot3.type == DungeonEnum.EpisodeType.WeekWalk then
		WeekWalkModel.instance:setCurMapId(slot1.layerId)
		WeekWalkModel.instance:setBattleElementId(slot1.elementId)
		FightController.instance:setFightParamByEpisodeBattleId(slot2, FightModel.instance:getBattleId())
	elseif slot3.type == DungeonEnum.EpisodeType.Meilanni then
		FightController.instance:setFightParamByEpisodeBattleId(slot2, FightModel.instance:getBattleId())

		slot5 = slot1.eventEpisodeId and lua_activity108_episode.configDict[slot4]

		MeilanniModel.instance:setCurMapId(slot5 and slot5.mapId)
		Activity108Rpc.instance:sendGet108InfosRequest(MeilanniEnum.activityId)
	elseif slot3.type == DungeonEnum.EpisodeType.Dog then
		FightController.instance:setFightParamByEpisodeBattleId(slot1.episodeId, slot1.battleId)
	elseif slot3.type == DungeonEnum.EpisodeType.YaXian then
		FightController.instance:setFightParamByEpisodeBattleId(YaXianGameEnum.EpisodeId, FightModel.instance:getBattleId())
	elseif SeasonHeroGroupHandler.checkIsSeasonTypeByEpisodeId(slot2) then
		SeasonFightHandler.checkProcessFightReconnect(slot1)
	else
		FightController.instance:setFightParamByEpisodeId(slot2, slot1.type == FightEnum.FightReason.DungeonRecord, slot1.multiplication and slot6 > 0 and slot6 or 1, slot1.battleId)
		HeroGroupModel.instance:setParam(slot1.battleId, slot2, false, true)
	end

	FightModel.instance:updateMySide(FightModel.instance.last_fightGroup)
	FightController.instance:enterFightScene()
end

function slot0._onCancel(slot0)
	DungeonFightController.instance:sendEndFightRequest(true)
	FightModel.instance:clear()
	slot0:onDone(true)
end

function slot0._onEnterFightScene(slot0)
	slot0:removeEnterFightListener()
	TaskDispatcher.runRepeat(slot0._onCheckEnterMainView, slot0, 0.5)
end

function slot0._onCheckEnterMainView(slot0)
	if not MainController.instance:isInMainView() then
		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
		slot0:onDone(true)
	end
end

function slot0._onDelayDone(slot0)
	logError("战斗重连超时，打开下一个Popup")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0:removeEnterFightListener()
	TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
end

function slot0.removeEnterFightListener(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayDone, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneType.Fight, slot0._onEnterFightScene, slot0)
end

return slot0
