module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionBagListModel", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionBagListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._filterCollectionList = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.onInitData(arg_3_0)
	arg_3_0:onCollectionDataUpdate()
end

function var_0_0.onCollectionDataUpdate(arg_4_0)
	local var_4_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_4_1 = var_4_0 and var_4_0.collections

	arg_4_0._filterCollectionList = {}

	if var_4_1 then
		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			table.insert(arg_4_0._filterCollectionList, iter_4_1)
		end
	end

	table.sort(arg_4_0._filterCollectionList, arg_4_0.sortFunc)

	local var_4_2 = arg_4_0:insertFakeData()

	arg_4_0:setList(var_4_2)
end

function var_0_0.insertFakeData(arg_5_0)
	local var_5_0 = 0

	arg_5_0._unEnchantCollectionLineNum = 0
	arg_5_0._enchantCollectionCount = 0

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._filterCollectionList) do
		local var_5_2 = iter_5_1 and iter_5_1.cfgId
		local var_5_3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_5_2)

		if var_5_3 and var_5_3.type ~= V1a6_CachotEnum.CollectionType.Enchant then
			var_5_0 = var_5_0 + 1
		else
			arg_5_0._enchantCollectionCount = arg_5_0._enchantCollectionCount + 1
		end

		table.insert(var_5_1, iter_5_1)
	end

	local var_5_4 = ViewMgr.instance:getContainer(ViewName.V1a6_CachotCollectionBagView)
	local var_5_5 = var_5_4 and var_5_4:getScrollParam()
	local var_5_6 = var_5_5 and var_5_5.lineCount or 1

	arg_5_0._unEnchantCollectionLineNum = math.ceil(var_5_0 / var_5_6)

	local var_5_7 = arg_5_0._unEnchantCollectionLineNum * var_5_6 - var_5_0

	for iter_5_2 = 1, var_5_7 do
		local var_5_8 = {
			isFake = true,
			id = -iter_5_2
		}
		local var_5_9 = var_5_0 + iter_5_2

		table.insert(var_5_1, var_5_9, var_5_8)
	end

	return var_5_1
end

function var_0_0.sortFunc(arg_6_0, arg_6_1)
	local var_6_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_6_0.cfgId)
	local var_6_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_6_1.cfgId)

	if var_6_0 and var_6_1 and var_6_0.type ~= var_6_1.type then
		return var_6_0.type < var_6_1.type
	end

	return arg_6_0.id > arg_6_1.id
end

function var_0_0.isBagEmpty(arg_7_0)
	return arg_7_0:getCount() <= 0
end

function var_0_0.moveCollectionWithHole2Top(arg_8_0)
	local var_8_0 = false
	local var_8_1 = arg_8_0:getFirstCollectionWithHole()

	if var_8_1 then
		arg_8_0:remove(var_8_1)
		arg_8_0:addAtFirst(var_8_1)

		var_8_0 = true
	else
		logError("cannot find first collection with hole")
	end

	return var_8_0
end

function var_0_0.getFirstCollectionWithHole(arg_9_0)
	local var_9_0 = arg_9_0:getList()

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_9_1.cfgId)

			if var_9_1 and var_9_1.type ~= V1a6_CachotEnum.CollectionType.Enchant and var_9_1.holeNum > 0 then
				return iter_9_1
			end
		end
	end
end

function var_0_0.getUnEnchantCollectionLineNum(arg_10_0)
	return arg_10_0._unEnchantCollectionLineNum or 0
end

function var_0_0.getEnchantCollectionNum(arg_11_0)
	return arg_11_0._enchantCollectionCount or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
