module("modules.logic.activity.controller.chessmap.step.ActivityChessStepBase", package.seeall)

local var_0_0 = class("ActivityChessStepBase")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.start(arg_2_0)
	return
end

function var_0_0.finish(arg_3_0)
	local var_3_0 = ActivityChessGameController.instance.event

	if var_3_0 then
		var_3_0:nextStep()
	end
end

function var_0_0.dispose(arg_4_0)
	arg_4_0.originData = nil
end

return var_0_0
