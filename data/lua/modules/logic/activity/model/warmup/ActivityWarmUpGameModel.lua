module("modules.logic.activity.model.warmup.ActivityWarmUpGameModel", package.seeall)

local var_0_0 = class("ActivityWarmUpGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	arg_3_0._settings = nil
	arg_3_0._blockDatas = nil
	arg_3_0._matDatas = nil
	arg_3_0._bindMap = nil
	arg_3_0._targetMatList = nil
	arg_3_0.curMatIndex = 0
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:release()

	arg_4_0._settings = arg_4_1

	if arg_4_0:checkParamAvalid() then
		arg_4_0._blockDatas = arg_4_0:genLevelData()
	end

	if not arg_4_3 then
		arg_4_0.pointerVal = 0.5
	end

	arg_4_0:initMatTarget(arg_4_2)
	arg_4_0:bindMaterials()
end

function var_0_0.initMatTarget(arg_5_0, arg_5_1)
	if #arg_5_1 <= 0 then
		logError("totalPoolIds length can't be Zero!")

		return
	end

	arg_5_0._matDatas = tabletool.copy(arg_5_1)
	arg_5_0._targetMatList = {}
	arg_5_0.curMatIndex = 1

	local var_5_0 = tabletool.copy(arg_5_1)

	for iter_5_0 = 1, arg_5_0._settings.blockCount do
		local var_5_1 = #var_5_0

		if var_5_1 <= 0 then
			for iter_5_1, iter_5_2 in pairs(arg_5_1) do
				var_5_0[iter_5_1] = iter_5_2
			end

			var_5_1 = #var_5_0
		end

		local var_5_2 = math.random(var_5_1)
		local var_5_3 = var_5_0[var_5_2]

		table.insert(arg_5_0._targetMatList, var_5_3)
		table.remove(var_5_0, var_5_2)
	end
end

function var_0_0.bindMaterials(arg_6_0)
	arg_6_0._bindMap = {}

	local var_6_0 = tabletool.copy(arg_6_0._targetMatList)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._blockDatas) do
		local var_6_1 = #var_6_0
		local var_6_2 = math.random(var_6_1)
		local var_6_3 = var_6_0[var_6_2]

		arg_6_0._bindMap[iter_6_1] = var_6_3

		table.remove(var_6_0, var_6_2)
	end
end

function var_0_0.getBlockDataByPointer(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._blockDatas) do
		if arg_7_1 >= iter_7_1.startPos then
			if arg_7_1 <= iter_7_1.endPos then
				return iter_7_1
			end
		else
			return nil
		end
	end
end

function var_0_0.isCurrentTarget(arg_8_0, arg_8_1)
	if arg_8_0._bindMap[arg_8_1] == arg_8_0._targetMatList[arg_8_0.curMatIndex] then
		return true
	end

	return false
end

function var_0_0.matIsUsed(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._targetMatList) do
		if iter_9_0 >= arg_9_0.curMatIndex then
			return false
		end

		if iter_9_1 == arg_9_1 then
			return true
		end
	end

	return false
end

function var_0_0.gotoNextTarget(arg_10_0)
	arg_10_0.curMatIndex = arg_10_0.curMatIndex + 1
end

function var_0_0.isAllTargetClean(arg_11_0)
	return arg_11_0.curMatIndex > arg_11_0._settings.blockCount
end

function var_0_0.getBlockDatas(arg_12_0)
	return arg_12_0._blockDatas
end

function var_0_0.getTargetMatIDs(arg_13_0)
	return arg_13_0._targetMatList
end

function var_0_0.getBindMatByBlock(arg_14_0, arg_14_1)
	return arg_14_0._bindMap[arg_14_1]
end

function var_0_0.getRoundInfo(arg_15_0)
	if arg_15_0._settings ~= nil then
		return arg_15_0.round, arg_15_0._settings.victoryRound
	end

	return nil
end

function var_0_0.genLevelData(arg_16_0)
	local var_16_0 = arg_16_0:step1BreakInterval()
	local var_16_1 = arg_16_0:step2PickBasePos(var_16_0)

	arg_16_0:step3Grow(var_16_1)

	return var_16_1
end

function var_0_0.step1BreakInterval(arg_17_0)
	local var_17_0 = arg_17_0._settings.minBlock + arg_17_0._settings.blockInterval
	local var_17_1 = math.floor(1 / var_17_0)
	local var_17_2 = {}

	if var_17_1 > 200 then
		logWarn("ActivityWarmUpGameModel data amount over 200!")
	end

	for iter_17_0 = 1, var_17_1 do
		table.insert(var_17_2, (iter_17_0 - 1) * var_17_0)
	end

	return var_17_2
end

function var_0_0.step2PickBasePos(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._settings.blockCount
	local var_18_1 = {}

	for iter_18_0 = 1, var_18_0 do
		local var_18_2 = {}
		local var_18_3 = math.random(#arg_18_1)

		var_18_2.startPos = arg_18_1[var_18_3] + arg_18_0._settings.blockInterval

		table.remove(arg_18_1, var_18_3)

		var_18_2.endPos = var_18_2.startPos + arg_18_0._settings.minBlock

		table.insert(var_18_1, var_18_2)
	end

	table.sort(var_18_1, var_0_0.sortBlockWithPos)

	return var_18_1
end

function var_0_0.step3Grow(arg_19_0, arg_19_1)
	for iter_19_0 = #arg_19_1, 1, -1 do
		local var_19_0 = arg_19_1[iter_19_0]

		arg_19_0:growSingleBlock(var_19_0, arg_19_1, iter_19_0)
	end
end

function var_0_0.growSingleBlock(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_2[arg_20_3 + 1]
	local var_20_1 = 1

	if var_20_0 then
		var_20_1 = var_20_0.startPos - arg_20_0._settings.blockInterval
	end

	local var_20_2 = var_20_1 - arg_20_1.endPos
	local var_20_3 = math.min(var_20_2, arg_20_0._settings.randomLength)
	local var_20_4 = math.random() * var_20_3

	arg_20_1.endPos = arg_20_1.endPos + var_20_4

	local var_20_5 = var_20_2 - var_20_4

	if var_20_5 > 0 and math.random() >= arg_20_0._settings.stayProb then
		local var_20_6 = var_20_5 * math.random()

		arg_20_1.startPos = arg_20_1.startPos + var_20_6
		arg_20_1.endPos = arg_20_1.endPos + var_20_6
	end
end

function var_0_0.sortBlockWithPos(arg_21_0, arg_21_1)
	return arg_21_0.startPos < arg_21_1.startPos
end

function var_0_0.checkParamAvalid(arg_22_0)
	if (arg_22_0._settings.minBlock + arg_22_0._settings.blockInterval) * arg_22_0._settings.blockCount >= 1 then
		logError("generate param error, min interval too large!")

		return false
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
