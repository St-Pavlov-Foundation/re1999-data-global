module("modules.logic.room.utils.RoomBendingHelper", package.seeall)

slot1, slot2 = nil
slot3, slot4 = nil

return {
	bendingAmount = 0,
	bendingPosition = Vector3(0, 0, 0),
	setBendingAmount = function (slot0)
		uv0.bendingAmount = slot0
	end,
	setBendingPosition = function (slot0)
		uv0.bendingPosition = slot0
	end,
	worldToBendingSimple = function (slot0)
		return uv0.worldToBending(slot0, true)
	end,
	getCameraPos = function ()
		if not uv0 or UnityEngine.Time.frameCount ~= uv1 then
			uv0 = CameraMgr.instance:getMainCameraTrs().position
			uv1 = UnityEngine.Time.frameCount
		end

		return uv0
	end,
	getCameraEuler = function ()
		if not uv0 or UnityEngine.Time.frameCount ~= uv1 then
			uv0 = CameraMgr.instance:getMainCameraTrs().eulerAngles
			uv1 = UnityEngine.Time.frameCount
		end

		return uv0
	end,
	worldToBending = function (slot0, slot1)
		slot2 = uv0.getCameraEuler()
		slot4 = slot0 - uv0.bendingPosition

		slot4:Set(slot4.x * math.cos(Mathf.Deg2Rad * slot2.y) - slot4.z * math.sin(Mathf.Deg2Rad * slot2.y), 0, slot4.z * math.cos(Mathf.Deg2Rad * slot2.y) + slot4.x * math.sin(Mathf.Deg2Rad * slot2.y))

		slot9 = slot4.x * slot4.x * uv0.bendingAmount * 0.08 + slot4.z * slot4.z * uv0.bendingAmount * 0.08

		if slot1 then
			slot4:Set(slot0.x, slot0.y - slot9, slot0.z)

			return slot4
		end

		slot10 = Vector3(slot4.x == 0 and 0 or Mathf.Rad2Deg * math.atan(slot7 / slot4.x), slot2.y, slot4.z == 0 and 0 or Mathf.Rad2Deg * math.atan(slot8 / slot4.z))

		Quaternion.New():SetEuler(slot10.z, slot10.y, -slot10.x)

		slot13 = slot0 - uv0.getCameraPos()

		slot13:Set(slot13.x * math.cos(Mathf.Deg2Rad * slot2.y) - slot13.z * math.sin(Mathf.Deg2Rad * slot2.y), 0, slot13.z * math.cos(Mathf.Deg2Rad * slot2.y) + slot13.x * math.sin(Mathf.Deg2Rad * slot2.y))
		slot13:Set(slot0.x, slot0.y - slot9, slot0.z)

		return slot13, slot11, Vector3(slot2.x * 0.7, (slot13.z == 0 and 0 or Mathf.Rad2Deg * math.atan(slot13.x / slot13.z)) * 0.5, 0)
	end,
	bendingToWorld = function (slot0)
		slot2 = slot0 - uv0.bendingPosition

		return Vector3(slot0.x, slot0.y + slot2.z * slot2.z * uv0.bendingAmount * 0.08 + slot2.x * slot2.x * uv0.bendingAmount * 0.08, slot0.z)
	end,
	screenToWorld = function (slot0)
		slot1 = uv0.screenPosToRay(slot0)
		slot2 = -uv0.bendingAmount * 0.08
		slot3 = uv0.bendingPosition
		slot4 = slot1.origin
		slot4.y = slot4.y - 0.1

		if slot1.direction.y >= 0 then
			return nil
		end

		slot6 = slot4 - slot3
		slot8 = uv0.getCameraEuler().y * Mathf.Deg2Rad
		slot9 = math.sin(slot8)
		slot10 = math.cos(slot8)
		slot11 = Vector3(slot6.x * slot10 - slot6.z * slot9, slot6.y, slot6.z * slot10 + slot6.x * slot9)
		slot12 = Vector3(slot5.x * slot10 - slot5.z * slot9, slot5.y, slot5.z * slot10 + slot5.x * slot9)
		slot16 = 0

		if slot12.x * slot12.x + slot12.z * slot12.z == 0 then
			slot16 = -(slot11.x * slot11.x + slot11.z * slot11.z - slot11.y / slot2) / (2 * slot11.x * slot12.x + 2 * slot11.z * slot12.z - slot12.y / slot2)
		else
			if slot14 * slot14 - 4 * slot13 * slot15 < 0 then
				return nil
			end

			slot18 = math.abs(math.sqrt(slot17))
			slot16 = math.abs((-slot14 + slot18) / (2 * slot13)) < math.abs((-slot14 - slot18) / (2 * slot13)) and slot19 or slot20
		end

		if slot16 <= 0 then
			return nil
		end

		return Vector2(slot4.x + slot16 * slot5.x, slot4.z + slot16 * slot5.z)
	end,
	screenPosToHex = function (slot0)
		if uv0.screenToWorld(slot0) then
			return HexMath.positionToRoundHex(slot1, RoomBlockEnum.BlockSize)
		end
	end,
	getRaycastEntity = function (slot0, slot1)
		slot2 = uv0.screenPosToRay(slot0)
		slot3 = RoomMapBuildingModel.instance:getBuildingMOList()
		slot4, slot5 = UnityEngine.Physics.Raycast(slot2.origin, slot2.direction, nil, 10, LayerMask.GetMask("SceneOpaque"))

		if not slot4 then
			return nil
		end

		slot6 = slot5.transform
		slot7 = GameSceneMgr.instance:getCurScene()

		for slot11, slot12 in ipairs(slot3) do
			if (slot12.buildingState == RoomBuildingEnum.BuildingState.Map or slot1 and (slot12.buildingState == RoomBuildingEnum.BuildingState.Temp or slot12.buildingState == RoomBuildingEnum.BuildingState.Revert)) and slot7.buildingmgr:getBuildingEntity(slot12.id, SceneTag.RoomBuilding) and slot6:IsChildOf(slot13.goTrs) then
				return RoomEnum.TouchTab.RoomBuilding, slot12.id
			end
		end

		if slot7.buildingmgr:getInitBuildingGO() and slot6:IsChildOf(slot8.transform) then
			return RoomEnum.TouchTab.RoomInitBuilding, 0
		end

		for slot12, slot13 in ipairs(lua_production_part.configList) do
			if slot7.buildingmgr:getPartContainerGO(slot12) and slot6:IsChildOf(slot14.transform) then
				return RoomEnum.TouchTab.RoomPartBuilding, slot12
			end
		end

		for slot13, slot14 in ipairs(RoomCharacterModel.instance:getList()) do
			if (slot14.characterState == RoomCharacterEnum.CharacterState.Map or slot1 and (slot14.characterState == RoomCharacterEnum.CharacterState.Temp or slot14.characterState == RoomCharacterEnum.CharacterState.Revert)) and slot7.charactermgr:getCharacterEntity(slot14.id, SceneTag.RoomCharacter) and slot6:IsChildOf(slot15.goTrs) then
				return RoomEnum.TouchTab.RoomCharacter, slot14.id
			end
		end

		for slot14, slot15 in ipairs(RoomCritterModel.instance:getAllCritterList()) do
			if (slot7.crittermgr:getCritterEntity(slot15.id, SceneTag.RoomCharacter) or slot7.buildingcrittermgr:getCritterEntity(slot15.id, SceneTag.RoomCharacter)) and slot6:IsChildOf(slot16.goTrs) then
				return RoomEnum.TouchTab.RoomCritter, slot15.id
			end
		end

		for slot15 = 1, #RoomTransportHelper.getSiteBuildingTypeList() do
			if slot7.sitemgr:getSiteEntity(slot11[slot15]) and slot6:IsChildOf(slot17.goTrs) then
				return RoomEnum.TouchTab.RoomTransportSite, slot16
			end

			if slot7.vehiclemgr:getVehicleEntity(RoomMapVehicleModel.instance:getVehicleIdBySiteType(slot16)) and slot6:IsChildOf(slot19.goTrs) then
				return RoomEnum.TouchTab.RoomTransportSite, slot16
			end
		end

		return nil
	end,
	screenPosToRay = function (slot0)
		return GameSceneMgr.instance:getCurScene().camera.camera:ScreenPointToRay(slot0)
	end,
	worldPosToAnchorPos = function (slot0, slot1, slot2, slot3)
		slot2 = slot2 or CameraMgr.instance:getUICamera()

		if (slot3 or CameraMgr.instance:getMainCamera()):WorldToScreenPoint(slot0).z < 0 then
			return nil
		else
			slot6, slot7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot1, slot4, slot2, Vector2.New(0, 0))

			if slot6 then
				return slot7
			else
				return nil
			end
		end
	end
}
