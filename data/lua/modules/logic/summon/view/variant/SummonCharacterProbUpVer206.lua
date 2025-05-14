module("modules.logic.summon.view.variant.SummonCharacterProbUpVer206", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer206", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_0/v2a0_lake/v20a_summonlake_bg.png",
	"singlebg/summon/heroversion_2_0/v2a0_lake/v20a_summonlake_role1.png",
	"singlebg/summon/heroversion_2_0/v2a0_lake/v20a_summonlake_role2.png",
	"singlebg/summon/heroversion_2_0/v2a0_lake/v20a_summonlake_mask.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagead1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad1")
	arg_1_0._simagead2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad2")
	arg_1_0._simagefullmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_fullmask")
	arg_1_0._gobefore30 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#go_before30")
	arg_1_0._txtcurrency_current = gohelper.findChildText(arg_1_0._gobefore30, "#txt_currency_current")
	arg_1_0._txtcurrency_before = gohelper.findChildText(arg_1_0._gobefore30, "#txt_currency_before")
	arg_1_0._gotag = gohelper.findChild(arg_1_0._gobefore30, "#go_tag")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0._gotag, "#txt_num")
	arg_1_0._textEN = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/textEN")
	arg_1_0._charaterItemCount = 2
	arg_1_0._txtcurrency102.text = ""
	arg_1_0._txtcurrency101.text = ""

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagead1:UnLoadImage()
	arg_3_0._simagead2:UnLoadImage()
	arg_3_0._simagefullmask:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

function var_0_0._parseCost(arg_4_0)
	if string.nilorempty(arg_4_0) then
		return -1, 0, 0
	end

	return SummonMainModel.instance.getCostByConfig(arg_4_0)
end

function var_0_0._checkIsEnough(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_2 <= ItemModel.instance:getItemQuantity(arg_5_0, arg_5_1)
end

function var_0_0._refreshView(arg_6_0, ...)
	local var_6_0 = SummonMainModel.instance:getCurPool()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.id

	arg_6_0._currentCostInfo = var_0_0._getCostInfo(var_6_1)

	var_0_0.super._refreshView(arg_6_0, ...)
end

function var_0_0._getCostInfo(arg_7_0)
	local var_7_0 = {
		cost_num = 0,
		cost_num_before = 0,
		discountPercent01 = 0,
		cost_id = 0,
		cost_type = -1
	}

	if not arg_7_0 then
		return var_7_0
	end

	local var_7_1 = SummonConfig.instance:getSummonPool(arg_7_0)

	if not var_7_1 then
		return var_7_0
	end

	local var_7_2, var_7_3, var_7_4 = var_0_0._parseCost(var_7_1.cost10)

	if var_7_2 < 0 then
		return var_7_0
	end

	var_7_0.cost_type = var_7_2
	var_7_0.cost_id = var_7_3
	var_7_0.cost_num = var_7_4
	var_7_0.cost_num_before = var_7_4

	if string.nilorempty(var_7_1.discountCost10) then
		return var_7_0
	end

	local var_7_5 = string.split(var_7_1.discountCost10, "|")

	for iter_7_0, iter_7_1 in ipairs(var_7_5) do
		local var_7_6 = string.splitToNumber(iter_7_1, "#")
		local var_7_7 = var_7_6[1]
		local var_7_8 = var_7_6[2]
		local var_7_9 = var_7_6[3]

		if var_7_7 == var_7_0.cost_type and var_7_0.cost_id == var_7_8 then
			if SummonMainModel.instance:getDiscountTime10Server(arg_7_0) > 0 then
				var_7_0.discountPercent01 = (var_7_0.cost_num - var_7_9) / var_7_0.cost_num
				var_7_0.cost_num = var_7_9
			end

			break
		end
	end

	return var_7_0
end

function var_0_0._btnsummon10OnClick(arg_8_0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	local var_8_0 = arg_8_0._currentCostInfo
	local var_8_1 = var_8_0.cost_type
	local var_8_2 = var_8_0.cost_id
	local var_8_3 = var_8_0.cost_num
	local var_8_4 = {
		type = var_8_1,
		id = var_8_2,
		quantity = var_8_3,
		callback = arg_8_0._summon10Confirm,
		callbackObj = arg_8_0
	}

	var_8_4.notEnough = false

	local var_8_5 = ItemModel.instance:getItemQuantity(var_8_1, var_8_2)
	local var_8_6 = var_8_3 <= var_8_5
	local var_8_7 = SummonMainModel.instance.everyCostCount
	local var_8_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_8_9 = var_8_3 - var_8_5
	local var_8_10 = var_8_7 * var_8_9

	if not var_8_6 and var_8_8 < var_8_10 then
		var_8_4.notEnough = true
	end

	if var_8_6 then
		var_8_4.needTransform = false

		arg_8_0:_summon10Confirm()

		return
	else
		var_8_4.needTransform = true
		var_8_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_8_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_8_4.cost_quantity = var_8_10
		var_8_4.miss_quantity = var_8_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_8_4)
end

function var_0_0._refreshCost(arg_9_0)
	local var_9_0 = SummonMainModel.instance:getCurPool()

	if var_9_0 then
		arg_9_0:_refreshSingleCost(var_9_0.cost1, arg_9_0._simagecurrency1, "_txtcurrency1")
		arg_9_0:_refreshCost10()
	end
end

function var_0_0._refreshCost10(arg_10_0)
	local var_10_0 = SummonMainModel.instance:getCurPool()

	if not var_10_0 then
		arg_10_0._txtcurrency101.text = ""
		arg_10_0._txtcurrency102.text = ""
		arg_10_0._textEN.text = ""

		gohelper.setActive(arg_10_0._gobefore30, false)

		return
	end

	local var_10_1 = arg_10_0._currentCostInfo
	local var_10_2 = var_10_1.cost_num
	local var_10_3 = var_10_1.cost_id
	local var_10_4 = var_10_1.cost_type
	local var_10_5 = var_10_1.discountPercent01
	local var_10_6 = var_10_1.cost_num_before
	local var_10_7 = var_10_5 > 0

	gohelper.setActive(arg_10_0._gotag, var_10_7)
	gohelper.setActive(arg_10_0._gobefore30, var_10_7)

	arg_10_0._textEN.text = "SUMMON*" .. var_10_2

	if var_10_5 <= 0 then
		arg_10_0:_refreshSingleCost(var_10_0.cost10, arg_10_0._simagecurrency10, "_txtcurrency10")
	else
		local var_10_8 = SummonMainModel.getSummonItemIcon(var_10_4, var_10_3)

		arg_10_0._simagecurrency10:LoadImage(var_10_8)

		arg_10_0._txtcurrency102.text = ""
		arg_10_0._txtcurrency101.text = ""
		arg_10_0._txtnum.text = "-" .. var_10_5 * 100 .. "%"
		arg_10_0._txtcurrency_before.text = var_10_6
		arg_10_0._txtcurrency_current.text = luaLang("multiple") .. var_10_2
	end
end

return var_0_0
