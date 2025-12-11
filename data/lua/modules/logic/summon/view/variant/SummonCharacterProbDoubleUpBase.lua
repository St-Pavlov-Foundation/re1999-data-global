module("modules.logic.summon.view.variant.SummonCharacterProbDoubleUpBase", package.seeall)

local var_0_0 = class("SummonCharacterProbDoubleUpBase", SummonMainCharacterProbUp)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._gobefore30 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#go_before30")
	arg_1_0._txtcurrency_current = gohelper.findChildText(arg_1_0._gobefore30, "#txt_currency_current")
	arg_1_0._txtcurrency_before = gohelper.findChildText(arg_1_0._gobefore30, "#txt_currency_before")
	arg_1_0._gotag = gohelper.findChild(arg_1_0._gobefore30, "#go_tag")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0._gotag, "#txt_num")
	arg_1_0._textEN = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/textEN")
	arg_1_0._tip = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/tip")
	arg_1_0._freetag = gohelper.findChild(arg_1_0._tip, "freetag")
	arg_1_0._arrow = gohelper.findChild(arg_1_0._tip, "arrow")
	arg_1_0._tipHLayoutGroup = arg_1_0._tip:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_1_0._txtcurrency102.text = ""
	arg_1_0._txtcurrency101.text = ""

	var_0_0.super._editableInitView(arg_1_0)
end

local function var_0_1(arg_2_0)
	if string.nilorempty(arg_2_0) then
		return -1, 0, 0
	end

	return SummonMainModel.instance.getCostByConfig(arg_2_0)
end

local function var_0_2(arg_3_0)
	local var_3_0 = {
		cost_num = 0,
		cost_num_before = 0,
		discountPercent01 = 0,
		cost_id = 0,
		cost_type = -1
	}

	if not arg_3_0 then
		return var_3_0
	end

	local var_3_1 = SummonConfig.instance:getSummonPool(arg_3_0)

	if not var_3_1 then
		return var_3_0
	end

	local var_3_2, var_3_3, var_3_4 = var_0_1(var_3_1.cost10)

	if var_3_2 < 0 then
		return var_3_0
	end

	var_3_0.cost_type = var_3_2
	var_3_0.cost_id = var_3_3
	var_3_0.cost_num = var_3_4
	var_3_0.cost_num_before = var_3_4

	if string.nilorempty(var_3_1.discountCost10) then
		return var_3_0
	end

	local var_3_5 = string.split(var_3_1.discountCost10, "|")

	for iter_3_0, iter_3_1 in ipairs(var_3_5) do
		local var_3_6 = string.splitToNumber(iter_3_1, "#")
		local var_3_7 = var_3_6[1]
		local var_3_8 = var_3_6[2]
		local var_3_9 = var_3_6[3]

		if var_3_7 == var_3_0.cost_type and var_3_0.cost_id == var_3_8 then
			if SummonMainModel.instance:getDiscountTime10Server(arg_3_0) > 0 then
				var_3_0.discountPercent01 = (var_3_0.cost_num - var_3_9) / var_3_0.cost_num
				var_3_0.cost_num = var_3_9
			end

			break
		end
	end

	return var_3_0
end

function var_0_0._refreshView(arg_4_0, ...)
	local var_4_0 = SummonMainModel.instance:getCurPool()

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.id

	arg_4_0._currentCostInfo = var_0_2(var_4_1)

	var_0_0.super._refreshView(arg_4_0, ...)
end

function var_0_0._btnsummon10OnClick(arg_5_0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	local var_5_0 = arg_5_0._currentCostInfo
	local var_5_1 = var_5_0.cost_type
	local var_5_2 = var_5_0.cost_id
	local var_5_3 = var_5_0.cost_num
	local var_5_4 = {
		type = var_5_1,
		id = var_5_2,
		quantity = var_5_3,
		callback = arg_5_0._summon10Confirm,
		callbackObj = arg_5_0
	}

	var_5_4.notEnough = false

	local var_5_5 = ItemModel.instance:getItemQuantity(var_5_1, var_5_2)
	local var_5_6 = var_5_3 <= var_5_5
	local var_5_7 = SummonMainModel.instance.everyCostCount
	local var_5_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_5_9 = var_5_3 - var_5_5
	local var_5_10 = var_5_7 * var_5_9

	if not var_5_6 and var_5_8 < var_5_10 then
		var_5_4.notEnough = true
	end

	if var_5_6 then
		var_5_4.needTransform = false

		arg_5_0:_summon10Confirm()

		return
	else
		var_5_4.needTransform = true
		var_5_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_5_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_5_4.cost_quantity = var_5_10
		var_5_4.miss_quantity = var_5_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_5_4)
end

function var_0_0._refreshCost(arg_6_0)
	local var_6_0 = SummonMainModel.instance:getCurPool()

	if var_6_0 then
		arg_6_0:_refreshSingleCost(var_6_0.cost1, arg_6_0._simagecurrency1, "_txtcurrency1")
		arg_6_0:_refreshCost10()
	end
end

function var_0_0._refreshCost10(arg_7_0)
	local var_7_0 = SummonMainModel.instance:getCurPool()

	if not var_7_0 then
		arg_7_0._txtcurrency101.text = ""
		arg_7_0._txtcurrency102.text = ""
		arg_7_0._textEN.text = ""

		gohelper.setActive(arg_7_0._gobefore30, false)

		return
	end

	local var_7_1 = arg_7_0._currentCostInfo
	local var_7_2 = var_7_1.cost_num
	local var_7_3 = var_7_1.cost_id
	local var_7_4 = var_7_1.cost_type
	local var_7_5 = var_7_1.discountPercent01
	local var_7_6 = var_7_1.cost_num_before
	local var_7_7 = var_7_5 > 0

	gohelper.setActive(arg_7_0._gotag, var_7_7)
	gohelper.setActive(arg_7_0._gobefore30, var_7_7)
	gohelper.setActive(arg_7_0._freetag, var_7_7)

	arg_7_0._textEN.text = "SUMMON*" .. var_7_2

	if var_7_5 <= 0 then
		arg_7_0:_refreshSingleCost(var_7_0.cost10, arg_7_0._simagecurrency10, "_txtcurrency10")
	else
		local var_7_8 = SummonMainModel.getSummonItemIcon(var_7_4, var_7_3)

		arg_7_0._simagecurrency10:LoadImage(var_7_8)

		arg_7_0._txtcurrency102.text = ""
		arg_7_0._txtcurrency101.text = ""
		arg_7_0._txtnum.text = "-" .. var_7_5 * 100 .. "%"
		arg_7_0._txtcurrency_before.text = var_7_6
		arg_7_0._txtcurrency_current.text = luaLang("multiple") .. var_7_2
	end

	if LangSettings.instance:isEn() then
		gohelper.setActive(arg_7_0._arrow, true)
	else
		gohelper.setActive(arg_7_0._arrow, not var_7_7)

		local var_7_9 = arg_7_0._tipHLayoutGroup.padding

		if var_7_7 then
			arg_7_0._tipHLayoutGroup.spacing = -60
			var_7_9.left = -300
		else
			var_7_9.left = 110
			arg_7_0._tipHLayoutGroup.spacing = 20
		end
	end
end

return var_0_0
