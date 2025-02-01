module("modules.logic.scene.room.comp.entitymgr.RoomSceneCritterEntityMgr", package.seeall)

slot0 = class("RoomSceneCritterEntityMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	for slot7, slot8 in ipairs(RoomCritterModel.instance:getList()) do
		slot0:spawnRoomCritter(slot8)
	end
end

function slot0.spawnRoomCritter(slot0, slot1)
	return slot0:_spawnRoomCritter(slot1, false)
end

function slot0._spawnRoomCritter(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	slot4 = slot1.currentPosition

	if slot2 ~= true then
		slot0:addUnit(MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot0._scene.go.critterRoot, string.format("%s", slot1.id)), RoomCritterEntity, slot1.id))
	end

	gohelper.addChild(slot3, slot5)

	if slot4 then
		slot6:setLocalPos(slot4.x, slot4.y, slot4.z)
	end

	return slot6
end

function slot0.delaySetFollow(slot0, slot1, slot2)
	if slot0:getCritterEntity(slot1, SceneTag.RoomCharacter) and slot3.critterfollower then
		slot3.critterfollower:delaySetFollow(slot2 or 0.1)
	end
end

function slot0.moveTo(slot0, slot1, slot2)
	slot1:setLocalPos(slot2.x, slot2.y, slot2.z)
end

function slot0.destroyCritter(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
end

function slot0.getCritterEntity(slot0, slot1, slot2)
	slot3 = (not slot2 or slot2 == SceneTag.RoomCharacter) and slot0:getTagUnitDict(SceneTag.RoomCharacter)

	return slot3 and slot3[slot1]
end

function slot0.spawnTempCritterByMO(slot0, slot1)
	if slot0._tempCritterEntity then
		if slot1 and slot0._tempCritterEntity.id == slot1.id then
			return slot0._tempCritterEntity
		end

		slot0._tempCritterEntity = nil

		slot0:destroyUnit(slot0._tempCritterEntity)
	end

	if slot1 then
		slot0._tempCritterEntity = slot0:_spawnRoomCritter(slot1, true)
	end

	return slot0._tempCritterEntity
end

function slot0.getTempCritterEntity(slot0)
	return slot0._tempCritterEntity
end

function slot0.getRoomCritterEntityDict(slot0)
	return slot0._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function slot0._onUpdate(slot0)
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)

	if slot0._tempCritterEntity then
		slot0._tempCritterEntity = nil

		slot0:destroyUnit(slot1)
	end
end

return slot0
