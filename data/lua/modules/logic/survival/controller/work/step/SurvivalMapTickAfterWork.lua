module("modules.logic.survival.controller.work.step.SurvivalMapTickAfterWork", package.seeall)

local var_0_0 = class("SurvivalMapTickAfterWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.paramInt[1] or 0
	local var_1_1 = arg_1_0._stepMo.paramInt[2] or 0
	local var_1_2 = arg_1_0._stepMo.paramInt[3] or 0

	arg_1_0._curRound = var_1_0
	arg_1_0._totalRound = var_1_1

	if var_1_2 == 2 and not arg_1_0.context.fastExecute then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowSurvivalHeroTick, var_1_0, var_1_1)
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, SurvivalConst.PlayerMoveSpeed)
		ViewMgr.instance:closeAllPopupViews()

		local var_1_3 = SurvivalMapModel.instance:getSceneMo().player
		local var_1_4, var_1_5, var_1_6 = SurvivalHelper.instance:hexPointToWorldPoint(var_1_3.pos.q, var_1_3.pos.r)

		SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_1_4, var_1_5, var_1_6))
		UIBlockMgrExtend.setNeedCircleMv(false)

		if var_1_0 == 1 then
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_dutiao_loop)
		end

		UIBlockHelper.instance:startBlock("SurvivalMapTickAfterWork", SurvivalConst.PlayerMoveSpeed)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	if arg_2_0._curRound == arg_2_0._totalRound then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_dutiao_loop)
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

function var_0_0.getRunOrder(arg_4_0, arg_4_1, arg_4_2)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
