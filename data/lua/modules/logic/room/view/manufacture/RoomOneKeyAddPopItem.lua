module("modules.logic.room.view.manufacture.RoomOneKeyAddPopItem", package.seeall)

slot0 = class("RoomOneKeyAddPopItem", RoomManufactureFormulaItem)

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, slot0.refreshSelected, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, slot0.refreshSelected, slot0)
end

function slot0.onClick(slot0)
	slot1 = OneKeyAddPopListModel.MINI_COUNT
	slot2, slot1 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if slot2 == slot0.id then
		-- Nothing
	end

	ManufactureController.instance:oneKeySelectCustomManufactureItem(slot0.id, slot1)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.goselected1 = gohelper.findChild(slot0.viewGO, "#go_needMat/#go_selected")
	slot0.goselected2 = gohelper.findChild(slot0.viewGO, "#go_noMat/#go_selected")

	gohelper.setActive(slot0._txtneedMattime, false)
	gohelper.setActive(slot0._txtnoMattime, false)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:refreshSelected()
end

function slot0.refreshItemName(slot0)
	slot2 = string.split(ManufactureConfig.instance:getManufactureItemName(slot0.id), "*")
	slot0._txtneedMatproductionName.text = slot2[1]
	slot0._txtnoMatproductionName.text = slot2[1]
end

function slot0.refreshItemNum(slot0)
	slot1 = nil
	slot2, slot3 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if slot2 == slot0.id then
		slot6, slot7 = ManufactureConfig.instance:getManufactureItemUnitCountRange(slot0.id)
		slot1 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacture_one_key_add_count"), ManufactureModel.instance:getManufactureItemCount(slot0.id), slot7 * slot3)
	else
		slot1 = formatLuaLang("materialtipview_itemquantity", slot4)
	end

	slot0._txtneedMatnum.text = slot1
	slot0._txtnoMatnum.text = slot1
end

function slot0.refreshTime(slot0)
end

function slot0.refreshSelected(slot0)
	slot2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem() == slot0.id

	slot0:refreshItemNum()
	gohelper.setActive(slot0.goselected1, slot2)
	gohelper.setActive(slot0.goselected2, slot2)
end

return slot0
