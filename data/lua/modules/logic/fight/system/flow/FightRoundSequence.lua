module("modules.logic.fight.system.flow.FightRoundSequence", package.seeall)

local var_0_0 = class("FightRoundSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0, arg_1_1)
	var_0_0.super.buildFlow(arg_1_0)

	arg_1_0.roundData = arg_1_1

	arg_1_0:buildRoundFlows()
end

function var_0_0.stop(arg_2_0)
	var_0_0.super.stop(arg_2_0)

	if arg_2_0._skillFlowList then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._skillFlowList) do
			iter_2_1:stopSkillFlow()
		end
	end
end

var_0_0.roundTempData = {}

function var_0_0.buildRoundFlows(arg_3_0)
	var_0_0.roundTempData = {}

	arg_3_0:addWork(WorkWaitSeconds.New(0.01))
	arg_3_0:addWork(FightWork2Work.New(FightWorkDialogueBeforeRoundStart))
	arg_3_0:addWork(FightWorkRoundStart.New())

	local var_3_0, var_3_1 = FightStepBuilder.buildStepWorkList(arg_3_0.roundData and arg_3_0.roundData.fightStep)

	arg_3_0._skillFlowList = var_3_1

	if not var_3_0 or #var_3_0 == 0 then
		return
	end

	local var_3_2 = 1

	while var_3_2 <= #var_3_0 do
		local var_3_3 = var_3_0[var_3_2]

		var_3_2 = var_3_2 + 1

		arg_3_0:addWork(var_3_3)
	end

	arg_3_0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	arg_3_0:addWork(FightWorkWaitForSkillsDone.New(arg_3_0._skillFlowList))
	arg_3_0:addWork(FightWorkRoundEnd.New())
	arg_3_0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))

	if not FightModel.instance:isFinish() then
		if FightModel.instance:getVersion() < 4 then
			arg_3_0:addWork(FightWork2Work.New(FightWorkDistributeCard))
			arg_3_0:addWork(FunctionWork.New(function()
				FightController.instance:setCurStage(FightEnum.Stage.Play)
			end))
		end

		local var_3_4, var_3_5 = FightStepBuilder.buildStepWorkList(arg_3_0.roundData and arg_3_0.roundData.nextRoundBeginStep)

		if var_3_4 and #var_3_4 > 0 then
			for iter_3_0, iter_3_1 in ipairs(var_3_4) do
				arg_3_0:addWork(iter_3_1)
			end
		end

		arg_3_0:addWork(FightWorkShowRoundView.New())
		arg_3_0:addWork(FunctionWork.New(function()
			GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end))
		arg_3_0:addWork(FightWorkShowBuffDialog.New())
		arg_3_0:addWork(FightWorkCorrectData.New())
	end

	arg_3_0:addWork(FightWorkClearAfterRound.New())
	arg_3_0:addWork(FunctionWork.New(function()
		local var_6_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_6_0)
	end))
	arg_3_0:addWork(FightWorkCompareDataAfterPlay.New())
	arg_3_0:addWork(FunctionWork.New(arg_3_0._refreshPosition, arg_3_0))
end

function var_0_0._refreshPosition(arg_7_0)
	local var_7_0 = FightHelper.getAllEntitys()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1:resetStandPos()

		if iter_7_1.nameUI then
			iter_7_1.nameUI._nameUIVisible = true

			iter_7_1.nameUI:setActive(true)
		end
	end
end

return var_0_0
