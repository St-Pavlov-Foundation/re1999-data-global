module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

local var_0_0 = {}

function var_0_0.defineMgrRef()
	local var_1_0 = FightDataMgr.instance.mgrList

	for iter_1_0, iter_1_1 in pairs(FightDataMgr.instance) do
		for iter_1_2, iter_1_3 in ipairs(var_1_0) do
			if iter_1_3 == iter_1_1 then
				var_0_0[iter_1_0] = iter_1_3

				break
			end
		end
	end
end

function var_0_0.initDataMgr()
	var_0_0.lastFightResult = nil

	FightLocalDataMgr.instance:initDataMgr()
	FightDataMgr.instance:initDataMgr()
	var_0_0.defineMgrRef()
	FightMsgMgr.sendMsg(FightMsgId.AfterInitDataMgrRef)
end

function var_0_0.initFightData(arg_3_0)
	if not arg_3_0 then
		var_0_0.version = 999
		FightModel.instance._version = var_0_0.version

		return
	end

	var_0_0.version = FightModel.GMForceVersion or arg_3_0.version or 0
	FightModel.instance._version = var_0_0.version

	var_0_0.checkReplay(arg_3_0)
	FightLocalDataMgr.instance:updateFightData(arg_3_0)
	FightDataMgr.instance:updateFightData(arg_3_0)
end

function var_0_0.checkReplay(arg_4_0)
	local var_4_0 = var_0_0.version
	local var_4_1 = arg_4_0.isRecord

	if var_4_0 >= 1 then
		if var_4_1 then
			var_0_0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		end
	else
		local var_4_2 = FightModel.instance:getFightParam()

		if var_4_2 and var_4_2.isReplay then
			var_0_0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		elseif FightReplayModel.instance:isReconnectReplay() then
			var_0_0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		end
	end
end

function var_0_0.cacheFightWavePush(arg_5_0)
	FightLocalDataMgr.instance.cacheFightMgr:cacheFightWavePush(arg_5_0.fight)
	FightDataMgr.instance.cacheFightMgr:cacheFightWavePush(arg_5_0.fight)
end

function var_0_0.playEffectData(arg_6_0)
	if arg_6_0:isDone() then
		return
	end

	var_0_0.calMgr:playActEffectData(arg_6_0)
end

local var_0_1 = {
	class = true
}

function var_0_0.coverData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0 == nil then
		arg_7_0 = {}
	end

	if arg_7_1 == nil then
		arg_7_1 = {}

		local var_7_0 = getmetatable(arg_7_0)

		if var_7_0 then
			setmetatable(arg_7_1, var_7_0)
		end
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_1 = false

		if arg_7_2 and arg_7_2[iter_7_0] then
			var_7_1 = true
		end

		if var_0_1[iter_7_0] then
			var_7_1 = true
		end

		if not var_7_1 and arg_7_0[iter_7_0] == nil then
			arg_7_1[iter_7_0] = nil
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0) do
		local var_7_2 = false

		if arg_7_2 and arg_7_2[iter_7_2] then
			var_7_2 = true
		end

		if var_0_1[iter_7_2] then
			var_7_2 = true
		end

		if not var_7_2 then
			if arg_7_3 and arg_7_3[iter_7_2] then
				arg_7_3[iter_7_2](arg_7_0, arg_7_1)
			elseif arg_7_1[iter_7_2] == nil then
				arg_7_1[iter_7_2] = FightHelper.deepCopySimpleWithMeta(arg_7_0[iter_7_2])
			elseif type(iter_7_3) == "table" then
				var_0_0.coverInternal(iter_7_3, arg_7_1[iter_7_2])
			else
				arg_7_1[iter_7_2] = iter_7_3
			end
		end
	end

	return arg_7_1
end

function var_0_0.coverInternal(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if arg_8_0[iter_8_0] == nil then
			arg_8_1[iter_8_0] = nil
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0) do
		if type(iter_8_3) == "table" then
			if arg_8_1[iter_8_2] == nil then
				arg_8_1[iter_8_2] = FightHelper.deepCopySimpleWithMeta(iter_8_3)
			else
				var_0_0.coverInternal(iter_8_3, arg_8_1[iter_8_2])
			end
		else
			arg_8_1[iter_8_2] = iter_8_3
		end
	end
end

var_0_0.findDiffList = {}
var_0_0.findDiffPath = {}

function var_0_0.addPathkey(arg_9_0)
	table.insert(var_0_0.findDiffPath, arg_9_0)
end

function var_0_0.removePathKey()
	table.remove(var_0_0.findDiffPath)
end

function var_0_0.findDiff(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	var_0_0.findDiffList = {}
	var_0_0.findDiffPath = {}

	var_0_0.doFindDiff(arg_11_0, arg_11_1, arg_11_2, arg_11_3)

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(var_0_0.findDiffList) do
		local var_11_1 = iter_11_1.pathList[1]

		var_11_0[var_11_1] = var_11_0[var_11_1] or {}

		table.insert(var_11_0[var_11_1], iter_11_1)
	end

	return #var_0_0.findDiffList > 0, var_11_0, var_0_0.findDiffList
end

function var_0_0.doFindDiff(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if type(arg_12_0) ~= "table" or type(arg_12_1) ~= "table" then
		logError("传入的参数必须是表结构,请检查代码")

		return
	end

	var_0_0.doCheckMissing(arg_12_0, arg_12_1, arg_12_2)

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		local var_12_0 = false

		if arg_12_2 and arg_12_2[iter_12_0] then
			var_12_0 = true
		end

		if not var_12_0 and arg_12_1[iter_12_0] ~= nil then
			var_0_0.addPathkey(iter_12_0)

			if arg_12_3 and arg_12_3[iter_12_0] then
				arg_12_3[iter_12_0](arg_12_0[iter_12_0], arg_12_1[iter_12_0], arg_12_0, arg_12_1)
			elseif arg_12_4 then
				arg_12_4(arg_12_0[iter_12_0], arg_12_1[iter_12_0])
			else
				var_0_0.checkDifference(arg_12_0[iter_12_0], arg_12_1[iter_12_0])
			end

			var_0_0.removePathKey()
		end
	end
end

function var_0_0.checkDifference(arg_13_0, arg_13_1)
	if type(arg_13_0) ~= type(arg_13_1) then
		var_0_0.addDiff(nil, var_0_0.diffType.difference)

		return
	elseif type(arg_13_0) == "table" then
		var_0_0.doCheckMissing(arg_13_0, arg_13_1)

		for iter_13_0, iter_13_1 in pairs(arg_13_0) do
			if arg_13_1[iter_13_0] ~= nil then
				var_0_0.addPathkey(iter_13_0)
				var_0_0.checkDifference(iter_13_1, arg_13_1[iter_13_0])
				var_0_0.removePathKey()
			end
		end
	elseif arg_13_0 ~= arg_13_1 then
		var_0_0.addDiff(nil, var_0_0.diffType.difference)
	end
end

function var_0_0.doCheckMissing(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		local var_14_0 = false

		if arg_14_2 and arg_14_2[iter_14_0] then
			var_14_0 = true
		end

		if not var_14_0 and arg_14_0[iter_14_0] == nil then
			var_0_0.addDiff(iter_14_0, var_0_0.diffType.missingSource)
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0) do
		local var_14_1 = false

		if arg_14_2 and arg_14_2[iter_14_2] then
			var_14_1 = true
		end

		if not var_14_1 and arg_14_1[iter_14_2] == nil then
			var_0_0.addDiff(iter_14_2, var_0_0.diffType.missingTarget)
		end
	end
end

var_0_0.diffType = {
	missingTarget = 2,
	difference = 3,
	missingSource = 1
}

function var_0_0.addDiff(arg_15_0, arg_15_1)
	local var_15_0 = {
		diffType = arg_15_1 or var_0_0.diffType.difference
	}
	local var_15_1 = var_0_0.coverData(var_0_0.findDiffPath)

	if arg_15_0 then
		table.insert(var_15_1, arg_15_0)
	end

	var_15_0.pathList = var_15_1
	var_15_0.pathStr = table.concat(var_15_1, ".")

	table.insert(var_0_0.findDiffList, var_15_0)

	return var_15_0
end

function var_0_0.getDiffValue(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1
	local var_16_2 = arg_16_2.pathList
	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_1

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		var_16_0 = var_16_3[iter_16_1]
		var_16_1 = var_16_4[iter_16_1]
		var_16_3 = var_16_0
		var_16_4 = var_16_1
	end

	var_16_0 = var_16_0 == nil and "nil" or var_16_0
	var_16_1 = var_16_1 == nil and "nil" or var_16_1

	return var_16_0, var_16_1
end

var_0_0.initDataMgr()

return var_0_0
