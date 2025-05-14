module("modules.logic.room.view.manufacture.RoomManufactureBuildingView", package.seeall)

local var_0_0 = class("RoomManufactureBuildingView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnpopBlock = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_popBlock")
	arg_1_0._imagebuildingIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/headerInfo/#simage_buildingIcon")
	arg_1_0._txtmanuName = gohelper.findChildText(arg_1_0.viewGO, "#go_left/headerInfo/layout/#txt_manuName")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "#go_left/headerInfo/layout/lv/#txt_lv")
	arg_1_0._btnupgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/headerInfo/#btn_upgrade")
	arg_1_0._goupgradeReddot = gohelper.findChild(arg_1_0.viewGO, "#go_left/headerInfo/#btn_upgrade/#go_reddot")
	arg_1_0._goswithbtnlayout = gohelper.findChild(arg_1_0.viewGO, "#go_left/layoutSwitchBtns")
	arg_1_0._goswithItem = gohelper.findChild(arg_1_0.viewGO, "#go_left/layoutSwitchBtns/#btn_swithItem")
	arg_1_0._gocritterInfo = gohelper.findChild(arg_1_0.viewGO, "#go_left/critterInfo")
	arg_1_0._gocritterItem = gohelper.findChild(arg_1_0.viewGO, "#go_left/critterInfo/#go_critterInfoItem")
	arg_1_0._gomanufacture = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture")
	arg_1_0._btnaccelerate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_accelerate")
	arg_1_0._btnwrong = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong")
	arg_1_0._gowrongselect = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong/#go_select")
	arg_1_0._gowrongunselect = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong/#go_unselect")
	arg_1_0._btnproduction = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/#btn_production")
	arg_1_0._goproductionReddot = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/#btn_production/#go_reddot")
	arg_1_0._goscrollslot = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot")
	arg_1_0._transscrollslot = arg_1_0._goscrollslot.transform
	arg_1_0._scrollslot = arg_1_0._goscrollslot:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_1_0._goslotItemContent = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot/viewport/content")
	arg_1_0._transslotItemContent = arg_1_0._goslotItemContent.transform
	arg_1_0._goslotItem = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot/viewport/content/#go_slotItem")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnupgrade:AddClickListener(arg_2_0._btnupgradeOnClick, arg_2_0)
	arg_2_0._btnaccelerate:AddClickListener(arg_2_0._btnaccelerateOnClick, arg_2_0)
	arg_2_0._btnwrong:AddClickListener(arg_2_0._btnwrongOnClick, arg_2_0)
	arg_2_0._btnproduction:AddClickListener(arg_2_0._btnproductionOnClick, arg_2_0)
	arg_2_0._btnpopBlock:AddClickListener(arg_2_0._btnpopBlockOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, arg_2_0._onManufactureGuideTweenFinish, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_2_0._onManufactureInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_2_0._onTradeLevelChange, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_2_0._onManufactureBuildingInfoChange, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_2_0._onChangeSelectedCritterSlotItem, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, arg_2_0._onReadNewFormula, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_2_0._onBuildingLevelUp, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onViewChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onViewChange, arg_2_0)
	NavigateMgr.instance:addEscape(ViewName.RoomManufactureBuildingView, arg_2_0._onEscape, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnupgrade:RemoveClickListener()
	arg_3_0._btnaccelerate:RemoveClickListener()
	arg_3_0._btnwrong:RemoveClickListener()
	arg_3_0._btnproduction:RemoveClickListener()
	arg_3_0._btnpopBlock:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0:clearSwitchBtnList()
	arg_3_0:removeEventCb(RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, arg_3_0._onManufactureGuideTweenFinish, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0._onManufactureInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_3_0._onTradeLevelChange, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._onManufactureBuildingInfoChange, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_3_0._onChangeSelectedCritterSlotItem, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, arg_3_0._onReadNewFormula, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_3_0._onBuildingLevelUp, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onViewChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onViewChange, arg_3_0)
end

function var_0_0._btndetailOnClick(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:getViewBuilding()

	ManufactureController.instance:openRoomManufactureBuildingDetailView(var_4_0)
end

function var_0_0._btnupgradeOnClick(arg_5_0)
	local var_5_0 = arg_5_0:getViewBuilding()

	ManufactureController.instance:openManufactureBuildingLevelUpView(var_5_0)
end

function var_0_0._btnaccelerateOnClick(arg_6_0)
	local var_6_0 = arg_6_0:getViewBuilding()

	ManufactureController.instance:openManufactureAccelerateView(var_6_0)
end

function var_0_0._btnwrongOnClick(arg_7_0)
	local var_7_0 = arg_7_0:getViewBuilding()

	ManufactureController.instance:clickWrongBtn(var_7_0)
end

function var_0_0._btnproductionOnClick(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getViewBuilding()

	ManufactureController.instance:clickSlotItem(var_8_0, nil, nil, true, nil, arg_8_1)
end

local var_0_2 = {
	ViewName.RoomManufactureAddPopView,
	ViewName.RoomCritterListView,
	ViewName.RoomManufactureWrongTipView
}

function var_0_0._btnpopBlockOnClick(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(var_0_2) do
		if ViewMgr.instance:isOpen(iter_9_1) then
			arg_9_0:closePopView()

			break
		end
	end
end

function var_0_0._btnswithItemOnClick(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.index
	local var_10_1 = arg_10_1.isOnOpen
	local var_10_2 = arg_10_0._switchBtnList[var_10_0]

	if not var_10_2 then
		return
	end

	local var_10_3 = var_10_2.buildingUid
	local var_10_4 = arg_10_0:getViewBuilding()

	if var_10_4 and var_10_4 == var_10_3 then
		return
	end

	arg_10_0:closePopView()
	arg_10_0.viewContainer:setContainerViewBuildingUid(var_10_3)

	arg_10_0._curViewManufactureState = nil

	if not var_10_1 then
		arg_10_0:_refreshCamera()
	end

	arg_10_0:refreshSelectedSlot()
	arg_10_0:refreshSelectedCritterSlot()
	arg_10_0:_setCritterItem()
	arg_10_0:_setSlotItems()
	arg_10_0:_setAddPopItems()
	arg_10_0:refresh()
end

function var_0_0._refreshCamera(arg_11_0)
	local var_11_0, var_11_1 = arg_11_0:getViewBuilding()

	if not var_11_1 then
		return
	end

	local var_11_2 = var_11_1.buildingId
	local var_11_3 = ManufactureConfig.instance:getBuildingCameraIdByIndex(var_11_2)

	if RoomCameraController.instance:getRoomCamera() and var_11_3 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(var_11_0, var_11_3)
	end
end

function var_0_0._onManufactureGuideTweenFinish(arg_12_0)
	arg_12_0:_setSlotItems()
end

function var_0_0._onManufactureInfoUpdate(arg_13_0)
	arg_13_0:refreshSelectedSlot()
	arg_13_0:refreshSelectedCritterSlot()
	arg_13_0:_setCritterItem()
	arg_13_0:_setSlotItems()
	arg_13_0:refresh()
end

function var_0_0._onTradeLevelChange(arg_14_0)
	arg_14_0:refreshTitle()
	arg_14_0:_setCritterItem()
end

function var_0_0._onManufactureBuildingInfoChange(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getViewBuilding()

	if arg_15_1 and not arg_15_1[var_15_0] then
		return
	end

	arg_15_0:refreshSelectedSlot()
	arg_15_0:refreshSelectedCritterSlot()
	arg_15_0:_setCritterItem()
	arg_15_0:_setSlotItems()
	arg_15_0:refresh()
end

function var_0_0._onChangeSelectedCritterSlotItem(arg_16_0)
	local var_16_0 = false
	local var_16_1, var_16_2 = ManufactureModel.instance:getSelectedCritterSlot()
	local var_16_3 = arg_16_0:getViewBuilding()

	if var_16_2 and var_16_1 and var_16_1 == var_16_3 then
		var_16_0 = true
	end

	gohelper.setActive(arg_16_0._gomanufacture, not var_16_0)
end

function var_0_0._onReadNewFormula(arg_17_0)
	if not arg_17_0._newFormulaReddot then
		return
	end

	arg_17_0._newFormulaReddot:refreshRedDot()
end

function var_0_0._onBuildingLevelUp(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getViewBuilding()

	if not arg_18_1 or not arg_18_1[var_18_0] then
		return
	end

	arg_18_0:closePopView()
	arg_18_0:_setAddPopItems()
	arg_18_0:_onReadNewFormula()
end

function var_0_0._onViewChange(arg_19_0, arg_19_1)
	if arg_19_1 == ViewName.RoomManufactureWrongTipView then
		arg_19_0:refreshWrongBtnSelect()
	end
end

function var_0_0._onEscape(arg_20_0)
	ViewMgr.instance:closeView(ViewName.RoomManufactureBuildingView)
	ManufactureController.instance:resetCameraOnCloseView()
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0:clearVar()
	gohelper.setActive(arg_21_0._goslotItem, false)
end

function var_0_0.onUpdateParam(arg_22_0)
	arg_22_0.buildingType = arg_22_0.viewParam.buildingType
	arg_22_0.defaultBuildingUid = arg_22_0.viewParam.defaultBuildingUid

	arg_22_0:setView()

	if arg_22_0.viewParam.addManuItem then
		arg_22_0:_btnproductionOnClick(arg_22_0.viewParam.addManuItem)
	end
end

function var_0_0.onOpen(arg_23_0)
	arg_23_0:onUpdateParam()
	arg_23_0:everySecondCall()
	TaskDispatcher.runRepeat(arg_23_0.everySecondCall, arg_23_0, TimeUtil.OneSecond)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
end

function var_0_0.setView(arg_24_0)
	arg_24_0:_setSwitchBtnGroup()

	local var_24_0 = var_0_1

	if arg_24_0.defaultBuildingUid then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0._switchBtnList) do
			if iter_24_1.buildingUid == arg_24_0.defaultBuildingUid then
				var_24_0 = iter_24_0

				break
			end
		end
	end

	arg_24_0:_btnswithItemOnClick({
		isOnOpen = true,
		index = var_24_0
	})
end

function var_0_0._setSwitchBtnGroup(arg_25_0)
	local var_25_0 = RoomMapBuildingModel.instance:getBuildingListByType(arg_25_0.buildingType, true) or {}

	gohelper.CreateObjList(arg_25_0, arg_25_0._onSetSwitchBtnItem, var_25_0, arg_25_0._goswithbtnlayout, arg_25_0._goswithItem)
end

function var_0_0._onSetSwitchBtnItem(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0:getUserDataTb_()

	var_26_0.go = arg_26_1
	var_26_0.buildingUid = arg_26_2.uid
	var_26_0.goSelect = gohelper.findChild(var_26_0.go, "go_select")
	var_26_0.goUnselect = gohelper.findChild(var_26_0.go, "go_unselect")
	var_26_0.goReddot = gohelper.findChild(var_26_0.go, "#go_reddot")

	RedDotController.instance:addRedDot(var_26_0.goReddot, RedDotEnum.DotNode.ManufactureBuildingCanLevelUp, tonumber(var_26_0.buildingUid))

	local var_26_1 = ManufactureConfig.instance:getManufactureBuildingIcon(arg_26_2.buildingId)

	var_26_0.imgSelectIcon = gohelper.findChildImage(var_26_0.go, "go_select/image_selecticon")
	var_26_0.imgUnselectIcon = gohelper.findChildImage(var_26_0.go, "go_unselect/image_unselecticon")

	UISpriteSetMgr.instance:setRoomSprite(var_26_0.imgSelectIcon, var_26_1)
	UISpriteSetMgr.instance:setRoomSprite(var_26_0.imgUnselectIcon, var_26_1)

	var_26_0.btn = gohelper.findChildClickWithDefaultAudio(var_26_0.go, "clickarea")

	var_26_0.btn:AddClickListener(arg_26_0._btnswithItemOnClick, arg_26_0, {
		index = arg_26_3
	})

	arg_26_0._switchBtnList[arg_26_3] = var_26_0
end

function var_0_0._setCritterItem(arg_27_0)
	local var_27_0, var_27_1 = arg_27_0:getViewBuilding()
	local var_27_2 = 0

	if var_27_1 then
		var_27_2 = var_27_1:getCanPlaceCritterCount()
	end

	local var_27_3 = arg_27_0._critterItemList and #arg_27_0._critterItemList

	if var_27_3 and var_27_2 < var_27_3 then
		for iter_27_0 = var_27_2 + 1, var_27_3 do
			arg_27_0._critterItemList[iter_27_0]:reset()
		end
	end

	arg_27_0._critterItemList = {}

	local var_27_4 = {}

	for iter_27_1 = 1, var_27_2 do
		var_27_4[iter_27_1] = iter_27_1 - 1
	end

	gohelper.CreateObjList(arg_27_0, arg_27_0._onSetCritterItem, var_27_4, arg_27_0._gocritterInfo, arg_27_0._gocritterItem, RoomManufactureCritterInfo)
end

function var_0_0._onSetCritterItem(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._critterItemList[arg_28_3] = arg_28_1

	arg_28_1:setData(arg_28_2, arg_28_3, arg_28_0)
end

function var_0_0._setSlotItems(arg_29_0)
	local var_29_0, var_29_1 = arg_29_0:getViewBuilding()

	if not var_29_1 then
		arg_29_0:recycleAllSlotItem()

		return
	end

	if arg_29_0:checkGuide() then
		return
	end

	local var_29_2 = var_29_1.buildingId
	local var_29_3 = var_29_1:getAllUnlockedSlotIdList()
	local var_29_4 = ManufactureConfig.instance:getBuildingTotalSlotCount(var_29_2)

	for iter_29_0 = 1, var_29_4 do
		local var_29_5 = arg_29_0:getSlotItem(iter_29_0)
		local var_29_6 = var_29_3[iter_29_0]

		var_29_5:setData(var_29_6, iter_29_0)
	end

	local var_29_7 = #arg_29_0._slotItemList

	if var_29_4 < var_29_7 then
		for iter_29_1 = var_29_4 + 1, var_29_7 do
			local var_29_8 = arg_29_0._slotItemList[iter_29_1]

			arg_29_0:recycleSlotItem(var_29_8)
		end
	end
end

function var_0_0._setAddPopItems(arg_30_0)
	local var_30_0 = arg_30_0:getViewBuilding()

	ManufactureController.instance:setManufactureFormulaItemList(var_30_0)
end

function var_0_0.closePopView(arg_31_0)
	arg_31_0:_closeFormulaListView()
	arg_31_0:_closeCritterListView()
	arg_31_0:_closeWrongTipView()
end

function var_0_0._closeCritterListView(arg_32_0)
	ManufactureController.instance:clearSelectCritterSlotItem()
end

function var_0_0._closeFormulaListView(arg_33_0)
	ManufactureController.instance:clearSelectedSlotItem()
end

function var_0_0._closeWrongTipView(arg_34_0)
	ManufactureController.instance:closeWrongTipView()
end

function var_0_0.getSlotItem(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._slotItemList[arg_35_1]

	if not var_35_0 then
		var_35_0 = arg_35_0:getSlotItemFromPool()
		arg_35_0._slotItemList[arg_35_1] = var_35_0
	end

	return var_35_0
end

function var_0_0.getSlotItemFromPool(arg_36_0)
	if next(arg_36_0._slotItemPool) then
		return (table.remove(arg_36_0._slotItemPool))
	else
		return arg_36_0:createSlotItem()
	end
end

function var_0_0.createSlotItem(arg_37_0, arg_37_1)
	local var_37_0 = gohelper.clone(arg_37_0._goslotItem, arg_37_1 or arg_37_0._goslotItemContent)

	return (RoomManufactureSlotItem.New(var_37_0, arg_37_0))
end

function var_0_0.recycleSlotItem(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	arg_38_1:reset(true)
	tabletool.removeValue(arg_38_0._slotItemList, arg_38_1)
	table.insert(arg_38_0._slotItemPool, arg_38_1)
end

function var_0_0.recycleAllSlotItem(arg_39_0)
	if arg_39_0._slotItemList then
		for iter_39_0, iter_39_1 in ipairs(arg_39_0._slotItemList) do
			iter_39_1:reset(true)
			table.insert(arg_39_0._slotItemPool, iter_39_1)
		end
	end

	arg_39_0._slotItemList = {}
end

function var_0_0.refresh(arg_40_0)
	arg_40_0:refreshTitle()
	arg_40_0:refreshSwitchBtns()
	arg_40_0:refreshSlotItems()
	arg_40_0:checkManufactureState()
	arg_40_0:refreshReddot()
	arg_40_0:refreshWrongBtnShow()
end

function var_0_0.refreshTitle(arg_41_0)
	local var_41_0 = ""
	local var_41_1 = 0
	local var_41_2
	local var_41_3
	local var_41_4, var_41_5 = arg_41_0:getViewBuilding()

	if var_41_5 then
		var_41_0 = var_41_5.config.useDesc
		var_41_1 = var_41_5:getLevel()
		var_41_3 = ManufactureConfig.instance:getManufactureBuildingIcon(var_41_5.buildingId)
		var_41_2 = var_41_5.buildingId
	end

	arg_41_0._txtmanuName.text = var_41_0

	local var_41_6 = ""

	if var_41_1 >= ManufactureConfig.instance:getBuildingMaxLevel(var_41_2) then
		var_41_6 = luaLang("lv_max")
	else
		var_41_6 = formatLuaLang("v1a5_aizila_level", var_41_1)
	end

	arg_41_0._txtlv.text = var_41_6

	if var_41_3 then
		UISpriteSetMgr.instance:setRoomSprite(arg_41_0._imagebuildingIcon, var_41_3)
	end

	local var_41_7 = ManufactureModel.instance:isMaxLevel(var_41_4)

	gohelper.setActive(arg_41_0._btnupgrade.gameObject, not var_41_7)
end

function var_0_0.refreshSwitchBtns(arg_42_0)
	if not arg_42_0._switchBtnList then
		return
	end

	local var_42_0 = arg_42_0:getViewBuilding()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0._switchBtnList) do
		local var_42_1 = iter_42_1.buildingUid == var_42_0

		gohelper.setActive(iter_42_1.goSelect, var_42_1)
		gohelper.setActive(iter_42_1.goUnselect, not var_42_1)
	end
end

function var_0_0.refreshSlotItems(arg_43_0)
	if arg_43_0:checkGuide() then
		return
	end

	for iter_43_0, iter_43_1 in ipairs(arg_43_0._slotItemList) do
		iter_43_1:refresh()
	end
end

function var_0_0.checkManufactureState(arg_44_0)
	local var_44_0, var_44_1 = arg_44_0:getViewBuilding()
	local var_44_2 = false

	if var_44_1 then
		var_44_2 = var_44_1:getManufactureState()
	end

	if arg_44_0._curViewManufactureState == var_44_2 then
		return
	end

	arg_44_0._curViewManufactureState = var_44_2

	local var_44_3 = arg_44_0._curViewManufactureState == RoomManufactureEnum.ManufactureState.Running

	gohelper.setActive(arg_44_0._btnaccelerate.gameObject, var_44_3)
end

function var_0_0.refreshSelectedSlot(arg_45_0)
	local var_45_0 = arg_45_0:getViewBuilding()

	ManufactureController.instance:refreshSelectedSlotId(var_45_0)
end

function var_0_0.refreshSelectedCritterSlot(arg_46_0)
	local var_46_0 = arg_46_0:getViewBuilding()

	ManufactureController.instance:refreshSelectedCritterSlotId(var_46_0)
end

function var_0_0.refreshReddot(arg_47_0)
	local var_47_0 = arg_47_0:getViewBuilding()

	RedDotController.instance:addRedDot(arg_47_0._goupgradeReddot, RedDotEnum.DotNode.ManufactureBuildingCanLevelUp, tonumber(var_47_0))

	arg_47_0._newFormulaReddot = RedDotController.instance:addNotEventRedDot(arg_47_0._goproductionReddot, arg_47_0.checkNewFormulaReddot, arg_47_0)
end

function var_0_0.checkNewFormulaReddot(arg_48_0)
	local var_48_0 = arg_48_0:getViewBuilding()

	return ManufactureModel.instance:hasNewManufactureFormula(var_48_0)
end

function var_0_0.refreshWrongBtnShow(arg_49_0)
	local var_49_0 = arg_49_0:getViewBuilding()
	local var_49_1 = #ManufactureModel.instance:getManufactureWrongTipItemList(var_49_0) > 0

	if var_49_1 then
		arg_49_0:refreshWrongBtnSelect()
	end

	gohelper.setActive(arg_49_0._btnwrong, var_49_1)
end

function var_0_0.refreshWrongBtnSelect(arg_50_0)
	local var_50_0 = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView)

	gohelper.setActive(arg_50_0._gowrongselect, var_50_0)
	gohelper.setActive(arg_50_0._gowrongunselect, not var_50_0)
end

function var_0_0.everySecondCall(arg_51_0)
	for iter_51_0, iter_51_1 in ipairs(arg_51_0._slotItemList) do
		iter_51_1:everySecondCall()
	end
end

function var_0_0.getViewBuilding(arg_52_0)
	local var_52_0, var_52_1 = arg_52_0.viewContainer:getContainerViewBuilding()

	return var_52_0, var_52_1
end

function var_0_0.clearVar(arg_53_0)
	arg_53_0.buildingType = nil
	arg_53_0.defaultBuildingUid = nil

	arg_53_0:clearSwitchBtnList()

	arg_53_0._curViewManufactureState = nil

	arg_53_0:clearSlotPool()
	arg_53_0:clearSlotItemList()
end

function var_0_0.clearSwitchBtnList(arg_54_0)
	if arg_54_0._switchBtnList then
		for iter_54_0, iter_54_1 in ipairs(arg_54_0._switchBtnList) do
			iter_54_1.btn:RemoveClickListener()
			gohelper.destroy(iter_54_1.go)
		end
	end

	arg_54_0._switchBtnList = {}
end

function var_0_0.clearSlotPool(arg_55_0)
	if arg_55_0._slotItemPool then
		for iter_55_0, iter_55_1 in ipairs(arg_55_0._slotItemPool) do
			iter_55_1:destroy()
		end
	end

	arg_55_0._slotItemPool = {}
end

function var_0_0.clearSlotItemList(arg_56_0)
	if arg_56_0._slotItemList then
		for iter_56_0, iter_56_1 in ipairs(arg_56_0._slotItemList) do
			iter_56_1:destroy()
		end
	end

	arg_56_0._slotItemList = {}
end

function var_0_0.checkGuide(arg_57_0)
	local var_57_0 = GuideModel.instance:getLockGuideId()
	local var_57_1 = false

	if var_57_0 == 414 then
		for iter_57_0, iter_57_1 in ipairs(arg_57_0._slotItemList) do
			if iter_57_1:checkPlayGuideTween() then
				var_57_1 = true
			end
		end
	end

	return var_57_1
end

function var_0_0.onClose(arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0.everySecondCall, arg_58_0)
	arg_58_0:closePopView()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.ManufactureBuildingViewChange)
end

function var_0_0.onDestroyView(arg_59_0)
	arg_59_0:clearVar()
end

return var_0_0
