module("modules.logic.scene.room.comp.RoomSceneCharacterComp", package.seeall)

local var_0_0 = class("RoomSceneCharacterComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._canMoveStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.ThirdPerson] = true,
		[RoomEnum.CameraState.FirstPerson] = true,
		[RoomEnum.CameraState.InteractBuilding] = true
	}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._lockUpdateTime = 0

	local var_2_0 = arg_2_0._scene.camera.cameraTrs

	arg_2_0._cameraRotation = RoomRotateHelper.getMod(var_2_0.eulerAngles.y, 360)

	TaskDispatcher.runRepeat(arg_2_0._onUpdate, arg_2_0, 0)

	arg_2_0._characterAnimalDict = {}
	arg_2_0._characterAnimalClickDict = {}
	arg_2_0._shadowOffset = Vector4.zero

	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_2_0._cameraTransformUpdate, arg_2_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.ClickCharacterInNormalCamera, arg_2_0._clickCharacterInNormalCamera, arg_2_0)
end

function var_0_0._cameraTransformUpdate(arg_3_0)
	if RoomController.instance:isEditMode() then
		return
	end

	local var_3_0 = arg_3_0._scene.camera.cameraTrs
	local var_3_1 = RoomRotateHelper.getMod(var_3_0.eulerAngles.y, 360)

	if math.abs(var_3_1 - arg_3_0._cameraRotation) > 1 or arg_3_0._lockUpdateTime and arg_3_0._lockUpdateTime > 0 and math.abs(var_3_1 - arg_3_0._cameraRotation) > 0.0001 then
		arg_3_0._lockUpdateTime = 0.5
		arg_3_0._cameraRotation = var_3_1
	end
end

function var_0_0._onUpdate(arg_4_0)
	if RoomController.instance:isEditMode() then
		return
	end

	arg_4_0:_updateAnimal()

	if not arg_4_0._lockUpdateTime or arg_4_0._lockUpdateTime <= 0 then
		arg_4_0:_updateMove()
	else
		arg_4_0._lockUpdateTime = arg_4_0._lockUpdateTime - Time.deltaTime

		if arg_4_0._lockUpdateTime <= 0 then
			RoomCharacterController.instance:tryMoveCharacterAfterRotateCamera()
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterMove)
end

function var_0_0.isLock(arg_5_0)
	return arg_5_0._lockUpdateTime and arg_5_0._lockUpdateTime > 0
end

function var_0_0._updateMove(arg_6_0)
	if RoomCritterController.instance:isPlayTrainEventStory() then
		return
	end

	local var_6_0 = arg_6_0._scene.camera:getCameraState()

	if arg_6_0._canMoveStateDict[var_6_0] then
		local var_6_1 = RoomCharacterModel.instance:getList()
		local var_6_2 = Time.deltaTime

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			iter_6_1:updateMove(var_6_2)
		end
	end
end

function var_0_0.setCharacterAnimal(arg_7_0, arg_7_1, arg_7_2)
	do return end

	local var_7_0 = RoomCharacterModel.instance:getCharacterMOById(arg_7_1)

	if not var_7_0 then
		return
	end

	var_7_0.isAnimal = arg_7_2

	if arg_7_2 then
		arg_7_0._characterAnimalDict[arg_7_1] = Time.time + RoomCharacterEnum.AnimalDuration
	else
		arg_7_0._characterAnimalDict[arg_7_1] = nil
	end

	local var_7_1 = arg_7_0._scene.charactermgr:getCharacterEntity(arg_7_1, SceneTag.RoomCharacter)

	if not var_7_1 then
		return
	end

	if var_7_1.characterspine then
		var_7_1.characterspine:refreshAnimal()
	end
end

function var_0_0._updateAnimal(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._characterAnimalDict) do
		if iter_8_1 < Time.time then
			arg_8_0:setCharacterAnimal(iter_8_0, false)
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0._characterAnimalClickDict) do
		for iter_8_4 = #iter_8_3, 1, -1 do
			if iter_8_3[iter_8_4] < Time.time then
				table.remove(iter_8_3, iter_8_4)
			end
		end
	end
end

function var_0_0._clickCharacterInNormalCamera(arg_9_0, arg_9_1)
	if RoomController.instance:isEditMode() then
		return
	end

	if arg_9_0._characterAnimalDict[arg_9_1] then
		return
	end

	local var_9_0 = RoomCharacterModel.instance:getCharacterMOById(arg_9_1)
	local var_9_1 = var_9_0:getCurrentInteractionId()

	if var_9_1 then
		RoomCharacterController.instance:startInteraction(var_9_1, true)

		return
	end

	local var_9_2 = var_9_0.currentFaith > 0 and RoomController.instance:isObMode()

	if var_9_2 then
		RoomCharacterController.instance:gainCharacterFaith({
			arg_9_1
		})
		AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
	elseif RoomController.instance:isObMode() and RoomCharacterModel.instance:isShowFaithFull(arg_9_1) and RoomCharacterController.instance:isCharacterFaithFull(arg_9_1) then
		RoomCharacterController.instance:hideCharacterFaithFull(arg_9_1)
		GameFacade.showToast(RoomEnum.Toast.GainFaithFull)
	end

	arg_9_0._characterAnimalClickDict[arg_9_1] = arg_9_0._characterAnimalClickDict[arg_9_1] or {}

	table.insert(arg_9_0._characterAnimalClickDict[arg_9_1], Time.time + RoomCharacterEnum.ClickInterval)

	if RoomCharacterHelper.checkCharacterAnimalInteraction(arg_9_1) or #arg_9_0._characterAnimalClickDict[arg_9_1] >= RoomCharacterEnum.ClickTimes then
		arg_9_0._characterAnimalClickDict[arg_9_1] = nil

		arg_9_0:setCharacterAnimal(arg_9_1, true)
	else
		arg_9_0:setCharacterTouch(arg_9_1, true)

		if not var_9_2 then
			local var_9_3 = arg_9_0._scene.charactermgr:getCharacterEntity(arg_9_1, SceneTag.RoomCharacter)

			if var_9_3 then
				var_9_3:playClickEffect()
			end
		end
	end
end

function var_0_0.setCharacterTouch(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RoomCharacterModel.instance:getCharacterMOById(arg_10_1)

	if not var_10_0 then
		return
	end

	var_10_0.isTouch = arg_10_2

	local var_10_1 = arg_10_0._scene.charactermgr:getCharacterEntity(arg_10_1, SceneTag.RoomCharacter)

	if not var_10_1 then
		return
	end

	if var_10_1.characterspine then
		var_10_1.characterspine:touch(arg_10_2)
	end

	if var_10_1.followPathComp and var_10_1.followPathComp:getCount() > 0 then
		var_10_0:setLockTime(0.1)
	end
end

function var_0_0.setShadowOffset(arg_11_0, arg_11_1)
	arg_11_0._shadowOffset = arg_11_1
end

function var_0_0.getShadowOffset(arg_12_0)
	return arg_12_0._shadowOffset
end

function var_0_0.onSceneClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onUpdate, arg_13_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_13_0._cameraTransformUpdate, arg_13_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.ClickCharacterInNormalCamera, arg_13_0._clickCharacterInNormalCamera, arg_13_0)
end

return var_0_0
