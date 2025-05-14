module("modules.logic.room.utils.RoomBendingHelper", package.seeall)

local var_0_0 = {}

var_0_0.bendingAmount = 0
var_0_0.bendingPosition = Vector3(0, 0, 0)
var_0_0._bendingPosX = 0
var_0_0._bendingPosY = 0
var_0_0._bendingPosZ = 0

function var_0_0.setBendingAmount(arg_1_0)
	var_0_0.bendingAmount = arg_1_0
end

function var_0_0.setBendingPosition(arg_2_0)
	var_0_0.bendingPosition = arg_2_0
	var_0_0._bendingPosX = arg_2_0.x
	var_0_0._bendingPosY = arg_2_0.y
	var_0_0._bendingPosZ = arg_2_0.z
end

function var_0_0.worldToBendingSimple(arg_3_0)
	return var_0_0.worldToBending(arg_3_0, true)
end

local var_0_1
local var_0_2
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 0

function var_0_0.getCameraPos()
	if not var_0_1 or UnityEngine.Time.frameCount ~= var_0_2 then
		var_0_1 = CameraMgr.instance:getMainCameraTrs().position
		var_0_2 = UnityEngine.Time.frameCount
		var_0_3, var_0_4, var_0_5 = var_0_1.x, var_0_1.y, var_0_1.z
	end

	return var_0_1
end

function var_0_0.getCameraPosXYZ()
	var_0_0.getCameraPos()

	return var_0_3, var_0_4, var_0_5
end

local var_0_6
local var_0_7

function var_0_0.getCameraEuler()
	if not var_0_6 or UnityEngine.Time.frameCount ~= var_0_7 then
		var_0_6 = CameraMgr.instance:getMainCameraTrs().eulerAngles
		var_0_7 = UnityEngine.Time.frameCount
	end

	return var_0_6
end

function var_0_0.worldToBending(arg_7_0, arg_7_1)
	return var_0_0.worldXYZToBending(arg_7_0.x, arg_7_0.y, arg_7_0.z, arg_7_1)
end

function var_0_0.worldXYZToBending(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0, var_8_1, var_8_2, var_8_3, var_8_4, var_8_5, var_8_6, var_8_7, var_8_8 = var_0_0.worldXYZToBendingXYZ(arg_8_0, arg_8_1, arg_8_2, arg_8_3)

	if arg_8_3 then
		return Vector3(var_8_0, var_8_1, var_8_2)
	end

	local var_8_9 = Quaternion.New()

	var_8_9:SetEuler(var_8_3, var_8_4, var_8_5)

	return Vector3(var_8_0, var_8_1, var_8_2), var_8_9, Vector3(var_8_6, var_8_7, var_8_8)
end

function var_0_0.worldToBendingXYZ(arg_9_0, arg_9_1)
	return var_0_0.worldXYZToBendingXYZ(arg_9_0.x, arg_9_0.y, arg_9_0.z, arg_9_1)
end

function var_0_0.worldXYZToBendingXYZ(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = var_0_0.getCameraEuler()
	local var_10_1 = var_10_0.y
	local var_10_2 = var_0_0._bendingPosX
	local var_10_3 = var_0_0._bendingPosY
	local var_10_4 = var_0_0._bendingPosZ
	local var_10_5 = arg_10_0 - var_10_2
	local var_10_6 = arg_10_1 - var_10_3
	local var_10_7 = arg_10_2 - var_10_4
	local var_10_8 = var_10_5 * math.cos(Mathf.Deg2Rad * var_10_1) - var_10_7 * math.sin(Mathf.Deg2Rad * var_10_1)
	local var_10_9 = var_10_7 * math.cos(Mathf.Deg2Rad * var_10_1) + var_10_5 * math.sin(Mathf.Deg2Rad * var_10_1)
	local var_10_10 = var_10_8 * var_10_8 * var_0_0.bendingAmount * 0.08
	local var_10_11 = var_10_9 * var_10_9 * var_0_0.bendingAmount * 0.08
	local var_10_12 = var_10_10 + var_10_11

	if arg_10_3 then
		return arg_10_0, arg_10_1 - var_10_12, arg_10_2
	end

	local var_10_13 = var_10_8 == 0 and 0 or Mathf.Rad2Deg * math.atan(var_10_10 / var_10_8)
	local var_10_14 = var_10_1
	local var_10_15 = var_10_9 == 0 and 0 or Mathf.Rad2Deg * math.atan(var_10_11 / var_10_9)
	local var_10_16 = -var_10_13
	local var_10_17, var_10_18, var_10_19 = var_0_0.getCameraPosXYZ()
	local var_10_20 = arg_10_0 - var_10_17
	local var_10_21 = arg_10_1 - var_10_18
	local var_10_22 = arg_10_2 - var_10_19
	local var_10_23 = var_10_20 * math.cos(Mathf.Deg2Rad * var_10_1) - var_10_22 * math.sin(Mathf.Deg2Rad * var_10_1)
	local var_10_24 = var_10_22 * math.cos(Mathf.Deg2Rad * var_10_1) + var_10_20 * math.sin(Mathf.Deg2Rad * var_10_1)
	local var_10_25 = var_10_24 == 0 and 0 or Mathf.Rad2Deg * math.atan(var_10_23 / var_10_24)
	local var_10_26 = var_10_0.x * 0.7
	local var_10_27 = var_10_25 * 0.5
	local var_10_28 = 0

	return arg_10_0, arg_10_1 - var_10_12, arg_10_2, var_10_16, var_10_14, var_10_15, var_10_26, var_10_27, var_10_28
end

function var_0_0.bendingToWorld(arg_11_0)
	local var_11_0 = arg_11_0 - var_0_0.bendingPosition
	local var_11_1 = var_11_0.z * var_11_0.z * var_0_0.bendingAmount * 0.08
	local var_11_2 = var_11_0.x * var_11_0.x * var_0_0.bendingAmount * 0.08

	return Vector3(arg_11_0.x, arg_11_0.y + var_11_1 + var_11_2, arg_11_0.z)
end

function var_0_0.screenToWorld(arg_12_0)
	local var_12_0 = var_0_0.screenPosToRay(arg_12_0)
	local var_12_1 = -var_0_0.bendingAmount * 0.08
	local var_12_2 = var_0_0.bendingPosition
	local var_12_3 = var_12_0.origin

	var_12_3.y = var_12_3.y - 0.1

	local var_12_4 = var_12_0.direction

	if var_12_4.y >= 0 then
		return nil
	end

	local var_12_5 = var_12_3 - var_12_2
	local var_12_6 = var_0_0.getCameraEuler().y * Mathf.Deg2Rad
	local var_12_7 = math.sin(var_12_6)
	local var_12_8 = math.cos(var_12_6)
	local var_12_9 = Vector3(var_12_5.x * var_12_8 - var_12_5.z * var_12_7, var_12_5.y, var_12_5.z * var_12_8 + var_12_5.x * var_12_7)
	local var_12_10 = Vector3(var_12_4.x * var_12_8 - var_12_4.z * var_12_7, var_12_4.y, var_12_4.z * var_12_8 + var_12_4.x * var_12_7)
	local var_12_11 = var_12_10.x * var_12_10.x + var_12_10.z * var_12_10.z
	local var_12_12 = 2 * var_12_9.x * var_12_10.x + 2 * var_12_9.z * var_12_10.z - var_12_10.y / var_12_1
	local var_12_13 = var_12_9.x * var_12_9.x + var_12_9.z * var_12_9.z - var_12_9.y / var_12_1
	local var_12_14 = 0

	if var_12_11 == 0 then
		var_12_14 = -var_12_13 / var_12_12
	else
		local var_12_15 = var_12_12 * var_12_12 - 4 * var_12_11 * var_12_13

		if var_12_15 < 0 then
			return nil
		end

		local var_12_16 = math.abs(math.sqrt(var_12_15))
		local var_12_17 = (-var_12_12 + var_12_16) / (2 * var_12_11)
		local var_12_18 = (-var_12_12 - var_12_16) / (2 * var_12_11)

		if math.abs(var_12_17) < math.abs(var_12_18) then
			var_12_14 = var_12_17
		else
			var_12_14 = var_12_18
		end
	end

	if var_12_14 <= 0 then
		return nil
	end

	return (Vector2(var_12_3.x + var_12_14 * var_12_4.x, var_12_3.z + var_12_14 * var_12_4.z))
end

function var_0_0.screenPosToHex(arg_13_0)
	local var_13_0 = var_0_0.screenToWorld(arg_13_0)

	if var_13_0 then
		return HexMath.positionToRoundHex(var_13_0, RoomBlockEnum.BlockSize)
	end
end

function var_0_0.getRaycastEntity(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0.screenPosToRay(arg_14_0)
	local var_14_1 = RoomMapBuildingModel.instance:getBuildingMOList()
	local var_14_2, var_14_3 = UnityEngine.Physics.Raycast(var_14_0.origin, var_14_0.direction, nil, 10, LayerMask.GetMask("SceneOpaque"))

	if not var_14_2 then
		return nil
	end

	local var_14_4 = var_14_3.transform
	local var_14_5 = GameSceneMgr.instance:getCurScene()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1.buildingState == RoomBuildingEnum.BuildingState.Map or arg_14_1 and (iter_14_1.buildingState == RoomBuildingEnum.BuildingState.Temp or iter_14_1.buildingState == RoomBuildingEnum.BuildingState.Revert) then
			local var_14_6 = var_14_5.buildingmgr:getBuildingEntity(iter_14_1.id, SceneTag.RoomBuilding)

			if var_14_6 and var_14_4:IsChildOf(var_14_6.goTrs) then
				return RoomEnum.TouchTab.RoomBuilding, iter_14_1.id
			end
		end
	end

	local var_14_7 = var_14_5.buildingmgr:getInitBuildingGO()

	if var_14_7 and var_14_4:IsChildOf(var_14_7.transform) then
		return RoomEnum.TouchTab.RoomInitBuilding, 0
	end

	for iter_14_2, iter_14_3 in ipairs(lua_production_part.configList) do
		local var_14_8 = var_14_5.buildingmgr:getPartContainerGO(iter_14_2)

		if var_14_8 and var_14_4:IsChildOf(var_14_8.transform) then
			return RoomEnum.TouchTab.RoomPartBuilding, iter_14_2
		end
	end

	local var_14_9 = RoomCharacterModel.instance:getList()

	for iter_14_4, iter_14_5 in ipairs(var_14_9) do
		if iter_14_5.characterState == RoomCharacterEnum.CharacterState.Map or arg_14_1 and (iter_14_5.characterState == RoomCharacterEnum.CharacterState.Temp or iter_14_5.characterState == RoomCharacterEnum.CharacterState.Revert) then
			local var_14_10 = var_14_5.charactermgr:getCharacterEntity(iter_14_5.id, SceneTag.RoomCharacter)

			if var_14_10 and var_14_4:IsChildOf(var_14_10.goTrs) then
				return RoomEnum.TouchTab.RoomCharacter, iter_14_5.id
			end
		end
	end

	local var_14_11 = RoomCritterModel.instance:getAllCritterList()

	for iter_14_6, iter_14_7 in ipairs(var_14_11) do
		local var_14_12 = var_14_5.crittermgr:getCritterEntity(iter_14_7.id, SceneTag.RoomCharacter) or var_14_5.buildingcrittermgr:getCritterEntity(iter_14_7.id, SceneTag.RoomCharacter)

		if var_14_12 and var_14_4:IsChildOf(var_14_12.goTrs) then
			return RoomEnum.TouchTab.RoomCritter, iter_14_7.id
		end
	end

	local var_14_13 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_14_8 = 1, #var_14_13 do
		local var_14_14 = var_14_13[iter_14_8]
		local var_14_15 = var_14_5.sitemgr:getSiteEntity(var_14_14)

		if var_14_15 and var_14_4:IsChildOf(var_14_15.goTrs) then
			return RoomEnum.TouchTab.RoomTransportSite, var_14_14
		end

		local var_14_16 = RoomMapVehicleModel.instance:getVehicleIdBySiteType(var_14_14)
		local var_14_17 = var_14_5.vehiclemgr:getVehicleEntity(var_14_16)

		if var_14_17 and var_14_4:IsChildOf(var_14_17.goTrs) then
			return RoomEnum.TouchTab.RoomTransportSite, var_14_14
		end
	end

	return nil
end

function var_0_0.screenPosToRay(arg_15_0)
	return (GameSceneMgr.instance:getCurScene().camera.camera:ScreenPointToRay(arg_15_0))
end

function var_0_0.worldPosToAnchorPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_2 = arg_16_2 or CameraMgr.instance:getUICamera()
	arg_16_3 = arg_16_3 or CameraMgr.instance:getMainCamera()

	local var_16_0 = arg_16_3:WorldToScreenPoint(arg_16_0)

	if var_16_0.z < 0 then
		return nil
	else
		local var_16_1 = Vector2.New(0, 0)
		local var_16_2, var_16_3 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_16_1, var_16_0, arg_16_2, var_16_1)

		if var_16_2 then
			return var_16_3
		else
			return nil
		end
	end
end

return var_0_0
