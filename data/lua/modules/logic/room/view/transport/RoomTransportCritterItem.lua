module("modules.logic.room.view.transport.RoomTransportCritterItem", package.seeall)

slot0 = class("RoomTransportCritterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_content/#go_icon")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_content/#go_info")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_content/#go_info/#txt_name")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "#go_content/#go_info/#go_skill")
	slot0._simageskill = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#go_info/#go_skill/#simage_skill")
	slot0._golayoutAttr = gohelper.findChild(slot0.viewGO, "#go_content/#go_info/#go_layoutAttr")
	slot0._goattrItem = gohelper.findChild(slot0.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem")
	slot0._txtattrValue = gohelper.findChildText(slot0.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem/#txt_attrValue")
	slot0._simageattrIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem/#simage_attrIcon")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_content/#go_selected")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_click")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_detail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo and slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.TransportCritterSelect, slot0._mo)
	end
end

function slot0._btndetailOnClick(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot1 = slot0._mo:getId()
	slot2 = slot0._mo:getDefineId()
	slot3 = slot0._mo:getDefineCfg()

	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goicon)
	end

	slot0.critterIcon:setMOValue(slot1, slot2)

	slot0._txtname.text = slot3.name
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

slot0.prefabPath = "ui/viewres/room/transport/roomtransportcritteritem.prefab"

return slot0
