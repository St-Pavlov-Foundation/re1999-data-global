module("modules.logic.summon.view.luckybag.SummonLuckyBagProbabilityView", package.seeall)

local var_0_0 = class("SummonLuckyBagProbabilityView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "infoScroll/Viewport/#go_Content")
	arg_1_0._goinfoItem = gohelper.findChild(arg_1_0.viewGO, "infoScroll/Viewport/#go_Content/#go_infoItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._infoItemTab = {}
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._poolParam = SummonController.instance:getPoolInfo()
	arg_6_0._poolId = arg_6_0._poolParam.poolId
	arg_6_0._poolDetailId = arg_6_0._poolParam.poolDetailId
	arg_6_0._poolAwardTime = arg_6_0._poolParam.poolAwardTime
	arg_6_0._maxAwardTime = string.splitToNumber(arg_6_0._poolAwardTime, "|")[2]

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = SummonConfig.instance:getPoolDetailConfig(arg_7_0._poolDetailId).desc

	if string.nilorempty(var_7_0) then
		var_7_0 = CommonConfig.instance:getConstStr(ConstEnum.SummonPoolDetail)
	end

	local var_7_1 = string.split(var_7_0, "#")
	local var_7_2 = SummonConfig.instance:getSummonPool(arg_7_0._poolId)

	arg_7_0._rareHeroNames = arg_7_0:buildRareNameDict(var_7_2)
	arg_7_0._rareRates = arg_7_0:buildRateRareDict(var_7_2)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_3 = arg_7_0._infoItemTab[iter_7_0]

		if not var_7_3 then
			var_7_3 = arg_7_0:getUserDataTb_()
			var_7_3.go = gohelper.clone(arg_7_0._goinfoItem, arg_7_0._goContent, "item" .. iter_7_0)
			var_7_3.txthero = gohelper.findChildText(var_7_3.go, "#txt_descContent")
			var_7_3.txtprobability = gohelper.findChildText(var_7_3.go, "desctitle/#go_starList/probability/#txt_probability")
			var_7_3.goprobup = gohelper.findChild(var_7_3.go, "#go_probup")
			arg_7_0._infoItemTab[iter_7_0] = var_7_3
		end

		gohelper.setActive(var_7_3.go, true)
		arg_7_0:_refreshSummonDesc(var_7_3, iter_7_1)

		for iter_7_2 = 1, 6 do
			gohelper.setActive(gohelper.findChild(var_7_3.go, "desctitle/#go_starList/star" .. iter_7_2), iter_7_2 <= arg_7_0._rate)
		end
	end
end

function var_0_0._refreshSummonDesc(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.txthero
	local var_8_1 = arg_8_1.txtprobability

	var_8_0.text = ""
	var_8_1.text = ""
	arg_8_0._rate = 0
	arg_8_2 = string.format(arg_8_2, arg_8_0._maxAwardTime - 1, arg_8_0._maxAwardTime)

	for iter_8_0 in arg_8_2:gmatch("%[heroname=.-%]") do
		local var_8_2, var_8_3, var_8_4, var_8_5, var_8_6 = string.find(iter_8_0, "(%[heroname=)(.*)(%])")
		local var_8_7 = string.splitToNumber(var_8_5, "#")
		local var_8_8 = ""
		local var_8_9 = {}

		for iter_8_1, iter_8_2 in ipairs(var_8_7) do
			local var_8_10 = arg_8_0._rareHeroNames[iter_8_2] or {}
			local var_8_11 = table.concat(var_8_10, "|")

			table.insert(var_8_9, var_8_11)
		end

		local var_8_12 = table.concat(var_8_9, "|")

		iter_8_0 = string.format("%s%s%s", "%[heroname=", var_8_5, "%]")
		arg_8_2 = string.gsub(arg_8_2, iter_8_0, var_8_12)
		var_8_0.text = string.format(var_8_12)
	end

	for iter_8_3 in arg_8_2:gmatch("%[rate=.-%]") do
		local var_8_13, var_8_14, var_8_15, var_8_16, var_8_17 = string.find(iter_8_3, "(%[rate=)(.*)(%])")
		local var_8_18 = string.splitToNumber(var_8_16, "#")
		local var_8_19 = 0

		for iter_8_4, iter_8_5 in ipairs(var_8_18) do
			var_8_19 = var_8_19 + (arg_8_0._rareRates[iter_8_5] or 0)
		end

		local var_8_20 = string.format("%s%%%%", var_8_19 * 100 - var_8_19 * 100 % 0.1)

		iter_8_3 = string.format("%s%s%s", "%[rate=", var_8_16, "%]")
		arg_8_2 = string.gsub(arg_8_2, iter_8_3, var_8_20)
		var_8_1.text = string.format(var_8_20)
		arg_8_0._rate = CharacterEnum.Star[tonumber(var_8_16)]
	end
end

function var_0_0.buildRareNameDict(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, 5 do
		var_9_0[iter_9_0] = {}
	end

	local var_9_1 = SummonMainModel.getResultType(arg_9_1)
	local var_9_2 = SummonConfig.instance:getSummon(arg_9_0._poolId)

	if not var_9_2 then
		logError("lua_summon poolId = " .. tostring(arg_9_0._poolId) .. " is nil")

		return var_9_0
	end

	for iter_9_1, iter_9_2 in pairs(var_9_2) do
		local var_9_3 = iter_9_2.summonId
		local var_9_4 = string.splitToNumber(var_9_3, "#")

		for iter_9_3, iter_9_4 in ipairs(var_9_4) do
			local var_9_5 = HeroConfig.instance:getHeroCO(iter_9_4).name

			table.insert(var_9_0[iter_9_1], var_9_5)
		end

		local var_9_6 = iter_9_2.luckyBagId
		local var_9_7 = string.splitToNumber(var_9_6, "#")

		for iter_9_5, iter_9_6 in ipairs(var_9_7) do
			local var_9_8 = SummonConfig.instance:getLuckyBag(iter_9_2.id, iter_9_6).name

			table.insert(var_9_0[iter_9_1], var_9_8)
		end
	end

	return var_9_0
end

function var_0_0.buildRateRareDict(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_1.initWeight
	local var_10_2

	if not string.nilorempty(var_10_1) then
		local var_10_3 = string.split(var_10_1, "|")

		for iter_10_0, iter_10_1 in ipairs(var_10_3) do
			local var_10_4 = string.split(iter_10_1, "#")

			var_10_0[tonumber(var_10_4[1])] = (tonumber(var_10_4[2]) or 0) / 10000
		end
	end

	return var_10_0
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
