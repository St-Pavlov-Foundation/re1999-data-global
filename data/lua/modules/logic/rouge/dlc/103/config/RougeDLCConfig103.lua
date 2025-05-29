module("modules.logic.rouge.dlc.103.config.RougeDLCConfig103", package.seeall)

local var_0_0 = class("RougeDLCConfig103", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_map_rule",
		"rouge_monster_rule"
	}
end

function var_0_0.getMapRuleConfig(arg_2_0, arg_2_1)
	return lua_rouge_map_rule.configDict[arg_2_1]
end

function var_0_0.getMonsterRuleConfig(arg_3_0, arg_3_1)
	return lua_rouge_monster_rule.configDict[arg_3_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
