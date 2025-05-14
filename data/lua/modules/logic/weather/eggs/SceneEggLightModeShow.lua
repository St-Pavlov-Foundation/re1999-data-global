module("modules.logic.weather.eggs.SceneEggLightModeShow", package.seeall)

local var_0_0 = class("SceneEggLightModeShow", SceneBaseEgg)

function var_0_0._onInit(arg_1_0)
	arg_1_0._lightMode = tonumber(arg_1_0._eggConfig.actionParams)

	arg_1_0:setGoListVisible(false)
end

function var_0_0._onReportChange(arg_2_0, arg_2_1)
	if not arg_2_1 then
		arg_2_0:setGoListVisible(false)

		return
	end

	arg_2_0:setGoListVisible(arg_2_0._lightMode == arg_2_1.lightMode)
end

return var_0_0
