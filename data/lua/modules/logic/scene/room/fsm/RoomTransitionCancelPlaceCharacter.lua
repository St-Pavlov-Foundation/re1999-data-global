module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceCharacter", package.seeall)

slot0 = class("RoomTransitionCancelPlaceCharacter", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1

	if RoomCharacterModel.instance:getTempCharacterMO() then
		if slot2:isTrainSourceState() or slot2:isTraining() then
			slot0:_finish()
			GameFacade.showToast(ToastEnum.RoomUnUseTrainCharacter)

			return
		end

		slot3 = slot0._scene.charactermgr:getCharacterEntity(slot2.id, SceneTag.RoomCharacter)

		if slot2.characterState == RoomCharacterEnum.CharacterState.Temp then
			slot0._toDestroyEntity = slot3

			slot3.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "close", 0, slot0._animDone, slot0)

			if slot0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPressingCharacter, nil, "disappearEffect", nil, 2.5) then
				slot5, slot6, slot7 = transformhelper.getPos(slot3.staticContainerGO.transform)

				transformhelper.setPos(slot4.transform, slot5, slot6, slot7)

				if slot4:GetComponent(RoomEnum.ComponentType.Animator) then
					slot8:Play("disappear", 0, 0)
				end
			end
		elseif slot2.characterState == RoomCharacterEnum.CharacterState.Revert then
			RoomCharacterModel.instance:removeRevertCharacterMO()

			if slot3 then
				slot0._scene.charactermgr:moveTo(slot3, slot2.currentPosition)
			end

			slot0:_finish()
		end
	else
		slot0:_finish()
	end
end

function slot0._animDone(slot0)
	RoomCharacterModel.instance:removeTempCharacterMO()

	if slot0._toDestroyEntity then
		slot0._scene.charactermgr:destroyCharacter(slot0._toDestroyEntity)

		slot0._toDestroyEntity = nil
	end

	slot0:_finish()
end

function slot0._finish(slot0)
	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	slot0:onDone()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
	slot0._toDestroyEntity = nil
end

return slot0
