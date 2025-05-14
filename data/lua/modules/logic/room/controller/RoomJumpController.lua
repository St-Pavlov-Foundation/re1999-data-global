module("modules.logic.room.controller.RoomJumpController", package.seeall)

local var_0_0 = class("RoomJumpController", BaseController)

function var_0_0.jumpFormTaskView(arg_1_0, arg_1_1)
	if string.nilorempty(arg_1_1) then
		return
	end

	local var_1_0 = false
	local var_1_1 = string.splitToNumber(arg_1_1, "#")

	if var_1_1[1] == JumpEnum.JumpView.RoomView then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
			return
		end

		local var_1_2 = arg_1_0["jumpTo" .. var_1_1[2]]

		if var_1_2 then
			var_1_0 = var_1_2(arg_1_0, var_1_1)
		end
	end

	if var_1_0 and ViewMgr.instance:isOpen(ViewName.RoomRecordView) then
		ViewMgr.instance:closeView(ViewName.RoomRecordView, false)
	end
end

function var_0_0.jumpTo1(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[3] or 1

	if var_2_0 == 1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RoomRecordView) then
		local var_2_1 = var_2_0 == 2 and RoomRecordEnum.AnimName.Task2Log or RoomRecordEnum.AnimName.Task2HandBook

		RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
			animName = var_2_1,
			view = var_2_0
		})
	else
		ManufactureController.instance:openRoomRecordView(var_2_0)
	end
end

function var_0_0.jumpTo2(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[3] or 1
	local var_3_1 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if not var_3_1 or #var_3_1 <= 0 then
		arg_3_0:showRoomNotBuildingMessageBox()

		return
	end

	if var_3_0 == 3 then
		if not GuideModel.instance:isGuideFinish(RoomTradeEnum.GuideUnlock.Summon) then
			GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

			return
		end
	elseif var_3_0 == 4 and ManufactureModel.instance:getTradeLevel() < RoomTradeTaskModel.instance:getOpenCritterIncubateLevel() then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	return ManufactureController.instance:openCritterBuildingView(nil, var_3_0)
end

function var_0_0.jumpTo3(arg_4_0, arg_4_1)
	return ManufactureController.instance:openOverView()
end

function var_0_0.jumpTo4(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[3] or 1

	return ManufactureController.instance:openRoomTradeView(nil, var_5_0)
end

function var_0_0.jumpTo5(arg_6_0, arg_6_1)
	return ManufactureController.instance:openRoomBackpackView()
end

function var_0_0.jumpTo6(arg_7_0, arg_7_1)
	return arg_7_0:jumpToPlaceBuilding()
end

function var_0_0.jumpTo7(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1[3]

	return arg_8_0:jumpToManufactureBuilding(var_8_0)
end

function var_0_0.jumpTo8(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[3]

	return arg_9_0:jumpToManufactureBuildingLevelUp(var_9_0)
end

function var_0_0.jumpTo9(arg_10_0, arg_10_1)
	JumpController.instance:jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function var_0_0.jumpTo10(arg_11_0, arg_11_1)
	if not (ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)) then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	local var_11_0 = arg_11_1[3]

	if not RoomTransportController.instance:_findLinkPathSiteType(var_11_0) then
		arg_11_0:showRoomNotTransportRoadMessageBox()

		return false
	end

	RoomTransportController.instance:openTransportSiteView(var_11_0)

	return true
end

function var_0_0.jumpTo11(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[3]

	return arg_12_0:jumpToManufactureBuilding(nil, var_12_0)
end

function var_0_0.jumpTo12(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1[3]

	return arg_13_0:jumpToManufactureBuildingLevelUp(nil, var_13_0)
end

function var_0_0.jumpTo13(arg_14_0, arg_14_1)
	if not (ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)) then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	return arg_14_0:jumpToTransportSiteView()
end

function var_0_0.jumpToPlaceBuilding(arg_15_0)
	ManufactureController.instance:jump2PlaceManufactureBuildingView()

	return true
end

function var_0_0.jumpToTransportSiteView(arg_16_0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		if RoomMapBuildingAreaModel.instance:getCount() < 2 then
			GameFacade.showToast(ToastEnum.RoomTranspathUnableEdite)

			return false
		end

		if ViewMgr.instance:isOpen(ViewName.RoomTradeView) then
			RoomTradeController.instance:dispatchEvent(RoomTradeEvent.PlayCloseTVAnim)
		end

		local var_16_0 = ViewMgr.instance:isOpen(ViewName.RoomBackpackView)
		local var_16_1 = ViewMgr.instance:isOpen(ViewName.RoomOverView)

		if var_16_0 or var_16_1 then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
		end

		ViewMgr.instance:closeView(ViewName.RoomManufactureMaterialTipView)
		RoomTransportPathModel.instance:setIsJumpTransportSite(true)
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
	end

	return true
end

function var_0_0.jumpToManufactureBuilding(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 then
		local var_17_0 = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(arg_17_2)

		if var_17_0 then
			ManufactureController.instance:openManufactureBuildingViewByBuilding(var_17_0)
		else
			arg_17_0:showRoomNotBuildingMessageBox()

			return false
		end
	else
		local var_17_1, var_17_2 = arg_17_0:isHasBuilding(arg_17_1)

		if not var_17_1 then
			arg_17_0:showRoomNotBuildingMessageBox()

			return false
		end

		ManufactureController.instance:openManufactureBuildingViewByType(var_17_2)
	end

	return true
end

function var_0_0.jumpToManufactureBuildingLevelUp(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 then
		local var_18_0 = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(arg_18_2)

		if var_18_0 then
			ManufactureController.instance:jumpToManufactureBuildingLevelUpView(var_18_0.buildingUid)
		else
			arg_18_0:showRoomNotBuildingMessageBox()

			return false
		end
	else
		local var_18_1, var_18_2 = arg_18_0:isHasBuilding(arg_18_1)

		if not var_18_1 then
			arg_18_0:showRoomNotBuildingMessageBox()

			return false
		end

		local var_18_3 = RoomMapBuildingModel.instance:getBuildingListByType(var_18_2)

		if var_18_3 and #var_18_3 > 0 then
			local var_18_4 = var_18_3[1].buildingUid

			ManufactureController.instance:jumpToManufactureBuildingLevelUpView(var_18_4)
		end
	end

	return true
end

function var_0_0.isHasBuilding(arg_19_0, arg_19_1)
	if arg_19_1 and arg_19_1 > 0 then
		local var_19_0 = RoomMapBuildingModel.instance:getBuildingListByType(arg_19_1)

		return var_19_0 and #var_19_0 > 0, arg_19_1
	end

	for iter_19_0, iter_19_1 in pairs(RoomJumpEnum.ManufactureBuildingType) do
		local var_19_1 = RoomMapBuildingModel.instance:getBuildingListByType(iter_19_1)

		if var_19_1 and #var_19_1 > 0 then
			return true, iter_19_1
		end
	end
end

function var_0_0.showRoomNotBuildingMessageBox(arg_20_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomNotBuilding, MsgBoxEnum.BoxType.Yes_No, arg_20_0.jumpToPlaceBuilding)
end

function var_0_0.showRoomNotTransportRoadMessageBox(arg_21_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomNotTransportRoad, MsgBoxEnum.BoxType.Yes_No, arg_21_0.jumpToTransportSiteView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
