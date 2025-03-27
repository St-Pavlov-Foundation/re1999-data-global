module("modules.logic.rouge.view.RougeDLCSelectListItem", package.seeall)

slot0 = class("RougeDLCSelectListItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._goselectedequip = gohelper.findChild(slot0.viewGO, "go_info/go_selected_equip")
	slot0._gounselectequip = gohelper.findChild(slot0.viewGO, "go_info/go_unselect_equip")
	slot0._goselectedunequip = gohelper.findChild(slot0.viewGO, "go_info/go_selected_unequip")
	slot0._gounselectunequip = gohelper.findChild(slot0.viewGO, "go_info/go_unselect_unequip")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_info/btn_click")
	slot0._txtsekectedequip = gohelper.findChildText(slot0.viewGO, "go_info/go_selected_equip/txt_title")
	slot0._txtunselectequip = gohelper.findChildText(slot0.viewGO, "go_info/go_unselect_equip/txt_title")
	slot0._txtselectedunequip = gohelper.findChildText(slot0.viewGO, "go_info/go_selected_unequip/txt_title")
	slot0._txtunselectunequip = gohelper.findChildText(slot0.viewGO, "go_info/go_unselect_unequip/txt_title")
	slot0._txtsekectedequipen = gohelper.findChildText(slot0.viewGO, "go_info/go_selected_equip/en")
	slot0._txtunselectequipen = gohelper.findChildText(slot0.viewGO, "go_info/go_unselect_equip/en")
	slot0._txtselectedunequipen = gohelper.findChildText(slot0.viewGO, "go_info/go_selected_unequip/en")
	slot0._txtunselectunequipen = gohelper.findChildText(slot0.viewGO, "go_info/go_unselect_unequip/en")
	slot0._golater = gohelper.findChild(slot0.viewGO, "go_later")
	slot0._goequipedeffect = gohelper.findChild(slot0.viewGO, "go_info/go_selected_equip/click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	RougeDLCSelectListModel.instance:selectCell(slot0._index)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeDLCController.instance, RougeEvent.OnSelectDLC, slot0._onSelectDLC, slot0)
	slot0:addEventCb(RougeDLCController.instance, RougeEvent.OnGetVersionInfo, slot0._onGetVersionInfo, slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txtsekectedequip.text = slot0._mo.name
	slot0._txtunselectequip.text = slot0._mo.name
	slot0._txtselectedunequip.text = slot0._mo.name
	slot0._txtunselectunequip.text = slot0._mo.name
	slot0._txtsekectedequipen.text = slot0._mo.enName
	slot0._txtunselectequipen.text = slot0._mo.enName
	slot0._txtselectedunequipen.text = slot0._mo.enName
	slot0._txtunselectunequipen.text = slot0._mo.enName
	slot0._isSelect = RougeDLCSelectListModel.instance:getCurSelectIndex() == slot0._index
	slot0._isEquiped = RougeDLCSelectListModel.instance:isAddDLC(slot0._mo.id)

	slot0:setSelectUI()
	slot0:setLaterFlagVisible()
end

function slot0._onSelectDLC(slot0, slot1)
	slot2 = slot0._mo and slot0._mo.id == slot1
	slot0._isSelect = slot2

	if slot2 or slot0._isSelect then
		slot0:setSelectUI()
	end
end

function slot0._onGetVersionInfo(slot0)
	slot0:setSelectUI()
end

function slot0.setSelectUI(slot0)
	slot1 = RougeDLCSelectListModel.instance:isAddDLC(slot0._mo.id)

	gohelper.setActive(slot0._goselectedequip, slot0._isSelect and slot1)
	gohelper.setActive(slot0._gounselectequip, not slot0._isSelect and slot1)
	gohelper.setActive(slot0._goselectedunequip, slot0._isSelect and not slot1)
	gohelper.setActive(slot0._gounselectunequip, not slot0._isSelect and not slot1)
	gohelper.setActive(slot0._goequipedeffect, slot0._isEquiped ~= slot1 and slot1)
	slot0:setTabIcon(slot0._goselectedequip, true, true)
	slot0:setTabIcon(slot0._gounselectequip, false, true)
	slot0:setTabIcon(slot0._goselectedunequip, true, false)
	slot0:setTabIcon(slot0._gounselectunequip, false, false)

	slot0._isEquiped = slot1
end

function slot0.setTabIcon(slot0, slot1, slot2, slot3)
	if not gohelper.findChildImage(slot1, "icon") then
		return
	end

	slot6 = ""

	UISpriteSetMgr.instance:setRouge4Sprite(slot4, string.format("rouge_dlc%s_leftlogo", slot0._mo.id) .. (slot2 and (slot3 and "1" or "2") or slot3 and "2" or "3"))
end

function slot0.setLaterFlagVisible(slot0)
	gohelper.setActive(slot0._golater, RougeDLCSelectListModel.instance:getCount() <= slot0._index)
end

function slot0.onDestroyView(slot0)
end

return slot0
