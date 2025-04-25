module("modules.logic.room.view.critter.summon.RoomCritterIncubateItem", package.seeall)

slot0 = class("RoomCritterIncubateItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_name")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_click")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#scroll_base/viewport/content/#go_baseitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	CritterSummonController.instance:registerCallback(CritterSummonEvent.onSelectParentCritter, slot0.refreshSelectParent, slot0)
	CritterSummonController.instance:registerCallback(CritterSummonEvent.onRemoveParentCritter, slot0.refreshSelectParent, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, slot0._onCritterRenameReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnlongPrees:RemoveLongPressListener()
	CritterSummonController.instance:unregisterCallback(CritterSummonEvent.onSelectParentCritter, slot0.refreshSelectParent, slot0)
	CritterSummonController.instance:unregisterCallback(CritterSummonEvent.onRemoveParentCritter, slot0.refreshSelectParent, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterRenameReply, slot0._onCritterRenameReply, slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0.isSelect then
		CritterIncubateModel.instance:removeSelectParentCritter(slot0._uid)
	else
		CritterIncubateModel.instance:addSelectParentCritter(slot0._uid)
	end
end

slot1 = 0.5
slot2 = 99999

function slot0._editableInitView(slot0)
	slot0._btnlongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._btnclick.gameObject)

	slot0._btnlongPrees:SetLongPressTime({
		uv0,
		uv1
	})
	slot0._btnlongPrees:AddLongPressListener(slot0._onLongPress, slot0)
end

function slot0._onLongPress(slot0)
	CritterController.instance:openRoomCritterDetailView(not slot0._mo:isMaturity(), slot0._mo)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._uid = slot0._mo.uid
	slot0._txtname.text = slot1:getName()

	if not slot0._critterIcon then
		slot0._critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goicon)
	end

	slot0._critterIcon:onUpdateMO(slot0._mo)
	slot0._critterIcon:hideMood()
	slot0:showAttr()
	slot0:refreshSelect()

	if next(slot1:getAdditionAttr()) ~= nil then
		slot0._critterIcon:showUpTip()
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0._onCritterRenameReply(slot0, slot1)
	if slot0._mo and slot0._uid == slot1 then
		slot0._txtname.text = slot0._mo:getName()
	end
end

function slot0.showAttr(slot0)
	slot1 = slot0._mo:getAttributeInfos()

	if not slot0._attrItems then
		slot0._attrItems = slot0:getUserDataTb_()
	end

	slot2 = 1

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			slot8 = slot0:getAttrItem(slot2)
			slot9, slot10 = slot0:getAttrRatioColor()

			slot8:setRatioColor(slot9, slot10)
			slot8:onRefreshMo(slot7, slot2)

			slot2 = slot2 + 1
		end
	end

	for slot6 = 1, #slot0._attrItems do
		gohelper.setActive(slot0._attrItems[slot6].viewGO, slot6 < slot2)
	end
end

function slot0.getAttrRatioColor(slot0)
	return "#acacac", "#FFAE46"
end

function slot0.getAttrItem(slot0, slot1)
	if not slot0._attrItems[slot1] then
		slot0._attrItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gobaseitem), RoomCritterDetailAttrItem)
	end

	return slot2
end

function slot0.refreshSelectParent(slot0, slot1, slot2)
	if slot0._uid ~= slot2 then
		return
	end

	slot0:refreshSelect()
end

function slot0.refreshSelect(slot0)
	slot0.isSelect = CritterIncubateModel.instance:isSelectParentCritter(slot0._uid)

	gohelper.setActive(slot0._goselected, slot0.isSelect)
end

return slot0
