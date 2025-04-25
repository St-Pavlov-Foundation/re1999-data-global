module("modules.logic.room.utils.RoomResHelper", package.seeall)

return {
	getMapBlockResPath = function (slot0, slot1, slot2)
		if slot0 == RoomResourceEnum.ResourceId.None or slot0 == RoomResourceEnum.ResourceId.Empty then
			return nil
		end

		slot3 = RoomResourceEnum.ResourceRes[slot0]

		if slot0 == RoomResourceEnum.ResourceId.River then
			slot2 = slot2 or 0
			slot4 = ResUrl.getRoomRes(string.format("%s/%s/%s", slot3, slot2 + 1, slot1))
			slot5 = ResUrl.getRoomResAB(string.format("%s/%s", slot3, slot2 + 1))

			if GameResMgr.IsFromEditorDir then
				slot5 = ResUrl.getRoomRes(string.format("%s/%s/%s", slot3, slot2 + 1, slot1))
			end

			return slot4, slot5
		end

		return nil
	end,
	getMapRiverFloorResPath = function (slot0, slot1)
		slot1 = slot1 or 0
		slot2 = ResUrl.getRoomRes(string.format("heliu_floor/%s/%s", slot1 + 1, slot0))
		slot3 = ResUrl.getRoomResAB(string.format("heliu_floor/%s", slot1 + 1))

		if GameResMgr.IsFromEditorDir then
			slot3 = slot2
		end

		return slot2, slot3
	end,
	getBlockPath = function (slot0)
		return string.format("room/block/%s", RoomConfig.instance:getBlockDefineConfig(slot0) and slot1.prefabPath or RoomResourceEnum.EmptyPrefabPath)
	end,
	getBlockABPath = function (slot0)
		if GameResMgr.IsFromEditorDir then
			return uv0.getBlockPath(slot0)
		else
			return string.format("room/block/%s", string.split(RoomConfig.instance:getBlockDefineConfig(slot0) and slot1.prefabPath or RoomResourceEnum.EmptyPrefabPath, "/")[1])
		end
	end,
	getBlockLandPath = function (slot0, slot1)
		if not uv0._DefaultBlockLandDict then
			uv0._DefaultBlockLandDict = {}
			uv0._ReplaceBlockLandDict = {}

			for slot5, slot6 in ipairs(lua_block.propertyList.blockType) do
				slot7 = nil
				slot7 = slot6 + 2 < 10 and "0" .. slot8 or slot8
				uv0._DefaultBlockLandDict[slot6] = string.format("scenes/m_s07_xiaowu/prefab/ground/floor/%s.prefab", slot7)
				uv0._ReplaceBlockLandDict[slot6] = string.format("scenes/m_s07_xiaowu/prefab/ground/floor/%sb.prefab", slot7)
			end

			uv0._DefaultBlockLandDict[0] = RoomScenePreloader.DefaultLand
			uv0._ReplaceBlockLandDict[0] = RoomScenePreloader.ReplaceLand
		end

		slot2 = slot1 and uv0._ReplaceBlockLandDict or uv0._DefaultBlockLandDict

		return slot2[slot0] or slot2[0], slot2[slot0] or slot2[0]
	end,
	_TransportPathDict = {},
	getTransportPathPath = function (slot0, slot1)
		if not uv0._TransportPathDict[slot1 or RoomTransportPathEnum.StyleId.Normal] then
			for slot6, slot7 in pairs(RoomTransportPathEnum.PathLineType) do
				-- Nothing
			end

			uv0._TransportPathDict[slot1] = {
				[slot7] = string.format("scenes/m_s07_xiaowu/prefab/transport/%s/%s.prefab", slot1, RoomTransportPathEnum.PathLineTypeRes[slot7])
			}
		end

		return slot2[slot0]
	end,
	getCharacterCameraAnimPath = function (slot0)
		if string.nilorempty(slot0) then
			return nil
		end

		return string.format("effects/animation/room/%s.controller", slot0)
	end,
	getCharacterCameraAnimABPath = function (slot0)
		if string.nilorempty(slot0) then
			return nil
		end

		if GameResMgr.IsFromEditorDir then
			return uv0.getCharacterCameraAnimPath(slot0)
		else
			return "effects/animation/room"
		end
	end,
	getCharacterEffectPath = function (slot0)
		if string.nilorempty(slot0) then
			return nil
		end

		return string.format("scenes/m_s07_xiaowu/prefab/vx/%s.prefab", slot0)
	end,
	getCharacterEffectABPath = function (slot0)
		return uv0.getCharacterEffectPath(slot0)
	end,
	getWaterPath = function ()
		return ResUrl.getRoomRes("ground/water/water")
	end,
	getBuildingPath = function (slot0, slot1)
		slot2 = RoomConfig.instance:getBuildingConfig(slot0)
		slot3 = slot2.path

		if slot2.canLevelUp and slot1 and RoomConfig.instance:getLevelGroupConfig(slot0, slot1) and not string.nilorempty(slot4.path) then
			slot3 = slot4.path
		end

		return ResUrl.getRoomRes(slot3)
	end,
	getVehiclePath = function (slot0)
		return ResUrl.getRoomRes(RoomConfig.instance:getVehicleConfig(slot0).path)
	end,
	getPartPathList = function (slot0, slot1)
		if slot1 < 0 then
			return {}
		end

		if not RoomConfig.instance:getLevelGroupConfig(slot0, slot1) then
			return slot2
		end

		if string.nilorempty(slot3.modulePart) then
			return slot2
		end

		for slot8, slot9 in ipairs(string.split(slot4, "#")) do
			table.insert(slot2, ResUrl.getRoomRes(string.format("jianzhu/%s", slot9)))
		end

		return slot2
	end,
	getCritterPath = function (slot0)
		slot1 = nil

		if CritterConfig.instance:getCritterSkinCfg(slot0, true) then
			slot1 = ResUrl.getSpineBxhyPrefab(slot2.spine)
		end

		return slot1
	end,
	getCharacterPath = function (slot0)
		return ResUrl.getSpineBxhyPrefab(SkinConfig.instance:getSkinCo(slot0).spine)
	end,
	getAnimalPath = function (slot0)
		return ResUrl.getSpineBxhyPrefab(SkinConfig.instance:getSkinCo(slot0).alternateSpine)
	end,
	getCritterUIPath = function (slot0)
		return ResUrl.getSpineUIBxhyPrefab(CritterConfig.instance:getCritterSkinCfg(slot0).spine)
	end,
	getBlockName = function (slot0)
		return string.format("%s_%s", slot0.x, slot0.y)
	end,
	getResourcePointName = function (slot0)
		return string.format("%s_%s_%s", slot0.x, slot0.y, slot0.direction)
	end,
	getIndexByResId = function (slot0)
		for slot6 = 1, #RoomResourceEnum.ResourceList do
			if slot1[slot6] == slot0 then
				return slot6
			end
		end

		return -1
	end
}
