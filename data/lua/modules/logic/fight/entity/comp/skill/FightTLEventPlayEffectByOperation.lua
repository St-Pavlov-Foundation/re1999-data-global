module("modules.logic.fight.entity.comp.skill.FightTLEventPlayEffectByOperation", package.seeall)

local var_0_0 = class("FightTLEventPlayEffectByOperation", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.playing = true
	arg_1_0.curCount = 0
	arg_1_0.operationWorkList = {}

	arg_1_0:com_registMsg(FightMsgId.OperationForPlayEffect, arg_1_0.onOperationForPlayEffect)

	arg_1_1.playerOperationCountForPlayEffectTimeline = 0
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.paramsArr = arg_1_3
	arg_1_0.effectType = tonumber(arg_1_0.paramsArr[1])
	arg_1_0.sequenceFlow = FightWorkFlowSequence.New()

	arg_1_0.timelineItem:addWork2FinishWork(arg_1_0.sequenceFlow)
	arg_1_0:buildOperationWorkList()

	arg_1_1.maxPlayerOperationCountForPlayEffectTimeline = #arg_1_0.operationWorkList

	arg_1_0:com_registTimer(arg_1_0.playAllOperationWork, tonumber(arg_1_0.paramsArr[3]))

	local var_1_0 = ({
		[FightEnum.EffectType.NUODIKARANDOMATTACK] = "FightNuoDiKaQteView"
	})[arg_1_0.effectType]

	if var_1_0 then
		ViewMgr.instance:openView(var_1_0, {
			effectType = arg_1_0.effectType,
			timeLimit = tonumber(arg_1_0.paramsArr[4]),
			paramsArr = arg_1_3,
			fightStepData = arg_1_1
		})
		arg_1_0.sequenceFlow:registWork(FightWorkFunction, arg_1_0.closeView, arg_1_0, var_1_0)
	end

	local var_1_1 = arg_1_0.paramsArr[6]

	if not string.nilorempty(var_1_1) then
		local var_1_2 = tonumber(arg_1_0.paramsArr[5])

		arg_1_0.sequenceFlow:registWork(FightWorkDelayTimer, var_1_2)

		local var_1_3 = {
			actId = 0,
			playerOperationCountForPlayEffectTimeline = 0,
			actEffect = arg_1_0.nuoDiKaTeamAttack,
			fromId = arg_1_1.fromId,
			toId = arg_1_1.toId,
			actType = FightEnum.ActType.SKILL,
			stepUid = FightTLEventEntityVisible.latestStepUid or 0,
			maxPlayerOperationCountForPlayEffectTimeline = arg_1_1.maxPlayerOperationCountForPlayEffectTimeline
		}

		arg_1_0.sequenceFlow:registWork(FightWorkFunction, arg_1_0.setOperationCount, arg_1_0, var_1_3, arg_1_1)
		arg_1_0.sequenceFlow:registWork(FightWorkPlayFakeStepTimeline, var_1_1, var_1_3)
	end
end

function var_0_0.setOperationCount(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1.playerOperationCountForPlayEffectTimeline = arg_2_2.playerOperationCountForPlayEffectTimeline
end

function var_0_0.buildOperationWorkList(arg_3_0)
	arg_3_0.timelineDic = {}
	arg_3_0.timelineOriginDic = {}

	local var_3_0 = GameUtil.splitString2(arg_3_0.paramsArr[2], false, ",", "#") or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = tonumber(iter_3_1[1])

		arg_3_0.timelineDic[var_3_1] = {}

		local var_3_2 = string.split(iter_3_1[2], "|")

		for iter_3_2, iter_3_3 in ipairs(var_3_2) do
			table.insert(arg_3_0.timelineDic[var_3_1], iter_3_3)
		end

		arg_3_0.timelineOriginDic[var_3_1] = FightDataUtil.copyData(arg_3_0.timelineDic[var_3_1])
	end

	local var_3_3 = arg_3_0.fightStepData.actEffect
	local var_3_4 = arg_3_0.sequenceFlow:registWork(FightWorkFlowParallel)

	arg_3_0.nuoDiKaTeamAttack = {}

	for iter_3_4, iter_3_5 in ipairs(var_3_3) do
		if iter_3_5.effectType == arg_3_0.effectType then
			local var_3_5 = var_3_4:registWork(FightWorkPlayEffectTimelineByOperation, iter_3_5, arg_3_0.paramsArr, arg_3_0.fightStepData, arg_3_0.timelineDic, arg_3_0.timelineOriginDic)

			table.insert(arg_3_0.operationWorkList, var_3_5)
		end

		if iter_3_5.effectType == FightEnum.EffectType.NUODIKATEAMATTACK then
			table.insert(arg_3_0.nuoDiKaTeamAttack, iter_3_5)
		end
	end
end

function var_0_0.onOperationForPlayEffect(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.effectType then
		return
	end

	arg_4_0.curCount = arg_4_0.curCount + 1

	local var_4_0 = arg_4_0.operationWorkList[arg_4_0.curCount]

	if var_4_0 then
		var_4_0:playTimeline()
		arg_4_0:com_replyMsg(FightMsgId.OperationForPlayEffect, arg_4_1)
	end
end

function var_0_0.playAllOperationWork(arg_5_0)
	if arg_5_0.paramsArr[7] == "0" then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.operationWorkList) do
			arg_5_0:com_sendFightEvent(FightEvent.PlayOnceQteWhenTimeout)
		end
	elseif arg_5_0.paramsArr[7] == "1" then
		local var_5_0 = tonumber(arg_5_0.paramsArr[4])
		local var_5_1 = arg_5_0:com_registFlowSequence()

		for iter_5_2, iter_5_3 in ipairs(arg_5_0.operationWorkList) do
			var_5_1:registWork(FightWorkDelayTimer, var_5_0)
			var_5_1:registWork(FightWorkFunction, arg_5_0.playOneTimeline, arg_5_0, iter_5_3)
		end

		var_5_1:start()
	else
		for iter_5_4, iter_5_5 in ipairs(arg_5_0.operationWorkList) do
			arg_5_0:com_sendFightEvent(FightEvent.PlayOnceQteWhenTimeout)
		end
	end
end

function var_0_0.playOneTimeline(arg_6_0, arg_6_1)
	arg_6_0:com_sendFightEvent(FightEvent.PlayOnceQteWhenTimeout)
end

function var_0_0.closeView(arg_7_0, arg_7_1)
	ViewMgr.instance:closeView(arg_7_1, true)
end

function var_0_0.onTrackEnd(arg_8_0)
	return
end

function var_0_0.onDestructor(arg_9_0)
	var_0_0.playing = false
end

return var_0_0
