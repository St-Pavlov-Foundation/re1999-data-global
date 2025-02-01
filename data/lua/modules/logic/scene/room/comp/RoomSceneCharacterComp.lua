module("modules.logic.scene.room.comp.RoomSceneCharacterComp", package.seeall)

slot0 = class("RoomSceneCharacterComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._blockCharacterDistance = 2
	slot0._interactDistanceDic = {
		[RoomCharacterEnum.InteractionType.Building] = 10
	}
	slot0._canMoveStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.ThirdPerson] = true,
		[RoomEnum.CameraState.FirstPerson] = true
	}
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._lockUpdateTime = 0
	slot0._cameraRotation = RoomRotateHelper.getMod(slot0._scene.camera.cameraTrs.eulerAngles.y, 360)

	TaskDispatcher.runRepeat(slot0._onUpdate, slot0, 0)

	slot0._characterAnimalDict = {}
	slot0._characterAnimalClickDict = {}
	slot0._shadowOffset = Vector4.zero

	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.ClickCharacterInNormalCamera, slot0._clickCharacterInNormalCamera, slot0)
end

function slot0._cameraTransformUpdate(slot0)
	if RoomController.instance:isEditMode() then
		return
	end

	if math.abs(RoomRotateHelper.getMod(slot0._scene.camera.cameraTrs.eulerAngles.y, 360) - slot0._cameraRotation) > 1 or slot0._lockUpdateTime and slot0._lockUpdateTime > 0 and math.abs(slot2 - slot0._cameraRotation) > 0.0001 then
		slot0._lockUpdateTime = 0.5
		slot0._cameraRotation = slot2
	end
end

function slot0._onUpdate(slot0)
	if RoomController.instance:isEditMode() then
		return
	end

	slot0:_updateCharacterBlock()
	slot0:_updateAnimal()

	if not slot0._lockUpdateTime or slot0._lockUpdateTime <= 0 then
		slot0:_updateMove()
	else
		slot0._lockUpdateTime = slot0._lockUpdateTime - Time.deltaTime

		if slot0._lockUpdateTime <= 0 then
			RoomCharacterController.instance:tryMoveCharacterAfterRotateCamera()
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterMove)
end

function slot0.isLock(slot0)
	return slot0._lockUpdateTime and slot0._lockUpdateTime > 0
end

function slot0._updateMove(slot0)
	if RoomCritterController.instance:isPlayTrainEventStory() then
		return
	end

	if slot0._canMoveStateDict[slot0._scene.camera:getCameraState()] then
		for slot7, slot8 in ipairs(RoomCharacterModel.instance:getList()) do
			slot8:updateMove(Time.deltaTime)
		end
	end
end

function slot0.setCharacterAnimal(slot0, slot1, slot2)
	return

	if not RoomCharacterModel.instance:getCharacterMOById(slot1) then
		return
	end

	slot3.isAnimal = slot2

	if slot2 then
		slot0._characterAnimalDict[slot1] = Time.time + RoomCharacterEnum.AnimalDuration
	else
		slot0._characterAnimalDict[slot1] = nil
	end

	if not slot0._scene.charactermgr:getCharacterEntity(slot1, SceneTag.RoomCharacter) then
		return
	end

	if slot4.characterspine then
		slot4.characterspine:refreshAnimal()
	end
end

function slot0._updateAnimal(slot0)
	for slot4, slot5 in pairs(slot0._characterAnimalDict) do
		if slot5 < Time.time then
			slot0:setCharacterAnimal(slot4, false)
		end
	end

	for slot4, slot5 in pairs(slot0._characterAnimalClickDict) do
		for slot9 = #slot5, 1, -1 do
			if slot5[slot9] < Time.time then
				table.remove(slot5, slot9)
			end
		end
	end
end

function slot0._clickCharacterInNormalCamera(slot0, slot1)
	if RoomController.instance:isEditMode() then
		return
	end

	if slot0._characterAnimalDict[slot1] then
		return
	end

	if RoomCharacterModel.instance:getCharacterMOById(slot1):getCurrentInteractionId() then
		RoomCharacterController.instance:startInteraction(slot3, true)

		return
	end

	if slot2.currentFaith > 0 and RoomController.instance:isObMode() then
		RoomCharacterController.instance:gainCharacterFaith({
			slot1
		})
		AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
	elseif RoomController.instance:isObMode() and RoomCharacterModel.instance:isShowFaithFull(slot1) and RoomCharacterController.instance:isCharacterFaithFull(slot1) then
		RoomCharacterController.instance:hideCharacterFaithFull(slot1)
		GameFacade.showToast(RoomEnum.Toast.GainFaithFull)
	end

	slot0._characterAnimalClickDict[slot1] = slot0._characterAnimalClickDict[slot1] or {}

	table.insert(slot0._characterAnimalClickDict[slot1], Time.time + RoomCharacterEnum.ClickInterval)

	if RoomCharacterHelper.checkCharacterAnimalInteraction(slot1) or RoomCharacterEnum.ClickTimes <= #slot0._characterAnimalClickDict[slot1] then
		slot0._characterAnimalClickDict[slot1] = nil

		slot0:setCharacterAnimal(slot1, true)
	else
		slot0:setCharacterTouch(slot1, true)

		if not slot4 and slot0._scene.charactermgr:getCharacterEntity(slot1, SceneTag.RoomCharacter) then
			slot6:playClickEffect()
		end
	end
end

function slot0.setCharacterTouch(slot0, slot1, slot2)
	if not RoomCharacterModel.instance:getCharacterMOById(slot1) then
		return
	end

	slot3.isTouch = slot2

	if not slot0._scene.charactermgr:getCharacterEntity(slot1, SceneTag.RoomCharacter) then
		return
	end

	if slot4.characterspine then
		slot4.characterspine:touch(slot2)
	end

	if slot4.followPathComp and slot4.followPathComp:getCount() > 0 then
		slot3:setLockTime(0.1)
	end
end

function slot0.setShadowOffset(slot0, slot1)
	slot0._shadowOffset = slot1
end

function slot0.getShadowOffset(slot0)
	return slot0._shadowOffset
end

function slot0._updateCharacterBlock(slot0)
	slot0._lastUpdateCharacterBlockTime = slot0._lastUpdateCharacterBlockTime or 0

	if slot0._lastUpdateCharacterBlockTime < 0.1 then
		slot0._lastUpdateCharacterBlockTime = slot0._lastUpdateCharacterBlockTime + Time.unscaledDeltaTime

		return
	end

	if not slot0:_getPlayingInteractionParam() and (not slot0._lastOpenNum or slot0._lastOpenNum == 0) then
		return
	end

	slot0._lastOpenNum = 0
	slot0._lastUpdateCharacterBlockTime = 0
	slot2 = GameSceneMgr.instance:getCurScene()
	slot4 = {}

	for slot8, slot9 in ipairs(RoomCharacterHelper.getAllBlockMeshRendererList()) do
		table.insert(slot4, slot9:GetInstanceID())
	end

	slot5 = slot0:_getBlockMeshRendererDict(slot3, slot4)
	slot6 = nil
	slot7 = slot0._lastMeshReaderDic or {}
	slot0._lastMeshReaderDic = {}
	slot9 = "_SCREENCOORD"

	if slot0.alphaThresholdID == nil then
		slot0.alphaThresholdID = UnityEngine.Shader.PropertyToID("_AlphaThreshold")
	end

	for slot13, slot14 in ipairs(slot3) do
		if slot5[slot4[slot13]] and slot16 > 0 then
			slot0._lastOpenNum = slot0._lastOpenNum + 1

			if slot7[slot15] ~= slot16 then
				if not slot6 then
					slot6 = slot2.mapmgr:getPropertyBlock()

					slot6:Clear()
					slot6:SetFloat(slot0.alphaThresholdID, slot16)
				end

				MaterialReplaceHelper.SetRendererKeyworld(slot14, slot9, true)
				slot14:SetPropertyBlock(slot6)
			end

			slot8[slot15] = slot16
		elseif slot7[slot15] then
			MaterialReplaceHelper.SetRendererKeyworld(slot14, slot9, false)
			slot14:SetPropertyBlock(nil)
		end
	end
end

function slot0._getBlockMeshRendererDict(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() then
		return {}
	end

	if not slot0:_getPlayingInteractionParam() then
		return slot3
	end

	slot5 = {}

	slot0:_addCharacterGOById(slot4.heroId, slot5)
	slot0:_addCharacterGOById(slot4.relateHeroId, slot5)

	if #slot1 <= 0 or #slot5 <= 0 then
		return slot3
	end

	slot7 = slot0._scene.camera:getCameraPosition()
	slot8 = {}

	for slot13, slot14 in pairs(slot5) do
		if Vector3.Distance(slot7, RoomBendingHelper.worldToBendingSimple(slot14.transform.position)) <= (slot0._interactDistanceDic[slot4.behaviour] or slot0._blockCharacterDistance) then
			table.insert(slot8, Ray(Vector3.Normalize(slot15 - slot7), slot7))
			table.insert({}, slot16)
		end
	end

	if #slot8 > 0 then
		slot14 = {}

		slot0:_addBuildingMeshRendererIdDict(slot4.buildingUid, slot14)

		for slot14, slot15 in ipairs(slot1) do
			if not slot10[slot2[slot14]] and RoomCharacterHelper.isBlockCharacter(slot8, slot9, slot15) then
				slot3[slot16] = 0.6
			end
		end
	end

	return slot3
end

function slot0._addCharacterGOById(slot0, slot1, slot2)
	if slot0._scene.charactermgr:getCharacterEntity(slot1, SceneTag.RoomCharacter) and slot3.characterspine:getCharacterGO() then
		table.insert(slot2, slot4)
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

	return slot1
end

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.ClickCharacterInNormalCamera, slot0._clickCharacterInNormalCamera, slot0)
end

return slot0
