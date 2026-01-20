-- chunkname: @modules/logic/patface/config/PatFaceConfig.lua

module("modules.logic.patface.config.PatFaceConfig", package.seeall)

local PatFaceConfig = class("PatFaceConfig", BaseConfig)

function PatFaceConfig:ctor()
	self._patFaceConfigList = {}
end

function PatFaceConfig:reqConfigNames()
	return {
		"pat_face"
	}
end

function PatFaceConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

local function patFaceSortFun(a, b)
	local aOrder = a.order or 0
	local bOrder = b.order or 0

	if aOrder ~= bOrder then
		return aOrder < bOrder
	end

	return a.id < b.id
end

function PatFaceConfig:pat_faceConfigLoaded(configTable)
	local tmpList = {}

	for _, cfg in ipairs(configTable.configList) do
		local id = cfg.id

		tmpList[#tmpList + 1] = {
			id = id,
			order = cfg.patFaceOrder,
			config = cfg
		}
	end

	table.sort(tmpList, patFaceSortFun)

	self._patFaceConfigList = tmpList
end

local function getCfg(id, canNil)
	local cfg

	if id then
		cfg = lua_pat_face.configDict[id]
	end

	if not cfg and not canNil then
		logError(string.format("PatFaceConfig:getCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function PatFaceConfig:getPatFaceActivityId(id)
	local result = 0
	local cfg = getCfg(id)

	if cfg then
		result = cfg.patFaceActivityId
	end

	return result
end

function PatFaceConfig:getPatFaceViewName(id)
	local result = ""
	local cfg = getCfg(id)

	if cfg then
		result = cfg.patFaceViewName
	end

	return result
end

function PatFaceConfig:getPatFaceStoryId(id)
	local result = 0
	local cfg = getCfg(id)

	if cfg then
		result = cfg.patFaceStoryId
	end

	return result
end

function PatFaceConfig:getPatFaceOrder(id)
	local result = 0
	local cfg = getCfg(id)

	if cfg then
		result = cfg.patFaceOrder
	end

	return result
end

function PatFaceConfig:getPatFaceConfigList()
	return self._patFaceConfigList or {}
end

PatFaceConfig.instance = PatFaceConfig.New()

return PatFaceConfig
