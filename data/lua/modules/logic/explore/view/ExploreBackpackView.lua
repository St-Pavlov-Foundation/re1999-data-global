module("modules.logic.explore.view.ExploreBackpackView", package.seeall)

slot0 = class("ExploreBackpackView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gohasprop = gohelper.findChild(slot0.viewGO, "#go_hasprop")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")
	slot0._propcontent = gohelper.findChild(slot0.viewGO, "mask/#scroll_prop/viewport/propcontent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnItemChange, slot0._updateItem, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorItemSelect, slot0.OnItemKeyDown, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnItemChange, slot0._updateItem, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorItemSelect, slot0.OnItemKeyDown, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.itemList = {}
end

function slot0.onOpen(slot0)
	slot0:_updateItem()
end

function slot0._updateItem(slot0)
	for slot6, slot7 in ipairs(ExploreBackpackModel.instance:getList()) do
		if slot0.itemList[slot6] == nil then
			slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._propcontent, "item"), ExploreBackpackPropListItem)
		end

		gohelper.setActive(slot8.go, true)
		slot8:onUpdateMO(slot7)

		slot0.itemList[slot6] = slot8

		PCInputController.instance:showkeyTips(gohelper.findChild(slot8.go, "#go_pcbtn"), PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.Item1 + slot6 - 1)
	end

	for slot6 = #slot1 + 1, #slot0.itemList do
		gohelper.setActive(slot0.itemList[slot6].go, false)
	end

	gohelper.setActive(slot0._goempty, #slot1 == 0)
	gohelper.setActive(slot0._gohasprop, #slot1 > 0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:onDestroyView()
	end

	slot0.itemList = nil
end

function slot0.OnItemKeyDown(slot0, slot1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	if slot0.itemList[slot1] then
		slot0.itemList[slot1]:_onItemClick()
	end
end

return slot0
