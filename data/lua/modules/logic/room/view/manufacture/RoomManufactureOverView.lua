module("modules.logic.room.view.manufacture.RoomManufactureOverView", package.seeall)

local var_0_0 = class("RoomManufactureOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnoneKeyCritter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottomBtns/#btn_oneKeyCritter")
	arg_1_0._btnoneKeyManu = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottomBtns/#btn_oneKeyManu")
	arg_1_0._btnpopBlock = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_popBlock")
	arg_1_0._goscrollbuilding = gohelper.findChild(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building")
	arg_1_0._scrollbuilding = gohelper.findChildScrollRect(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building")
	arg_1_0._transscrollbuilding = arg_1_0._goscrollbuilding.transform
	arg_1_0._gobuildingContent = gohelper.findChild(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content")
	arg_1_0._gobuildingItem = gohelper.findChild(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem")
	arg_1_0._goslotItem = gohelper.findChild(arg_1_0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem/manufactureInfo/#scroll_slot/slotViewport/slotContent/#go_slotItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoneKeyCritter:AddClickListener(arg_2_0._btnoneKeyCritterOnClick, arg_2_0)
	arg_2_0._btnoneKeyManu:AddClickListener(arg_2_0._btnoneKeyManuOnClick, arg_2_0)
	arg_2_0._btnpopBlock:AddClickListener(arg_2_0._btnpopBlockOnClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, arg_2_0._onChangeSelectedSlotItem, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_2_0._onManufactureInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_2_0._onTradeLevelChange, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_2_0._onManufactureBuildingInfoChange, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_2_0._onBuildingLevelUp, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onViewChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onViewChange, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureOverViewFocusAddPop, arg_2_0._focusBuildingItemAddPop, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.GuideFocusCritter, arg_2_0._onGuideFocusCritter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoneKeyCritter:RemoveClickListener()
	arg_3_0._btnoneKeyManu:RemoveClickListener()
	arg_3_0._btnpopBlock:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, arg_3_0._onChangeSelectedSlotItem, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0._onManufactureInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_3_0._onTradeLevelChange, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._onManufactureBuildingInfoChange, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_3_0._onBuildingLevelUp, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onViewChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onViewChange, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureOverViewFocusAddPop, arg_3_0._focusBuildingItemAddPop, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.GuideFocusCritter, arg_3_0._onGuideFocusCritter, arg_3_0)
end

function var_0_0._btnoneKeyCritterOnClick(arg_4_0)
	ManufactureController.instance:oneKeyCritter()
end

function var_0_0._btnoneKeyManuOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.RoomOneKeyView)
end

function var_0_0._btnpopBlockOnClick(arg_6_0)
	arg_6_0:closePopView()
end

function var_0_0._onChangeSelectedSlotItem(arg_7_0)
	local var_7_0, var_7_1 = ManufactureModel.instance:getSelectedSlot()

	if var_7_0 then
		arg_7_0:_setAddPopItems(var_7_0)
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0._overBuildingItemDict) do
		iter_7_1:onChangeSelectedSlotItem()
	end
end

function var_0_0._onManufactureInfoUpdate(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._overBuildingItemDict) do
		iter_8_1:onManufactureInfoUpdate()
	end
end

function var_0_0._onTradeLevelChange(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._overBuildingItemDict) do
		iter_9_1:onTradeLevelChange()
	end
end

function var_0_0._onManufactureBuildingInfoChange(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._overBuildingItemDict) do
		iter_10_1:onManufactureBuildingInfoChange(arg_10_1)
	end
end

function var_0_0._onBuildingLevelUp(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_1[arg_11_0._addPopBuildingUid] then
		arg_11_0:_setAddPopItems(arg_11_0._addPopBuildingUid, true)
	end
end

local var_0_1 = {
	ViewName.RoomManufactureAddPopView,
	ViewName.RoomCritterListView,
	ViewName.RoomManufactureWrongTipView
}

function var_0_0._onViewChange(arg_12_0, arg_12_1)
	local var_12_0 = false

	for iter_12_0, iter_12_1 in ipairs(var_0_1) do
		if arg_12_1 == iter_12_1 then
			var_12_0 = true

			break
		end
	end

	if var_12_0 then
		arg_12_0:refreshPopBlock()
	end
end

function var_0_0._focusBuildingItemAddPop(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._overBuildingItemDict[arg_13_1]
	local var_13_1 = var_13_0 and var_13_0:getIndex()

	if not var_13_1 then
		return
	end

	local var_13_2 = recthelper.getHeight(arg_13_0._contentRect)
	local var_13_3 = 1 - (var_13_1 - 1) * (arg_13_0._buildingItemHeight + arg_13_0._layoutSpace) / (var_13_2 - arg_13_0._scrollHeight)

	arg_13_0._scrollbuilding.verticalNormalizedPosition = Mathf.Clamp(var_13_3, 0, 1)

	ManufactureController.instance:clickSlotItem(arg_13_1, nil, true, true, nil, arg_13_2)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._scrollHeight = recthelper.getHeight(arg_14_0._goscrollbuilding:GetComponent(gohelper.Type_RectTransform))
	arg_14_0._buildingItemHeight = recthelper.getHeight(arg_14_0._gobuildingItem:GetComponent(gohelper.Type_RectTransform))
	arg_14_0._contentRect = arg_14_0._gobuildingContent:GetComponent(gohelper.Type_RectTransform)
	arg_14_0._layoutSpace = arg_14_0._gobuildingContent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup)).spacing

	arg_14_0:clearVar()
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_setBuildingList()
	arg_16_0:everySecondCall()
	arg_16_0:refreshPopBlock()
	TaskDispatcher.runRepeat(arg_16_0.everySecondCall, arg_16_0, TimeUtil.OneSecond)
end

function var_0_0._setBuildingList(arg_17_0)
	arg_17_0._overBuildingItemDict = {}

	local var_17_0 = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	gohelper.CreateObjList(arg_17_0, arg_17_0._onSetBuildingItem, var_17_0, arg_17_0._gobuildingContent, arg_17_0._gobuildingItem, RoomManufactureOverBuildingItem)
end

function var_0_0._onSetBuildingItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1:setData(arg_18_2, arg_18_3, arg_18_0)

	arg_18_0._overBuildingItemDict[arg_18_2.uid] = arg_18_1
end

function var_0_0._setAddPopItems(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 and arg_19_0._addPopBuildingUid == arg_19_1 then
		return
	end

	ManufactureController.instance:setManufactureFormulaItemList(arg_19_1)

	arg_19_0._addPopBuildingUid = arg_19_1
end

function var_0_0.setViewBuildingUid(arg_20_0, arg_20_1)
	arg_20_0.viewContainer:setContainerViewBuildingUid(arg_20_1)
end

function var_0_0.closePopView(arg_21_0)
	ManufactureController.instance:clearSelectedSlotItem()
	ManufactureController.instance:clearSelectCritterSlotItem()
	ManufactureController.instance:closeWrongTipView()
end

function var_0_0.refreshPopBlock(arg_22_0)
	gohelper.setActive(arg_22_0._btnpopBlock, false)

	for iter_22_0, iter_22_1 in ipairs(var_0_1) do
		if ViewMgr.instance:isOpen(iter_22_1) then
			gohelper.setActive(arg_22_0._btnpopBlock, true)

			break
		end
	end
end

function var_0_0.everySecondCall(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._overBuildingItemDict) do
		iter_23_1:everySecondCall()
	end
end

function var_0_0.clearVar(arg_24_0)
	arg_24_0._addPopBuildingUid = nil
end

function var_0_0._onGuideFocusCritter(arg_25_0, arg_25_1)
	local var_25_0 = 294 * arg_25_1 - 807

	recthelper.setAnchorY(arg_25_0._gobuildingContent.transform, math.max(var_25_0, 0))
end

function var_0_0.onClose(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.everySecondCall, arg_26_0)
	arg_26_0:closePopView()
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0:clearVar()
end

return var_0_0
