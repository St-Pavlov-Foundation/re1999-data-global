-- chunkname: @modules/logic/versionactivity3_8/dianjishi/config/DianJiShiGameConfig.lua

module("modules.logic.versionactivity3_8.dianjishi.config.DianJiShiGameConfig", package.seeall)

local DianJiShiGameConfig = class("DianJiShiGameConfig", BaseConfig)

function DianJiShiGameConfig:reqConfigNames()
	return {
		"activity220_dianjishi_game",
		"activity220_dianjishi_map",
		"activity220_dianjishi_block"
	}
end

function DianJiShiGameConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_dianjishi_map" then
		self:_onLoadMapConfig(configTable)
	elseif configName == "activity220_dianjishi_block" then
		self:_onLoadBlockConfig(configTable)
	end
end

function DianJiShiGameConfig:_onLoadMapConfig(configTable)
	self._allMapAreaDict = {}
	self._allMapAreaCellList = {}

	for _, mapCo in ipairs(configTable.configList) do
		local mapId = mapCo.mapId
		local areaId = mapCo.id
		local mapAreaList = self._allMapAreaDict and self._allMapAreaDict[mapId]

		if not mapAreaList then
			mapAreaList = {}
			self._allMapAreaDict[mapId] = mapAreaList
		end

		local cellList = GameUtil.splitString2(mapCo.position, true)

		self._allMapAreaCellList[mapId] = self._allMapAreaCellList[mapId] or {}
		self._allMapAreaCellList[mapId][areaId] = cellList

		table.insert(mapAreaList, mapCo)
	end
end

function DianJiShiGameConfig:_onLoadBlockConfig(configTable)
	self._allBlockDict = {}
	self._allBlockCubeDict = {}
	self._allBlockRightPosDict = {}
	self._allBlockRightPosList = {}

	for _, blockCo in ipairs(configTable.configList) do
		local mapId = blockCo.mapId
		local blockId = blockCo.id
		local mapBlockDict = self._allBlockCubeDict and self._allBlockCubeDict[mapId]
		local mapBlockRightDict = self._allBlockRightPosDict and self._allBlockRightPosDict[mapId]
		local mapBlockRightList = self._allBlockRightPosList and self._allBlockRightPosList[mapId]

		if not mapBlockDict then
			mapBlockDict = {}
			self._allBlockCubeDict[mapId] = mapBlockDict
		end

		if not mapBlockRightDict then
			mapBlockRightDict = {}
			mapBlockRightList = {}
			self._allBlockRightPosDict[mapId] = mapBlockRightDict
			self._allBlockRightPosList[mapId] = mapBlockRightList
		end

		local _tempShapeList = GameUtil.splitString2(blockCo.shape, true)
		local shapeList = {}
		local shapeDict = {}
		local size = {
			0,
			0
		}
		local minPosX, minPosY, maxPosX, maxPosY = 100, 100, -100, -100

		for _, tempShapeInfo in ipairs(_tempShapeList) do
			table.insert(shapeList, tempShapeInfo)

			local posX = tempShapeInfo[1]
			local posY = tempShapeInfo[2]

			shapeDict[posX] = shapeDict[posX] or {}
			shapeDict[posX][posY] = true
			minPosX = math.min(minPosX, posX)
			minPosY = math.min(minPosY, posY)
			maxPosX = math.max(maxPosX, posX)
			maxPosY = math.max(maxPosY, posY)
		end

		size = {
			maxPosX - minPosX + 1,
			maxPosY - minPosY + 1
		}
		mapBlockDict[blockId] = {
			list = shapeList,
			dict = shapeDict,
			size = size
		}

		local blockType = blockCo.type

		if not string.nilorempty(blockCo.rightPos) then
			local rightPos = string.splitToNumber(blockCo.rightPos, "#")
			local rightPosX = rightPos and rightPos[1] or 0
			local rightPosY = rightPos and rightPos[2] or 0

			mapBlockRightDict[blockType] = mapBlockRightDict[blockType] or {}
			mapBlockRightDict[blockType][rightPosX] = mapBlockRightDict[blockType][rightPosX] or {}
			mapBlockRightDict[blockType][rightPosX][rightPosY] = true
			mapBlockRightList[blockType] = mapBlockRightList[blockType] or {}

			table.insert(mapBlockRightList[blockType], rightPos)
		end
	end
end

function DianJiShiGameConfig:getMapBlockList(mapId)
	return lua_activity220_dianjishi_block.configDict[mapId]
end

function DianJiShiGameConfig:getBlockCo(mapId, blockId)
	local mapBlockDict = lua_activity220_dianjishi_block.configDict[mapId]

	return mapBlockDict and mapBlockDict[blockId]
end

function DianJiShiGameConfig:getBlockShapeList(mapId, blockId)
	local mapBlockDict = self._allBlockCubeDict and self._allBlockCubeDict[mapId]
	local config = mapBlockDict and mapBlockDict[blockId]

	return config and config.list
end

function DianJiShiGameConfig:getBlockShapeMap(mapId, blockId)
	local mapBlockDict = self._allBlockCubeDict and self._allBlockCubeDict[mapId]
	local config = mapBlockDict and mapBlockDict[blockId]

	return config and config.dict
end

function DianJiShiGameConfig:getBlockSize(mapId, blockId)
	local mapBlockDict = self._allBlockCubeDict and self._allBlockCubeDict[mapId]
	local config = mapBlockDict and mapBlockDict[blockId]

	return config and config.size
end

function DianJiShiGameConfig:getMapAreaList(mapId)
	return self._allMapAreaDict and self._allMapAreaDict[mapId]
end

function DianJiShiGameConfig:getMapAreaCellList(mapId, areaId)
	local areaCellList = self._allMapAreaCellList and self._allMapAreaCellList[mapId]

	return areaCellList and areaCellList[areaId]
end

function DianJiShiGameConfig:getGameConfig(gameId)
	return lua_activity220_dianjishi_game.configDict[gameId]
end

function DianJiShiGameConfig:getAreaSplitLineSize(mapId)
	self._areaSplitLineSizeMap = self._areaSplitLineSizeMap or {}

	local lineSize = self._areaSplitLineSizeMap and self._areaSplitLineSizeMap[mapId]

	if not lineSize then
		local mapCo = self:getGameConfig(mapId)

		lineSize = string.splitToNumber(mapCo and mapCo.areaSplitSize or "", "#")
		self._areaSplitLineSizeMap[mapId] = lineSize
	end

	local width = lineSize and lineSize[1]
	local height = lineSize and lineSize[2]

	return width or 0, height or 0
end

function DianJiShiGameConfig:getBlockRightPosDict(mapId, blockId)
	local blockCo = self:getBlockCo(mapId, blockId)
	local blockType = blockCo and blockCo.type

	if not blockType then
		return
	end

	local rightPosDict = self._allBlockRightPosDict and self._allBlockRightPosDict[mapId]

	return rightPosDict and rightPosDict[blockType]
end

function DianJiShiGameConfig:getBlockRightPosList(mapId, blockId)
	local blockCo = self:getBlockCo(mapId, blockId)
	local blockType = blockCo and blockCo.type

	if not blockType then
		return
	end

	local rightPosList = self._allBlockRightPosList and self._allBlockRightPosList[mapId]

	return rightPosList and rightPosList[blockType]
end

function DianJiShiGameConfig:isBlockInRightPos(mapId, blockId, blockPosX, blockPosY)
	local rightPosDict = self:getBlockRightPosDict(mapId, blockId)

	return rightPosDict and rightPosDict[blockPosX] and rightPosDict[blockPosX][blockPosY] == true
end

DianJiShiGameConfig.instance = DianJiShiGameConfig.New()

return DianJiShiGameConfig
