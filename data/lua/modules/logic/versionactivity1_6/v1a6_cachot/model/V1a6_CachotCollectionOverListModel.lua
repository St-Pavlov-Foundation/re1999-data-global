module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionOverListModel", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionOverListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._collectionList = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.onInitData(arg_3_0)
	local var_3_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_3_1 = var_3_0 and var_3_0.collections

	arg_3_0._collectionList = {}

	if var_3_1 then
		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			table.insert(arg_3_0._collectionList, iter_3_1)
		end
	end

	table.sort(arg_3_0._collectionList, arg_3_0.sortFunc)
	arg_3_0:setList(arg_3_0._collectionList)
end

function var_0_0.sortFunc(arg_4_0, arg_4_1)
	local var_4_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_4_0.cfgId)
	local var_4_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_4_1.cfgId)

	if var_4_0 and var_4_1 and var_4_0.type ~= var_4_1.type then
		return var_4_0.type < var_4_1.type
	end

	return arg_4_0.id > arg_4_1.id
end

function var_0_0.isBagEmpty(arg_5_0)
	return arg_5_0:getCount() <= 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
