module("modules.logic.fightuiswitch.config.FightUISwitchConfig", package.seeall)

local var_0_0 = class("FightUISwitchConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"fight_ui_style",
		"fight_ui_effect"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "fight_ui_style" then
		arg_3_0._fight_ui_style = arg_3_2

		arg_3_0:_initFightUIStyleConfig()
	elseif arg_3_1 == "fight_ui_effect" then
		arg_3_0._fight_ui_effect = arg_3_2
	end
end

function var_0_0._initFightUIStyleConfig(arg_4_0)
	arg_4_0._itemStyleCoList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._fight_ui_style.configList) do
		if not arg_4_0._itemStyleCoList[iter_4_1.itemId] then
			arg_4_0._itemStyleCoList[iter_4_1.itemId] = {}
		end

		table.insert(arg_4_0._itemStyleCoList[iter_4_1.itemId], iter_4_1)
	end
end

function var_0_0.getFightUIStyleCoById(arg_5_0, arg_5_1)
	return arg_5_0._fight_ui_style.configDict[arg_5_1]
end

function var_0_0.getFightUIStyleCoList(arg_6_0)
	return arg_6_0._fight_ui_style.configList
end

function var_0_0.getFightUIEffectConfigById(arg_7_0, arg_7_1)
	return arg_7_0._fight_ui_effect.configDict[arg_7_1]
end

function var_0_0.getStyleCosByItemId(arg_8_0, arg_8_1)
	return arg_8_0._itemStyleCoList[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
