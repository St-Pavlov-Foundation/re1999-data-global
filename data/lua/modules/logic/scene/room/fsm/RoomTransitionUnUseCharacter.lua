module("modules.logic.scene.room.fsm.RoomTransitionUnUseCharacter", package.seeall)

slot0 = class("RoomTransitionUnUseCharacter", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot2 = slot0._param.heroId
	slot3 = slot0._param.tempCharacterMO
	slot4 = slot0._param.anim

	RoomCharacterController.instance:interruptInteraction(slot3:getCurrentInteractionId())

	if slot3 and (slot3:isTrainSourceState() or slot3:isTraining()) then
		slot3.sourceState = RoomCharacterEnum.SourceState.Train

		slot0:_animDone()
		GameFacade.showToast(ToastEnum.RoomUnUseTrainCharacter)

		return
	end

	slot5 = slot0._scene.charactermgr:getCharacterEntity(slot3.id, SceneTag.RoomCharacter)

	if slot4 and slot5 and slot5.characterspine then
		slot5.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "close", 0, slot0._animDone, slot0)

		if slot0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPressingCharacter, nil, "disappearEffect", nil, 2.5) then
			slot7, slot8, slot9 = transformhelper.getPos(slot5.staticContainerGO.transform)

			transformhelper.setPos(slot6.transform, slot7, slot8, slot9)

			if slot6:GetComponent(RoomEnum.ComponentType.Animator) then
				slot10:Play("disappear", 0, 0)
			end
		end
	else
		slot0:_animDone()
	end
end

function slot0._animDone(slot0)
	if slot0._param.tempCharacterMO:isTrainSourceState() or slot1:isTraining() then
		RoomCharacterModel.instance:placeTempCharacterMO()
	else
		if slot0._scene.charactermgr:getCharacterEntity(slot1.id, SceneTag.RoomCharacter) then
			slot0._scene.charactermgr:destroyCharacter(slot2)
		end

		RoomCharacterModel.instance:unUseRevertCharacterMO()
	end

	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomMapController.instance:dispatchEvent(RoomEvent.UnUseCharacter)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	slot0:onDone()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
