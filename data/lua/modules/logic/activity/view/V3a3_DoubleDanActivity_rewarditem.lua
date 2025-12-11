module("modules.logic.activity.view.V3a3_DoubleDanActivity_rewarditem", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivity_rewarditem", RougeSimpleItemBase)

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

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)

	arg_4_0._image_rare = gohelper.findChildImage(arg_4_0.viewGO, "image_rare")
	arg_4_0._txt_count = gohelper.findChildText(arg_4_0.viewGO, "countbg/txt_count")
	arg_4_0._itemIcon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(arg_4_0.viewGO, "simage_icon"))
	arg_4_0._btn_click = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "btn_click")
	arg_4_0._goLocked = gohelper.findChild(arg_4_0.viewGO, "#go_Locked")
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._btn_click:AddClickListener(arg_5_0._btn_clickOnClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._btn_click:RemoveClickListener()
end

function var_0_0._btn_clickOnClick(arg_7_0)
	arg_7_0:_onItemClick()
end

function var_0_0._isType101RewardGet(arg_8_0)
	return arg_8_0:parent():_isType101RewardGet()
end

function var_0_0.setData(arg_9_0, arg_9_1)
	var_0_0.super.setData(arg_9_0, arg_9_1)

	local var_9_0 = arg_9_0:_isType101RewardGet()
	local var_9_1 = arg_9_1[1]
	local var_9_2 = arg_9_1[2]
	local var_9_3 = arg_9_1[3] or 0
	local var_9_4, var_9_5 = ItemModel.instance:getItemConfigAndIcon(var_9_1, var_9_2)

	arg_9_0:_setActive_goLocked(var_9_0)
	arg_9_0._itemIcon:setMOValue(var_9_1, var_9_2, var_9_3)
	arg_9_0._itemIcon:isShowQuality(false)
	arg_9_0._itemIcon:isShowEquipAndItemCount(false)
	arg_9_0._itemIcon:customOnClickCallback(arg_9_0._onItemClick, arg_9_0)

	if arg_9_0._itemIcon:isEquipIcon() then
		arg_9_0._itemIcon:setScale(0.7)
	else
		arg_9_0._itemIcon:setScale(0.8)
	end

	arg_9_0:_refresh_image_rare(var_9_4.rare)

	arg_9_0._txt_count.text = luaLang("multiple") .. var_9_3
end

function var_0_0._onItemClick(arg_10_0)
	if arg_10_0:parent():onRewardItemClick() then
		return
	end

	local var_10_0 = arg_10_0._mo

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0[1]
	local var_10_2 = var_10_0[2]

	MaterialTipController.instance:showMaterialInfo(var_10_1, var_10_2)
end

function var_0_0._refresh_image_rare(arg_11_0, arg_11_1)
	UISpriteSetMgr.instance:setUiFBSprite(arg_11_0._image_rare, "bg_pinjidi_" .. tostring(arg_11_1 or 0))
end

function var_0_0._setActive_goLocked(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goLocked, arg_12_1)
end

return var_0_0
