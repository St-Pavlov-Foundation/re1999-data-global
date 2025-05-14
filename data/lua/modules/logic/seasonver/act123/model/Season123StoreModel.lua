module("modules.logic.seasonver.act123.model.Season123StoreModel", package.seeall)

local var_0_0 = class("Season123StoreModel", ListScrollModel)

function var_0_0.OnInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.storeItemList = {}
end

function var_0_0.setStoreItemList(arg_3_0, arg_3_1)
	arg_3_0.storeItemList = tabletool.copy(arg_3_1)

	table.sort(arg_3_0.storeItemList, var_0_0.sortGoods)
	arg_3_0:setList(arg_3_0.storeItemList)
end

function var_0_0.sortGoods(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.maxBuyCount ~= 0 and arg_4_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_4_0.activityId, arg_4_0.id) <= 0

	if var_4_0 ~= (arg_4_1.maxBuyCount ~= 0 and arg_4_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_4_1.activityId, arg_4_1.id) <= 0) then
		if var_4_0 then
			return false
		end

		return true
	end

	return arg_4_0.id < arg_4_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
