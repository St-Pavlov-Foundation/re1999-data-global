-- chunkname: @modules/logic/versionactivity1_9/roomgift/config/RoomGiftConfig.lua

module("modules.logic.versionactivity1_9.roomgift.config.RoomGiftConfig", package.seeall)

local RoomGiftConfig = class("RoomGiftConfig", BaseConfig)

function RoomGiftConfig:reqConfigNames()
	return {
		"activity159",
		"activity159_critter"
	}
end

function RoomGiftConfig:onInit()
	return
end

function RoomGiftConfig:onConfigLoaded(configName, configTable)
	return
end

local function getRoomGiftSpineCfg(name)
	local cfg

	if not string.nilorempty(name) then
		cfg = lua_activity159_critter.configDict[name]
	end

	if not cfg then
		logError(string.format("RoomGiftConfig.getRoomGiftSpineCfg error, no cfg, name:%s", name))
	end

	return cfg
end

function RoomGiftConfig:getAllRoomGiftSpineList()
	local result = {}

	for _, cfg in ipairs(lua_activity159_critter.configList) do
		result[#result + 1] = cfg.name
	end

	return result
end

function RoomGiftConfig:getRoomGiftSpineRes(name)
	local result
	local cfg = getRoomGiftSpineCfg(name)

	if cfg then
		result = cfg.res
	end

	return result
end

function RoomGiftConfig:getRoomGiftSpineAnim(name)
	local result
	local cfg = getRoomGiftSpineCfg(name)

	if cfg then
		result = cfg.anim
	end

	return result
end

function RoomGiftConfig:getRoomGiftSpineStartPos(name)
	local result = {
		0,
		0,
		0
	}
	local cfg = getRoomGiftSpineCfg(name)

	if cfg then
		result = string.splitToNumber(cfg.startPos, "#")
	end

	return result
end

function RoomGiftConfig:getRoomGiftSpineScale(name)
	local result = 1
	local cfg = getRoomGiftSpineCfg(name)

	if cfg then
		result = cfg.scale
	end

	return result
end

local function getActivity159Cfg(actId, day, nilError)
	local cfg

	if actId and day then
		local actCfgDict = lua_activity159.configDict[actId]

		cfg = actCfgDict and actCfgDict[day]
	end

	if not cfg and nilError then
		logError(string.format("RoomGiftConfig:getActivity159Cfg error, cfg is nil, actId:%s  day:%s", actId, day))
	end

	return cfg
end

function RoomGiftConfig:getRoomGiftBonus(actId, day)
	local result
	local cfg = getActivity159Cfg(actId, day)

	if cfg then
		result = cfg.bonus
	end

	return result
end

RoomGiftConfig.instance = RoomGiftConfig.New()

return RoomGiftConfig
