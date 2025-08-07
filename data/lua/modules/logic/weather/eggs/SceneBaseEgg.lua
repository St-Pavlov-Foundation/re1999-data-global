module("modules.logic.weather.eggs.SceneBaseEgg", package.seeall)

local var_0_0 = class("SceneBaseEgg")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onEnable(arg_2_0)
	arg_2_0:_onEnable()
end

function var_0_0._onEnable(arg_3_0)
	return
end

function var_0_0.onDisable(arg_4_0)
	arg_4_0:_onDisable()
end

function var_0_0._onDisable(arg_5_0)
	return
end

function var_0_0.onReportChange(arg_6_0, arg_6_1)
	arg_6_0:_onReportChange(arg_6_1)
end

function var_0_0._onReportChange(arg_7_0, arg_7_1)
	return
end

function var_0_0.init(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0._sceneGo = arg_8_1
	arg_8_0._context = arg_8_4
	arg_8_0._goList = arg_8_2
	arg_8_0._eggConfig = arg_8_3

	arg_8_0:_onInit()
end

function var_0_0.setGoListVisible(arg_9_0, arg_9_1)
	if not arg_9_0._goList then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._goList) do
		gohelper.setActive(iter_9_1, arg_9_1)
	end
end

function var_0_0.playAnim(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._goList) do
		gohelper.setActive(iter_10_1, true)

		local var_10_0 = iter_10_1 and iter_10_1:GetComponent("Animator")

		if var_10_0 then
			var_10_0:Play(arg_10_1, 0, 0)
		else
			logError("go has no animator animName:" .. arg_10_1)
		end
	end
end

function var_0_0._onInit(arg_11_0)
	return
end

function var_0_0.onSceneClose(arg_12_0)
	arg_12_0._goList = nil

	arg_12_0:_onSceneClose()
end

function var_0_0._onSceneClose(arg_13_0)
	return
end

return var_0_0
