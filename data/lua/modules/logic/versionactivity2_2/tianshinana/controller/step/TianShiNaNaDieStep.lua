module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDieStep", package.seeall)

local var_0_0 = class("TianShiNaNaDieStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = TianShiNaNaModel.instance:getHeroMo()

	if not var_1_0 then
		arg_1_0:_delayDone()

		return
	end

	local var_1_1 = TianShiNaNaEntityMgr.instance:getEntity(var_1_0.co.id)

	if not var_1_1 then
		arg_1_0:_delayDone()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_death)
	var_1_1:playCloseAnim()
	UIBlockMgr.instance:startBlock("TianShiNaNaDieStep")
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 1)
end

function var_0_0._delayDone(arg_2_0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaResultView, {
		isWin = false,
		reason = arg_2_0._data.reason
	})
	arg_2_0:onDone(false)
end

function var_0_0.clearWork(arg_3_0)
	UIBlockMgr.instance:endBlock("TianShiNaNaDieStep")
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

return var_0_0
