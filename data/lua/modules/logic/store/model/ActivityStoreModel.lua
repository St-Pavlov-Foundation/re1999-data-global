module("modules.logic.store.model.ActivityStoreModel", package.seeall)

local var_0_0 = class("ActivityStoreModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.activityGoodsInfosDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initActivityGoodsInfos(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.activityGoodsInfosDict = arg_3_0.activityGoodsInfosDict or {}

	local var_3_0 = {}
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		local var_3_2 = ActivityStoreMo.New()

		var_3_2:init(arg_3_1, iter_3_1)

		var_3_0[var_3_2.id] = var_3_2
	end

	arg_3_0.activityGoodsInfosDict[arg_3_1] = var_3_0
end

function var_0_0.updateActivityGoodsInfos(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.activityGoodsInfosDict[arg_4_1]
	local var_4_1 = var_4_0[arg_4_2.id]

	if not var_4_1 then
		var_4_1 = ActivityStoreMo.New()

		var_4_1:init(arg_4_1, arg_4_2)

		var_4_0[var_4_1.id] = var_4_1
	else
		var_4_1:updateData(arg_4_2)
	end
end

function var_0_0.getActivityGoodsBuyCount(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.activityGoodsInfosDict

	if not var_5_0 or not var_5_0[arg_5_1] or not var_5_0[arg_5_1][arg_5_2] then
		return 0
	end

	return var_5_0[arg_5_1][arg_5_2].buyCount or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
