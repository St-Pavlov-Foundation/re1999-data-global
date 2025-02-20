module("modules.logic.room.entity.comp.RoomCharacterMoveComp", package.seeall)

slot0 = class("RoomCharacterMoveComp", RoomBaseFollowPathComp)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._forcePosition = nil
	slot0._forceLookDir = nil
	slot0._forceMoveState = nil
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._seeker = ZProj.AStarSeekWrap.Get(slot0.go)

	slot0._seeker:SetTagTraversable(RoomEnum.AStarLayerTag.Water, slot0.entity:getMO():getCanWade())
	slot0._seeker:SetTagTraversable(RoomEnum.AStarLayerTag.NoWalkRoad, false)
	slot0:_updateCharacterMove()
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._updateCharacterMove, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.PauseCharacterMove, slot0._pauseCharacterMove, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, slot0._cameraStateUpdate, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._updateCharacterMove, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.PauseCharacterMove, slot0._pauseCharacterMove, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, slot0._cameraStateUpdate, slot0)

	if not gohelper.isNil(slot0._seeker) then
		slot0._seeker:RemoveOnPathCall()
	end

	slot0._seeker = nil
end

function slot0._cameraTransformUpdate(slot0)
end

function slot0.forcePositionAndLookDir(slot0, slot1, slot2, slot3)
	slot0._forcePosition = slot1
	slot0._forceLookDir = slot2
	slot0._forceMoveState = slot3

	slot0:_updateCharacterMove()
end

function slot0.clearForcePositionAndLookDir(slot0)
	slot0._forcePosition = nil
	slot0._forceLookDir = nil
	slot0._forceMoveState = nil

	slot0:_updateCharacterMove()
end

function slot0._updateCharacterMove(slot0)
	slot0:_updateMovingLookDir()
	slot0:_updateMovingPosition()
	slot0:_updateMovingState()
end

function slot0._cameraStateUpdate(slot0)
	slot1 = slot0._scene.camera:getCameraState()

	if slot0._lastCameraState == RoomEnum.CameraState.OverlookAll then
		slot0._lastCameraState = slot1

		if slot0.entity:getMO() then
			slot2:setLockTime(0.5)
		end
	end

	slot0._lastCameraState = slot1
end

function slot0._pauseCharacterMove(slot0, slot1)
	slot0.entity.followPathComp:stopMove()
end

function slot0._updateMovingLookDir(slot0)
	if slot0._forceLookDir then
		slot0.entity.characterspine:changeLookDir(slot0._forceLookDir)

		return
	end

	if slot0.entity.isPressing then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	if not slot0._scene.character:isLock() then
		slot3 = GameSceneMgr.instance:getCurScene()
		slot4 = slot1:getMovingDir()

		if slot1:getMoveState() ~= RoomCharacterEnum.CharacterMoveState.Move then
			return
		end

		slot5 = slot1.currentPosition
		slot5 = Vector3(slot5.x, slot5.y, slot5.z)

		slot0.entity.characterspine:changeLookDir(slot0:getMoveToLookDirByPos(slot5, slot5 + Vector3.Normalize(Vector3(slot4.x, 0, slot4.y))))
	end
end

function slot0.getMoveToLookDirByPos(slot0, slot1, slot2)
	slot4 = slot0._scene.camera.camera:WorldToScreenPoint(RoomBendingHelper.worldToBendingSimple(slot1))

	if (slot0._scene.camera.camera:WorldToScreenPoint(RoomBendingHelper.worldToBendingSimple(slot2)).z > 0 and slot6.x or -slot6.x) - (slot4.z > 0 and slot4.x or -slot4.x) > 0.0001 then
		return SpineLookDir.Right
	else
		return SpineLookDir.Left
	end
end

function slot0._updateMovingState(slot0)
	if slot0._forceMoveState then
		slot0.entity.characterspine:changeMoveState(slot0._forceMoveState)

		return
	end

	if slot0.entity.isPressing then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	if slot0._scene.character:isLock() and slot1:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move then
		slot0.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
	else
		slot0.entity.characterspine:changeMoveState(slot3)
	end
end

function slot0._updateMovingPosition(slot0)
	if slot0._forcePosition then
		slot0.entity:setLocalPos(slot0._forcePosition.x, slot0._forcePosition.y, slot0._forcePosition.z)

		return
	end

	if slot0.entity.isPressing then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	slot3 = slot1:getPositionCodeId()

	if slot1:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move and slot1:canMove() or slot0._lastMoveState ~= slot2 or slot0._lastPositionCodeId ~= slot3 then
		slot5 = slot0._lastMoveState == RoomCharacterEnum.CharacterMoveState.Move
		slot0._lastMoveState = slot2

		if slot1.currentPosition then
			slot0._lastPositionCodeId = slot3

			slot0.entity:setLocalPos(slot6.x, slot6.y, slot6.z)

			if slot0.entity.followPathComp:getCount() > 0 then
				slot0.entity.followPathComp:addPathPos(Vector3(slot6.x, slot6.y, slot6.z))
			end
		end

		if slot4 then
			slot0.entity.followPathComp:moveByPathData()
		elseif slot5 then
			slot0.entity.followPathComp:stopMove()
		end
	end
end

function slot0.getSeeker(slot0)
	return slot0._seeker
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

return slot0
