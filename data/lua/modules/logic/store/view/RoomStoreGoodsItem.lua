module("modules.logic.store.view.RoomStoreGoodsItem", package.seeall)

slot0 = class("RoomStoreGoodsItem", NormalStoreGoodsItem)
slot1 = {
	MaterialEnum.MaterialType.Equip,
	MaterialEnum.MaterialType.Item
}

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
end

function slot0.refreshRare(slot0)
	slot1 = false
	slot2 = {
		anchorX = -9.5,
		anchorY = -2,
		width = 354.5,
		height = 280
	}

	if slot0._mo:getIsActGoods() then
		UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._rare, FurnaceTreasureEnum.RareBgName)

		slot1 = true
	elseif slot0.itemConfig then
		if slot0.itemConfig.subType == 23 then
			slot0:_setSpecialBg(slot2)

			slot1 = true
		else
			UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._rare, "rare" .. slot0.itemConfig.rare)

			slot1 = true
		end
	end

	recthelper.setAnchor(slot0._rare.transform, slot2.anchorX, slot2.anchorY)
	recthelper.setWidth(slot0._rare.transform, slot2.width)
	recthelper.setHeight(slot0._rare.transform, slot2.height)
	gohelper.setActive(slot0._rare.gameObject, slot1)
end

function slot0._setSpecialBg(slot0, slot1)
	UISpriteSetMgr.instance:setRoomSprite(slot0._rare, "room_qualityframe_" .. slot0.itemConfig.rare)

	slot1.anchorX = 4.5
	slot1.anchorY = 29
	slot1.width = 335
	slot1.height = 310
end

return slot0
