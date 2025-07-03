module("modules.logic.versionactivity2_5.act187.view.Activity187AccrueRewardItem", package.seeall)

local var_0_0 = class("Activity187AccrueRewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._btnItem = gohelper.findChildClick(arg_2_0.go, "#go_item")
	arg_2_0._imagebg = gohelper.findChildImage(arg_2_0.go, "#go_item/#image_bg")
	arg_2_0._simagereward = gohelper.findChildSingleImage(arg_2_0.go, "#go_item/#simage_reward")
	arg_2_0._imagecircle = gohelper.findChildImage(arg_2_0.go, "#go_item/image_circle")
	arg_2_0._txtrewardcount = gohelper.findChildText(arg_2_0.go, "#go_item/#txt_rewardcount")
	arg_2_0._deadline1 = gohelper.findChild(arg_2_0.go, "#go_item/deadline1")
	arg_2_0._gohasget = gohelper.findChild(arg_2_0.go, "#go_status/#go_hasget")
	arg_2_0._gocanget = gohelper.findChild(arg_2_0.go, "#go_status/#go_canget")
	arg_2_0._btnget = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#go_status/#go_canget/#btn_get")
	arg_2_0._imagestatus = gohelper.findChildImage(arg_2_0.go, "#image_point")
	arg_2_0._txtpointvalue = gohelper.findChildText(arg_2_0.go, "#txt_pointvalue")
	arg_2_0._hasGetAnimator = arg_2_0._gohasget:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnget:AddClickListener(arg_3_0._btngetOnClick, arg_3_0)
	arg_3_0._btnItem:AddClickListener(arg_3_0._btnitemOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnget:RemoveClickListener()
	arg_4_0._btnItem:RemoveClickListener()
end

function var_0_0._btngetOnClick(arg_5_0)
	if not arg_5_0.data then
		return
	end

	local var_5_0 = Activity187Model.instance:getFinishPaintingIndex()
	local var_5_1 = Activity187Model.instance:getAccrueRewardIndex() >= arg_5_0.id

	if not var_5_1 and var_5_0 >= arg_5_0.id and not var_5_1 then
		Activity187Controller.instance:getAccrueReward()
	end
end

function var_0_0._btnitemOnClick(arg_6_0)
	if not arg_6_0.data then
		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_6_0.data.materilType, arg_6_0.data.materilId)
end

function var_0_0.setData(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1
	arg_7_0.id = arg_7_0.data and arg_7_0.data.accrueId

	arg_7_0:setItem()
	arg_7_0:refreshStatus()
	gohelper.setActive(arg_7_0.go, arg_7_0.data)
end

function var_0_0.setItem(arg_8_0)
	if not arg_8_0.data then
		return
	end

	local var_8_0, var_8_1 = ItemModel.instance:getItemConfigAndIcon(arg_8_0.data.materilType, arg_8_0.data.materilId)

	UISpriteSetMgr.instance:setUiFBSprite(arg_8_0._imagebg, "bg_pinjidi_" .. var_8_0.rare)
	arg_8_0._simagereward:LoadImage(var_8_1)
	UISpriteSetMgr.instance:setUiFBSprite(arg_8_0._imagecircle, "bg_pinjidi_lanse_" .. var_8_0.rare)

	arg_8_0._txtrewardcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multiple_1"), arg_8_0.data.quantity)
	arg_8_0._txtpointvalue.text = formatLuaLang("times2", arg_8_0.id)

	local var_8_2 = false

	if arg_8_0.data.materilType == MaterialEnum.MaterialType.PowerPotion then
		var_8_2 = var_8_0.expireType ~= 0 and not string.nilorempty(var_8_0.expireTime)
	end

	gohelper.setActive(arg_8_0._deadline1, var_8_2)
end

function var_0_0.refreshStatus(arg_9_0, arg_9_1)
	if not arg_9_0.data then
		return
	end

	local var_9_0 = Activity187Model.instance:getFinishPaintingIndex()
	local var_9_1 = Activity187Model.instance:getAccrueRewardIndex() >= arg_9_0.id
	local var_9_2 = not var_9_1 and var_9_0 >= arg_9_0.id
	local var_9_3 = var_9_1 and "#CF7845" or "#968C89"

	SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtpointvalue, var_9_3)
	UISpriteSetMgr.instance:setUiFBSprite(arg_9_0._imagestatus, "bg_xingjidian" .. (var_9_1 and "" or "_dis"), true)

	if arg_9_1 and var_9_2 then
		gohelper.setActive(arg_9_0._gohasget, true)
		gohelper.setActive(arg_9_0._gocanget, false)
		arg_9_0._hasGetAnimator:Play("open")
	else
		gohelper.setActive(arg_9_0._gohasget, var_9_1)
		gohelper.setActive(arg_9_0._gocanget, var_9_2)
	end
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._simagereward:UnLoadImage()
end

return var_0_0
