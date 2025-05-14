module("modules.logic.store.view.optionalcharge.OptionalChargeItem", package.seeall)

local var_0_0 = class("OptionalChargeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imageQuality = gohelper.findChildImage(arg_1_1, "#img_Quality")
	arg_1_0._simageItem = gohelper.findChildSingleImage(arg_1_1, "#simage_Item")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_1, "image_NumBG/#txt_Num")
	arg_1_0._txtItemName = gohelper.findChildText(arg_1_1, "#txt_ItemName")
	arg_1_0.goSelected = gohelper.findChild(arg_1_1, "#go_Selected")
	arg_1_0.click = gohelper.findChildClick(arg_1_1, "click")
	arg_1_0.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(arg_1_1, "click")

	arg_1_0.longPress:SetLongPressTime({
		0.5,
		99999
	})
	arg_1_0:refreshSelect()
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.click:AddClickListener(arg_2_0._onClickItem, arg_2_0)
	arg_2_0.longPress:AddLongPressListener(arg_2_0._onClickInfo, arg_2_0)
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0.click:RemoveClickListener()
	arg_3_0.longPress:RemoveLongPressListener()

	if arg_3_0._simageItem then
		arg_3_0._simageItem:UnLoadImage()
	end
end

function var_0_0.setValue(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0.itemStr = arg_4_1
	arg_4_0.itemArr = string.splitToNumber(arg_4_1, "#")
	arg_4_0.clickCallback = arg_4_2
	arg_4_0.view = arg_4_3
	arg_4_0.areaIndex = arg_4_4
	arg_4_0.index = arg_4_5

	local var_4_0, var_4_1 = ItemModel.instance:getItemConfigAndIcon(arg_4_0.itemArr[1], arg_4_0.itemArr[2])

	UISpriteSetMgr.instance:setOptionalGiftSprite(arg_4_0._imageQuality, "bg_pinjidi_" .. var_4_0.rare)
	arg_4_0._simageItem:LoadImage(var_4_1)

	arg_4_0._txtNum.text = GameUtil.numberDisplay(arg_4_0.itemArr[3])
	arg_4_0._txtItemName.text = var_4_0.name
end

function var_0_0.refreshSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.goSelected, arg_5_1)
end

function var_0_0._onClickInfo(arg_6_0)
	MaterialTipController.instance:showMaterialInfo(arg_6_0.itemArr[1], arg_6_0.itemArr[2], false, nil, nil, nil, nil, nil, nil, arg_6_0.view.closeThis, arg_6_0.view)
end

function var_0_0._onClickItem(arg_7_0)
	if arg_7_0.clickCallback then
		arg_7_0.clickCallback(arg_7_0.view, arg_7_0.areaIndex, arg_7_0.index)
	end
end

return var_0_0
