module("modules.logic.room.view.record.RoomCritterHandBookBackItem", package.seeall)

slot0 = class("RoomCritterHandBookBackItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simageitem = gohelper.findChildSingleImage(slot0.viewGO, "#simage_item")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._gouse = gohelper.findChild(slot0.viewGO, "#go_use")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_normal/#go_new")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gonoraml = gohelper.findChild(slot0.viewGO, "#go_normal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshUse, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshUse, slot0)
end

function slot0._btnclickOnClick(slot0)
	slot0._view:selectCell(slot0._index, true)
	RoomHandBookBackModel.instance:setSelectMo(slot0._mo)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.refreshBack)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._id = slot1.id
	slot0._config = slot1:getConfig()
	slot0._isuse = slot1:checkIsUse()
	slot0._isEmpty = slot1:isEmpty()

	gohelper.setActive(slot0._goempty, slot0._isEmpty)
	gohelper.setActive(slot0._gonoraml, not slot0._isEmpty)
	gohelper.setActive(slot0._gouse, slot0._isuse)
	gohelper.setActive(slot0._gonew, slot1:checkNew())
	gohelper.setActive(slot0._simageitem.gameObject, not slot0._isEmpty)

	if not slot0._isEmpty then
		slot0._simageitem:LoadImage(ResUrl.getPropItemIcon(slot0._config.icon))
	end
end

function slot0.refreshUse(slot0)
	slot0._isuse = slot0._mo:checkIsUse()

	gohelper.setActive(slot0._gouse, slot0._isuse)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
