module("modules.logic.fight.system.flow.FightStartSequence", package.seeall)

local var_0_0 = class("FightStartSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0, arg_1_1)
	var_0_0.super.buildFlow(arg_1_0)

	arg_1_0.roundData = arg_1_1

	arg_1_0:_buildStartRoundSteps()
end

function var_0_0._buildStartRoundSteps(arg_2_0)
	arg_2_0:addWork(FightWorkDialogBeforeStartFight.New())
	arg_2_0:addWork(FightWorkAppearPerformance.New())
	arg_2_0:addWork(FightWorkDetectReplayEnterSceneActive.New())

	var_0_0.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWave, 1)

	if FightWorkFocusMonster.getFocusEntityId() or var_0_0.needStopMonsterWave then
		arg_2_0:_buildFocusBorn()
	else
		arg_2_0:_buildNormalBorn()
	end

	arg_2_0:addWork(FightWorkCompareDataAfterPlay.New())
	arg_2_0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	arg_2_0:addWork(FunctionWork.New(function()
		local var_3_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_3_0)
	end))
	arg_2_0:addWork(FunctionWork.New(function()
		FightRpc.instance:dealCardInfoPushData()
	end))
	arg_2_0:addWork(FunctionWork.New(function()
		FightViewPartVisible.set(true, true, true, false, false)
	end))
end

function var_0_0._buildFocusBorn(arg_6_0)
	if var_0_0.needStopMonsterWave then
		arg_6_0:addWork(FunctionWork.New(function()
			arg_6_0:_setMonsterVisible(false)
		end))
	end

	arg_6_0:addWork(FightWorkStartBorn.New())

	if var_0_0.needStopMonsterWave then
		arg_6_0:addWork(FightWorkWaitDialog.New(1))
		arg_6_0:addWork(FunctionWork.New(function()
			arg_6_0:_setMonsterVisible(true)
		end))
	end

	arg_6_0:addWork(FightWorkFocusMonster.New())

	if FightModel.instance:getVersion() < 4 then
		arg_6_0:addWork(FightWorkDistributeCard.New())
		arg_6_0:addWork(FunctionWork.New(function()
			FightController.instance:setCurStage(FightEnum.Stage.StartRound)
		end))
	end

	arg_6_0:addWork(FunctionWork.New(arg_6_0._dealStartBuff))
	arg_6_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local var_6_0 = FightStepBuilder.buildStepWorkList(arg_6_0.roundData.fightStep)

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			arg_6_0:addWork(iter_6_1)
		end
	end

	arg_6_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))

	if FightController.instance:canOpenRoundView() then
		arg_6_0:addWork(FightWorkBeforeStartNoticeView.New())
	end

	local var_6_1 = arg_6_0:_buildRoundViewWork()

	if var_6_1 then
		arg_6_0:addWork(var_6_1)
	end
end

function var_0_0._buildNormalBorn(arg_12_0)
	local var_12_0 = FlowParallel.New()

	var_12_0:addWork(FightWorkStartBorn.New())

	local var_12_1 = FlowSequence.New()

	var_12_0:addWork(var_12_1)
	arg_12_0:addWork(var_12_0)
	var_12_1:addWork(WorkWaitSeconds.New(1.4 / FightModel.instance:getSpeed()))

	local var_12_2 = arg_12_0:_buildRoundViewWork()

	if var_12_2 then
		var_12_1:addWork(var_12_2)
		var_12_1:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getSpeed()))
	end

	if FightModel.instance:getVersion() < 4 then
		var_12_1:addWork(FightWorkDistributeCard.New())
		arg_12_0:addWork(FunctionWork.New(function()
			FightController.instance:setCurStage(FightEnum.Stage.StartRound)
		end))
	end

	arg_12_0:addWork(FunctionWork.New(arg_12_0._dealStartBuff))
	arg_12_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local var_12_3 = FightStepBuilder.buildStepWorkList(arg_12_0.roundData and arg_12_0.roundData.fightStep)

	if var_12_3 then
		for iter_12_0, iter_12_1 in ipairs(var_12_3) do
			arg_12_0:addWork(iter_12_1)
		end
	end

	if FightController.instance:canOpenRoundView() then
		arg_12_0:addWork(FightWorkBeforeStartNoticeView.New())
	end
end

function var_0_0._buildRoundViewWork(arg_15_0)
	if FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		return FunctionWork.New(function()
			FightController.instance:openRoundView()
		end)
	end
end

function var_0_0._dealStartBuff(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(FightHelper.getAllEntitys()) do
		if iter_17_1.buff then
			iter_17_1.buff:dealStartBuff()
		end
	end
end

function var_0_0._setMonsterVisible(arg_18_0, arg_18_1)
	local var_18_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		iter_18_1:setActive(arg_18_1)
	end
end

return var_0_0
