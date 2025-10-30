module("modules.logic.gm.model.GMSummonModel", package.seeall)

local var_0_0 = class("GMSummonModel", BaseModel)

var_0_0._index2Star = {
	6,
	5,
	4,
	3,
	2
}

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._allSummonHeroList = {}
	arg_2_0._upSummonHeroList = {}
	arg_2_0._diffRaritySummonHeroList = {}
	arg_2_0._diffRaritySummonShowList = {}
	arg_2_0._poolId = nil
	arg_2_0._totalCount = nil
	arg_2_0._star6TotalCount = nil
	arg_2_0._star5TotalCount = nil
end

function var_0_0.getAllInfo(arg_3_0)
	return arg_3_0._poolId, arg_3_0._totalCount, arg_3_0._star6TotalCount, arg_3_0._star5TotalCount
end

function var_0_0.getDiffRaritySummonHeroInfo(arg_4_0)
	return arg_4_0._diffRaritySummonHeroList
end

function var_0_0.getDiffRaritySummonShowInfo(arg_5_0)
	return arg_5_0._diffRaritySummonShowList
end

function var_0_0.getUpSummonHeroInfo(arg_6_0)
	return arg_6_0._upSummonHeroList
end

function var_0_0.getAllSummonHeroInfo(arg_7_0)
	return arg_7_0._allSummonHeroList
end

function var_0_0.getAllUpSummonName(arg_8_0)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._upSummonHeroList) do
		local var_8_1 = arg_8_0:getTargetName(iter_8_1.id)

		if iter_8_0 == 1 then
			var_8_0 = var_8_1
		else
			var_8_0 = var_8_0 .. "、" .. var_8_1
		end
	end

	return var_8_0
end

function var_0_0.setInfo(arg_9_0, arg_9_1)
	arg_9_0:reInit()

	arg_9_0._poolId = arg_9_1.poolId
	arg_9_0._totalCount = arg_9_1.totalCount
	arg_9_0._star6TotalCount = arg_9_1.star6TotalCount
	arg_9_0._star5TotalCount = arg_9_1.star5TotalCount

	local var_9_0 = cjson.decode(arg_9_1.resJs1)

	arg_9_0:_setDiffRaritySummonHeroInfo(var_9_0[1])
	arg_9_0:_setDiffRaritySummonShowInfo(var_9_0[2])
	arg_9_0:_setUpSummonHeroInfo(cjson.decode(arg_9_1.resJs2))
	arg_9_0:_setAllSummonHeroInfo(cjson.decode(arg_9_1.resJs3))
end

function var_0_0._setDiffRaritySummonHeroInfo(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		local var_10_0 = iter_10_0 + 1
		local var_10_1 = string.split(iter_10_1, "#")
		local var_10_2 = var_10_1[1]
		local var_10_3 = var_10_1[2]

		table.insert(arg_10_0._diffRaritySummonHeroList, {
			star = tonumber(var_10_0),
			num = var_10_2,
			per = var_10_3
		})
	end

	table.sort(arg_10_0._diffRaritySummonHeroList, function(arg_11_0, arg_11_1)
		return arg_11_0.star > arg_11_1.star
	end)
end

function var_0_0._setDiffRaritySummonShowInfo(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		local var_12_0 = iter_12_0 + 1

		table.insert(arg_12_0._diffRaritySummonShowList, {
			star = tonumber(var_12_0),
			num = iter_12_1
		})
	end

	table.sort(arg_12_0._diffRaritySummonShowList, function(arg_13_0, arg_13_1)
		return arg_13_0.star > arg_13_1.star
	end)
end

function var_0_0._setUpSummonHeroInfo(arg_14_0, arg_14_1)
	local function var_14_0(arg_15_0, arg_15_1)
		if arg_15_0.star ~= arg_15_1.star then
			return arg_15_0.star > arg_15_1.star
		else
			return arg_15_0.id > arg_15_1.id
		end
	end

	arg_14_0:_setHeroInfo(arg_14_0._upSummonHeroList, arg_14_1, var_14_0)
end

function var_0_0._setAllSummonHeroInfo(arg_16_0, arg_16_1)
	local function var_16_0(arg_17_0, arg_17_1)
		if arg_17_0.per ~= arg_17_1.per then
			return arg_17_0.per > arg_17_1.per
		else
			return arg_17_0.id > arg_17_1.id
		end
	end

	arg_16_0:_setHeroInfo(arg_16_0._allSummonHeroList, arg_16_1, var_16_0)
	logNormal()
end

function var_0_0._setHeroInfo(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		local var_18_0 = {}

		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			local var_18_1 = var_0_0._index2Star[iter_18_0]
			local var_18_2 = string.split(iter_18_3, "#")
			local var_18_3 = var_18_2[1]
			local var_18_4 = var_18_2[2]

			table.insert(var_18_0, {
				id = tonumber(iter_18_2),
				star = var_18_1,
				num = var_18_3,
				per = tonumber(var_18_4)
			})
		end

		if #var_18_0 >= 2 then
			table.sort(var_18_0, arg_18_3)
		end

		tabletool.addValues(arg_18_1, var_18_0)
	end

	if #arg_18_1 >= 2 then
		table.sort(arg_18_1, arg_18_3)
	end
end

function var_0_0.getTargetName(arg_19_0, arg_19_1)
	return HeroConfig.instance:getHeroCO(arg_19_1).name
end

function var_0_0.getUpHeroInfo(arg_20_0)
	local var_20_0 = SummonConfig.instance:getSummonPool(arg_20_0._poolId)
	local var_20_1 = {}
	local var_20_2 = {}
	local var_20_3 = {}

	if not string.nilorempty(var_20_0.upWeight) then
		local var_20_4 = string.split(var_20_0.upWeight, "|")

		for iter_20_0, iter_20_1 in ipairs(var_20_4) do
			local var_20_5 = string.splitToNumber(iter_20_1, "#")

			tabletool.addValues(var_20_1, var_20_5)
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0._upSummonHeroList) do
		if not tabletool.indexOf(var_20_1, iter_20_3.id) then
			table.insert(var_20_2, iter_20_3)
		else
			table.insert(var_20_3, iter_20_3)
		end
	end

	return var_20_3, var_20_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
