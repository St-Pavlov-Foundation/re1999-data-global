module("modules.logic.room.view.backpack.RoomBackpackPropItem", package.seeall)

slot0 = class("RoomBackpackPropItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imgquality = gohelper.findChildImage(slot0.viewGO, "#image_quality")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._goicon)

	recthelper.setAnchorY(slot0._itemIcon:getCountBg().transform, RoomManufactureEnum.ItemCountBgY)
	recthelper.setAnchorY(slot0._itemIcon:getCount().transform, RoomManufactureEnum.ItemCountY)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._itemIcon:setMOValue(slot0._mo.type, slot0._mo.id, slot0._mo.quantity)
	slot0._itemIcon:isShowQuality(false)
	slot0._itemIcon:isShowName(false)
	UISpriteSetMgr.instance:setCritterSprite(slot0._imgquality, RoomManufactureEnum.RareImageMap[slot0._itemIcon:getRare()])
end

function slot0.onDestroyView(slot0)
end

return slot0
