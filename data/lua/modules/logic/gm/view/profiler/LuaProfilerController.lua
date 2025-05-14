module("modules.logic.gm.view.profiler.LuaProfilerController", package.seeall)

local var_0_0 = class("LuaProfilerController")
local var_0_1 = {
	Ready = 0,
	Running = 1
}
local var_0_2 = {
	"LuaProfilerController",
	"GM"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._funMemoryState = var_0_1.Ready
	arg_1_0._luaMemoryState = var_0_1.Ready
end

local var_0_3 = 0
local var_0_4 = {}
local var_0_5 = 0
local var_0_6 = 0

function var_0_0.luaFunMemoryCalBegin(arg_2_0)
	if arg_2_0._funMemoryState ~= var_0_1.Ready then
		return
	end

	arg_2_0._funMemoryState = var_0_1.Running
	var_0_5 = os.time()

	var_0_0.SC_StartRecordAlloc(false)
end

function var_0_0.luaFunMemoryCalEnd(arg_3_0)
	if arg_3_0._funMemoryState ~= var_0_1.Running then
		return
	end

	local var_3_0 = var_0_0.getFileName("luaFunMemory")

	var_0_0.SC_StopRecordAllocAndDumpStat(var_3_0)

	arg_3_0._funMemoryState = var_0_1.Ready
end

function var_0_0.luaMemoryCalBegin(arg_4_0)
	if arg_4_0._luaMemoryState ~= var_0_1.Ready then
		return
	end

	arg_4_0._luaMemoryState = var_0_1.Running
	var_0_6 = os.time()

	TaskDispatcher.runRepeat(arg_4_0._calLuaMemory, arg_4_0, 1)
end

function var_0_0.luaMemoryCalEnd(arg_5_0)
	if arg_5_0._luaMemoryState ~= var_0_1.Running then
		return
	end

	TaskDispatcher.cancelTask(arg_5_0._calLuaMemory, arg_5_0)

	local var_5_0 = os.time() - var_0_6
	local var_5_1 = (("" .. "Lua内存统计时间：" .. var_5_0 .. "s\n") .. "----------------------\n") .. "占用最大内存：" .. var_0_3 .. "\n"

	if #var_0_4 > 0 then
		for iter_5_0, iter_5_1 in ipairs(var_0_4) do
			iter_5_1.memory = iter_5_1.memory / 1024
		end

		local var_5_2, var_5_3 = arg_5_0:getMemoryPeakValue(var_0_4)

		if #var_5_2 > 0 and #var_5_3 > 0 and #var_5_2 >= #var_5_3 then
			var_5_1 = var_5_1 .. "Lua GC消耗：\n"

			for iter_5_2 = 1, #var_5_2 do
				if var_5_3[iter_5_2] then
					var_5_1 = var_5_1 .. "GC 耗时：" .. var_5_3[iter_5_2].time - var_5_2[iter_5_2].time .. "s, 释放内存：" .. var_5_2[iter_5_2].memory .. "-->" .. var_5_3[iter_5_2].memory .. "MB\n"
				end
			end
		end

		var_5_1 = var_5_1 .. "Lua内存占用统计：\n"

		for iter_5_3, iter_5_4 in ipairs(var_0_4) do
			var_5_1 = var_5_1 .. iter_5_4.time .. " : " .. iter_5_4.memory .. "MB\n"
		end
	end

	SLFramework.FileHelper.WriteTextToPath(var_0_0.getFileName("luaMemory"), var_5_1)

	var_0_4 = {}
	var_0_3 = 0
	arg_5_0._luaMemoryState = var_0_1.Ready
end

function var_0_0.getFileName(arg_6_0)
	local var_6_0 = os.time()
	local var_6_1 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/luaMemoryTest/" .. arg_6_0 .. var_6_0

	if arg_6_0 == "luaMemory" then
		var_6_1 = var_6_1 .. ".log"
	else
		var_6_1 = var_6_1 .. ".csv"
	end

	print("filePath:" .. var_6_1)

	return var_6_1
end

function var_0_0._calLuaMemory(arg_7_0)
	local var_7_0 = collectgarbage("count")

	var_0_4[#var_0_4 + 1] = {
		time = os.time(),
		memory = var_7_0
	}

	if var_7_0 > var_0_3 then
		var_0_3 = var_7_0
	end
end

local function var_0_7(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2
	local var_8_1

	for iter_8_0 = 1, #arg_8_0 do
		local var_8_2 = arg_8_0[iter_8_0]

		if var_8_2[arg_8_1] and var_8_0 < var_8_2[arg_8_1] then
			var_8_0 = var_8_2[arg_8_1]
			var_8_1 = var_8_2
		end

		if var_8_1 ~= nil and var_8_0 > var_8_2[arg_8_1] then
			return iter_8_0, var_8_1
		end
	end

	return #arg_8_0, var_8_1
end

local function var_0_8(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2
	local var_9_1

	for iter_9_0 = 1, #arg_9_0 do
		local var_9_2 = arg_9_0[iter_9_0]

		if var_9_2[arg_9_1] and var_9_0 > var_9_2[arg_9_1] then
			var_9_0 = var_9_2[arg_9_1]
			var_9_1 = var_9_2
		end

		if var_9_1 ~= nil and var_9_0 < var_9_2[arg_9_1] then
			return iter_9_0, var_9_1
		end
	end

	return #arg_9_0, var_9_1
end

local function var_0_9(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	arg_10_1 = arg_10_1 <= 1 and 1 or arg_10_1

	for iter_10_0 = arg_10_1, arg_10_2 do
		var_10_0[#var_10_0 + 1] = arg_10_0[iter_10_0]
	end

	return var_10_0
end

function var_0_0.getMemoryPeakValue(arg_11_0, arg_11_1)
	local var_11_0 = true
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = 1

	while var_11_3 < #arg_11_1 do
		if var_11_0 then
			local var_11_4 = #var_11_2 > 0 and var_11_2[#var_11_2].memory or 0
			local var_11_5, var_11_6 = var_0_7(var_0_9(arg_11_1, var_11_3, #arg_11_1), "memory", var_11_4)

			var_11_3 = var_11_5 + var_11_3 - 1
			var_11_0 = false

			if var_11_6 then
				var_11_1[#var_11_1 + 1] = var_11_6
			end
		else
			local var_11_7 = #var_11_1 > 0 and var_11_1[#var_11_1].memory or 0
			local var_11_8, var_11_9 = var_0_8(var_0_9(arg_11_1, var_11_3, #arg_11_1), "memory", var_11_7)

			var_11_3 = var_11_8 + var_11_3 - 1
			var_11_0 = true

			if var_11_9 then
				var_11_2[#var_11_2 + 1] = var_11_9
			end
		end
	end

	return var_11_1, var_11_2
end

local var_0_10 = {}
local var_0_11 = 0
local var_0_12 = true

local function var_0_13(arg_12_0, arg_12_1)
	local var_12_0 = collectgarbage("count") - var_0_11

	if var_12_0 <= 1e-06 then
		var_0_11 = collectgarbage("count")

		return
	end

	local var_12_1 = debug.getinfo(2, "S").source

	for iter_12_0 = 1, #var_0_2 do
		if string.find(var_12_1, var_0_2[iter_12_0]) then
			var_0_11 = collectgarbage("count")

			return
		end
	end

	if var_0_12 then
		var_12_1 = string.format("%s__%d", var_12_1, arg_12_1 - 1)
	end

	local var_12_2 = var_0_10[var_12_1]

	if not var_12_2 then
		var_0_10[var_12_1] = {
			var_12_1,
			1,
			var_12_0
		}
	else
		var_12_2[2] = var_12_2[2] + 1
		var_12_2[3] = var_12_2[3] + var_12_0
	end

	var_0_11 = collectgarbage("count")
end

function var_0_0.SC_StartRecordAlloc(arg_13_0)
	if debug.gethook() then
		var_0_0.SC_StopRecordAllocAndDumpStat()

		return
	end

	var_0_10 = {}
	var_0_11 = collectgarbage("count")
	var_0_12 = not arg_13_0

	debug.sethook(var_0_13, "l")
end

function var_0_0.SC_StopRecordAllocAndDumpStat(arg_14_0)
	debug.sethook()

	if not var_0_10 then
		return
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(var_0_10) do
		table.insert(var_14_0, iter_14_1)
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0[3] > arg_15_1[3]
	end)

	arg_14_0 = arg_14_0 or "memAlloc.csv"

	local var_14_1 = io.open(arg_14_0, "w")

	if not var_14_1 then
		logError("can't open file:", arg_14_0)

		return
	end

	local var_14_2 = os.time() - var_0_5

	var_14_1:write("collectTotalTime:" .. var_14_2 .. " s \n")
	var_14_1:write("fileLine, count, mem K, avg K\n")

	for iter_14_2, iter_14_3 in ipairs(var_14_0) do
		var_14_1:write(string.format("%s, %d, %f, %f\n", iter_14_3[1], iter_14_3[2], iter_14_3[3], iter_14_3[3] / iter_14_3[2]))
	end

	var_14_1:close()

	var_0_10 = nil
end

local var_0_14 = {}
local var_0_15 = false
local var_0_16 = 0

function var_0_0.collectEventIsOpen(arg_16_0)
	return var_0_15
end

function var_0_0.collectEventParams(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not var_0_15 then
		return
	end

	if not var_0_14 then
		var_0_14 = {}
	end

	local var_17_0 = {}

	if arg_17_2 then
		for iter_17_0 = 1, #arg_17_2 do
			table.insert(var_17_0, type(arg_17_2[iter_17_0]))
		end
	end

	local var_17_1 = arg_17_2 and #arg_17_2 or 0
	local var_17_2 = arg_17_1 .. var_17_1

	if not var_0_14[var_17_2] then
		var_0_14[var_17_2] = {
			dispatchCount = 0,
			cbObjName = arg_17_3,
			eventName = arg_17_1,
			paramsCount = var_17_1,
			paramTypes = var_17_0
		}
	end

	var_0_14[var_17_2].dispatchCount = var_0_14[var_17_2].dispatchCount + 1
end

function var_0_0.collectEventParamsState(arg_18_0)
	var_0_15 = not var_0_15

	if not var_0_15 then
		arg_18_0:dumpEventInfos()

		var_0_14 = {}
	else
		var_0_16 = os.time()
	end
end

function var_0_0.dumpEventInfos(arg_19_0)
	local var_19_0 = arg_19_0.getFileName("eventInfos")
	local var_19_1 = io.open(var_19_0, "w")

	if not var_19_1 then
		logError("can't open file:", var_19_0)

		return
	end

	table.sort(var_0_14, function(arg_20_0, arg_20_1)
		return arg_20_0.dispatchCount > arg_20_1.dispatchCount
	end)
	var_19_1:write("collectTotalTime:" .. os.time() - var_0_16 .. " s \n")
	var_19_1:write("cbObjName, eventName, paramsCount, paramTypes, dispatchCount\n")

	for iter_19_0, iter_19_1 in pairs(var_0_14) do
		var_19_1:write(string.format("%s, %s, %d, %s, %d\n", iter_19_1.cbObjName, iter_19_1.eventName, iter_19_1.paramsCount, table.concat(iter_19_1.paramTypes, "|"), iter_19_1.dispatchCount))
	end

	var_19_1:close()
end

var_0_0.instance = var_0_0.New()

return var_0_0
