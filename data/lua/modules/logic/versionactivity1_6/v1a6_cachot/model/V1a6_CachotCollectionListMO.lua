module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionListMO", package.seeall)

local var_0_0 = pureTable("V1a6_CachotCollectionListMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.collectionType = arg_1_1
	arg_1_0.collectionList = {}
	arg_1_0.collectionDic = {}
	arg_1_0._curCollectionCount = 0
	arg_1_0._isTop = arg_1_2 or false
	arg_1_0._maxCollectionNumSingleLine = arg_1_3
end

function var_0_0.addCollection(arg_2_0, arg_2_1)
	if not arg_2_0.collectionDic[arg_2_1.id] then
		arg_2_0.collectionDic[arg_2_1.id] = true

		table.insert(arg_2_0.collectionList, arg_2_1)

		arg_2_0._curCollectionCount = arg_2_0._curCollectionCount + 1
	end
end

function var_0_0.isFull(arg_3_0)
	return arg_3_0._curCollectionCount >= arg_3_0._maxCollectionNumSingleLine
end

function var_0_0.getLineHeight(arg_4_0)
	return arg_4_0._isTop and 330 or 230
end

return var_0_0
