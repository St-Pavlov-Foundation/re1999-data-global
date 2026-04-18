-- chunkname: @modules/logic/room/utils/RoomResHelper.lua

module("modules.logic.room.utils.RoomResHelper", package.seeall)

local RoomResHelper = {}

function RoomResHelper.getMapBlockResPath(resourceId, resourceType, defineWaterType)
	if resourceId == RoomResourceEnum.ResourceId.None or resourceId == RoomResourceEnum.ResourceId.Empty then
		return nil
	end

	local resourceName = RoomResourceEnum.ResourceRes[resourceId]

	if resourceId == RoomResourceEnum.ResourceId.River then
		defineWaterType = defineWaterType or 0

		local resPath = ResUrl.getRoomRes(string.format("%s/%s/%s", resourceName, defineWaterType + 1, resourceType))
		local resAb = resPath

		return resPath, resAb
	end

	return nil
end

function RoomResHelper.getMapRiverFloorResPath(riverBlockType, defineBlockType)
	defineBlockType = defineBlockType or 0

	local tBlockType = RoomResHelper._getBlockType(defineBlockType)
	local resPath = ResUrl.getRoomRes(string.format("heliu_floor/%s/%s", tBlockType + 1, riverBlockType))
	local resAb = resPath

	return resPath, resAb
end

function RoomResHelper.getBlockPath(defineId)
	local defineConfig = RoomConfig.instance:getBlockDefineConfig(defineId)
	local prefabPath = defineConfig and defineConfig.prefabPath or RoomResourceEnum.EmptyPrefabPath

	return string.format("room/block/%s", prefabPath)
end

function RoomResHelper.getBlockABPath(defineId)
	return RoomResHelper.getBlockPath(defineId)
end

function RoomResHelper.getBlockLandPath(defineBlockType, isReplace)
	if not RoomResHelper._DefaultBlockLandDict then
		RoomResHelper._DefaultBlockLandDict = {}
		RoomResHelper._ReplaceBlockLandDict = {}

		for _, blockType in ipairs(lua_block.propertyList.blockType) do
			local numStr
			local num = blockType + 2

			if num < 10 then
				numStr = "0" .. num
			else
				numStr = num
			end

			RoomResHelper._DefaultBlockLandDict[blockType] = string.format("scenes/m_s07_xiaowu/prefab/ground/floor/%s.prefab", numStr)
			RoomResHelper._ReplaceBlockLandDict[blockType] = string.format("scenes/m_s07_xiaowu/prefab/ground/floor/%sb.prefab", numStr)
		end

		RoomResHelper._DefaultBlockLandDict[0] = RoomScenePreloader.DefaultLand
		RoomResHelper._ReplaceBlockLandDict[0] = RoomScenePreloader.ReplaceLand
	end

	local tBlockType = RoomResHelper._getBlockType(defineBlockType)
	local landDic = isReplace and RoomResHelper._ReplaceBlockLandDict or RoomResHelper._DefaultBlockLandDict

	return landDic[tBlockType] or landDic[0], landDic[tBlockType] or landDic[0]
end

function RoomResHelper._getBlockType(blockType)
	if blockType >= 10000 then
		return math.floor(blockType % 10000)
	end

	return blockType
end

RoomResHelper._TransportPathDict = {}

function RoomResHelper.getTransportPathPath(lineType, styleId)
	styleId = styleId or RoomTransportPathEnum.StyleId.Normal

	local lineTypeDict = RoomResHelper._TransportPathDict[styleId]

	if not lineTypeDict then
		lineTypeDict = {}

		for _, lineType in pairs(RoomTransportPathEnum.PathLineType) do
			local lineTypeRes = RoomTransportPathEnum.PathLineTypeRes[lineType]

			lineTypeDict[lineType] = string.format("scenes/m_s07_xiaowu/prefab/transport/%s/%s.prefab", styleId, lineTypeRes)
		end

		RoomResHelper._TransportPathDict[styleId] = lineTypeDict
	end

	return lineTypeDict[lineType]
end

function RoomResHelper.getCharacterCameraAnimPath(cameraAnimPath)
	if string.nilorempty(cameraAnimPath) then
		return nil
	end

	return string.format("effects/animation/room/%s.controller", cameraAnimPath)
end

function RoomResHelper.getCharacterCameraAnimABPath(cameraAnimPath)
	if string.nilorempty(cameraAnimPath) then
		return nil
	end

	return RoomResHelper.getCharacterCameraAnimPath(cameraAnimPath)
end

function RoomResHelper.getCharacterEffectPath(effectPath)
	if string.nilorempty(effectPath) then
		return nil
	end

	return string.format("scenes/m_s07_xiaowu/prefab/vx/%s.prefab", effectPath)
end

function RoomResHelper.getCharacterEffectABPath(effectPath)
	return RoomResHelper.getCharacterEffectPath(effectPath)
end

function RoomResHelper.getWaterPath()
	return ResUrl.getRoomRes("ground/water/water")
end

function RoomResHelper.getBuildingPath(buildingId, level)
	local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)
	local path = buildingConfig.path

	if buildingConfig.canLevelUp and level then
		local levelCfg = RoomConfig.instance:getLevelGroupConfig(buildingId, level)

		if levelCfg and not string.nilorempty(levelCfg.path) then
			path = levelCfg.path
		end
	end

	local url = ResUrl.getRoomRes(path)

	return url
end

function RoomResHelper.getVehiclePath(vehicleId)
	local vehicleConfig = RoomConfig.instance:getVehicleConfig(vehicleId)
	local path = vehicleConfig.path
	local url = ResUrl.getRoomRes(path)

	return url
end

function RoomResHelper.getPartPathList(levelGroup, level)
	local resList = {}

	if level < 0 then
		return resList
	end

	local levelGroupConfig = RoomConfig.instance:getLevelGroupConfig(levelGroup, level)

	if not levelGroupConfig then
		return resList
	end

	local path = levelGroupConfig.modulePart

	if string.nilorempty(path) then
		return resList
	end

	path = string.split(path, "#")

	for i, res in ipairs(path) do
		table.insert(resList, ResUrl.getRoomRes(string.format("jianzhu/%s", res)))
	end

	return resList
end

function RoomResHelper.getCritterPath(skinId)
	local path
	local skinConfig = CritterConfig.instance:getCritterSkinCfg(skinId, true)

	if skinConfig then
		path = ResUrl.getSpineBxhyPrefab(skinConfig.spine)
	end

	return path
end

function RoomResHelper.getCharacterPath(skinId)
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local spineName = skinConfig.spine

	return ResUrl.getSpineBxhyPrefab(spineName)
end

function RoomResHelper.getAnimalPath(skinId)
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local spineName = skinConfig.alternateSpine

	return ResUrl.getSpineBxhyPrefab(spineName)
end

function RoomResHelper.getCritterUIPath(skinId)
	local skinConfig = CritterConfig.instance:getCritterSkinCfg(skinId)
	local spineName = skinConfig.spine

	return ResUrl.getSpineUIBxhyPrefab(spineName)
end

function RoomResHelper.getBlockName(hexPoint)
	return string.format("%s_%s", hexPoint.x, hexPoint.y)
end

function RoomResHelper.getResourcePointName(resourcePoint)
	return string.format("%s_%s_%s", resourcePoint.x, resourcePoint.y, resourcePoint.direction)
end

function RoomResHelper.getIndexByResId(resId)
	local resList = RoomResourceEnum.ResourceList
	local max = #resList

	for index = 1, max do
		if resList[index] == resId then
			return index
		end
	end

	return -1
end

return RoomResHelper
