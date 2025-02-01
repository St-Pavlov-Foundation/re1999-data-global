module("modules.logic.sdk.view.SDKSandboxPayView", package.seeall)

slot0 = class("SDKSandboxPayView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtgoodsName = gohelper.findChildText(slot0.viewGO, "goodsName/#txt_goodsName")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "cost/#txt_cost")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_buy")
	slot0._btnsdk = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_sdk")
	slot0._txtbalance = gohelper.findChildText(slot0.viewGO, "balance/#txt_balance")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnsdk:AddClickListener(slot0._btnsdkOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
	slot0._btnsdk:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnbuyOnClick(slot0)
	ChargeRpc.instance:sendSandboxChargeRequset(slot0.payInfo.gameOrderId)
	slot0:closeThis()
end

function slot0._btnsdkOnClick(slot0)
	SDKMgr.instance:payGoods(StatModel.instance:getPayInfo())
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.payInfo = slot0.viewParam.payInfo
	slot1 = StoreConfig.instance:getChargeGoodsConfig(slot0.payInfo.goodsId)
	slot0._txtcost.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(slot0.payInfo.amount / 100))
	slot0._txtgoodsName.text = slot0.payInfo.goodsName
	slot0._txtbalance.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(PayModel.instance:getSandboxBalance() / 100))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
