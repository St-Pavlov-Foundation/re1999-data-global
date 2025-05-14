module("modules.logic.season.model.Activity104EquipItemBookModel", package.seeall)

local var_0_0 = class("Activity104EquipItemBookModel", ListScrollModel)

function var_0_0.clear(arg_1_0)
	var_0_0.super.clear(arg_1_0)

	arg_1_0.activityId = nil
	arg_1_0.curSelectItemId = nil
	arg_1_0._itemMap = nil
	arg_1_0.recordNew = nil
	arg_1_0._itemStartAnimTime = nil
	arg_1_0.tagModel = nil
end

function var_0_0.initDatas(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1
	arg_2_0.curSelectItemId = nil

	arg_2_0:initSubModel()
	arg_2_0:initPlayerPrefs()
	arg_2_0:initList()
end

function var_0_0.initList(arg_3_0)
	arg_3_0:initConfig()
	arg_3_0:initBackpack()

	if arg_3_0:getCount() > 0 then
		arg_3_0:setSelectItemId(arg_3_0:getByIndex(1).id)
	end
end

function var_0_0.initSubModel(arg_4_0)
	arg_4_0.tagModel = Activity104EquipTagModel.New()

	arg_4_0.tagModel:init(arg_4_0.activityId)
end

function var_0_0.initConfig(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = SeasonConfig.instance:getSeasonEquipCos()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if not SeasonConfig.instance:getEquipIsOptional(iter_5_0) and not SeasonEquipMetaUtils.isBanActivity(iter_5_1, arg_5_0.activityId) and arg_5_0:isCardCanShowByTag(iter_5_1.tag) then
			local var_5_2 = Activity104EquipBookMo.New()

			var_5_2:init(iter_5_0)
			table.insert(var_5_0, var_5_2)
		end
	end

	arg_5_0:setList(var_5_0)
end

function var_0_0.initPlayerPrefs(arg_6_0)
	arg_6_0.recordNew = SeasonEquipLocalRecord.New()

	arg_6_0.recordNew:init(arg_6_0.activityId, Activity104Enum.PlayerPrefsKeyItemUid)
end

function var_0_0.initBackpack(arg_7_0)
	arg_7_0._itemMap = Activity104Model.instance:getAllItemMo(arg_7_0.activityId) or {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._itemMap) do
		if SeasonConfig.instance:getSeasonEquipCo(iter_7_1.itemId) then
			local var_7_0 = arg_7_0:getById(iter_7_1.itemId)

			if var_7_0 then
				var_7_0.count = var_7_0.count + 1

				if not arg_7_0.recordNew:contain(iter_7_0) then
					var_7_0:setIsNew(true)
				end
			end
		end
	end

	arg_7_0:sort(var_0_0.sortItemMOList)
end

function var_0_0.isCardCanShowByTag(arg_8_0, arg_8_1)
	if arg_8_0.tagModel then
		return arg_8_0.tagModel:isCardNeedShow(arg_8_1)
	end

	return true
end

function var_0_0.getDelayPlayTime(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return -1
	end

	local var_9_0 = Time.time

	if arg_9_0._itemStartAnimTime == nil then
		arg_9_0._itemStartAnimTime = var_9_0 + SeasonEquipBookItem.OpenAnimStartTime
	end

	local var_9_1 = arg_9_0:getIndex(arg_9_1)

	if not var_9_1 or var_9_1 > SeasonEquipBookItem.AnimRowCount * SeasonEquipBookItem.ColumnCount then
		return -1
	end

	local var_9_2 = math.floor((var_9_1 - 1) / SeasonEquipBookItem.ColumnCount) * SeasonEquipBookItem.OpenAnimTime + SeasonEquipBookItem.OpenAnimStartTime
	local var_9_3 = var_9_0 - arg_9_0._itemStartAnimTime

	if var_9_2 < var_9_3 then
		return -1
	else
		return var_9_2 - var_9_3
	end
end

function var_0_0.sortItemMOList(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.count > 0

	if var_10_0 ~= (arg_10_1.count > 0) then
		return var_10_0
	end

	local var_10_1 = SeasonConfig.instance:getSeasonEquipCo(arg_10_0.id)
	local var_10_2 = SeasonConfig.instance:getSeasonEquipCo(arg_10_1.id)

	if var_10_1 ~= nil and var_10_2 ~= nil then
		if var_10_1.rare ~= var_10_2.rare then
			return var_10_1.rare > var_10_2.rare
		else
			return var_10_1.equipId > var_10_2.equipId
		end
	else
		return arg_10_0.id < arg_10_1.id
	end
end

function var_0_0.setSelectItemId(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getById(arg_11_1)

	if var_11_0 then
		arg_11_0.curSelectItemId = arg_11_1

		var_11_0:setIsNew(false)
	end
end

function var_0_0.checkResetCurSelected(arg_12_0)
	if arg_12_0.curSelectItemId and not arg_12_0:getById(arg_12_0.curSelectItemId) then
		arg_12_0.curSelectItemId = nil
	end
end

function var_0_0.flushRecord(arg_13_0)
	if arg_13_0.recordNew then
		arg_13_0.recordNew:recordAllItem()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
