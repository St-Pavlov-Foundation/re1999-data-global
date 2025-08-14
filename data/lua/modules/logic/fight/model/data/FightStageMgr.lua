module("modules.logic.fight.model.data.FightStageMgr", package.seeall)

local var_0_0 = FightDataClass("FightStageMgr", FightDataMgrBase)

var_0_0.StageType = {
	Normal = GameUtil.getEnumId(),
	Play = GameUtil.getEnumId(),
	End = GameUtil.getEnumId()
}
var_0_0.PlayType = {
	ClothSkill = 2,
	Normal = 1
}
var_0_0.FightStateType = {
	Enter = GameUtil.getEnumId(),
	Auto = GameUtil.getEnumId(),
	Replay = GameUtil.getEnumId(),
	DouQuQu = GameUtil.getEnumId(),
	Season2AutoChangeHero = GameUtil.getEnumId(),
	Distribute1Card = GameUtil.getEnumId(),
	OperationView2PlayView = GameUtil.getEnumId(),
	SendOperation2Server = GameUtil.getEnumId(),
	PlaySeasonChangeHero = GameUtil.getEnumId(),
	AiJiAoQteIng = GameUtil.getEnumId()
}
var_0_0.OperateStateType = {
	Discard = GameUtil.getEnumId(),
	DiscardEffect = GameUtil.getEnumId(),
	SeasonChangeHero = GameUtil.getEnumId(),
	BindContract = GameUtil.getEnumId()
}

local var_0_1 = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.StageType) do
	var_0_1[iter_0_1] = iter_0_0
end

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.stages = {}
	arg_1_0.stageParam = {}
	arg_1_0.operateStates = {}
	arg_1_0.operateParam = {}
	arg_1_0.fightStates = {}
	arg_1_0.fightStateParam = {}
end

function var_0_0.getStages(arg_2_0)
	return arg_2_0.stages
end

function var_0_0.getCurStage(arg_3_0)
	return arg_3_0.stages[#arg_3_0.stages]
end

function var_0_0.getCurOperateState(arg_4_0)
	return arg_4_0.operateStates[#arg_4_0.operateStates]
end

function var_0_0.getCurOperateParam(arg_5_0)
	return arg_5_0.operateParam[#arg_5_0.operateParam]
end

function var_0_0.enterStage(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0 = #arg_6_0.stages, 1, -1 do
		if arg_6_1 == arg_6_0.stages[iter_6_0] then
			arg_6_0.stageParam[iter_6_0] = arg_6_2 or 0

			return
		end
	end

	table.insert(arg_6_0.stages, arg_6_1)

	arg_6_2 = arg_6_2 or 0

	table.insert(arg_6_0.stageParam, arg_6_2)
end

function var_0_0.getCurStageParam(arg_7_0)
	return arg_7_0.stageParam[#arg_7_0.stageParam]
end

function var_0_0.exitStage(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0 = #arg_8_0.stages, 1, -1 do
		if arg_8_1 == arg_8_0.stages[iter_8_0] then
			var_8_0 = iter_8_0

			break
		end
	end

	if not var_8_0 then
		return
	end

	if var_8_0 ~= #arg_8_0.stages then
		logError("退出阶段,但是栈结构被打乱了,请检查代码,退出的stage:" .. var_0_1[arg_8_1])
	end

	table.remove(arg_8_0.stages, var_8_0)

	return (table.remove(arg_8_0.stageParam, var_8_0))
end

function var_0_0.enterFightState(arg_9_0, arg_9_1, arg_9_2)
	table.insert(arg_9_0.fightStates, arg_9_1)

	arg_9_2 = arg_9_2 or 0

	table.insert(arg_9_0.fightStateParam, arg_9_2)
	FightController.instance:dispatchEvent(FightEvent.EnterFightState, arg_9_1, arg_9_2)
end

function var_0_0.exitFightState(arg_10_0, arg_10_1)
	local var_10_0

	for iter_10_0 = #arg_10_0.fightStates, 1, -1 do
		if arg_10_1 == arg_10_0.fightStates[iter_10_0] then
			var_10_0 = iter_10_0

			break
		end
	end

	if not var_10_0 then
		return
	end

	table.remove(arg_10_0.fightStates, var_10_0)

	local var_10_1 = table.remove(arg_10_0.fightStateParam, var_10_0)

	FightController.instance:dispatchEvent(FightEvent.ExitFightState, arg_10_1, var_10_1)
end

function var_0_0.enterOperateState(arg_11_0, arg_11_1, arg_11_2)
	table.insert(arg_11_0.operateStates, arg_11_1)

	arg_11_2 = arg_11_2 or 0

	table.insert(arg_11_0.operateParam, arg_11_2)
	FightController.instance:dispatchEvent(FightEvent.EnterOperateState, arg_11_1, arg_11_2)
end

function var_0_0.exitOperateState(arg_12_0, arg_12_1)
	local var_12_0

	for iter_12_0 = #arg_12_0.operateStates, 1, -1 do
		if arg_12_1 == arg_12_0.operateStates[iter_12_0] then
			var_12_0 = iter_12_0

			break
		end
	end

	if not var_12_0 then
		return
	end

	table.remove(arg_12_0.operateStates, var_12_0)

	local var_12_1 = table.remove(arg_12_0.operateParam, var_12_0)

	FightController.instance:dispatchEvent(FightEvent.ExitOperateState, arg_12_1, var_12_1)
end

function var_0_0.isEmptyOperateState(arg_13_0, arg_13_1)
	if #arg_13_0.operateStates == 0 then
		return true
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.operateStates) do
		if not arg_13_1 or not arg_13_1[iter_13_1] then
			return false
		end
	end

	return true
end

function var_0_0.inOperateState(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 and arg_14_2[arg_14_1] then
		return false
	end

	for iter_14_0 = #arg_14_0.operateStates, 1, -1 do
		if arg_14_1 == arg_14_0.operateStates[iter_14_0] then
			return true
		end
	end
end

function var_0_0.inFightState(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 and arg_15_2[arg_15_1] then
		return false
	end

	for iter_15_0 = #arg_15_0.fightStates, 1, -1 do
		if arg_15_1 == arg_15_0.fightStates[iter_15_0] then
			return true
		end
	end
end

function var_0_0.isNormalStage(arg_16_0)
	return arg_16_0:getCurStage() == var_0_0.StageType.Normal
end

function var_0_0.isPlayStage(arg_17_0)
	return arg_17_0:getCurStage() == var_0_0.StageType.Play
end

function var_0_0.inAutoFightState(arg_18_0)
	return arg_18_0:inFightState(var_0_0.FightStateType.Auto)
end

function var_0_0.isFree(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0:inReplay() then
		return
	end

	if not arg_19_0:isNormalStage() then
		return
	end

	if arg_19_0:inAutoFightState() then
		return
	end

	if arg_19_0:inFightState(var_0_0.FightStateType.OperationView2PlayView) then
		return
	end

	if arg_19_0:inFightState(var_0_0.FightStateType.SendOperation2Server) then
		return
	end

	if arg_19_0:inFightState(var_0_0.FightStateType.Enter) then
		return
	end

	if arg_19_0:inFightState(var_0_0.FightStateType.DouQuQu, arg_19_2) then
		return
	end

	if not arg_19_0:isEmptyOperateState(arg_19_1) then
		return
	end

	if #arg_19_0.dataMgr.operationStateMgr.operationStates > 0 then
		return
	end

	return true
end

function var_0_0.inReplay(arg_20_0)
	return arg_20_0:inFightState(var_0_0.FightStateType.Replay)
end

return var_0_0
