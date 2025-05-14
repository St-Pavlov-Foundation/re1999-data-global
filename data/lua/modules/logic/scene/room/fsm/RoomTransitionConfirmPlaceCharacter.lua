module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceCharacter", package.seeall)

local var_0_0 = class("RoomTransitionConfirmPlaceCharacter", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.tempCharacterMO

	RoomCharacterController.instance:interruptInteraction(var_3_0:getCurrentInteractionId())

	local var_3_1 = arg_3_0._scene.charactermgr:getCharacterEntity(var_3_0.id, SceneTag.RoomCharacter)

	if var_3_1 then
		arg_3_0._scene.charactermgr:moveTo(var_3_1, var_3_0.currentPosition)
		var_3_1:playConfirmEffect()
	end

	if not var_3_0:isPlaceSourceState() and RoomModel.instance:getCharacterById(var_3_0.id) then
		var_3_0.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmCharacter)
	arg_3_0:onDone()
end

function var_0_0.stop(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

return var_0_0
