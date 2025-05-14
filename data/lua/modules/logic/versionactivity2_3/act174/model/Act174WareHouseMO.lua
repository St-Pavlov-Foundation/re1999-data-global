module("modules.logic.versionactivity2_3.act174.model.Act174WareHouseMO", package.seeall)

local var_0_0 = pureTable("Act174WareHouseMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.newHeroDic = {}
	arg_1_0.newItemDic = {}
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.enhanceId = arg_1_1.enhanceId

	arg_1_0:caculateEnhanceRole(arg_1_0.enhanceId)

	arg_1_0.endEnhanceId = arg_1_1.endEnhanceId
	arg_1_0.itemId = arg_1_1.itemId
end

function var_0_0.update(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.heroId) do
		if not tabletool.indexOf(arg_2_0.heroId, iter_2_1) then
			arg_2_0.newHeroDic[iter_2_1] = 1
		end
	end

	local var_2_0 = var_0_0.getItemCntDic(arg_2_1.itemId)

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.itemId) do
		if var_2_0[iter_2_3] then
			var_2_0[iter_2_3] = var_2_0[iter_2_3] - 1

			if var_2_0[iter_2_3] == 0 then
				var_2_0[iter_2_3] = nil
			end
		end
	end

	for iter_2_4, iter_2_5 in pairs(var_2_0) do
		local var_2_1 = arg_2_0.newItemDic[iter_2_4]

		if var_2_1 then
			arg_2_0.newItemDic[iter_2_4] = var_2_1 + iter_2_5
		else
			arg_2_0.newItemDic[iter_2_4] = iter_2_5
		end
	end

	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.itemId = arg_2_1.itemId
	arg_2_0.enhanceId = arg_2_1.enhanceId

	arg_2_0:caculateEnhanceRole(arg_2_0.enhanceId)

	arg_2_0.endEnhanceId = arg_2_1.endEnhanceId
end

function var_0_0.getHeroData(arg_3_0)
	local var_3_0 = Activity174Model.instance:getActInfo():getGameInfo()
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.heroId) do
		local var_3_2 = var_3_0:isHeroInTeam(iter_3_1)

		var_3_1[iter_3_0] = {
			id = iter_3_1,
			isEquip = var_3_2
		}
	end

	table.sort(var_3_1, var_0_0.SortRoleFunc)

	return var_3_1
end

function var_0_0.getItemData(arg_4_0)
	local var_4_0 = Activity174Model.instance:getActInfo():getGameInfo()
	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemId) do
		if not var_4_2[iter_4_1] then
			var_4_2[iter_4_1] = var_4_0:getCollectionEquipCnt(iter_4_1)
		end

		local var_4_3 = var_4_2[iter_4_1]
		local var_4_4 = 0

		if var_4_3 > 0 then
			var_4_4 = 1
			var_4_2[iter_4_1] = var_4_3 - 1
		end

		var_4_1[iter_4_0] = {
			id = iter_4_1,
			isEquip = var_4_4
		}
	end

	table.sort(var_4_1, var_0_0.SortItemFunc)

	return var_4_1
end

function var_0_0.SortRoleFunc(arg_5_0, arg_5_1)
	if arg_5_0.isEquip == arg_5_1.isEquip then
		local var_5_0 = Activity174Config.instance:getRoleCo(arg_5_0.id)
		local var_5_1 = Activity174Config.instance:getRoleCo(arg_5_1.id)

		if var_5_0.rare == var_5_1.rare then
			return arg_5_0.id > arg_5_1.id
		else
			return var_5_0.rare > var_5_1.rare
		end
	else
		return arg_5_0.isEquip > arg_5_1.isEquip
	end
end

function var_0_0.SortItemFunc(arg_6_0, arg_6_1)
	if arg_6_0.isEquip == arg_6_1.isEquip then
		local var_6_0 = Activity174Config.instance:getCollectionCo(arg_6_0.id)
		local var_6_1 = Activity174Config.instance:getCollectionCo(arg_6_1.id)

		if var_6_0.rare == var_6_1.rare then
			return arg_6_0.id > arg_6_1.id
		else
			return var_6_0.rare > var_6_1.rare
		end
	else
		return arg_6_0.isEquip > arg_6_1.isEquip
	end
end

function var_0_0.getItemCntDic(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		if not var_7_0[iter_7_1] then
			var_7_0[iter_7_1] = 1
		else
			var_7_0[iter_7_1] = var_7_0[iter_7_1] + 1
		end
	end

	return var_7_0
end

function var_0_0.getNewIdDic(arg_8_0, arg_8_1)
	if arg_8_1 == Activity174Enum.WareType.Hero then
		return tabletool.copy(arg_8_0.newHeroDic)
	else
		return tabletool.copy(arg_8_0.newItemDic)
	end
end

function var_0_0.deleteNewSign(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 == Activity174Enum.WareType.Hero then
		var_9_0 = arg_9_0.newHeroDic
	else
		var_9_0 = arg_9_0.newItemDic
	end

	if var_9_0[arg_9_2] then
		var_9_0[arg_9_2] = var_9_0[arg_9_2] - 1

		if var_9_0[arg_9_2] == 0 then
			var_9_0[arg_9_2] = nil
		end
	end
end

function var_0_0.clearNewSign(arg_10_0)
	tabletool.clear(arg_10_0.newHeroDic)
	tabletool.clear(arg_10_0.newItemDic)
end

function var_0_0.caculateEnhanceRole(arg_11_0, arg_11_1)
	arg_11_0.enhanceRoleList = {}

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = lua_activity174_enhance.configDict[iter_11_1]

		if var_11_1 then
			if not string.nilorempty(var_11_1.effects) then
				local var_11_2 = string.splitToNumber(var_11_1.effects, "|")

				tabletool.addValues(var_11_0, var_11_2)
			end
		else
			logError("dont exist enhanceCo" .. iter_11_1)
		end
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_3 = lua_activity174_effect.configDict[iter_11_3]

		if var_11_3 then
			if var_11_3.type == Activity174Enum.EffectType.EnhanceRole then
				arg_11_0.enhanceRoleList[#arg_11_0.enhanceRoleList + 1] = tonumber(var_11_3.typeParam)
			end
		else
			logError("dont exist enhanceCo" .. iter_11_3)
		end
	end
end

return var_0_0
