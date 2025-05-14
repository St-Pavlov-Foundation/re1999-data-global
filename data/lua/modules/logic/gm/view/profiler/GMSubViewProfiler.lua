module("modules.logic.gm.view.profiler.GMSubViewProfiler", package.seeall)

local var_0_0 = class("GMSubViewProfiler", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "Profiler"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)

	arg_4_0.lineIndex = 1

	arg_4_0:addTitleSplitLine("Lua内存占用")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "Lua开始统计", arg_4_0.luaMemoryCalBegin, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "Lua结束统计", arg_4_0.luaMemoryCalEnd, arg_4_0)
	arg_4_0:addTitleSplitLine("Lua函数内存消耗统计")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "函数内存开始统计", arg_4_0.luaFunMemoryCalBegin, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "函数内存结束统计", arg_4_0.luaFunMemoryCalEnd, arg_4_0)
	arg_4_0:addTitleSplitLine("LuaEvent调用分析")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "Event开始统计", arg_4_0.eventCalBegin, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "Event结束统计", arg_4_0.eventCalEnd, arg_4_0)
	arg_4_0:addTitleSplitLine("PROFILER")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "性能文件输出", arg_4_0.profilerCalOut, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "清空记录", arg_4_0.clearRecord, arg_4_0)
	arg_4_0:addTitleSplitLine("性能数据")
	arg_4_0:addLineIndex()

	arg_4_0._recordText = arg_4_0:addButton(arg_4_0:getLineGroup(), "开启连接", arg_4_0.initProfilerConnection, arg_4_0)[2]
end

function var_0_0.luaFunMemoryCalBegin(arg_5_0)
	LuaProfilerController.instance:luaFunMemoryCalBegin()
end

function var_0_0.luaFunMemoryCalEnd(arg_6_0)
	LuaProfilerController.instance:luaFunMemoryCalEnd()
end

function var_0_0.luaMemoryCalBegin(arg_7_0)
	LuaProfilerController.instance:luaMemoryCalBegin()
end

function var_0_0.luaMemoryCalEnd(arg_8_0)
	LuaProfilerController.instance:luaMemoryCalEnd()
end

function var_0_0.eventCalBegin(arg_9_0)
	LuaProfilerController.instance:collectEventParamsState()
end

function var_0_0.eventCalEnd(arg_10_0)
	LuaProfilerController.instance:collectEventParamsState()
end

function var_0_0.profilerCalOut(arg_11_0)
	ZProj.ProfilerMan.Instance:outCsv()
end

function var_0_0.clearRecord(arg_12_0)
	ZProj.ProfilerMan.Instance:BeginRecord()
end

function var_0_0._onLangDropChange(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 == 1 and true or false

	ZProj.ProfilerMan.Instance.IsProfiler = var_13_0
end

function var_0_0.initProfilerConnection(arg_14_0)
	PerformanceRecorder.initProfilerConnection()

	arg_14_0._recordText.text = "已开启"
end

return var_0_0
