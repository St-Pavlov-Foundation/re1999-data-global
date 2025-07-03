module("modules.logic.fight.entity.comp.skill.FightTLEventPlayEffectByOperation", package.seeall)

local var_0_0 = class("FightTLEventPlayEffectByOperation", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.curCount = 0
	arg_1_0.operationWorkList = {}

	FightController.instance:registerCallback(FightEvent.OperationForPlayEffect, arg_1_0.onOperationForPlayEffect, arg_1_0)

	arg_1_0.fightStepData = arg_1_1
	arg_1_0.paramsArr = arg_1_3
	arg_1_0.effectType = tonumber(arg_1_0.paramsArr[1])

	local var_1_0 = ({
		[-666] = "GMFightNuoDiKaXianJieAnNiu"
	})[arg_1_0.effectType]

	if var_1_0 then
		ViewMgr.instance:openView(var_1_0, {
			effectType = arg_1_0.effectType,
			timeLimit = tonumber(arg_1_0.paramsArr[4])
		})
	end

	arg_1_0.sequenceFlow = FightWorkFlowSequence.New()

	arg_1_0.timelineItem:addWork2FinishWork(arg_1_0.sequenceFlow)
	arg_1_0:buildOperationWorkList()
	TaskDispatcher.runDelay(arg_1_0.playAllOperationWork, arg_1_0, tonumber(arg_1_0.paramsArr[3]))
	arg_1_0.sequenceFlow:registWork(FightWorkFunction, arg_1_0.clearEvent, arg_1_0)

	if var_1_0 then
		arg_1_0.sequenceFlow:registWork(FightWorkFunction, arg_1_0.closeView, arg_1_0, var_1_0)
	end

	local var_1_1 = arg_1_0.paramsArr[6]

	if not string.nilorempty(var_1_1) then
		local var_1_2 = tonumber(arg_1_0.paramsArr[5])

		arg_1_0.sequenceFlow:registWork(FightWorkDelayTimer, var_1_2)
		arg_1_0.sequenceFlow:registWork(FightWorkPlayFakeStepTimeline, var_1_1, arg_1_1)
	end
end

function var_0_0.buildOperationWorkList(arg_2_0)
	arg_2_0.timelineDic = {}

	local var_2_0 = GameUtil.splitString2(arg_2_0.paramsArr[2], false, ",", "#")

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = tonumber(iter_2_1[1])

		arg_2_0.timelineDic[var_2_1] = {}

		local var_2_2 = string.split(iter_2_1[2], "|")

		for iter_2_2, iter_2_3 in ipairs(var_2_2) do
			table.insert(arg_2_0.timelineDic[var_2_1], iter_2_3)
		end
	end

	local var_2_3 = arg_2_0.fightStepData.actEffect
	local var_2_4 = arg_2_0.sequenceFlow:registWork(FightWorkFlowParallel)

	for iter_2_4, iter_2_5 in ipairs(var_2_3) do
		if iter_2_5.effectType == arg_2_0.effectType then
			local var_2_5 = var_2_4:registWork(FightWorkPlayEffectTimelineByOperation, iter_2_5, arg_2_0.paramsArr, arg_2_0.fightStepData, arg_2_0.timelineDic)

			table.insert(arg_2_0.operationWorkList, var_2_5)
		end
	end
end

function var_0_0.clearEvent(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.playAllOperationWork, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OperationForPlayEffect, arg_3_0.onOperationForPlayEffect, arg_3_0)
end

function var_0_0.onOperationForPlayEffect(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.effectType then
		return
	end

	arg_4_0.curCount = arg_4_0.curCount + 1

	local var_4_0 = arg_4_0.operationWorkList[arg_4_0.curCount]

	if var_4_0 then
		var_4_0:playTimeline()
	end
end

function var_0_0.playAllOperationWork(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.operationWorkList) do
		iter_5_1:playTimeline()
	end
end

function var_0_0.closeView(arg_6_0, arg_6_1)
	ViewMgr.instance:closeView(arg_6_1, true)
end

function var_0_0.onTrackEnd(arg_7_0)
	return
end

function var_0_0.onDestructor(arg_8_0)
	return
end

return var_0_0
