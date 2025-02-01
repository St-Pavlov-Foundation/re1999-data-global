module("modules.logic.scene.room.fsm.RoomTransitionTryBackBlock", package.seeall)

slot0 = class("RoomTransitionTryBackBlock", JompFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot2 = slot0._param.hexPoint

	if RoomEnum.ConstNum.InventoryBlockOneBackMax <= RoomMapBlockModel.instance:getBackBlockModel():getCount() and slot4:getById(RoomMapBlockModel.instance:getBlockMO(slot2.x, slot2.y).id) == nil then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockOneBackMax)
		slot0:onDone()

		return
	end

	if not RoomMapBlockModel.instance:isBackMore() then
		slot0:_backOne(slot3.id)
	end

	slot5 = slot0._scene.mapmgr:getBlockEntity(slot3.id, SceneTag.RoomMapBlock)
	slot6 = slot0._opToDis[slot3:getOpState()] or RoomBlockEnum.OpState.Normal

	slot3:setOpState(slot6)

	if slot6 == RoomBlockEnum.OpState.Back then
		slot4:addAtLast(slot3)
	else
		slot4:remove(slot3)
		slot5:refreshBlock()

		slot2 = nil
	end

	slot0:onDone()
	slot0:_refreshBackBlock()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientTryBackBlock)

	if slot2 then
		if slot0:_isOutScreen(HexMath.hexToPosition(slot2, RoomBlockEnum.BlockSize)) then
			-- Nothing
		end

		slot0._scene.camera:tweenCamera({
			focusX = slot7.x,
			focusY = slot7.y
		})
	end
end

function slot0._refreshBackBlock(slot0)
	slot1 = RoomMapBlockModel.instance:isCanBackBlock()

	for slot7 = 1, #RoomMapBlockModel.instance:getBackBlockModel():getList() do
		if slot3[slot7]:getOpStateParam() ~= slot1 then
			slot8:setOpState(RoomBlockEnum.OpState.Back, slot1)

			if slot0._scene.mapmgr:getBlockEntity(slot8.id, SceneTag.RoomMapBlock) then
				slot9:refreshBlock()
			end
		end
	end
end

function slot0._backOne(slot0, slot1)
	for slot7 = 1, #RoomMapBlockModel.instance:getBackBlockModel():getList() do
		if slot3[slot7] and slot8.id ~= slot1 then
			slot8:setOpState(RoomBlockEnum.OpState.Normal)

			if slot0._scene.mapmgr:getBlockEntity(slot8.id, SceneTag.RoomMapBlock) then
				slot9:refreshBlock()
			end
		end
	end

	slot2:clear()
end

function slot0._isOutScreen(slot0, slot1)
	return RoomHelper.isOutCameraFocus(slot1)
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

function slot0.onDone(slot0)
	uv0.super.onDone(slot0)
end

return slot0
