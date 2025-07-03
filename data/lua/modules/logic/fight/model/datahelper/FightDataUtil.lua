module("modules.logic.fight.model.datahelper.FightDataUtil", package.seeall)

local var_0_0 = {}

function var_0_0.copyData(arg_1_0)
	if type(arg_1_0) ~= "table" then
		return arg_1_0
	else
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			var_1_0[iter_1_0] = var_0_0.copyData(iter_1_1)
		end

		local var_1_1 = getmetatable(arg_1_0)

		if var_1_1 then
			setmetatable(var_1_0, var_1_1)
		end

		return var_1_0
	end
end

local var_0_1 = {
	class = true
}

function var_0_0.coverData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0 == nil then
		return nil
	end

	if arg_2_1 == nil then
		arg_2_1 = {}

		local var_2_0 = getmetatable(arg_2_0)

		if var_2_0 then
			setmetatable(arg_2_1, var_2_0)
		end
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		local var_2_1 = false

		if arg_2_2 and arg_2_2[iter_2_0] then
			var_2_1 = true
		end

		if var_0_1[iter_2_0] then
			var_2_1 = true
		end

		if not var_2_1 and arg_2_0[iter_2_0] == nil then
			arg_2_1[iter_2_0] = nil
		end
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_0) do
		local var_2_2 = false

		if arg_2_2 and arg_2_2[iter_2_2] then
			var_2_2 = true
		end

		if var_0_1[iter_2_2] then
			var_2_2 = true
		end

		if not var_2_2 then
			if arg_2_3 and arg_2_3[iter_2_2] then
				arg_2_3[iter_2_2](arg_2_0, arg_2_1)
			elseif arg_2_1[iter_2_2] == nil then
				arg_2_1[iter_2_2] = FightHelper.deepCopySimpleWithMeta(arg_2_0[iter_2_2])
			elseif type(iter_2_3) == "table" then
				var_0_0.coverInternal(iter_2_3, arg_2_1[iter_2_2])
			else
				arg_2_1[iter_2_2] = iter_2_3
			end
		end
	end

	return arg_2_1
end

function var_0_0.coverInternal(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if arg_3_0[iter_3_0] == nil then
			arg_3_1[iter_3_0] = nil
		end
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0) do
		if type(iter_3_3) == "table" then
			if arg_3_1[iter_3_2] == nil then
				arg_3_1[iter_3_2] = FightHelper.deepCopySimpleWithMeta(iter_3_3)
			else
				var_0_0.coverInternal(iter_3_3, arg_3_1[iter_3_2])
			end
		else
			arg_3_1[iter_3_2] = iter_3_3
		end
	end
end

var_0_0.findDiffList = {}
var_0_0.findDiffPath = {}

function var_0_0.addPathkey(arg_4_0)
	table.insert(var_0_0.findDiffPath, arg_4_0)
end

function var_0_0.removePathKey()
	table.remove(var_0_0.findDiffPath)
end

function var_0_0.findDiff(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_0.findDiffList = {}
	var_0_0.findDiffPath = {}

	var_0_0.doFindDiff(arg_6_0, arg_6_1, arg_6_2, arg_6_3)

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(var_0_0.findDiffList) do
		local var_6_1 = iter_6_1.pathList[1]

		var_6_0[var_6_1] = var_6_0[var_6_1] or {}

		table.insert(var_6_0[var_6_1], iter_6_1)
	end

	return #var_0_0.findDiffList > 0, var_6_0, var_0_0.findDiffList
end

function var_0_0.doFindDiff(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if type(arg_7_0) ~= "table" or type(arg_7_1) ~= "table" then
		logError("传入的参数必须是表结构,请检查代码")

		return
	end

	var_0_0.doCheckMissing(arg_7_0, arg_7_1, arg_7_2)

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		local var_7_0 = false

		if arg_7_2 and arg_7_2[iter_7_0] then
			var_7_0 = true
		end

		if not var_7_0 and arg_7_1[iter_7_0] ~= nil then
			var_0_0.addPathkey(iter_7_0)

			if arg_7_3 and arg_7_3[iter_7_0] then
				arg_7_3[iter_7_0](arg_7_0[iter_7_0], arg_7_1[iter_7_0], arg_7_0, arg_7_1)
			elseif arg_7_4 then
				arg_7_4(arg_7_0[iter_7_0], arg_7_1[iter_7_0])
			else
				var_0_0.checkDifference(arg_7_0[iter_7_0], arg_7_1[iter_7_0])
			end

			var_0_0.removePathKey()
		end
	end
end

function var_0_0.checkDifference(arg_8_0, arg_8_1)
	if type(arg_8_0) ~= type(arg_8_1) then
		var_0_0.addDiff(nil, var_0_0.diffType.difference)

		return
	elseif type(arg_8_0) == "table" then
		var_0_0.doCheckMissing(arg_8_0, arg_8_1)

		for iter_8_0, iter_8_1 in pairs(arg_8_0) do
			if arg_8_1[iter_8_0] ~= nil then
				var_0_0.addPathkey(iter_8_0)
				var_0_0.checkDifference(iter_8_1, arg_8_1[iter_8_0])
				var_0_0.removePathKey()
			end
		end
	elseif arg_8_0 ~= arg_8_1 then
		var_0_0.addDiff(nil, var_0_0.diffType.difference)
	end
end

function var_0_0.doCheckMissing(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_0 = false

		if arg_9_2 and arg_9_2[iter_9_0] then
			var_9_0 = true
		end

		if not var_9_0 and arg_9_0[iter_9_0] == nil then
			var_0_0.addDiff(iter_9_0, var_0_0.diffType.missingSource)
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0) do
		local var_9_1 = false

		if arg_9_2 and arg_9_2[iter_9_2] then
			var_9_1 = true
		end

		if not var_9_1 and arg_9_1[iter_9_2] == nil then
			var_0_0.addDiff(iter_9_2, var_0_0.diffType.missingTarget)
		end
	end
end

var_0_0.diffType = {
	missingTarget = 2,
	difference = 3,
	missingSource = 1
}

function var_0_0.addDiff(arg_10_0, arg_10_1)
	local var_10_0 = {
		diffType = arg_10_1 or var_0_0.diffType.difference
	}
	local var_10_1 = var_0_0.coverData(var_0_0.findDiffPath)

	if arg_10_0 then
		table.insert(var_10_1, arg_10_0)
	end

	var_10_0.pathList = var_10_1
	var_10_0.pathStr = table.concat(var_10_1, ".")

	table.insert(var_0_0.findDiffList, var_10_0)

	return var_10_0
end

function var_0_0.getDiffValue(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0
	local var_11_1
	local var_11_2 = arg_11_2.pathList
	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		var_11_0 = var_11_3[iter_11_1]
		var_11_1 = var_11_4[iter_11_1]
		var_11_3 = var_11_0
		var_11_4 = var_11_1
	end

	var_11_0 = var_11_0 == nil and "nil" or var_11_0
	var_11_1 = var_11_1 == nil and "nil" or var_11_1

	return var_11_0, var_11_1
end

return var_0_0
