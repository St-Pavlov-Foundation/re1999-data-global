module("modules.logic.room.view.manufacture.RoomOneKeyAddPopView", package.seeall)

slot0 = class("RoomOneKeyAddPopView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "right/#go_addPop/#txt_title")
	slot0._btncloseAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_addPop/#btn_closeAdd")
	slot0._gotabparent = gohelper.findChild(slot0.viewGO, "right/#go_addPop/#go_tabList")
	slot0._gotabitem = gohelper.findChild(slot0.viewGO, "right/#go_addPop/#go_tabList/#go_tabItem")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_addPop/#go_num/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_addPop/#go_num/#btn_sub")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "right/#go_addPop/#go_num/valuebg/#input_value")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_addPop/#go_num/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_addPop/#go_num/#btn_max")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseAdd:AddClickListener(slot0._btncloseAddOnClick, slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._inputvalue:AddOnValueChanged(slot0._onInputValueChange, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, slot0.refreshCount, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0, LuaEventSystem.High)
end

function slot0.removeEvents(slot0)
	slot0._btncloseAdd:RemoveClickListener()
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._inputvalue:RemoveOnValueChanged()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, slot0.refreshCount, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)

	if slot0.tabItemList then
		for slot4, slot5 in ipairs(slot0.tabItemList) do
			slot5.click:RemoveClickListener()
		end
	end
end

function slot0._btncloseAddOnClick(slot0)
	slot0.viewContainer:oneKeyViewSetAddPopActive(false)
end

function slot0._tabItemOnClick(slot0, slot1)
	if slot0._selectTabIndex == slot1 then
		return
	end

	if not (slot0.tabItemList and slot0.tabItemList[slot1]) then
		return
	end

	if slot0.tabItemList[slot0._selectTabIndex] then
		gohelper.setActive(slot3.goSelected, false)
		gohelper.setActive(slot3.goUnselected, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot3.icon, "#5C5B5A")
	end

	gohelper.setActive(slot2.goSelected, true)
	gohelper.setActive(slot2.goUnselected, false)
	SLFramework.UGUI.GuiHelper.SetColor(slot2.icon, "#BB693D")

	slot0._selectTabIndex = slot1
	slot0._txttitle.text = RoomMapBuildingModel.instance:getBuildingMOById(slot2.idList[1]) and slot4.config.useDesc or ""

	OneKeyAddPopListModel.instance:setOneKeyFormulaItemList(slot2.idList)
end

function slot0._btnminOnClick(slot0)
	slot0:changeCount(OneKeyAddPopListModel.MINI_COUNT)
end

function slot0._btnsubOnClick(slot0)
	slot1, slot2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	slot0:changeCount(slot2 - 1)
end

function slot0._onInputValueChange(slot0, slot1)
	slot0:changeCount(tonumber(slot1))
end

function slot0._btnaddOnClick(slot0)
	slot1, slot2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	slot0:changeCount(slot2 + 1)
end

function slot0._btnmaxOnClick(slot0)
	slot0:changeCount(ManufactureModel.instance:getMaxCanProductCount(OneKeyAddPopListModel.instance:getSelectedManufactureItem()))
end

function slot0.changeCount(slot0, slot1)
	if not OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
		GameFacade.showToast(ToastEnum.RoomNotSelectedManufactureItem)

		return
	end

	ManufactureController.instance:oneKeySelectCustomManufactureItem(slot2, Mathf.Clamp(slot1 or OneKeyAddPopListModel.MINI_COUNT, OneKeyAddPopListModel.MINI_COUNT, ManufactureModel.instance:getMaxCanProductCount(slot2)), true)
end

function slot0._onItemChanged(slot0)
	ManufactureController.instance:updateTraceNeedItemDict()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btncloseAdd, false)
	ManufactureController.instance:updateTraceNeedItemDict()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initTab()
	slot0:_tabItemOnClick(slot0:getDefaultTabIndex())
	slot0:refreshCount()
end

function slot0.getDefaultTabIndex(slot0)
	if not OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
		return uv0
	end

	slot3 = {
		[slot8] = true
	}

	for slot7, slot8 in ipairs(ManufactureConfig.instance:getManufactureItemBelongBuildingList(slot1)) do
		-- Nothing
	end

	for slot7, slot8 in ipairs(slot0.tabItemList) do
		for slot12, slot13 in ipairs(slot8.idList) do
			if RoomMapBuildingModel.instance:getBuildingMOById(slot13) and slot3[slot14.buildingId] then
				return slot7
			end
		end
	end

	return uv0
end

function slot0.initTab(slot0)
	if slot0.tabItemList then
		for slot4, slot5 in ipairs(slot0.tabItemList) do
			slot5.click:removeClickListener()
		end
	end

	slot0.tabItemList = {}

	gohelper.CreateObjList(slot0, slot0.onSetTabItem, OneKeyAddPopListModel.instance:getTabDataList(), slot0._gotabparent, slot0._gotabitem)
end

function slot0.onSetTabItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.idList = slot2
	slot4.icon = gohelper.findChildImage(slot1, "#simage_icon")
	slot4.goSelected = gohelper.findChild(slot1, "#go_selected")
	slot4.goUnselected = gohelper.findChild(slot1, "#go_unselected")
	slot4.click = gohelper.findChildClickWithDefaultAudio(slot1, "#btn_click")

	slot4.click:AddClickListener(slot0._tabItemOnClick, slot0, slot3)

	slot5 = nil

	if RoomMapBuildingModel.instance:getBuildingMOById(slot4.idList[1]) then
		slot5 = (#slot4.idList <= 1 or RoomConfig.instance:getBuildingTypeIcon(RoomConfig.instance:getBuildingType(slot6.buildingId))) and ManufactureConfig.instance:getManufactureBuildingIcon(slot7)
	end

	UISpriteSetMgr.instance:setRoomSprite(slot4.icon, slot5)

	slot0.tabItemList[slot3] = slot4
end

function slot0.refreshCount(slot0)
	slot1, slot2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	slot0._inputvalue:SetTextWithoutNotify(tostring(slot2))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
