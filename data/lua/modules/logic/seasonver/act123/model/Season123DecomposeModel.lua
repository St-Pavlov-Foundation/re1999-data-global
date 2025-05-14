module("modules.logic.seasonver.act123.model.Season123DecomposeModel", package.seeall)

local var_0_0 = class("Season123DecomposeModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.release(arg_2_0)
	arg_2_0._itemStartAnimTime = nil
	arg_2_0._itemUid2HeroUid = nil
	arg_2_0._itemMap = {}
	arg_2_0.curSelectItemDict = {}
	arg_2_0.curSelectItemCount = 0
	arg_2_0.rareSelectTab = {}
	arg_2_0.tagSelectTab = {}
	arg_2_0.rareAscendState = false
	arg_2_0.curOverPartSelectIndex = 1
	arg_2_0.itemColunmCount = 6
	arg_2_0.AnimRowCount = 4
	arg_2_0.OpenAnimTime = 0.06
	arg_2_0.OpenAnimStartTime = 0.05
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
end

function var_0_0.initDatas(arg_4_0, arg_4_1)
	arg_4_0.curActId = arg_4_1
	arg_4_0.curSelectItemDict = {}
	arg_4_0.curSelectItemCount = 0
	arg_4_0.rareSelectTab = {}
	arg_4_0.tagSelectTab = {}
	arg_4_0.rareAscendState = false
	arg_4_0.curOverPartSelectIndex = arg_4_0.curOverPartSelectIndex or 1
	arg_4_0.itemColunmCount = 6

	arg_4_0:initPosList()
	arg_4_0:initList()
end

function var_0_0.initList(arg_5_0)
	local var_5_0 = {}

	arg_5_0._itemMap = Season123Model.instance:getAllItemMo(arg_5_0.curActId) or {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._itemMap) do
		local var_5_1 = Season123Config.instance:getSeasonEquipCo(iter_5_1.itemId)

		if var_5_1 and not Season123EquipMetaUtils.isBanActivity(var_5_1, arg_5_0.curActId) and arg_5_0:isCardCanShow(var_5_1) then
			table.insert(var_5_0, iter_5_1)
		end
	end

	table.sort(var_5_0, var_0_0.sortItemMOList)
	arg_5_0:setList(var_5_0)
end

function var_0_0.initPosList(arg_6_0)
	arg_6_0._itemUid2HeroUid = {}

	local var_6_0 = Season123Model.instance:getSeasonAllHeroGroup(arg_6_0.curActId)

	if not var_6_0 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1.activity104Equips

		if var_6_1 then
			arg_6_0:parseHeroGroupEquips(iter_6_1, var_6_1)
		end
	end
end

function var_0_0.parseHeroGroupEquips(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._itemMap = Season123Model.instance:getAllItemMo(arg_7_0.curActId) or {}

	for iter_7_0, iter_7_1 in pairs(arg_7_2) do
		local var_7_0 = iter_7_1.index
		local var_7_1 = arg_7_1:getHeroByIndex(var_7_0 + 1)

		if var_7_0 == Activity123Enum.MainCharPos then
			var_7_1 = Activity123Enum.MainRoleHeroUid
		end

		if var_7_1 then
			for iter_7_2, iter_7_3 in pairs(iter_7_1.equipUid) do
				if iter_7_3 ~= Activity123Enum.EmptyUid and (not arg_7_0._itemUid2HeroUid[iter_7_3] or arg_7_0._itemUid2HeroUid[iter_7_3] == Activity123Enum.EmptyUid) and arg_7_0._itemMap[iter_7_3] ~= nil then
					arg_7_0._itemUid2HeroUid[iter_7_3] = var_7_1
				end
			end
		end
	end
end

function var_0_0.isCardCanShow(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.rare
	local var_8_1 = arg_8_0:isCardCanShowByRare(var_8_0)
	local var_8_2 = arg_8_0:isCardCanShowByTag(arg_8_1)

	return var_8_1 and var_8_2
end

function var_0_0.isCardCanShowByRare(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = false

	for iter_9_0, iter_9_1 in pairs(arg_9_0.rareSelectTab) do
		if iter_9_0 == arg_9_1 then
			var_9_0 = iter_9_1
		end

		if iter_9_1 then
			var_9_1 = true
		end
	end

	return var_9_0 or not var_9_1
end

function var_0_0.isCardCanShowByTag(arg_10_0, arg_10_1)
	local var_10_0 = false
	local var_10_1 = false
	local var_10_2 = string.split(arg_10_1.tag, "#")

	for iter_10_0, iter_10_1 in pairs(arg_10_0.tagSelectTab) do
		for iter_10_2, iter_10_3 in ipairs(var_10_2) do
			if arg_10_0.tagSelectTab[tonumber(iter_10_3)] then
				var_10_0 = true
			end
		end

		if iter_10_1 then
			var_10_1 = true
		end
	end

	return var_10_0 or not var_10_1
end

function var_0_0.getDelayPlayTime(arg_11_0, arg_11_1)
	if arg_11_1 == nil then
		return -1
	end

	local var_11_0 = Time.time

	if arg_11_0._itemStartAnimTime == nil then
		arg_11_0._itemStartAnimTime = var_11_0 + arg_11_0.OpenAnimStartTime
	end

	local var_11_1 = arg_11_0:getIndex(arg_11_1)

	if not var_11_1 or var_11_1 > arg_11_0.AnimRowCount * arg_11_0.itemColunmCount then
		return -1
	end

	local var_11_2 = math.floor((var_11_1 - 1) / arg_11_0.itemColunmCount) * arg_11_0.OpenAnimTime + arg_11_0.OpenAnimStartTime

	if var_11_0 - arg_11_0._itemStartAnimTime - var_11_2 > 0.1 then
		return -1
	else
		return var_11_2
	end
end

function var_0_0.setItemCellCount(arg_12_0, arg_12_1)
	arg_12_0.itemColunmCount = arg_12_1 or 6
end

function var_0_0.sortItemMOList(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.instance:getItemUidToHeroUid(arg_13_0.uid) ~= nil
	local var_13_1 = var_0_0.instance:getItemUidToHeroUid(arg_13_1.uid) ~= nil
	local var_13_2 = Season123Config.instance:getSeasonEquipCo(arg_13_0.itemId)
	local var_13_3 = Season123Config.instance:getSeasonEquipCo(arg_13_1.itemId)

	if var_13_2 ~= nil and var_13_3 ~= nil then
		local var_13_4 = var_13_2.isMain == Activity123Enum.isMainRole

		if var_13_4 ~= (var_13_3.isMain == Activity123Enum.isMainRole) then
			return var_13_4
		end

		if var_13_2.rare ~= var_13_3.rare then
			if var_0_0.instance.rareAscendState then
				return var_13_2.rare < var_13_3.rare
			else
				return var_13_2.rare > var_13_3.rare
			end
		else
			if var_13_2.equipId ~= var_13_3.equipId then
				return var_13_2.equipId > var_13_3.equipId
			end

			local var_13_5 = var_0_0.instance.curSelectItemDict[arg_13_0.uid] ~= nil and var_0_0.instance.curSelectItemDict[arg_13_0.uid] ~= false

			if var_13_5 ~= (var_0_0.instance.curSelectItemDict[arg_13_1.uid] ~= nil and var_0_0.instance.curSelectItemDict[arg_13_1.uid] ~= false) then
				return var_13_5
			end

			if var_13_0 ~= var_13_1 then
				return var_13_1
			end

			return arg_13_0.uid < arg_13_1.uid
		end
	else
		return arg_13_0.uid < arg_13_1.uid
	end
end

function var_0_0.getItemUidToHeroUid(arg_14_0, arg_14_1)
	return arg_14_0._itemUid2HeroUid[arg_14_1]
end

function var_0_0.setCurSelectItemUid(arg_15_0, arg_15_1)
	if not arg_15_0.curSelectItemDict[arg_15_1] then
		local var_15_0 = arg_15_0._itemMap[arg_15_1]

		arg_15_0.curSelectItemDict[arg_15_1] = var_15_0
		arg_15_0.curSelectItemCount = arg_15_0.curSelectItemCount + 1
	else
		arg_15_0.curSelectItemDict[arg_15_1] = nil
		arg_15_0.curSelectItemCount = arg_15_0.curSelectItemCount - 1
	end
end

function var_0_0.isSelectedItem(arg_16_0, arg_16_1)
	return arg_16_0.curSelectItemDict[arg_16_1] ~= nil
end

function var_0_0.clearCurSelectItem(arg_17_0)
	arg_17_0.curSelectItemDict = {}
	arg_17_0.curSelectItemCount = 0
end

function var_0_0.setRareSelectItem(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		arg_18_0.rareSelectTab[iter_18_0] = iter_18_1
	end
end

function var_0_0.setTagSelectItem(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		arg_19_0.tagSelectTab[iter_19_0] = iter_19_1
	end
end

function var_0_0.hasSelectFilterItem(arg_20_0)
	if GameUtil.getTabLen(arg_20_0.rareSelectTab) > 0 then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.rareSelectTab) do
			if iter_20_1 then
				return true
			end
		end
	end

	if GameUtil.getTabLen(arg_20_0.tagSelectTab) > 0 then
		for iter_20_2, iter_20_3 in pairs(arg_20_0.tagSelectTab) do
			if iter_20_3 then
				return true
			end
		end
	end

	return false
end

function var_0_0.setRareAscendState(arg_21_0, arg_21_1)
	arg_21_0.rareAscendState = arg_21_1
end

function var_0_0.sortDecomposeItemListByRare(arg_22_0)
	local var_22_0 = arg_22_0:getList()

	table.sort(var_22_0, var_0_0.sortItemMOList)
	arg_22_0:setList(var_22_0)
end

function var_0_0.setCurOverPartSelectIndex(arg_23_0, arg_23_1)
	arg_23_0.curOverPartSelectIndex = arg_23_1
end

function var_0_0.selectOverPartItem(arg_24_0)
	if arg_24_0:getCount() == 0 then
		return
	end

	arg_24_0:clearCurSelectItem()

	if Season123EquipBookModel.instance:getCount() == 0 then
		Season123EquipBookModel.instance:initDatas(arg_24_0.curActId)
	end

	Season123EquipBookModel.instance:getAllEquipItem()

	local var_24_0 = arg_24_0:getList()
	local var_24_1 = 0
	local var_24_2 = -1

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_3 = Season123EquipBookModel.instance.allEquipItemMap[iter_24_1.itemId].count - arg_24_0.curOverPartSelectIndex

		if iter_24_1.itemId ~= var_24_2 then
			var_24_2 = iter_24_1.itemId
			var_24_1 = 0
		end

		if var_24_3 > 0 and var_24_1 < var_24_3 and not arg_24_0:isSelectItemMaxCount() then
			arg_24_0.curSelectItemDict[iter_24_1.uid] = iter_24_1
			var_24_1 = var_24_1 + 1
			arg_24_0.curSelectItemCount = arg_24_0.curSelectItemCount + 1
		end
	end
end

function var_0_0.isSelectItemMaxCount(arg_25_0)
	return arg_25_0.curSelectItemCount >= Activity123Enum.maxDecomposeCount
end

function var_0_0.getDecomposeItemsByItemId(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._itemMap = Season123Model.instance:getAllItemMo(arg_26_1) or {}

	if GameUtil.getTabLen(arg_26_0._itemMap) == 0 then
		return nil
	end

	if arg_26_0:getCount() == 0 then
		arg_26_0:initDatas(arg_26_1)
	end

	local var_26_0 = {}
	local var_26_1 = arg_26_0:getDict()

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		if iter_26_1.itemId == arg_26_2 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function var_0_0.isDecomposeItemUsedByHero(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_1) do
		local var_27_0 = arg_27_0:getItemUidToHeroUid(iter_27_1.uid)

		if var_27_0 and var_27_0 ~= Activity123Enum.EmptyUid then
			return true
		end
	end

	return false
end

function var_0_0.removeHasDecomposeItems(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		arg_28_0.curSelectItemDict[iter_28_1] = nil
		arg_28_0._itemMap[iter_28_1] = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
