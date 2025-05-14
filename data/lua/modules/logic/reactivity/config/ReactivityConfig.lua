module("modules.logic.reactivity.config.ReactivityConfig", package.seeall)

local var_0_0 = class("ReactivityConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._retroItemConvertConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"retro_item_convert"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "retro_item_convert" then
		arg_3_0._retroItemConvertConfig = arg_3_2
	end
end

function var_0_0.getItemConvertList(arg_4_0)
	return arg_4_0._retroItemConvertConfig.configList
end

function var_0_0.getItemConvertCO(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._retroItemConvertConfig.configDict[arg_5_1]

	if not var_5_0 then
		return
	end

	return var_5_0[arg_5_2]
end

function var_0_0.checkItemNeedConvert(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getItemConvertCO(arg_6_1, arg_6_2)

	if not var_6_0 then
		return false
	end

	return ItemModel.instance:getItemQuantity(arg_6_1, arg_6_2) >= var_6_0.limit, var_6_0.price
end

var_0_0.instance = var_0_0.New()

return var_0_0
