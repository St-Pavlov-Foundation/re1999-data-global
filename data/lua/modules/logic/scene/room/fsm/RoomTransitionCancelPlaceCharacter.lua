module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceCharacter", package.seeall)

local var_0_0 = class("RoomTransitionCancelPlaceCharacter", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = RoomCharacterModel.instance:getTempCharacterMO()

	if var_3_0 then
		if var_3_0:isTrainSourceState() or var_3_0:isTraining() then
			arg_3_0:_finish()
			GameFacade.showToast(ToastEnum.RoomUnUseTrainCharacter)

			return
		end

		local var_3_1 = arg_3_0._scene.charactermgr:getCharacterEntity(var_3_0.id, SceneTag.RoomCharacter)

		if var_3_0.characterState == RoomCharacterEnum.CharacterState.Temp then
			arg_3_0._toDestroyEntity = var_3_1

			var_3_1.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "close", 0, arg_3_0._animDone, arg_3_0)

			local var_3_2 = arg_3_0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPressingCharacter, nil, "disappearEffect", nil, 2.5)

			if var_3_2 then
				local var_3_3, var_3_4, var_3_5 = transformhelper.getPos(var_3_1.staticContainerGO.transform)

				transformhelper.setPos(var_3_2.transform, var_3_3, var_3_4, var_3_5)

				local var_3_6 = var_3_2:GetComponent(RoomEnum.ComponentType.Animator)

				if var_3_6 then
					var_3_6:Play("disappear", 0, 0)
				end
			end
		elseif var_3_0.characterState == RoomCharacterEnum.CharacterState.Revert then
			RoomCharacterModel.instance:removeRevertCharacterMO()

			if var_3_1 then
				arg_3_0._scene.charactermgr:moveTo(var_3_1, var_3_0.currentPosition)
			end

			arg_3_0:_finish()
		end
	else
		arg_3_0:_finish()
	end
end

function var_0_0._animDone(arg_4_0)
	RoomCharacterModel.instance:removeTempCharacterMO()

	if arg_4_0._toDestroyEntity then
		arg_4_0._scene.charactermgr:destroyCharacter(arg_4_0._toDestroyEntity)

		arg_4_0._toDestroyEntity = nil
	end

	arg_4_0:_finish()
end

function var_0_0._finish(arg_5_0)
	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	arg_5_0:onDone()
end

function var_0_0.stop(arg_6_0)
	return
end

function var_0_0.clear(arg_7_0)
	arg_7_0._toDestroyEntity = nil
end

return var_0_0
