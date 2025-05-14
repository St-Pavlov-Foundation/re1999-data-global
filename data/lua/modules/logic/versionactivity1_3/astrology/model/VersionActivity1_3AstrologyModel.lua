module("modules.logic.versionactivity1_3.astrology.model.VersionActivity1_3AstrologyModel", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._planetList = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._planetList = {}
	arg_2_0._rewardList = nil
	arg_2_0._exchangeList = nil
end

function var_0_0.initData(arg_3_0)
	local var_3_0 = Activity126Model.instance:getStarProgressStr()

	if string.nilorempty(var_3_0) then
		var_3_0 = Activity126Config.instance:getConst(VersionActivity1_3Enum.ActivityId.Act310, Activity126Enum.constId.initAngle).value2
	end

	local var_3_1 = string.splitToNumber(var_3_0, "#")

	for iter_3_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_3_2 = VersionActivity1_3AstrologyEnum.PlanetItem[iter_3_0]
		local var_3_3 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_3_2)

		arg_3_0:_addPlanetData(iter_3_0, var_3_1[iter_3_0 - 1] or 0, var_3_3)
	end
end

function var_0_0._addPlanetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0._planetList[arg_4_1] or VersionActivity1_3AstrologyPlanetMo.New()

	var_4_0:init({
		id = arg_4_1,
		angle = arg_4_2,
		previewAngle = arg_4_2,
		num = arg_4_3
	})

	arg_4_0._planetList[arg_4_1] = var_4_0
end

function var_0_0.getQuadrantResult(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._planetList) do
		local var_5_2 = iter_5_1:getQuadrant()
		local var_5_3 = var_5_0[var_5_2] or {
			minId = 100,
			num = 0,
			quadrant = var_5_2,
			planetList = {}
		}

		var_5_3.num = var_5_3.num + 1

		if iter_5_0 < var_5_3.minId then
			var_5_3.minId = iter_5_0
		end

		var_5_0[var_5_2] = var_5_3
		var_5_1[iter_5_0] = var_5_2
	end

	local var_5_4 = var_5_1[VersionActivity1_3AstrologyEnum.Planet.yueliang]

	if var_5_4 == 7 or var_5_4 == 8 then
		return var_5_4
	end

	local var_5_5 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		table.insert(var_5_5, iter_5_3)
	end

	table.sort(var_5_5, arg_5_0._sortResult)

	return var_5_5[1].quadrant
end

function var_0_0._sortResult(arg_6_0, arg_6_1)
	if arg_6_0.num == arg_6_1.num then
		return arg_6_0.minId < arg_6_1.minId
	end

	return arg_6_0.num > arg_6_1.num
end

function var_0_0.generateStarProgressStr(arg_7_0)
	local var_7_0

	for iter_7_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_7_1 = arg_7_0._planetList[iter_7_0].previewAngle

		if string.nilorempty(var_7_0) then
			var_7_0 = string.format("%s", var_7_1)
		else
			var_7_0 = string.format("%s#%s", var_7_0, var_7_1)
		end
	end

	return var_7_0
end

function var_0_0.generateStarProgressCost(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_8_2 = arg_8_0._planetList[iter_8_0]:getCostNum()

		if var_8_2 > 0 then
			var_8_1[iter_8_0] = true

			for iter_8_1 = 1, var_8_2 do
				table.insert(var_8_0, VersionActivity1_3AstrologyEnum.PlanetItem[iter_8_0])
			end
		end
	end

	return var_8_0, var_8_1
end

function var_0_0.getPlanetMo(arg_9_0, arg_9_1)
	return arg_9_0._planetList[arg_9_1]
end

function var_0_0.hasAdjust(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._planetList) do
		if iter_10_1:hasAdjust() then
			return true
		end
	end
end

function var_0_0.isEffectiveAdjust(arg_11_0)
	if Activity126Model.instance:getStarNum() >= 10 then
		return false
	end

	return arg_11_0:hasAdjust()
end

function var_0_0.getAdjustNum(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._planetList) do
		var_12_0 = var_12_0 + iter_12_1:getCostNum()
	end

	return var_12_0
end

function var_0_0.setStarReward(arg_13_0, arg_13_1)
	arg_13_0._rewardList = arg_13_1
end

function var_0_0.getStarReward(arg_14_0)
	return arg_14_0._rewardList
end

function var_0_0.setExchangeList(arg_15_0, arg_15_1)
	arg_15_0._exchangeList = arg_15_1
end

function var_0_0.getExchangeList(arg_16_0)
	return arg_16_0._exchangeList
end

var_0_0.instance = var_0_0.New()

return var_0_0
