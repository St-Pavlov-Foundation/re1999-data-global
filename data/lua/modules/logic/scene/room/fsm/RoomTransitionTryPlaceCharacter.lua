module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceCharacter", package.seeall)

local var_0_0 = class("RoomTransitionTryPlaceCharacter", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.heroId
	local var_3_1 = arg_3_0._param.press
	local var_3_2 = arg_3_0._param.uidrag

	arg_3_0._playingAnimName = nil
	arg_3_0._playingAnimEntity = nil
	arg_3_0._cameraTweening = false

	local var_3_3 = RoomCharacterModel.instance:getTempCharacterMO()

	arg_3_0._heroId = var_3_0 or var_3_3 and var_3_3.heroId

	if var_3_3 and var_3_0 and var_3_3.heroId ~= var_3_0 then
		arg_3_0:_replaceCharacter()
	elseif var_3_3 then
		arg_3_0:_changeCharacter()
	else
		arg_3_0:_placeCharacter()
	end

	local var_3_4 = RoomCharacterModel.instance:getTempCharacterMO()

	if var_3_4 and not var_3_1 and not var_3_2 then
		local var_3_5 = var_3_4.currentPosition
		local var_3_6 = var_3_5.x
		local var_3_7 = var_3_5.z
		local var_3_8 = RoomCharacterController.instance:getCharacterFocus()
		local var_3_9

		if var_3_8 == RoomCharacterEnum.CameraFocus.MoreShowList then
			var_3_9 = 580
		end

		if RoomHelper.isOutCameraFocusByPlaceCharacter(var_3_6, var_3_7, var_3_9) then
			arg_3_0._cameraTweening = true

			RoomCharacterController.instance:tweenCameraFocus(var_3_6, var_3_7, var_3_8, arg_3_0._cameraDone, arg_3_0)
		end
	end

	arg_3_0:_checkDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientPlaceCharacter)
end

function var_0_0._replaceCharacter(arg_4_0)
	local var_4_0 = RoomCharacterModel.instance:getTempCharacterMO()
	local var_4_1 = arg_4_0._scene.charactermgr:getCharacterEntity(var_4_0.id, SceneTag.RoomCharacter)

	if var_4_0.characterState == RoomCharacterEnum.CharacterState.Temp then
		RoomCharacterModel.instance:removeTempCharacterMO()

		if var_4_1 then
			arg_4_0._scene.charactermgr:destroyCharacter(var_4_1)
		end
	elseif var_4_0.characterState == RoomCharacterEnum.CharacterState.Revert then
		RoomCharacterModel.instance:removeRevertCharacterMO()

		if var_4_1 then
			arg_4_0._scene.charactermgr:moveTo(var_4_1, var_4_0.currentPosition)
			arg_4_0:_delayCritterFollow(0.05)
		end
	end

	arg_4_0:_placeCharacter()
end

function var_0_0._changeCharacter(arg_5_0)
	local var_5_0 = arg_5_0._param.position
	local var_5_1 = arg_5_0._param.focus
	local var_5_2 = arg_5_0._param.isPressing
	local var_5_3 = arg_5_0._param.uidrag
	local var_5_4 = RoomCharacterModel.instance:getTempCharacterMO()

	var_5_0 = var_5_0 or var_5_4.currentPosition

	local var_5_5 = var_5_4.currentPosition

	RoomCharacterModel.instance:changeTempCharacterMO(var_5_0)

	if var_5_5 ~= var_5_0 then
		local var_5_6 = arg_5_0._scene.charactermgr:getCharacterEntity(var_5_4.id, SceneTag.RoomCharacter)

		if var_5_6 then
			if var_5_2 or var_5_3 or Vector3.Distance(var_5_5, var_5_0) < RoomBlockEnum.BlockSize then
				arg_5_0._scene.charactermgr:moveTo(var_5_6, var_5_4.currentPosition)
				arg_5_0:_delayCritterFollow(0.05)
			else
				arg_5_0:_playCharacterTransferAnim(var_5_6, var_5_5, var_5_4.currentPosition)
			end
		end
	end
end

function var_0_0._placeCharacter(arg_6_0)
	local var_6_0 = arg_6_0._param.heroId
	local var_6_1 = arg_6_0._param.skinId
	local var_6_2 = arg_6_0._param.position
	local var_6_3 = arg_6_0._param.uidrag
	local var_6_4 = RoomCharacterModel.instance:revertTempCharacterMO(var_6_0)

	if not var_6_4 then
		local var_6_5 = RoomCharacterModel.instance:addTempCharacterMO(var_6_0, var_6_2, var_6_1)

		RoomCharacterModel.instance:changeTempCharacterMO(var_6_2)

		local var_6_6 = arg_6_0._scene.charactermgr:getCharacterEntity(var_6_5.id, SceneTag.RoomCharacter)

		if var_6_6 == nil then
			var_6_6 = arg_6_0._scene.charactermgr:spawnRoomCharacter(var_6_5)
		end

		if not var_6_3 then
			arg_6_0:_playCharacterInAnim(var_6_6)
		end
	else
		local var_6_7 = var_6_4.currentPosition
		local var_6_8 = arg_6_0._scene.charactermgr:getCharacterEntity(var_6_4.id, SceneTag.RoomCharacter)

		RoomCharacterModel.instance:changeTempCharacterMO(var_6_7)

		if var_6_8 then
			arg_6_0._scene.charactermgr:moveTo(var_6_8, var_6_4.currentPosition)
			var_6_8.characterspine:refreshAnimState()
			var_6_8.interactActionComp:endIneract()
			arg_6_0:_delayCritterFollow(0.05)
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
end

function var_0_0._playCharacterInAnim(arg_7_0, arg_7_1)
	arg_7_1.charactermove:forcePositionAndLookDir(nil, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)

	arg_7_0._playingAnimName = "open"
	arg_7_0._playingAnimEntity = arg_7_1

	TaskDispatcher.runDelay(arg_7_0._animDone, arg_7_0, 0.5)
	arg_7_0:_delayCritterFollow(0.5)
	arg_7_1.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, arg_7_0._playingAnimName, 0)

	local var_7_0 = arg_7_0._scene.camera:getCameraRotate() * Mathf.Rad2Deg
	local var_7_1, var_7_2, var_7_3 = transformhelper.getPos(arg_7_1.go.transform)

	arg_7_0:_playPlaceEffect(Vector3(var_7_1, var_7_2, var_7_3), var_7_0)
	transformhelper.setLocalRotation(arg_7_1.go.transform, 0, var_7_0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_door_effect_put)
end

function var_0_0._playCharacterTransferAnim(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1.charactermove:forcePositionAndLookDir(arg_8_2, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)

	arg_8_0._playingAnimName = "door"
	arg_8_0._playingAnimEntity = arg_8_1
	arg_8_0._toPosition = arg_8_3

	TaskDispatcher.runDelay(arg_8_0._animDone, arg_8_0, 0.8)
	arg_8_0:_delayCritterFollow(0.8)
	arg_8_1.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, arg_8_0._playingAnimName, 0, arg_8_0._moveEntity, arg_8_0)

	local var_8_0 = arg_8_0._scene.camera:getCameraRotate() * Mathf.Rad2Deg

	arg_8_0:_playPlaceEffect(arg_8_2, var_8_0, "right")
	arg_8_0:_playPlaceEffect(arg_8_3, var_8_0, "left")
	transformhelper.setLocalRotation(arg_8_1.go.transform, 0, var_8_0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_door_effect_move)
end

function var_0_0._playPlaceEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPlaceCharacter, nil, "placeCharacterEffect", nil, 2)

	if var_9_0 then
		local var_9_1 = var_9_0.transform

		transformhelper.setPos(var_9_1, arg_9_1.x, arg_9_1.y, arg_9_1.z)
		transformhelper.setLocalRotation(var_9_1, 0, arg_9_2, 0)

		if not string.nilorempty(arg_9_3) then
			local var_9_2 = gohelper.findChildComponent(var_9_0, "anim", RoomEnum.ComponentType.Animator)

			if var_9_2 then
				var_9_2:Play(arg_9_3)
			end
		end
	end
end

function var_0_0._moveEntity(arg_10_0)
	if arg_10_0._playingAnimEntity and arg_10_0._toPosition then
		arg_10_0._playingAnimName = "out"

		arg_10_0._playingAnimEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, arg_10_0._playingAnimName, 0)
		arg_10_0._playingAnimEntity.charactermove:forcePositionAndLookDir(arg_10_0._toPosition, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)
	end
end

function var_0_0._skipAnim(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._animDone, arg_11_0)

	if arg_11_0._playingAnimName and arg_11_0._playingAnimEntity then
		if arg_11_0._playingAnimName == "door" then
			arg_11_0._playingAnimName = "out"
		end

		arg_11_0._playingAnimEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, arg_11_0._playingAnimName, 1)
	end

	arg_11_0:_animDone()
end

function var_0_0._animDone(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._animDone, arg_12_0)

	if arg_12_0._playingAnimEntity then
		arg_12_0._playingAnimEntity.charactermove:clearForcePositionAndLookDir()

		if arg_12_0._playingAnimEntity.characterspine then
			arg_12_0._playingAnimEntity.characterspine:clearAnim()
		end
	end

	arg_12_0._playingAnimName = nil
	arg_12_0._playingAnimEntity = nil

	arg_12_0:_checkDone()
end

function var_0_0._cameraDone(arg_13_0)
	arg_13_0._cameraTweening = false

	arg_13_0:_checkDone()
end

function var_0_0._checkDone(arg_14_0)
	if not arg_14_0._playingAnimName and not arg_14_0._cameraTweening then
		arg_14_0:onDone()
	end
end

function var_0_0._delayCritterFollow(arg_15_0, arg_15_1)
	local var_15_0 = RoomCharacterModel.instance:getCharacterMOById(arg_15_0._heroId)

	if var_15_0 and var_15_0.trainCritterUid then
		arg_15_0._scene.crittermgr:delaySetFollow(var_15_0.trainCritterUid, arg_15_1)
	end
end

function var_0_0.stop(arg_16_0)
	return
end

function var_0_0.clear(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._animDone, arg_17_0)

	if arg_17_0._playingAnimEntity then
		arg_17_0._playingAnimEntity.charactermove:clearForcePositionAndLookDir()

		if arg_17_0._playingAnimEntity.characterspine then
			arg_17_0._playingAnimEntity.characterspine:clearAnim()
		end
	end
end

return var_0_0
