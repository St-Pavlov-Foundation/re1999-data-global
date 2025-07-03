module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminatePlayAudioStep", package.seeall)

local var_0_0 = class("EliminatePlayAudioStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	if var_1_0 == nil then
		arg_1_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
