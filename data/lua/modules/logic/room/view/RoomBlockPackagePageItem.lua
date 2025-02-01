module("modules.logic.room.view.RoomBlockPackagePageItem", package.seeall)

slot0 = class("RoomBlockPackagePageItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goselect = gohelper.findChild(slot0._go, "go_select")
	slot0._goitem = gohelper.findChild(slot0._go, "image")
end

function slot0.getGO(slot0)
	return slot0._go
end

function slot0.setShowIcon(slot0, slot1)
	slot0._isShowIcon = slot1

	gohelper.setActive(slot0._imageIcon.gameObject, slot1 and true or false)
end

function slot0.setSelect(slot0, slot1)
	slot0._isSelect = slot1

	gohelper.setActive(slot0._goselect, slot1 and true or false)
end

function slot0.beforeDestroy(slot0)
	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._go, true)
end

return slot0
