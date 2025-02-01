module("modules.logic.room.view.common.RoomStoreGoodsTipItem", package.seeall)

slot0 = class("RoomStoreGoodsTipItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goeprice = gohelper.findChild(slot0.viewGO, "go_price")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "go_finish")
	slot0._txtgold = gohelper.findChildText(slot0.viewGO, "go_price/txt_gold")
	slot0._imagegold = gohelper.findChildImage(slot0.viewGO, "go_price/node/image_gold")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "txt_num")
	slot0._imgbg = slot0.viewGO:GetComponent(gohelper.Type_Image)
	slot0._txtowner = gohelper.findChildText(slot0.viewGO, "go_finish/txt_owner")
	slot0._parenttrs = slot0.viewGO.transform.parent
end

function slot0._refreshUI(slot0)
	slot3 = slot0._roomStoreItemMO:getNeedNum() <= slot0._roomStoreItemMO:getItemQuantity()

	gohelper.setActive(slot0._goeprice, not slot3)
	gohelper.setActive(slot0._gofinish, slot3)

	if slot3 then
		slot0._txtowner.text = string.format(luaLang("roommaterialtipview_owner"), tostring(slot1))
	end

	slot0._txtname.text = slot0._roomStoreItemMO:getItemConfig() and slot4.name or ""
	slot0._txtnum.text = slot0:_getStateStr(slot2, slot1)

	if not slot3 then
		slot7 = nil

		if not (not RoomStoreItemListModel.instance:getIsSelectCurrency() and slot0._roomStoreItemMO:checkShowTicket()) then
			slot9 = slot0._roomStoreItemMO:getCostById(RoomStoreItemListModel.instance:getCostId() or 1)
			slot12, slot13 = ItemModel.instance:getItemConfigAndIcon(slot9.itemType, slot9.itemId)
			slot7 = slot12.icon
		else
			slot7 = slot0._roomStoreItemMO:getTicketId()
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagegold, string.format("%s_1", slot7))

		if not slot6 then
			slot0._txtgold.text = slot0._roomStoreItemMO:getTotalPriceByCostId(slot8)
		else
			slot0._txtgold.text = 1
		end
	end
end

function slot0._getStateStr(slot0, slot1, slot2)
	return string.format("%s/%s", slot2, slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._roomStoreItemMO = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
