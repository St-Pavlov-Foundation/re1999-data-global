-- chunkname: @modules/logic/tower/config/TowerDeepConfig.lua

module("modules.logic.tower.config.TowerDeepConfig", package.seeall)

local TowerDeepConfig = class("TowerDeepConfig", BaseConfig)

function TowerDeepConfig:ctor()
	self.TowerDeepConfig = nil
end

function TowerDeepConfig:reqConfigNames()
	return {
		"tower_deep_const",
		"tower_deep_task",
		"tower_deep_monster"
	}
end

function TowerDeepConfig:onConfigLoaded(configName, configTable)
	if configName == "tower_deep_const" then
		self._constConfig = configTable
	elseif configName == "tower_deep_task" then
		self._taskConfig = configTable
	elseif configName == "tower_deep_monster" then
		self._deepMonsterConfig = configTable
	end
end

function TowerDeepConfig:getConstConfigValue(id, isString)
	local config = self._constConfig.configDict[id]

	if config then
		return isString and config.value or tonumber(config.value)
	end
end

function TowerDeepConfig:getConstConfigLangValue(id)
	local config = self._constConfig.configDict[id]

	if config then
		return config.value2
	end
end

function TowerDeepConfig:getTaskConfig(id)
	return self._taskConfig.configDict[id]
end

function TowerDeepConfig:getTaskConfigList()
	return self._taskConfig.configList
end

function TowerDeepConfig:getDeepMonsterId(deepHigh)
	for index, config in ipairs(self._deepMonsterConfig.configList) do
		if deepHigh >= config.startHighDeep and deepHigh <= config.endHighDeep then
			return config.bossId
		end
	end

	return self._deepMonsterConfig.configList[1].bossId
end

TowerDeepConfig.instance = TowerDeepConfig.New()

return TowerDeepConfig
