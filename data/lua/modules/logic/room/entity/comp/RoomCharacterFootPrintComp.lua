module("modules.logic.room.entity.comp.RoomCharacterFootPrintComp", package.seeall)

slot0 = class("RoomCharacterFootPrintComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goTrs = slot1.transform
	slot2, slot3, slot4 = transformhelper.getPos(slot0.goTrs)
	slot0._lastPosition = Vector3(slot2, slot3, slot4)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._footDistance = 0.05
end

function slot0.addEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._updateCharacterMove, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._updateCharacterMove, slot0)
end

function slot0._updateCharacterMove(slot0)
	slot0:_updateMovingLookDir()
end

function slot0._updateMovingLookDir(slot0)
	if slot0.entity.isPressing then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	if slot0._scene.character:isLock() then
		return
	end

	if slot1:getMoveState() ~= RoomCharacterEnum.CharacterMoveState.Move then
		slot0._needFootPrint = true

		return
	end

	slot2 = slot1:getMovingDir()

	if slot2.x == 0 and slot2.y == 0 then
		return
	end

	slot5, slot6, slot7 = transformhelper.getPos(slot0.goTrs)
	slot8 = Vector3(slot5, slot6, slot7)

	if slot0._needFootPrint or slot0._footDistance <= Vector3.Distance(slot0._lastPosition, slot8) then
		slot9, slot10 = HexMath.posXYToRoundHexYX(slot5, slot7, RoomBlockEnum.BlockSize)

		if RoomMapBlockModel.instance:getBlockMO(slot9, slot10) and slot11:isInMapBlock() and RoomBlockEnum.FootPrintDict[slot11:getDefineBlockType()] then
			slot0._needFootPrint = false
			slot0._lastPosition = slot8
			slot0._isLeftFoot = slot0._isLeftFoot == false

			RoomMapController.instance:dispatchEvent(RoomEvent.AddCharacterFootPrint, Quaternion.LookRotation(Vector3(slot3, 0, slot4), Vector3.up).eulerAngles, slot8, slot0._isLeftFoot)
		end
	end
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

return slot0
