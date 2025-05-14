module("modules.logic.summon.view.SummonConfirmView", package.seeall)

local var_0_0 = class("SummonConfirmView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagehuawen1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/tipbg/#simage_huawen1")
	arg_1_0._simagehuawen2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/tipbg/#simage_huawen2")
	arg_1_0._simagebeforeicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "cost/before/#simage_beforeicon")
	arg_1_0._simageaftericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "cost/after/#simage_aftericon")
	arg_1_0._txtbeforequantity = gohelper.findChildText(arg_1_0.viewGO, "cost/before/numbg/#txt_beforequantity")
	arg_1_0._txtafterquantity = gohelper.findChildText(arg_1_0.viewGO, "cost/after/numbg/#txt_afterquantity")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
end

function var_0_0._btnyesOnClick(arg_4_0)
	arg_4_0._yes = true

	if arg_4_0.viewParam.notEnough then
		CurrencyController.instance:checkFreeDiamondEnough(arg_4_0.viewParam.cost_quantity, CurrencyEnum.PayDiamondExchangeSource.Summon, true, arg_4_0._callCheckWithParam, arg_4_0)
	end

	arg_4_0:closeThis()
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._callCheckWithParam(arg_6_0)
	arg_6_0._callback(arg_6_0._callbackObj, arg_6_0.viewParam)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	arg_7_0._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))
	gohelper.addUIClickAudio(arg_7_0._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_7_0._btnno.gameObject, AudioEnum.UI.UI_Common_Click)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:onOpen()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._type = arg_9_0.viewParam.type
	arg_9_0._id = arg_9_0.viewParam.id
	arg_9_0._quantity = arg_9_0.viewParam.quantity
	arg_9_0._callback = arg_9_0.viewParam.callback
	arg_9_0._callbackObj = arg_9_0.viewParam.callbackObj
	arg_9_0._yes = false
	arg_9_0.needTransform = arg_9_0.viewParam.needTransform

	local var_9_0 = false

	if arg_9_0._type == MaterialEnum.MaterialType.Currency and (arg_9_0._id == CurrencyEnum.CurrencyType.Diamond or arg_9_0._id == CurrencyEnum.CurrencyType.FreeDiamondCoupon) then
		var_9_0 = true
	end

	local var_9_1, var_9_2 = ItemModel.instance:getItemConfigAndIcon(arg_9_0._type, arg_9_0._id)

	arg_9_0._simageaftericon:LoadImage(var_9_2)

	if arg_9_0.needTransform then
		local var_9_3, var_9_4 = ItemModel.instance:getItemConfigAndIcon(arg_9_0.viewParam.cost_type, arg_9_0.viewParam.cost_id)

		arg_9_0._simagebeforeicon:LoadImage(var_9_4)

		arg_9_0._txtbeforequantity.text = GameUtil.numberDisplay(arg_9_0.viewParam.cost_quantity)
		arg_9_0._txtafterquantity.text = GameUtil.numberDisplay(arg_9_0.viewParam.miss_quantity)

		local var_9_5 = {
			arg_9_0.viewParam.miss_quantity,
			var_9_0 and luaLang("summon_confirm_quantifier1") or luaLang("summon_confirm_quantifier2"),
			var_9_1.name,
			arg_9_0.viewParam.cost_quantity,
			var_9_3.name
		}

		arg_9_0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_transform_desc"), var_9_5)
	else
		arg_9_0._simagebeforeicon:LoadImage(var_9_2)

		local var_9_6 = ItemModel.instance:getItemQuantity(arg_9_0._type, arg_9_0._id)

		arg_9_0._txtbeforequantity.text = GameUtil.numberDisplay(var_9_6)
		arg_9_0._txtafterquantity.text = GameUtil.numberDisplay(var_9_6 - arg_9_0._quantity)

		local var_9_7 = {
			arg_9_0._quantity,
			var_9_0 and luaLang("summon_confirm_quantifier1") or luaLang("summon_confirm_quantifier2"),
			var_9_1.name
		}

		arg_9_0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_confirm_desc"), var_9_7)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onCloseFinish(arg_11_0)
	if arg_11_0._yes and not arg_11_0.viewParam.notEnough and arg_11_0._callback then
		arg_11_0._callback(arg_11_0._callbackObj, arg_11_0.viewParam)
	end
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagehuawen1:UnLoadImage()
	arg_12_0._simagehuawen2:UnLoadImage()
	arg_12_0._simagebeforeicon:UnLoadImage()
	arg_12_0._simageaftericon:UnLoadImage()
end

return var_0_0
