module("modules.logic.store.model.StoreRoomGoodsItemListModel", package.seeall)

local var_0_0 = class("StoreRoomGoodsItemListModel", TreeScrollModel)

function var_0_0.setMOList(arg_1_0, arg_1_1)
	arg_1_0:clear()

	local var_1_0 = 24
	local var_1_1 = 373 + var_1_0

	table.sort(arg_1_1, arg_1_0.sortFunction)

	local var_1_2 = {}

	var_1_2.rootType = 1
	var_1_2.rootLength = var_1_1

	for iter_1_0 = 1, #arg_1_1 do
		if arg_1_1[iter_1_0].children then
			local var_1_3 = math.ceil(#arg_1_1[iter_1_0].children / 4)
			local var_1_4 = {}

			var_1_4.rootType = 1
			var_1_4.rootLength = var_1_1
			var_1_4.nodeType = var_1_3 + 1
			var_1_4.nodeLength = 387 * var_1_3 + 30
			var_1_4.nodeCountEachLine = 1
			var_1_4.nodeStartSpace = 0
			var_1_4.nodeEndSpace = 0
			var_1_4.isExpanded = arg_1_1[iter_1_0].isExpand or false
			arg_1_1[iter_1_0].treeRootParam = var_1_4
			arg_1_1[iter_1_0].children.rootindex = iter_1_0

			arg_1_0:addRoot(arg_1_1[iter_1_0], var_1_4, iter_1_0)
			arg_1_0:addNode(arg_1_1[iter_1_0].children, iter_1_0, 1)
		else
			local var_1_5 = {}

			var_1_5.rootType = 1
			var_1_5.rootLength = var_1_1

			arg_1_0:addRoot(arg_1_1[iter_1_0], var_1_5, iter_1_0)
		end
	end

	for iter_1_1, iter_1_2 in pairs(arg_1_1) do
		if iter_1_2.children then
			table.sort(iter_1_2.children, arg_1_0.sortFunction)
		end
	end

	arg_1_0:addRoot({
		update = true,
		type = 0
	}, var_1_2, #arg_1_1 + 1)
end

function var_0_0.getInfoList(arg_2_0)
	return var_0_0.super.getInfoList(arg_2_0)
end

function var_0_0.sortFunction(arg_3_0, arg_3_1)
	local var_3_0 = StoreConfig.instance:getGoodsConfig(arg_3_0.goodsId)
	local var_3_1 = StoreConfig.instance:getGoodsConfig(arg_3_1.goodsId)
	local var_3_2 = StoreNormalGoodsItemListModel._isStoreItemSoldOut(arg_3_0.goodsId)
	local var_3_3 = StoreNormalGoodsItemListModel._isStoreItemSoldOut(arg_3_1.goodsId)
	local var_3_4 = StoreNormalGoodsItemListModel._isStoreItemUnlock(arg_3_0.goodsId)
	local var_3_5 = StoreNormalGoodsItemListModel._isStoreItemUnlock(arg_3_1.goodsId)

	if not var_3_2 and var_3_3 then
		return true
	elseif var_3_2 and not var_3_3 then
		return false
	end

	if var_3_4 and not var_3_5 then
		return true
	elseif not var_3_4 and var_3_5 then
		return false
	end

	local var_3_6 = arg_3_0:alreadyHas()
	local var_3_7 = arg_3_1:alreadyHas()

	if var_3_6 ~= var_3_7 then
		return var_3_7
	end

	local var_3_8 = StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_3_0.goodsId)

	if var_3_8 ~= StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_3_1.goodsId) then
		if var_3_8 then
			return false
		end

		return true
	end

	if var_3_0.order < var_3_1.order then
		return true
	elseif var_3_0.order > var_3_1.order then
		return false
	end

	if var_3_0.id < var_3_1.id then
		return true
	elseif var_3_0.id > var_3_1.id then
		return false
	end
end

function var_0_0._isStoreItemUnlock(arg_4_0)
	local var_4_0 = StoreConfig.instance:getGoodsConfig(arg_4_0).needEpisodeId

	if not var_4_0 or var_4_0 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_4_0)
end

function var_0_0.needWeekWalkLayerUnlock(arg_5_0)
	local var_5_0 = StoreConfig.instance:getGoodsConfig(arg_5_0).needWeekwalkLayer

	if var_5_0 <= 0 then
		return false
	end

	if not WeekWalkModel.instance:getInfo() then
		return true
	end

	return var_5_0 > WeekWalkModel.instance:getMaxLayerId()
end

function var_0_0._isStoreItemSoldOut(arg_6_0)
	return StoreModel.instance:getGoodsMO(arg_6_0):isSoldOut()
end

var_0_0.instance = var_0_0.New()

return var_0_0
