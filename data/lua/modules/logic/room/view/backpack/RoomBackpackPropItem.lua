module("modules.logic.room.view.backpack.RoomBackpackPropItem", package.seeall)

local var_0_0 = class("RoomBackpackPropItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imgquality = gohelper.findChildImage(arg_1_0.viewGO, "#image_quality")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_1_0._goicon)

	local var_1_0 = arg_1_0._itemIcon:getCountBg()
	local var_1_1 = arg_1_0._itemIcon:getCount()
	local var_1_2 = var_1_0.transform
	local var_1_3 = var_1_1.transform

	recthelper.setAnchorY(var_1_2, RoomManufactureEnum.ItemCountBgY)
	recthelper.setAnchorY(var_1_3, RoomManufactureEnum.ItemCountY)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0._itemIcon:setMOValue(arg_4_0._mo.type, arg_4_0._mo.id, arg_4_0._mo.quantity)
	arg_4_0._itemIcon:isShowQuality(false)
	arg_4_0._itemIcon:isShowName(false)

	local var_4_0 = arg_4_0._itemIcon:getRare()
	local var_4_1 = RoomManufactureEnum.RareImageMap[var_4_0]

	UISpriteSetMgr.instance:setCritterSprite(arg_4_0._imgquality, var_4_1)
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

return var_0_0
