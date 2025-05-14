module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaPlayEffectWork", package.seeall)

local var_0_0 = class("TianShiNaNaPlayEffectWork", BaseWork)

function var_0_0.setWalkPath(arg_1_0, arg_1_1)
	arg_1_0._playerWalkPaths = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = #arg_2_0._playerWalkPaths

	if var_2_0 == 0 then
		arg_2_0:onDone(true)
	else
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_paving_succeed)

		for iter_2_0 = 1, var_2_0 do
			local var_2_1 = arg_2_0._playerWalkPaths[iter_2_0]

			TianShiNaNaEffectPool.instance:getFromPool(var_2_1.x, var_2_1.y, 2, (iter_2_0 - 1) * 0.1, 0.1)
		end

		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, var_2_0 * 0.1)
	end
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
