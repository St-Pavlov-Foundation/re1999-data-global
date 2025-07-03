module("modules.logic.fight.model.data.FightOperationStateMgr", package.seeall)

local var_0_0 = FightDataClass("FightOperationStateMgr", FightDataMgrBase)

var_0_0.StateType = {
	PlayHandCard = GameUtil.getEnumId(),
	PlayAssistBossCard = GameUtil.getEnumId(),
	PlayPlayerFinisherSkill = GameUtil.getEnumId(),
	MoveHandCard = GameUtil.getEnumId()
}

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.operationStates = {}
end

function var_0_0.onCancelOperation(arg_2_0)
	tabletool.clear(arg_2_0.operationStates)
end

function var_0_0.onStageChanged(arg_3_0)
	if #arg_3_0.operationStates > 0 then
		logError("战斗阶段改变了，但是操作状态列表中还有值，")
	end

	tabletool.clear(arg_3_0.operationStates)
end

function var_0_0.enterOperationState(arg_4_0, arg_4_1)
	table.insert(arg_4_0.operationStates, arg_4_1)
end

function var_0_0.exitOperationState(arg_5_0, arg_5_1)
	for iter_5_0 = #arg_5_0.operationStates, 1, -1 do
		if arg_5_0.operationStates[iter_5_0] == arg_5_1 then
			table.remove(arg_5_0.operationStates, iter_5_0)
		end
	end
end

return var_0_0
