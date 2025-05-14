module("modules.logic.backpack.config.BackpackConfig", package.seeall)

local var_0_0 = class("BackpackConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._tabConfig = nil
	arg_1_0._subclassConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"backpack",
		"subclass_priority"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "backpack" then
		arg_3_0._tabConfig = arg_3_2
	elseif arg_3_1 == "subclass_priority" then
		arg_3_0._subclassConfig = arg_3_2
	end
end

function var_0_0.getCategoryCO(arg_4_0)
	return arg_4_0._tabConfig.configDict
end

function var_0_0.getSubclassCo(arg_5_0)
	return arg_5_0._subclassConfig.configDict
end

var_0_0.instance = var_0_0.New()

return var_0_0
