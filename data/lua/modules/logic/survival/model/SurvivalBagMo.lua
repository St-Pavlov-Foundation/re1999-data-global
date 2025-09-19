module("modules.logic.survival.model.SurvivalBagMo", package.seeall)

local var_0_0 = pureTable("SurvivalBagMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.bagType = arg_1_1.bagType
	arg_1_0.items = {}
	arg_1_0.itemsByUid = arg_1_0.itemsByUid or {}
	arg_1_0.totalMass = 0
	arg_1_0.maxWeightLimit = arg_1_1.maxWeightLimit
	arg_1_0.currencysById = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.item) do
		local var_1_0 = arg_1_0.itemsByUid[iter_1_1.uid] or SurvivalBagItemMo.New()

		var_1_0:init(iter_1_1)

		var_1_0.source = arg_1_0.bagType

		if var_1_0:isCurrency() then
			arg_1_0.currencysById[var_1_0.id] = var_1_0
		else
			table.insert(arg_1_0.items, var_1_0)
		end

		arg_1_0.totalMass = arg_1_0.totalMass + var_1_0:getMass()
	end

	arg_1_0.itemsByUid = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.items) do
		arg_1_0.itemsByUid[iter_1_3.uid] = iter_1_3
	end

	for iter_1_4, iter_1_5 in pairs(arg_1_0.currencysById) do
		arg_1_0.itemsByUid[iter_1_5.uid] = iter_1_5
	end
end

function var_0_0.addOrUpdateItems(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0:addOrUpdateItem(iter_2_1)
	end
end

function var_0_0.removeItems(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:removeItemByUid(iter_3_1)
	end
end

function var_0_0.addOrUpdateItem(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.itemsByUid[arg_4_1.uid]

	if var_4_0 then
		arg_4_0.totalMass = arg_4_0.totalMass - var_4_0:getMass()

		var_4_0:init(arg_4_1)

		arg_4_0.totalMass = arg_4_0.totalMass + var_4_0:getMass()
	else
		var_4_0 = SurvivalBagItemMo.New()

		var_4_0:init(arg_4_1)

		if var_4_0:isCurrency() then
			if arg_4_0.currencysById[var_4_0.id] then
				logError(string.format("有2个相同货币的数据：[%s]:[%s]  [%s]:[%s]", arg_4_0.currencysById[arg_4_1.id].uid, arg_4_0.currencysById[arg_4_1.id].count, arg_4_1.uid, arg_4_1.count))
			end

			arg_4_0.currencysById[var_4_0.id] = var_4_0
		else
			table.insert(arg_4_0.items, var_4_0)
		end

		arg_4_0.itemsByUid[arg_4_1.uid] = var_4_0
		arg_4_0.totalMass = arg_4_0.totalMass + var_4_0:getMass()
	end

	var_4_0.source = arg_4_0.bagType
end

function var_0_0.removeItemByUid(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.itemsByUid[arg_5_1]

	if var_5_0 then
		arg_5_0.totalMass = arg_5_0.totalMass - var_5_0:getMass()

		if var_5_0:isCurrency() then
			arg_5_0.currencysById[var_5_0.id] = nil
		else
			tabletool.removeValue(arg_5_0.items, var_5_0)
		end

		arg_5_0.itemsByUid[arg_5_1] = nil

		return
	else
		logError("删除道具失败，uid：" .. tostring(arg_5_1))
	end
end

function var_0_0.getCurrencyNum(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.currencysById[arg_6_1]
	local var_6_1 = 0

	if arg_6_0.bagType == SurvivalEnum.ItemSource.Map then
		var_6_1 = SurvivalShelterModel.instance:getWeekInfo().bag:getCurrencyNum(arg_6_1)
	end

	return (var_6_0 and var_6_0.count or 0) + var_6_1
end

function var_0_0.getItemCount(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.items) do
		if iter_7_1.id == arg_7_1 then
			var_7_0 = var_7_0 + iter_7_1.count
		end
	end

	return var_7_0
end

function var_0_0.getItemCountPlus(arg_8_0, arg_8_1)
	local var_8_0 = lua_survival_item.configDict[arg_8_1]

	if not var_8_0 then
		return 0
	end

	if var_8_0.type == SurvivalEnum.ItemType.Currency then
		return arg_8_0:getCurrencyNum(arg_8_1)
	end

	return arg_8_0:getItemCount(arg_8_1)
end

function var_0_0.getNPCCount(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items) do
		if iter_9_1:isNPC() then
			var_9_0 = var_9_0 + iter_9_1.count
		end
	end

	return var_9_0
end

function var_0_0.costIsEnough(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if string.nilorempty(arg_10_1) then
		return true
	end

	local var_10_0 = string.split(arg_10_1, "#")
	local var_10_1 = string.splitToNumber(var_10_0[2], ":")
	local var_10_2 = var_10_1[1]
	local var_10_3 = var_10_1[2]

	if arg_10_2 and arg_10_3 then
		var_10_3 = arg_10_2:getAttr(arg_10_3, var_10_3)
	end

	local var_10_4 = arg_10_0:getItemCountPlus(var_10_2)

	return var_10_3 <= var_10_4, var_10_2, var_10_3, var_10_4
end

function var_0_0.getItemByUid(arg_11_0, arg_11_1)
	return arg_11_0.itemsByUid[arg_11_1]
end

return var_0_0
