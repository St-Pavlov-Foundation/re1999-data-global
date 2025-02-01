module("modules.logic.room.view.RoomBlockPackageSimpleItem", package.seeall)

slot0 = class("RoomBlockPackageSimpleItem", RoomBlockPackageItem)

function slot0._editableInitView(slot0)
	slot0._go = slot0.viewGO
	slot0._goitem = gohelper.findChild(slot0.viewGO, "item")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "item/image_rare/bottom/txt_num")
	slot0._txtdegree = gohelper.findChildText(slot0.viewGO, "item/image_rare/bottom/txt_degree")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "item/image_rare")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "item/image_rare/txt_name")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "item/image_rare/go_reddot")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "item/image_rare/go_select")
	slot0._btnItem = gohelper.findChildButtonWithAudio(slot0.viewGO, "item")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "item/image_rare/bottom/go_empty")
	slot0._simagedegree = gohelper.findChildImage(slot0.viewGO, "item/image_rare/bottom/txt_degree/icon")

	slot0._btnItem:AddClickListener(slot0._btnitemOnClick, slot0)
	UISpriteSetMgr.instance:setRoomSprite(slot0._simagedegree, "jianshezhi")
	slot0:_onInit(slot0.viewGO)
end

function slot0._onInit(slot0, slot1)
	gohelper.setActive(slot0._goselect, false)
end

function slot0._onRefreshUI(slot0)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBlockPackageEnum.RareIcon[slot0._packageCfg.rare] or RoomBlockPackageEnum.RareIcon[1])
end

function slot0._onSelectUI(slot0)
end

return slot0
