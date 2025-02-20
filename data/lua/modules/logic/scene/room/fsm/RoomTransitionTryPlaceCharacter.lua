module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceCharacter", package.seeall)

slot0 = class("RoomTransitionTryPlaceCharacter", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot3 = slot0._param.press
	slot4 = slot0._param.uidrag
	slot0._playingAnimName = nil
	slot0._playingAnimEntity = nil
	slot0._cameraTweening = false
	slot5 = RoomCharacterModel.instance:getTempCharacterMO()
	slot0._heroId = slot0._param.heroId or slot5 and slot5.heroId

	if slot5 and slot2 and slot5.heroId ~= slot2 then
		slot0:_replaceCharacter()
	elseif slot5 then
		slot0:_changeCharacter()
	else
		slot0:_placeCharacter()
	end

	if RoomCharacterModel.instance:getTempCharacterMO() and not slot3 and not slot4 then
		slot6 = slot5.currentPosition
		slot7 = slot6.x
		slot8 = slot6.z
		slot10 = nil

		if RoomCharacterController.instance:getCharacterFocus() == RoomCharacterEnum.CameraFocus.MoreShowList then
			slot10 = 580
		end

		if RoomHelper.isOutCameraFocusByPlaceCharacter(slot7, slot8, slot10) then
			slot0._cameraTweening = true

			RoomCharacterController.instance:tweenCameraFocus(slot7, slot8, slot9, slot0._cameraDone, slot0)
		end
	end

	slot0:_checkDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientPlaceCharacter)
end

function slot0._replaceCharacter(slot0)
	slot1 = RoomCharacterModel.instance:getTempCharacterMO()
	slot2 = slot0._scene.charactermgr:getCharacterEntity(slot1.id, SceneTag.RoomCharacter)

	if slot1.characterState == RoomCharacterEnum.CharacterState.Temp then
		RoomCharacterModel.instance:removeTempCharacterMO()

		if slot2 then
			slot0._scene.charactermgr:destroyCharacter(slot2)
		end
	elseif slot1.characterState == RoomCharacterEnum.CharacterState.Revert then
		RoomCharacterModel.instance:removeRevertCharacterMO()

		if slot2 then
			slot0._scene.charactermgr:moveTo(slot2, slot1.currentPosition)
			slot0:_delayCritterFollow(0.05)
		end
	end

	slot0:_placeCharacter()
end

function slot0._changeCharacter(slot0)
	slot2 = slot0._param.focus
	slot5 = RoomCharacterModel.instance:getTempCharacterMO()
	slot1 = slot0._param.position or slot5.currentPosition

	RoomCharacterModel.instance:changeTempCharacterMO(slot1)

	if slot5.currentPosition ~= slot1 and slot0._scene.charactermgr:getCharacterEntity(slot5.id, SceneTag.RoomCharacter) then
		if slot0._param.isPressing or slot0._param.uidrag or Vector3.Distance(slot6, slot1) < RoomBlockEnum.BlockSize then
			slot0._scene.charactermgr:moveTo(slot7, slot5.currentPosition)
			slot0:_delayCritterFollow(0.05)
		else
			slot0:_playCharacterTransferAnim(slot7, slot6, slot5.currentPosition)
		end
	end
end

function slot0._placeCharacter(slot0)
	slot3 = slot0._param.position
	slot4 = slot0._param.uidrag

	if not RoomCharacterModel.instance:revertTempCharacterMO(slot0._param.heroId) then
		RoomCharacterModel.instance:changeTempCharacterMO(slot3)

		if slot0._scene.charactermgr:getCharacterEntity(RoomCharacterModel.instance:addTempCharacterMO(slot1, slot3, slot0._param.skinId).id, SceneTag.RoomCharacter) == nil then
			slot7 = slot0._scene.charactermgr:spawnRoomCharacter(slot6)
		end

		if not slot4 then
			slot0:_playCharacterInAnim(slot7)
		end
	else
		RoomCharacterModel.instance:changeTempCharacterMO(slot5.currentPosition)

		if slot0._scene.charactermgr:getCharacterEntity(slot5.id, SceneTag.RoomCharacter) then
			slot0._scene.charactermgr:moveTo(slot6, slot5.currentPosition)
			slot6.characterspine:refreshAnimState()
			slot6.interactActionComp:endIneract()
			slot0:_delayCritterFollow(0.05)
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
end

function slot0._playCharacterInAnim(slot0, slot1)
	slot1.charactermove:forcePositionAndLookDir(nil, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)

	slot0._playingAnimName = "open"
	slot0._playingAnimEntity = slot1

	TaskDispatcher.runDelay(slot0._animDone, slot0, 0.5)
	slot0:_delayCritterFollow(0.5)
	slot1.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, slot0._playingAnimName, 0)

	slot3 = slot0._scene.camera:getCameraRotate() * Mathf.Rad2Deg
	slot4, slot5, slot6 = transformhelper.getPos(slot1.go.transform)

	slot0:_playPlaceEffect(Vector3(slot4, slot5, slot6), slot3)
	transformhelper.setLocalRotation(slot1.go.transform, 0, slot3, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_door_effect_put)
end

function slot0._playCharacterTransferAnim(slot0, slot1, slot2, slot3)
	slot1.charactermove:forcePositionAndLookDir(slot2, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)

	slot0._playingAnimName = "door"
	slot0._playingAnimEntity = slot1
	slot0._toPosition = slot3

	TaskDispatcher.runDelay(slot0._animDone, slot0, 0.8)
	slot0:_delayCritterFollow(0.8)
	slot1.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, slot0._playingAnimName, 0, slot0._moveEntity, slot0)

	slot5 = slot0._scene.camera:getCameraRotate() * Mathf.Rad2Deg

	slot0:_playPlaceEffect(slot2, slot5, "right")
	slot0:_playPlaceEffect(slot3, slot5, "left")
	transformhelper.setLocalRotation(slot1.go.transform, 0, slot5, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_door_effect_move)
end

function slot0._playPlaceEffect(slot0, slot1, slot2, slot3)
	if slot0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPlaceCharacter, nil, "placeCharacterEffect", nil, 2) then
		slot5 = slot4.transform

		transformhelper.setPos(slot5, slot1.x, slot1.y, slot1.z)
		transformhelper.setLocalRotation(slot5, 0, slot2, 0)

		if not string.nilorempty(slot3) and gohelper.findChildComponent(slot4, "anim", RoomEnum.ComponentType.Animator) then
			slot6:Play(slot3)
		end
	end
end

function slot0._moveEntity(slot0)
	if slot0._playingAnimEntity and slot0._toPosition then
		slot0._playingAnimName = "out"

		slot0._playingAnimEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, slot0._playingAnimName, 0)
		slot0._playingAnimEntity.charactermove:forcePositionAndLookDir(slot0._toPosition, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)
	end
end

function slot0._skipAnim(slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)

	if slot0._playingAnimName and slot0._playingAnimEntity then
		if slot0._playingAnimName == "door" then
			slot0._playingAnimName = "out"
		end

		slot0._playingAnimEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, slot0._playingAnimName, 1)
	end

	slot0:_animDone()
end

function slot0._animDone(slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)

	if slot0._playingAnimEntity then
		slot0._playingAnimEntity.charactermove:clearForcePositionAndLookDir()

		if slot0._playingAnimEntity.characterspine then
			slot0._playingAnimEntity.characterspine:clearAnim()
		end
	end

	slot0._playingAnimName = nil
	slot0._playingAnimEntity = nil

	slot0:_checkDone()
end

function slot0._cameraDone(slot0)
	slot0._cameraTweening = false

	slot0:_checkDone()
end

function slot0._checkDone(slot0)
	if not slot0._playingAnimName and not slot0._cameraTweening then
		slot0:onDone()
	end
end

function slot0._delayCritterFollow(slot0, slot1)
	if RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) and slot2.trainCritterUid then
		slot0._scene.crittermgr:delaySetFollow(slot2.trainCritterUid, slot1)
	end
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)

	if slot0._playingAnimEntity then
		slot0._playingAnimEntity.charactermove:clearForcePositionAndLookDir()

		if slot0._playingAnimEntity.characterspine then
			slot0._playingAnimEntity.characterspine:clearAnim()
		end
	end
end

return slot0
