module("modules.logic.room.entity.comp.RoomBuildingCritterComp", package.seeall)

local var_0_0 = class("RoomBuildingCritterComp", RoomBaseEffectKeyComp)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangSeatSlotVisible, arg_2_0.isShowSeatSlots, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_2_0._startRefreshSeatSlotsTask, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, arg_2_0._startRefreshSeatSlotsTask, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangSeatSlotVisible, arg_3_0.isShowSeatSlots, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_3_0._startRefreshSeatSlotsTask, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, arg_3_0._startRefreshSeatSlotsTask, arg_3_0)
end

function var_0_0.onStart(arg_4_0)
	return
end

function var_0_0.setSeatSlotItem(arg_5_0)
	arg_5_0._seatSlotDict = {}

	local var_5_0 = arg_5_0:getMO()

	for iter_5_0 = 1, CritterEnum.CritterMaxSeatCount do
		local var_5_1 = iter_5_0 - 1
		local var_5_2 = arg_5_0.entity:getCritterPoint(var_5_1)

		if not var_5_2 then
			logError(string.format("RoomBuildingCritterComp:setSeatSlotItem error, no critter point, buildingUid:%s,index:%s", var_5_0 and var_5_0.buildingUid, var_5_1 + 1))

			return
		end

		local var_5_3 = RoomGOPool.getInstance(RoomScenePreloader.CritterBuildingSeatSlot, var_5_2, "seatSlot" .. var_5_1)

		gohelper.setActive(var_5_3, false)

		local var_5_4 = arg_5_0:getUserDataTb_()

		var_5_4.go = var_5_3
		var_5_4.trans = var_5_3.transform

		transformhelper.setLocalScale(var_5_4.trans, 0.35, 0.35, 0.35)

		var_5_4.goLocked = gohelper.findChild(var_5_4.go, "locked")
		var_5_4.goUnlocked = gohelper.findChild(var_5_4.go, "unlocked")
		arg_5_0._seatSlotDict[var_5_1] = var_5_4
	end
end

function var_0_0.cleanSeatSlotItem(arg_6_0)
	if arg_6_0._seatSlotDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._seatSlotDict) do
			RoomGOPool.returnInstance(RoomScenePreloader.CritterBuildingSeatSlot, iter_6_1.go)
		end

		arg_6_0._seatSlotDict = nil
	end
end

function var_0_0.onRebuildEffectGO(arg_7_0)
	local var_7_0 = arg_7_0:getMO()

	if (var_7_0 and var_7_0.config and var_7_0.config.buildingType) == RoomBuildingEnum.BuildingType.Rest then
		arg_7_0._scene.loader:makeSureLoaded({
			RoomScenePreloader.CritterBuildingSeatSlot
		}, arg_7_0.setSeatSlotItem, arg_7_0)
	end
end

function var_0_0.onReturnEffectGO(arg_8_0)
	arg_8_0:cleanSeatSlotItem()
end

function var_0_0.refreshAllCritter(arg_9_0)
	return
end

function var_0_0.isShowSeatSlots(arg_10_0, arg_10_1)
	if not arg_10_0._seatSlotDict then
		return
	end

	arg_10_0:refreshSeatSlots()

	for iter_10_0, iter_10_1 in pairs(arg_10_0._seatSlotDict) do
		gohelper.setActive(iter_10_1.go, arg_10_1)
	end
end

function var_0_0._startRefreshSeatSlotsTask(arg_11_0)
	if not arg_11_0._isHasRefreshSeatSlotsTask then
		arg_11_0._isHasRefreshSeatSlotsTask = true

		TaskDispatcher.runDelay(arg_11_0._onRunRefreshSeatSlotsTask, arg_11_0, 0.1)
	end
end

function var_0_0._onRunRefreshSeatSlotsTask(arg_12_0)
	arg_12_0._isHasRefreshSeatSlotsTask = false

	if arg_12_0.__willDestroy then
		return
	end

	arg_12_0:refreshSeatSlots()
end

function var_0_0.refreshSeatSlots(arg_13_0)
	if not arg_13_0._seatSlotDict then
		return
	end

	local var_13_0 = arg_13_0:getMO()

	for iter_13_0, iter_13_1 in pairs(arg_13_0._seatSlotDict) do
		local var_13_1 = var_13_0:getSeatSlotMO(iter_13_0)
		local var_13_2 = var_13_0:isSeatSlotEmpty(iter_13_0)

		gohelper.setActive(iter_13_1.goUnlocked, var_13_1 and var_13_2)
		gohelper.setActive(iter_13_1.goLocked, not var_13_1)
	end
end

function var_0_0.getMO(arg_14_0)
	return arg_14_0.entity:getMO()
end

function var_0_0.beforeDestroy(arg_15_0)
	arg_15_0.__willDestroy = true

	arg_15_0:removeEventListeners()
	arg_15_0:cleanSeatSlotItem()

	arg_15_0._isHasRefreshSeatSlotsTask = false

	TaskDispatcher.cancelTask(arg_15_0._onRunRefreshSeatSlotsTask, arg_15_0)
end

return var_0_0
