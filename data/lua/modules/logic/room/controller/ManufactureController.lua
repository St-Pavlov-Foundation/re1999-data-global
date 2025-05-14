module("modules.logic.room.controller.ManufactureController", package.seeall)

local var_0_0 = class("ManufactureController", BaseController)
local var_0_1 = 0.2

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._realOpenManufactureBuildingView, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._realOpenCritterBuildingView, arg_3_0)
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.checkManufactureInfoUpdate(arg_5_0)
	local var_5_0 = false
	local var_5_1 = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = iter_5_1:getSlotIdInProgress()

		if iter_5_1:getSlotProgress(var_5_2) >= 1 then
			var_5_0 = true

			break
		end
	end

	if var_5_0 then
		arg_5_0:getManufactureServerInfo()
	end
end

function var_0_0.updateTraceNeedItemDict(arg_6_0)
	local var_6_0 = RoomController.instance:isRoomScene()
	local var_6_1 = RoomTradeModel.instance:isGetOrderInfo()

	if var_6_0 and var_6_1 then
		RoomTradeModel.instance:calTracedItemDict()
	end
end

function var_0_0.getManufactureServerInfo(arg_7_0)
	if not ManufactureModel.instance:isManufactureUnlock() then
		return
	end

	RoomRpc.instance:sendGetManufactureInfoRequest()
end

function var_0_0.setManufactureItems(arg_8_0, arg_8_1, arg_8_2)
	RoomRpc.instance:sendSelectSlotProductionPlanRequest(arg_8_1, arg_8_2)
end

function var_0_0.upgradeManufactureBuilding(arg_9_0, arg_9_1)
	RoomRpc.instance:sendManuBuildingUpgradeRequest(arg_9_1)
end

function var_0_0.allocateCritter(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	RoomRpc.instance:sendDispatchCritterRequest(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.useAccelerateItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_4 then
		logError("ManufactureController:useAccelerateItem error, slotId is nil")

		return
	end

	arg_11_0:clearSelectedSlotItem()

	local var_11_0 = {
		type = MaterialEnum.MaterialType.Item,
		id = arg_11_2,
		quantity = arg_11_3
	}

	RoomRpc.instance:sendManufactureAccelerateRequest(arg_11_1, var_11_0, arg_11_4)
end

function var_0_0.gainCompleteManufactureItem(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or RoomManufactureEnum.InvalidBuildingUid

	RoomRpc.instance:sendReapFinishSlotRequest(arg_12_1)
end

function var_0_0.updateManufactureInfo(arg_13_0, arg_13_1)
	ManufactureModel.instance:resetDataBeforeSetInfo()

	if arg_13_1 then
		ManufactureModel.instance:setManufactureInfo(arg_13_1)
		RoomCritterModel.instance:initStayBuildingCritters()
	end

	arg_13_0:dispatchEvent(ManufactureEvent.ManufactureInfoUpdate)
end

function var_0_0.updateTradeLevel(arg_14_0, arg_14_1)
	ManufactureModel.instance:setTradeLevel(arg_14_1)
	arg_14_0:dispatchEvent(ManufactureEvent.TradeLevelChange)
end

function var_0_0.updateManuBuildingInfoList(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 then
		return
	end

	ManufactureModel.instance:setManuBuildingInfoList(arg_15_1)

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		var_15_0[iter_15_1.buildingUid] = true
	end

	RoomCritterModel.instance:initStayBuildingCritters()

	if arg_15_2 then
		ManufactureModel.instance:clientCalAllFrozenItemDict()
	end

	arg_15_0:dispatchEvent(ManufactureEvent.ManufactureBuildingInfoChange, var_15_0)
end

function var_0_0.updateManuBuildingInfo(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	ManufactureModel.instance:setManuBuildingInfo(arg_16_1, true)
	RoomCritterModel.instance:initStayBuildingCritters()
	arg_16_0:dispatchEvent(ManufactureEvent.ManufactureBuildingInfoChange, {
		[arg_16_1.buildingUid] = true
	})
end

function var_0_0.updateWorkCritterInfo(arg_17_0, arg_17_1)
	arg_17_0:dispatchEvent(ManufactureEvent.CritterWorkInfoChange, arg_17_1)
end

function var_0_0.updateFrozenItem(arg_18_0, arg_18_1)
	ManufactureModel.instance:setFrozenItemDict(arg_18_1)
end

function var_0_0.jumpToManufactureBuildingLevelUpView(arg_19_0, arg_19_1)
	local var_19_0 = false

	if ManufactureModel.instance:isManufactureUnlock(true) then
		local var_19_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_19_1)

		if var_19_1 then
			if ManufactureConfig.instance:isManufactureBuilding(var_19_1.buildingId) then
				if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
					arg_19_0:closeCritterBuildingView(true)
				end

				if ViewMgr.instance:isOpen(ViewName.RoomTradeView) then
					ViewMgr.instance:closeView(ViewName.RoomTradeView, false)
				end

				ViewMgr.instance:closeAllPopupViews({
					ViewName.RoomTradeView
				})

				local var_19_2 = false
				local var_19_3, var_19_4 = ManufactureModel.instance:getCameraRecord()

				if var_19_3 or var_19_4 then
					var_19_2 = true
				end

				arg_19_0:openManufactureBuildingViewByBuilding(var_19_1, var_19_2, true)

				var_19_0 = true
			else
				logError(string.format("ManufactureController:jumpToManufactureBuildingLevelUpView error, not manufacture building, buildingUid:%s", arg_19_1))
			end
		else
			logError(string.format("ManufactureController:jumpToManufactureBuildingLevelUpView error, not find building, buildingUid:%s", arg_19_1))
		end
	end

	return var_19_0
end

function var_0_0.openManufactureBuildingViewByBuilding(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if not arg_20_1 then
		return
	end

	local var_20_0 = RoomConfig.instance:getBuildingType(arg_20_1.buildingId)

	arg_20_0:openManufactureBuildingViewByType(var_20_0, arg_20_1.uid, arg_20_2, arg_20_3, arg_20_4)
end

function var_0_0.openManufactureBuildingViewByType(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if arg_21_1 ~= RoomBuildingEnum.BuildingType.Collect and arg_21_1 ~= RoomBuildingEnum.BuildingType.Process and arg_21_1 ~= RoomBuildingEnum.BuildingType.Manufacture then
		return
	end

	local var_21_0 = RoomMapBuildingModel.instance:getBuildingListByType(arg_21_1)

	if not var_21_0 or #var_21_0 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceManufactureBuilding)

		return
	end

	local var_21_1
	local var_21_2 = false

	if arg_21_2 then
		var_21_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_21_2)

		if var_21_1 and var_21_1.config and var_21_1.config.buildingType == arg_21_1 then
			var_21_2 = true
		end
	end

	if not var_21_2 then
		var_21_1 = var_21_0[1]
		arg_21_2 = var_21_0[1].buildingUid
	end

	arg_21_0._tmpManuBuildingViewParam = {
		buildingType = arg_21_1,
		defaultBuildingUid = arg_21_2,
		addManuItem = arg_21_5
	}
	arg_21_0._tmpJumpLvUpBuildingUid = arg_21_4 and arg_21_2 or nil

	local var_21_3 = var_21_1.buildingId
	local var_21_4 = ManufactureConfig.instance:getBuildingCameraIdByIndex(var_21_3)
	local var_21_5 = RoomCameraController.instance:getRoomCamera()

	if var_21_5 and var_21_4 then
		if not arg_21_3 then
			local var_21_6 = var_21_5:getCameraState()
			local var_21_7 = var_21_5:getCameraParam()
			local var_21_8 = LuaUtil.deepCopy(var_21_7)

			ManufactureModel.instance:setCameraRecord(var_21_6, var_21_8)
		end

		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(arg_21_2, var_21_4)
		TaskDispatcher.cancelTask(arg_21_0._realOpenManufactureBuildingView, arg_21_0)
		TaskDispatcher.runDelay(arg_21_0._realOpenManufactureBuildingView, arg_21_0, var_0_1)
	else
		arg_21_0:_realOpenManufactureBuildingView()
	end

	arg_21_0:dispatchEvent(ManufactureEvent.OnEnterManufactureBuildingView)
	arg_21_0:dispatchEvent(ManufactureEvent.ManufactureBuildingViewChange, {
		inManufactureBuildingView = true
	})
end

function var_0_0.openRoomManufactureBuildingDetailView(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_22_1)

	if var_22_0 and (var_22_0:checkSameType(RoomBuildingEnum.BuildingType.Collect) or var_22_0:checkSameType(RoomBuildingEnum.BuildingType.Process) or var_22_0:checkSameType(RoomBuildingEnum.BuildingType.Manufacture)) then
		ViewMgr.instance:openView(ViewName.RoomManufactureBuildingDetailView, {
			buildingUid = arg_22_1,
			buildingMO = var_22_0,
			showIsRight = arg_22_2
		})

		return true
	end

	return false
end

function var_0_0._realOpenManufactureBuildingView(arg_23_0)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if not (arg_23_0._tmpManuBuildingViewParam and arg_23_0._tmpManuBuildingViewParam.buildingType) then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomManufactureBuildingView, arg_23_0._tmpManuBuildingViewParam)

	arg_23_0._tmpManuBuildingViewParam = nil

	arg_23_0:jump2ManufactureUpgradeView()
end

function var_0_0.jump2ManufactureUpgradeView(arg_24_0, arg_24_1)
	if not arg_24_0._tmpJumpLvUpBuildingUid and not arg_24_1 then
		return
	end

	arg_24_0:openManufactureBuildingLevelUpView(arg_24_1 or arg_24_0._tmpJumpLvUpBuildingUid)

	arg_24_0._tmpJumpLvUpBuildingUid = nil
end

function var_0_0.openManufactureBuildingLevelUpView(arg_25_0, arg_25_1)
	if ManufactureModel.instance:isMaxLevel(arg_25_1) then
		return
	end

	local var_25_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_25_1)

	if ManufactureConfig.instance:getBuildingUpgradeGroup(var_25_0.buildingId) == 0 then
		return
	end

	local var_25_1 = ManufactureModel.instance:getManufactureLevelUpParam(arg_25_1)

	ViewMgr.instance:openView(ViewName.RoomBuildingLevelUpView, var_25_1)
end

function var_0_0.openManufactureAccelerateView(arg_26_0, arg_26_1)
	local var_26_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_26_1)

	if (var_26_0 and var_26_0:getManufactureState()) ~= RoomManufactureEnum.ManufactureState.Running then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomManufactureAccelerateView, {
		buildingUid = arg_26_1
	})
end

function var_0_0.openRoomRecordView(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or RoomRecordEnum.View.Task

	if arg_27_1 == RoomRecordEnum.View.Task then
		RoomRpc.instance:sendGetTradeTaskInfoRequest(function()
			arg_27_0:_reallyOpenRoomRecordView(arg_27_1)
		end, arg_27_0)
	else
		arg_27_0:_reallyOpenRoomRecordView(arg_27_1)
	end
end

function var_0_0._reallyOpenRoomRecordView(arg_29_0, arg_29_1)
	ViewMgr.instance:openView(ViewName.RoomRecordView, arg_29_1)
end

function var_0_0.openCritterBuildingView(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not CritterModel.instance:isCritterUnlock(true) then
		return
	end

	local var_30_0 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if not var_30_0 or #var_30_0 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceCritterBuilding)

		return
	end

	local var_30_1

	if not arg_30_1 then
		var_30_1 = var_30_0[1]
		arg_30_1 = var_30_0[1].buildingUid
	else
		var_30_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_30_1)
	end

	if (var_30_1 and var_30_1.config.buildingType) ~= RoomBuildingEnum.BuildingType.Rest then
		return
	end

	local var_30_2 = var_30_1.buildingId
	local var_30_3 = ManufactureConfig.instance:getBuildingCameraIdByIndex(var_30_2, arg_30_2)
	local var_30_4 = RoomCameraController.instance:getRoomCamera()

	if var_30_4 and var_30_3 then
		local var_30_5 = var_30_4:getCameraState()
		local var_30_6 = var_30_4:getCameraParam()
		local var_30_7 = LuaUtil.deepCopy(var_30_6)

		ManufactureModel.instance:setCameraRecord(var_30_5, var_30_7)

		arg_30_0._tmpCritterBuildingUid = arg_30_1
		arg_30_0._tmpCritterDefaultTab = arg_30_2
		arg_30_0._tmpCritterUid = arg_30_3

		local var_30_8 = false

		if arg_30_2 == RoomCritterBuildingViewContainer.SubViewTabId.Training and arg_30_3 then
			local var_30_9 = CritterModel.instance:getCritterMOByUid(arg_30_3)

			var_30_8 = var_30_9 and var_30_9:isCultivating()
		end

		TaskDispatcher.cancelTask(arg_30_0._realOpenCritterBuildingView, arg_30_0)

		if var_30_8 then
			arg_30_0:_realOpenCritterBuildingView(arg_30_1, arg_30_2, arg_30_3)
		else
			RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(arg_30_1, var_30_3, arg_30_0._openCritterBuildingViewCameraTweenFinish, arg_30_0)
			TaskDispatcher.runDelay(arg_30_0._realOpenCritterBuildingView, arg_30_0, var_0_1)
		end
	else
		arg_30_0:_realOpenCritterBuildingView(arg_30_1, arg_30_2, arg_30_3)
	end

	CritterController.instance:dispatchEvent(CritterEvent.onEnterCritterBuildingView)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChange, {
		inCritterBuildingView = true
	})

	return true
end

function var_0_0._realOpenCritterBuildingView(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_1 = arg_31_1 or arg_31_0._tmpCritterBuildingUid
	arg_31_2 = arg_31_2 or arg_31_0._tmpCritterDefaultTab
	arg_31_3 = arg_31_3 or arg_31_0._tmpCritterUid

	if not arg_31_1 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomCritterBuildingView, {
		buildingUid = arg_31_1,
		defaultTab = arg_31_2,
		critterUid = arg_31_3
	})
	arg_31_0:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, 0, true)
end

function var_0_0.closeCritterBuildingView(arg_32_0, arg_32_1)
	if arg_32_1 then
		arg_32_0:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, RoomManufactureEnum.AudioDelayTime, false)
	end

	ViewMgr.instance:closeView(ViewName.RoomCritterBuildingView)
end

function var_0_0._openCritterBuildingViewCameraTweenFinish(arg_33_0)
	arg_33_0._tmpCritterBuildingUid = nil
	arg_33_0._tmpCritterDefaultTab = nil
	arg_33_0._tmpCritterUid = nil

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingCameraTweenFinish, arg_33_0._tmpCritterDefaultTab)
end

function var_0_0.openCritterPlaceView(arg_34_0, arg_34_1)
	ViewMgr.instance:openView(ViewName.RoomCritterPlaceView, {
		buildingUid = arg_34_1
	})
end

function var_0_0.openOverView(arg_35_0, arg_35_1)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	local var_35_0 = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	if not var_35_0 or #var_35_0 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceManufactureBuilding)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomOverView, {
		openFromRest = arg_35_1
	})

	return true
end

function var_0_0.openRoomTradeView(arg_36_0, arg_36_1, arg_36_2)
	if RoomTradeTaskModel.instance:getOpenOrderLevel() > ManufactureModel.instance:getTradeLevel() then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	local var_36_0 = ManufactureModel.instance:getTradeBuildingListInOrder()

	if not var_36_0 or #var_36_0 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoTradeBuilding)

		return
	end

	RoomRpc.instance:sendGetFrozenItemInfoRequest()

	arg_36_1 = arg_36_1 or var_36_0[1].buildingUid

	local var_36_1 = RoomCameraController.instance:getRoomCamera()

	local function var_36_2()
		arg_36_2 = arg_36_2 or 1

		ViewMgr.instance:openView(ViewName.RoomTradeView, {
			defaultTab = arg_36_2
		})
	end

	if var_36_1 and arg_36_1 then
		local var_36_3 = var_36_1:getCameraState()
		local var_36_4 = var_36_1:getCameraParam()
		local var_36_5 = LuaUtil.deepCopy(var_36_4)

		ManufactureModel.instance:setCameraRecord(var_36_3, var_36_5)
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(arg_36_1, RoomTradeEnum.CameraId, var_36_2)
	else
		var_36_2()
	end

	return true
end

function var_0_0.openRoomBackpackView(arg_38_0)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomBackpackView)

	return true
end

function var_0_0.jump2PlaceManufactureBuildingView(arg_39_0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		if ViewMgr.instance:isOpen(ViewName.RoomTradeView) then
			RoomTradeController.instance:dispatchEvent(RoomTradeEvent.PlayCloseTVAnim)
		end

		local var_39_0 = ViewMgr.instance:isOpen(ViewName.RoomBackpackView)
		local var_39_1 = ViewMgr.instance:isOpen(ViewName.RoomOverView)

		if var_39_0 or var_39_1 then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
		end

		ViewMgr.instance:closeView(ViewName.RoomManufactureMaterialTipView)
		ManufactureModel.instance:setIsJump2ManufactureBuildingList(true)
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
	end
end

function var_0_0.clickWrongBtn(arg_40_0, arg_40_1, arg_40_2)
	if ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView) and arg_40_0._lastWrongBuildingUid == arg_40_1 then
		arg_40_0:closeWrongTipView()
	else
		arg_40_0:clearSelectedSlotItem()
		arg_40_0:clearSelectCritterSlotItem()
		ViewMgr.instance:openView(ViewName.RoomManufactureWrongTipView, {
			buildingUid = arg_40_1,
			isRight = arg_40_2
		})

		arg_40_0._lastWrongBuildingUid = arg_40_1
	end
end

function var_0_0.clickWrongJump(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if not arg_41_1 then
		return
	end

	local var_41_0 = RoomManufactureEnum.WrongTypeHandlerFunc[arg_41_1]

	if not var_41_0 then
		return
	end

	if var_41_0(arg_41_0, arg_41_2, arg_41_3, arg_41_4) then
		arg_41_0:closeWrongTipView()
	end
end

function var_0_0._addPreMat(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0
	local var_42_1 = arg_42_3.isOverView
	local var_42_2 = arg_42_2 == RoomBuildingEnum.BuildingType.Collect
	local var_42_3 = RoomMapBuildingModel.instance:getBuildingListByType(arg_42_2, true)

	if var_42_3 and #var_42_3 > 0 then
		if var_42_2 then
			for iter_42_0, iter_42_1 in ipairs(var_42_3) do
				if arg_42_0:getNextEmptySlot(iter_42_1.id) then
					var_42_0 = iter_42_1

					break
				end
			end

			if not var_42_0 then
				var_42_0 = var_42_3[1]
			end
		else
			for iter_42_2, iter_42_3 in ipairs(var_42_3) do
				if ManufactureConfig.instance:isManufactureItemBelongBuilding(iter_42_3.buildingId, arg_42_1) then
					var_42_0 = iter_42_3

					break
				end
			end
		end
	end

	if not var_42_0 then
		return false
	end

	if var_42_1 then
		arg_42_0:dispatchEvent(ManufactureEvent.ManufactureOverViewFocusAddPop, var_42_0.id, arg_42_1)
	else
		arg_42_0:openManufactureBuildingViewByBuilding(var_42_0, true, false, arg_42_1)
	end

	return true
end

function var_0_0._lvUpBuilding(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0
	local var_43_1 = 0
	local var_43_2 = RoomMapBuildingModel.instance:getBuildingListByType(arg_43_2, true)

	if var_43_2 and #var_43_2 > 0 then
		for iter_43_0, iter_43_1 in ipairs(var_43_2) do
			local var_43_3 = iter_43_1.id

			if ManufactureConfig.instance:isManufactureItemBelongBuilding(iter_43_1.buildingId, arg_43_1) then
				local var_43_4 = ManufactureModel.instance:isMaxLevel(var_43_3)
				local var_43_5 = iter_43_1.level

				if not var_43_4 and var_43_1 < var_43_5 then
					var_43_0 = iter_43_1
					var_43_1 = var_43_5
				end
			end
		end
	end

	if not var_43_0 then
		return false
	end

	arg_43_0:jumpToManufactureBuildingLevelUpView(var_43_0.id)

	return true
end

function var_0_0._linPath(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen) then
		local var_44_0 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_44_2, arg_44_3.pathToType)
		local var_44_1 = var_44_0 and var_44_0:isLinkFinish()
		local var_44_2 = var_44_0 and var_44_0:hasCritterWorking()

		if var_44_1 and not var_44_2 then
			arg_44_0:closeWrongTipView()
			ViewMgr.instance:closeView(ViewName.RoomOverView, true)

			local var_44_3 = RoomTransportHelper.fromTo2SiteType(arg_44_2, arg_44_3.pathToType)

			RoomTransportController.instance:openTransportSiteView(var_44_3, RoomEnum.CameraState.Overlook)

			if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
				arg_44_0:closeCritterBuildingView(true)
			end

			if ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView) then
				ViewMgr.instance:closeView(ViewName.RoomManufactureBuildingView)
				ManufactureModel.instance:setCameraRecord()
			end
		else
			RoomJumpController.instance:jumpToTransportSiteView()
		end
	else
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)
	end
end

function var_0_0.closeWrongTipView(arg_45_0)
	ViewMgr.instance:closeView(ViewName.RoomManufactureWrongTipView)
end

function var_0_0.clickSlotItem(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6)
	if not arg_46_4 then
		local var_46_0 = RoomManufactureEnum.SlotState.Locked
		local var_46_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_46_1)

		if var_46_1 then
			var_46_0 = var_46_1:getSlotState(arg_46_2)
		end

		if var_46_0 == RoomManufactureEnum.SlotState.Locked then
			local var_46_2 = ManufactureConfig.instance:getBuildingUpgradeGroup(var_46_1.buildingId)
			local var_46_3 = ManufactureConfig.instance:getSlotUnlockNeedLevel(var_46_2, arg_46_5)

			GameFacade.showToast(ToastEnum.RoomSlotLocked, var_46_3)

			return
		end

		if var_46_0 == RoomManufactureEnum.SlotState.Complete then
			if arg_46_3 then
				arg_46_0:gainCompleteManufactureItem()
			else
				arg_46_0:gainCompleteManufactureItem(arg_46_1)
			end

			return
		end
	end

	local var_46_4 = ManufactureModel.instance:getSelectedSlot()

	if ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView) and var_46_4 == arg_46_1 then
		arg_46_0:clearSelectedSlotItem()
	else
		arg_46_0:refreshSelectedSlotId(arg_46_1, true)
		arg_46_0:clearSelectCritterSlotItem()
		arg_46_0:closeWrongTipView()
		ManufactureModel.instance:setReadNewManufactureFormula(arg_46_1)
		ViewMgr.instance:openView(ViewName.RoomManufactureAddPopView, {
			inRight = arg_46_3,
			highLightManufactureItem = arg_46_6
		})
		arg_46_0:dispatchEvent(ManufactureEvent.ManufactureReadNewFormula)
	end
end

function var_0_0.refreshSelectedSlotId(arg_47_0, arg_47_1, arg_47_2)
	if not arg_47_2 and not ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView) then
		arg_47_0:clearSelectedSlotItem()

		return
	end

	local var_47_0 = arg_47_0:getNextEmptySlot(arg_47_1)

	ManufactureModel.instance:setSelectedSlot(arg_47_1, var_47_0)
	arg_47_0:dispatchEvent(ManufactureEvent.ChangeSelectedSlotItem)
end

function var_0_0.clearSelectedSlotItem(arg_48_0)
	ViewMgr.instance:closeView(ViewName.RoomManufactureAddPopView)
	ManufactureModel.instance:setSelectedSlot()
	arg_48_0:dispatchEvent(ManufactureEvent.ChangeSelectedSlotItem)
end

function var_0_0.setManufactureFormulaItemList(arg_49_0, arg_49_1)
	if RoomTradeModel.instance:isGetOrderInfo() then
		ManufactureFormulaListModel.instance:setManufactureFormulaItemList(arg_49_1)
	else
		RoomRpc.instance:sendGetOrderInfoRequest(function()
			ManufactureFormulaListModel.instance:setManufactureFormulaItemList(arg_49_1)
		end, arg_49_0)
	end
end

function var_0_0.clickFormulaItem(arg_51_0, arg_51_1)
	local var_51_0, var_51_1 = ManufactureModel.instance:getSelectedSlot()

	if not var_51_0 or not var_51_1 then
		GameFacade.showToast(ToastEnum.RoomNotSelectedSlot)

		return
	end

	local var_51_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_51_0)
	local var_51_3 = var_51_2 and var_51_2:getSlotState(var_51_1)

	if not var_51_3 or var_51_3 ~= RoomManufactureEnum.SlotState.None then
		logError(string.format("ManufactureController:clickFormulaItem error, slot not empty, buildingUid:%s slotId:%s slotState:%s", var_51_0, var_51_1, var_51_3))

		return
	end

	local var_51_4 = {
		priority = -1,
		slotId = var_51_1,
		operation = RoomManufactureEnum.SlotOperation.Add,
		productionId = arg_51_1
	}

	arg_51_0:setManufactureItems(var_51_0, {
		var_51_4
	})
end

function var_0_0.clickRemoveSlotManufactureItem(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_52_1)
	local var_52_1 = var_52_0 and var_52_0:getSlotManufactureItemId(arg_52_2)

	if not var_52_1 or var_52_1 == 0 then
		return
	end

	local var_52_2 = {
		priority = -1,
		slotId = arg_52_2,
		operation = RoomManufactureEnum.SlotOperation.Cancel,
		productionId = var_52_1
	}
	local var_52_3 = var_52_0 and var_52_0:getSlotState(arg_52_2, true)

	if var_52_3 == RoomManufactureEnum.SlotState.Stop or var_52_3 == RoomManufactureEnum.SlotState.Running then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveHasProgressManufactureItem, MsgBoxEnum.BoxType.Yes_No, function()
			arg_52_0:setManufactureItems(arg_52_1, {
				var_52_2
			})
		end)
	else
		arg_52_0:setManufactureItems(arg_52_1, {
			var_52_2
		})
	end
end

function var_0_0.moveManufactureItem(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_54_1)
	local var_54_1 = var_54_0 and var_54_0:getSlotManufactureItemId(arg_54_2)

	if not var_54_1 or var_54_1 == 0 then
		return
	end

	local var_54_2 = var_54_0 and var_54_0:getSlotState(arg_54_2, true)
	local var_54_3 = var_54_2 == RoomManufactureEnum.SlotState.Running
	local var_54_4 = var_54_2 == RoomManufactureEnum.SlotState.Stop
	local var_54_5 = var_54_2 == RoomManufactureEnum.SlotState.Wait

	if var_54_3 or var_54_4 or var_54_5 then
		local var_54_6 = var_54_0:getSlotPriority(arg_54_2) == RoomManufactureEnum.FirstSlotPriority

		if var_54_6 and arg_54_3 or not var_54_6 and not arg_54_3 then
			local var_54_7 = {
				productionId = 0,
				priority = -1,
				slotId = arg_54_2,
				operation = arg_54_3 and RoomManufactureEnum.SlotOperation.MoveBottom or RoomManufactureEnum.SlotOperation.MoveTop
			}

			arg_54_0:setManufactureItems(arg_54_1, {
				var_54_7
			})
		end
	end
end

function var_0_0.getFormatTime(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = ""
	local var_55_1 = arg_55_2 and TimeUtil.DateEnFormat.Day or luaLang("time_day")
	local var_55_2 = arg_55_2 and TimeUtil.DateEnFormat.Hour or luaLang("time_hour2")
	local var_55_3 = arg_55_2 and TimeUtil.DateEnFormat.Minute or luaLang("time_minute2")
	local var_55_4, var_55_5, var_55_6, var_55_7 = TimeUtil.secondsToDDHHMMSS(arg_55_1)

	if var_55_4 > 0 then
		var_55_0 = string.format("%s%s%s%s", var_55_4, var_55_1, var_55_5, var_55_2)
	elseif var_55_5 > 0 then
		if var_55_6 > 0 then
			var_55_0 = string.format("%s%s%s%s", var_55_5, var_55_2, var_55_6, var_55_3)
		else
			var_55_0 = string.format("%s%s", var_55_5, var_55_2)
		end
	else
		if var_55_6 <= 0 then
			var_55_6 = "<1"
		end

		var_55_0 = string.format("%s%s", var_55_6, var_55_3)
	end

	return var_55_0
end

function var_0_0.getNextEmptySlot(arg_56_0, arg_56_1)
	local var_56_0
	local var_56_1 = ManufactureModel.instance:getManufactureMOById(arg_56_1)

	if var_56_1 then
		var_56_0 = var_56_1:getNextEmptySlot()
	end

	return var_56_0
end

function var_0_0.checkPlaceProduceBuilding(arg_57_0, arg_57_1)
	local var_57_0 = false
	local var_57_1 = ManufactureConfig.instance:getManufactureItemBelongBuildingType(arg_57_1)
	local var_57_2 = RoomMapBuildingModel.instance:getBuildingListByType(var_57_1)

	if var_57_2 and #var_57_2 > 0 then
		for iter_57_0, iter_57_1 in ipairs(var_57_2) do
			if ManufactureConfig.instance:isManufactureItemBelongBuilding(iter_57_1.buildingId, arg_57_1) then
				var_57_0 = true

				break
			end
		end
	end

	return var_57_0
end

function var_0_0.checkProduceBuildingLevel(arg_58_0, arg_58_1)
	local var_58_0
	local var_58_1 = true
	local var_58_2 = 0
	local var_58_3 = ManufactureConfig.instance:getManufactureItemBelongBuildingType(arg_58_1)
	local var_58_4 = RoomMapBuildingModel.instance:getBuildingListByType(var_58_3)

	if var_58_4 and #var_58_4 > 0 then
		for iter_58_0, iter_58_1 in ipairs(var_58_4) do
			local var_58_5 = iter_58_1.buildingId

			if ManufactureConfig.instance:isManufactureItemBelongBuilding(var_58_5, arg_58_1) then
				var_58_0 = iter_58_1.id

				local var_58_6 = iter_58_1:getLevel()

				var_58_2 = ManufactureConfig.instance:getManufactureItemNeedLevel(var_58_5, arg_58_1)

				if var_58_2 <= var_58_6 then
					var_58_1 = false

					break
				end
			end
		end
	end

	return var_58_1, var_58_0, var_58_2
end

function var_0_0.oneKeySelectCustomManufactureItem(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	local var_59_0, var_59_1 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not arg_59_3 and var_59_0 == arg_59_1 and arg_59_2 == var_59_1 then
		return
	end

	OneKeyAddPopListModel.instance:setSelectedManufactureItem(arg_59_1, arg_59_2)
	arg_59_0:dispatchEvent(ManufactureEvent.OneKeySelectCustomManufactureItem)
end

function var_0_0.clickCritterSlotItem(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = false
	local var_60_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_60_1)

	if var_60_1 and var_60_1:getCanPlaceCritterCount() >= arg_60_2 + 1 then
		var_60_0 = true
	end

	if not var_60_0 then
		return
	end

	local var_60_2 = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)
	local var_60_3 = ManufactureModel.instance:getSelectedCritterSlot()

	if var_60_2 and var_60_3 == arg_60_1 then
		arg_60_0:clearSelectCritterSlotItem()
	else
		arg_60_0:clearSelectedSlotItem()
		arg_60_0:closeWrongTipView()
		arg_60_0:refreshSelectedCritterSlotId(arg_60_1, true)
		ViewMgr.instance:openView(ViewName.RoomCritterListView, {
			buildingUid = arg_60_1
		})
	end
end

function var_0_0.refreshSelectedCritterSlotId(arg_61_0, arg_61_1, arg_61_2)
	if not arg_61_2 and not ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		arg_61_0:clearSelectCritterSlotItem()

		return
	end

	local var_61_0 = arg_61_0:getNextEmptyCritterSlot(arg_61_1)

	ManufactureModel.instance:setSelectedCritterSlot(arg_61_1, var_61_0)
	arg_61_0:dispatchEvent(ManufactureEvent.ChangeSelectedCritterSlotItem)
end

function var_0_0.getNextEmptyCritterSlot(arg_62_0, arg_62_1)
	local var_62_0
	local var_62_1 = ManufactureModel.instance:getManufactureMOById(arg_62_1)

	if var_62_1 then
		var_62_0 = var_62_1:getNextEmptyCritterSlot()
	end

	return var_62_0
end

function var_0_0.clearSelectCritterSlotItem(arg_63_0)
	ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	ManufactureModel.instance:setSelectedCritterSlot()
	arg_63_0:dispatchEvent(ManufactureEvent.ChangeSelectedCritterSlotItem)
end

function var_0_0.clickCritterItem(arg_64_0, arg_64_1)
	local var_64_0, var_64_1 = ManufactureModel.instance:getSelectedCritterSlot()

	if not var_64_0 then
		logError(string.format("ManufactureController:clickCritterItem error, not select building"))

		return
	end

	local var_64_2 = ManufactureModel.instance:getCritterWorkingBuilding(arg_64_1)

	if var_64_2 == var_64_0 then
		local var_64_3 = RoomMapBuildingModel.instance:getBuildingMOById(var_64_2)
		local var_64_4 = var_64_3 and var_64_3:getCritterWorkSlot(arg_64_1)

		arg_64_0:allocateCritter(var_64_2, CritterEnum.InvalidCritterUid, var_64_4)
	else
		local var_64_5 = false
		local var_64_6 = false
		local var_64_7 = RoomMapBuildingModel.instance:getBuildingMOById(var_64_0)

		if not var_64_7 then
			logError(string.format("ManufactureController:clickCritterItem error, can not find buildingUId:%s", var_64_0))

			return
		end

		local var_64_8 = var_64_7:getCanPlaceCritterCount()

		if var_64_8 == 1 then
			var_64_1 = 0
			var_64_6 = true
		end

		if not var_64_1 then
			GameFacade.showToast(ToastEnum.RoomNotSelectedCritterSlot)

			return
		end

		if var_64_8 >= var_64_1 + 1 then
			var_64_5 = true
		end

		if not var_64_5 then
			logError(string.format("ManufactureController:clickCritterItem error, critter slot not unlock, buildingUid:%s critterSlotId:%s", var_64_0, var_64_1))

			return
		end

		local var_64_9 = var_64_7:getWorkingCritter(var_64_1)

		if var_64_9 and not var_64_6 then
			logError(string.format("ManufactureController:clickCritterItem error, slot has critter, buildingUid:%s critterSlotId:%s", var_64_0, var_64_1))

			return
		end

		local var_64_10 = 0
		local var_64_11 = CritterModel.instance:getCritterMOByUid(arg_64_1)

		if var_64_11 then
			var_64_10 = var_64_11:getMoodValue()
		end

		if var_64_10 <= 0 then
			GameFacade.showToast(ToastEnum.RoomCritterNoMoodWork)

			return
		end

		if var_64_9 and var_64_6 then
			arg_64_0:allocateCritter(var_64_0, CritterEnum.InvalidCritterUid, var_64_1)
		end

		arg_64_0:allocateCritter(var_64_0, arg_64_1, var_64_1)
	end
end

function var_0_0.clickTransportCritterSlotItem(arg_65_0, arg_65_1)
	local var_65_0 = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)
	local var_65_1 = ManufactureModel.instance:getSelectedTransportPath()

	if var_65_0 and var_65_1 == arg_65_1 then
		arg_65_0:clearSelectTransportPath()
	else
		ManufactureModel.instance:setSelectedTransportPath(arg_65_1)
		ViewMgr.instance:openView(ViewName.RoomCritterListView, {
			pathId = arg_65_1
		})
		arg_65_0:dispatchEvent(ManufactureEvent.ChangeSelectedTransportPath)
	end
end

function var_0_0.clearSelectTransportPath(arg_66_0)
	ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	ManufactureModel.instance:setSelectedTransportPath()
	arg_66_0:dispatchEvent(ManufactureEvent.ChangeSelectedTransportPath)
end

function var_0_0.clickTransportCritterItem(arg_67_0, arg_67_1)
	local var_67_0 = ManufactureModel.instance:getSelectedTransportPath()

	if not var_67_0 then
		logError(string.format("ManufactureController:clickTransportCritterItem error, not select transport path"))

		return
	end

	local var_67_1
	local var_67_2 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(arg_67_1)

	if (var_67_2 and var_67_2.id) == var_67_0 then
		var_67_1 = CritterEnum.InvalidCritterUid
	else
		local var_67_3 = RoomMapTransportPathModel.instance:getTransportPathMO(var_67_0)
		local var_67_4 = var_67_3 and var_67_3.critterUid

		if not var_67_3 or var_67_4 and var_67_4 ~= CritterEnum.InvalidCritterUid and var_67_4 ~= tonumber(CritterEnum.InvalidCritterUid) then
			GameFacade.showToast(ToastEnum.RoomNotSelectedCritterSlot)

			return
		end

		local var_67_5 = 0
		local var_67_6 = CritterModel.instance:getCritterMOByUid(arg_67_1)

		if var_67_6 then
			var_67_5 = var_67_6:getMoodValue()
		end

		if var_67_5 <= 0 then
			GameFacade.showToast(ToastEnum.RoomCritterNoMoodWork)

			return
		end

		var_67_1 = arg_67_1
	end

	if var_67_0 and var_67_1 then
		RoomRpc.instance:sendAllotCritterRequestt(var_67_0, var_67_1)
	end
end

function var_0_0.checkTradeLevelCondition(arg_68_0, arg_68_1)
	local var_68_0 = false
	local var_68_1
	local var_68_2
	local var_68_3
	local var_68_4 = RoomMapBuildingModel.instance:getBuildingMOById(arg_68_1)
	local var_68_5 = ManufactureConfig.instance:getBuildingUpgradeGroup(var_68_4 and var_68_4.buildingId)

	if var_68_5 ~= 0 then
		local var_68_6 = ManufactureModel.instance:getTradeLevel()

		var_68_3 = ManufactureConfig.instance:getNeedTradeLevel(var_68_5, var_68_4.level + 1)

		if var_68_3 then
			var_68_0 = var_68_3 <= var_68_6
		end
	end

	if not var_68_0 then
		var_68_1 = ToastEnum.RoomUpgradeFailByTradeLevel

		local var_68_7 = luaLang("room_manufacutre_building_level_up_need_trade_level")
		local var_68_8 = ManufactureConfig.instance:getTradeLevelCfg(var_68_3)

		var_68_2 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_68_7, var_68_8.dimension, var_68_8.job)
	end

	return var_68_0, var_68_1, var_68_2
end

function var_0_0.oneKeyManufactureItem(arg_69_0, arg_69_1)
	if not arg_69_0:checkCanFill(arg_69_1) then
		return
	end

	local var_69_0
	local var_69_1
	local var_69_2
	local var_69_3

	if arg_69_1 == RoomManufactureEnum.OneKeyType.Customize then
		OneKeyAddPopListModel.instance:recordSelectManufactureItem()

		local var_69_4, var_69_5 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		var_69_0 = ManufactureConfig.instance:getManufactureItemBelongBuildingType(var_69_4)

		if var_69_0 ~= RoomBuildingEnum.BuildingType.Collect then
			local var_69_6 = ManufactureConfig.instance:getManufactureItemBelongBuildingList(var_69_4)

			var_69_1 = var_69_6 and var_69_6[1]
		end

		var_69_2 = ManufactureConfig.instance:getItemId(var_69_4)

		local var_69_7, var_69_8 = ManufactureConfig.instance:getManufactureItemUnitCountRange(var_69_4)

		var_69_3 = var_69_8 * var_69_5
	end

	ManufactureModel.instance:setRecordOneKeyType(arg_69_1)
	RoomStatController.instance:oneKeyDispatch(false, arg_69_1)
	RoomRpc.instance:sendBatchAddProctionsRequest(arg_69_1, var_69_0, var_69_1, var_69_2, var_69_3)
	ViewMgr.instance:closeView(ViewName.RoomOneKeyView)
end

function var_0_0.checkCanFill(arg_70_0, arg_70_1)
	local var_70_0 = true

	if arg_70_1 == RoomManufactureEnum.OneKeyType.TracedOrder then
		local var_70_1 = false
		local var_70_2 = RoomTradeModel.instance:getDailyOrders()

		for iter_70_0, iter_70_1 in ipairs(var_70_2) do
			if iter_70_1.isTraced then
				var_70_1 = true

				break
			end
		end

		if not var_70_1 then
			GameFacade.showToast(ToastEnum.RoomTraceOrderIsEnough)

			var_70_0 = false
		end
	elseif arg_70_1 == RoomManufactureEnum.OneKeyType.Customize then
		local var_70_3 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		if var_70_3 then
			local var_70_4, var_70_5 = ManufactureModel.instance:getMaxCanProductCount(var_70_3)

			if var_70_5 then
				GameFacade.showToast(ToastEnum.RoomNoEmptyManufactureSlot)

				var_70_0 = false
			end
		else
			GameFacade.showToast(ToastEnum.RoomNotSelectedManufactureItem)

			var_70_0 = false
		end
	end

	return var_70_0
end

function var_0_0.oneKeyCritter(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_1 and CritterEnum.OneKeyType.Transport or CritterEnum.OneKeyType.Manufacture

	RoomStatController.instance:oneKeyDispatch(true, var_71_0)
	RoomRpc.instance:sendBatchDispatchCrittersRequest(var_71_0)
end

function var_0_0.openRouseCritterView(arg_72_0, arg_72_1)
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in ipairs(arg_72_1.infos) do
		local var_72_1 = {
			buildingUid = iter_72_1.buildingUid,
			roadId = iter_72_1.roadId,
			critterUids = {}
		}

		for iter_72_2, iter_72_3 in ipairs(iter_72_1.critterUids) do
			table.insert(var_72_1.critterUids, iter_72_3)
		end

		table.insert(var_72_0, var_72_1)
	end

	if #var_72_0 <= 0 then
		GameFacade.showToast(ToastEnum.NoCritterCanWork)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomCritterOneKeyView, {
		type = arg_72_1.type,
		infoList = var_72_0
	})
end

function var_0_0.sendRouseCritter(arg_73_0, arg_73_1, arg_73_2)
	RoomRpc.instance:sendRouseCrittersRequest(arg_73_1, arg_73_2)
end

function var_0_0.removeRestingCritterList(arg_74_0, arg_74_1)
	if not arg_74_1 then
		return
	end

	local var_74_0 = false

	for iter_74_0, iter_74_1 in ipairs(arg_74_1) do
		local var_74_1 = ManufactureModel.instance:getCritterRestingBuilding(iter_74_1)
		local var_74_2 = ManufactureModel.instance:getCritterBuildingMOById(var_74_1)

		if var_74_2 then
			var_74_2:removeRestingCritter(iter_74_1)

			var_74_0 = true
		end
	end

	if var_74_0 then
		RoomCritterModel.instance:initStayBuildingCritters()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
	end
end

function var_0_0.removeRestingCritter(arg_75_0, arg_75_1)
	local var_75_0 = false
	local var_75_1 = ManufactureModel.instance:getCritterRestingBuilding(arg_75_1)
	local var_75_2 = ManufactureModel.instance:getCritterBuildingMOById(var_75_1)

	if var_75_2 then
		var_75_2:removeRestingCritter(arg_75_1)

		var_75_0 = true
	end

	if var_75_0 then
		RoomCritterModel.instance:initStayBuildingCritters()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
	end
end

function var_0_0.resetCameraOnCloseView(arg_76_0)
	local var_76_0 = RoomCameraController.instance:getRoomScene()
	local var_76_1, var_76_2 = ManufactureModel.instance:getCameraRecord()

	if var_76_0 and var_76_1 and var_76_2 then
		var_76_0.camera:switchCameraState(var_76_1, var_76_2)
	end

	ManufactureModel.instance:setCameraRecord()
end

function var_0_0.getPlayAddEffDict(arg_77_0, arg_77_1)
	if not arg_77_1 then
		return
	end

	local var_77_0 = {}

	for iter_77_0, iter_77_1 in ipairs(arg_77_1) do
		local var_77_1 = iter_77_1.buildingUid
		local var_77_2 = ManufactureModel.instance:getManufactureMOById(var_77_1)

		if var_77_2 then
			for iter_77_2, iter_77_3 in ipairs(iter_77_1.slotInfos) do
				local var_77_3 = iter_77_3.slotId
				local var_77_4 = var_77_2:getSlotMO(var_77_3)
				local var_77_5 = var_77_4 and var_77_4:getSlotManufactureItemId()

				if (not var_77_5 or var_77_5 == 0) and iter_77_3.productionId and iter_77_3.productionId ~= 0 then
					var_77_0[var_77_1] = var_77_0[var_77_1] or {}
					var_77_0[var_77_1][var_77_3] = true
				end
			end
		end
	end

	return var_77_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
