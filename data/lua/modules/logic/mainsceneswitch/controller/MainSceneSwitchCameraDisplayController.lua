module("modules.logic.mainsceneswitch.controller.MainSceneSwitchCameraDisplayController", package.seeall)

local var_0_0 = class("MainSceneSwitchCameraDisplayController", MainSceneSwitchDisplayController)

var_0_0.instance = var_0_0.New()

function var_0_0.clear(arg_1_0)
	if arg_1_0._loaderMap then
		for iter_1_0, iter_1_1 in pairs(arg_1_0._loaderMap) do
			iter_1_1:dispose()
		end

		tabletool.clear(arg_1_0._loaderMap)
	end

	if arg_1_0._weatherCompMap then
		for iter_1_2, iter_1_3 in pairs(arg_1_0._weatherCompMap) do
			for iter_1_4, iter_1_5 in ipairs(iter_1_3) do
				iter_1_5:onSceneClose()
			end
		end

		tabletool.clear(arg_1_0._weatherCompMap)
	end

	if arg_1_0._sceneNameMap then
		for iter_1_6, iter_1_7 in pairs(arg_1_0._sceneNameMap) do
			gohelper.destroy(iter_1_7)
		end

		tabletool.clear(arg_1_0._sceneNameMap)
	end

	arg_1_0._sceneRoot = nil
	arg_1_0._callback = nil
	arg_1_0._callbackTarget = nil
end

return var_0_0
