module("modules.versionactivitybase.fixed.dungeon.model.VersionActivityFixedStoreListModel", package.seeall)

local var_0_0 = class("VersionActivityFixedStoreListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initStoreGoodsConfig(arg_3_0)
	if arg_3_0.goodsConfigList then
		return
	end

	local var_3_0, var_3_1 = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local var_3_2 = VersionActivityFixedHelper.getVersionActivityEnum(var_3_0, var_3_1)

	arg_3_0.goodsConfigList = {}

	local var_3_3 = ActivityStoreConfig.instance:getActivityStoreGroupDict(var_3_2.ActivityId.DungeonStore) or {}

	for iter_3_0, iter_3_1 in pairs(var_3_3) do
		tabletool.addValues(arg_3_0.goodsConfigList, iter_3_1)
	end
end

function var_0_0._sortGoods(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local var_4_2 = VersionActivityFixedHelper.getVersionActivityEnum(var_4_0, var_4_1)
	local var_4_3 = arg_4_0.maxBuyCount ~= 0 and arg_4_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(var_4_2.ActivityId.DungeonStore, arg_4_0.id) <= 0

	if var_4_3 ~= (arg_4_1.maxBuyCount ~= 0 and arg_4_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(var_4_2.ActivityId.DungeonStore, arg_4_1.id) <= 0) then
		if var_4_3 then
			return false
		end

		return true
	end

	return arg_4_0.id < arg_4_1.id
end

function var_0_0.refreshStore(arg_5_0)
	arg_5_0:initStoreGoodsConfig()
	table.sort(arg_5_0.goodsConfigList, var_0_0._sortGoods)
	arg_5_0:setList(arg_5_0.goodsConfigList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
