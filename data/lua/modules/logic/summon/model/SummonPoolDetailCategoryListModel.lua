module("modules.logic.summon.model.SummonPoolDetailCategoryListModel", package.seeall)

local var_0_0 = class("SummonPoolDetailCategoryListModel", ListScrollModel)

function var_0_0.initCategory(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 1, 2 do
		table.insert(var_1_0, arg_1_0:packMo(var_0_0.getName(iter_1_0), var_0_0.getNameEn(iter_1_0), iter_1_0))
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.packMo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._moList = arg_2_0._moList or {}

	local var_2_0 = arg_2_0._moList[arg_2_3]

	if not var_2_0 then
		var_2_0 = {}
		arg_2_0._moList[arg_2_3] = var_2_0
		var_2_0.enName = arg_2_2
		var_2_0.resIndex = arg_2_3
	end

	var_2_0.cnName = arg_2_1

	return var_2_0
end

function var_0_0.setJumpLuckyBag(arg_3_0, arg_3_1)
	arg_3_0._jumpLuckyBagId = arg_3_1
end

function var_0_0.getJumpLuckyBag(arg_4_0)
	return arg_4_0._jumpLuckyBagId
end

function var_0_0.getName(arg_5_0)
	if not var_0_0.nameDict then
		var_0_0.nameDict = {
			[1] = "p_summon_pool_detail",
			[2] = "p_summon_pool_probability"
		}
	end

	return luaLang(var_0_0.nameDict[arg_5_0])
end

function var_0_0.getNameEn(arg_6_0)
	if not var_0_0.nameEnDict then
		var_0_0.nameEnDict = {
			[1] = "p_summon_pool_detailEn",
			[2] = "p_summon_pool_probabilityEn"
		}
	end

	return luaLang(var_0_0.nameEnDict[arg_6_0])
end

function var_0_0.buildProbUpDict(arg_7_0)
	local var_7_0 = SummonConfig.instance:getSummonPool(arg_7_0)
	local var_7_1 = {
		5,
		4
	}
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = false

	if not string.nilorempty(var_7_0.upWeight) then
		local var_7_5 = string.split(var_7_0.upWeight, "|")

		for iter_7_0, iter_7_1 in ipairs(var_7_5) do
			local var_7_6 = var_7_1[iter_7_0]
			local var_7_7 = string.splitToNumber(iter_7_1, "#")

			var_7_2[var_7_6] = var_7_7

			tabletool.addValues(var_7_3, var_7_7)

			var_7_4 = true
		end
	end

	return var_7_2, var_7_3, var_7_4
end

function var_0_0.buildLuckyBagDict(arg_8_0)
	local var_8_0 = SummonConfig.instance:getSummonPool(arg_8_0)
	local var_8_1 = SummonConfig.instance:getSummonLuckyBag(arg_8_0)
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		table.insert(var_8_2, iter_8_1)
		table.insert(var_8_3, SummonConfig.instance:getLuckyBagHeroIds(arg_8_0, iter_8_1))
	end

	return var_8_2, var_8_3
end

function var_0_0.buildCustomPickDict(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = SummonMainModel.instance:getPoolServerMO(arg_9_0)

	if var_9_1 and var_9_1.customPickMO and var_9_1.customPickMO.pickHeroIds then
		local var_9_2 = #var_9_1.customPickMO.pickHeroIds

		for iter_9_0 = 1, var_9_2 do
			local var_9_3 = var_9_1.customPickMO.pickHeroIds[iter_9_0]

			table.insert(var_9_0, var_9_3)
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
