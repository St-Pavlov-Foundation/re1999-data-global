module("modules.logic.rouge.model.RougeFavoriteModel", package.seeall)

local var_0_0 = class("RougeFavoriteModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._reddots = {}
	arg_2_0._reviewInfoList = {}
end

function var_0_0.initReddots(arg_3_0, arg_3_1)
	arg_3_0._reddots = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = RougeNewReddotNOMO.New()

		var_3_0:init(iter_3_1)

		arg_3_0._reddots[iter_3_1.type] = var_3_0
	end
end

function var_0_0.getReddotNum(arg_4_0, arg_4_1)
	return arg_4_0._reddots[arg_4_1].idNum
end

function var_0_0.getReddotMap(arg_5_0, arg_5_1)
	return arg_5_0._reddots[arg_5_1].idMap
end

function var_0_0.getReddot(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0._reddots[arg_6_1].idMap[arg_6_2]
end

function var_0_0.deleteReddotId(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._reddots[arg_7_1]:removeId(arg_7_2)
end

function var_0_0.getAllReddotNum(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0._reddots) do
		var_8_0 = var_8_0 + iter_8_1.idNum
	end

	return var_8_0
end

function var_0_0.initReviews(arg_9_0, arg_9_1)
	arg_9_0._reviewInfoList = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = RougeReviewMO.New()

		var_9_0:init(iter_9_1)
		table.insert(arg_9_0._reviewInfoList, var_9_0)
	end
end

function var_0_0.getReviewInfoList(arg_10_0)
	return arg_10_0._reviewInfoList
end

function var_0_0.initUnlockCollectionIds(arg_11_0, arg_11_1)
	arg_11_0._collectionMap = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		arg_11_0._collectionMap[iter_11_1] = iter_11_1
	end
end

function var_0_0.collectionIsUnlock(arg_12_0, arg_12_1)
	return arg_12_0._collectionMap and arg_12_0._collectionMap[arg_12_1] ~= nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
