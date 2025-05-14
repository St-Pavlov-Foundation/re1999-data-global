module("modules.logic.critter.controller.CritterController", package.seeall)

local var_0_0 = class("CritterController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._oldWorkPathId = nil
	arg_1_0._isToastStopWork = false
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._oldWorkPathId = nil
	arg_4_0._isToastStopWork = false
end

function var_0_0.critterGetInfoReply(arg_5_0, arg_5_1)
	CritterModel.instance:initCritter(arg_5_1.critterInfos)
end

function var_0_0.critterInfoPush(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.critterInfos or {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		CritterModel.instance:addCritter(iter_6_1)
	end

	arg_6_0:dispatchEvent(CritterEvent.CritterInfoPushReply)

	arg_6_0.tempCritterMoList = {}

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		local var_6_1 = CritterMO.New()

		var_6_1:init(iter_6_3)

		arg_6_0.tempCritterMoList[iter_6_2] = var_6_1
	end
end

function var_0_0.startTrainCritterReply(arg_7_0, arg_7_1)
	local var_7_0 = CritterModel.instance:getCritterMOByUid(arg_7_1.uid)

	if var_7_0 then
		var_7_0.trainInfo.heroId = arg_7_1.heroId

		local var_7_1 = RoomTrainSlotListModel.instance:findWaitingSlotMOByUid(arg_7_1.uid) or RoomTrainSlotListModel.instance:findFreeSlotMO()

		if var_7_1 then
			var_7_1:setCritterMO(var_7_0)
		end
	end

	arg_7_0:dispatchEvent(CritterEvent.TrainStartTrainCritterReply, arg_7_1.uid, arg_7_1.heroId)
end

function var_0_0.fastForwardTrainReply(arg_8_0, arg_8_1)
	arg_8_0:dispatchEvent(CritterEvent.FastForwardTrainReply)
end

function var_0_0.cancelTrainReply(arg_9_0, arg_9_1)
	local var_9_0 = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(arg_9_1.uid)

	if var_9_0 then
		var_9_0:setCritterMO(nil)
	end

	arg_9_0:dispatchEvent(CritterEvent.TrainCancelTrainReply, arg_9_1.uid)
end

function var_0_0.selectEventOptionReply(arg_10_0, arg_10_1)
	arg_10_0:dispatchEvent(CritterEvent.TrainSelectEventOptionReply, arg_10_1.uid, arg_10_1.eventId or 0)
end

function var_0_0.finishTrainCritterReply(arg_11_0, arg_11_1)
	local var_11_0 = CritterModel.instance:getCritterMOByUid(arg_11_1.uid)

	if var_11_0 then
		var_11_0.trainInfo.heroId = 0
	end

	local var_11_1 = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(arg_11_1.uid)

	if var_11_1 then
		var_11_1:setCritterMO(nil)
	end

	arg_11_0:dispatchEvent(CritterEvent.TrainFinishTrainCritterReply, arg_11_1.uid, arg_11_1.heroId)
end

function var_0_0.startTrainCritterPreviewReply(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.info
	local var_12_1 = var_12_0.uid
	local var_12_2 = var_12_0.trainInfo and var_12_0.trainInfo.heroId
	local var_12_3 = CritterModel.instance:getTrainPreviewMO(var_12_1, var_12_2)

	if var_12_3 then
		var_12_3:init(var_12_0)
	else
		local var_12_4 = CritterMO.New()

		var_12_4:init(var_12_0)
		CritterModel.instance:addTrainPreviewMO(var_12_4)
	end

	arg_12_0:dispatchEvent(CritterEvent.StartTrainCritterPreviewReply, var_12_1, var_12_2)
end

function var_0_0.finishTrainSpecialEventByUid(arg_13_0, arg_13_1)
	local var_13_0 = CritterModel.instance:getCritterMOByUid(arg_13_1)

	if var_13_0 and var_13_0:isCultivating() then
		local var_13_1 = var_13_0.trainInfo.events

		for iter_13_0 = 1, #var_13_1 do
			local var_13_2 = var_13_1[iter_13_0]

			if var_13_2:getEventType() == CritterEnum.EventType.Special and not var_13_2:isEventFinish() then
				local var_13_3 = 0

				if #var_13_2.options > 0 then
					var_13_3 = var_13_2.options[1].optionId
				end

				CritterRpc.instance:sendSelectEventOptionRequest(var_13_0.uid, var_13_2.eventId, var_13_3)
			end
		end
	end
end

function var_0_0.banishCritterReply(arg_14_0, arg_14_1)
	CritterModel.instance:removeCritters(arg_14_1.uids)
	ManufactureController.instance:removeRestingCritterList(arg_14_1.uids)
	arg_14_0:dispatchEvent(CritterEvent.CritterDecomposeReply, arg_14_1.uids)
end

function var_0_0.lockCritterRequest(arg_15_0, arg_15_1)
	local var_15_0 = CritterModel.instance:getCritterMOByUid(arg_15_1.uid)

	if var_15_0 then
		var_15_0.lock = arg_15_1.lock
	end

	arg_15_0:dispatchEvent(CritterEvent.CritterChangeLockStatus, arg_15_1.uid)
end

function var_0_0.critterRenameReply(arg_16_0, arg_16_1)
	CritterModel.instance:getCritterMOByUid(arg_16_1.uid).name = arg_16_1.name

	arg_16_0:dispatchEvent(CritterEvent.CritterRenameReply, arg_16_1.uid)
end

function var_0_0.updateCritterPreviewAttr(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	CritterRpc.instance:sendGetRealCritterAttributeRequest(arg_17_1, arg_17_2, true, arg_17_3, arg_17_4)
end

function var_0_0.setManufactureCritterList(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	ManufactureCritterListModel.instance:setCritterNewList(arg_18_2, arg_18_3, arg_18_4)

	local var_18_0 = ManufactureCritterListModel.instance:getPreviewCritterUidList()

	if arg_18_1 and var_18_0 and #var_18_0 > 0 then
		arg_18_0:updateCritterPreviewAttr(arg_18_1, var_18_0, arg_18_0._setCritterList, arg_18_0)
	else
		arg_18_0:_setCritterList()
	end
end

function var_0_0._setCritterList(arg_19_0)
	arg_19_0:dispatchEvent(CritterEvent.CritterListResetScrollPos)
	ManufactureCritterListModel.instance:setManufactureCritterList()
	arg_19_0:dispatchEvent(CritterEvent.CritterListUpdate)
end

function var_0_0.getNextCritterPreviewAttr(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_1 then
		return
	end

	local var_20_0 = ManufactureCritterListModel.instance:getPreviewCritterUidList(arg_20_2)

	if var_20_0 and #var_20_0 > 0 then
		arg_20_0:updateCritterPreviewAttr(arg_20_1, var_20_0)
	end
end

function var_0_0.clickCritterPlaceItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_21_1)

	if not var_21_0 then
		return
	end

	local var_21_1 = arg_21_2
	local var_21_2 = var_21_0:isCritterInSeatSlot(arg_21_2)

	if var_21_2 then
		var_21_1 = CritterEnum.InvalidCritterUid
	else
		var_21_2 = var_21_0:getNextEmptyCritterSeatSlot()
	end

	if not var_21_2 then
		GameFacade.showToast(ToastEnum.RoomNoEmptySeatSlot)

		return
	end

	arg_21_0:changeRestCritter(arg_21_1, var_21_2, var_21_1)
end

function var_0_0.waitSendBuildManufacturAttrByBuid(arg_22_0, arg_22_1)
	arg_22_0._waitBuildManufacturBuidList = arg_22_0._waitBuildManufacturBuidList or {}

	if not arg_22_1 or tabletool.indexOf(arg_22_0._waitBuildManufacturBuidList, arg_22_1) then
		return
	end

	table.insert(arg_22_0._waitBuildManufacturBuidList, arg_22_1)

	if #arg_22_0._waitBuildManufacturBuidList == 1 then
		TaskDispatcher.runDelay(arg_22_0._onRunSendBuildManufacturAll, arg_22_0, 1)
	end
end

function var_0_0._onRunSendBuildManufacturAll(arg_23_0)
	local var_23_0 = arg_23_0._waitBuildManufacturBuidList

	arg_23_0._waitBuildManufacturBuidList = nil

	if var_23_0 then
		for iter_23_0 = 1, #var_23_0 do
			arg_23_0:sendBuildManufacturAttrByBuid(var_23_0[iter_23_0])
		end
	end
end

function var_0_0.sendBuildManufacturAttrByBtype(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1 and iter_24_1.config and iter_24_1.config.buildingType == arg_24_1 then
			if arg_24_2 == true then
				arg_24_0:waitSendBuildManufacturAttrByBuid(iter_24_1.id)
			else
				arg_24_0:sendBuildManufacturAttrByBuid(iter_24_1.id)
			end
		end
	end
end

function var_0_0.sendBuildManufacturAttrByBuid(arg_25_0, arg_25_1)
	local var_25_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_25_1)

	if not var_25_0 then
		return
	end

	local var_25_1 = CritterModel.instance:getAllCritters()
	local var_25_2

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_3 = iter_25_1:getId()

		if iter_25_1:isMaturity() and iter_25_1.workInfo and iter_25_1.workInfo.workBuildingUid == arg_25_1 or iter_25_1.restInfo and iter_25_1.restInfo.restBuildingUid == arg_25_1 then
			var_25_2 = var_25_2 or {}

			table.insert(var_25_2, var_25_3)
		end
	end

	if var_25_2 then
		CritterRpc.instance:sendGetRealCritterAttributeRequest(var_25_0.buildingId, var_25_2, false)
	end
end

function var_0_0.clickCritterInCritterBuilding(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_26_1)
	local var_26_1 = var_26_0 and var_26_0:isCritterInSeatSlot(arg_26_2)
	local var_26_2, var_26_3 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if not var_26_1 or var_26_2 == arg_26_1 and var_26_3 == var_26_1 then
		arg_26_0:clearSelectedCritterSeatSlot()
	else
		ManufactureModel.instance:setSelectedCritterSeatSlot(arg_26_1, var_26_1)
		arg_26_0:dispatchEvent(CritterEvent.CritterBuildingSelectCritter)
	end
end

function var_0_0.clearSelectedCritterSeatSlot(arg_27_0)
	ManufactureModel.instance:setSelectedCritterSeatSlot()
	arg_27_0:dispatchEvent(CritterEvent.CritterBuildingSelectCritter)
end

function var_0_0.changeRestCritter(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	RoomRpc.instance:sendChangeRestCritterRequest(arg_28_1, CritterEnum.SeatSlotOperation.Change, arg_28_2, arg_28_3, 0, arg_28_0._afterChangeRestCritter, arg_28_0)
	ManufactureModel.instance:setNewRestCritter(arg_28_3)

	arg_28_0._isToastStopWork = false
	arg_28_0._oldWorkPathId = nil

	local var_28_0 = CritterModel.instance:getCritterMOByUid(arg_28_3)

	if var_28_0 and not var_28_0:isNoMood() then
		local var_28_1 = ManufactureModel.instance:getCritterWorkingBuilding(arg_28_3)
		local var_28_2 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(arg_28_3)

		if var_28_1 or var_28_2 then
			arg_28_0._isToastStopWork = true

			if var_28_2 then
				arg_28_0._oldWorkPathId = var_28_2.id
			end
		end
	end
end

function var_0_0._afterChangeRestCritter(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2 ~= 0 then
		arg_29_0._isToastStopWork = false

		return
	end

	if arg_29_0._isToastStopWork then
		GameFacade.showToast(ToastEnum.CritterStopWork)
	end

	if arg_29_0._oldWorkPathId then
		local var_29_0 = {
			critterUid = CritterEnum.InvalidCritterUid
		}

		RoomTransportPathModel.instance:updateInofoById(arg_29_0._oldWorkPathId, var_29_0)
		RoomMapTransportPathModel.instance:updateInofoById(arg_29_0._oldWorkPathId, var_29_0)
	end

	arg_29_0._oldWorkPathId = nil
	arg_29_0._isToastStopWork = false
end

function var_0_0.exchangeSeatSlot(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if RoomMapBuildingModel.instance:getBuildingMOById(arg_30_1):getSeatSlotMO(arg_30_3) then
		RoomRpc.instance:sendChangeRestCritterRequest(arg_30_1, CritterEnum.SeatSlotOperation.Exchange, arg_30_2, CritterEnum.InvalidCritterUid, arg_30_3)
	else
		local var_30_0 = RoomCameraController.instance:getRoomScene()

		if var_30_0 then
			var_30_0.buildingcrittermgr:refreshAllCritterEntityPos()
		end
	end
end

function var_0_0.setCritterBuildingInfoList(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return
	end

	ManufactureModel.instance:setCritterBuildingInfoList(arg_31_1)
	RoomCritterModel.instance:initStayBuildingCritters()
	arg_31_0:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
end

function var_0_0.buySeatSlot(arg_32_0, arg_32_1, arg_32_2)
	RoomRpc.instance:sendBuyRestSlotRequest(arg_32_1, arg_32_2)
end

function var_0_0.buySeatSlotCb(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = ManufactureModel.instance:getCritterBuildingMOById(arg_33_1)

	if not var_33_0 then
		return
	end

	var_33_0:unlockSeatSlot(arg_33_2)
	arg_33_0:dispatchEvent(CritterEvent.CritterUnlockSeatSlot)
end

function var_0_0.openCritterFilterView(arg_34_0, arg_34_1, arg_34_2)
	ViewMgr.instance:openView(ViewName.RoomCritterFilterView, {
		filterTypeList = arg_34_1,
		viewName = arg_34_2
	})
end

function var_0_0.openCriiterDetailSimpleView(arg_35_0, arg_35_1)
	local var_35_0 = {
		critterMo = arg_35_1
	}

	ViewMgr.instance:openView(ViewName.RoomCriiterDetailSimpleView, var_35_0)
end

function var_0_0.openRoomCritterDetailView(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = {
		isYoung = arg_36_1,
		critterMo = arg_36_2,
		isPreview = arg_36_3,
		critterMos = arg_36_4
	}

	if arg_36_1 then
		ViewMgr.instance:openView(ViewName.RoomCritterDetailYoungView, var_36_0)
	else
		ViewMgr.instance:openView(ViewName.RoomCritterDetailMaturityView, var_36_0)
	end
end

function var_0_0.popUpCritterGetView(arg_37_0)
	local var_37_0 = arg_37_0.tempCritterMoList

	if var_37_0 and #var_37_0 > 0 then
		local var_37_1 = {
			isSkip = true,
			mode = RoomSummonEnum.SummonType.ItemGet,
			critterMOList = var_37_0
		}

		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomGetCritterView, ViewName.RoomGetCritterView, var_37_1)

		arg_37_0.tempCritterMoList = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
