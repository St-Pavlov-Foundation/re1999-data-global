module("modules.logic.room.view.manufacture.RoomOneKeyAddPopView", package.seeall)

local var_0_0 = class("RoomOneKeyAddPopView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "right/#go_addPop/#txt_title")
	arg_1_0._btncloseAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_addPop/#btn_closeAdd")
	arg_1_0._gotabparent = gohelper.findChild(arg_1_0.viewGO, "right/#go_addPop/#go_tabList")
	arg_1_0._gotabitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_addPop/#go_tabList/#go_tabItem")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_addPop/#go_num/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_addPop/#go_num/#btn_sub")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "right/#go_addPop/#go_num/valuebg/#input_value")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_addPop/#go_num/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_addPop/#go_num/#btn_max")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseAdd:AddClickListener(arg_2_0._btncloseAddOnClick, arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnValueChanged(arg_2_0._onInputValueChange, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, arg_2_0.refreshCount, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0, LuaEventSystem.High)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseAdd:RemoveClickListener()
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnValueChanged()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, arg_3_0.refreshCount, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)

	if arg_3_0.tabItemList then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.tabItemList) do
			iter_3_1.click:RemoveClickListener()
		end
	end
end

function var_0_0._btncloseAddOnClick(arg_4_0)
	arg_4_0.viewContainer:oneKeyViewSetAddPopActive(false)
end

function var_0_0._tabItemOnClick(arg_5_0, arg_5_1)
	if arg_5_0._selectTabIndex == arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0.tabItemList and arg_5_0.tabItemList[arg_5_1]

	if not var_5_0 then
		return
	end

	local var_5_1 = arg_5_0.tabItemList[arg_5_0._selectTabIndex]

	if var_5_1 then
		gohelper.setActive(var_5_1.goSelected, false)
		gohelper.setActive(var_5_1.goUnselected, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_5_1.icon, "#5C5B5A")
	end

	gohelper.setActive(var_5_0.goSelected, true)
	gohelper.setActive(var_5_0.goUnselected, false)
	SLFramework.UGUI.GuiHelper.SetColor(var_5_0.icon, "#BB693D")

	arg_5_0._selectTabIndex = arg_5_1

	local var_5_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_5_0.idList[1])
	local var_5_3 = var_5_2 and var_5_2.config.useDesc or ""

	arg_5_0._txttitle.text = var_5_3

	OneKeyAddPopListModel.instance:setOneKeyFormulaItemList(var_5_0.idList)
end

function var_0_0._btnminOnClick(arg_6_0)
	arg_6_0:changeCount(OneKeyAddPopListModel.MINI_COUNT)
end

function var_0_0._btnsubOnClick(arg_7_0)
	local var_7_0, var_7_1 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	arg_7_0:changeCount(var_7_1 - 1)
end

function var_0_0._onInputValueChange(arg_8_0, arg_8_1)
	arg_8_0:changeCount(tonumber(arg_8_1))
end

function var_0_0._btnaddOnClick(arg_9_0)
	local var_9_0, var_9_1 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	arg_9_0:changeCount(var_9_1 + 1)
end

function var_0_0._btnmaxOnClick(arg_10_0)
	local var_10_0 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()
	local var_10_1 = ManufactureModel.instance:getMaxCanProductCount(var_10_0)

	arg_10_0:changeCount(var_10_1)
end

function var_0_0.changeCount(arg_11_0, arg_11_1)
	local var_11_0 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not var_11_0 then
		GameFacade.showToast(ToastEnum.RoomNotSelectedManufactureItem)

		return
	end

	arg_11_1 = arg_11_1 or OneKeyAddPopListModel.MINI_COUNT

	local var_11_1 = ManufactureModel.instance:getMaxCanProductCount(var_11_0)

	arg_11_1 = Mathf.Clamp(arg_11_1, OneKeyAddPopListModel.MINI_COUNT, var_11_1)

	ManufactureController.instance:oneKeySelectCustomManufactureItem(var_11_0, arg_11_1, true)
end

function var_0_0._onItemChanged(arg_12_0)
	ManufactureController.instance:updateTraceNeedItemDict()
end

function var_0_0._editableInitView(arg_13_0)
	gohelper.setActive(arg_13_0._btncloseAdd, false)
	ManufactureController.instance:updateTraceNeedItemDict()
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:initTab()

	local var_15_0 = arg_15_0:getDefaultTabIndex()

	arg_15_0:_tabItemOnClick(var_15_0)
	arg_15_0:refreshCount()
end

function var_0_0.getDefaultTabIndex(arg_16_0)
	local var_16_0 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not var_16_0 then
		return var_0_1
	end

	local var_16_1 = ManufactureConfig.instance:getManufactureItemBelongBuildingList(var_16_0)
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		var_16_2[iter_16_1] = true
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.tabItemList) do
		for iter_16_4, iter_16_5 in ipairs(iter_16_3.idList) do
			local var_16_3 = RoomMapBuildingModel.instance:getBuildingMOById(iter_16_5)

			if var_16_3 and var_16_2[var_16_3.buildingId] then
				return iter_16_2
			end
		end
	end

	return var_0_1
end

function var_0_0.initTab(arg_17_0)
	if arg_17_0.tabItemList then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0.tabItemList) do
			iter_17_1.click:removeClickListener()
		end
	end

	arg_17_0.tabItemList = {}

	local var_17_0 = OneKeyAddPopListModel.instance:getTabDataList()

	gohelper.CreateObjList(arg_17_0, arg_17_0.onSetTabItem, var_17_0, arg_17_0._gotabparent, arg_17_0._gotabitem)
end

function var_0_0.onSetTabItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:getUserDataTb_()

	var_18_0.go = arg_18_1
	var_18_0.idList = arg_18_2
	var_18_0.icon = gohelper.findChildImage(arg_18_1, "#simage_icon")
	var_18_0.goSelected = gohelper.findChild(arg_18_1, "#go_selected")
	var_18_0.goUnselected = gohelper.findChild(arg_18_1, "#go_unselected")
	var_18_0.click = gohelper.findChildClickWithDefaultAudio(arg_18_1, "#btn_click")

	var_18_0.click:AddClickListener(arg_18_0._tabItemOnClick, arg_18_0, arg_18_3)

	local var_18_1
	local var_18_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_18_0.idList[1])

	if var_18_2 then
		local var_18_3 = var_18_2.buildingId
		local var_18_4 = RoomConfig.instance:getBuildingType(var_18_3)

		if #var_18_0.idList > 1 then
			var_18_1 = RoomConfig.instance:getBuildingTypeIcon(var_18_4)
		else
			var_18_1 = ManufactureConfig.instance:getManufactureBuildingIcon(var_18_3)
		end
	end

	UISpriteSetMgr.instance:setRoomSprite(var_18_0.icon, var_18_1)

	arg_18_0.tabItemList[arg_18_3] = var_18_0
end

function var_0_0.refreshCount(arg_19_0)
	local var_19_0, var_19_1 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	arg_19_0._inputvalue:SetTextWithoutNotify(tostring(var_19_1))
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
