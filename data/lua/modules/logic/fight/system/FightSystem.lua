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

function var_0_0.directStartNewFight(arg_13_0)
	if arg_13_0.directStartNewFightWork then
		arg_13_0.directStartNewFightWork:disposeSelf()
	end

	arg_13_0.directStartNewFightWork = FightWorkDirectStartNewFightAfterEndFight.New()

	arg_13_0.directStartNewFightWork:start()
end

function var_0_0.clearDirectStartNewFightWork(arg_14_0)
	if arg_14_0.directStartNewFightWork then
		arg_14_0.directStartNewFightWork:disposeSelf()

		arg_14_0.directStartNewFightWork = nil
	end
end

function var_0_0._onStartFinish(arg_15_0)
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

function var_0_0.getReconnectSequence(arg_16_0)
	return arg_16_0._reconnectSequence
end

function var_0_0.getStartSequence(arg_17_0)
	return arg_17_0._startSequence
end

function var_0_0.getRoundSequence(arg_18_0)
	return arg_18_0._roundSequence
end

function var_0_0.getClothSkillSequence(arg_19_0)
	return arg_19_0._clothSkillSequence
end

function var_0_0.getEndSequence(arg_20_0)
	return arg_20_0._endSequence
end

function var_0_0.getRestartSequence(arg_21_0)
	return arg_21_0._restartSequence
end

function var_0_0._onRoundFinish(arg_22_0)
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

function var_0_0._onClothSkillRoundFinish(arg_23_0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)

	if not FightModel.instance:isFinish() then
		if FightModel.instance:isAuto() then
			FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
		else
			FightController.instance:setCurStage(FightEnum.Stage.Card)
		end
	end

	local var_23_0 = FightModel.instance:getCurStage()

	if var_23_0 == FightEnum.Stage.Card or var_23_0 == FightEnum.Stage.AutoCard then
		FightViewPartVisible.set(true, true, true, false, false)
	end

	FightController.instance:dispatchEvent(FightEvent.OnClothSkillRoundSequenceFinish)
end

function var_0_0._onEndFinish(arg_24_0)
	FightController.instance:setCurStage(FightEnum.Stage.End)
	FightController.instance:dispatchEvent(FightEvent.OnEndSequenceFinish)
end

function var_0_0.dispose(arg_25_0)
	arg_25_0._reconnectSequence:stop()
	arg_25_0._startSequence:stop()
	arg_25_0._roundSequence:stop()
	arg_25_0._clothSkillSequence:stop()
	arg_25_0._endSequence:stop()
	arg_25_0._reconnectSequence:dispose()
	arg_25_0._startSequence:dispose()
	arg_25_0._roundSequence:dispose()
	arg_25_0._clothSkillSequence:dispose()
	arg_25_0._endSequence:dispose()
	FightPlayCardModel.instance:onEndRound()
	FightModel.instance:clear()
	FightModel.instance:setCurStage(nil)
end

function var_0_0.dumpStates(arg_26_0)
	arg_26_0:_dumpSequence(arg_26_0._reconnectSequence, "reconnectSequence")
	arg_26_0:_dumpSequence(arg_26_0._startSequence, "startSequence")
	arg_26_0:_dumpSequence(arg_26_0._roundSequence, "roundSequence")
	arg_26_0:_dumpSequence(arg_26_0._clothSkillSequence, "clothSkillSequence")
	arg_26_0:_dumpSequence(arg_26_0._endSequence, "endSequence")
end

function var_0_0._dumpSequence(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1._sequence and arg_27_1._sequence.status == WorkStatus.Running then
		local var_27_0 = {
			arg_27_2
		}
		local var_27_1 = arg_27_1._sequence

		if var_27_1 then
			arg_27_0:_getWorks(var_27_1, var_27_0, 0)
		end

		logError(table.concat(var_27_0, "\n"))
	end
end

function var_0_0._getWorks(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = ""

	for iter_28_0 = 1, arg_28_3 do
		var_28_0 = var_28_0 .. "  "
	end

	local var_28_1 = var_28_0 .. arg_28_1.__cname

	if arg_28_1.status == WorkStatus.Running then
		var_28_1 = var_28_1 .. "(running)"
	end

	table.insert(arg_28_2, var_28_1)

	if isTypeOf(arg_28_1, FlowSequence) then
		local var_28_2 = arg_28_1._workList

		for iter_28_1, iter_28_2 in ipairs(var_28_2) do
			arg_28_0:_getWorks(iter_28_2, arg_28_2, arg_28_3 + 1)
		end
	elseif isTypeOf(arg_28_1, FlowParallel) then
		local var_28_3 = arg_28_1._workList

		for iter_28_3, iter_28_4 in ipairs(var_28_3) do
			arg_28_0:_getWorks(iter_28_4, arg_28_2, arg_28_3 + 1)
		end
	elseif isTypeOf(arg_28_1, FightSkillFlow) and arg_28_1._sequence then
		arg_28_0:_getWorks(arg_28_1._sequence, arg_28_2, arg_28_3 + 1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
