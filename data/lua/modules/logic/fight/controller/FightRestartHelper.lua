module("modules.logic.fight.controller.FightRestartHelper", package.seeall)

local var_0_0 = _M

function var_0_0.tryRestart()
	local var_1_0 = FightModel.instance:getRecordMO()

	if var_1_0 and var_1_0.fightResult == FightEnum.FightResult.Succ then
		return false
	end

	local var_1_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_1_2 = var_1_1 and var_1_1.type

	if not var_1_2 then
		return false
	end

	var_0_0._initHandle()

	local var_1_3 = var_0_0.handleDict[var_1_2]

	return var_1_3 and var_1_3()
end

function var_0_0._initHandle()
	if not var_0_0.handleDict then
		var_0_0.handleDict = {
			[DungeonEnum.EpisodeType.Cachot] = var_0_0.tryRestartCachot,
			[DungeonEnum.EpisodeType.Rouge] = var_0_0.tryRestartRouge
		}
	end
end

function var_0_0.tryRestartCachot()
	if ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local var_3_0 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if var_3_0 then
		local var_3_1 = V1a6_CachotModel.instance:getRogueInfo().difficulty
		local var_3_2 = lua_rogue_difficulty.configDict[var_3_1].retries - var_3_0:getRetries() + 1

		if var_3_2 > 0 then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.V1a6CachotMsgBox05, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", FightRestartMgr.fastRestart, var_0_0.onExitCachot, nil, FightGameMgr.restartMgr, nil, nil, var_3_2)

			return true
		end
	end

	return false
end

function var_0_0.onExitCachot()
	RogueRpc.instance:sendAbortRogueRequest(V1a6_CachotEnum.ActivityId)
	FightGameMgr.playMgr:_PlayEnd()
end

function var_0_0.tryRestartRouge()
	if (SLFramework.FrameworkSettings.IsEditor or isDebugBuild) and RougeEditorController.instance:isAllowAbortFight() then
		GMRpc.instance:sendGMRequest("rougeSetRetryNum 1 0")

		return false
	end

	if FightModel.instance:isAbort() then
		RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason() or 1)

		return false
	end

	if RougeModel.instance:isFinish() then
		return false
	end

	local var_5_0 = RougeModel.instance:getFightResultInfo()

	if not var_5_0 then
		return false
	end

	local var_5_1 = RougeMapConfig.instance:getFightRetryNum()

	if var_5_1 < var_5_0.retryNum then
		return false
	end

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.RougeFightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", FightRestartMgr.fastRestart, var_0_0.onExitFight, nil, FightGameMgr.restartMgr, nil, nil, var_5_1 - var_5_0.retryNum + 1)

	return true
end

function var_0_0.onExitFight()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason() or 1)
	FightGameMgr.playMgr:_PlayEnd()
end

return var_0_0
