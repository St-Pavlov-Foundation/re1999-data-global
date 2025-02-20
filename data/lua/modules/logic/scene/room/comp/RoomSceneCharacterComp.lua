module("modules.logic.scene.room.comp.RoomSceneCharacterComp", package.seeall)

slot0 = class("RoomSceneCharacterComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._canMoveStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.ThirdPerson] = true,
		[RoomEnum.CameraState.FirstPerson] = true,
		[RoomEnum.CameraState.InteractBuilding] = true
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

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.ClickCharacterInNormalCamera, slot0._clickCharacterInNormalCamera, slot0)
end

return slot0
