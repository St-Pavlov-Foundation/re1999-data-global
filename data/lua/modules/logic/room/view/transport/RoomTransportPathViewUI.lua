module("modules.logic.room.view.transport.RoomTransportPathViewUI", package.seeall)

local var_0_0 = class("RoomTransportPathViewUI", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gomapui = gohelper.findChild(arg_4_0.viewGO, "go_mapui")
	arg_4_0._gomapuiitem = gohelper.findChild(arg_4_0.viewGO, "go_mapui/go_mapuiitem")
	arg_4_0._gomapuiTrs = arg_4_0._gomapui.transform
	arg_4_0._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#91D7F1",
		[RoomBuildingEnum.BuildingType.Process] = "#E2D487",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#99EAC8"
	}
	arg_4_0._uiitemTBList = {
		arg_4_0:_createTB(arg_4_0._gomapuiitem)
	}

	gohelper.setActive(arg_4_0._gomapuiitem, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_6_0._cameraTransformUpdate, arg_6_0)

	if arg_6_0.viewContainer then
		arg_6_0:addEventCb(arg_6_0.viewContainer, RoomEvent.TransportPathSelectLineItem, arg_6_0.startWaitRunDelayTask, arg_6_0)
	end

	arg_6_0:startWaitRunDelayTask()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(arg_7_0.__onWaitRunDelayTask_, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0._cameraTransformUpdate(arg_9_0)
	arg_9_0:_refreshItemUIPos()
end

function var_0_0.startWaitRunDelayTask(arg_10_0)
	if not arg_10_0.__hasWaitRunDelayTask_ then
		arg_10_0.__hasWaitRunDelayTask_ = true

		TaskDispatcher.runDelay(arg_10_0.__onWaitRunDelayTask_, arg_10_0, 0.001)
	end
end

function var_0_0.__onWaitRunDelayTask_(arg_11_0)
	arg_11_0.__hasWaitRunDelayTask_ = false

	arg_11_0:_refreshItemList()
	arg_11_0:_refreshItemUIPos()
end

function var_0_0._createTB(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = arg_12_1
	var_12_0.goTrs = arg_12_1.transform
	var_12_0._imageicon = gohelper.findChildImage(arg_12_1, "image_icon")

	return var_12_0
end

function var_0_0._refreshTB(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1.buildingId ~= arg_13_2 then
		local var_13_0 = RoomConfig.instance:getBuildingConfig(arg_13_2)
		local var_13_1 = ManufactureConfig.instance:getManufactureBuildingIcon(arg_13_2)

		UISpriteSetMgr.instance:setRoomSprite(arg_13_1._imageicon, var_13_1)

		local var_13_2 = var_13_0 and arg_13_0._buildingTypeIconColor[var_13_0.buildingType] or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(arg_13_1._imageicon, var_13_2)
	end

	if arg_13_1.hexPoint == nil or arg_13_1.hexPoint ~= arg_13_3 then
		arg_13_1.hexPoint = arg_13_3

		local var_13_3, var_13_4 = HexMath.hexXYToPosXY(arg_13_3.x, arg_13_3.y, RoomBlockEnum.BlockSize)

		arg_13_1.worldPos = Vector3(var_13_3, 0, var_13_4)
	end
end

function var_0_0._getBuildingMOList(arg_14_0)
	local var_14_0 = RoomMapTransportPathModel.instance:getSelectBuildingType()

	if not var_14_0 then
		return nil
	end

	local var_14_1, var_14_2 = RoomTransportHelper.getSiteFromToByType(var_14_0)

	if var_14_1 == nil and var_14_2 == nil then
		return nil
	end

	local var_14_3 = {}
	local var_14_4 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_14_0, iter_14_1 in ipairs(var_14_4) do
		if iter_14_1:checkSameType(var_14_1) or iter_14_1:checkSameType(var_14_2) then
			table.insert(var_14_3, iter_14_1)
		end
	end

	return var_14_3
end

function var_0_0._refreshItemList(arg_15_0)
	local var_15_0 = arg_15_0:_getBuildingMOList()
	local var_15_1 = 0

	if var_15_0 and #var_15_0 > 0 then
		local var_15_2 = RoomMapHexPointModel.instance
		local var_15_3 = RoomMapModel.instance

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_4 = iter_15_1.hexPoint
			local var_15_5 = var_15_3:getBuildingPointList(iter_15_1.buildingId, iter_15_1.rotate)

			for iter_15_2, iter_15_3 in ipairs(var_15_5) do
				var_15_1 = var_15_1 + 1

				local var_15_6 = arg_15_0._uiitemTBList[var_15_1]

				if not var_15_6 then
					var_15_6 = arg_15_0:_createTB(gohelper.cloneInPlace(arg_15_0._gomapuiitem))
					arg_15_0._uiitemTBList[var_15_1] = var_15_6
				end

				local var_15_7 = var_15_2:getHexPoint(iter_15_3.x + var_15_4.x, iter_15_3.y + var_15_4.y)

				arg_15_0:_refreshTB(var_15_6, iter_15_1.buildingId, var_15_7)
			end
		end
	end

	for iter_15_4 = 1, #arg_15_0._uiitemTBList do
		local var_15_8 = arg_15_0._uiitemTBList[iter_15_4]
		local var_15_9 = iter_15_4 <= var_15_1

		if var_15_8.isActive ~= var_15_9 then
			var_15_8.isActive = var_15_9

			gohelper.setActive(var_15_8.go, var_15_9)
		end
	end
end

function var_0_0._refreshItemUIPos(arg_16_0)
	for iter_16_0 = 1, #arg_16_0._uiitemTBList do
		local var_16_0 = arg_16_0._uiitemTBList[iter_16_0]

		if var_16_0.isActive then
			arg_16_0:_setUIPos(var_16_0.worldPos, var_16_0.goTrs, arg_16_0._gomapuiTrs, 0.12)
		end
	end
end

function var_0_0._setUIPos(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = RoomBendingHelper.worldToBendingSimple(arg_17_1)
	local var_17_1 = var_17_0.x
	local var_17_2 = var_17_0.z

	arg_17_4 = arg_17_4 or 0.12

	local var_17_3 = Vector3(var_17_1, var_17_0.y + arg_17_4, var_17_2)
	local var_17_4 = recthelper.worldPosToAnchorPos(var_17_3, arg_17_3)

	recthelper.setAnchor(arg_17_2, var_17_4.x, var_17_4.y)
end

return var_0_0
