-- chunkname: @modules/logic/versionactivity3_5/lamona/config/LamonaConfig.lua

module("modules.logic.versionactivity3_5.lamona.config.LamonaConfig", package.seeall)

local LamonaConfig = class("LamonaConfig", BaseConfig)

function LamonaConfig:reqConfigNames()
	return {
		"activity220_lamona_const",
		"activity220_lamona_game",
		"activity220_lamona_map",
		"activity220_lamona_unit_type",
		"activity220_lamona_unit"
	}
end

function LamonaConfig:onInit()
	return
end

function LamonaConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function LamonaConfig:activity220_lamona_mapConfigLoaded(configTable)
	self._mapStartPosDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local mapId = cfg.mapId
		local strStartPos = cfg.startPos
		local posArr = string.splitToNumber(strStartPos, "#")

		self._mapStartPosDict[mapId] = {
			x = posArr and posArr[1] or 0,
			y = posArr and posArr[2] or 0
		}
	end
end

function LamonaConfig:getLamonaConstCfg(constId, nilError)
	local cfg = lua_activity220_lamona_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("LamonaConfig:getLamonaConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function LamonaConfig:getLamonaConst(constId, isMLValue, isToNumber, delimiter)
	local result
	local cfg = self:getLamonaConstCfg(constId, true)

	if cfg then
		result = isMLValue and cfg.mlvalue or cfg.value

		if not string.nilorempty(delimiter) then
			if isToNumber then
				result = string.splitToNumber(result, delimiter)
			else
				result = string.split(result, delimiter)
			end
		elseif isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function LamonaConfig:getGridSize()
	if not self._gridSizeX or not self._gridSizeY then
		local arr = self:getLamonaConst(LamonaEnum.ConstId.GridSize, false, true, "#")

		self._gridSizeX = arr and arr[1] or 0
		self._gridSizeY = arr and arr[2] or 0
	end

	return self._gridSizeX, self._gridSizeY
end

function LamonaConfig:_getConstPointList(isThree)
	local pointList = {}
	local constId = isThree and LamonaEnum.ConstId.ThreeGhostPoint or LamonaEnum.ConstId.TwoGhostPoint
	local pointStr = self:getLamonaConst(constId)
	local twoPointArr = GameUtil.splitString2(pointStr, true, "|", "#")

	if twoPointArr then
		for i, pos in ipairs(twoPointArr) do
			pointList[i] = {
				x = pos[1] or 0,
				y = pos[2] or 0
			}
		end
	end

	return pointList
end

function LamonaConfig:getGridPointList(count)
	if not self._gridPointList then
		self._gridPointList = {
			{
				{
					x = 0,
					y = 0
				}
			}
		}

		local twoPointList = self:_getConstPointList()

		table.insert(self._gridPointList, twoPointList)

		local threePointList = self:_getConstPointList(true)

		table.insert(self._gridPointList, threePointList)
	end

	local result = self._gridPointList[count] or self._gridPointList[#self._gridPointList]

	return result
end

function LamonaConfig:getLamonaGameCfg(gameId, nilError)
	local cfg = lua_activity220_lamona_game.configDict[gameId]

	if not cfg and nilError then
		logError(string.format("LamonaConfig:getLamonaGameCfg error, cfg is nil, gameId:%s", gameId))
	end

	return cfg
end

function LamonaConfig:getLamonaMapId(gameId)
	local cfg = self:getLamonaGameCfg(gameId, true)

	return cfg and cfg.mapId
end

function LamonaConfig:getLamonaTargetDesc(gameId)
	local cfg = self:getLamonaGameCfg(gameId, true)

	return cfg and cfg.targetDesc or ""
end

function LamonaConfig:getLamonaPropId(gameId)
	local cfg = self:getLamonaGameCfg(gameId, true)

	return cfg and cfg.propId or 0
end

function LamonaConfig:getLamonaPropCount(gameId)
	local cfg = self:getLamonaGameCfg(gameId, true)

	return cfg and cfg.propCount or 0
end

function LamonaConfig:getLamonaMapCfg(mapId, nilError)
	local cfg = lua_activity220_lamona_map.configDict[mapId]

	if not cfg and nilError then
		logError(string.format("LamonaConfig:getLamonaMapCfg error, cfg is nil, mapId:%s", mapId))
	end

	return cfg
end

function LamonaConfig:getLamonaMapBg(mapId)
	local cfg = self:getLamonaMapCfg(mapId, true)

	return cfg and cfg.bg
end

function LamonaConfig:getLamonaMapStartPos(mapId)
	local x, y = 0, 0
	local mapStartPos = self._mapStartPosDict and self._mapStartPosDict[mapId]

	if mapStartPos then
		x = mapStartPos.x
		y = mapStartPos.y
	end

	return x, y
end

function LamonaConfig:getLamonaMapSize(mapId)
	local width, height = 0, 0
	local cfg = self:getLamonaMapCfg(mapId, true)

	if cfg then
		local arr = string.splitToNumber(cfg.size, "#")

		width = arr and arr[1] or 0
		height = arr and arr[2] or 0
	end

	return width, height
end

function LamonaConfig:getLamonaMapContent(mapId)
	local cfg = self:getLamonaMapCfg(mapId, true)

	return cfg and cfg.content
end

function LamonaConfig:getLamonaUnitTypeCfg(typeId, nilError)
	local cfg = lua_activity220_lamona_unit_type.configDict[typeId]

	if not cfg and nilError then
		logError(string.format("LamonaConfig:getLamonaUnitTypeCfg error, cfg is nil, typeId:%s", typeId))
	end

	return cfg
end

function LamonaConfig:getLamonaUnitTypeResName(typeId)
	local cfg = self:getLamonaUnitTypeCfg(typeId, true)

	return cfg and cfg.resName
end

function LamonaConfig:getLamonaUnitTypeLayer(typeId)
	local cfg = self:getLamonaUnitTypeCfg(typeId, true)

	return cfg and cfg.layer
end

local function sortUnitTypeList(a, b)
	local aLayer = LamonaConfig.instance:getLamonaUnitTypeLayer(a)
	local bLayer = LamonaConfig.instance:getLamonaUnitTypeLayer(b)

	if aLayer and bLayer and aLayer ~= bLayer then
		return aLayer < bLayer
	end

	return a < b
end

function LamonaConfig:getLamonaUnitTypeListInOrder()
	local result = {}

	for i, cfg in ipairs(lua_activity220_lamona_unit_type.configList) do
		result[i] = cfg.id
	end

	table.sort(result, sortUnitTypeList)

	return result
end

function LamonaConfig:getLamonaUnitCfg(unitId, nilError)
	local cfg = lua_activity220_lamona_unit.configDict[unitId]

	if not cfg and nilError then
		logError(string.format("LamonaConfig:getLamonaUnitCfg error, cfg is nil, unitId:%s", unitId))
	end

	return cfg
end

function LamonaConfig:getLamonaUnitType(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.type
end

function LamonaConfig:getLamonaUnitDesc(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.desc
end

function LamonaConfig:getLamonaUnitAttrList(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.attributeList or {}
end

function LamonaConfig:getLamonaUnitChangeGhostAttrs(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.changeGhostAttrs
end

function LamonaConfig:getLamonaUnitChangeGhostTempAttrs(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.changeGhostTempAttrs
end

function LamonaConfig:getLamonaUnitRemoveAfterEffect(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.removeAfterEffect
end

function LamonaConfig:getLamonaEffectRangeUnitId(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.effectRangeUnitId
end

function LamonaConfig:getLamonaUnitImgName(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.imgName
end

function LamonaConfig:getLamonaUnitIcon(unitId)
	local cfg = self:getLamonaUnitCfg(unitId, true)

	return cfg and cfg.icon
end

LamonaConfig.instance = LamonaConfig.New()

return LamonaConfig
