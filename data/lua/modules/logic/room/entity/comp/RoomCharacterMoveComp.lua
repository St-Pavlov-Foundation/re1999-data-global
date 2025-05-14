module("modules.logic.room.entity.comp.RoomCharacterMoveComp", package.seeall)

local var_0_0 = class("RoomCharacterMoveComp", RoomBaseFollowPathComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._forcePosition = nil
	arg_1_0._forceLookDir = nil
	arg_1_0._forceMoveState = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._seeker = ZProj.AStarSeekWrap.Get(arg_2_0.go)

	local var_2_0 = arg_2_0.entity:getMO()

	arg_2_0._seeker:SetTagTraversable(RoomEnum.AStarLayerTag.Water, var_2_0:getCanWade())
	arg_2_0._seeker:SetTagTraversable(RoomEnum.AStarLayerTag.NoWalkRoad, false)
	arg_2_0:_updateCharacterMove()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_3_0._cameraTransformUpdate, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_3_0._updateCharacterMove, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.PauseCharacterMove, arg_3_0._pauseCharacterMove, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, arg_3_0._cameraStateUpdate, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_4_0._cameraTransformUpdate, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_4_0._updateCharacterMove, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.PauseCharacterMove, arg_4_0._pauseCharacterMove, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, arg_4_0._cameraStateUpdate, arg_4_0)

	if not gohelper.isNil(arg_4_0._seeker) then
		arg_4_0._seeker:RemoveOnPathCall()
	end

	arg_4_0._seeker = nil
end

function var_0_0._cameraTransformUpdate(arg_5_0)
	return
end

function var_0_0.forcePositionAndLookDir(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._forcePosition = arg_6_1
	arg_6_0._forceLookDir = arg_6_2
	arg_6_0._forceMoveState = arg_6_3

	arg_6_0:_updateCharacterMove()
end

function var_0_0.clearForcePositionAndLookDir(arg_7_0)
	arg_7_0._forcePosition = nil
	arg_7_0._forceLookDir = nil
	arg_7_0._forceMoveState = nil

	arg_7_0:_updateCharacterMove()
end

function var_0_0._updateCharacterMove(arg_8_0)
	arg_8_0:_updateMovingLookDir()
	arg_8_0:_updateMovingPosition()
	arg_8_0:_updateMovingState()
end

function var_0_0._cameraStateUpdate(arg_9_0)
	local var_9_0 = arg_9_0._scene.camera:getCameraState()

	if arg_9_0._lastCameraState == RoomEnum.CameraState.OverlookAll then
		arg_9_0._lastCameraState = var_9_0

		local var_9_1 = arg_9_0.entity:getMO()

		if var_9_1 then
			var_9_1:setLockTime(0.5)
		end
	end

	arg_9_0._lastCameraState = var_9_0
end

function var_0_0._pauseCharacterMove(arg_10_0, arg_10_1)
	arg_10_0.entity.followPathComp:stopMove()
end

function var_0_0._updateMovingLookDir(arg_11_0)
	if arg_11_0._forceLookDir then
		arg_11_0.entity.characterspine:changeLookDir(arg_11_0._forceLookDir)

		return
	end

	if arg_11_0.entity.isPressing then
		return
	end

	local var_11_0 = arg_11_0.entity:getMO()

	if not var_11_0 then
		return
	end

	if not arg_11_0._scene.character:isLock() then
		local var_11_1 = GameSceneMgr.instance:getCurScene()
		local var_11_2 = var_11_0:getMovingDir()

		if var_11_0:getMoveState() ~= RoomCharacterEnum.CharacterMoveState.Move then
			return
		end

		local var_11_3 = var_11_0.currentPosition
		local var_11_4 = Vector3(var_11_3.x, var_11_3.y, var_11_3.z)
		local var_11_5 = var_11_4 + Vector3.Normalize(Vector3(var_11_2.x, 0, var_11_2.y))
		local var_11_6 = arg_11_0:getMoveToLookDirByPos(var_11_4, var_11_5)

		arg_11_0.entity.characterspine:changeLookDir(var_11_6)
	end
end

function var_0_0.getMoveToLookDirByPos(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = RoomBendingHelper.worldToBendingSimple(arg_12_1)
	local var_12_1 = arg_12_0._scene.camera.camera:WorldToScreenPoint(var_12_0)
	local var_12_2 = RoomBendingHelper.worldToBendingSimple(arg_12_2)
	local var_12_3 = arg_12_0._scene.camera.camera:WorldToScreenPoint(var_12_2)

	if (var_12_3.z > 0 and var_12_3.x or -var_12_3.x) - (var_12_1.z > 0 and var_12_1.x or -var_12_1.x) > 0.0001 then
		return SpineLookDir.Right
	else
		return SpineLookDir.Left
	end
end

function var_0_0._updateMovingState(arg_13_0)
	if arg_13_0._forceMoveState then
		arg_13_0.entity.characterspine:changeMoveState(arg_13_0._forceMoveState)

		return
	end

	if arg_13_0.entity.isPressing then
		return
	end

	local var_13_0 = arg_13_0.entity:getMO()

	if not var_13_0 then
		return
	end

	local var_13_1 = arg_13_0._scene.character:isLock()
	local var_13_2 = var_13_0:getMoveState()

	if var_13_1 and var_13_2 == RoomCharacterEnum.CharacterMoveState.Move then
		arg_13_0.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
	else
		arg_13_0.entity.characterspine:changeMoveState(var_13_2)
	end
end

function var_0_0._updateMovingPosition(arg_14_0)
	if arg_14_0._forcePosition then
		arg_14_0.entity:setLocalPos(arg_14_0._forcePosition.x, arg_14_0._forcePosition.y, arg_14_0._forcePosition.z)

		return
	end

	if arg_14_0.entity.isPressing then
		return
	end

	local var_14_0 = arg_14_0.entity:getMO()

	if not var_14_0 then
		return
	end

	local var_14_1 = var_14_0:getMoveState()
	local var_14_2 = var_14_0:getPositionCodeId()
	local var_14_3 = var_14_1 == RoomCharacterEnum.CharacterMoveState.Move and var_14_0:canMove()

	if var_14_3 or arg_14_0._lastMoveState ~= var_14_1 or arg_14_0._lastPositionCodeId ~= var_14_2 then
		local var_14_4 = arg_14_0._lastMoveState == RoomCharacterEnum.CharacterMoveState.Move

		arg_14_0._lastMoveState = var_14_1

		local var_14_5 = var_14_0.currentPosition

		if var_14_5 then
			arg_14_0._lastPositionCodeId = var_14_2

			arg_14_0.entity:setLocalPos(var_14_5.x, var_14_5.y, var_14_5.z)

			if arg_14_0.entity.followPathComp:getCount() > 0 then
				arg_14_0.entity.followPathComp:addPathPos(Vector3(var_14_5.x, var_14_5.y, var_14_5.z))
			end
		end

		if var_14_3 then
			arg_14_0.entity.followPathComp:moveByPathData()
		elseif var_14_4 then
			arg_14_0.entity.followPathComp:stopMove()
		end
	end
end

function var_0_0.getSeeker(arg_15_0)
	return arg_15_0._seeker
end

function var_0_0.beforeDestroy(arg_16_0)
	arg_16_0:removeEventListeners()
end

return var_0_0
