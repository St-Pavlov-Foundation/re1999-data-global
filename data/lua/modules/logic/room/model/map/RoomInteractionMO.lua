module("modules.logic.room.model.map.RoomInteractionMO", package.seeall)

local var_0_0 = pureTable("RoomInteractionMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.interactionId = arg_1_2
	arg_1_0.config = RoomConfig.instance:getCharacterInteractionConfig(arg_1_0.interactionId)
	arg_1_0.hasInteraction = false
	arg_1_0._interactionRate = arg_1_0.config.rate * 0.001
	arg_1_0._buildingUids = arg_1_3
	arg_1_0._interactionPoint = {}

	arg_1_0:_initBuildingCaramer()
end

function var_0_0._initBuildingCaramer(arg_2_0)
	if not string.nilorempty(arg_2_0.config.buildingCameraIds) then
		arg_2_0._buildingCameraIds = string.splitToNumber(arg_2_0.config.buildingCameraIds, "#")
	else
		arg_2_0._buildingCameraIds = {}
	end

	arg_2_0._buildingNodesDic = {}
	arg_2_0._buildingNodeList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._buildingCameraIds) do
		local var_2_0 = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(iter_2_1)

		if not var_2_0 then
			logError(string.format("[export_角色交互]Id:%s,字段\"buildingCameraIds\"配置了[export_角色建筑交互镜头表]中不存在id:%s", arg_2_0.interactionId, iter_2_1))
		end

		if var_2_0 and not string.nilorempty(var_2_0.nodesXYZ) then
			local var_2_1 = GameUtil.splitString2(var_2_0.nodesXYZ, true)

			arg_2_0._buildingNodesDic[iter_2_1] = var_2_1

			tabletool.addValues(arg_2_0._buildingNodeList, var_2_1)
		end
	end
end

function var_0_0.isCanByRandom(arg_3_0)
	return math.random() <= arg_3_0._interactionRate
end

function var_0_0.getBuildingUids(arg_4_0)
	return arg_4_0._buildingUids
end

function var_0_0.getBuildingCameraIds(arg_5_0)
	return arg_5_0._buildingCameraIds
end

function var_0_0.getBuildingNodeList(arg_6_0)
	return arg_6_0._buildingNodeList
end

function var_0_0.buildingNodesByCId(arg_7_0, arg_7_1)
	return arg_7_0._buildingNodesDic[arg_7_1]
end

function var_0_0.getInteractionPointParam(arg_8_0, arg_8_1)
	return arg_8_0._interactionPoint[arg_8_1]
end

function var_0_0.getBuildingRangeIndexList(arg_9_0, arg_9_1)
	return RoomMapInteractionModel.instance:getBuildingRangeIndexList(arg_9_1)
end

function var_0_0.getInteractionBuilingUidAndCarmeraId(arg_10_0)
	local var_10_0 = RoomCharacterModel.instance:getCharacterMOById(arg_10_0.config.heroId)

	if not var_10_0 or var_10_0:getCurrentInteractionId() ~= nil and var_10_0:getCurrentInteractionId() ~= 0 then
		return nil
	end

	local var_10_1 = arg_10_0:getBuildingUids()

	if not var_10_1 or #var_10_1 < 1 then
		return nil
	end

	local var_10_2 = var_10_0.currentPosition

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_3 = arg_10_0:getBuildingCameraIdByBuildingUid(iter_10_1, var_10_2)

		if var_10_3 then
			return iter_10_1, var_10_3
		end
	end
end

function var_0_0.getBuildingCameraIdByBuildingUid(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = GameSceneMgr.instance:getCurScene()

	if not var_11_0 or not var_11_0.buildingmgr then
		return nil
	end

	local var_11_1 = var_11_0.buildingmgr:getBuildingEntity(arg_11_1, SceneTag.RoomBuilding)

	if not var_11_1 then
		logError(string.format("RoomInteractionMO:getBuildingCameraIdByBuildingUid(buildingUid,posv3) :%s", arg_11_1))

		return nil
	end

	local var_11_2 = arg_11_2.y

	for iter_11_0, iter_11_1 in pairs(arg_11_0._buildingNodesDic) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			local var_11_3 = var_11_1:transformPoint(iter_11_3[1], var_11_2, iter_11_3[3])

			if Vector3.Distance(arg_11_2, var_11_3) <= RoomCharacterEnum.BuilingInteractionNodeRadius then
				return iter_11_0
			end
		end
	end

	return nil
end

function var_0_0.getInteractionBuilingUid(arg_12_0)
	local var_12_0 = RoomCharacterModel.instance:getCharacterMOById(arg_12_0.config.heroId)

	if not var_12_0 or var_12_0:getCurrentInteractionId() ~= nil and var_12_0:getCurrentInteractionId() ~= 0 then
		return nil
	end

	local var_12_1 = arg_12_0:getBuildingUids()

	if not var_12_1 or #var_12_1 < 1 then
		return nil
	end

	local var_12_2 = var_12_0.currentPosition
	local var_12_3 = Vector2(var_12_2.x, var_12_2.z)
	local var_12_4 = HexMath.positionToRoundHex(var_12_3, RoomBlockEnum.BlockSize)
	local var_12_5 = RoomResourceModel.instance:getIndexByXY(var_12_4.x, var_12_4.y)

	for iter_12_0 = 1, #var_12_1 do
		local var_12_6 = var_12_1[iter_12_0]
		local var_12_7 = RoomMapBuildingModel.instance:getBuildingMOById(var_12_6)

		if var_12_7 and (var_12_7:getCurrentInteractionId() == nil or var_12_7:getCurrentInteractionId() == 0) then
			local var_12_8 = arg_12_0:getBuildingRangeIndexList(var_12_6)

			if var_12_8 and tabletool.indexOf(var_12_8, var_12_5) then
				return var_12_6
			end
		end
	end

	return nil
end

return var_0_0
