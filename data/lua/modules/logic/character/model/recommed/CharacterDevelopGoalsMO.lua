module("modules.logic.character.model.recommed.CharacterDevelopGoalsMO", package.seeall)

local var_0_0 = pureTable("CharacterDevelopGoalsMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._developGoalsType = arg_1_1
	arg_1_0._heroId = arg_1_2
	arg_1_0._isTraced = false
	arg_1_0._heroMo = HeroModel.instance:getByHeroId(arg_1_2)
end

function var_0_0.setItemList(arg_2_0, arg_2_1)
	table.sort(arg_2_1, arg_2_0._sort)

	arg_2_0._itemList = arg_2_1
end

function var_0_0._sort(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.materilType
	local var_3_1 = arg_3_1.materilType

	if var_3_0 ~= var_3_1 then
		if var_3_0 == MaterialEnum.MaterialType.Currency then
			return true
		end

		if var_3_1 == MaterialEnum.MaterialType.Currency then
			return false
		end
	end

	local var_3_2 = arg_3_0.materilId
	local var_3_3 = arg_3_1.materilId

	if var_3_0 == MaterialEnum.MaterialType.Currency then
		return var_3_2 < var_3_3
	end

	local var_3_4 = ItemModel.instance:getItemConfig(var_3_0, var_3_2)
	local var_3_5 = ItemModel.instance:getItemConfig(var_3_1, var_3_3)
	local var_3_6 = var_3_4.subType
	local var_3_7 = var_3_5.subType
	local var_3_8 = lua_subclass_priority.configDict[var_3_6].priority
	local var_3_9 = lua_subclass_priority.configDict[var_3_7].priority

	if var_3_8 ~= var_3_9 then
		return var_3_8 < var_3_9
	end

	local var_3_10 = var_3_4.rare
	local var_3_11 = var_3_5.rare

	if var_3_10 ~= var_3_11 then
		return var_3_11 < var_3_10
	end

	return var_3_2 < var_3_3
end

function var_0_0.getItemList(arg_4_0)
	return arg_4_0._itemList
end

function var_0_0.setTraced(arg_5_0, arg_5_1)
	arg_5_0._isTraced = arg_5_1
end

function var_0_0.isTraced(arg_6_0)
	return arg_6_0._isTraced
end

function var_0_0.getDevelopGoalsType(arg_7_0)
	return arg_7_0._developGoalsType
end

function var_0_0.getTracedItems(arg_8_0)
	if not arg_8_0._itemList then
		return
	end

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._itemList) do
		if ItemModel.instance:getItemQuantity(iter_8_1.materilType, iter_8_1.materilId) < iter_8_1.quantity then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.getHeroSkinCo(arg_9_0)
	if not arg_9_0._heroMo then
		return
	end

	return SkinConfig.instance:getSkinCo(arg_9_0._heroMo.skin)
end

function var_0_0.isCurRankMaxLv(arg_10_0)
	if not arg_10_0._heroMo then
		return
	end

	return CharacterModel.instance:getrankEffects(arg_10_0._heroId, arg_10_0._heroMo.rank)[1] <= arg_10_0._heroMo.level, arg_10_0._heroMo
end

function var_0_0.isMaxTalentLv(arg_11_0)
	if not arg_11_0._heroMo then
		return
	end

	return CharacterModel.instance:getMaxTalent(arg_11_0._heroId) <= arg_11_0._heroMo.talent, arg_11_0._heroMo
end

function var_0_0.isOwnHero(arg_12_0)
	return arg_12_0._heroMo and arg_12_0._heroMo:isOwnHero()
end

function var_0_0.setTitleTxtAndIcon(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._titleTxt = arg_13_1
	arg_13_0._titleIcon = arg_13_2
end

function var_0_0.getTitleTxtAndIcon(arg_14_0)
	return arg_14_0._titleTxt, arg_14_0._titleIcon
end

return var_0_0
