module("modules.logic.fight.system.work.FightWorkPlayStart", package.seeall)

local var_0_0 = class("FightWorkPlayStart", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	if FightDataHelper.stateMgr.isReplay then
		FightReplayController.instance._replayErrorFix:startReplayErrorFix()
	end

	arg_1_0.roundData = FightDataHelper.roundMgr:getRoundData()

	local var_1_0 = arg_1_0:com_registFlowSequence()

	var_1_0:registWork(FightWorkSendEvent, FightEvent.OnStartSequenceStart)
	var_1_0:addWork(FightWorkDialogBeforeStartFight.New())
	var_1_0:addWork(FightWorkAppearPerformance.New())
	var_1_0:addWork(FightWorkDetectReplayEnterSceneActive.New())

	FightStartSequence.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWave, 1)

	if FightWorkFocusMonster.getFocusEntityId() or FightStartSequence.needStopMonsterWave then
		arg_1_0:_buildFocusBorn(var_1_0)
	else
		arg_1_0:_buildNormalBorn(var_1_0)
	end

	var_1_0:addWork(FightWorkCompareDataAfterPlay.New())
	var_1_0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	var_1_0:addWork(FunctionWork.New(function()
		local var_2_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_2_0)
	end))
	var_1_0:addWork(FunctionWork.New(function()
		FightRpc.instance:dealCardInfoPushData()
	end))
	var_1_0:addWork(FunctionWork.New(function()
		FightViewPartVisible.set(true, true, true, false, false)
	end))
	var_1_0:registFinishCallback(arg_1_0.onFlowFinish, arg_1_0)
	arg_1_0:playWorkAndDone(var_1_0, {})
end

function var_0_0.onFlowFinish(arg_5_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceFinish)
end

function var_0_0._buildFocusBorn(arg_6_0, arg_6_1)
	if FightStartSequence.needStopMonsterWave then
		arg_6_1:addWork(FunctionWork.New(function()
			arg_6_0:_setMonsterVisible(false)
		end))
	end

	arg_6_1:addWork(FightWorkStartBorn.New())

	if FightStartSequence.needStopMonsterWave then
		arg_6_1:addWork(FightWorkWaitDialog.New(1))
		arg_6_1:addWork(FunctionWork.New(function()
			arg_6_0:_setMonsterVisible(true)
		end))
	end

	arg_6_1:addWork(FightWorkFocusMonster.New())

	if FightModel.instance:getVersion() < 4 then
		arg_6_1:addWork(FightWork2Work.New(FightWorkDistributeCard))
	end

	arg_6_1:addWork(FunctionWork.New(arg_6_0._dealStartBuff))
	arg_6_1:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local var_6_0 = FightStepBuilder.buildStepWorkList(arg_6_0.roundData.fightStep)

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			arg_6_1:addWork(iter_6_1)
		end
	end

	arg_6_1:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))

	if FightController.instance:canOpenRoundView() then
		arg_6_1:addWork(FightWorkBeforeStartNoticeView.New())
	end

	local var_6_1 = arg_6_0:_buildRoundViewWork()

	if var_6_1 then
		arg_6_1:addWork(var_6_1)
	end
end

function var_0_0._buildNormalBorn(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:registWork(FightWorkFlowParallel)

	var_11_0:addWork(FightWorkStartBorn.New())

	local var_11_1 = var_11_0:registWork(FightWorkFlowSequence)

	var_11_1:addWork(WorkWaitSeconds.New(1.4 / FightModel.instance:getSpeed()))

	local var_11_2 = arg_11_0:_buildRoundViewWork()

	if var_11_2 then
		var_11_1:addWork(var_11_2)
		var_11_1:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getSpeed()))
	end

	if FightModel.instance:getVersion() < 4 then
		var_11_1:addWork(FightWork2Work.New(FightWorkDistributeCard))
	end

	arg_11_1:addWork(FunctionWork.New(arg_11_0._dealStartBuff))
	arg_11_1:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local var_11_3 = FightStepBuilder.buildStepWorkList(arg_11_0.roundData and arg_11_0.roundData.fightStep)

	if var_11_3 then
		for iter_11_0, iter_11_1 in ipairs(var_11_3) do
			arg_11_1:addWork(iter_11_1)
		end
	end

	if FightController.instance:canOpenRoundView() then
		arg_11_1:addWork(FightWorkBeforeStartNoticeView.New())
	end
end

function var_0_0._buildRoundViewWork(arg_13_0)
	if FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		return FunctionWork.New(function()
			FightController.instance:openRoundView()
		end)
	end
end

function var_0_0._dealStartBuff(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(FightHelper.getAllEntitys()) do
		if iter_15_1.buff then
			iter_15_1.buff:dealStartBuff()
		end
	end
end

function var_0_0._setMonsterVisible(arg_16_0, arg_16_1)
	local var_16_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		iter_16_1:setActive(arg_16_1)
	end
end

return var_0_0
