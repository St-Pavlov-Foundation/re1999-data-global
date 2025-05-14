module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCurrencyView", package.seeall)

local var_0_0 = class("V1a6_CachotCurrencyView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._rootPath = arg_1_1

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._rootGo = gohelper.findChild(arg_2_0.viewGO, arg_2_0._rootPath or "")
	arg_2_0._txtcoin = gohelper.findChildText(arg_2_0._rootGo, "#go_shop/#txt_num2")
	arg_2_0._slidercurrency = gohelper.findChildSlider(arg_2_0._rootGo, "#go_hope/bg/#slider_progress")
	arg_2_0._txtcurrency = gohelper.findChildTextMesh(arg_2_0._rootGo, "#go_hope/#txt_num2")
	arg_2_0._txtcurrencytotal = gohelper.findChildTextMesh(arg_2_0._rootGo, "#go_hope/#txt_num1")
	arg_2_0._btnClickCurrency = gohelper.findChildButtonWithAudio(arg_2_0._rootGo, "#go_hope/#btn_click")
	arg_2_0._btnClickCoin = gohelper.findChildButtonWithAudio(arg_2_0._rootGo, "#go_shop/#btn_click")
	arg_2_0._goeffectcoinadd = gohelper.findChild(arg_2_0._rootGo, "#go_shop/vx_vitality")
	arg_2_0._goeffectcurrencyadd = gohelper.findChild(arg_2_0._rootGo, "#go_hope/vx_vitality")
end

function var_0_0.addEvents(arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_3_0.updateCurrency, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCoin, arg_3_0.updateCurrency, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCurrency, arg_3_0.updateCurrency, arg_3_0)

	if arg_3_0._btnClickCurrency then
		arg_3_0._btnClickCurrency:AddClickListener(arg_3_0._clickCurrency, arg_3_0)
	end

	if arg_3_0._btnClickCoin then
		arg_3_0._btnClickCoin:AddClickListener(arg_3_0._clickCoin, arg_3_0)
	end
end

function var_0_0.removeEvents(arg_4_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_4_0.updateCurrency, arg_4_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCoin, arg_4_0.updateCurrency, arg_4_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCurrency, arg_4_0.updateCurrency, arg_4_0)

	if arg_4_0._btnClickCurrency then
		arg_4_0._btnClickCurrency:RemoveClickListener()
	end

	if arg_4_0._btnClickCoin then
		arg_4_0._btnClickCoin:RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:hideEffect()
	arg_5_0:updateCurrency()
end

function var_0_0._clickCurrency(arg_6_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6CachotCurrency, false, nil, false)
end

function var_0_0._clickCoin(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6CachotCoin, false, nil, false)
end

function var_0_0.updateCurrency(arg_8_0)
	arg_8_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	arg_8_0._txtcoin.text = arg_8_0._rogueInfo.coin
	arg_8_0._txtcurrency.text = math.min(arg_8_0._rogueInfo.currency, arg_8_0._rogueInfo.currencyTotal)
	arg_8_0._txtcurrencytotal.text = arg_8_0._rogueInfo.currencyTotal

	local var_8_0 = false

	if arg_8_0._cacheCoin then
		if arg_8_0._cacheCoin < arg_8_0._rogueInfo.coin then
			gohelper.setActive(arg_8_0._goeffectcoinadd, true)

			var_8_0 = true
		end

		if arg_8_0._cacheCurrency < arg_8_0._rogueInfo.currency then
			gohelper.setActive(arg_8_0._goeffectcurrencyadd, true)

			var_8_0 = true
		end
	end

	arg_8_0._cacheCoin = arg_8_0._rogueInfo.coin
	arg_8_0._cacheCurrency = arg_8_0._rogueInfo.currency

	if arg_8_0._rogueInfo.currencyTotal == 0 then
		arg_8_0._slidercurrency:SetValue(0)
	else
		arg_8_0._slidercurrency:SetValue(arg_8_0._rogueInfo.currency / arg_8_0._rogueInfo.currencyTotal)
	end

	if var_8_0 then
		TaskDispatcher.cancelTask(arg_8_0.hideEffect, arg_8_0)
		TaskDispatcher.runDelay(arg_8_0.hideEffect, arg_8_0, 2)
	end
end

function var_0_0.hideEffect(arg_9_0)
	gohelper.setActive(arg_9_0._goeffectcoinadd, false)
	gohelper.setActive(arg_9_0._goeffectcurrencyadd, false)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.hideEffect, arg_10_0)
end

return var_0_0
