module("modules.logic.scene.room.comp.RoomSceneCameraFOVBlockComp", package.seeall)

slot0 = class("RoomSceneCameraFOVBlockComp", BaseSceneComp)
slot1 = {
	Building = 2,
	Hero = 1,
	Vehicle = 3
}
slot2 = {
	_SCREENCOORD = "_SCREENCOORD"
}
slot4 = {
	alphaThreshold = UnityEngine.Shader.PropertyToID("_AlphaThreshold")
}

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	TaskDispatcher.runRepeat(slot0._onUpdate, slot0, 0.1)

	slot0._buildingPosListMap = nil
end

function slot0._onUpdate(slot0)
	if RoomController.instance:isEditMode() then
		return
	end

	slot0:_updateEntityFovBlock()
end

function slot0._checkIsNeedUpdateBlock(slot0)
	if slot0:_getPlayingInteractionParam() then
		if slot0._isCameraChange then
			return true
		end
	elseif not slot0._lastOpenNum or slot0._lastOpenNum == 0 then
		return true
	end

	return false
end

function slot0._updateEntityFovBlock(slot0)
	if not slot0:_getPlayingInteractionParam() and (not slot0._lastOpenNum or slot0._lastOpenNum == 0) then
		return
	end

	slot0._lastOpenNum = 0
	slot2 = GameSceneMgr.instance:getCurScene()
	slot4 = {}

	for slot8, slot9 in ipairs(RoomCharacterHelper.getAllBlockMeshRendererList()) do
		table.insert(slot4, slot9:GetInstanceID())
	end

	slot0._lastMeshReaderDic = {}
	slot9 = uv0._SCREENCOORD

	for slot14, slot15 in ipairs(slot3) do
		if slot0:_getBlockMeshRendererDict(slot3, slot4)[slot4[slot14]] and slot17 > 0 then
			slot0._lastOpenNum = slot0._lastOpenNum + 1

			if (slot0._lastMeshReaderDic or {})[slot16] ~= slot17 then
				if not nil then
					slot6 = slot2.mapmgr:getPropertyBlock()

					slot6:Clear()
					slot6:SetFloat(uv1.alphaThreshold, slot17)
				end

				MaterialReplaceHelper.SetRendererKeyworld(slot15, slot9, true)
				slot15:SetPropertyBlock(slot6)
			end

			slot8[slot16] = slot17
		elseif slot7[slot16] then
			MaterialReplaceHelper.SetRendererKeyworld(slot15, slot9, false)
			slot15:SetPropertyBlock(nil)
		end
	end
end

function slot0._getBlockMeshRendererDict(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() then
		return {}
	end

	slot4, slot5 = slot0:_getPlayingInteractionParam()

	if not slot4 then
		return slot3
	end

	slot0:_addBlockPositionById(slot5, slot4, {})

	if #slot1 <= 0 or #slot6 <= 0 then
		return slot3
	end

	slot7 = slot0._scene.camera:getCameraPosition()

	for slot13, slot14 in pairs(slot6) do
		slot15 = RoomBendingHelper.worldToBendingSimple(slot14)

		table.insert({}, Ray(Vector3.Normalize(slot15 - slot7), slot7))
		table.insert({}, Vector3.Distance(slot7, slot15))
	end

	slot10 = nil

	if uv0.Hero == slot5 then
		slot10 = slot4.buildingUid
	elseif uv0.Building == slot5 then
		slot10 = slot4
	end

	if #slot8 > 0 then
		slot15 = {}

		slot0:_addBuildingMeshRendererIdDict(slot10, slot15)

		for slot15, slot16 in ipairs(slot1) do
			if not slot11[slot2[slot15]] and RoomCharacterHelper.isBlockCharacter(slot8, slot9, slot16) then
				slot3[slot17] = 0.6
			end
		end
	end

	return slot3
end

function slot0._addBlockPositionById(slot0, slot1, slot2, slot3)
	if not slot0._blockTypeFuncMap then
		slot0._blockTypeFuncMap = {
			[uv0.Hero] = slot0._addHeroPosFunc,
			[uv0.Building] = slot0._addBuildingPosFunc,
			[uv0.Vehicle] = slot0._addVehiclePosFunc
		}
	end

	if slot0._blockTypeFuncMap[slot1] then
		slot4(slot0, slot2, slot3)
	end
end

function slot0._addVehiclePosFunc(slot0, slot1, slot2)
	if slot0._scene.vehiclemgr:getVehicleEntity(slot1) then
		slot4, slot5, slot6 = transformhelper.getPos(slot3.goTrs)

		table.insert(slot2, Vector3(slot4, slot5, slot6))

		slot7, slot8, slot9 = slot3.cameraFollowTargetComp:getPositionXYZ()

		table.insert(slot2, Vector3(slot7, slot8, slot9))
	end
end

function slot0._addBuildingPosFunc(slot0, slot1, slot2)
	slot0._buildingPosListMap = slot0._buildingPosListMap or {}

	if not slot0._buildingPosListMap[slot1] then
		slot0._buildingPosListMap[slot1] = {}

		if slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) and slot4:getBodyGO() then
			slot6, slot7, slot8 = transformhelper.getPos(slot5.transform)

			table.insert(slot3, Vector3(slot6, slot7, slot8))
		end

		if RoomMapBuildingModel.instance:getBuildingMOById(slot1) and RoomMapModel.instance:getBuildingPointList(slot5.buildingId, slot5.rotate) and slot5 then
			for slot10, slot11 in ipairs(slot6) do
				slot12, slot13 = HexMath.hexXYToPosXY(slot11.x + slot5.hexPoint.x, slot11.y + slot5.hexPoint.y, RoomBlockEnum.BlockSize)

				table.insert(slot3, Vector3(slot12, 0.11, slot13))
			end
		end
	end

	tabletool.addValues(slot2, slot3)
end

function slot0._addHeroPosFunc(slot0, slot1, slot2)
	slot0:_addCharacterPosById(slot1.heroId, slot2)
	slot0:_addCharacterPosById(slot1.relateHeroId, slot2)
end

function slot0._addCharacterPosById(slot0, slot1, slot2)
	if slot0._scene.charactermgr:getCharacterEntity(slot1, SceneTag.RoomCharacter) then
		slot4, slot5, slot6 = transformhelper.getPos(slot3.goTrs)

		table.insert(slot2, Vector3(slot4, slot5, slot6))
	end
end

function slot0._addBuildingMeshRendererIdDict(slot0, slot1, slot2)
	if slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) and slot3:getCharacterMeshRendererList() then
		for slot8, slot9 in ipairs(slot4) do
			slot2[slot9:GetInstanceID()] = true
		end
	end
end

function slot0._getPlayingInteractionParam(slot0)
	if RoomCharacterController.instance:getPlayingInteractionParam() == nil then
		slot1 = RoomCritterController.instance:getPlayingInteractionParam()
	end

	if slot1 == nil and slot0._lookCaneraState == slot0._scene.camera:getCameraState() then
		return slot0._lookEntityUid, slot0._lookLockType
	end

	return slot1, uv0.Hero
end

function slot0.setLookBuildingUid(slot0, slot1, slot2)
	if slot0._buildingPosListMap and slot2 then
		slot0._buildingPosListMap[slot2] = nil
	end

	slot0:_setLookEntityUid(slot1, slot2, uv0.Building)
end

function slot0.setLookVehicleUid(slot0, slot1, slot2)
	slot0:_setLookEntityUid(slot1, slot2, uv0.Vehicle)
end

function slot0.clearLookParam(slot0)
	slot0:_setLookEntityUid(nil, , )
end

function slot0._setLookEntityUid(slot0, slot1, slot2, slot3)
	slot0._lookCaneraState = slot1
	slot0._lookEntityUid = slot2
	slot0._lookLockType = slot3
end

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)
	slot0:_setLookEntityUid(nil, , )
end

return slot0
