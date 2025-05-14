﻿module("modules.logic.fight.model.data.FightStageMgr", package.seeall)

local var_0_0 = FightDataClass("FightStageMgr")

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
	PlaySeasonChangeHero = GameUtil.getEnumId()
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

function var_0_0.exitStage(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0 = #arg_7_0.stages, 1, -1 do
		if arg_7_1 == arg_7_0.stages[iter_7_0] then
			var_7_0 = iter_7_0

			break
		end
	end

	if not var_7_0 then
		return
	end

	if var_7_0 ~= #arg_7_0.stages then
		logError("退出阶段,但是栈结构被打乱了,请检查代码,退出的stage:" .. var_0_1[arg_7_1])
	end

	table.remove(arg_7_0.stages, var_7_0)

	return (table.remove(arg_7_0.stageParam, var_7_0))
end

function var_0_0.enterFightState(arg_8_0, arg_8_1, arg_8_2)
	table.insert(arg_8_0.fightStates, arg_8_1)

	arg_8_2 = arg_8_2 or 0

	table.insert(arg_8_0.fightStateParam, arg_8_2)
	FightController.instance:dispatchEvent(FightEvent.EnterFightState, arg_8_1, arg_8_2)
end

function var_0_0.exitFightState(arg_9_0, arg_9_1)
	local var_9_0

	for iter_9_0 = #arg_9_0.fightStates, 1, -1 do
		if arg_9_1 == arg_9_0.fightStates[iter_9_0] then
			var_9_0 = iter_9_0

			break
		end
	end

	if not var_9_0 then
		return
	end

	table.remove(arg_9_0.fightStates, var_9_0)

	local var_9_1 = table.remove(arg_9_0.fightStateParam, var_9_0)

	FightController.instance:dispatchEvent(FightEvent.ExitFightState, arg_9_1, var_9_1)
end

function var_0_0.enterOperateState(arg_10_0, arg_10_1, arg_10_2)
	table.insert(arg_10_0.operateStates, arg_10_1)

	arg_10_2 = arg_10_2 or 0

	table.insert(arg_10_0.operateParam, arg_10_2)
	FightController.instance:dispatchEvent(FightEvent.EnterOperateState, arg_10_1, arg_10_2)
end

function var_0_0.exitOperateState(arg_11_0, arg_11_1)
	local var_11_0

	for iter_11_0 = #arg_11_0.operateStates, 1, -1 do
		if arg_11_1 == arg_11_0.operateStates[iter_11_0] then
			var_11_0 = iter_11_0

			break
		end
	end

	if not var_11_0 then
		return
	end

	table.remove(arg_11_0.operateStates, var_11_0)

	local var_11_1 = table.remove(arg_11_0.operateParam, var_11_0)

	FightController.instance:dispatchEvent(FightEvent.ExitOperateState, arg_11_1, var_11_1)
end

function var_0_0.isEmptyOperateState(arg_12_0, arg_12_1)
	if #arg_12_0.operateStates == 0 then
		return true
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.operateStates) do
		if not arg_12_1 or not arg_12_1[iter_12_1] then
			return false
		end
	end

	return true
end

function var_0_0.inOperateState(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 and arg_13_2[arg_13_1] then
		return false
	end

	for iter_13_0 = #arg_13_0.operateStates, 1, -1 do
		if arg_13_1 == arg_13_0.operateStates[iter_13_0] then
			return true
		end
	end
end

function var_0_0.inFightState(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 and arg_14_2[arg_14_1] then
		return false
	end

	for iter_14_0 = #arg_14_0.fightStates, 1, -1 do
		if arg_14_1 == arg_14_0.fightStates[iter_14_0] then
			return true
		end
	end
end

function var_0_0.isNormalStage(arg_15_0)
	return arg_15_0:getCurStage() == var_0_0.StageType.Normal
end

function var_0_0.isPlayStage(arg_16_0)
	return arg_16_0:getCurStage() == var_0_0.StageType.Play
end

function var_0_0.inAutoFightState(arg_17_0)
	return arg_17_0:inFightState(var_0_0.FightStateType.Auto)
end

function var_0_0.isFree(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0:inReplay() then
		return
	end

	if not arg_18_0:isNormalStage() then
		return
	end

	if arg_18_0:inAutoFightState() then
		return
	end

	if arg_18_0:inFightState(var_0_0.FightStateType.OperationView2PlayView) then
		return
	end

	if arg_18_0:inFightState(var_0_0.FightStateType.SendOperation2Server) then
		return
	end

	if arg_18_0:inFightState(var_0_0.FightStateType.Enter) then
		return
	end

	if arg_18_0:inFightState(var_0_0.FightStateType.DouQuQu, arg_18_2) then
		return
	end

	if not arg_18_0:isEmptyOperateState(arg_18_1) then
		return
	end

	if #arg_18_0.dataMgr.operationMgr.operationStates > 0 then
		return
	end

	return true
end

function var_0_0.inReplay(arg_19_0)
	return arg_19_0:inFightState(var_0_0.FightStateType.Replay)
end

return var_0_0
