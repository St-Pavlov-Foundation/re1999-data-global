module("modules.logic.survival.model.map.SurvivalChoiceMo", package.seeall)

local var_0_0 = class("SurvivalChoiceMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.callback = nil
	arg_1_0.callobj = nil
	arg_1_0.param = nil
	arg_1_0.desc = ""
	arg_1_0.icon = SurvivalEnum.EventChoiceIcon.None
	arg_1_0.color = SurvivalEnum.EventChoiceColor.Green
	arg_1_0.conditionStr = ""
	arg_1_0.resultStr = ""
	arg_1_0.otherParam = ""
	arg_1_0.unitId = 0
	arg_1_0.treeId = 0

	arg_1_0:clearValues()
end

function var_0_0.Create(arg_2_0)
	local var_2_0 = var_0_0.New()

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.callback = arg_3_1.callback
	arg_3_0.callobj = arg_3_1.callobj
	arg_3_0.param = arg_3_1.param
	arg_3_0.desc = arg_3_1.desc or ""
	arg_3_0.icon = arg_3_1.icon or SurvivalEnum.EventChoiceIcon.None
	arg_3_0.conditionStr = arg_3_1.conditionStr or ""
	arg_3_0.resultStr = arg_3_1.resultStr or ""
	arg_3_0.unitId = arg_3_1.unitId or 0
	arg_3_0.otherParam = arg_3_1.otherParam or ""

	arg_3_0:refreshData()
end

function var_0_0.clearValues(arg_4_0)
	arg_4_0.exStr = nil
	arg_4_0.isValid = true
	arg_4_0.isCostTime = false
	arg_4_0.exStepDesc = nil
	arg_4_0.exShowItemMos = nil
	arg_4_0.npcWorthCheck = nil
	arg_4_0.isShowBogusBtn = false
	arg_4_0.exBogusData = nil
	arg_4_0.openFogRange = nil
end

function var_0_0.refreshData(arg_5_0)
	arg_5_0.color = SurvivalEnum.IconToColor[arg_5_0.icon]

	arg_5_0:checkConditionStr()
end

function var_0_0.checkConditionStr(arg_6_0)
	arg_6_0:clearValues()

	if not string.nilorempty(arg_6_0.conditionStr) then
		local var_6_0 = string.split(arg_6_0.conditionStr, "|")
		local var_6_1 = var_6_0[1]
		local var_6_2 = var_0_0["checkCondition_" .. var_6_1]

		if var_6_2 then
			var_6_2(arg_6_0, var_6_0[2])
		end

		if not string.nilorempty(arg_6_0.exStr) then
			return
		end
	end

	if not string.nilorempty(arg_6_0.resultStr) then
		local var_6_3 = string.split(arg_6_0.resultStr, "|")
		local var_6_4 = var_6_3[1]
		local var_6_5 = var_0_0["checkCondition_" .. var_6_4]

		if var_6_5 then
			var_6_5(arg_6_0, var_6_3[2])
		end
	end
end

function var_0_0.checkCondition_CostGameTime(arg_7_0, arg_7_1)
	local var_7_0 = tonumber(arg_7_1) or 0
	local var_7_1 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.ChoiceCostTime, var_7_0)
	local var_7_2 = SurvivalMapModel.instance:getSceneMo()

	arg_7_0.isCostTime = true
	arg_7_0.isValid = var_7_1 <= var_7_2.currMaxGameTime - var_7_2.gameTime
	arg_7_0.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_costtime"), var_7_1)
end

function var_0_0.checkCondition_AddHealth(arg_8_0, arg_8_1)
	arg_8_0.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_changehealth"), "+" .. arg_8_1)
end

function var_0_0.checkCondition_DeductHealth(arg_9_0, arg_9_1)
	arg_9_0.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_changehealth"), "-" .. arg_9_1)
end

function var_0_0.checkCondition_ItemGE(arg_10_0, arg_10_1)
	local var_10_0 = string.splitToNumber(arg_10_1, "#")
	local var_10_1 = var_10_0[1] or 0
	local var_10_2 = var_10_0[2] or 0

	arg_10_0.isValid = var_10_2 <= SurvivalMapModel.instance:getSceneMo().bag:getItemCountPlus(var_10_1)

	if not arg_10_0.isValid then
		local var_10_3 = lua_survival_item.configDict[var_10_1]

		arg_10_0.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), var_10_3 and var_10_3.name or "", var_10_2)
	end
end

function var_0_0.checkCondition_ItemLT(arg_11_0, arg_11_1)
	local var_11_0 = string.splitToNumber(arg_11_1, "#")
	local var_11_1 = var_11_0[1] or 0
	local var_11_2 = var_11_0[2] or 0

	arg_11_0.isValid = var_11_2 > SurvivalMapModel.instance:getSceneMo().bag:getItemCountPlus(var_11_1)

	if not arg_11_0.isValid then
		local var_11_3 = lua_survival_item.configDict[var_11_1]

		arg_11_0.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyLT"), var_11_3 and var_11_3.name or "", var_11_2)
	end
end

function var_0_0.checkCondition_AddItem(arg_12_0, arg_12_1)
	local var_12_0 = GameUtil.splitString2(arg_12_1, true, "&", ":")

	arg_12_0.isValid = true

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = iter_12_1[1]
		local var_12_2 = iter_12_1[2]
		local var_12_3 = SurvivalBagItemMo.New()

		var_12_3:init({
			id = var_12_1,
			count = var_12_2
		})

		if var_12_3:isCurrency() and var_12_3.id == SurvivalEnum.CurrencyType.Enthusiastic then
			arg_12_0.exStr = luaLang("survival_choice_enthusiastic_get")
		elseif var_12_3:isCurrency() and var_12_3.id < SurvivalEnum.CurrencyType.Enthusiastic then
			arg_12_0.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_getitem"), var_12_3.co.name, var_12_2)
		elseif not var_12_3:isCurrency() then
			-- block empty
		end
	end
end

function var_0_0.checkCondition_CostPointItem(arg_13_0, arg_13_1)
	arg_13_0.exStr = luaLang("survival_choice_enthusiastic_cost")
end

function var_0_0.checkCondition_CostItem(arg_14_0, arg_14_1)
	local var_14_0 = GameUtil.splitString2(arg_14_1, true, "&", ":")
	local var_14_1 = SurvivalMapModel.instance:getSceneMo()

	arg_14_0.exShowItemMos = {}
	arg_14_0.isShowBogusBtn = true
	arg_14_0.exStepDesc = luaLang("survival_eventview_commititem")
	arg_14_0.isValid = true

	local var_14_2

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_3 = iter_14_1[1]
		local var_14_4 = iter_14_1[2]
		local var_14_5 = SurvivalBagItemMo.New()

		var_14_5:init({
			id = var_14_3,
			count = var_14_4
		})
		table.insert(arg_14_0.exShowItemMos, var_14_5)

		if not var_14_2 and var_14_5:isCurrency() then
			var_14_2 = var_14_5
		end

		if var_14_4 > var_14_1.bag:getItemCountPlus(var_14_3) and arg_14_0.isValid then
			arg_14_0.isValid = false

			if var_14_5:isCurrency() then
				arg_14_0.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), var_14_5.co.name, var_14_5.count)
			else
				arg_14_0.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), var_14_5.co.name)
			end
		end
	end

	if arg_14_0.isValid and var_14_2 then
		arg_14_0.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_costitem"), var_14_2.co.name, var_14_2.count)
	end
end

function var_0_0.checkCondition_RecrNpc(arg_15_0, arg_15_1)
	local var_15_0 = SurvivalMapModel.instance:getSceneMo()
	local var_15_1 = var_15_0.unitsById[arg_15_0.unitId]

	if not var_15_1 then
		return
	end

	local var_15_2 = lua_survival_recruitment.configDict[var_15_1.co.recruitment]

	if not var_15_2 then
		return
	end

	arg_15_0.isShowBogusBtn = true
	arg_15_0.exStepDesc = var_15_2.desc

	if var_15_2.conditionType == SurvivalEnum.NpcRecruitmentType.ItemCost then
		arg_15_0.exBogusData = {}
		arg_15_0.exBogusData.exStepDesc = luaLang("survival_eventview_commititem")

		local var_15_3 = GameUtil.splitString2(var_15_2.param, true, "&", ":")

		arg_15_0.exBogusData.exShowItemMos = {}
		arg_15_0.exBogusData.isValid = true

		for iter_15_0, iter_15_1 in ipairs(var_15_3) do
			local var_15_4 = iter_15_1[1]
			local var_15_5 = iter_15_1[2]
			local var_15_6 = SurvivalBagItemMo.New()

			var_15_6:init({
				id = var_15_4,
				count = var_15_5
			})
			table.insert(arg_15_0.exBogusData.exShowItemMos, var_15_6)

			if var_15_5 > var_15_0.bag:getItemCountPlus(var_15_4) and arg_15_0.exBogusData.isValid then
				arg_15_0.exBogusData.isValid = false

				if var_15_6:isCurrency() then
					arg_15_0.exBogusData.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), var_15_6.co.name, var_15_5)
				else
					arg_15_0.exBogusData.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), var_15_6.co.name)
				end
			end
		end
	elseif var_15_2.conditionType == SurvivalEnum.NpcRecruitmentType.ItemCheck then
		local var_15_7 = GameUtil.splitString2(var_15_2.param, true, "&", ":")

		for iter_15_2, iter_15_3 in ipairs(var_15_7) do
			local var_15_8 = iter_15_3[1]
			local var_15_9 = iter_15_3[2]

			if var_15_9 > var_15_0.bag:getItemCountPlus(var_15_8) and arg_15_0.isValid then
				arg_15_0.isValid = false

				local var_15_10 = lua_survival_item.configDict[var_15_8]

				if var_15_10.type == SurvivalEnum.ItemType.Currency then
					arg_15_0.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), var_15_10.name, var_15_9)

					break
				end

				arg_15_0.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), var_15_10.name)

				break
			end
		end
	elseif var_15_2.conditionType == SurvivalEnum.NpcRecruitmentType.NpcNumCheck then
		local var_15_11 = string.splitToNumber(var_15_2.param, "#")
		local var_15_12 = var_15_0.bag:getNPCCount()

		arg_15_0.isValid = SurvivalHelper.instance:getOperResult(var_15_11[1], var_15_12, var_15_11[2])

		if not arg_15_0.isValid then
			arg_15_0.exStr = luaLang("survival_choice_recruitmentNPC")
		end
	elseif var_15_2.conditionType == SurvivalEnum.NpcRecruitmentType.WorthCheck then
		arg_15_0.isValid = true
		arg_15_0.npcWorthCheck = tonumber(var_15_2.param) or 0
	elseif var_15_2.conditionType == SurvivalEnum.NpcRecruitmentType.FinishTask or var_15_2.conditionType == SurvivalEnum.NpcRecruitmentType.FinishEvent then
		arg_15_0.isValid = arg_15_0.otherParam == "true"

		if not arg_15_0.isValid then
			arg_15_0.exStr = luaLang("survival_choice_recruitmentNPC")
		end
	end
end

function var_0_0.checkCondition_RemoveFog(arg_16_0, arg_16_1)
	arg_16_0.openFogRange = (string.splitToNumber(arg_16_1, "#") or {})[1] or 0
end

return var_0_0
