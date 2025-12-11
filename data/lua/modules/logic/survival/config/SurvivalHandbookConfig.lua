module("modules.logic.survival.config.SurvivalHandbookConfig", package.seeall)

local var_0_0 = class("SurvivalHandbookConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"survival_handbook",
		"survival_equip"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "survival_handbook" then
		-- block empty
	end
end

function var_0_0.getConfigList(arg_4_0)
	return lua_survival_handbook.configList
end

var_0_0.instance = var_0_0.New()

return var_0_0
