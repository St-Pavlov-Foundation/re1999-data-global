module("modules.logic.fight.model.data.FightStageMgr", package.seeall)

local var_0_0 = FightDataClass("FightStageMgr", FightDataMgrBase)

var_0_0.StageType = {
	Operate = GameUtil.getEnumId(),
	Play = GameUtil.getEnumId()
}
var_0_0.FightStateType = {
	Enter = GameUtil.getEnumId(),
	DouQuQu = GameUtil.getEnumId(),
	Season2AutoChangeHero = GameUtil.getEnumId(),
	DistributeCard = GameUtil.getEnumId(),
	Distribute1Card = GameUtil.getEnumId(),
	OperationView2PlayView = GameUtil.getEnumId(),
	SendOperation2Server = GameUtil.getEnumId(),
	PlaySeasonChangeHero = GameUtil.getEnumId(),
	ClothSkill = GameUtil.getEnumId(),
	AutoCardPlaying = GameUtil.getEnumId(),
	AiJiAoQteIng = GameUtil.getEnumId()
}
var_0_0.OperateStateType = {
	Discard = GameUtil.getEnumId(),
	DiscardEffect = GameUtil.getEnumId(),
	SeasonChangeHero = GameUtil.getEnumId(),
	BindContract = GameUtil.getEnumId()
}

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.curStage = nil
	arg_1_0.operateStates = {}
	arg_1_0.operateParam = {}
	arg_1_0.fightStates = {}
	arg_1_0.fightStateParam = {}
end

function var_0_0.getCurStage(arg_2_0)
	return arg_2_0.curStage
end

function var_0_0.setStage(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.curStage

	arg_3_0.curStage = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(FightDataMgr.instance.mgrList) do
		iter_3_1:onStageChanged(arg_3_1, var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(FightLocalDataMgr.instance.mgrList) do
		iter_3_3:onStageChanged(arg_3_1, var_3_0)
	end

	arg_3_0:com_sendFightEvent(FightEvent.StageChanged, arg_3_1, var_3_0)
end

function var_0_0.getCurOperateState(arg_4_0)
	return arg_4_0.operateStates[#arg_4_0.operateStates]
end

function var_0_0.getCurOperateParam(arg_5_0)
	return arg_5_0.operateParam[#arg_5_0.operateParam]
end

function var_0_0.enterFightState(arg_6_0, arg_6_1, arg_6_2)
	table.insert(arg_6_0.fightStates, arg_6_1)

	arg_6_2 = arg_6_2 or 0

	table.insert(arg_6_0.fightStateParam, arg_6_2)
	FightController.instance:dispatchEvent(FightEvent.EnterFightState, arg_6_1, arg_6_2)
end

function var_0_0.exitFightState(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0 = #arg_7_0.fightStates, 1, -1 do
		if arg_7_1 == arg_7_0.fightStates[iter_7_0] then
			var_7_0 = iter_7_0

			break
		end
	end

	if not var_7_0 then
		return
	end

	table.remove(arg_7_0.fightStates, var_7_0)

	local var_7_1 = table.remove(arg_7_0.fightStateParam, var_7_0)

	FightController.instance:dispatchEvent(FightEvent.ExitFightState, arg_7_1, var_7_1)
end

function var_0_0.enterOperateState(arg_8_0, arg_8_1, arg_8_2)
	table.insert(arg_8_0.operateStates, arg_8_1)

	arg_8_2 = arg_8_2 or 0

	table.insert(arg_8_0.operateParam, arg_8_2)
	FightController.instance:dispatchEvent(FightEvent.EnterOperateState, arg_8_1, arg_8_2)
end

function var_0_0.exitOperateState(arg_9_0, arg_9_1)
	local var_9_0

	for iter_9_0 = #arg_9_0.operateStates, 1, -1 do
		if arg_9_1 == arg_9_0.operateStates[iter_9_0] then
			var_9_0 = iter_9_0

			break
		end
	end

	if not var_9_0 then
		return
	end

	table.remove(arg_9_0.operateStates, var_9_0)

	local var_9_1 = table.remove(arg_9_0.operateParam, var_9_0)

	FightController.instance:dispatchEvent(FightEvent.ExitOperateState, arg_9_1, var_9_1)
end

function var_0_0.isEmptyOperateState(arg_10_0, arg_10_1)
	if #arg_10_0.operateStates == 0 then
		return true
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.operateStates) do
		if not arg_10_1 or not arg_10_1[iter_10_1] then
			return false
		end
	end

	return true
end

function var_0_0.inOperateState(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 and arg_11_2[arg_11_1] then
		return false
	end

	for iter_11_0 = #arg_11_0.operateStates, 1, -1 do
		if arg_11_1 == arg_11_0.operateStates[iter_11_0] then
			return true
		end
	end
end

function var_0_0.inFightState(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 and arg_12_2[arg_12_1] then
		return false
	end

	for iter_12_0 = #arg_12_0.fightStates, 1, -1 do
		if arg_12_1 == arg_12_0.fightStates[iter_12_0] then
			return true
		end
	end
end

function var_0_0.isOperateStage(arg_13_0)
	return arg_13_0:getCurStage() == var_0_0.StageType.Operate
end

function var_0_0.isPlayStage(arg_14_0)
	return arg_14_0:getCurStage() == var_0_0.StageType.Play
end

function var_0_0.isFree(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.dataMgr.stateMgr.isReplay then
		return
	end

	if not arg_15_0:isOperateStage() then
		return
	end

	if arg_15_0.dataMgr.stateMgr.isAuto then
		return
	end

	if arg_15_0:inFightState(var_0_0.FightStateType.OperationView2PlayView) then
		return
	end

	if arg_15_0:inFightState(var_0_0.FightStateType.SendOperation2Server) then
		return
	end

	if arg_15_0:inFightState(var_0_0.FightStateType.Enter) then
		return
	end

	if arg_15_0:inFightState(var_0_0.FightStateType.DouQuQu, arg_15_2) then
		return
	end

	if not arg_15_0:isEmptyOperateState(arg_15_1) then
		return
	end

	return true
end

return var_0_0
