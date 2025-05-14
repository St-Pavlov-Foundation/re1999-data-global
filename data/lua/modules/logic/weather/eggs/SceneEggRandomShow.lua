module("modules.logic.weather.eggs.SceneEggRandomShow", package.seeall)

local var_0_0 = class("SceneEggRandomShow", SceneBaseEgg)

function var_0_0._onEnable(arg_1_0)
	arg_1_0:setGoListVisible(true)
end

function var_0_0._onDisable(arg_2_0)
	arg_2_0:setGoListVisible(false)
end

function var_0_0._onInit(arg_3_0)
	arg_3_0:setGoListVisible(false)
end

return var_0_0
