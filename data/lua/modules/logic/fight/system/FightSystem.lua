module("modules.logic.fight.system.FightSystem", package.seeall)

local var_0_0 = class("FightSystem")

function var_0_0.ctor(arg_1_0)
	arg_1_0._reconnectSequence = FightReconnectSequence.New()
	arg_1_0._startSequence = FightStartSequence.New()
	arg_1_0._roundSequence = FightRoundSequence.New()
	arg_1_0._clothSkillSequence = FightClothSkillSequence.New()
	arg_1_0._endSequence = FightEndSequence.New()
	arg_1_0._restartSequence = FightRestartSequence.New()
	arg_1_0._fastRestartSequence = FightFastRestartSequence.New()
end

function var_0_0.reconnectFight(arg_2_0)
	FightController.instance:setCurStage(FightEnum.Stage.StartRound)
	FightController.instance:dispatchEvent(FightEvent.OnFightReconnect)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		local var_2_0 = FightDataHelper.roundMgr:getRoundData()

		arg_2_0._reconnectSequence:buildFlow(var_2_0)
		arg_2_0._reconnectSequence:start(arg_2_0._onStartFinish, arg_2_0)
	end
end

function var_0_0.startFight(arg_3_0)
	FightController.instance:setCurStage(FightEnum.Stage.StartRound)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceStart)

	local var_3_0 = FightDataHelper.roundMgr:getRoundData()

	arg_3_0._startSequence:buildFlow(var_3_0)
	arg_3_0._startSequence:start(arg_3_0._onStartFinish, arg_3_0)
end

function var_0_0.restartFight(arg_4_0)
	var_0_0.instance.restarting = true

	arg_4_0._restartSequence:buildFlow()
	arg_4_0._restartSequence:start(arg_4_0._onRestartFightFinish, arg_4_0)
end

function var_0_0.cancelRestart(arg_5_0)
	arg_5_0._restartSequence:stop()
	arg_5_0._restartSequence:dispose()

	var_0_0.instance.restarting = false
end

function var_0_0._onRestartFightFinish(arg_6_0)
	var_0_0.instance.restarting = false
end

function var_0_0.restartFightFail(arg_7_0)
	ToastController.instance:showToast(-80)
	arg_7_0:cancelRestart()
	FightController.instance:exitFightScene()
end

function var_0_0.startRound(arg_8_0)
	FightController.instance:setCurStage(FightEnum.Stage.Play)
	FightController.instance:dispatchEvent(FightEvent.OnRoundSequenceStart)

	local var_8_0 = FightDataHelper.roundMgr:getRoundData()

	arg_8_0._roundSequence:buildFlow(var_8_0)
	FightMgr.instance:enterStage(FightStageMgr.StageType.Play, FightStageMgr.PlayType.Normal)
	arg_8_0._roundSequence:start(arg_8_0._onRoundFinish, arg_8_0)
end

function var_0_0.startClothSkillRound(arg_9_0)
	arg_9_0._beforeClothSkillStage = FightModel.instance:getCurStage()

	FightController.instance:setCurStage(FightEnum.Stage.ClothSkill)

	local var_9_0 = FightDataHelper.roundMgr:getRoundData()

	arg_9_0._clothSkillSequence:buildFlow(var_9_0)
	FightMgr.instance:enterStage(FightStageMgr.StageType.Play, FightStageMgr.PlayType.ClothSkill)
	arg_9_0._clothSkillSequence:start(arg_9_0._onClothSkillRoundFinish, arg_9_0)
end

function var_0_0.endFight(arg_10_0)
	FightController.instance:setCurStage(FightEnum.Stage.EndRound)
	arg_10_0._startSequence:stop()
	arg_10_0._roundSequence:stop()
	arg_10_0._clothSkillSequence:stop()

	if var_0_0.instance.restarting then
		return
	end

	if FightRestartHelper.tryRestart() then
		return
	end

	arg_10_0._endSequence:buildFlow()
	arg_10_0._endSequence:start(arg_10_0._onEndFinish, arg_10_0)
end

function var_0_0._onRestart(arg_11_0)
	var_0_0.instance.restarting = true

	arg_11_0._fastRestartSequence:buildFlow()
	arg_11_0._fastRestartSequence:start(arg_11_0._onRestartFightFinish, arg_11_0)
end

function var_0_0._onEndFight(arg_12_0)
	arg_12_0._endSequence:buildFlow()
	arg_12_0._endSequence:start(arg_12_0._onEndFinish, arg_12_0)
end

function var_0_0._onStartFinish(arg_13_0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)

	if FightModel.instance:isAuto() then
		FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
	else
		FightController.instance:setCurStage(FightEnum.Stage.Card)
	end

	FightViewPartVisible.set(true, true, true, false, false)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceFinish)
end

function var_0_0.getReconnectSequence(arg_14_0)
	return arg_14_0._reconnectSequence
end

function var_0_0.getStartSequence(arg_15_0)
	return arg_15_0._startSequence
end

function var_0_0.getRoundSequence(arg_16_0)
	return arg_16_0._roundSequence
end

function var_0_0.getClothSkillSequence(arg_17_0)
	return arg_17_0._clothSkillSequence
end

function var_0_0.getEndSequence(arg_18_0)
	return arg_18_0._endSequence
end

function var_0_0.getRestartSequence(arg_19_0)
	return arg_19_0._restartSequence
end

function var_0_0._onRoundFinish(arg_20_0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)
	FightModel.instance:onEndRound()

	if not FightModel.instance:isFinish() then
		if FightModel.instance:isAuto() then
			FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
		else
			FightController.instance:setCurStage(FightEnum.Stage.Card)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnRoundSequenceFinish)
end

function var_0_0._onClothSkillRoundFinish(arg_21_0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)
	FightController.instance:setCurStage(arg_21_0._beforeClothSkillStage)

	local var_21_0 = FightModel.instance:getCurStage()

	if var_21_0 == FightEnum.Stage.Card or var_21_0 == FightEnum.Stage.AutoCard then
		FightViewPartVisible.set(true, true, true, false, false)
	end

	FightController.instance:dispatchEvent(FightEvent.OnClothSkillRoundSequenceFinish)
end

function var_0_0._onEndFinish(arg_22_0)
	FightController.instance:setCurStage(FightEnum.Stage.End)
	FightController.instance:dispatchEvent(FightEvent.OnEndSequenceFinish)
end

function var_0_0.dispose(arg_23_0)
	arg_23_0._reconnectSequence:stop()
	arg_23_0._startSequence:stop()
	arg_23_0._roundSequence:stop()
	arg_23_0._clothSkillSequence:stop()
	arg_23_0._endSequence:stop()
	arg_23_0._reconnectSequence:dispose()
	arg_23_0._startSequence:dispose()
	arg_23_0._roundSequence:dispose()
	arg_23_0._clothSkillSequence:dispose()
	arg_23_0._endSequence:dispose()
	FightPlayCardModel.instance:onEndRound()
	FightModel.instance:clear()
	FightModel.instance:setCurStage(nil)
end

function var_0_0.dumpStates(arg_24_0)
	arg_24_0:_dumpSequence(arg_24_0._reconnectSequence, "reconnectSequence")
	arg_24_0:_dumpSequence(arg_24_0._startSequence, "startSequence")
	arg_24_0:_dumpSequence(arg_24_0._roundSequence, "roundSequence")
	arg_24_0:_dumpSequence(arg_24_0._clothSkillSequence, "clothSkillSequence")
	arg_24_0:_dumpSequence(arg_24_0._endSequence, "endSequence")
end

function var_0_0._dumpSequence(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1._sequence and arg_25_1._sequence.status == WorkStatus.Running then
		local var_25_0 = {
			arg_25_2
		}
		local var_25_1 = arg_25_1._sequence

		if var_25_1 then
			arg_25_0:_getWorks(var_25_1, var_25_0, 0)
		end

		logError(table.concat(var_25_0, "\n"))
	end
end

function var_0_0._getWorks(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = ""

	for iter_26_0 = 1, arg_26_3 do
		var_26_0 = var_26_0 .. "  "
	end

	local var_26_1 = var_26_0 .. arg_26_1.__cname

	if arg_26_1.status == WorkStatus.Running then
		var_26_1 = var_26_1 .. "(running)"
	end

	table.insert(arg_26_2, var_26_1)

	if isTypeOf(arg_26_1, FlowSequence) then
		local var_26_2 = arg_26_1._workList

		for iter_26_1, iter_26_2 in ipairs(var_26_2) do
			arg_26_0:_getWorks(iter_26_2, arg_26_2, arg_26_3 + 1)
		end
	elseif isTypeOf(arg_26_1, FlowParallel) then
		local var_26_3 = arg_26_1._workList

		for iter_26_3, iter_26_4 in ipairs(var_26_3) do
			arg_26_0:_getWorks(iter_26_4, arg_26_2, arg_26_3 + 1)
		end
	elseif isTypeOf(arg_26_1, FightSkillFlow) and arg_26_1._sequence then
		arg_26_0:_getWorks(arg_26_1._sequence, arg_26_2, arg_26_3 + 1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
