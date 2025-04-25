module("modules.logic.gm.view.profiler.GMSubViewProfiler", package.seeall)

slot0 = class("GMSubViewProfiler", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "Profiler"
end

function slot0.addLineIndex(slot0)
	slot0.lineIndex = slot0.lineIndex + 1
end

function slot0.getLineGroup(slot0)
	return "L" .. slot0.lineIndex
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)

	slot0.lineIndex = 1

	slot0:addTitleSplitLine("Lua内存占用")
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "Lua开始统计", slot0.luaMemoryCalBegin, slot0)
	slot0:addButton(slot0:getLineGroup(), "Lua结束统计", slot0.luaMemoryCalEnd, slot0)
	slot0:addTitleSplitLine("Lua函数内存消耗统计")
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "函数内存开始统计", slot0.luaFunMemoryCalBegin, slot0)
	slot0:addButton(slot0:getLineGroup(), "函数内存结束统计", slot0.luaFunMemoryCalEnd, slot0)
	slot0:addTitleSplitLine("LuaEvent调用分析")
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "Event开始统计", slot0.eventCalBegin, slot0)
	slot0:addButton(slot0:getLineGroup(), "Event结束统计", slot0.eventCalEnd, slot0)
	slot0:addTitleSplitLine("PROFILER")
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "性能文件输出", slot0.profilerCalOut, slot0)
	slot0:addButton(slot0:getLineGroup(), "清空记录", slot0.clearRecord, slot0)
	slot0:addTitleSplitLine("性能数据")
	slot0:addLineIndex()

	slot0._recordText = slot0:addButton(slot0:getLineGroup(), "开启连接", slot0.initProfilerConnection, slot0)[2]
end

function slot0.luaFunMemoryCalBegin(slot0)
	LuaProfilerController.instance:luaFunMemoryCalBegin()
end

function slot0.luaFunMemoryCalEnd(slot0)
	LuaProfilerController.instance:luaFunMemoryCalEnd()
end

function slot0.luaMemoryCalBegin(slot0)
	LuaProfilerController.instance:luaMemoryCalBegin()
end

function slot0.luaMemoryCalEnd(slot0)
	LuaProfilerController.instance:luaMemoryCalEnd()
end

function slot0.eventCalBegin(slot0)
	LuaProfilerController.instance:collectEventParamsState()
end

function slot0.eventCalEnd(slot0)
	LuaProfilerController.instance:collectEventParamsState()
end

function slot0.profilerCalOut(slot0)
	ZProj.ProfilerMan.Instance:outCsv()
end

function slot0.clearRecord(slot0)
	ZProj.ProfilerMan.Instance:BeginRecord()
end

function slot0._onLangDropChange(slot0, slot1)
	ZProj.ProfilerMan.Instance.IsProfiler = slot1 == 1 and true or false
end

function slot0.initProfilerConnection(slot0)
	PerformanceRecorder.initProfilerConnection()

	slot0._recordText.text = "已开启"
end

return slot0
