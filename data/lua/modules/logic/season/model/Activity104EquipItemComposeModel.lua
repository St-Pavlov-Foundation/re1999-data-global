module("modules.logic.season.model.Activity104EquipItemComposeModel", package.seeall)

local var_0_0 = class("Activity104EquipItemComposeModel", ListScrollModel)

var_0_0.ComposeMaxCount = 3
var_0_0.EmptyUid = "0"
var_0_0.MainRoleHeroUid = "main_role"

function var_0_0.initDatas(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1
	arg_1_0.curSelectMap = {}
	arg_1_0._curSelectUidPosSet = {}

	for iter_1_0 = 1, var_0_0.ComposeMaxCount do
		arg_1_0.curSelectMap[iter_1_0] = var_0_0.EmptyUid
	end

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
	arg_2_0._itemStartAnimTime = nil
	arg_2_0.tagModel = nil
end

function var_0_0.initSubModel(arg_3_0)
	arg_3_0.tagModel = Activity104EquipTagModel.New()

	arg_3_0.tagModel:init(arg_3_0.activityId)
end

function var_0_0.initItemMap(arg_4_0)
	arg_4_0._itemMap = Activity104Model.instance:getAllItemMo(arg_4_0.activityId) or {}
end

function var_0_0.initPosList(arg_5_0)
	arg_5_0._itemUid2HeroUid = {}

	local var_5_0 = Activity104Model.instance:getSeasonAllHeroGroup(arg_5_0.activityId)

	if not var_5_0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = iter_5_1.activity104Equips

		if var_5_1 then
			arg_5_0:parseHeroGroupEquips(iter_5_1, var_5_1)
		end
	end
end

function var_0_0.parseHeroGroupEquips(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		local var_6_0 = iter_6_1.index
		local var_6_1 = arg_6_1:getHeroByIndex(var_6_0 + 1)

		if var_6_0 == Activity104EquipItemListModel.MainCharPos then
			var_6_1 = var_0_0.MainRoleHeroUid
		end

		if var_6_1 then
			for iter_6_2, iter_6_3 in pairs(iter_6_1.equipUid) do
				if iter_6_3 ~= var_0_0.EmptyUid and (not arg_6_0._itemUid2HeroUid[iter_6_3] or arg_6_0._itemUid2HeroUid[iter_6_3] == var_0_0.EmptyUid) and arg_6_0._itemMap[iter_6_3] ~= nil then
					arg_6_0._itemUid2HeroUid[iter_6_3] = var_6_1
				end
			end
		end
	end
end

function var_0_0.initList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._itemMap) do
		if not SeasonConfig.instance:getEquipIsOptional(iter_7_1.itemId) then
			local var_7_1 = SeasonConfig.instance:getSeasonEquipCo(iter_7_1.itemId)

			if var_7_1 and not SeasonEquipMetaUtils.isBanActivity(var_7_1, arg_7_0.activityId) and var_7_1.rare ~= Activity104Enum.MainRoleRare and arg_7_0:isCardCanShowByTag(var_7_1.tag) then
				local var_7_2 = Activity104EquipComposeMo.New()

				var_7_2:init(iter_7_1)
				table.insert(var_7_0, var_7_2)
			end
		end
	end

	table.sort(var_7_0, var_0_0.sortItemMOList)
	arg_7_0:setList(var_7_0)
end

function var_0_0.isCardCanShowByTag(arg_8_0, arg_8_1)
	if arg_8_0.tagModel then
		return arg_8_0.tagModel:isCardNeedShow(arg_8_1)
	end

	return true
end

function var_0_0.sortItemMOList(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.instance:getEquipedHeroUid(arg_9_0.id) ~= nil
	local var_9_1 = var_0_0.instance:getEquipedHeroUid(arg_9_1.id) ~= nil

	if var_9_0 ~= var_9_1 then
		return var_9_1
	end

	local var_9_2 = SeasonConfig.instance:getSeasonEquipCo(arg_9_0.itemId)
	local var_9_3 = SeasonConfig.instance:getSeasonEquipCo(arg_9_1.itemId)

	if var_9_2 ~= nil and var_9_3 ~= nil then
		if var_9_2.rare ~= var_9_3.rare then
			return var_9_2.rare > var_9_3.rare
		else
			return var_9_2.equipId > var_9_3.equipId
		end
	else
		return arg_9_0.id < arg_9_1.id
	end
end

function var_0_0.checkResetCurSelected(arg_10_0)
	for iter_10_0 = 1, var_0_0.ComposeMaxCount do
		local var_10_0 = arg_10_0.curSelectMap[iter_10_0]

		if not arg_10_0._itemMap[var_10_0] then
			arg_10_0.curSelectMap[iter_10_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.setSelectEquip(arg_11_0, arg_11_1)
	for iter_11_0 = 1, var_0_0.ComposeMaxCount do
		if var_0_0.EmptyUid == arg_11_0.curSelectMap[iter_11_0] then
			arg_11_0:selectEquip(arg_11_1, iter_11_0)

			return true
		end
	end

	return false
end

function var_0_0.selectEquip(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.curSelectMap[arg_12_2] = arg_12_1
	arg_12_0._curSelectUidPosSet[arg_12_1] = arg_12_2
end

function var_0_0.getEquipMO(arg_13_0, arg_13_1)
	return arg_13_0._itemMap[arg_13_1]
end

function var_0_0.unloadEquip(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._curSelectUidPosSet[arg_14_1]

	if var_14_0 then
		arg_14_0.curSelectMap[var_14_0] = var_0_0.EmptyUid
		arg_14_0._curSelectUidPosSet[arg_14_1] = nil
	end
end

function var_0_0.getEquipedHeroUid(arg_15_0, arg_15_1)
	return arg_15_0._itemUid2HeroUid[arg_15_1]
end

function var_0_0.isEquipSelected(arg_16_0, arg_16_1)
	return arg_16_0._curSelectUidPosSet[arg_16_1] ~= nil
end

function var_0_0.existSelectedMaterial(arg_17_0)
	for iter_17_0 = 1, var_0_0.ComposeMaxCount do
		if arg_17_0.curSelectMap[iter_17_0] ~= var_0_0.EmptyUid then
			return true
		end
	end

	return false
end

function var_0_0.getSelectedRare(arg_18_0)
	for iter_18_0 = 1, var_0_0.ComposeMaxCount do
		local var_18_0 = arg_18_0.curSelectMap[iter_18_0]

		if var_18_0 ~= var_0_0.EmptyUid then
			local var_18_1 = arg_18_0:getEquipMO(var_18_0)
			local var_18_2 = SeasonConfig.instance:getSeasonEquipCo(var_18_1.itemId)

			if var_18_2 then
				return var_18_2.rare
			end
		end
	end
end

function var_0_0.isMaterialAllReady(arg_19_0)
	for iter_19_0 = 1, var_0_0.ComposeMaxCount do
		if arg_19_0.curSelectMap[iter_19_0] == var_0_0.EmptyUid then
			return false
		end
	end

	return true
end

function var_0_0.getMaterialList(arg_20_0)
	local var_20_0 = {}

	for iter_20_0 = 1, var_0_0.ComposeMaxCount do
		table.insert(var_20_0, arg_20_0.curSelectMap[iter_20_0])
	end

	return var_20_0
end

function var_0_0.getDelayPlayTime(arg_21_0, arg_21_1)
	if arg_21_1 == nil then
		return -1
	end

	local var_21_0 = Time.time

	if arg_21_0._itemStartAnimTime == nil then
		arg_21_0._itemStartAnimTime = var_21_0 + SeasonEquipComposeItem.OpenAnimStartTime
	end

	local var_21_1 = arg_21_0:getIndex(arg_21_1)

	if not var_21_1 or var_21_1 > SeasonEquipComposeItem.AnimRowCount * SeasonEquipComposeItem.ColumnCount then
		return -1
	end

	local var_21_2 = math.floor((var_21_1 - 1) / SeasonEquipComposeItem.ColumnCount) * SeasonEquipComposeItem.OpenAnimTime + SeasonEquipComposeItem.OpenAnimStartTime
	local var_21_3 = var_21_0 - arg_21_0._itemStartAnimTime

	if var_21_2 < var_21_3 then
		return -1
	else
		return var_21_2 - var_21_3
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
