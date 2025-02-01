module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCurrencyView", package.seeall)

slot0 = class("V1a6_CachotCurrencyView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._rootPath = slot1

	uv0.super.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._rootGo = gohelper.findChild(slot0.viewGO, slot0._rootPath or "")
	slot0._txtcoin = gohelper.findChildText(slot0._rootGo, "#go_shop/#txt_num2")
	slot0._slidercurrency = gohelper.findChildSlider(slot0._rootGo, "#go_hope/bg/#slider_progress")
	slot0._txtcurrency = gohelper.findChildTextMesh(slot0._rootGo, "#go_hope/#txt_num2")
	slot0._txtcurrencytotal = gohelper.findChildTextMesh(slot0._rootGo, "#go_hope/#txt_num1")
	slot0._btnClickCurrency = gohelper.findChildButtonWithAudio(slot0._rootGo, "#go_hope/#btn_click")
	slot0._btnClickCoin = gohelper.findChildButtonWithAudio(slot0._rootGo, "#go_shop/#btn_click")
	slot0._goeffectcoinadd = gohelper.findChild(slot0._rootGo, "#go_shop/vx_vitality")
	slot0._goeffectcurrencyadd = gohelper.findChild(slot0._rootGo, "#go_hope/vx_vitality")
end

function slot0.addEvents(slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0.updateCurrency, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCoin, slot0.updateCurrency, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCurrency, slot0.updateCurrency, slot0)

	if slot0._btnClickCurrency then
		slot0._btnClickCurrency:AddClickListener(slot0._clickCurrency, slot0)
	end

	if slot0._btnClickCoin then
		slot0._btnClickCoin:AddClickListener(slot0._clickCoin, slot0)
	end
end

function slot0.removeEvents(slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0.updateCurrency, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCoin, slot0.updateCurrency, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCurrency, slot0.updateCurrency, slot0)

	if slot0._btnClickCurrency then
		slot0._btnClickCurrency:RemoveClickListener()
	end

	if slot0._btnClickCoin then
		slot0._btnClickCoin:RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	slot0:hideEffect()
	slot0:updateCurrency()
end

function slot0._clickCurrency(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6CachotCurrency, false, nil, false)
end

function slot0._clickCoin(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6CachotCoin, false, nil, false)
end

function slot0.updateCurrency(slot0)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	slot0._txtcoin.text = slot0._rogueInfo.coin
	slot0._txtcurrency.text = math.min(slot0._rogueInfo.currency, slot0._rogueInfo.currencyTotal)
	slot0._txtcurrencytotal.text = slot0._rogueInfo.currencyTotal
	slot1 = false

	if slot0._cacheCoin then
		if slot0._cacheCoin < slot0._rogueInfo.coin then
			gohelper.setActive(slot0._goeffectcoinadd, true)

			slot1 = true
		end

		if slot0._cacheCurrency < slot0._rogueInfo.currency then
			gohelper.setActive(slot0._goeffectcurrencyadd, true)

			slot1 = true
		end
	end

	slot0._cacheCoin = slot0._rogueInfo.coin
	slot0._cacheCurrency = slot0._rogueInfo.currency

	if slot0._rogueInfo.currencyTotal == 0 then
		slot0._slidercurrency:SetValue(0)
	else
		slot0._slidercurrency:SetValue(slot0._rogueInfo.currency / slot0._rogueInfo.currencyTotal)
	end

	if slot1 then
		TaskDispatcher.cancelTask(slot0.hideEffect, slot0)
		TaskDispatcher.runDelay(slot0.hideEffect, slot0, 2)
	end
end

function slot0.hideEffect(slot0)
	gohelper.setActive(slot0._goeffectcoinadd, false)
	gohelper.setActive(slot0._goeffectcurrencyadd, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.hideEffect, slot0)
end

return slot0
