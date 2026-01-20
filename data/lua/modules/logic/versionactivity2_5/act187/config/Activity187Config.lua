-- chunkname: @modules/logic/versionactivity2_5/act187/config/Activity187Config.lua

module("modules.logic.versionactivity2_5.act187.config.Activity187Config", package.seeall)

local Activity187Config = class("Activity187Config", BaseConfig)

function Activity187Config:reqConfigNames()
	return {
		"activity187_const",
		"activity187",
		"activity187_blessing"
	}
end

function Activity187Config:onInit()
	return
end

function Activity187Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function Activity187Config:getAct187ConstCfg(constId, nilError)
	local cfg = lua_activity187_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("Activity187Config:getAct187ConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function Activity187Config:getAct187Const(constId)
	local result
	local cfg = self:getAct187ConstCfg(constId, true)

	if cfg then
		result = cfg.value
	end

	return result
end

function Activity187Config:getAct187AccrueRewardCfg(actId, accrueId, nilError)
	local cfg = lua_activity187.configDict[actId] and lua_activity187.configDict[actId][accrueId]

	if not cfg and nilError then
		logError(string.format("Activity187Config:getAct187AccrueRewardCfg error, cfg is nil, actId:%s, accrueId:%s", actId, accrueId))
	end

	return cfg
end

function Activity187Config:getAccrueRewardIdList(actId)
	local result = {}
	local cfgDict = lua_activity187.configDict[actId]

	if cfgDict then
		for id, _ in pairs(cfgDict) do
			result[#result + 1] = id
		end
	end

	return result
end

function Activity187Config:getAccrueRewards(actId, accrueId)
	local result = {}
	local cfg = self:getAct187AccrueRewardCfg(actId, accrueId, true)

	if cfg then
		local items = GameUtil.splitString2(cfg.bonus, true)

		for _, item in ipairs(items) do
			local itemData = {
				accrueId = accrueId,
				materilType = item[1],
				materilId = item[2],
				quantity = item[3]
			}

			result[#result + 1] = itemData
		end
	end

	return result
end

function Activity187Config:getAct187BlessingCfg(actId, rewardId, nilError)
	local cfg = activity187_blessing.configDict[actId] and activity187_blessing.configDict[actId][rewardId]

	if not cfg and nilError then
		logError(string.format("Activity187Config:getAct187BlessingCfg error, cfg is nil, actId:%s, rewardId:%s", actId, rewardId))
	end

	return cfg
end

function Activity187Config:getLantern(actId, rewardId)
	local result = ""
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	if cfg then
		result = cfg.lantern
	end

	return result
end

function Activity187Config:getLanternRibbon(actId, rewardId)
	local result = ""
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	if cfg then
		result = cfg.lanternRibbon
	end

	return result
end

function Activity187Config:getLanternImg(actId, rewardId)
	local result
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	if cfg then
		result = cfg.lanternImg
	end

	return result
end

function Activity187Config:getLanternImgBg(actId, rewardId)
	local result
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	if cfg then
		result = cfg.lanternImgBg
	end

	return result
end

function Activity187Config:getBlessing(actId, rewardId)
	local result = ""
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	if cfg then
		result = cfg.blessing
	end

	return result
end

Activity187Config.instance = Activity187Config.New()

return Activity187Config
