module("modules.logic.scene.room.comp.entitymgr.RoomSceneInventoryEntitySelectMgr", package.seeall)

slot0 = class("RoomSceneInventoryEntitySelectMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._inventoryRootGO = slot0._scene.go.inventoryRootGO
	slot0._inventoryBlockIdList = {}
	slot0._entityPosInfoList = {}
	slot0._locationParamDic = {}

	for slot6 = 1, 24 do
		table.insert(slot0._entityPosInfoList, {
			blockId = 0,
			remove = false,
			index = slot6
		})
	end

	slot0:refreshInventoryBlock()
end

function slot0.refreshInventoryBlock(slot0)
	if not RoomController.instance:isEditMode() then
		return
	end

	if slot0:_isHasEntity() then
		slot0._scene.camera:refreshOrthCamera()
	end
end

function slot0._isHasEntity(slot0)
	if slot0._entityPosInfoList then
		for slot4, slot5 in ipairs(slot0._entityPosInfoList) do
			if slot5.blockId ~= 0 then
				return true
			end
		end
	end

	return false
end

function slot0.addBlockEntity(slot0, slot1, slot2)
	if slot1 then
		slot0:_setTransform(slot0:_getOrcreateUnit(slot1, slot2), slot0:_findIndexById(slot1))
		slot0:refreshInventoryBlock()
	end
end

function slot0.removeBlockEntity(slot0, slot1)
	if slot1 then
		slot0:_deleteById(slot1)
		slot0:refreshInventoryBlock()
	end
end

function slot0.getIndexById(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._entityPosInfoList) do
		if slot6.blockId == slot1 then
			return slot6.index
		end
	end
end

function slot0._removeIndexById(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._entityPosInfoList) do
		if slot6.blockId == slot1 then
			slot6.blockId = 0

			return slot6.index
		end
	end
end

function slot0._findIndexById(slot0, slot1)
	if slot0:getIndexById(slot1) then
		return slot2
	end

	for slot6, slot7 in ipairs(slot0._entityPosInfoList) do
		if slot7.blockId == 0 then
			slot7.blockId = slot1

			return slot7.index
		end
	end
end

function slot0._getOrcreateUnit(slot0, slot1, slot2)
	if not slot0:getUnit(SceneTag.RoomInventoryBlock, slot1) then
		slot4 = gohelper.create3d(slot0._inventoryRootGO, string.format("block_%d", slot1))
		slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomInventoryBlockEntity, {
			entityId = slot1,
			isWaterReform = slot2
		})
		slot3.retainCount = 1

		slot0:addUnit(slot3)
		table.insert(slot0._inventoryBlockIdList, slot1)
		gohelper.addChild(slot0._inventoryRootGO, slot4)
	else
		slot3.retainCount = slot3.retainCount + 1
	end

	slot0:refreshInventoryBlock()

	return slot3
end

function slot0._deleteById(slot0, slot1)
	if slot0:getUnit(SceneTag.RoomInventoryBlock, slot1) then
		slot2.retainCount = slot2.retainCount - 1

		if slot2.retainCount < 1 then
			slot2.retainCount = 0

			slot0:_removeIndexById(slot1)
		end
	else
		slot0:_removeIndexById(slot1)
	end

	if not slot0._isHasDelayCheckRetainTask then
		slot0._isHasDelayCheckRetainTask = true

		TaskDispatcher.runDelay(slot0._onDelayCheckRetain, slot0, 0.06666666666666667)
	end

	slot0:refreshInventoryBlock()
end

function slot0._onDelayCheckRetain(slot0)
	slot0._isHasDelayCheckRetainTask = false

	for slot5 = #slot0._inventoryBlockIdList, 1, -1 do
		if not slot0:getIndexById(slot1[slot5]) then
			table.remove(slot1, slot5)
			slot0:removeUnit(SceneTag.RoomInventoryBlock, slot6)
		end
	end

	slot0:refreshInventoryBlock()
end

function slot0._setTransform(slot0, slot1, slot2)
	slot3 = slot1.goTrs
	slot4 = slot0:_getLocationParam(slot2)

	transformhelper.setLocalScale(slot3, slot4.scale, slot4.scale, slot4.scale)
	transformhelper.setLocalRotation(slot3, slot4.rotationX, slot4.rotationY, slot4.rotationZ)
	slot1:setLocalPos(slot4.positionX, slot4.positionY, slot4.positionZ)
	slot1:refreshBlock()
	slot1:refreshRotation()
	slot0:refreshInventoryBlock()
end

function slot0.moveForward(slot0)
	slot0:refreshInventoryBlock()
end

function slot0.playForwardAnim(slot0, slot1, slot2)
	slot0:_removeAnim()

	if slot1 then
		slot0._forwardAnimCallback = slot1
		slot0._forwardAnimCallbackObj = slot2
		slot0._isDelayForwardAminRun = true

		TaskDispatcher.runDelay(slot0._delayForwardAnimCallback, slot0, 0.11)
	end

	slot0:refreshInventoryBlock()
end

function slot0._removeAnim(slot0)
	slot0._forwardAnimCallback = nil
	slot0._forwardAnimCallbackObj = nil

	if slot0._isDelayForwardAminRun then
		slot0._isDelayForwardAminRun = false

		TaskDispatcher.cancelTask(slot0._delayForwardAnimCallback, slot0)
	end
end

function slot0._delayForwardAnimCallback(slot0)
	slot0._isDelayForwardAminRun = false

	if slot0._forwardAnimCallback then
		if slot0._forwardAnimCallbackObj then
			slot0._forwardAnimCallback(slot0._forwardAnimCallbackObj)
		else
			slot0._forwardAnimCallback()
		end
	end

	slot0:refreshInventoryBlock()
end

function slot0._getLocationParam(slot0, slot1)
	if not slot0._locationParamDic[slot1] then
		slot2 = {}
		slot0._locationParamDic[slot1] = slot2
		slot3 = slot1 - 1
		slot2.positionX = -2.51 + math.floor(slot3 % 6) * 1
		slot2.positionY = 0.15
		slot2.positionZ = -1.55 + math.floor(slot3 / 6) * 1.3125
		slot2.rotationX = 26
		slot2.rotationY = 0
		slot2.rotationZ = 0
		slot2.scale = 0.9
	end

	return slot2
end

function slot0.refreshRemainBlock(slot0)
end

function slot0.getBlockEntity(slot0, slot1)
	return slot0:getTagUnitDict(SceneTag.RoomInventoryBlock) and slot2[slot1]
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayCheckRetain, slot0)

	slot0._inventoryBlockIdList = {}

	slot0:_removeAnim()
	slot0:removeAllUnits()
end

function slot0.addUnit(slot0, slot1)
	uv0.super.addUnit(slot0, slot1)
end

return slot0
