module("modules.logic.seasonver.act123.model.Season123EquipBookModel", package.seeall)

local var_0_0 = class("Season123EquipBookModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.clear(arg_2_0)
	var_0_0.super.clear(arg_2_0)

	arg_2_0.equipItemList = {}
	arg_2_0.curSelectItemId = nil
	arg_2_0.curActId = nil
	arg_2_0.tagModel = nil
	arg_2_0._itemStartAnimTime = nil
	arg_2_0.allItemMo = nil
	arg_2_0.recordNew = nil
	arg_2_0.allEquipItemMap = {}
	arg_2_0.ColumnCount = 6
	arg_2_0.AnimRowCount = 4
	arg_2_0.OpenAnimTime = 0.06
	arg_2_0.OpenAnimStartTime = 0.05
end

function var_0_0.initDatas(arg_3_0, arg_3_1)
	arg_3_0.curActId = arg_3_1
	arg_3_0.curSelectItemId = nil

	arg_3_0:initSubModel()
	arg_3_0:initPlayerPrefs()
	arg_3_0:initList()
end

function var_0_0.initList(arg_4_0)
	arg_4_0:initConfig()
	arg_4_0:initBackpack()

	if arg_4_0:getCount() > 0 then
		arg_4_0:setCurSelectItemId(arg_4_0:getByIndex(1).id)
	end
end

function var_0_0.initConfig(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = Season123Config.instance:getSeasonEquipCos()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if not Season123EquipMetaUtils.isBanActivity(iter_5_1, arg_5_0.curActId) and arg_5_0:isCardCanShowByTag(iter_5_1.tag) then
			local var_5_2 = Season123EquipBookMO.New()

			var_5_2:init(iter_5_0)
			table.insert(var_5_0, var_5_2)
		end
	end

	arg_5_0:setList(var_5_0)
end

function var_0_0.initBackpack(arg_6_0)
	arg_6_0.allItemMo = Season123Model.instance:getAllItemMo(arg_6_0.curActId) or {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.allItemMo) do
		if Season123Config.instance:getSeasonEquipCo(iter_6_1.itemId) then
			local var_6_0 = arg_6_0:getById(iter_6_1.itemId)

			if var_6_0 then
				var_6_0.count = var_6_0.count + 1

				if not arg_6_0.recordNew:contain(iter_6_1.itemId) then
					var_6_0:setIsNew(true)
				end
			end
		end
	end

	arg_6_0:sort(var_0_0.sortItemMOList)
end

function var_0_0.setCurSelectItemId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getById(arg_7_1)

	if var_7_0 then
		arg_7_0.curSelectItemId = arg_7_1

		arg_7_0.recordNew:add(arg_7_1)
		var_7_0:setIsNew(false)
	else
		arg_7_0.curSelectItemId = nil
	end
end

function var_0_0.initSubModel(arg_8_0)
	arg_8_0.tagModel = Season123EquipTagModel.New()

	arg_8_0.tagModel:init(arg_8_0.curActId)
end

function var_0_0.initPlayerPrefs(arg_9_0)
	arg_9_0.recordNew = Season123EquipLocalRecord.New()

	arg_9_0.recordNew:init(arg_9_0.curActId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function var_0_0.isCardCanShowByTag(arg_10_0, arg_10_1)
	if arg_10_0.tagModel then
		return arg_10_0.tagModel:isCardNeedShow(arg_10_1)
	end

	return true
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

	if not var_11_1 or var_11_1 > arg_11_0.AnimRowCount * arg_11_0.ColumnCount then
		return -1
	end

	local var_11_2 = math.floor((var_11_1 - 1) / arg_11_0.ColumnCount) * arg_11_0.OpenAnimTime + arg_11_0.OpenAnimStartTime

	if var_11_0 - arg_11_0._itemStartAnimTime - var_11_2 > 0.1 then
		return -1
	else
		return var_11_2
	end
end

function var_0_0.sortItemMOList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.count > 0

	if var_12_0 ~= (arg_12_1.count > 0) then
		return var_12_0
	end

	local var_12_1 = Season123Config.instance:getSeasonEquipCo(arg_12_0.id)
	local var_12_2 = Season123Config.instance:getSeasonEquipCo(arg_12_1.id)

	if var_12_1 ~= nil and var_12_2 ~= nil then
		local var_12_3 = var_12_1.isMain == Activity123Enum.isMainRole

		if var_12_3 ~= (var_12_2.isMain == Activity123Enum.isMainRole) then
			return var_12_3
		end

		if var_12_1.rare ~= var_12_2.rare then
			return var_12_1.rare > var_12_2.rare
		else
			return var_12_1.equipId > var_12_2.equipId
		end
	else
		return arg_12_0.id < arg_12_1.id
	end
end

function var_0_0.checkResetCurSelected(arg_13_0)
	if arg_13_0.curSelectItemId and not arg_13_0:getById(arg_13_0.curSelectItemId) then
		arg_13_0.curSelectItemId = nil
	end
end

function var_0_0.flushRecord(arg_14_0)
	if arg_14_0.recordNew then
		arg_14_0.recordNew:recordAllItem()
	end
end

function var_0_0.getEquipBookItemCount(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getList()

	for iter_15_0 = 1, #var_15_0 do
		if var_15_0[iter_15_0].id == arg_15_1 then
			return var_15_0[iter_15_0].count
		end
	end

	return 0
end

function var_0_0.refreshBackpack(arg_16_0)
	arg_16_0:initConfig()
	arg_16_0:initBackpack()
end

function var_0_0.removeDecomposeEquipItem(arg_17_0, arg_17_1)
	arg_17_0:initConfig()
	arg_17_0:initBackpack()

	local var_17_0 = arg_17_0:getById(arg_17_0.curSelectItemId)

	if var_17_0 and var_17_0.count == 0 then
		arg_17_0:setCurSelectItemId(arg_17_0:getByIndex(1).id)
	end
end

function var_0_0.selectFirstCard(arg_18_0)
	if arg_18_0:getCount() > 0 then
		arg_18_0:setCurSelectItemId(arg_18_0:getByIndex(1).id)
	end
end

function var_0_0.getAllEquipItem(arg_19_0)
	arg_19_0.allEquipItemMap = {}

	local var_19_0 = Season123Config.instance:getSeasonEquipCos()

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		if not Season123EquipMetaUtils.isBanActivity(iter_19_1, arg_19_0.curActId) then
			local var_19_1 = Season123EquipBookMO.New()

			var_19_1:init(iter_19_0)

			arg_19_0.allEquipItemMap[iter_19_0] = var_19_1
		end
	end

	arg_19_0.allItemMo = Season123Model.instance:getAllItemMo(arg_19_0.curActId) or {}

	for iter_19_2, iter_19_3 in pairs(arg_19_0.allItemMo) do
		if Season123Config.instance:getSeasonEquipCo(iter_19_3.itemId) then
			local var_19_2 = arg_19_0.allEquipItemMap[iter_19_3.itemId]

			if var_19_2 then
				var_19_2.count = var_19_2.count + 1
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
