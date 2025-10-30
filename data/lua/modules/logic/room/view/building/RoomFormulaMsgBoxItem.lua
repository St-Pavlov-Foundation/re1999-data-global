module("modules.logic.room.view.building.RoomFormulaMsgBoxItem", package.seeall)

local var_0_0 = class("RoomFormulaMsgBoxItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._go, "#image_rare")
	arg_1_0._simageproduceitem = gohelper.findChildSingleImage(arg_1_0._go, "#simage_produceitem")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0._go, "image_NumBG/#txt_Num")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	local var_2_0, var_2_1 = ItemModel.instance:getItemConfigAndIcon(arg_2_1.type, arg_2_1.id)

	arg_2_0._simageproduceitem:LoadImage(var_2_1)
	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._imagerare, "bg_wupindi_" .. tostring(ItemEnum.Color[var_2_0.rare]))

	local var_2_2 = GameUtil.numberDisplay(arg_2_1.quantity)

	arg_2_0._txtNum.text = luaLang("multiple") .. tostring(var_2_2)
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0._simageproduceitem:UnLoadImage()
end

return var_0_0
