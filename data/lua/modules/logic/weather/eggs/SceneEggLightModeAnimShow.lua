module("modules.logic.weather.eggs.SceneEggLightModeAnimShow", package.seeall)

local var_0_0 = class("SceneEggLightModeAnimShow", SceneBaseEgg)

function var_0_0._onInit(arg_1_0)
	arg_1_0._animNameList = string.split(arg_1_0._eggConfig.actionParams, "#")

	arg_1_0:setGoListVisible(false)
end

function var_0_0._onEnable(arg_2_0)
	if not arg_2_0._lightMode then
		return
	end

	local var_2_0 = arg_2_0._animNameList[arg_2_0._lightMode]

	if not var_2_0 then
		return
	end

	arg_2_0:playAnim(var_2_0)
end

function var_0_0._onDisable(arg_3_0)
	arg_3_0:setGoListVisible(false)
end

function var_0_0._onReportChange(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0._lightMode = arg_4_1.lightMode
end

return var_0_0
