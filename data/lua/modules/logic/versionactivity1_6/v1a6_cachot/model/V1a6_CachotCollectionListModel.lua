module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionListModel", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionListModel", MixScrollModel)

var_0_0.instance = var_0_0.New()

function var_0_0.release(arg_1_0)
	arg_1_0._curCategory = nil
	arg_1_0._newCollectionAndClickList = nil
	arg_1_0._unlockCollectionsNew = nil
	arg_1_0._curPlayAnimCellIndex = nil
end

function var_0_0.onInitData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._curCategory = arg_2_1 or V1a6_CachotEnum.CollectionCategoryType.All
	arg_2_0._maxCollectionNumSingleLine = arg_2_2

	arg_2_0:buildUnLockCollectionsNew()
	arg_2_0:buildAllConfigData()
	arg_2_0:switchCategory(arg_2_0._curCategory)
end

function var_0_0.buildUnLockCollectionsNew(arg_3_0)
	local var_3_0 = V1a6_CachotModel.instance:getRogueStateInfo()

	if var_3_0 then
		arg_3_0._unlockCollectionsNew = var_3_0.unlockCollectionsNew
	end
end

function var_0_0.buildAllConfigData(arg_4_0)
	arg_4_0:intCategoryDataTab()
	arg_4_0:initCollectionStateMap()

	local var_4_0 = V1a6_CachotCollectionConfig.instance:getAllConfig()

	if var_4_0 then
		table.sort(var_4_0, arg_4_0.configSortFunc)

		local var_4_1 = arg_4_0._collectionDic[V1a6_CachotEnum.CollectionCategoryType.All]
		local var_4_2 = arg_4_0._collectionDic[V1a6_CachotEnum.CollectionCategoryType.HasGet]
		local var_4_3 = arg_4_0._collectionDic[V1a6_CachotEnum.CollectionCategoryType.UnGet]

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if iter_4_1.inHandBook == V1a6_CachotEnum.CollectionInHandBook then
				arg_4_0:buildCollectionListMO(iter_4_1, var_4_1)
				arg_4_0:buildCollectionListMO(iter_4_1, var_4_2, {
					V1a6_CachotEnum.CollectionState.HasGet
				})
				arg_4_0:buildCollectionListMO(iter_4_1, var_4_3, {
					V1a6_CachotEnum.CollectionState.UnLocked,
					V1a6_CachotEnum.CollectionState.Locked
				})
			end
		end
	end
end

local var_0_1 = {
	ListFull = 2,
	MisMatchState = 1,
	Success = 3
}

function var_0_0.buildCollectionListMO(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:collectionCheckFunc(arg_5_1, arg_5_2, arg_5_3)
	local var_5_1 = arg_5_2 and arg_5_2[#arg_5_2]

	if var_5_0 == var_0_1.MisMatchState then
		return
	elseif var_5_0 == var_0_1.ListFull then
		local var_5_2 = V1a6_CachotCollectionListMO.New()
		local var_5_3 = not var_5_1 or var_5_1.collectionType ~= arg_5_1.type

		var_5_2:init(arg_5_1.type, var_5_3, arg_5_0._maxCollectionNumSingleLine)
		var_5_2:addCollection(arg_5_1)
		table.insert(arg_5_2, var_5_2)
	elseif var_5_0 == var_0_1.Success then
		arg_5_2[#arg_5_2]:addCollection(arg_5_1)
	end
end

function var_0_0.collectionCheckFunc(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2 and arg_6_2[#arg_6_2]
	local var_6_1 = arg_6_0:getCollectionState(arg_6_1.id)

	if arg_6_3 and not tabletool.indexOf(arg_6_3, var_6_1) then
		return var_0_1.MisMatchState
	elseif not var_6_0 or var_6_0:isFull() or var_6_0.collectionType ~= arg_6_1.type then
		return var_0_1.ListFull
	else
		return var_0_1.Success
	end
end

function var_0_0.configSortFunc(arg_7_0, arg_7_1)
	if arg_7_0.type ~= arg_7_1.type then
		return arg_7_0.type < arg_7_1.type
	end

	return arg_7_0.id < arg_7_1.id
end

local var_0_2 = {
	Top = 1,
	Others = 2
}

function var_0_0.getInfoList(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = iter_8_1._isTop and var_0_2.Top or var_0_2.Others
		local var_8_3 = SLFramework.UGUI.MixCellInfo.New(var_8_2, iter_8_1:getLineHeight(), iter_8_0)

		table.insert(var_8_0, var_8_3)
	end

	return var_8_0
end

function var_0_0.intCategoryDataTab(arg_9_0)
	arg_9_0._collectionDic = {}

	for iter_9_0, iter_9_1 in pairs(V1a6_CachotEnum.CollectionCategoryType) do
		arg_9_0._collectionDic[iter_9_1] = {}
	end
end

function var_0_0.initCollectionStateMap(arg_10_0)
	arg_10_0._collectionStateMap = {}

	local var_10_0 = V1a6_CachotModel.instance:getRogueStateInfo()

	if var_10_0 then
		arg_10_0:buildCollectionMap(arg_10_0._collectionStateMap, var_10_0.unlockCollections, V1a6_CachotEnum.CollectionState.UnLocked)
		arg_10_0:buildCollectionMap(arg_10_0._collectionStateMap, var_10_0.hasCollections, V1a6_CachotEnum.CollectionState.HasGet)
	end
end

function var_0_0.buildCollectionMap(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 and arg_11_1 and arg_11_3 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
			arg_11_1[iter_11_1] = arg_11_3
		end
	end
end

function var_0_0.getCollectionState(arg_12_0, arg_12_1)
	if arg_12_0._collectionStateMap then
		return arg_12_0._collectionStateMap[arg_12_1] or V1a6_CachotEnum.CollectionState.Locked
	end
end

function var_0_0.switchCategory(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._collectionDic and arg_13_0._collectionDic[arg_13_1]

	if var_13_0 then
		arg_13_0:setList(var_13_0)

		arg_13_0._curCategory = arg_13_1
	end
end

function var_0_0.getCurCategory(arg_14_0)
	return arg_14_0._curCategory
end

function var_0_0.getCurCategoryFirstCollection(arg_15_0)
	local var_15_0 = arg_15_0:getByIndex(1)

	if var_15_0 and var_15_0.collectionList and var_15_0.collectionList[1] then
		return var_15_0.collectionList[1].id
	end
end

function var_0_0.markSelectCollecionId(arg_16_0, arg_16_1)
	arg_16_0._curSelectCollectionId = arg_16_1

	if arg_16_0:isCollectionNew(arg_16_1) then
		arg_16_0._newCollectionAndClickList = arg_16_0._newCollectionAndClickList or {}

		table.insert(arg_16_0._newCollectionAndClickList, arg_16_1)

		arg_16_0._unlockCollectionsNew[arg_16_1] = nil
	end
end

function var_0_0.isCollectionNew(arg_17_0, arg_17_1)
	return arg_17_0._unlockCollectionsNew and arg_17_0._unlockCollectionsNew[arg_17_1]
end

function var_0_0.getNewCollectionAndClickList(arg_18_0)
	return arg_18_0._newCollectionAndClickList
end

function var_0_0.getCurSelectCollectionId(arg_19_0)
	return arg_19_0._curSelectCollectionId
end

function var_0_0.markCurPlayAnimCellIndex(arg_20_0, arg_20_1)
	arg_20_0._curPlayAnimCellIndex = arg_20_1
end

function var_0_0.getCurPlayAnimCellIndex(arg_21_0)
	return arg_21_0._curPlayAnimCellIndex
end

function var_0_0.resetCurPlayAnimCellIndex(arg_22_0)
	arg_22_0._curPlayAnimCellIndex = nil
end

return var_0_0
