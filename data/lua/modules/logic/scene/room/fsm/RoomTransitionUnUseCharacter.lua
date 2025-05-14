module("modules.logic.scene.room.fsm.RoomTransitionUnUseCharacter", package.seeall)

local var_0_0 = class("RoomTransitionUnUseCharacter", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.heroId
	local var_3_1 = arg_3_0._param.tempCharacterMO
	local var_3_2 = arg_3_0._param.anim

	RoomCharacterController.instance:interruptInteraction(var_3_1:getCurrentInteractionId())

	if var_3_1 and (var_3_1:isTrainSourceState() or var_3_1:isTraining()) then
		var_3_1.sourceState = RoomCharacterEnum.SourceState.Train

		arg_3_0:_animDone()
		GameFacade.showToast(ToastEnum.RoomUnUseTrainCharacter)

		return
	end

	local var_3_3 = arg_3_0._scene.charactermgr:getCharacterEntity(var_3_1.id, SceneTag.RoomCharacter)

	if var_3_2 and var_3_3 and var_3_3.characterspine then
		var_3_3.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "close", 0, arg_3_0._animDone, arg_3_0)

		local var_3_4 = arg_3_0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPressingCharacter, nil, "disappearEffect", nil, 2.5)

		if var_3_4 then
			local var_3_5, var_3_6, var_3_7 = transformhelper.getPos(var_3_3.staticContainerGO.transform)

			transformhelper.setPos(var_3_4.transform, var_3_5, var_3_6, var_3_7)

			local var_3_8 = var_3_4:GetComponent(RoomEnum.ComponentType.Animator)

			if var_3_8 then
				var_3_8:Play("disappear", 0, 0)
			end
		end
	else
		arg_3_0:_animDone()
	end
end

function var_0_0._animDone(arg_4_0)
	local var_4_0 = arg_4_0._param.tempCharacterMO

	if var_4_0:isTrainSourceState() or var_4_0:isTraining() then
		RoomCharacterModel.instance:placeTempCharacterMO()
	else
		local var_4_1 = arg_4_0._scene.charactermgr:getCharacterEntity(var_4_0.id, SceneTag.RoomCharacter)

		if var_4_1 then
			arg_4_0._scene.charactermgr:destroyCharacter(var_4_1)
		end

		RoomCharacterModel.instance:unUseRevertCharacterMO()
	end

	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomMapController.instance:dispatchEvent(RoomEvent.UnUseCharacter)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	arg_4_0:onDone()
end

function var_0_0.stop(arg_5_0)
	return
end

function var_0_0.clear(arg_6_0)
	return
end

return var_0_0
