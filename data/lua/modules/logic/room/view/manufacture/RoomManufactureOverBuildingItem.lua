module("modules.logic.room.view.manufacture.RoomManufactureOverBuildingItem", package.seeall)

local var_0_0 = class("RoomManufactureOverBuildingItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._gocritterInfo = gohelper.findChild(arg_2_0.go, "critterInfo")
	arg_2_0._gocritterItem = gohelper.findChild(arg_2_0.go, "critterInfo/#go_critterInfoItem")
	arg_2_0._txtbuilding = gohelper.findChildText(arg_2_0.go, "manufactureInfo/progress/#txt_building")
	arg_2_0._imagebuildingicon = gohelper.findChildImage(arg_2_0.go, "manufactureInfo/progress/#txt_building/#image_buildingicon")
	arg_2_0._btnaccelerate = gohelper.findChildButtonWithAudio(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_accelerate")
	arg_2_0._btndetail = gohelper.findChildButtonWithAudio(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail")
	arg_2_0._goaccelerate = arg_2_0._btnaccelerate.gameObject
	arg_2_0._btnwrong = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong")
	arg_2_0._gowrongselect = gohelper.findChild(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong/#go_select")
	arg_2_0._gowrongunselect = gohelper.findChild(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong/#go_unselect")
	arg_2_0._btngoto = gohelper.findChildClickWithAudio(arg_2_0.go, "manufactureInfo/progress/#btn_goto/clickarea")
	arg_2_0._goscrollslot = gohelper.findChild(arg_2_0.go, "manufactureInfo/#scroll_slot")
	arg_2_0._scrollSlot = arg_2_0._goscrollslot:GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_2_0._goslotItemContent = gohelper.findChild(arg_2_0.go, "manufactureInfo/#scroll_slot/slotViewport/slotContent")
	arg_2_0._transslotItemContent = arg_2_0._goslotItemContent.transform
	arg_2_0._goslotItem = gohelper.findChild(arg_2_0.go, "manufactureInfo/#scroll_slot/slotViewport/slotContent/#go_slotItem")

	gohelper.setActive(arg_2_0._goslotItem, false)

	arg_2_0._gounselectdetail = gohelper.findChild(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail/unselect")
	arg_2_0._goselectdetail = gohelper.findChild(arg_2_0.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail/select")

	arg_2_0:clearVar()
	arg_2_0:_setDetailSelect(false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnaccelerate:AddClickListener(arg_3_0._btnaccelerateOnClick, arg_3_0)
	arg_3_0._btnwrong:AddClickListener(arg_3_0._btnwrongOnClick, arg_3_0)
	arg_3_0._btngoto:AddClickListener(arg_3_0._btngotoOnClick, arg_3_0)
	arg_3_0._btndetail:AddClickListener(arg_3_0._btndetailOnClick, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, arg_3_0._onCloseDetatilView, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.OnWrongTipViewChange, arg_3_0._onWrongViewChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnaccelerate:RemoveClickListener()
	arg_4_0._btnwrong:RemoveClickListener()
	arg_4_0._btngoto:RemoveClickListener()
	arg_4_0._btndetail:RemoveClickListener()
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, arg_4_0._onCloseDetatilView, arg_4_0)
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.OnWrongTipViewChange, arg_4_0._onWrongViewChange, arg_4_0)
end

function var_0_0._btnaccelerateOnClick(arg_5_0)
	local var_5_0 = arg_5_0:getViewBuilding()

	ManufactureController.instance:openManufactureAccelerateView(var_5_0)
	arg_5_0:closePopView()
end

function var_0_0._btnwrongOnClick(arg_6_0)
	local var_6_0 = arg_6_0:getViewBuilding()

	ManufactureController.instance:clickWrongBtn(var_6_0, true)
end

function var_0_0._btngotoOnClick(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:getViewBuilding()

	ViewMgr.instance:closeView(ViewName.RoomOverView, true)

	if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		ManufactureController.instance:closeCritterBuildingView(true)
	end

	local var_7_2 = false

	if arg_7_0.parentView and arg_7_0.parentView.viewContainer.viewParam then
		var_7_2 = arg_7_0.parentView.viewContainer.viewParam.openFromRest
	end

	ManufactureController.instance:openManufactureBuildingViewByBuilding(var_7_1, var_7_2)
end

function var_0_0._btndetailOnClick(arg_8_0)
	local var_8_0 = arg_8_0:getViewBuilding()
	local var_8_1 = ManufactureController.instance:openRoomManufactureBuildingDetailView(var_8_0, true)

	arg_8_0:_setDetailSelect(var_8_1)
end

function var_0_0._onCloseDetatilView(arg_9_0)
	arg_9_0:_setDetailSelect(false)
end

function var_0_0.onManufactureInfoUpdate(arg_10_0)
	arg_10_0:refreshSelectedSlot()
	arg_10_0:refreshSelectedCritterSlot()
	arg_10_0:_setSlotItems()
	arg_10_0:_setCritterItem()
	arg_10_0:refresh()
end

function var_0_0.onManufactureBuildingInfoChange(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getViewBuilding()

	if arg_11_1 and not arg_11_1[var_11_0] then
		return
	end

	arg_11_0:refreshSelectedSlot()
	arg_11_0:refreshSelectedCritterSlot()
	arg_11_0:_setSlotItems()
	arg_11_0:_setCritterItem()
	arg_11_0:refresh()
end

function var_0_0.onTradeLevelChange(arg_12_0)
	arg_12_0:_setCritterItem()
end

function var_0_0.onChangeSelectedSlotItem(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._slotItemList) do
		iter_13_1:onChangeSelectedSlotItem()
	end
end

function var_0_0._setDetailSelect(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goselectdetail, arg_14_1)
	gohelper.setActive(arg_14_0._gounselectdetail, not arg_14_1)
end

function var_0_0._onWrongViewChange(arg_15_0, arg_15_1)
	arg_15_0:refreshWrongBtnSelect(arg_15_1)
end

function var_0_0.setData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.buildingMO = arg_16_1
	arg_16_0.index = arg_16_2
	arg_16_0.parentView = arg_16_3
	arg_16_0._scrollSlot.parentGameObject = arg_16_3._goscrollbuilding
	arg_16_0._curViewManufactureState = nil

	arg_16_0:_setSlotItems()
	arg_16_0:_setCritterItem()
	arg_16_0:refresh()
end

function var_0_0._setSlotItems(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0:getViewBuilding()

	if not var_17_1 then
		arg_17_0:recycleAllSlotItem()

		return
	end

	local var_17_2 = var_17_1.buildingId
	local var_17_3 = var_17_1:getAllUnlockedSlotIdList()
	local var_17_4 = ManufactureConfig.instance:getBuildingTotalSlotCount(var_17_2)

	for iter_17_0 = 1, var_17_4 do
		local var_17_5 = arg_17_0:getSlotItem(iter_17_0)
		local var_17_6 = var_17_3[iter_17_0]

		var_17_5:setData(var_17_6, iter_17_0)
	end

	local var_17_7 = #arg_17_0._slotItemList

	if var_17_4 < var_17_7 then
		for iter_17_1 = var_17_4 + 1, var_17_7 do
			local var_17_8 = arg_17_0._slotItemList[iter_17_1]

			arg_17_0:recycleSlotItem(var_17_8)
		end
	end

	arg_17_0:_setSlotContentSize()
end

function var_0_0._setSlotContentSize(arg_18_0)
	local var_18_0 = #arg_18_0._slotItemList
	local var_18_1 = (recthelper.getWidth(arg_18_0._goslotItem.transform) + RoomManufactureEnum.OverviewSlotItemSpace) * var_18_0 - RoomManufactureEnum.OverviewSlotItemSpace

	recthelper.setWidth(arg_18_0._transslotItemContent, var_18_1)
end

function var_0_0._setCritterItem(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:getViewBuilding()
	local var_19_2 = 0

	if var_19_1 then
		var_19_2 = var_19_1:getCanPlaceCritterCount()
	end

	local var_19_3 = arg_19_0._critterItemList and #arg_19_0._critterItemList

	if var_19_3 and var_19_2 < var_19_3 then
		for iter_19_0 = var_19_2 + 1, var_19_3 do
			arg_19_0._critterItemList[iter_19_0]:reset()
		end
	end

	arg_19_0._critterItemList = {}

	local var_19_4 = {}

	for iter_19_1 = 1, var_19_2 do
		var_19_4[iter_19_1] = iter_19_1 - 1
	end

	gohelper.CreateObjList(arg_19_0, arg_19_0._onSetCritterItem, var_19_4, arg_19_0._gocritterInfo, arg_19_0._gocritterItem, RoomManufactureCritterInfo)
end

function var_0_0._onSetCritterItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._critterItemList[arg_20_3] = arg_20_1

	arg_20_1:setData(arg_20_2, arg_20_3, arg_20_0)
end

function var_0_0.closePopView(arg_21_0)
	ManufactureController.instance:clearSelectedSlotItem()
	ManufactureController.instance:clearSelectCritterSlotItem()
end

function var_0_0.getSlotItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._slotItemList[arg_22_1]

	if not var_22_0 then
		var_22_0 = arg_22_0:getSlotItemFromPool()
		arg_22_0._slotItemList[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0.getSlotItemFromPool(arg_23_0)
	if next(arg_23_0._slotItemPool) then
		return (table.remove(arg_23_0._slotItemPool))
	else
		return arg_23_0:createSlotItem()
	end
end

function var_0_0.createSlotItem(arg_24_0)
	local var_24_0 = gohelper.clone(arg_24_0._goslotItem, arg_24_0._goslotItemContent)

	return (RoomManufactureOverSlotItem.New(var_24_0, arg_24_0))
end

function var_0_0.recycleSlotItem(arg_25_0, arg_25_1)
	arg_25_1:reset(true)
	tabletool.removeValue(arg_25_0._slotItemList, arg_25_1)
	table.insert(arg_25_0._slotItemPool, arg_25_1)
end

function var_0_0.recycleAllSlotItem(arg_26_0)
	if arg_26_0._slotItemList then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._slotItemList) do
			iter_26_1:reset(true)
			table.insert(arg_26_0._slotItemPool, iter_26_1)
		end
	end

	arg_26_0._slotItemList = {}
end

function var_0_0.refresh(arg_27_0)
	arg_27_0:refreshTitle()
	arg_27_0:refreshCritter()
	arg_27_0:checkManufactureState()
	arg_27_0:refreshSlotItems()
	arg_27_0:refreshWrongBtnShow()
	arg_27_0:refreshDetailBtn()
end

function var_0_0.refreshTitle(arg_28_0)
	local var_28_0 = ""
	local var_28_1 = 0
	local var_28_2
	local var_28_3, var_28_4 = arg_28_0:getViewBuilding()

	if var_28_4 then
		var_28_0 = var_28_4.config.useDesc
		var_28_1 = var_28_4.level
		var_28_2 = var_28_4.buildingId
	end

	local var_28_5 = ""

	if var_28_1 >= ManufactureConfig.instance:getBuildingMaxLevel(var_28_2) then
		var_28_5 = luaLang("lv_max")
	else
		var_28_5 = formatLuaLang("v1a5_aizila_level", var_28_1)
	end

	arg_28_0._txtbuilding.text = string.format("%s <color=#E19653>%s</color>", var_28_0, var_28_5)

	local var_28_6 = ManufactureConfig.instance:getManufactureBuildingIcon(var_28_4.buildingId)

	UISpriteSetMgr.instance:setRoomSprite(arg_28_0._imagebuildingicon, var_28_6)
end

function var_0_0.refreshCritter(arg_29_0)
	return
end

function var_0_0.checkManufactureState(arg_30_0)
	local var_30_0 = false
	local var_30_1, var_30_2 = arg_30_0:getViewBuilding()

	if var_30_2 then
		var_30_0 = var_30_2:getManufactureState()
	end

	if arg_30_0._curViewManufactureState == var_30_0 then
		return
	end

	arg_30_0._curViewManufactureState = var_30_0

	local var_30_3 = arg_30_0._curViewManufactureState == RoomManufactureEnum.ManufactureState.Running

	gohelper.setActive(arg_30_0._goaccelerate, var_30_3)
end

function var_0_0.refreshSlotItems(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0._slotItemList) do
		iter_31_1:refresh()
	end
end

function var_0_0.refreshSelectedSlot(arg_32_0)
	local var_32_0 = arg_32_0:getViewBuilding()

	if ManufactureModel.instance:getSelectedSlot() == var_32_0 then
		ManufactureController.instance:refreshSelectedSlotId(var_32_0)
	end
end

function var_0_0.refreshSelectedCritterSlot(arg_33_0)
	local var_33_0 = arg_33_0:getViewBuilding()

	if ManufactureModel.instance:getSelectedCritterSlot() == var_33_0 then
		ManufactureController.instance:refreshSelectedCritterSlotId(var_33_0)
	end
end

function var_0_0.refreshWrongBtnShow(arg_34_0)
	local var_34_0 = arg_34_0:getViewBuilding()
	local var_34_1 = ManufactureModel.instance:getManufactureWrongTipItemList(var_34_0)

	arg_34_0:refreshWrongBtnSelect()

	local var_34_2 = #var_34_1 > 0

	gohelper.setActive(arg_34_0._btnwrong, var_34_2)
end

function var_0_0.refreshWrongBtnSelect(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getViewBuilding()
	local var_35_1 = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView) and arg_35_1 == var_35_0

	gohelper.setActive(arg_35_0._gowrongselect, var_35_1)
	gohelper.setActive(arg_35_0._gowrongunselect, not var_35_1)
end

function var_0_0.refreshDetailBtn(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0:getViewBuilding()
	local var_36_2 = var_36_1:getSlot2CritterDict()
	local var_36_3 = next(var_36_2)

	gohelper.setActive(arg_36_0._btndetail, var_36_3)
end

function var_0_0.everySecondCall(arg_37_0)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0._slotItemList) do
		iter_37_1:everySecondCall()
	end
end

function var_0_0.getViewBuilding(arg_38_0)
	local var_38_0

	if arg_38_0.buildingMO then
		var_38_0 = arg_38_0.buildingMO.uid
	end

	return var_38_0, arg_38_0.buildingMO
end

function var_0_0.getSlotItemContentTrans(arg_39_0)
	return arg_39_0._transslotItemContent
end

function var_0_0.getIndex(arg_40_0)
	return arg_40_0.index
end

function var_0_0.isShowAddPop(arg_41_0)
	return arg_41_0.parentView:isShowAddPop()
end

function var_0_0.setViewBuildingUid(arg_42_0)
	local var_42_0 = arg_42_0:getViewBuilding()

	arg_42_0.parentView:setViewBuildingUid(var_42_0)
end

function var_0_0.clearVar(arg_43_0)
	arg_43_0.index = nil
	arg_43_0._curViewManufactureState = nil

	arg_43_0:clearSlotPool()
	arg_43_0:clearSlotItemList()
end

function var_0_0.clearSlotPool(arg_44_0)
	if arg_44_0._slotItemPool then
		for iter_44_0, iter_44_1 in ipairs(arg_44_0._slotItemPool) do
			iter_44_1:destroy()
		end
	end

	arg_44_0._slotItemPool = {}
end

function var_0_0.clearSlotItemList(arg_45_0)
	if arg_45_0._slotItemList then
		for iter_45_0, iter_45_1 in ipairs(arg_45_0._slotItemList) do
			iter_45_1:destroy()
		end
	end

	arg_45_0._slotItemList = {}
end

function var_0_0.onDestroy(arg_46_0)
	arg_46_0:clearVar()
end

return var_0_0
