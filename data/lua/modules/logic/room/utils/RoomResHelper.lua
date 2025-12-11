module("modules.logic.room.utils.RoomResHelper", package.seeall)

local var_0_0 = {
	getMapBlockResPath = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_0 == RoomResourceEnum.ResourceId.None or arg_1_0 == RoomResourceEnum.ResourceId.Empty then
			return nil
		end

		local var_1_0 = RoomResourceEnum.ResourceRes[arg_1_0]

		if arg_1_0 == RoomResourceEnum.ResourceId.River then
			arg_1_2 = arg_1_2 or 0

			local var_1_1 = ResUrl.getRoomRes(string.format("%s/%s/%s", var_1_0, arg_1_2 + 1, arg_1_1))
			local var_1_2 = ResUrl.getRoomResAB(string.format("%s/%s", var_1_0, arg_1_2 + 1))

			if GameResMgr.IsFromEditorDir then
				var_1_2 = ResUrl.getRoomRes(string.format("%s/%s/%s", var_1_0, arg_1_2 + 1, arg_1_1))
			end

			return var_1_1, var_1_2
		end

		return nil
	end
}

function var_0_0.getMapRiverFloorResPath(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or 0

	local var_2_0 = var_0_0._getBlockType(arg_2_1)
	local var_2_1 = ResUrl.getRoomRes(string.format("heliu_floor/%s/%s", var_2_0 + 1, arg_2_0))
	local var_2_2 = ResUrl.getRoomResAB(string.format("heliu_floor/%s", var_2_0 + 1))

	if GameResMgr.IsFromEditorDir then
		var_2_2 = var_2_1
	end

	return var_2_1, var_2_2
end

function var_0_0.getBlockPath(arg_3_0)
	local var_3_0 = RoomConfig.instance:getBlockDefineConfig(arg_3_0)
	local var_3_1 = var_3_0 and var_3_0.prefabPath or RoomResourceEnum.EmptyPrefabPath

	return string.format("room/block/%s", var_3_1)
end

function var_0_0.getBlockABPath(arg_4_0)
	if GameResMgr.IsFromEditorDir then
		return var_0_0.getBlockPath(arg_4_0)
	else
		local var_4_0 = RoomConfig.instance:getBlockDefineConfig(arg_4_0)
		local var_4_1 = var_4_0 and var_4_0.prefabPath or RoomResourceEnum.EmptyPrefabPath
		local var_4_2 = string.split(var_4_1, "/")[1]

		return string.format("room/block/%s", var_4_2)
	end
end

function var_0_0.getBlockLandPath(arg_5_0, arg_5_1)
	if not var_0_0._DefaultBlockLandDict then
		var_0_0._DefaultBlockLandDict = {}
		var_0_0._ReplaceBlockLandDict = {}

		for iter_5_0, iter_5_1 in ipairs(lua_block.propertyList.blockType) do
			local var_5_0
			local var_5_1 = iter_5_1 + 2

			if var_5_1 < 10 then
				var_5_0 = "0" .. var_5_1
			else
				var_5_0 = var_5_1
			end

			var_0_0._DefaultBlockLandDict[iter_5_1] = string.format("scenes/m_s07_xiaowu/prefab/ground/floor/%s.prefab", var_5_0)
			var_0_0._ReplaceBlockLandDict[iter_5_1] = string.format("scenes/m_s07_xiaowu/prefab/ground/floor/%sb.prefab", var_5_0)
		end

		var_0_0._DefaultBlockLandDict[0] = RoomScenePreloader.DefaultLand
		var_0_0._ReplaceBlockLandDict[0] = RoomScenePreloader.ReplaceLand
	end

	local var_5_2 = var_0_0._getBlockType(arg_5_0)
	local var_5_3 = arg_5_1 and var_0_0._ReplaceBlockLandDict or var_0_0._DefaultBlockLandDict

	return var_5_3[var_5_2] or var_5_3[0], var_5_3[var_5_2] or var_5_3[0]
end

function var_0_0._getBlockType(arg_6_0)
	if arg_6_0 >= 10000 then
		return math.floor(arg_6_0 % 10000)
	end

	return arg_6_0
end

var_0_0._TransportPathDict = {}

function var_0_0.getTransportPathPath(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or RoomTransportPathEnum.StyleId.Normal

	local var_7_0 = var_0_0._TransportPathDict[arg_7_1]

	if not var_7_0 then
		var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(RoomTransportPathEnum.PathLineType) do
			local var_7_1 = RoomTransportPathEnum.PathLineTypeRes[iter_7_1]

			var_7_0[iter_7_1] = string.format("scenes/m_s07_xiaowu/prefab/transport/%s/%s.prefab", arg_7_1, var_7_1)
		end

		var_0_0._TransportPathDict[arg_7_1] = var_7_0
	end

	return var_7_0[arg_7_0]
end

function var_0_0.getCharacterCameraAnimPath(arg_8_0)
	if string.nilorempty(arg_8_0) then
		return nil
	end

	return string.format("effects/animation/room/%s.controller", arg_8_0)
end

function var_0_0.getCharacterCameraAnimABPath(arg_9_0)
	if string.nilorempty(arg_9_0) then
		return nil
	end

	if GameResMgr.IsFromEditorDir then
		return var_0_0.getCharacterCameraAnimPath(arg_9_0)
	else
		return "effects/animation/room"
	end
end

function var_0_0.getCharacterEffectPath(arg_10_0)
	if string.nilorempty(arg_10_0) then
		return nil
	end

	return string.format("scenes/m_s07_xiaowu/prefab/vx/%s.prefab", arg_10_0)
end

function var_0_0.getCharacterEffectABPath(arg_11_0)
	return var_0_0.getCharacterEffectPath(arg_11_0)
end

function var_0_0.getWaterPath()
	return ResUrl.getRoomRes("ground/water/water")
end

function var_0_0.getBuildingPath(arg_13_0, arg_13_1)
	local var_13_0 = RoomConfig.instance:getBuildingConfig(arg_13_0)
	local var_13_1 = var_13_0.path

	if var_13_0.canLevelUp and arg_13_1 then
		local var_13_2 = RoomConfig.instance:getLevelGroupConfig(arg_13_0, arg_13_1)

		if var_13_2 and not string.nilorempty(var_13_2.path) then
			var_13_1 = var_13_2.path
		end
	end

	return (ResUrl.getRoomRes(var_13_1))
end

function var_0_0.getVehiclePath(arg_14_0)
	local var_14_0 = RoomConfig.instance:getVehicleConfig(arg_14_0).path

	return (ResUrl.getRoomRes(var_14_0))
end

function var_0_0.getPartPathList(arg_15_0, arg_15_1)
	local var_15_0 = {}

	if arg_15_1 < 0 then
		return var_15_0
	end

	local var_15_1 = RoomConfig.instance:getLevelGroupConfig(arg_15_0, arg_15_1)

	if not var_15_1 then
		return var_15_0
	end

	local var_15_2 = var_15_1.modulePart

	if string.nilorempty(var_15_2) then
		return var_15_0
	end

	local var_15_3 = string.split(var_15_2, "#")

	for iter_15_0, iter_15_1 in ipairs(var_15_3) do
		table.insert(var_15_0, ResUrl.getRoomRes(string.format("jianzhu/%s", iter_15_1)))
	end

	return var_15_0
end

function var_0_0.getCritterPath(arg_16_0)
	local var_16_0
	local var_16_1 = CritterConfig.instance:getCritterSkinCfg(arg_16_0, true)

	if var_16_1 then
		var_16_0 = ResUrl.getSpineBxhyPrefab(var_16_1.spine)
	end

	return var_16_0
end

function var_0_0.getCharacterPath(arg_17_0)
	local var_17_0 = SkinConfig.instance:getSkinCo(arg_17_0).spine

	return ResUrl.getSpineBxhyPrefab(var_17_0)
end

function var_0_0.getAnimalPath(arg_18_0)
	local var_18_0 = SkinConfig.instance:getSkinCo(arg_18_0).alternateSpine

	return ResUrl.getSpineBxhyPrefab(var_18_0)
end

function var_0_0.getCritterUIPath(arg_19_0)
	local var_19_0 = CritterConfig.instance:getCritterSkinCfg(arg_19_0).spine

	return ResUrl.getSpineUIBxhyPrefab(var_19_0)
end

function var_0_0.getBlockName(arg_20_0)
	return string.format("%s_%s", arg_20_0.x, arg_20_0.y)
end

function var_0_0.getResourcePointName(arg_21_0)
	return string.format("%s_%s_%s", arg_21_0.x, arg_21_0.y, arg_21_0.direction)
end

function var_0_0.getIndexByResId(arg_22_0)
	local var_22_0 = RoomResourceEnum.ResourceList
	local var_22_1 = #var_22_0

	for iter_22_0 = 1, var_22_1 do
		if var_22_0[iter_22_0] == arg_22_0 then
			return iter_22_0
		end
	end

	return -1
end

return var_0_0
