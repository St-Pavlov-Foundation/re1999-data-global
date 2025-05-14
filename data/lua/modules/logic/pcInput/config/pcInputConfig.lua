module("modules.logic.pcInput.config.pcInputConfig", package.seeall)

local var_0_0 = class("pcInputConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"key_binding",
		"key_block",
		"key_name_replace"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "key_binding" then
		arg_2_0.key_binding = arg_2_2
	end

	if arg_2_1 == "key_block" then
		arg_2_0.key_block = arg_2_2
	end

	if arg_2_1 == "key_name_replace" then
		arg_2_0.key_name_replace = arg_2_2
	end
end

function var_0_0.getKeyBinding(arg_3_0)
	return arg_3_0.key_binding.configDict
end

function var_0_0.getKeyBlock(arg_4_0)
	return arg_4_0.key_block.configDict
end

function var_0_0.getKeyNameReplace(arg_5_0)
	return arg_5_0.key_name_replace.configDict
end

var_0_0.instance = var_0_0.New()

return var_0_0
