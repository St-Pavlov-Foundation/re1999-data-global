module("modules.logic.activity.view.show.ActivityGuestBindViewItem", package.seeall)

slot0 = class("ActivityGuestBindViewItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._item = IconMgr.instance:getCommonPropItemIcon(slot0._goitem)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refresh()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0._refresh(slot0)
	slot2 = slot0._mo.itemCO

	slot0._item:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
end

return slot0
