module("modules.logic.battlepass.view.BpBuyView", package.seeall)

slot0 = class("BpBuyView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btnBuy")
	slot0._btnMin = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btnMin", AudioEnum.UI.play_ui_set_volume_button)
	slot0._btnMax = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btnMax", AudioEnum.UI.play_ui_set_volume_button)
	slot0._btnMinus = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btnMinus", AudioEnum.UI.play_ui_set_volume_button)
	slot0._btnAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btnAdd", AudioEnum.UI.play_ui_set_volume_button)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btnClose")
	slot0._btnClose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._sliderBuy = gohelper.findChildSlider(slot0.viewGO, "bg/#slider_buy")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "bg/#txtTips")
	slot0._txtCost = gohelper.findChildText(slot0.viewGO, "bg/cost/#txtCost")
	slot0._imgCost = gohelper.findChildImage(slot0.viewGO, "bg/cost/#imgCost")
	slot0._txtbuy = gohelper.findChildTextMesh(slot0.viewGO, "bg/txtbuy/#txt_buyNum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnBuy:AddClickListener(slot0._onClickbtnBuy, slot0)
	slot0._btnMin:AddClickListener(slot0._onClickbtnMin, slot0)
	slot0._btnMax:AddClickListener(slot0._onClickbtnMax, slot0)
	slot0._btnMinus:AddClickListener(slot0._onClickbtnMinus, slot0)
	slot0._btnAdd:AddClickListener(slot0._onClickbtnAdd, slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnClose1:AddClickListener(slot0.closeThis, slot0)
	slot0._sliderBuy:AddOnValueChanged(slot0._onInpEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBuy:RemoveClickListener()
	slot0._btnMin:RemoveClickListener()
	slot0._btnMax:RemoveClickListener()
	slot0._btnMinus:RemoveClickListener()
	slot0._btnAdd:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._btnClose1:RemoveClickListener()
	slot0._sliderBuy:RemoveOnValueChanged()
	slot0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._onBuyLevel, slot0)
end

function slot0._editableInitView(slot0)
	slot0._maxNum = #BpConfig.instance:getBonusCOList(BpModel.instance.id)
end

function slot0.onOpen(slot0)
	slot0._buyCost = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.BpBuyLevelCost), "#")

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgCost, CurrencyConfig.instance:getCurrencyCo(slot0._buyCost[2]).icon .. "_1")

	slot0._num = 1

	slot0:_updateView()
end

function slot0.onClose(slot0)
end

function slot0._onClickbtnBuy(slot0)
	if CurrencyController.instance:checkFreeDiamondEnough(slot0._buyCost[3] * slot0._num, CurrencyEnum.PayDiamondExchangeSource.HUD, nil, slot0.buyLevel, slot0) then
		slot0:buyLevel()
	end
end

function slot0.buyLevel(slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._onBuyLevel, slot0)
	BpRpc.instance:sendBpBuyLevelRequset(slot0._num)
end

function slot0._onYes(slot0)
	slot0:closeThis()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
end

function slot0._onClickbtnMin(slot0)
	slot0._num = 1

	slot0:_updateView()
end

function slot0._onClickbtnMax(slot0)
	slot0._num = slot0:_getMax()

	slot0:_updateView()
end

function slot0._onClickbtnMinus(slot0)
	if slot0._num > 1 then
		slot0._num = slot0._num - 1

		slot0:_updateView()
	end
end

function slot0._onClickbtnAdd(slot0)
	if slot0._num < slot0:_getMax() then
		slot0._num = slot0._num + 1

		slot0:_updateView()
	end
end

function slot0._onInpEndEdit(slot0)
	if Mathf.Round(slot0._sliderBuy:GetValue() * (slot0._maxNum - math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) - 1)) + 1 then
		if slot0:_getMax() < slot4 then
			slot0._num = slot5
		elseif slot4 < 1 then
			slot0._num = 1
		else
			slot0._num = slot4
		end
	end

	slot0:_updateView()
end

function slot0._updateView(slot0)
	slot2 = math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))

	slot0._sliderBuy.slider:SetValueWithoutNotify((slot0._num - 1) / (slot0._maxNum - slot2 - 1))

	slot0._txtbuy.text = slot0._num
	slot0._txtTips.text = formatLuaLang("bp_buy_reward_tip", slot0._num + slot2)
	slot0._txtCost.text = tostring(slot0._buyCost[3] * slot0._num)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtCost, slot5 <= (CurrencyModel.instance:getCurrency(slot0._buyCost[2]) and slot6.quantity or 0) and "#292523" or "#ff0000")

	slot8 = {}
	slot9 = {}

	for slot13 = slot2 + 1, slot3 do
		slot0:_calcBonus(slot8, slot9, BpConfig.instance:getBonusCO(BpModel.instance.id, slot13).freeBonus)

		if BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
			slot0:_calcBonus(slot8, slot9, slot14.payBonus)
		end
	end

	BpBuyViewModel.instance:setList(slot9)
end

function slot0._calcBonus(slot0, slot1, slot2, slot3)
	slot7 = "|"

	for slot7, slot8 in pairs(string.split(slot3, slot7)) do
		slot9 = string.splitToNumber(slot8, "#")
		slot11 = slot9[3]

		if not slot1[slot9[2]] then
			slot1[slot10] = slot9

			table.insert(slot2, slot9)
		else
			slot1[slot10][3] = slot1[slot10][3] + slot11
		end
	end
end

function slot0._getMax(slot0)
	return slot0._maxNum - math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))
end

function slot0._onBuyLevel(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
