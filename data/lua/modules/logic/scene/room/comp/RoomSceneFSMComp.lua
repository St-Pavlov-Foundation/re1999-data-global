module("modules.logic.scene.room.comp.RoomSceneFSMComp", package.seeall)

slot0 = class("RoomSceneFSMComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._context = {}
	slot0._fsm = SimpleFSM.New(slot0._context)

	if RoomController.instance:isEditMode() then
		slot0._fsm:registerState(RoomEditStateIdle.New(RoomEnum.FSMEditState.Idle))
		slot0._fsm:registerState(RoomEditStatePlaceConfirm.New(RoomEnum.FSMEditState.PlaceConfirm))
		slot0._fsm:registerState(RoomEditStateBackConfirm.New(RoomEnum.FSMEditState.BackConfirm))
		slot0._fsm:registerState(RoomEditStatePlaceConfirm.New(RoomEnum.FSMEditState.PlaceBuildingConfirm))
		slot0._fsm:registerState(SimpleFSMBaseState.New(RoomEnum.FSMEditState.WaterReform))

		slot3 = {
			RoomEnum.FSMEditState.BackConfirm
		}
		slot4 = {
			RoomEnum.FSMEditState.BackConfirm,
			RoomEnum.FSMEditState.PlaceConfirm
		}

		slot0._fsm:registerTransition(RoomTransitionConfirmPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBlock, slot3))
		slot0._fsm:registerTransition(RoomTransitionConfirmPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBlock, slot3))
		slot0._fsm:registerTransition(RoomTransitionCancelPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBlock, slot3))
		slot0._fsm:registerTransition(RoomTransitionCancelPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBlock, slot3))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		slot0._fsm:registerTransition(RoomTransitionTryBackBlock.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.BackConfirm, RoomSceneEvent.TryBackBlock, slot4))
		slot0._fsm:registerTransition(RoomTransitionTryBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.BackConfirm, RoomSceneEvent.TryBackBlock, slot4))
		slot0._fsm:registerTransition(RoomTransitionConfirmBackBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmBackBlock, slot4))
		slot0._fsm:registerTransition(RoomTransitionConfirmBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmBackBlock, slot4))
		slot0._fsm:registerTransition(RoomTransitionCancelBackBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelBackBlock, slot4))
		slot0._fsm:registerTransition(RoomTransitionCancelBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelBackBlock, slot4))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionConfirmPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionCancelPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		slot0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		slot0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		slot0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		slot0._fsm:registerTransition(RoomTransitionEnterWaterReform.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.WaterReform, RoomSceneEvent.EnterWaterReform))
		slot0._fsm:registerTransition(RoomTransitionCloseWaterReform.New(RoomEnum.FSMEditState.WaterReform, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CloseWaterReform))
		slot0._fsm:start(RoomEnum.FSMEditState.Idle)
	elseif RoomController.instance:isObMode() then
		slot0._fsm:registerState(RoomObStateIdle.New(RoomEnum.FSMObState.Idle))
		slot0._fsm:registerState(RoomObStatePlaceConfirm.New(RoomEnum.FSMObState.PlaceBuildingConfirm))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionConfirmPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.ConfirmPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionCancelPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.CancelPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		slot0._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.UnUseBuilding))
		slot0._fsm:registerState(RoomObStatePlaceConfirm.New(RoomEnum.FSMObState.PlaceCharacterConfirm))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceCharacter.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.PlaceCharacterConfirm, RoomSceneEvent.TryPlaceCharacter))
		slot0._fsm:registerTransition(RoomTransitionConfirmPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.ConfirmPlaceCharacter))
		slot0._fsm:registerTransition(RoomTransitionCancelPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.CancelPlaceCharacter))
		slot0._fsm:registerTransition(RoomTransitionTryPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.PlaceCharacterConfirm, RoomSceneEvent.TryPlaceCharacter))
		slot0._fsm:registerTransition(RoomTransitionUnUseCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.UnUseCharacter))
		slot0._fsm:registerState(RoomObStateIdle.New(RoomEnum.FSMObState.CharacterBuildingShowTime))
		slot0._fsm:registerTransition(RoomShowTimeCharacterBuilding.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.CharacterBuildingShowTime, RoomSceneEvent.CharacterBuildingShowTime))
		slot0._fsm:start(RoomEnum.FSMObState.Idle)
	end
end

function slot0.triggerEvent(slot0, slot1, slot2)
	if slot0._fsm then
		slot0._fsm:triggerEvent(slot1, slot2)
	end
end

function slot0.getCurStateName(slot0)
	if slot0._fsm then
		return slot0._fsm.curStateName
	end
end

function slot0.isTransitioning(slot0)
	if slot0._fsm then
		return slot0._fsm.isTransitioning
	end
end

function slot0.onSceneClose(slot0)
	if slot0._fsm then
		slot0._fsm:clear()

		slot0._fsm = nil
	end

	slot0._context = nil
end

return slot0
