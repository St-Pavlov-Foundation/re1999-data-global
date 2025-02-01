module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceCharacter", package.seeall)

slot0 = class("RoomTransitionConfirmPlaceCharacter", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot2 = slot0._param.tempCharacterMO

	RoomCharacterController.instance:interruptInteraction(slot2:getCurrentInteractionId())

	if slot0._scene.charactermgr:getCharacterEntity(slot2.id, SceneTag.RoomCharacter) then
		slot0._scene.charactermgr:moveTo(slot3, slot2.currentPosition)
		slot3:playConfirmEffect()
	end

	if not slot2:isPlaceSourceState() and RoomModel.instance:getCharacterById(slot2.id) then
		slot2.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmCharacter)
	slot0:onDone()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
