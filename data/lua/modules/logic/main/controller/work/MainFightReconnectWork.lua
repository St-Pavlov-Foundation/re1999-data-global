module("modules.logic.main.controller.work.MainFightReconnectWork", package.seeall)

local var_0_0 = class("MainFightReconnectWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main or GameSceneMgr.instance:isClosing() then
		FightModel.instance.needFightReconnect = false

		arg_1_0:onDone(true)

		return
	end

	if FightModel.instance.needFightReconnect then
		if FightDataHelper.fieldMgr:is191DouQuQu() then
			Activity191Rpc.instance:sendGetAct191InfoRequest(VersionActivity2_7Enum.ActivityId.Act191)
		end

		local var_1_0 = FightModel.instance:getFightReason()

		if var_1_0.type == FightEnum.FightReason.None then
			FightRpc.instance:sendEndFightRequest(false)
			arg_1_0:onDone(true)
		elseif var_1_0.type == FightEnum.FightReason.Dungeon then
			local var_1_1 = arg_1_0

			GameFacade.showMessageBox(MessageBoxIdDefine.FightSureToReconnect, MsgBoxEnum.BoxType.Yes_No, function()
				var_1_1:_onConfirm()
			end, function()
				var_1_1:_onCancel()
			end)
		elseif var_1_0.type == FightEnum.FightReason.DungeonRecord then
			GameFacade.showMessageBox(MessageBoxIdDefine.FightSureToReconnect, MsgBoxEnum.BoxType.Yes_No, function()
				FightReplayModel.instance:setReconnectReplay(true)
				arg_1_0:_onConfirm()
			end, function()
				arg_1_0:_onCancel()
			end)
		else
			logError("reconnect type not implement: " .. (var_1_0.type or "nil"))
			arg_1_0:_onCancel()

			FightModel.instance.needFightReconnect = false
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onConfirm(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._onDelayDone, arg_6_0, 20)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, arg_6_0._onEnterFightScene, arg_6_0)

	local var_6_0 = FightModel.instance:getFightReason()
	local var_6_1 = var_6_0.episodeId

	DungeonModel.instance:SetSendChapterEpisodeId(nil, var_6_1)

	local var_6_2 = DungeonConfig.instance:getEpisodeCO(var_6_1)

	if var_6_2.type == DungeonEnum.EpisodeType.TowerPermanent then
		local var_6_3 = TowerModel.instance:getCurPermanentMo()

		if var_6_3 then
			TowerPermanentModel.instance:setLocalPassLayer(var_6_3.passLayerId)
		end
	elseif var_6_2.type == DungeonEnum.EpisodeType.TowerLimited then
		local var_6_4 = FightModel.instance.last_fightGroup.assistBossId
		local var_6_5 = TowerAssistBossModel.instance:getById(var_6_4)
		local var_6_6 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

		if var_6_5 then
			var_6_5:setTempState(var_6_6 > var_6_5.level)
		end

		TowerAssistBossModel.instance:getTempUnlockTrialBossMO(var_6_4)
	elseif var_6_2.type == DungeonEnum.EpisodeType.Assassin2Outside or var_6_2.type == DungeonEnum.EpisodeType.Assassin2Stealth then
		AssassinController.instance:getAssassinOutsideInfo()

		if var_6_2.type == DungeonEnum.EpisodeType.Assassin2Outside then
			local var_6_7 = AssassinConfig.instance:getFightQuestId(var_6_1)

			AssassinOutsideModel.instance:setEnterFightQuest(var_6_7)
		end
	end

	if DungeonConfig.instance:isLeiMiTeBeiChapterType(var_6_2) then
		local var_6_8 = var_6_0.type == FightEnum.FightReason.DungeonRecord

		FightController.instance:setFightParamByEpisodeId(var_6_1, var_6_8, var_6_0.multiplication)
	elseif var_6_2.type == DungeonEnum.EpisodeType.WeekWalk then
		WeekWalkModel.instance:setCurMapId(var_6_0.layerId)
		WeekWalkModel.instance:setBattleElementId(var_6_0.elementId)
		FightController.instance:setFightParamByEpisodeBattleId(var_6_1, FightModel.instance:getBattleId())
	elseif var_6_2.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		WeekWalk_2Model.instance:setCurMapId(var_6_0.layerId)
		WeekWalk_2Model.instance:setBattleElementId(var_6_0.elementId)
		FightController.instance:setFightParamByEpisodeBattleId(var_6_1, FightModel.instance:getBattleId())
	elseif var_6_2.type == DungeonEnum.EpisodeType.Meilanni then
		FightController.instance:setFightParamByEpisodeBattleId(var_6_1, FightModel.instance:getBattleId())

		local var_6_9 = var_6_0.eventEpisodeId
		local var_6_10 = var_6_9 and lua_activity108_episode.configDict[var_6_9]
		local var_6_11 = var_6_10 and var_6_10.mapId

		MeilanniModel.instance:setCurMapId(var_6_11)
		Activity108Rpc.instance:sendGet108InfosRequest(MeilanniEnum.activityId)
	elseif var_6_2.type == DungeonEnum.EpisodeType.Dog then
		FightController.instance:setFightParamByEpisodeBattleId(var_6_0.episodeId, var_6_0.battleId)
	elseif var_6_2.type == DungeonEnum.EpisodeType.YaXian then
		FightController.instance:setFightParamByEpisodeBattleId(YaXianGameEnum.EpisodeId, FightModel.instance:getBattleId())
	elseif var_6_2.type == DungeonEnum.EpisodeType.Survival or var_6_2.type == DungeonEnum.EpisodeType.Shelter then
		SurvivalController.instance:tryEnterSurvivalFight(arg_6_0._enterFightScene, arg_6_0)

		return
	elseif SeasonHeroGroupHandler.checkIsSeasonTypeByEpisodeId(var_6_1) then
		SeasonFightHandler.checkProcessFightReconnect(var_6_0)
	else
		local var_6_12 = var_6_0.type == FightEnum.FightReason.DungeonRecord
		local var_6_13 = var_6_0.multiplication

		var_6_13 = var_6_13 and var_6_13 > 0 and var_6_13 or 1

		FightController.instance:setFightParamByEpisodeId(var_6_1, var_6_12, var_6_13, var_6_0.battleId)
		HeroGroupModel.instance:setParam(var_6_0.battleId, var_6_1, false, true)
	end

	arg_6_0:_enterFightScene()
end

function var_0_0._enterFightScene(arg_7_0)
	FightModel.instance:updateMySide(FightModel.instance.last_fightGroup)
	FightController.instance:enterFightScene()
end

function var_0_0._onCancel(arg_8_0)
	DungeonFightController.instance:sendEndFightRequest(true)
	FightModel.instance:clear()
	arg_8_0:onDone(true)
end

function var_0_0._onEnterFightScene(arg_9_0)
	arg_9_0:removeEnterFightListener()
	TaskDispatcher.runRepeat(arg_9_0._onCheckEnterMainView, arg_9_0, 0.5)
end

function var_0_0._onCheckEnterMainView(arg_10_0)
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
		TaskDispatcher.cancelTask(arg_10_0._onCheckEnterMainView, arg_10_0)
		arg_10_0:onDone(true)
	end
end

function var_0_0._onDelayDone(arg_11_0)
	logError("战斗重连超时，打开下一个Popup")
	arg_11_0:onDone(true)
end

function var_0_0.clearWork(arg_12_0)
	arg_12_0:removeEnterFightListener()
	TaskDispatcher.cancelTask(arg_12_0._onCheckEnterMainView, arg_12_0)
end

function var_0_0.removeEnterFightListener(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onDelayDone, arg_13_0)
	GameSceneMgr.instance:unregisterCallback(SceneType.Fight, arg_13_0._onEnterFightScene, arg_13_0)
end

return var_0_0
