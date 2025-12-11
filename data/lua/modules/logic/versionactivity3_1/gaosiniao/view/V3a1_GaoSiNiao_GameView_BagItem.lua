module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_BagItem", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_BagItem", V3a1_GaoSiNiao_GameViewDragItemBase)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)

	arg_4_0._mo = {}
end

function var_0_0.addEventListeners(arg_5_0)
	var_0_0.super.addEventListeners(arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	var_0_0.super.removeEventListeners(arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	var_0_0.super.onDestroyView(arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	var_0_0.super._editableInitView(arg_8_0)
	arg_8_0:initDragObj(arg_8_0.viewGO)

	arg_8_0._gocontent = gohelper.findChild(arg_8_0.viewGO, "go_content")
	arg_8_0._imageIcon = gohelper.findChildImage(arg_8_0._gocontent, "image_icon")
	arg_8_0._imageIconTran = arg_8_0._imageIcon.transform
	arg_8_0._txtNum = gohelper.findChildText(arg_8_0._gocontent, "image_NumBG/txt_Num")
end

function var_0_0._setSprite(arg_9_0, arg_9_1)
	arg_9_0:baseViewContainer():setSprite(arg_9_0._imageIcon, arg_9_1)
end

function var_0_0.setData(arg_10_0, arg_10_1)
	var_0_0.super.setData(arg_10_0, arg_10_1)

	local var_10_0 = arg_10_1.count

	arg_10_0:_refreshSprite()
	arg_10_0:setCount(var_10_0)
end

function var_0_0._refreshSprite(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = arg_11_0:getSpriteNamesAndZRot()

	arg_11_0:_setSprite(var_11_0)
	arg_11_0:localRotateZ(var_11_2, arg_11_0._imageIconTran)
end

function var_0_0.getSpriteNamesAndZRot(arg_12_0)
	local var_12_0 = arg_12_0._mo.type
	local var_12_1 = GaoSiNiaoEnum.PathInfo[var_12_0]
	local var_12_2 = var_12_1.spriteId
	local var_12_3 = var_12_1.zRot
	local var_12_4 = GaoSiNiaoConfig.instance:getPathSpriteName(var_12_2)
	local var_12_5 = GaoSiNiaoConfig.instance:getBloodSpriteName(var_12_2)

	return var_12_4, var_12_5, var_12_3
end

function var_0_0.setCount(arg_13_0, arg_13_1)
	arg_13_0._mo.count = arg_13_1

	arg_13_0:setShowCount(arg_13_1)
end

function var_0_0.setShowCount(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 <= 0 and "#DA9390" or "#E3E3E3"

	arg_14_0._txtNum.text = gohelper.getRichColorText(arg_14_1, var_14_0)
end

function var_0_0.getCount(arg_15_0)
	return arg_15_0._mo.count or 0
end

function var_0_0.getType(arg_16_0)
	return arg_16_0._mo.type or GaoSiNiaoEnum.PathType.None
end

function var_0_0.in_ZoneMask(arg_17_0)
	return arg_17_0._mo:in_ZoneMask()
end

function var_0_0.out_ZoneMask(arg_18_0)
	return arg_18_0._mo:out_ZoneMask()
end

function var_0_0._onBeginDrag(arg_19_0, arg_19_1)
	arg_19_0:parent():onBeginDrag_BagItemObj(arg_19_0, arg_19_1)
end

function var_0_0._onDragging(arg_20_0, arg_20_1)
	arg_20_0:parent():onDragging_BagItemObj(arg_20_0, arg_20_1)
end

function var_0_0._onEndDrag(arg_21_0, arg_21_1)
	arg_21_0:parent():onEndDrag_BagItemObj(arg_21_0, arg_21_1)
end

function var_0_0.getDraggingSpriteAndZRot(arg_22_0)
	local var_22_0, var_22_1, var_22_2 = transformhelper.getLocalRotation(arg_22_0._imageIconTran)

	return arg_22_0._imageIcon.sprite, var_22_2
end

function var_0_0.isDraggable(arg_23_0)
	if arg_23_0:getCount() <= 0 then
		return false
	end

	return true
end

return var_0_0
