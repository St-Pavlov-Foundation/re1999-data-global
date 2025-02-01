module("modules.logic.fight.controller.FightRestartHelper", package.seeall)

slot0 = _M

function slot0.tryRestart()
	if FightModel.instance:getRecordMO() and slot0.fightResult == FightEnum.FightResult.Succ then
		return false
	end

	if not (DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type) then
		return false
	end

	uv0._initHandle()

	return uv0.handleDict[slot2] and slot3()
end

function slot0._initHandle()
	if not uv0.handleDict then
		uv0.handleDict = {
			[DungeonEnum.EpisodeType.Cachot] = uv0.tryRestartCachot,
			[DungeonEnum.EpisodeType.Rouge] = uv0.tryRestartRouge
		}
	end
end

function slot0.tryRestartCachot()
	if ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	if V1a6_CachotRoomModel.instance:getNowBattleEventMo() and lua_rogue_difficulty.configDict[V1a6_CachotModel.instance:getRogueInfo().difficulty].retries - slot1:getRetries() + 1 > 0 then
		MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.V1a6CachotMsgBox05, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", FightSystem._onRestart, FightSystem.onExitCachot, nil, FightSystem.instance, nil, , slot4)

		return true
	end

	return false
end

function slot0.onExitCachot()
	RogueRpc.instance:sendAbortRogueRequest(V1a6_CachotEnum.ActivityId)
	FightSystem.instance:_onEndFight()
end

function slot0.tryRestartRouge()
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

	if not RougeModel.instance:getFightResultInfo() then
		return false
	end

	if RougeMapConfig.instance:getFightRetryNum() < slot0.retryNum then
		return false
	end

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.RougeFightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", FightSystem._onRestart, uv0.onExitFight, nil, FightSystem.instance, nil, , slot1 - slot0.retryNum + 1)

	return true
end

function slot0.onExitFight()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason() or 1)
	FightSystem.instance:_onEndFight()
end

return slot0
