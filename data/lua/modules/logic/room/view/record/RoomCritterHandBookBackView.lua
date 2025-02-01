module("modules.logic.room.view.record.RoomCritterHandBookBackView", package.seeall)

slot0 = class("RoomCritterHandBookBackView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "bg/#scroll_view")
	slot0._simageback = gohelper.findChildSingleImage(slot0.viewGO, "bg/#go_show/#simage_back")
	slot0._simageutm = gohelper.findChildSingleImage(slot0.viewGO, "bg/#go_show/#simage_utm")
	slot0._gobackicon = gohelper.findChild(slot0.viewGO, "bg/#go_show/#simage_back/icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "bg/#go_show/#txt_name")
	slot0._gouse = gohelper.findChild(slot0.viewGO, "bg/#go_use")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "bg/#go_empty")
	slot0._goshow = gohelper.findChild(slot0.viewGO, "bg/#go_show")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_confirm")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_close")
	slot0._btnempty = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/maskbg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "bg/txt_title")
	slot0._scrollview = slot0.viewContainer:getScrollView()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnempty:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnempty:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshUI, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmOnClick(slot0)
	CritterRpc.instance:sendSetCritterBookBackgroundRequest(RoomHandBookModel.instance:getSelectMo().id, RoomHandBookBackModel.instance:getSelectMo():isEmpty() and 0 or slot2.id)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.updateView(slot0, slot1)
	slot2 = slot1.id
	slot3 = slot1.backgroundId
end

function slot0.onOpen(slot0)
	RoomHandBookBackListModel.instance:init()
	slot0:refreshUI()
	slot0._scrollview:selectCell(RoomHandBookBackListModel.instance:getSelectIndex(), true)
end

function slot0.refreshUI(slot0)
	slot2 = RoomHandBookBackModel.instance:getSelectMo() and slot1:isEmpty()

	gohelper.setActive(slot0._goempty, slot2)
	gohelper.setActive(slot0._goshow, not slot2)

	if slot1 and not slot1:isEmpty() then
		gohelper.setActive(slot0._gobackicon, false)
		slot0._simageutm:LoadImage(ResUrl.getPropItemIcon(slot1:getConfig().icon))

		slot0._txtname.text = slot1:getConfig().name
	else
		gohelper.setActive(slot0._gobackicon, true)
	end

	if RoomHandBookModel.instance:getSelectMo() then
		slot0._txttitle.text = string.format(luaLang("critterhandbookbacktitle"), slot3:getConfig().name)
	end

	slot4 = slot1:checkIsUse()

	gohelper.setActive(slot0._gouse, slot4)
	gohelper.setActive(slot0._btnconfirm.gameObject, not slot4)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
