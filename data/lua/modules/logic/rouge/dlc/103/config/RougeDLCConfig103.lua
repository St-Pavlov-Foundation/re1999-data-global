-- chunkname: @modules/logic/rouge/dlc/103/config/RougeDLCConfig103.lua

module("modules.logic.rouge.dlc.103.config.RougeDLCConfig103", package.seeall)

local RougeDLCConfig103 = class("RougeDLCConfig103", BaseConfig)

function RougeDLCConfig103:reqConfigNames()
	return {
		"rouge_map_rule",
		"rouge_monster_rule"
	}
end

function RougeDLCConfig103:getMapRuleConfig(ruleId)
	local ruleCo = lua_rouge_map_rule.configDict[ruleId]

	return ruleCo
end

function RougeDLCConfig103:getMonsterRuleConfig(ruleId)
	local ruleCo = lua_rouge_monster_rule.configDict[ruleId]

	return ruleCo
end

RougeDLCConfig103.instance = RougeDLCConfig103.New()

return RougeDLCConfig103
