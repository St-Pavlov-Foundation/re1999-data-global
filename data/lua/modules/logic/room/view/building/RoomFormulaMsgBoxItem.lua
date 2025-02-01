module("modules.logic.room.view.building.RoomFormulaMsgBoxItem", package.seeall)

slot0 = class("RoomFormulaMsgBoxItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._imagerare = gohelper.findChildImage(slot0._go, "#image_rare")
	slot0._simageproduceitem = gohelper.findChildSingleImage(slot0._go, "#simage_produceitem")
	slot0._txtNum = gohelper.findChildText(slot0._go, "image_NumBG/#txt_Num")
end

function slot0.onUpdateMO(slot0, slot1)
	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot1.type, slot1.id)

	slot0._simageproduceitem:LoadImage(slot3)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, "bg_wupindi_" .. tostring(ItemEnum.Color[slot2.rare]))

	slot0._txtNum.text = luaLang("multiple") .. tostring(GameUtil.numberDisplay(slot1.quantity))
end

return slot0
