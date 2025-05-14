module("modules.logic.scene.room.comp.RoomSceneFSMComp", package.seeall)

local var_0_0 = class("RoomSceneFSMComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._context = {}
	arg_2_0._fsm = SimpleFSM.New(arg_2_0._context)

	if RoomController.instance:isEditMode() then
		arg_2_0._fsm:registerState(RoomEditStateIdle.New(RoomEnum.FSMEditState.Idle))
		arg_2_0._fsm:registerState(RoomEditStatePlaceConfirm.New(RoomEnum.FSMEditState.PlaceConfirm))
		arg_2_0._fsm:registerState(RoomEditStateBackConfirm.New(RoomEnum.FSMEditState.BackConfirm))
		arg_2_0._fsm:registerState(RoomEditStatePlaceConfirm.New(RoomEnum.FSMEditState.PlaceBuildingConfirm))
		arg_2_0._fsm:registerState(SimpleFSMBaseState.New(RoomEnum.FSMEditState.WaterReform))

		local var_2_0 = {
			RoomEnum.FSMEditState.BackConfirm
		}
		local var_2_1 = {
			RoomEnum.FSMEditState.BackConfirm,
			RoomEnum.FSMEditState.PlaceConfirm
		}

		arg_2_0._fsm:registerTransition(RoomTransitionConfirmPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBlock, var_2_0))
		arg_2_0._fsm:registerTransition(RoomTransitionConfirmPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBlock, var_2_0))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBlock, var_2_0))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBlock, var_2_0))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		arg_2_0._fsm:registerTransition(RoomTransitionTryBackBlock.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.BackConfirm, RoomSceneEvent.TryBackBlock, var_2_1))
		arg_2_0._fsm:registerTransition(RoomTransitionTryBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.BackConfirm, RoomSceneEvent.TryBackBlock, var_2_1))
		arg_2_0._fsm:registerTransition(RoomTransitionConfirmBackBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmBackBlock, var_2_1))
		arg_2_0._fsm:registerTransition(RoomTransitionConfirmBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmBackBlock, var_2_1))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelBackBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelBackBlock, var_2_1))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelBackBlock, var_2_1))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionConfirmPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionEnterWaterReform.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.WaterReform, RoomSceneEvent.EnterWaterReform))
		arg_2_0._fsm:registerTransition(RoomTransitionCloseWaterReform.New(RoomEnum.FSMEditState.WaterReform, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CloseWaterReform))
		arg_2_0._fsm:start(RoomEnum.FSMEditState.Idle)
	elseif RoomController.instance:isObMode() then
		arg_2_0._fsm:registerState(RoomObStateIdle.New(RoomEnum.FSMObState.Idle))
		arg_2_0._fsm:registerState(RoomObStatePlaceConfirm.New(RoomEnum.FSMObState.PlaceBuildingConfirm))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionConfirmPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.ConfirmPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.CancelPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		arg_2_0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.UnUseBuilding))
		arg_2_0._fsm:registerState(RoomObStatePlaceConfirm.New(RoomEnum.FSMObState.PlaceCharacterConfirm))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceCharacter.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.PlaceCharacterConfirm, RoomSceneEvent.TryPlaceCharacter))
		arg_2_0._fsm:registerTransition(RoomTransitionConfirmPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.ConfirmPlaceCharacter))
		arg_2_0._fsm:registerTransition(RoomTransitionCancelPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.CancelPlaceCharacter))
		arg_2_0._fsm:registerTransition(RoomTransitionTryPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.PlaceCharacterConfirm, RoomSceneEvent.TryPlaceCharacter))
		arg_2_0._fsm:registerTransition(RoomTransitionUnUseCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.UnUseCharacter))
		arg_2_0._fsm:registerState(RoomObStateIdle.New(RoomEnum.FSMObState.CharacterBuildingShowTime))
		arg_2_0._fsm:registerTransition(RoomShowTimeCharacterBuilding.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.CharacterBuildingShowTime, RoomSceneEvent.CharacterBuildingShowTime))
		arg_2_0._fsm:start(RoomEnum.FSMObState.Idle)
	end
end

function var_0_0.triggerEvent(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._fsm then
		arg_3_0._fsm:triggerEvent(arg_3_1, arg_3_2)
	end
end

function var_0_0.getCurStateName(arg_4_0)
	if arg_4_0._fsm then
		return arg_4_0._fsm.curStateName
	end
end

function var_0_0.isTransitioning(arg_5_0)
	if arg_5_0._fsm then
		return arg_5_0._fsm.isTransitioning
	end
end

function var_0_0.onSceneClose(arg_6_0)
	if arg_6_0._fsm then
		arg_6_0._fsm:clear()

		arg_6_0._fsm = nil
	end

	arg_6_0._context = nil
end

return var_0_0
