module("modules.logic.fight.controller.entitymohelper.FightEntityMoDiffHelper", package.seeall)

local var_0_0 = _M

var_0_0.DeepMaxStack = 100

local var_0_1 = {}
local var_0_2 = "entityMo1"
local var_0_3 = "[表现层数据] entityMo2"
local var_0_4 = 0

function var_0_0.getDiffMsg(arg_1_0, arg_1_1)
	var_0_0.initGetDiffHandleDict()
	tabletool.clear(var_0_1)

	var_0_4 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if not FightEntityMoCompareHelper.CompareFilterAttrDict[iter_1_0] then
			(var_0_0.diffHandleDict[iter_1_0] or var_0_0.defaultDiff)(iter_1_1, arg_1_1[iter_1_0], iter_1_0)
		end
	end

	return table.concat(var_0_1, "\n")
end

function var_0_0.getTypeDiffMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_4 = var_0_4 + 1

	table.insert(var_0_1, string.format("\n[error %s] key : %s, \n%s.%s type is %s, \n%s.%s type is %s", var_0_4, arg_2_0, arg_2_1, arg_2_0, arg_2_2, arg_2_3, arg_2_0, arg_2_4))
end

function var_0_0.getValueDiffMsg(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	var_0_4 = var_0_4 + 1

	table.insert(var_0_1, string.format("\n[error %s] key : %s, \n%s.%s = %s, \n%s.%s = %s", var_0_4, arg_3_0, arg_3_1, arg_3_0, arg_3_2, arg_3_3, arg_3_0, arg_3_4))
end

function var_0_0.addDiffMsg(arg_4_0)
	table.insert(var_0_1, "\n" .. tostring(arg_4_0))
end

function var_0_0.initGetDiffHandleDict()
	if not var_0_0.diffHandleDict then
		var_0_0.diffHandleDict = {
			buffModel = var_0_0.buffModelDiff,
			_powerInfos = var_0_0.defaultTableDeepDiff,
			summonedInfo = var_0_0.summonedInfoDiff
		}
	end
end

function var_0_0.defaultDiff(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 == arg_6_1 then
		return
	end

	if not arg_6_0 or not arg_6_1 then
		var_0_0.getValueDiffMsg(arg_6_2, var_0_2, arg_6_0, var_0_3, arg_6_1)

		return
	end

	local var_6_0 = type(arg_6_0)
	local var_6_1 = type(arg_6_1)

	if var_6_0 ~= var_6_1 then
		var_0_0.getTypeDiffMsg(arg_6_2, var_0_2, var_6_0, var_0_3, var_6_1)

		return
	end

	if var_6_0 == "table" then
		return var_0_0.defaultTableDiff(arg_6_0, arg_6_1, arg_6_2)
	end

	if arg_6_0 ~= arg_6_1 then
		var_0_0.getValueDiffMsg(arg_6_2, var_0_2, arg_6_0, var_0_3, arg_6_1)
	end
end

var_0_0.CompareStatus = {
	CompareFinish = 2,
	WaitCompare = 1
}

function var_0_0._innerTableDiff(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0 == arg_7_1 then
		return var_0_0.CompareStatus.CompareFinish
	end

	if not arg_7_0 or not arg_7_1 then
		var_0_0.getValueDiffMsg(arg_7_2, var_0_2, arg_7_0, var_0_3, arg_7_1)

		return var_0_0.CompareStatus.CompareFinish
	end

	local var_7_0 = type(arg_7_0)
	local var_7_1 = type(arg_7_1)

	if var_7_0 ~= var_7_1 then
		var_0_0.getTypeDiffMsg(arg_7_2, var_0_2, var_7_0, var_0_3, var_7_1)

		return var_0_0.CompareStatus.CompareFinish
	end

	return var_0_0.CompareStatus.WaitCompare
end

function var_0_0.defaultTableDiff(arg_8_0, arg_8_1, arg_8_2)
	if var_0_0._innerTableDiff(arg_8_0, arg_8_1, arg_8_2) == var_0_0.CompareStatus.CompareFinish then
		return
	end

	local var_8_0 = true

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if iter_8_1 ~= arg_8_0[iter_8_0] then
			var_8_0 = false

			var_0_0.getValueDiffMsg(arg_8_2 .. iter_8_0, var_0_2, iter_8_1, var_0_3, arg_8_0[arg_8_2])
		end
	end

	if not var_8_0 then
		var_0_0.addDiffMsg(GameUtil.logTab(arg_8_0))
		var_0_0.addDiffMsg(GameUtil.logTab(arg_8_1))
	end
end

function var_0_0.defaultTableDeepDiff(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_3 = arg_9_3 or 0

	if arg_9_3 > var_0_0.DeepMaxStack then
		logError("stackoverflow")

		return
	end

	if var_0_0._innerTableDiff(arg_9_0, arg_9_1, arg_9_2) == var_0_0.CompareStatus.CompareFinish then
		return
	end

	local var_9_0 = true

	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		local var_9_1 = arg_9_2 .. "." .. iter_9_0
		local var_9_2 = arg_9_1[iter_9_0]
		local var_9_3 = type(iter_9_1)
		local var_9_4 = type(var_9_2)

		if var_9_3 ~= var_9_4 then
			var_9_0 = false

			var_0_0.getTypeDiffMsg(var_9_1, var_0_2, var_9_3, var_0_3, var_9_4)
		elseif var_9_3 == "table" then
			var_0_0.defaultTableDeepDiff(iter_9_1, var_9_2, var_9_1, arg_9_3 + 1)
		elseif iter_9_1 ~= var_9_2 then
			var_9_0 = false

			var_0_0.getValueDiffMsg(var_9_1, var_0_2, iter_9_1, var_0_3, var_9_2)
		end
	end

	if not var_9_0 then
		var_0_0.addDiffMsg(GameUtil.logTab(arg_9_0))
		var_0_0.addDiffMsg(GameUtil.logTab(arg_9_1))
	end
end

function var_0_0.buffModelDiff(arg_10_0, arg_10_1, arg_10_2)
	if var_0_0._innerTableDiff(arg_10_0, arg_10_1, arg_10_2) == var_0_0.CompareStatus.CompareFinish then
		return
	end

	local var_10_0 = arg_10_0.getDict and arg_10_0:getDict()
	local var_10_1 = arg_10_1.getDict and arg_10_1:getDict()

	if var_0_0._innerTableDiff(var_10_0, var_10_1, arg_10_2 .. "._dict") == var_0_0.CompareStatus.CompareFinish then
		return
	end

	local var_10_2 = true

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_3 = arg_10_2 .. "._dict." .. iter_10_0
		local var_10_4 = var_10_1[iter_10_0]
		local var_10_5, var_10_6 = FightEntityMoCompareHelper.defaultTableDeepCompare(iter_10_1, var_10_4)

		if not var_10_5 then
			var_10_2 = false
			var_10_3 = var_10_6 and var_10_3 .. var_10_6 or var_10_3

			var_0_0.getValueDiffMsg(var_10_3, var_0_2, GameUtil.logTab(iter_10_1), var_0_3, GameUtil.logTab(var_10_4))
		end
	end

	if not var_10_2 then
		var_0_0.addDiffMsg(FightLogHelper.getFightBuffDictString(var_10_0))
		var_0_0.addDiffMsg(FightLogHelper.getFightBuffDictString(var_10_1))
	end
end

function var_0_0.summonedInfoDiff(arg_11_0, arg_11_1, arg_11_2)
	if var_0_0._innerTableDiff(arg_11_0, arg_11_1, arg_11_2) == var_0_0.CompareStatus.CompareFinish then
		return
	end

	local var_11_0 = arg_11_0.getDataDic and arg_11_0:getDataDic()
	local var_11_1 = arg_11_0.getDataDic and arg_11_1:getDataDic()

	if var_0_0._innerTableDiff(var_11_0, var_11_1, arg_11_2 .. ".dataDic") == var_0_0.CompareStatus.CompareFinish then
		return
	end

	local var_11_2 = true

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_3 = arg_11_2 .. ".dataDic." .. iter_11_0
		local var_11_4 = var_11_1[iter_11_0]

		if not FightEntityMoCompareHelper.defaultTableDeepCompare(iter_11_1, var_11_4) then
			var_0_0.getValueDiffMsg(var_11_3, var_0_2, GameUtil.logTab(iter_11_1), var_0_3, GameUtil.logTab(var_11_4))
		end
	end

	if not var_11_2 then
		var_0_0.addDiffMsg(GameUtil.logTab(var_11_0))
		var_0_0.addDiffMsg(GameUtil.logTab(var_11_1))
	end
end

return var_0_0
