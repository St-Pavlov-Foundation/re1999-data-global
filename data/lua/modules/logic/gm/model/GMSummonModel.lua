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

function var_0_0.getUpSummonHeroInfo(arg_5_0)
	return arg_5_0._upSummonHeroList
end

function var_0_0.getAllSummonHeroInfo(arg_6_0)
	return arg_6_0._allSummonHeroList
end

function var_0_0.getAllUpSummonName(arg_7_0)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._upSummonHeroList) do
		local var_7_1 = arg_7_0:getTargetName(iter_7_1.id)

		if iter_7_0 == 1 then
			var_7_0 = var_7_1
		else
			var_7_0 = var_7_0 .. "、" .. var_7_1
		end
	end

	return var_7_0
end

function var_0_0.setInfo(arg_8_0, arg_8_1)
	arg_8_0:reInit()

	arg_8_0._poolId = arg_8_1.poolId
	arg_8_0._totalCount = arg_8_1.totalCount
	arg_8_0._star6TotalCount = arg_8_1.star6TotalCount
	arg_8_0._star5TotalCount = arg_8_1.star5TotalCount

	arg_8_0:_setDiffRaritySummonHeroInfo(cjson.decode(arg_8_1.resJs1))
	arg_8_0:_setUpSummonHeroInfo(cjson.decode(arg_8_1.resJs2))
	arg_8_0:_setAllSummonHeroInfo(cjson.decode(arg_8_1.resJs3))
end

function var_0_0._setDiffRaritySummonHeroInfo(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_0 = iter_9_0 + 1
		local var_9_1 = string.split(iter_9_1, "#")
		local var_9_2 = var_9_1[1]
		local var_9_3 = var_9_1[2]

		table.insert(arg_9_0._diffRaritySummonHeroList, {
			star = tonumber(var_9_0),
			num = var_9_2,
			per = var_9_3
		})
	end

	table.sort(arg_9_0._diffRaritySummonHeroList, function(arg_10_0, arg_10_1)
		return arg_10_0.star > arg_10_1.star
	end)
end

function var_0_0._setUpSummonHeroInfo(arg_11_0, arg_11_1)
	local function var_11_0(arg_12_0, arg_12_1)
		if arg_12_0.star ~= arg_12_1.star then
			return arg_12_0.star > arg_12_1.star
		else
			return arg_12_0.id > arg_12_1.id
		end
	end

	arg_11_0:_setHeroInfo(arg_11_0._upSummonHeroList, arg_11_1, var_11_0)
end

function var_0_0._setAllSummonHeroInfo(arg_13_0, arg_13_1)
	local function var_13_0(arg_14_0, arg_14_1)
		if arg_14_0.per ~= arg_14_1.per then
			return arg_14_0.per > arg_14_1.per
		else
			return arg_14_0.id > arg_14_1.id
		end
	end

	arg_13_0:_setHeroInfo(arg_13_0._allSummonHeroList, arg_13_1, var_13_0)
	logNormal()
end

function var_0_0._setHeroInfo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
		local var_15_0 = {}

		for iter_15_2, iter_15_3 in pairs(iter_15_1) do
			local var_15_1 = var_0_0._index2Star[iter_15_0]
			local var_15_2 = string.split(iter_15_3, "#")
			local var_15_3 = var_15_2[1]
			local var_15_4 = var_15_2[2]

			table.insert(var_15_0, {
				id = tonumber(iter_15_2),
				star = var_15_1,
				num = var_15_3,
				per = tonumber(var_15_4)
			})
		end

		if #var_15_0 >= 2 then
			table.sort(var_15_0, arg_15_3)
		end

		tabletool.addValues(arg_15_1, var_15_0)
	end

	if #arg_15_1 >= 2 then
		table.sort(arg_15_1, arg_15_3)
	end
end

function var_0_0.getTargetName(arg_16_0, arg_16_1)
	return HeroConfig.instance:getHeroCO(arg_16_1).name
end

function var_0_0.getUpHeroInfo(arg_17_0)
	local var_17_0 = SummonConfig.instance:getSummonPool(arg_17_0._poolId)
	local var_17_1 = {}
	local var_17_2 = {}
	local var_17_3 = {}

	if not string.nilorempty(var_17_0.upWeight) then
		local var_17_4 = string.split(var_17_0.upWeight, "|")

		for iter_17_0, iter_17_1 in ipairs(var_17_4) do
			local var_17_5 = string.splitToNumber(iter_17_1, "#")

			tabletool.addValues(var_17_1, var_17_5)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0._upSummonHeroList) do
		if not tabletool.indexOf(var_17_1, iter_17_3.id) then
			table.insert(var_17_2, iter_17_3)
		else
			table.insert(var_17_3, iter_17_3)
		end
	end

	return var_17_3, var_17_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
