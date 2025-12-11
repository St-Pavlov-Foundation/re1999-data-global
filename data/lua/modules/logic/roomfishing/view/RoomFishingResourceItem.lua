module("modules.logic.roomfishing.view.RoomFishingResourceItem", package.seeall)

local var_0_0 = class("RoomFishingResourceItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageItemBG = gohelper.findChildImage(arg_1_0.viewGO, "#image_ItemBG")
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Prop")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Num/#txt_Num")
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.click:RemoveClickListener()
end

function var_0_0._onClick(arg_4_0)
	if not arg_4_0._canClick then
		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_4_0._mo.type, arg_4_0._mo.id)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:refreshItemInfo()
end

function var_0_0.setCanClick(arg_6_0, arg_6_1)
	arg_6_0._canClick = arg_6_1
end

function var_0_0.refreshItemInfo(arg_7_0)
	UISpriteSetMgr.instance:setRoomSprite(arg_7_0._imageItemBG, "roomfish_itemqualitybg" .. CharacterEnum.Color[arg_7_0._mo.rare])

	local var_7_0, var_7_1 = ItemModel.instance:getItemConfigAndIcon(arg_7_0._mo.type, arg_7_0._mo.id)

	if not string.nilorempty(var_7_1) then
		arg_7_0._simageProp:LoadImage(var_7_1)
	end

	arg_7_0._txtNum.text = GameUtil.numberDisplay(arg_7_0._mo.quantity)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simageProp:UnLoadImage()
end

return var_0_0
