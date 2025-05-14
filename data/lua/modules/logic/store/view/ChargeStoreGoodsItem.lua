module("modules.logic.store.view.ChargeStoreGoodsItem", package.seeall)

local var_0_0 = class("ChargeStoreGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#image_icon/#txt_name")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#image_icon/huan/#txt_num")
	arg_1_0._gorecharge = gohelper.findChild(arg_1_0.viewGO, "#image_icon/#go_recharge")
	arg_1_0._txtrecharge = gohelper.findChildText(arg_1_0.viewGO, "#image_icon/#go_recharge/#txt_recharge")
	arg_1_0._txtrechargenum = gohelper.findChildText(arg_1_0.viewGO, "#image_icon/#go_recharge/#txt_recharge/#txt_recharge_num")
	arg_1_0._goexcharge = gohelper.findChild(arg_1_0.viewGO, "#image_icon/#go_excharge")
	arg_1_0._txtexcharge = gohelper.findChildText(arg_1_0.viewGO, "#image_icon/#go_excharge/excharge/#txt_excharge")
	arg_1_0._txtexchargenum = gohelper.findChildText(arg_1_0.viewGO, "#image_icon/#go_excharge/excharge/#txt_excharge_num")
	arg_1_0._txtbtnnum = gohelper.findChildText(arg_1_0.viewGO, "btn_bg/#txt_btn_num")
	arg_1_0._gosign = gohelper.findChild(arg_1_0.viewGO, "btn_bg/sign")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.UpdateProductDetails, arg_2_0._refreshGoods, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.UpdateProductDetails, arg_3_0._refreshGoods, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._btnGO = gohelper.findChild(arg_4_0.viewGO, "clickArea")
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0._btnGO)

	arg_4_0._btn:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._lastStartPayTime = 0
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0._onClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	if Time.time - arg_7_0._lastStartPayTime > 0.3 then
		PayController.instance:startPay(arg_7_0._mo.id)

		arg_7_0._lastStartPayTime = Time.time
	end
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:_refreshGoods()
	arg_8_0:_refreshDiscount()
end

local var_0_1 = 210006

function var_0_0._refreshGoods(arg_9_0)
	local var_9_0 = arg_9_0._mo.config.product
	local var_9_1 = string.splitToNumber(var_9_0, "#")[3]

	UISpriteSetMgr.instance:setStoreGoodsSprite(arg_9_0._imageicon, arg_9_0._mo.config.id, true)

	arg_9_0._txtnum.text = var_9_1
	arg_9_0._txtbtnnum.text = PayModel.instance:getProductPrice(arg_9_0._mo.id)

	gohelper.setActive(arg_9_0._gosign, false)

	arg_9_0._txtname.text = arg_9_0._mo.config.name
end

function var_0_0._refreshDiscount(arg_10_0)
	gohelper.setActive(arg_10_0._gorecharge, false)
	gohelper.setActive(arg_10_0._goexcharge, false)

	if arg_10_0._mo.firstCharge then
		if arg_10_0._mo.config.firstDiamond > 0 then
			gohelper.setActive(arg_10_0._gorecharge, true)
			gohelper.setActive(arg_10_0._gorechargeTip, true)

			arg_10_0._txtrechargenum.text = string.format("<size=24>+</size>%s", arg_10_0._mo.config.firstDiamond)
			arg_10_0._txtrecharge.text = luaLang("store_charge_firstdouble")

			arg_10_0._txtrecharge:GetPreferredValues()
		end
	elseif arg_10_0._mo.config.extraDiamond > 0 then
		gohelper.setActive(arg_10_0._goexcharge, true)

		arg_10_0._txtexcharge.text = string.format(luaLang("store_charge_extra"), arg_10_0._mo.config.extraDiamond)
		arg_10_0._txtexchargenum.text = string.format("<voffset=1><size=24>+</size></voffset>%s", arg_10_0._mo.config.extraDiamond)
	end
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.getAnimator(arg_12_0)
	return arg_12_0._animator
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._btn:RemoveClickListener()
end

return var_0_0
