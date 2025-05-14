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
	end,
	getMapRiverFloorResPath = function(arg_2_0, arg_2_1)
		arg_2_1 = arg_2_1 or 0

		local var_2_0 = ResUrl.getRoomRes(string.format("heliu_floor/%s/%s", arg_2_1 + 1, arg_2_0))
		local var_2_1 = ResUrl.getRoomResAB(string.format("heliu_floor/%s", arg_2_1 + 1))

		if GameResMgr.IsFromEditorDir then
			var_2_1 = var_2_0
		end

		return var_2_0, var_2_1
	end,
	getBlockPath = function(arg_3_0)
		local var_3_0 = RoomConfig.instance:getBlockDefineConfig(arg_3_0)
		local var_3_1 = var_3_0 and var_3_0.prefabPath or RoomResourceEnum.EmptyPrefabPath

		return string.format("room/block/%s", var_3_1)
	end
}

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

	local var_5_2 = arg_5_1 and var_0_0._ReplaceBlockLandDict or var_0_0._DefaultBlockLandDict

	return var_5_2[arg_5_0] or var_5_2[0], var_5_2[arg_5_0] or var_5_2[0]
end

var_0_0._TransportPathDict = {}

function var_0_0.getTransportPathPath(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or RoomTransportPathEnum.StyleId.Normal

	local var_6_0 = var_0_0._TransportPathDict[arg_6_1]

	if not var_6_0 then
		var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(RoomTransportPathEnum.PathLineType) do
			local var_6_1 = RoomTransportPathEnum.PathLineTypeRes[iter_6_1]

			var_6_0[iter_6_1] = string.format("scenes/m_s07_xiaowu/prefab/transport/%s/%s.prefab", arg_6_1, var_6_1)
		end

		var_0_0._TransportPathDict[arg_6_1] = var_6_0
	end

	return var_6_0[arg_6_0]
end

function var_0_0.getCharacterCameraAnimPath(arg_7_0)
	if string.nilorempty(arg_7_0) then
		return nil
	end

	return string.format("effects/animation/room/%s.controller", arg_7_0)
end

function var_0_0.getCharacterCameraAnimABPath(arg_8_0)
	if string.nilorempty(arg_8_0) then
		return nil
	end

	if GameResMgr.IsFromEditorDir then
		return var_0_0.getCharacterCameraAnimPath(arg_8_0)
	else
		return "effects/animation/room"
	end
end

function var_0_0.getCharacterEffectPath(arg_9_0)
	if string.nilorempty(arg_9_0) then
		return nil
	end

	return string.format("scenes/m_s07_xiaowu/prefab/vx/%s.prefab", arg_9_0)
end

function var_0_0.getCharacterEffectABPath(arg_10_0)
	return var_0_0.getCharacterEffectPath(arg_10_0)
end

function var_0_0.getWaterPath()
	return ResUrl.getRoomRes("ground/water/water")
end

function var_0_0.getBuildingPath(arg_12_0, arg_12_1)
	local var_12_0 = RoomConfig.instance:getBuildingConfig(arg_12_0)
	local var_12_1 = var_12_0.path

	if var_12_0.canLevelUp and arg_12_1 then
		local var_12_2 = RoomConfig.instance:getLevelGroupConfig(arg_12_0, arg_12_1)

		if var_12_2 and not string.nilorempty(var_12_2.path) then
			var_12_1 = var_12_2.path
		end
	end

	return (ResUrl.getRoomRes(var_12_1))
end

function var_0_0.getVehiclePath(arg_13_0)
	local var_13_0 = RoomConfig.instance:getVehicleConfig(arg_13_0).path

	return (ResUrl.getRoomRes(var_13_0))
end

function var_0_0.getPartPathList(arg_14_0, arg_14_1)
	local var_14_0 = {}

	if arg_14_1 < 0 then
		return var_14_0
	end

	local var_14_1 = RoomConfig.instance:getLevelGroupConfig(arg_14_0, arg_14_1)

	if not var_14_1 then
		return var_14_0
	end

	local var_14_2 = var_14_1.modulePart

	if string.nilorempty(var_14_2) then
		return var_14_0
	end

	local var_14_3 = string.split(var_14_2, "#")

	for iter_14_0, iter_14_1 in ipairs(var_14_3) do
		table.insert(var_14_0, ResUrl.getRoomRes(string.format("jianzhu/%s", iter_14_1)))
	end

	return var_14_0
end

function var_0_0.getCritterPath(arg_15_0)
	local var_15_0
	local var_15_1 = CritterConfig.instance:getCritterSkinCfg(arg_15_0, true)

	if var_15_1 then
		var_15_0 = ResUrl.getSpineBxhyPrefab(var_15_1.spine)
	end

	return var_15_0
end

function var_0_0.getCharacterPath(arg_16_0)
	local var_16_0 = SkinConfig.instance:getSkinCo(arg_16_0).spine

	return ResUrl.getSpineBxhyPrefab(var_16_0)
end

function var_0_0.getAnimalPath(arg_17_0)
	local var_17_0 = SkinConfig.instance:getSkinCo(arg_17_0).alternateSpine

	return ResUrl.getSpineBxhyPrefab(var_17_0)
end

function var_0_0.getCritterUIPath(arg_18_0)
	local var_18_0 = CritterConfig.instance:getCritterSkinCfg(arg_18_0).spine

	return ResUrl.getSpineUIBxhyPrefab(var_18_0)
end

function var_0_0.getBlockName(arg_19_0)
	return string.format("%s_%s", arg_19_0.x, arg_19_0.y)
end

function var_0_0.getResourcePointName(arg_20_0)
	return string.format("%s_%s_%s", arg_20_0.x, arg_20_0.y, arg_20_0.direction)
end

function var_0_0.getIndexByResId(arg_21_0)
	local var_21_0 = RoomResourceEnum.ResourceList
	local var_21_1 = #var_21_0

	for iter_21_0 = 1, var_21_1 do
		if var_21_0[iter_21_0] == arg_21_0 then
			return iter_21_0
		end
	end

	return -1
end

return var_0_0
