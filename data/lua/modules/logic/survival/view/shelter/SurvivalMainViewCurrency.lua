module("modules.logic.survival.view.shelter.SurvivalMainViewCurrency", package.seeall)

local var_0_0 = class("SurvivalMainViewCurrency", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnCurrency = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Top/#go_currency")
	arg_1_0.imgCurrency = gohelper.findChildImage(arg_1_0.viewGO, "go_normalroot/Top/#go_currency/#image_icon")
	arg_1_0.txtCurrency = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Top/#go_currency/#txt_currency")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Top/#go_currency/arrow")
	arg_1_0.goTips = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Top/#go_currency/go_tips")
	arg_1_0.txtSpeed = gohelper.findChildTextMesh(arg_1_0.goTips, "#txt_speed")
	arg_1_0.imgSpeedIcon = gohelper.findChildImage(arg_1_0.goTips, "#txt_speed/#image_icon")
	arg_1_0.btnCloseTips = gohelper.findChildButtonWithAudio(arg_1_0.goTips, "#btn_close")
	arg_1_0.itemType = SurvivalEnum.ItemType.Currency
	arg_1_0.currencyList = {
		SurvivalEnum.CurrencyType.Food,
		SurvivalEnum.CurrencyType.Build
	}
	arg_1_0.currencyItemList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCurrency, arg_2_0.onClickCurrency, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCloseTips, arg_2_0.onClickCloseTips, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, arg_2_0.onWeekInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnAttrUpdate, arg_2_0.onAttrUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, arg_2_0.onNpcPostionChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnCurrency)
	arg_3_0:removeClickCb(arg_3_0.btnCloseTips)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, arg_3_0.onWeekInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnAttrUpdate, arg_3_0.onAttrUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, arg_3_0.onNpcPostionChange, arg_3_0)
end

function var_0_0.onWeekInfoUpdate(arg_4_0)
	arg_4_0:refreshCurrency()
end

function var_0_0.onAttrUpdate(arg_5_0)
	arg_5_0:refreshCurrency()
end

function var_0_0.onNpcPostionChange(arg_6_0)
	arg_6_0:refreshCurrency()
end

function var_0_0.onShelterBagUpdate(arg_7_0)
	arg_7_0:refreshCurrency()
end

function var_0_0.onClickCurrency(arg_8_0)
	arg_8_0:setTipsVisible(true)
end

function var_0_0.onClickCloseTips(arg_9_0)
	arg_9_0:setTipsVisible(false)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:setTipsVisible(false)
	arg_10_0:refreshCurrency()
end

function var_0_0.setTipsVisible(arg_11_0, arg_11_1)
	if arg_11_0._tipsVisible == arg_11_1 then
		return
	end

	arg_11_0._tipsVisible = arg_11_1

	gohelper.setActive(arg_11_0.goArrow, not arg_11_1)
	gohelper.setActive(arg_11_0.goTips, arg_11_1)

	if arg_11_1 then
		arg_11_0:refreshSpeed()
	end
end

function var_0_0.refreshCurrency(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.currencyList) do
		local var_12_0 = arg_12_0:getCurrencyItem(iter_12_0)

		arg_12_0:refreshCurrencyItem(var_12_0, iter_12_1)
	end

	arg_12_0:refreshSpeed()
end

function var_0_0.getCurrencyItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.currencyItemList[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "go_normalroot/Top/#go_currency/#go_tag/tag" .. arg_13_1)
		var_13_0.txtNum = gohelper.findChildTextMesh(var_13_0.go, "#txt_tag")
		arg_13_0.currencyItemList[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.refreshCurrencyItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_14_1 = var_14_0.bag:getItemCountPlus(arg_14_2)

	if arg_14_2 == SurvivalEnum.CurrencyType.Food then
		if var_14_1 >= var_14_0:getNpcCost() then
			arg_14_1.txtNum.text = var_14_1
		else
			arg_14_1.txtNum.text = string.format("<color=#ff0000>%s</color>", var_14_1)
		end
	else
		arg_14_1.txtNum.text = var_14_1
	end
end

function var_0_0.refreshSpeed(arg_15_0)
	if not arg_15_0._tipsVisible then
		return
	end

	local var_15_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcCost()

	arg_15_0.txtSpeed.text = formatLuaLang("survival_mainview_foodcost_speed", var_15_0)
end

return var_0_0
