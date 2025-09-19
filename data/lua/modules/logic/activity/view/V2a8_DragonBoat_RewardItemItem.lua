module("modules.logic.activity.view.V2a8_DragonBoat_RewardItemItem", package.seeall)

local var_0_0 = class("V2a8_DragonBoat_RewardItemItem", RougeSimpleItemBase)

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
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._item = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(arg_5_0.viewGO, "go_icon"))
	arg_5_0._hasgetGo = gohelper.findChild(arg_5_0.viewGO, "hasget")
	arg_5_0._cangetGo = gohelper.findChild(arg_5_0.viewGO, "canget")

	arg_5_0:setActive_cangetGo(false)
	arg_5_0:setActive_hasgetGo(false)
end

function var_0_0.setData(arg_6_0, arg_6_1)
	var_0_0.super.setData(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_1

	arg_6_0._item:setMOValue(var_6_0[1], var_6_0[2], var_6_0[3])
	arg_6_0._item:setScale(0.5)
	arg_6_0._item:setCountFontSize(46)
	arg_6_0._item:setCountTxtSize(35)
	arg_6_0._item:SetCountBgHeight(22.72)
	arg_6_0._item:setHideLvAndBreakFlag(true)
	arg_6_0._item:hideEquipLvAndBreak(true)
	arg_6_0._item:customOnClickCallback(arg_6_0._customOnClickCallback, arg_6_0)
end

function var_0_0._customOnClickCallback(arg_7_0)
	if arg_7_0:_onItemClick() then
		return
	end

	local var_7_0 = arg_7_0._mo

	MaterialTipController.instance:showMaterialInfo(var_7_0[1], var_7_0[2])
end

function var_0_0.setActive_cangetGo(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._cangetGo, arg_8_1 and true or false)
end

function var_0_0.setActive_hasgetGo(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._hasgetGo, arg_9_1 and true or false)
	arg_9_0._item:setGetMask(arg_9_1)
end

function var_0_0._onItemClick(arg_10_0)
	return arg_10_0:_assetGetParent():onItemClick()
end

return var_0_0
