module("modules.logic.versionactivity1_6.dungeon.controller.VersionActivity1_6DungeonController", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._bossModel = VersionActivity1_6DungeonBossModel.instance
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._bossModel = VersionActivity1_6DungeonBossModel.instance

	arg_2_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenMapViewDone, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_3_0._respBeginFight, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.RespBeginRound, arg_3_0._respBeginRound, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnIndicatorChange, arg_3_0._onIndicatorChange, arg_3_0)
	arg_3_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
end

function var_0_0._respBeginFight(arg_4_0)
	arg_4_0._tempScore = 0

	arg_4_0._bossModel:setFightScore(0)
end

function var_0_0._respBeginRound(arg_5_0)
	local var_5_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.fightStep

	if not var_5_1 or not next(var_5_1) then
		return
	end

	local var_5_2 = FightWorkIndicatorChange.ConfigEffect.AddIndicator
	local var_5_3 = FightEnum.EffectType.INDICATORCHANGE
	local var_5_4 = FightEnum.IndicatorId.Act1_6DungeonBoss
	local var_5_5 = 0

	for iter_5_0 = #var_5_1, 1, -1 do
		local var_5_6 = var_5_1[iter_5_0].actEffect or {}

		for iter_5_1 = #var_5_6, 1, -1 do
			local var_5_7 = var_5_6[iter_5_1]
			local var_5_8 = var_5_7.effectType
			local var_5_9 = tonumber(var_5_7.targetId)
			local var_5_10 = var_5_7.configEffect

			if var_5_8 == var_5_3 and var_5_9 == var_5_4 and var_5_10 == var_5_2 then
				var_5_5 = math.max(var_5_5, var_5_7.effectNum)
			end
		end
	end

	if var_5_5 > 0 then
		arg_5_0._bossModel:setFightScore(var_5_5)
	end
end

function var_0_0._onIndicatorChange(arg_6_0, arg_6_1)
	if arg_6_1 == FightEnum.IndicatorId.Act1_6DungeonBoss then
		local var_6_0 = FightDataHelper.fieldMgr:getIndicatorNum(arg_6_1)

		arg_6_0._tempScore = math.max(arg_6_0._tempScore, var_6_0)

		arg_6_0._bossModel:noticeFightScore(arg_6_0._tempScore)
	end
end

function var_0_0._onEndDungeonPush(arg_7_0, arg_7_1)
	if not FightResultModel.instance.firstPass then
		return
	end

	local var_7_0 = FightResultModel.instance.episodeId

	if arg_7_0._bossModel:getMaxOrderMo().cfg.episodeId == var_7_0 then
		-- block empty
	end
end

function var_0_0.openActivityDungeonMapViewDirectly(arg_8_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapView, arg_8_0.openViewParam)
end

function var_0_0.getEpisodeMapConfig(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getStoryEpisodeCo(arg_9_1)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_6DungeonEnum.DungeonChapterId.Story, var_9_0.preEpisode)
end

function var_0_0.getEpisodeIndex(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getStoryEpisodeCo(arg_10_1)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_10_0.chapterId, var_10_0.id)
end

function var_0_0.getStoryEpisodeCo(arg_11_0, arg_11_1)
	local var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_1)

	if var_11_0.chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Hard then
		arg_11_1 = arg_11_1 - 10000
		var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_1)
	else
		while var_11_0.chapterId ~= VersionActivity1_6DungeonEnum.DungeonChapterId.Story do
			var_11_0 = DungeonConfig.instance:getEpisodeCO(var_11_0.preEpisode)
		end
	end

	return var_11_0
end

function var_0_0.enterBossFightScene(arg_12_0, arg_12_1)
	local var_12_0 = Activity149Config.instance:getDungeonEpisodeCfg(arg_12_1)
	local var_12_1 = var_12_0.id
	local var_12_2 = var_12_0.chapterId
	local var_12_3 = var_12_0.battleId
	local var_12_4 = FightController.instance:setFightParamByBattleId(var_12_3)

	var_12_4.episodeId = var_12_1
	var_12_4.chapterId = var_12_2
	FightResultModel.instance.episodeId = var_12_1

	DungeonModel.instance:SetSendChapterEpisodeId(var_12_2, var_12_1)
	var_12_4:setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.openVersionActivityDungeonMapView(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0.openViewParam = {
		chapterId = arg_13_1,
		episodeId = arg_13_2
	}
	arg_13_0.openMapViewCallback = arg_13_3
	arg_13_0.openMapViewCallbackObj = arg_13_4
	arg_13_0.receiveTaskReply = nil
	arg_13_0.waitAct148InfoReply = true

	VersionActivity1_6DungeonModel.instance:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_13_0._onReceiveTaskReply, arg_13_0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_6Enum.ActivityId.Dungeon)

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
		VersionActivity1_6DungeonRpc.instance:sendGet148InfoRequest(arg_13_0._onReceiveAct148InfoReply, arg_13_0)
	else
		arg_13_0.waitAct148InfoReply = false
	end
end

function var_0_0._onReceiveTaskReply(arg_14_0)
	arg_14_0.receiveTaskReply = true

	arg_14_0:_openVersionActivityDungeonMapView()
end

function var_0_0._onReceiveAct148InfoReply(arg_15_0)
	arg_15_0.waitAct148InfoReply = false

	arg_15_0:_openVersionActivityDungeonMapView()
end

function var_0_0._openVersionActivityDungeonMapView(arg_16_0)
	if not arg_16_0.receiveTaskReply or arg_16_0.waitAct148InfoReply then
		return
	end

	arg_16_0.receiveTaskReply = nil

	if arg_16_0.openMapViewCallback then
		arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_16_0._onOpenMapViewDone, arg_16_0)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapView, arg_16_0.openViewParam)
end

function var_0_0._onOpenMapViewDone(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.VersionActivity1_6DungeonMapView then
		arg_17_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_17_0._onOpenMapViewDone, arg_17_0)

		if arg_17_0.openMapViewCallback then
			local var_17_0 = arg_17_0.openMapViewCallback
			local var_17_1 = arg_17_0.openMapViewCallbackObj

			arg_17_0.openMapViewCallback = nil
			arg_17_0.openMapViewCallbackObj = nil

			var_17_0(var_17_1)
		end
	end
end

function var_0_0.openTaskView(arg_18_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6TaskView)
end

function var_0_0.openSkillView(arg_19_0)
	VersionActivity1_6DungeonRpc.instance:sendGet148InfoRequest(arg_19_0._openSkillViewImpl, arg_19_0)
end

function var_0_0._openSkillViewImpl(arg_20_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillView)
end

function var_0_0.openSkillLvUpView(arg_21_0, arg_21_1)
	local var_21_0 = {
		skillType = arg_21_1
	}

	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillLvUpView, var_21_0)
end

function var_0_0.openResultPanel(arg_22_0, arg_22_1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)
end

function var_0_0.openDungeonBossView(arg_23_0, arg_23_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102) then
		local var_23_0, var_23_1 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60102)

		GameFacade.showToastWithTableParam(var_23_0, var_23_1)

		return
	end

	arg_23_0._openBossViewParam = {
		toPreEpisode = arg_23_1
	}

	VersionActivity1_6DungeonRpc.instance:sendGet149InfoRequest(arg_23_0._onReceiveAct149InfoReply, arg_23_0)
end

function var_0_0._onReceiveAct149InfoReply(arg_24_0)
	arg_24_0:_afterDailyBonusOpenDungeonBossView()
end

function var_0_0._afterDailyBonusOpenDungeonBossView(arg_25_0)
	local var_25_0 = VersionActivity1_6DungeonBossModel.instance:GetOpenBossViewWithDailyBonus()

	arg_25_0._openBossViewParam.showDailyBonus = var_25_0

	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonBossView, arg_25_0._openBossViewParam)
	VersionActivity1_6DungeonBossModel.instance:SetOpenBossViewWithDailyBonus(false)
end

function var_0_0._onCurrencyChange(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		if iter_26_1 == CurrencyEnum.CurrencyType.V1a6DungeonSkill then
			-- block empty
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
