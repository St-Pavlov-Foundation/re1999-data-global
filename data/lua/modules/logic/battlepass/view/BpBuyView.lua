module("modules.logic.battlepass.view.BpBuyView", package.seeall)

local var_0_0 = class("BpBuyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btnBuy")
	arg_1_0._btnMin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btnMin", AudioEnum.UI.play_ui_set_volume_button)
	arg_1_0._btnMax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btnMax", AudioEnum.UI.play_ui_set_volume_button)
	arg_1_0._btnMinus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btnMinus", AudioEnum.UI.play_ui_set_volume_button)
	arg_1_0._btnAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btnAdd", AudioEnum.UI.play_ui_set_volume_button)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btnClose")
	arg_1_0._btnClose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._sliderBuy = gohelper.findChildSlider(arg_1_0.viewGO, "bg/#slider_buy")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "bg/#txtTips")
	arg_1_0._txtCost = gohelper.findChildText(arg_1_0.viewGO, "bg/cost/#txtCost")
	arg_1_0._imgCost = gohelper.findChildImage(arg_1_0.viewGO, "bg/cost/#imgCost")
	arg_1_0._txtbuy = gohelper.findChildTextMesh(arg_1_0.viewGO, "bg/txtbuy/#txt_buyNum")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._onClickbtnBuy, arg_2_0)
	arg_2_0._btnMin:AddClickListener(arg_2_0._onClickbtnMin, arg_2_0)
	arg_2_0._btnMax:AddClickListener(arg_2_0._onClickbtnMax, arg_2_0)
	arg_2_0._btnMinus:AddClickListener(arg_2_0._onClickbtnMinus, arg_2_0)
	arg_2_0._btnAdd:AddClickListener(arg_2_0._onClickbtnAdd, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnClose1:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._sliderBuy:AddOnValueChanged(arg_2_0._onInpEndEdit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._btnMin:RemoveClickListener()
	arg_3_0._btnMax:RemoveClickListener()
	arg_3_0._btnMinus:RemoveClickListener()
	arg_3_0._btnAdd:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnClose1:RemoveClickListener()
	arg_3_0._sliderBuy:RemoveOnValueChanged()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_3_0._onBuyLevel, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._maxNum = #BpConfig.instance:getBonusCOList(BpModel.instance.id)
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = CommonConfig.instance:getConstStr(ConstEnum.BpBuyLevelCost)

	arg_5_0._buyCost = string.splitToNumber(var_5_0, "#")

	local var_5_1 = CurrencyConfig.instance:getCurrencyCo(arg_5_0._buyCost[2]).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_5_0._imgCost, var_5_1 .. "_1")

	arg_5_0._num = 1

	arg_5_0:_updateView()
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0._onClickbtnBuy(arg_7_0)
	if CurrencyController.instance:checkFreeDiamondEnough(arg_7_0._buyCost[3] * arg_7_0._num, CurrencyEnum.PayDiamondExchangeSource.HUD, nil, arg_7_0.buyLevel, arg_7_0) then
		arg_7_0:buyLevel()
	end
end

function var_0_0.buyLevel(arg_8_0)
	arg_8_0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_8_0._onBuyLevel, arg_8_0)
	BpRpc.instance:sendBpBuyLevelRequset(arg_8_0._num)
end

function var_0_0._onYes(arg_9_0)
	arg_9_0:closeThis()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
end

function var_0_0._onClickbtnMin(arg_10_0)
	arg_10_0._num = 1

	arg_10_0:_updateView()
end

function var_0_0._onClickbtnMax(arg_11_0)
	arg_11_0._num = arg_11_0:_getMax()

	arg_11_0:_updateView()
end

function var_0_0._onClickbtnMinus(arg_12_0)
	if arg_12_0._num > 1 then
		arg_12_0._num = arg_12_0._num - 1

		arg_12_0:_updateView()
	end
end

function var_0_0._onClickbtnAdd(arg_13_0)
	if arg_13_0._num < arg_13_0:_getMax() then
		arg_13_0._num = arg_13_0._num + 1

		arg_13_0:_updateView()
	end
end

function var_0_0._onInpEndEdit(arg_14_0)
	local var_14_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_14_1 = math.floor(BpModel.instance.score / var_14_0)
	local var_14_2 = arg_14_0._sliderBuy:GetValue()
	local var_14_3 = Mathf.Round(var_14_2 * (arg_14_0._maxNum - var_14_1 - 1)) + 1

	if var_14_3 then
		local var_14_4 = arg_14_0:_getMax()

		if var_14_4 < var_14_3 then
			arg_14_0._num = var_14_4
		elseif var_14_3 < 1 then
			arg_14_0._num = 1
		else
			arg_14_0._num = var_14_3
		end
	end

	arg_14_0:_updateView()
end

function var_0_0._updateView(arg_15_0)
	local var_15_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_15_1 = math.floor(BpModel.instance.score / var_15_0)
	local var_15_2 = arg_15_0._num + var_15_1
	local var_15_3 = (arg_15_0._num - 1) / (arg_15_0._maxNum - var_15_1 - 1)

	arg_15_0._sliderBuy.slider:SetValueWithoutNotify(var_15_3)

	arg_15_0._txtbuy.text = arg_15_0._num
	arg_15_0._txtTips.text = formatLuaLang("bp_buy_reward_tip", var_15_2)

	local var_15_4 = arg_15_0._buyCost[3] * arg_15_0._num

	arg_15_0._txtCost.text = tostring(var_15_4)

	local var_15_5 = CurrencyModel.instance:getCurrency(arg_15_0._buyCost[2])
	local var_15_6 = var_15_5 and var_15_5.quantity or 0

	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtCost, var_15_4 <= var_15_6 and "#292523" or "#ff0000")

	local var_15_7 = {}
	local var_15_8 = {}

	for iter_15_0 = var_15_1 + 1, var_15_2 do
		local var_15_9 = BpConfig.instance:getBonusCO(BpModel.instance.id, iter_15_0)

		arg_15_0:_calcBonus(var_15_7, var_15_8, var_15_9.freeBonus)

		if BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
			arg_15_0:_calcBonus(var_15_7, var_15_8, var_15_9.payBonus)
		end
	end

	BpBuyViewModel.instance:setList(var_15_8)
end

function var_0_0._calcBonus(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	for iter_16_0, iter_16_1 in pairs(string.split(arg_16_3, "|")) do
		local var_16_0 = string.splitToNumber(iter_16_1, "#")
		local var_16_1 = var_16_0[2]
		local var_16_2 = var_16_0[3]

		if not arg_16_1[var_16_1] then
			arg_16_1[var_16_1] = var_16_0

			table.insert(arg_16_2, var_16_0)
		else
			arg_16_1[var_16_1][3] = arg_16_1[var_16_1][3] + var_16_2
		end
	end
end

function var_0_0._getMax(arg_17_0)
	local var_17_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_17_1 = math.floor(BpModel.instance.score / var_17_0)

	return arg_17_0._maxNum - var_17_1
end

function var_0_0._onBuyLevel(arg_18_0)
	arg_18_0:closeThis()
end

function var_0_0.onClickModalMask(arg_19_0)
	arg_19_0:closeThis()
end

return var_0_0
