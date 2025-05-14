module("modules.logic.store.view.RoomStoreGoodsItem", package.seeall)

local var_0_0 = class("RoomStoreGoodsItem", NormalStoreGoodsItem)
local var_0_1 = {
	MaterialEnum.MaterialType.Equip,
	MaterialEnum.MaterialType.Item
}

function var_0_0.onUpdateMO(arg_1_0, arg_1_1)
	var_0_0.super.onUpdateMO(arg_1_0, arg_1_1)
end

function var_0_0.refreshRare(arg_2_0)
	local var_2_0 = false
	local var_2_1 = {}

	var_2_1.anchorX = -9.5
	var_2_1.anchorY = -2
	var_2_1.width = 354.5
	var_2_1.height = 280

	if arg_2_0._mo:getIsActGoods() then
		UISpriteSetMgr.instance:setStoreGoodsSprite(arg_2_0._rare, FurnaceTreasureEnum.RareBgName)

		var_2_0 = true
	elseif arg_2_0.itemConfig then
		if arg_2_0.itemConfig.subType == 23 then
			arg_2_0:_setSpecialBg(var_2_1)

			var_2_0 = true
		else
			UISpriteSetMgr.instance:setStoreGoodsSprite(arg_2_0._rare, "rare" .. arg_2_0.itemConfig.rare)

			var_2_0 = true
		end
	end

	recthelper.setAnchor(arg_2_0._rare.transform, var_2_1.anchorX, var_2_1.anchorY)
	recthelper.setWidth(arg_2_0._rare.transform, var_2_1.width)
	recthelper.setHeight(arg_2_0._rare.transform, var_2_1.height)
	gohelper.setActive(arg_2_0._rare.gameObject, var_2_0)
end

function var_0_0._setSpecialBg(arg_3_0, arg_3_1)
	UISpriteSetMgr.instance:setRoomSprite(arg_3_0._rare, "room_qualityframe_" .. arg_3_0.itemConfig.rare)

	arg_3_1.anchorX = 4.5
	arg_3_1.anchorY = 29
	arg_3_1.width = 335
	arg_3_1.height = 310
end

return var_0_0
