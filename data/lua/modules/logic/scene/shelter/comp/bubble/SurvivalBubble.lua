module("modules.logic.scene.shelter.comp.bubble.SurvivalBubble", package.seeall)

local var_0_0 = class("SurvivalBubble", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.survivalBubbleComp = arg_1_2
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.survivalBubbleParam = arg_2_1
	arg_2_0.transform = arg_2_2
end

function var_0_0.enable(arg_3_0)
	if arg_3_0.survivalBubbleParam.duration > 0 then
		TaskDispatcher.runDelay(arg_3_0.onFinish, arg_3_0, arg_3_0.survivalBubbleParam.duration)
	end
end

function var_0_0.disable(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.onFinish, arg_4_0)
end

function var_0_0.onFinish(arg_5_0)
	arg_5_0.survivalBubbleComp:removeBubble(arg_5_0.id)
end

return var_0_0
