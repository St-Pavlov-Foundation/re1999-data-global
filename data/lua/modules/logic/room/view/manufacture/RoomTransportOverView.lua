module("modules.logic.room.view.manufacture.RoomTransportOverView", package.seeall)

local var_0_0 = class("RoomTransportOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotransportContent = gohelper.findChild(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content")
	arg_1_0._gotransportItem = gohelper.findChild(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem")
	arg_1_0._btnpopBlock = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_popBlock")
	arg_1_0._btnoneKeyCritter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottomBtns/#btn_oneKeyCritter")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoneKeyCritter:AddClickListener(arg_2_0._btnoneKeyCritterOnClick, arg_2_0)
	arg_2_0._btnpopBlock:AddClickListener(arg_2_0._btnpopBlockOnClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_2_0._onManufactureInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_2_0._onManufactureInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onViewChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onViewChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoneKeyCritter:RemoveClickListener()
	arg_3_0._btnpopBlock:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0._onManufactureInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._onManufactureInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onViewChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onViewChange, arg_3_0)
end

function var_0_0._btnoneKeyCritterOnClick(arg_4_0)
	ManufactureController.instance:oneKeyCritter(true)
end

function var_0_0._btnpopBlockOnClick(arg_5_0)
	arg_5_0:_closeCritterListView()
end

function var_0_0._onManufactureInfoUpdate(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._transportItemList) do
		iter_6_1:onManufactureInfoUpdate()
	end
end

function var_0_0._onViewChange(arg_7_0, arg_7_1)
	if arg_7_1 ~= ViewName.RoomCritterListView then
		return
	end

	arg_7_0:refreshPopBlock()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:_setTransportList()
end

function var_0_0._setTransportList(arg_9_0)
	arg_9_0._transportItemList = {}

	local var_9_0 = true
	local var_9_1 = RoomMapTransportPathModel.instance:getMaxCount()
	local var_9_2 = RoomMapTransportPathModel.instance:getTransportPathMOList()

	if var_9_1 < #var_9_2 then
		var_9_0 = false

		logError(string.format("RoomTransportOverView:_setTransportList error path count more than maxCount, pathCount:%s, maxCount:%s", #var_9_2, var_9_1))
	end

	local var_9_3 = {}
	local var_9_4 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_9_0 = 1, #var_9_4 do
		local var_9_5 = {}
		local var_9_6 = var_9_2[iter_9_0]

		if var_9_0 and var_9_6 and var_9_6:isLinkFinish() then
			var_9_5.mo = var_9_6
		end

		var_9_3[iter_9_0] = var_9_5
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._onSetTransportItem, var_9_3, arg_9_0._gotransportContent, arg_9_0._gotransportItem, RoomTransportOverItem)
end

function var_0_0._onSetTransportItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2.mo

	arg_10_1:setData(var_10_0)

	arg_10_0._transportItemList[arg_10_3] = arg_10_1
end

function var_0_0._closeCritterListView(arg_11_0)
	ManufactureController.instance:clearSelectTransportPath()
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:refreshPopBlock()
	arg_13_0:everySecondCall()
	TaskDispatcher.runRepeat(arg_13_0.everySecondCall, arg_13_0, TimeUtil.OneSecond)
end

function var_0_0.refreshPopBlock(arg_14_0)
	local var_14_0 = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)

	gohelper.setActive(arg_14_0._btnpopBlock, var_14_0)
end

function var_0_0.everySecondCall(arg_15_0)
	if arg_15_0._transportItemList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._transportItemList) do
			iter_15_1:everySecondCall()
		end
	end
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.everySecondCall, arg_16_0)
	arg_16_0:_closeCritterListView()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
