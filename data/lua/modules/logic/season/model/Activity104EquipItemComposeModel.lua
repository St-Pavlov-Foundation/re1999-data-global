module("modules.logic.season.model.Activity104EquipItemComposeModel", package.seeall)

local var_0_0 = class("Activity104EquipItemComposeModel", ListScrollModel)

var_0_0.ComposeMaxCount = 3
var_0_0.EmptyUid = "0"
var_0_0.MainRoleHeroUid = "main_role"

function var_0_0.initDatas(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1

	arg_1_0:clearSelectMap()
	arg_1_0:initSubModel()
	arg_1_0:initItemMap()
	arg_1_0:initPosList()
	arg_1_0:initList()
end

function var_0_0.clear(arg_2_0)
	var_0_0.super.clear(arg_2_0)

	arg_2_0.curSelectMap = nil
	arg_2_0._curSelectUidPosSet = nil
	arg_2_0._itemUid2HeroUid = nil
	arg_2_0._itemMap = nil
	arg_2_0._itemDefaultList = {}
	arg_2_0._itemStartAnimTime = nil
	arg_2_0.tagModel = nil
	arg_2_0.countModel = nil
	arg_2_0._itemCountDict = nil
end

function var_0_0.clearSelectMap(arg_3_0)
	arg_3_0.curSelectMap = {}
	arg_3_0._curSelectUidPosSet = {}

	for iter_3_0 = 1, var_0_0.ComposeMaxCount do
		arg_3_0.curSelectMap[iter_3_0] = var_0_0.EmptyUid
	end
end

function var_0_0.initSubModel(arg_4_0)
	arg_4_0.tagModel = Activity104EquipTagModel.New()

	arg_4_0.tagModel:init(arg_4_0.activityId)

	arg_4_0.countModel = Activity104EquipCountModel.New()

	arg_4_0.countModel:init(arg_4_0.activityId)
end

function var_0_0.initItemMap(arg_5_0)
	arg_5_0._itemMap = Activity104Model.instance:getAllItemMo(arg_5_0.activityId) or {}

	arg_5_0:initDefaultList()

	if arg_5_0.countModel then
		arg_5_0.countModel:refreshData(arg_5_0._itemDefaultList)
	end
end

function var_0_0.initPosList(arg_6_0)
	arg_6_0._itemUid2HeroUid = {}

	local var_6_0 = Activity104Model.instance:getSeasonAllHeroGroup(arg_6_0.activityId)

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
	for iter_7_0, iter_7_1 in pairs(arg_7_2) do
		local var_7_0 = iter_7_1.index
		local var_7_1 = arg_7_1:getHeroByIndex(var_7_0 + 1)

		if var_7_0 == Activity104EquipItemListModel.MainCharPos then
			var_7_1 = var_0_0.MainRoleHeroUid
		end

		if var_7_1 then
			for iter_7_2, iter_7_3 in pairs(iter_7_1.equipUid) do
				if iter_7_3 ~= var_0_0.EmptyUid and (not arg_7_0._itemUid2HeroUid[iter_7_3] or arg_7_0._itemUid2HeroUid[iter_7_3] == var_0_0.EmptyUid) and arg_7_0._itemMap[iter_7_3] ~= nil then
					arg_7_0._itemUid2HeroUid[iter_7_3] = var_7_1
				end
			end
		end
	end
end

function var_0_0.initDefaultList(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0._itemMap) do
		if not SeasonConfig.instance:getEquipIsOptional(iter_8_1.itemId) then
			local var_8_1 = SeasonConfig.instance:getSeasonEquipCo(iter_8_1.itemId)

			if var_8_1 and not SeasonEquipMetaUtils.isBanActivity(var_8_1, arg_8_0.activityId) and var_8_1.rare ~= Activity104Enum.MainRoleRare then
				local var_8_2 = Activity104EquipComposeMo.New()

				var_8_2:init(iter_8_1)
				table.insert(var_8_0, var_8_2)
			end
		end
	end

	arg_8_0._itemDefaultList = var_8_0
end

function var_0_0.initList(arg_9_0)
	arg_9_0._itemCountDict = {}

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0._itemDefaultList) do
		local var_9_1 = SeasonConfig.instance:getSeasonEquipCo(iter_9_1.itemId)

		if var_9_1 and arg_9_0:isCardCanShow(var_9_1) then
			table.insert(var_9_0, iter_9_1)
			arg_9_0:_addItemToCountDict(iter_9_1.itemId)
		end
	end

	table.sort(var_9_0, var_0_0.sortItemMOList)
	arg_9_0:setList(var_9_0)
end

function var_0_0._addItemToCountDict(arg_10_0, arg_10_1)
	if not arg_10_0._itemCountDict then
		arg_10_0._itemCountDict = {}
	end

	if not arg_10_0._itemCountDict[arg_10_1] then
		arg_10_0._itemCountDict[arg_10_1] = 0
	end

	arg_10_0._itemCountDict[arg_10_1] = arg_10_0._itemCountDict[arg_10_1] + 1
end

function var_0_0._getItemCount(arg_11_0, arg_11_1)
	if not arg_11_0._itemCountDict then
		arg_11_0._itemCountDict = {}
	end

	return arg_11_0._itemCountDict[arg_11_1] or 0
end

function var_0_0.isCardCanShow(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.tagModel:isCardNeedShow(arg_12_1.tag)
	local var_12_1 = arg_12_0.countModel:isCardNeedShow(arg_12_1.equipId, arg_12_0:_getItemCount(arg_12_1.equipId))

	return var_12_0 and var_12_1
end

function var_0_0.sortItemMOList(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.instance:getEquipedHeroUid(arg_13_0.id) ~= nil
	local var_13_1 = var_0_0.instance:getEquipedHeroUid(arg_13_1.id) ~= nil

	if var_13_0 ~= var_13_1 then
		return var_13_1
	end

	local var_13_2 = SeasonConfig.instance:getSeasonEquipCo(arg_13_0.itemId)
	local var_13_3 = SeasonConfig.instance:getSeasonEquipCo(arg_13_1.itemId)

	if var_13_2 ~= nil and var_13_3 ~= nil then
		if var_13_2.rare ~= var_13_3.rare then
			return var_13_2.rare > var_13_3.rare
		else
			return var_13_2.equipId > var_13_3.equipId
		end
	else
		return arg_13_0.id < arg_13_1.id
	end
end

function var_0_0.checkResetCurSelected(arg_14_0)
	for iter_14_0 = 1, var_0_0.ComposeMaxCount do
		local var_14_0 = arg_14_0.curSelectMap[iter_14_0]

		if not arg_14_0._itemMap[var_14_0] then
			arg_14_0.curSelectMap[iter_14_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.setSelectEquip(arg_15_0, arg_15_1)
	for iter_15_0 = 1, var_0_0.ComposeMaxCount do
		if var_0_0.EmptyUid == arg_15_0.curSelectMap[iter_15_0] then
			arg_15_0:selectEquip(arg_15_1, iter_15_0)

			return true
		end
	end

	return false
end

function var_0_0.selectEquip(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.curSelectMap[arg_16_2] = arg_16_1
	arg_16_0._curSelectUidPosSet[arg_16_1] = arg_16_2
end

function var_0_0.getEquipMO(arg_17_0, arg_17_1)
	return arg_17_0._itemMap[arg_17_1]
end

function var_0_0.unloadEquip(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._curSelectUidPosSet[arg_18_1]

	if var_18_0 then
		arg_18_0.curSelectMap[var_18_0] = var_0_0.EmptyUid
		arg_18_0._curSelectUidPosSet[arg_18_1] = nil
	end
end

function var_0_0.getEquipedHeroUid(arg_19_0, arg_19_1)
	return arg_19_0._itemUid2HeroUid[arg_19_1]
end

function var_0_0.isEquipSelected(arg_20_0, arg_20_1)
	return arg_20_0._curSelectUidPosSet[arg_20_1] ~= nil
end

function var_0_0.existSelectedMaterial(arg_21_0)
	for iter_21_0 = 1, var_0_0.ComposeMaxCount do
		if arg_21_0.curSelectMap[iter_21_0] ~= var_0_0.EmptyUid then
			return true
		end
	end

	return false
end

function var_0_0.getSelectedRare(arg_22_0)
	for iter_22_0 = 1, var_0_0.ComposeMaxCount do
		local var_22_0 = arg_22_0.curSelectMap[iter_22_0]

		if var_22_0 ~= var_0_0.EmptyUid then
			local var_22_1 = arg_22_0:getEquipMO(var_22_0)
			local var_22_2 = SeasonConfig.instance:getSeasonEquipCo(var_22_1.itemId)

			if var_22_2 then
				return var_22_2.rare
			end
		end
	end
end

function var_0_0.isMaterialAllReady(arg_23_0)
	for iter_23_0 = 1, var_0_0.ComposeMaxCount do
		if arg_23_0.curSelectMap[iter_23_0] == var_0_0.EmptyUid then
			return false
		end
	end

	return true
end

function var_0_0.getMaterialList(arg_24_0)
	local var_24_0 = {}

	for iter_24_0 = 1, var_0_0.ComposeMaxCount do
		table.insert(var_24_0, arg_24_0.curSelectMap[iter_24_0])
	end

	return var_24_0
end

function var_0_0.getDelayPlayTime(arg_25_0, arg_25_1)
	if arg_25_1 == nil then
		return -1
	end

	local var_25_0 = Time.time

	if arg_25_0._itemStartAnimTime == nil then
		arg_25_0._itemStartAnimTime = var_25_0 + SeasonEquipComposeItem.OpenAnimStartTime
	end

	local var_25_1 = arg_25_0:getIndex(arg_25_1)

	if not var_25_1 or var_25_1 > SeasonEquipComposeItem.AnimRowCount * SeasonEquipComposeItem.ColumnCount then
		return -1
	end

	local var_25_2 = math.floor((var_25_1 - 1) / SeasonEquipComposeItem.ColumnCount) * SeasonEquipComposeItem.OpenAnimTime + SeasonEquipComposeItem.OpenAnimStartTime
	local var_25_3 = var_25_0 - arg_25_0._itemStartAnimTime

	if var_25_2 < var_25_3 then
		return -1
	else
		return var_25_2 - var_25_3
	end
end

function var_0_0.checkAutoSelectEquip(arg_26_0)
	arg_26_0:clearSelectMap()

	local var_26_0 = arg_26_0:getList()
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		table.insert(var_26_1, iter_26_1)
	end

	table.sort(var_26_1, var_0_0.sortAutoSelectItemMOList)

	local var_26_2 = {}
	local var_26_3 = {}

	for iter_26_2, iter_26_3 in ipairs(var_26_1) do
		local var_26_4 = SeasonConfig.instance:getSeasonEquipCo(iter_26_3.itemId)

		if not var_26_2[var_26_4.rare] then
			var_26_2[var_26_4.rare] = {}

			table.insert(var_26_3, var_26_4.rare)
		end

		table.insert(var_26_2[var_26_4.rare], iter_26_3)
	end

	table.sort(var_26_3, function(arg_27_0, arg_27_1)
		return arg_27_0 < arg_27_1
	end)

	local var_26_5 = false

	for iter_26_4, iter_26_5 in ipairs(var_26_3) do
		local var_26_6 = var_26_2[iter_26_5]

		if #var_26_6 >= var_0_0.ComposeMaxCount then
			var_26_5 = true

			for iter_26_6 = 1, var_0_0.ComposeMaxCount do
				arg_26_0:setSelectEquip(var_26_6[iter_26_6].id)
			end

			break
		end
	end

	return var_26_5
end

function var_0_0.sortAutoSelectItemMOList(arg_28_0, arg_28_1)
	local var_28_0 = SeasonConfig.instance:getSeasonEquipCo(arg_28_0.itemId)
	local var_28_1 = SeasonConfig.instance:getSeasonEquipCo(arg_28_1.itemId)

	if var_28_0 ~= nil and var_28_1 ~= nil then
		if var_28_0.rare ~= var_28_1.rare then
			return var_28_0.rare < var_28_1.rare
		else
			return var_28_0.equipId < var_28_1.equipId
		end
	else
		return arg_28_0.id < arg_28_1.id
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
