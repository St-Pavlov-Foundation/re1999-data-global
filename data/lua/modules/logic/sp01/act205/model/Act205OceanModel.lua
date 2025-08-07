module("modules.logic.sp01.act205.model.Act205OceanModel", package.seeall)

local var_0_0 = class("Act205OceanModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.curRandomGoldList = {}
	arg_2_0.curRandomDiceList = {}
	arg_2_0.randomDiceMap = {}
	arg_2_0.curSelectGoldId = 0
	arg_2_0.curSelectDiceIdList = {}
end

function var_0_0.getGoldList(arg_3_0)
	local var_3_0 = {}

	arg_3_0.curRandomGoldList = {}

	local var_3_1 = Act205Controller.instance:getPlayerPrefs(Act205Enum.saveLocalOceanGoldKey, "")

	if not string.nilorempty(var_3_1) then
		var_3_0 = string.splitToNumber(var_3_1, "#")
		arg_3_0.curRandomGoldList = var_3_0
	else
		var_3_0 = arg_3_0:getRandomGoldList()
	end

	return var_3_0
end

function var_0_0.getRandomGoldList(arg_4_0)
	if #arg_4_0.curRandomGoldList >= 3 then
		math.randomseed(os.time())
		table.sort(arg_4_0.curRandomGoldList, function()
			return math.random() < 0.5
		end)
		Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanGoldKey, table.concat(arg_4_0.curRandomGoldList, "#"))

		return arg_4_0.curRandomGoldList
	end

	local var_4_0 = {}
	local var_4_1 = arg_4_0:getAllNormalTypeGoldIdList()

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if not tabletool.indexOf(arg_4_0.curRandomGoldList, iter_4_1.id) then
			table.insert(var_4_0, iter_4_1)
		end
	end

	local var_4_2 = 0

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		var_4_2 = var_4_2 + iter_4_3.weight
	end

	local var_4_3 = math.random(1, var_4_2)
	local var_4_4 = 0

	for iter_4_4, iter_4_5 in ipairs(var_4_0) do
		var_4_4 = var_4_4 + iter_4_5.weight

		if var_4_3 <= var_4_4 then
			table.insert(arg_4_0.curRandomGoldList, iter_4_5.id)

			break
		end
	end

	if #arg_4_0.curRandomGoldList == 2 then
		local var_4_5 = arg_4_0:getRandomHardTypeGold()

		table.insert(arg_4_0.curRandomGoldList, var_4_5.id)
	end

	return arg_4_0:getRandomGoldList()
end

function var_0_0.getRandomHardTypeGold(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = Act205Config.instance:getDiceGoalConfigList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.hardType == Act205Enum.oceanGoldHardType.Hard then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0[math.random(1, #var_6_0)]
end

function var_0_0.getAllNormalTypeGoldIdList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = Act205Config.instance:getDiceGoalConfigList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.hardType == Act205Enum.oceanGoldHardType.Normal then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.getDiceList(arg_8_0, arg_8_1)
	local var_8_0 = {}

	arg_8_0.curRandomDiceList = {}

	local var_8_1 = Act205Controller.instance:getPlayerPrefs(Act205Enum.saveLocalOceanDiceKey, "")

	if not string.nilorempty(var_8_1) then
		local var_8_2 = cjson.decode(var_8_1)

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			local var_8_3 = GameUtil.splitString2(iter_8_1, true)

			arg_8_0.randomDiceMap[var_8_3[1][1]] = var_8_3[2]
		end

		if arg_8_0.randomDiceMap[arg_8_1] then
			var_8_0 = arg_8_0.randomDiceMap[arg_8_1]
		else
			var_8_0 = arg_8_0:createRandomDiceList(arg_8_1)
			arg_8_0.randomDiceMap[arg_8_1] = var_8_0
		end
	else
		var_8_0 = arg_8_0:createRandomDiceList(arg_8_1)
		arg_8_0.randomDiceMap[arg_8_1] = var_8_0
	end

	arg_8_0:saveLocalDiceMap()

	return var_8_0
end

function var_0_0.createRandomDiceList(arg_9_0, arg_9_1)
	local var_9_0 = Act205Model.instance:getGameInfoMo(Act205Enum.ActId, Act205Enum.GameStageId.Ocean)

	arg_9_0.curFailTimes = string.nilorempty(var_9_0:getGameInfo()) and 0 or tonumber(var_9_0:getGameInfo())

	local var_9_1 = Act205Config.instance:getAct205Const(Act205Enum.ConstId.OceanGameFailTimesToWin, true)
	local var_9_2 = Act205Config.instance:getWinDiceConfig()

	if var_9_1 <= arg_9_0.curFailTimes then
		for iter_9_0 = 1, 3 do
			table.insert(arg_9_0.curRandomDiceList, var_9_2.id)
		end

		return arg_9_0.curRandomDiceList
	end

	local var_9_3 = arg_9_0.curRandomGoldList[arg_9_1]
	local var_9_4 = Act205Config.instance:getDiceGoalConfig(var_9_3)

	if not string.nilorempty(var_9_4.bindingDice) then
		local var_9_5 = string.splitToNumber(var_9_4.bindingDice, "#")

		for iter_9_1, iter_9_2 in ipairs(var_9_5) do
			table.insert(arg_9_0.curRandomDiceList, iter_9_2)
		end
	end

	local var_9_6 = Act205Config.instance:getAct205Const(Act205Enum.ConstId.OceanGameAddWinWeight, true) * arg_9_0.curFailTimes
	local var_9_7 = Act205Config.instance:getWinDiceConfig()
	local var_9_8 = var_9_7.weight + var_9_6

	arg_9_0.newWinDiceCo = tabletool.copy(var_9_7)
	arg_9_0.newWinDiceCo.weight = var_9_8

	return arg_9_0:getRandomDiceList(arg_9_1)
end

function var_0_0.getRandomDiceList(arg_10_0, arg_10_1)
	if #arg_10_0.curRandomDiceList >= 3 then
		local var_10_0 = false

		for iter_10_0, iter_10_1 in ipairs(arg_10_0.curRandomDiceList) do
			if iter_10_1 == arg_10_0.newWinDiceCo.id then
				var_10_0 = true

				break
			end
		end

		if var_10_0 then
			arg_10_0.curRandomDiceList = {}

			for iter_10_2 = 1, 3 do
				table.insert(arg_10_0.curRandomDiceList, arg_10_0.newWinDiceCo.id)
			end
		else
			return arg_10_0.curRandomDiceList
		end
	end

	local var_10_1 = {}
	local var_10_2 = Act205Config.instance:getDicePoolConfigList()

	for iter_10_3, iter_10_4 in ipairs(var_10_2) do
		if not tabletool.indexOf(arg_10_0.curRandomDiceList, iter_10_4.id) and iter_10_4.winDice ~= 1 then
			table.insert(var_10_1, iter_10_4)
		end
	end

	table.insert(var_10_1, arg_10_0.newWinDiceCo)

	local var_10_3 = 0

	for iter_10_5, iter_10_6 in ipairs(var_10_1) do
		var_10_3 = var_10_3 + iter_10_6.weight
	end

	local var_10_4 = math.random(1, var_10_3)
	local var_10_5 = 0

	for iter_10_7, iter_10_8 in ipairs(var_10_1) do
		var_10_5 = var_10_5 + iter_10_8.weight

		if var_10_4 <= var_10_5 then
			table.insert(arg_10_0.curRandomDiceList, iter_10_8.id)

			break
		end
	end

	return arg_10_0:getRandomDiceList(arg_10_1)
end

function var_0_0.saveLocalDiceMap(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.randomDiceMap) do
		local var_11_1 = string.format("%s|%s", iter_11_0, table.concat(iter_11_1, "#"))

		table.insert(var_11_0, var_11_1)
	end

	Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanDiceKey, cjson.encode(var_11_0))
end

function var_0_0.setCurSelectGoldId(arg_12_0, arg_12_1)
	arg_12_0.curSelectGoldId = arg_12_1
end

function var_0_0.getCurSelectGoldId(arg_13_0)
	return arg_13_0.curSelectGoldId
end

function var_0_0.getGoldIndexByGoldId(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.curRandomGoldList) do
		if arg_14_1 == iter_14_1 then
			return iter_14_0
		end
	end
end

function var_0_0.setcurSelectDiceIdList(arg_15_0, arg_15_1)
	arg_15_0.curSelectDiceIdList = arg_15_1
end

function var_0_0.getcurSelectDiceIdList(arg_16_0)
	return arg_16_0.curSelectDiceIdList
end

function var_0_0.cleanLocalSaveKey(arg_17_0)
	Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanGoldKey, "")
	Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanDiceKey, "")

	arg_17_0.curRandomGoldList = {}
	arg_17_0.curRandomDiceList = {}
	arg_17_0.randomDiceMap = {}
end

function var_0_0.cleanSelectData(arg_18_0)
	arg_18_0.curSelectDiceIdList = {}
	arg_18_0.curSelectGoldId = 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
