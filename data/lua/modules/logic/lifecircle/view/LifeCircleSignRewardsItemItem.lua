module("modules.logic.lifecircle.view.LifeCircleSignRewardsItemItem", package.seeall)

local var_0_0 = class("LifeCircleSignRewardsItemItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "#image_bg")
	arg_1_0._simageReward = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Reward")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "#go_hasget")
	arg_1_0._txtrewardcount = gohelper.findChildText(arg_1_0.viewGO, "#txt_rewardcount")

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

local var_0_1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local var_0_2 = Color.New(1, 1, 1, 1)
local var_0_3 = Color.New(0.5, 0.5, 0.5, 1)
local var_0_4 = Color.New(1, 1, 1, 1)
local var_0_5 = Color.New(0.227451, 0.227451, 0.227451, 1)
local var_0_6 = Color.New(0.227451, 0.227451, 0.227451, 1)

function var_0_0.ctor(arg_4_0, ...)
	arg_4_0:__onInit()
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._simageRewardGo = arg_5_0._simageReward.gameObject
	arg_5_0._simageRewardImg = arg_5_0._simageReward:GetComponent(gohelper.Type_Image)
	arg_5_0._imagebgGo = arg_5_0._imagebg.gameObject
	arg_5_0._itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_5_0._simageRewardGo)
end

function var_0_0.onDestroyView(arg_6_0)
	GameUtil.onDestroyViewMember(arg_6_0, "_itemIcon")
	var_0_0.super.onDestroyView(arg_6_0)
	arg_6_0:__onDispose()
end

function var_0_0._isClaimed(arg_7_0)
	return arg_7_0:parent():isClaimed()
end

function var_0_0._logindaysid(arg_8_0)
	return arg_8_0:parent():logindaysid()
end

function var_0_0._setData_Normal(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[1]
	local var_9_1 = arg_9_1[2]
	local var_9_2 = arg_9_1[3]
	local var_9_3, var_9_4 = ItemModel.instance:getItemConfigAndIcon(var_9_0, var_9_1)

	arg_9_0._itemIcon:setMOValue(var_9_0, var_9_1, var_9_2)
	arg_9_0._itemIcon:isShowQuality(false)
	arg_9_0._itemIcon:isShowEquipAndItemCount(false)
	arg_9_0._itemIcon:customOnClickCallback(arg_9_0._onItemClick, arg_9_0)

	if arg_9_0._itemIcon:isEquipIcon() then
		arg_9_0._itemIcon:setScale(0.7)
	else
		arg_9_0._itemIcon:setScale(0.8)
	end

	arg_9_0:_setBg(var_9_3.rare)

	arg_9_0._txtrewardcount.text = var_9_2 and luaLang("multiple") .. var_9_2 or ""
end

function var_0_0._setBg(arg_10_0, arg_10_1)
	UISpriteSetMgr.instance:setUiFBSprite(arg_10_0._imagebg, "bg_pinjidi_" .. tostring(arg_10_1 or 0))
end

function var_0_0._setData_LastOne(arg_11_0)
	arg_11_0._txtrewardcount.text = ""

	gohelper.setActive(arg_11_0._imagebgGo, true)
	UISpriteSetMgr.instance:setUiFBSprite(arg_11_0._imagebg, "bg_pinjidi_0")
	arg_11_0:_setBg(0)
end

function var_0_0.setData(arg_12_0, arg_12_1)
	var_0_0.super.setData(arg_12_0, arg_12_1)

	local var_12_0 = arg_12_0:_isClaimed()
	local var_12_1 = var_12_0 and var_0_1 or var_0_2
	local var_12_2 = var_12_0 and var_0_3 or var_0_4
	local var_12_3 = var_12_0 and var_0_5 or var_0_6

	gohelper.setActive(arg_12_0._simageRewardGo, arg_12_1 and true or false)

	local var_12_4 = arg_12_1 and true or false

	arg_12_0:_setActive_itemIcon(var_12_4)

	arg_12_0._simageRewardImg.enabled = not var_12_4

	if not arg_12_1 then
		arg_12_0:_setData_LastOne()
	else
		arg_12_0:_setData_Normal(arg_12_1)
	end

	arg_12_0._simageRewardImg.color = var_12_1
	arg_12_0._imagebg.color = var_12_2
	arg_12_0._txtrewardcount.color = var_12_3

	gohelper.setActive(arg_12_0._gohasget, var_12_0)
end

function var_0_0._onItemClick(arg_13_0)
	if not arg_13_0:parent():onItemClick() then
		return
	end

	local var_13_0 = arg_13_0._mo

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0[1]
	local var_13_2 = var_13_0[2]

	MaterialTipController.instance:showMaterialInfo(var_13_1, var_13_2)
end

function var_0_0._setActive_itemIcon(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0._itemIcon:setPropItemScale(1)
	else
		arg_14_0._itemIcon:setPropItemScale(0)
	end
end

return var_0_0
