module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepBase", package.seeall)

local var_0_0 = class("YaXianStepBase")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.originData = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.originData.index = arg_1_2
	arg_1_0.stepType = arg_1_0.originData.stepType
end

function var_0_0.start(arg_2_0)
	return
end

function var_0_0.finish(arg_3_0)
	local var_3_0 = YaXianGameController.instance.stepMgr

	if var_3_0 then
		var_3_0:nextStep()
	end
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
