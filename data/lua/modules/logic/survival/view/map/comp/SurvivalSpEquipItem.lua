module("modules.logic.survival.view.map.comp.SurvivalSpEquipItem", package.seeall)

local var_0_0 = class("SurvivalSpEquipItem", SurvivalEquipItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imageRare = gohelper.findChildImage(arg_1_1, "#go_drag/item/#image_rare")
	arg_1_0._imageIcon = gohelper.findChildSingleImage(arg_1_1, "#go_drag/item/simage_Icon")
	arg_1_0._goEffect6 = gohelper.findChild(arg_1_1, "#go_drag/item/#go_deceffect")
	arg_1_0._goTag = gohelper.findChild(arg_1_1, "#go_drag/item/go_tag")

	var_0_0.super.init(arg_1_0, arg_1_1)
end

function var_0_0.updateItemMo(arg_2_0)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_2_0._imageRare, "survival_bag_itemquality3_" .. arg_2_0.mo.item.co.rare)
	arg_2_0._imageIcon:LoadImage(ResUrl.getSurvivalItemIcon(arg_2_0.mo.item.co.icon))
	gohelper.setActive(arg_2_0._goEffect6, arg_2_0.mo.item.co.rare == 6)
	gohelper.setActive(arg_2_0._goTag, arg_2_0.mo.item.bagReason == 1)
end

return var_0_0
