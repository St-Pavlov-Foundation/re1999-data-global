module("modules.logic.survival.model.shelter.SurvivalWeekClientDataMo", package.seeall)

local var_0_0 = pureTable("SurvivalWeekClientDataMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}

	if not string.nilorempty(arg_1_1) then
		var_1_0 = cjson.decode(arg_1_1)
	end

	if var_1_0.ver and var_1_0.ver ~= arg_1_0:getCurVersion() then
		var_1_0 = {}
	end

	var_1_0.ver = var_1_0.ver or arg_1_0:getCurVersion()

	local var_1_1 = false

	if not var_1_0.nowUnlockMapsCount then
		var_1_0.nowUnlockMapsCount = #arg_1_2.mapInfos
		var_1_1 = true
	end

	var_1_0.shopLevelUI = var_1_0.shopLevelUI or {}
	var_1_0.shopHUDLevelUI = var_1_0.shopHUDLevelUI or {}
	var_1_0.decodingItemNum = var_1_0.decodingItemNum or 0
	var_1_0.isBossWeak = var_1_0.isBossWeak or false
	var_1_0.bossRepress = var_1_0.bossRepress or {}
	var_1_0.bossRepressProgress = var_1_0.bossRepressProgress or 0.089
	arg_1_0.data = var_1_0

	if var_1_1 and arg_1_2.day > 0 then
		arg_1_0.isDirty = true

		arg_1_0:saveDataToServer()
	end
end

function var_0_0.getCurVersion(arg_2_0)
	return 1
end

function var_0_0.setHeroCount(arg_3_0, arg_3_1)
	arg_3_0.data.npcCount = arg_3_1
	arg_3_0.isDirty = true
end

function var_0_0.setNpcCount(arg_4_0, arg_4_1)
	arg_4_0.data.heroCount = arg_4_1
	arg_4_0.isDirty = true
end

function var_0_0.setIsBossWeak(arg_5_0, arg_5_1)
	arg_5_0.data.isBossWeak = arg_5_1
	arg_5_0.isDirty = true
end

function var_0_0.setDecodingItemNum(arg_6_0, arg_6_1)
	arg_6_0.data.decodingItemNum = arg_6_1
	arg_6_0.isDirty = true
end

function var_0_0.getReputationShopUILevel(arg_7_0, arg_7_1)
	local var_7_0 = tostring(arg_7_1)

	if arg_7_0.data.shopLevelUI[var_7_0] then
		return arg_7_0.data.shopLevelUI[var_7_0]
	end

	return 0
end

function var_0_0.setReputationShopUILevel(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0:getReputationShopUILevel(arg_8_1) ~= arg_8_2 then
		local var_8_0 = tostring(arg_8_1)

		arg_8_0.data.shopLevelUI[var_8_0] = arg_8_2
		arg_8_0.isDirty = true
	end
end

function var_0_0.getReputationShopHUDUILevel(arg_9_0, arg_9_1)
	local var_9_0 = tostring(arg_9_1)

	if arg_9_0.data.shopHUDLevelUI[var_9_0] then
		return arg_9_0.data.shopHUDLevelUI[var_9_0]
	end

	return 0
end

function var_0_0.setReputationShopHUDUILevel(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0:getReputationShopHUDUILevel(arg_10_1) ~= arg_10_2 then
		local var_10_0 = tostring(arg_10_1)

		arg_10_0.data.shopHUDLevelUI[var_10_0] = arg_10_2
		arg_10_0.isDirty = true
	end
end

function var_0_0.getBossRepress(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = string.format("%s_%s", arg_11_1, arg_11_2)

	if arg_11_0.data.bossRepress[var_11_0] then
		return arg_11_0.data.bossRepress[var_11_0]
	end

	return 0
end

function var_0_0.setBossRepress(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = string.format("%s_%s", arg_12_1, arg_12_2)

	arg_12_0.data.bossRepress[var_12_0] = true
	arg_12_0.isDirty = true
end

function var_0_0.getBossRepressProgress(arg_13_0, arg_13_1)
	local var_13_0 = tostring(arg_13_1)

	if arg_13_0.data.bossRepressProgress[var_13_0] then
		return arg_13_0.data.bossRepressProgress[var_13_0]
	end

	return 0.089
end

function var_0_0.setBossRepressProgress(arg_14_0, arg_14_1)
	arg_14_0.data.bossRepressProgress = arg_14_1
	arg_14_0.isDirty = true
end

function var_0_0.saveDataToServer(arg_15_0, arg_15_1)
	if SurvivalModel.instance:getSurvivalSettleInfo() then
		return
	end

	if arg_15_1 or arg_15_0.isDirty then
		SurvivalWeekRpc.instance:sendSurvivalSurvivalWeekClientData(cjson.encode(arg_15_0.data))

		arg_15_0.isDirty = false
	end
end

return var_0_0
