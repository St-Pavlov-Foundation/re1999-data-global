module("modules.logic.fight.system.work.FightWorkPlayShow", package.seeall)

local var_0_0 = class("FightWorkPlayShow", FightWorkItem)

FightRoundSequence.roundTempData = {}

function var_0_0.onStart(arg_1_0)
	FightRoundSequence.roundTempData = {}
	arg_1_0.roundData = FightDataHelper.roundMgr:getRoundData()

	local var_1_0 = arg_1_0:com_registFlowSequence()

	var_1_0:registWork(FightWorkSendEvent, FightEvent.OnRoundSequenceStart)
	var_1_0:addWork(WorkWaitSeconds.New(0.01))
	var_1_0:addWork(FightWork2Work.New(FightWorkDialogueBeforeRoundStart))
	var_1_0:addWork(FightWorkRoundStart.New())

	local var_1_1, var_1_2 = FightStepBuilder.buildStepWorkList(arg_1_0.roundData and arg_1_0.roundData.fightStep)

	if var_1_1 then
		local var_1_3 = 1

		while var_1_3 <= #var_1_1 do
			local var_1_4 = var_1_1[var_1_3]

			var_1_3 = var_1_3 + 1

			var_1_0:addWork(var_1_4)
		end
	end

	var_1_0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	var_1_0:addWork(FightWorkRoundEnd.New())
	var_1_0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))

	if not FightModel.instance:isFinish() then
		if FightModel.instance:getVersion() < 4 then
			var_1_0:addWork(FightWork2Work.New(FightWorkDistributeCard))
		end

		local var_1_5, var_1_6 = FightStepBuilder.buildStepWorkList(arg_1_0.roundData and arg_1_0.roundData.nextRoundBeginStep)

		if var_1_5 and #var_1_5 > 0 then
			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				var_1_0:addWork(iter_1_1)
			end
		end

		var_1_0:addWork(FightWorkShowRoundView.New())
		var_1_0:addWork(FunctionWork.New(function()
			GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end))
		var_1_0:addWork(FightWorkShowBuffDialog.New())
		var_1_0:addWork(FightWorkCorrectData.New())
	end

	var_1_0:addWork(FightWorkClearAfterRound.New())
	var_1_0:addWork(FunctionWork.New(function()
		local var_3_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_3_0)
	end))
	var_1_0:addWork(FightWorkCompareDataAfterPlay.New())
	var_1_0:addWork(FunctionWork.New(arg_1_0._refreshPosition, arg_1_0))
	var_1_0:registFinishCallback(arg_1_0.onShowFinish, arg_1_0)
	arg_1_0:playWorkAndDone(var_1_0, {})
end

function var_0_0.onShowFinish(arg_4_0)
	FightModel.instance:onEndRound()
	FightController.instance:dispatchEvent(FightEvent.OnRoundSequenceFinish)
end

function var_0_0._refreshPosition(arg_5_0)
	local var_5_0 = FightHelper.getAllEntitys()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		iter_5_1:resetStandPos()

		if iter_5_1.nameUI then
			iter_5_1.nameUI._nameUIVisible = true

			iter_5_1.nameUI:setActive(true)
		end
	end
end

return var_0_0
