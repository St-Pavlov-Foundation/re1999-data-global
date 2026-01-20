-- chunkname: @modules/logic/versionactivity1_6/act147/config/FurnaceTreasureConfig.lua

module("modules.logic.versionactivity1_6.act147.config.FurnaceTreasureConfig", package.seeall)

local FurnaceTreasureConfig = class("FurnaceTreasureConfig", BaseConfig)

function FurnaceTreasureConfig:reqConfigNames()
	return {
		"activity147",
		"activity147_goods"
	}
end

function FurnaceTreasureConfig:onInit()
	return
end

function FurnaceTreasureConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

local function getAct147Cfg(activityId, nilError)
	local cfg = lua_activity147 and lua_activity147.configDict[activityId] or nil

	if not cfg and nilError then
		logError(string.format("FurnaceTreasureConfig.getAct147Cfg error, cfg is nil, id:%s", activityId))
	end

	return cfg
end

function FurnaceTreasureConfig:getDescList(activityId)
	local result = {}
	local cfg = getAct147Cfg(activityId, true)

	if cfg then
		local strDescList = cfg.descList

		result = string.split(strDescList, "|")
	end

	return result
end

function FurnaceTreasureConfig:getRewardList(activityId)
	local result = {}
	local cfg = getAct147Cfg(activityId, true)

	if cfg then
		local strRewardList = cfg.rewardList

		result = ItemModel.instance:getItemDataListByConfigStr(strRewardList)
	end

	return result
end

function FurnaceTreasureConfig:getSpineRes(activityId)
	local result
	local cfg = getAct147Cfg(activityId, true)

	if cfg then
		result = cfg.spineRes
	end

	return result
end

function FurnaceTreasureConfig:getDialogList(activityId)
	local result = {}
	local cfg = getAct147Cfg(activityId, true)

	if cfg then
		local strDialogs = cfg.dialogs

		result = string.split(strDialogs, "|")
	end

	return result
end

function FurnaceTreasureConfig:getJumpId(activityId)
	local result = 0
	local cfg = getAct147Cfg(activityId, true)

	if cfg then
		result = cfg.jumpId
	end

	return result
end

local function getAct147GoodCfg(goodsId, nilError)
	local cfg
	local activityId = FurnaceTreasureModel.instance:getActId()

	if lua_activity147_goods and lua_activity147_goods.configDict[activityId] then
		cfg = lua_activity147_goods.configDict[activityId][goodsId]
	end

	if not cfg and nilError then
		logError(string.format("FurnaceTreasureConfig.get147GoodCfg error, cfg is nil, actId:%s,goodsId:%s", activityId, goodsId))
	end

	return cfg
end

function FurnaceTreasureConfig:get147GoodsCost(goodsId)
	local result
	local cfg = getAct147GoodCfg(goodsId, true)

	if cfg then
		result = cfg.cost
	end

	return result
end

function FurnaceTreasureConfig:getAct147GoodsShowItem(poolId)
	local type = 0
	local id = 0
	local quantity = 0
	local strShowItem = poolId and FurnaceTreasureEnum.Pool2GoodsId[poolId] or nil

	if strShowItem then
		local showInfo = string.splitToNumber(strShowItem, "#")

		type = showInfo[1] or 0
		id = showInfo[2] or 0
		quantity = showInfo[3] or 0
	else
		logError(string.format("FurnaceTreasureConfig:getAct147GoodsShowItem error, can't get strShowItem, poolId:%s", poolId))
	end

	return type, id, quantity
end

FurnaceTreasureConfig.instance = FurnaceTreasureConfig.New()

return FurnaceTreasureConfig
