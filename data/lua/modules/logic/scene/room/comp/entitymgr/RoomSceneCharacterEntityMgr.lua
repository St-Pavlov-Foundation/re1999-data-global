module("modules.logic.scene.room.comp.entitymgr.RoomSceneCharacterEntityMgr", package.seeall)

slot0 = class("RoomSceneCharacterEntityMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	for slot7, slot8 in ipairs(RoomCharacterModel.instance:getList()) do
		slot0:spawnRoomCharacter(slot8)
	end

	if not slot0:getUnit(SceneTag.Untagged, 1) then
		slot0:_spawnEffect(RoomEnum.EffectKey.CharacterFootPrintGOKey, RoomCharacterFootPrintEntity, 1)
	end
end

function slot0.spawnRoomCharacter(slot0, slot1)
	return slot0:_spawnRoomCharacter(slot1)
end

function slot0._spawnRoomCharacter(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	slot4 = slot1.currentPosition
	slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot0._scene.go.characterRoot, string.format("%s", slot1.id)), RoomCharacterEntity, slot1.id)

	if slot2 ~= true then
		slot0:addUnit(slot6)
	end

	gohelper.addChild(slot3, slot5)
	slot6:setLocalPos(slot4.x, slot4.y, slot4.z)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterEntityChanged)

	return slot6
end

function slot0._spawnEffect(slot0, slot1, slot2, slot3)
	slot4 = slot0._scene.go.characterRoot
	slot5 = gohelper.create3d(slot4, slot1)
	slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(slot5, slot2, slot3)

	gohelper.addChild(slot4, slot5)
	slot0:addUnit(slot6)

	return slot6
end

function slot0.moveTo(slot0, slot1, slot2)
	slot1:setLocalPos(slot2.x, slot2.y, slot2.z)
end

function slot0.destroyCharacter(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterEntityChanged)
end

function slot0.getCharacterEntity(slot0, slot1, slot2)
	slot3 = (not slot2 or slot2 == SceneTag.RoomCharacter) and slot0:getTagUnitDict(SceneTag.RoomCharacter)

	return slot3 and slot3[slot1]
end

function slot0.spawnTempCharacterByMO(slot0, slot1)
	if slot0._tempCharacterEntity then
		if slot1 and slot0._tempCharacterEntity.id == slot1.id then
			return slot0._tempCharacterEntity
		end

		slot0._tempCharacterEntity = nil

		slot0:destroyUnit(slot0._tempCharacterEntity)
	end

	if slot1 then
		slot0._tempCharacterEntity = slot0:_spawnRoomCharacter(slot1, true)
	end

	return slot0._tempCharacterEntity
end

function slot0.getTempCharacterEntity(slot0)
	return slot0._tempCharacterEntity
end

function slot0.getRoomCharacterEntityDict(slot0)
	return slot0._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function slot0._onUpdate(slot0)
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)

	if slot0._tempCharacterEntity then
		slot0._tempCharacterEntity = nil

		slot0:destroyUnit(slot1)
	end
end

return slot0
