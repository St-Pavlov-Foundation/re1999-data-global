module("modules.logic.room.entity.comp.RoomBuildingCritterComp", package.seeall)

slot0 = class("RoomBuildingCritterComp", RoomBaseEffectKeyComp)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangSeatSlotVisible, slot0.isShowSeatSlots, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._startRefreshSeatSlotsTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, slot0._startRefreshSeatSlotsTask, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangSeatSlotVisible, slot0.isShowSeatSlots, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._startRefreshSeatSlotsTask, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, slot0._startRefreshSeatSlotsTask, slot0)
end

function slot0.onStart(slot0)
end

function slot0.setSeatSlotItem(slot0)
	slot0._seatSlotDict = {}
	slot1 = slot0:getMO()

	for slot5 = 1, CritterEnum.CritterMaxSeatCount do
		if not slot0.entity:getCritterPoint(slot5 - 1) then
			logError(string.format("RoomBuildingCritterComp:setSeatSlotItem error, no critter point, buildingUid:%s,index:%s", slot1 and slot1.buildingUid, slot6 + 1))

			return
		end

		slot8 = RoomGOPool.getInstance(RoomScenePreloader.CritterBuildingSeatSlot, slot7, "seatSlot" .. slot6)

		gohelper.setActive(slot8, false)

		slot9 = slot0:getUserDataTb_()
		slot9.go = slot8
		slot9.trans = slot8.transform

		transformhelper.setLocalScale(slot9.trans, 0.35, 0.35, 0.35)

		slot9.goLocked = gohelper.findChild(slot9.go, "locked")
		slot9.goUnlocked = gohelper.findChild(slot9.go, "unlocked")
		slot0._seatSlotDict[slot6] = slot9
	end
end

function slot0.cleanSeatSlotItem(slot0)
	if slot0._seatSlotDict then
		for slot4, slot5 in pairs(slot0._seatSlotDict) do
			RoomGOPool.returnInstance(RoomScenePreloader.CritterBuildingSeatSlot, slot5.go)
		end

		slot0._seatSlotDict = nil
	end
end

function slot0.onRebuildEffectGO(slot0)
	if (slot0:getMO() and slot1.config and slot1.config.buildingType) == RoomBuildingEnum.BuildingType.Rest then
		slot0._scene.loader:makeSureLoaded({
			RoomScenePreloader.CritterBuildingSeatSlot
		}, slot0.setSeatSlotItem, slot0)
	end
end

function slot0.onReturnEffectGO(slot0)
	slot0:cleanSeatSlotItem()
end

function slot0.refreshAllCritter(slot0)
end

function slot0.isShowSeatSlots(slot0, slot1)
	if not slot0._seatSlotDict then
		return
	end

	slot0:refreshSeatSlots()

	for slot5, slot6 in pairs(slot0._seatSlotDict) do
		gohelper.setActive(slot6.go, slot1)
	end
end

function slot0._startRefreshSeatSlotsTask(slot0)
	if not slot0._isHasRefreshSeatSlotsTask then
		slot0._isHasRefreshSeatSlotsTask = true

		TaskDispatcher.runDelay(slot0._onRunRefreshSeatSlotsTask, slot0, 0.1)
	end
end

function slot0._onRunRefreshSeatSlotsTask(slot0)
	slot0._isHasRefreshSeatSlotsTask = false

	if slot0.__willDestroy then
		return
	end

	slot0:refreshSeatSlots()
end

function slot0.refreshSeatSlots(slot0)
	if not slot0._seatSlotDict then
		return
	end

	slot1 = slot0:getMO()

	for slot5, slot6 in pairs(slot0._seatSlotDict) do
		gohelper.setActive(slot6.goUnlocked, slot1:getSeatSlotMO(slot5) and slot1:isSeatSlotEmpty(slot5))
		gohelper.setActive(slot6.goLocked, not slot7)
	end
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	slot0:removeEventListeners()
	slot0:cleanSeatSlotItem()

	slot0._isHasRefreshSeatSlotsTask = false

	TaskDispatcher.cancelTask(slot0._onRunRefreshSeatSlotsTask, slot0)
end

return slot0
