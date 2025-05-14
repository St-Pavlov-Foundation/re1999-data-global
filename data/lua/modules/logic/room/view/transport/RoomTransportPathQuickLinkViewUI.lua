module("modules.logic.room.view.transport.RoomTransportPathQuickLinkViewUI", package.seeall)

local var_0_0 = class("RoomTransportPathQuickLinkViewUI", BaseView)

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
	arg_4_0._gomapuiitem = gohelper.findChild(arg_4_0.viewGO, "go_mapui/go_quickuiitem")
	arg_4_0._gomapuiTrs = arg_4_0._gomapui.transform
	arg_4_0._uiitemTBList = {
		arg_4_0:_createTB(arg_4_0._gomapuiitem)
	}

	gohelper.setActive(arg_4_0._gomapuiitem, false)

	arg_4_0._isLinkFinsh = true
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._quickLinkMO = RoomTransportQuickLinkMO.New()

	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_6_0._cameraTransformUpdate, arg_6_0)

	if arg_6_0.viewContainer then
		arg_6_0:addEventCb(arg_6_0.viewContainer, RoomEvent.TransportPathSelectLineItem, arg_6_0._onSelectLineItem, arg_6_0)
	end

	arg_6_0._quickLinkMO:init()
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

function var_0_0._onSelectLineItem(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		return
	end

	local var_10_0 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_10_1.fromType, arg_10_1.toType)

	if var_10_0 and var_10_0:isLinkFinish() then
		arg_10_0._isLinkFinsh = true
	else
		arg_10_0._isLinkFinsh = false

		arg_10_0._quickLinkMO:findPath(arg_10_1.fromType, arg_10_1.toType, true)
	end

	arg_10_0:startWaitRunDelayTask()
end

function var_0_0.startWaitRunDelayTask(arg_11_0)
	if not arg_11_0.__hasWaitRunDelayTask_ then
		arg_11_0.__hasWaitRunDelayTask_ = true

		TaskDispatcher.runDelay(arg_11_0.__onWaitRunDelayTask_, arg_11_0, 0.001)
	end
end

function var_0_0.__onWaitRunDelayTask_(arg_12_0)
	arg_12_0.__hasWaitRunDelayTask_ = false

	arg_12_0:_refreshItemList()
	arg_12_0:_refreshItemUIPos()
end

function var_0_0._createTB(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = arg_13_1
	var_13_0.goTrs = arg_13_1.transform
	var_13_0._txtquick = gohelper.findChildText(arg_13_1, "txt_quick")

	return var_13_0
end

function var_0_0._refreshTB(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1.searchIndex ~= arg_14_2.searchIndex then
		arg_14_1.searchIndex = arg_14_2.searchIndex
		arg_14_1._txtquick.text = arg_14_2.searchIndex
	end

	if arg_14_1.hexPoint == nil or arg_14_1.hexPoint ~= arg_14_3 then
		arg_14_1.hexPoint = arg_14_3

		local var_14_0, var_14_1 = HexMath.hexXYToPosXY(arg_14_3.x, arg_14_3.y, RoomBlockEnum.BlockSize)

		arg_14_1.worldPos = Vector3(var_14_0, 0, var_14_1)
	end
end

function var_0_0._refreshItemList(arg_15_0)
	local var_15_0 = arg_15_0._quickLinkMO:getNodeList()
	local var_15_1 = 0

	if not arg_15_0._isLinkFinsh and var_15_0 and #var_15_0 > 0 then
		local var_15_2 = RoomMapHexPointModel.instance
		local var_15_3 = RoomMapModel.instance

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			var_15_1 = var_15_1 + 1

			local var_15_4 = arg_15_0._uiitemTBList[var_15_1]

			if not var_15_4 then
				var_15_4 = arg_15_0:_createTB(gohelper.cloneInPlace(arg_15_0._gomapuiitem))
				arg_15_0._uiitemTBList[var_15_1] = var_15_4
			end

			arg_15_0:_refreshTB(var_15_4, iter_15_1, iter_15_1.hexPoint)
		end
	end

	for iter_15_2 = 1, #arg_15_0._uiitemTBList do
		local var_15_5 = arg_15_0._uiitemTBList[iter_15_2]
		local var_15_6 = iter_15_2 <= var_15_1

		if var_15_5.isActive ~= var_15_6 then
			var_15_5.isActive = var_15_6

			gohelper.setActive(var_15_5.go, var_15_6)
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
