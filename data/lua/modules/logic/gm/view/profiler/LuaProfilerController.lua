module("modules.logic.gm.view.profiler.LuaProfilerController", package.seeall)

slot0 = class("LuaProfilerController")
slot1 = {
	Ready = 0,
	Running = 1
}
slot2 = {
	"LuaProfilerController",
	"GM"
}

function slot0.ctor(slot0)
	slot0._funMemoryState = uv0.Ready
	slot0._luaMemoryState = uv0.Ready
end

slot3 = 0
slot4 = {}
slot5 = 0
slot6 = 0

function slot0.luaFunMemoryCalBegin(slot0)
	if slot0._funMemoryState ~= uv0.Ready then
		return
	end

	slot0._funMemoryState = uv0.Running
	uv1 = os.time()

	uv2.SC_StartRecordAlloc(false)
end

function slot0.luaFunMemoryCalEnd(slot0)
	if slot0._funMemoryState ~= uv0.Running then
		return
	end

	uv1.SC_StopRecordAllocAndDumpStat(uv1.getFileName("luaFunMemory"))

	slot0._funMemoryState = uv0.Ready
end

function slot0.luaMemoryCalBegin(slot0)
	if slot0._luaMemoryState ~= uv0.Ready then
		return
	end

	slot0._luaMemoryState = uv0.Running
	uv1 = os.time()

	TaskDispatcher.runRepeat(slot0._calLuaMemory, slot0, 1)
end

function slot0.luaMemoryCalEnd(slot0)
	if slot0._luaMemoryState ~= uv0.Running then
		return
	end

	TaskDispatcher.cancelTask(slot0._calLuaMemory, slot0)

	slot2 = "" .. "Lua内存统计时间：" .. os.time() - uv1 .. "s\n" .. "----------------------\n" .. "占用最大内存：" .. uv2 .. "\n"

	if #uv3 > 0 then
		for slot6, slot7 in ipairs(uv3) do
			slot7.memory = slot7.memory / 1024
		end

		slot3, slot4 = slot0:getMemoryPeakValue(uv3)

		if #slot3 > 0 and #slot4 > 0 and #slot3 >= #slot4 then
			for slot8 = 1, #slot3 do
				if slot4[slot8] then
					slot2 = slot2 .. "Lua GC消耗：\n" .. "GC 耗时：" .. slot4[slot8].time - slot3[slot8].time .. "s, 释放内存：" .. slot3[slot8].memory .. "-->" .. slot4[slot8].memory .. "MB\n"
				end
			end
		end

		for slot8, slot9 in ipairs(uv3) do
			slot2 = slot2 .. "Lua内存占用统计：\n" .. slot9.time .. " : " .. slot9.memory .. "MB\n"
		end
	end

	SLFramework.FileHelper.WriteTextToPath(uv4.getFileName("luaMemory"), slot2)

	uv3 = {}
	uv2 = 0
	slot0._luaMemoryState = uv0.Ready
end

function slot0.getFileName(slot0)
	slot2 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/luaMemoryTest/" .. slot0 .. os.time()
	slot2 = slot0 == "luaMemory" and slot2 .. ".log" or slot2 .. ".csv"

	print("filePath:" .. slot2)

	return slot2
end

function slot0._calLuaMemory(slot0)
	slot1 = collectgarbage("count")
	uv0[#uv0 + 1] = {
		time = os.time(),
		memory = slot1
	}

	if uv1 < slot1 then
		uv1 = slot1
	end
end

function slot7(slot0, slot1, slot2)
	slot4 = nil

	for slot8 = 1, #slot0 do
		if slot0[slot8][slot1] and slot2 < slot9[slot1] then
			slot3 = slot9[slot1]
			slot4 = slot9
		end

		if slot4 ~= nil and slot9[slot1] < slot3 then
			return slot8, slot4
		end
	end

	return #slot0, slot4
end

function slot8(slot0, slot1, slot2)
	slot4 = nil

	for slot8 = 1, #slot0 do
		if slot0[slot8][slot1] and slot9[slot1] < slot2 then
			slot3 = slot9[slot1]
			slot4 = slot9
		end

		if slot4 ~= nil and slot3 < slot9[slot1] then
			return slot8, slot4
		end
	end

	return #slot0, slot4
end

function slot9(slot0, slot1, slot2)
	slot3 = {}

	if slot1 <= 1 then
		slot1 = 1
	end

	for slot7 = slot1, slot2 do
		slot3[#slot3 + 1] = slot0[slot7]
	end

	return slot3
end

function slot0.getMemoryPeakValue(slot0, slot1)
	slot2 = true
	slot3 = {}
	slot4 = {}

	while 1 < #slot1 do
		if slot2 then
			slot7, slot8 = uv0(uv1(slot1, slot5, #slot1), "memory", #slot4 > 0 and slot4[#slot4].memory or 0)
			slot5 = slot7 + slot5 - 1
			slot2 = false

			if slot8 then
				slot3[#slot3 + 1] = slot8
			end
		else
			slot7, slot8 = uv2(uv1(slot1, slot5, #slot1), "memory", #slot3 > 0 and slot3[#slot3].memory or 0)
			slot5 = slot7 + slot5 - 1
			slot2 = true

			if slot8 then
				slot4[#slot4 + 1] = slot8
			end
		end
	end

	return slot3, slot4
end

slot10 = {}
slot11 = 0
slot12 = true

function slot13(slot0, slot1)
	if collectgarbage("count") - uv0 <= 1e-06 then
		uv0 = collectgarbage("count")

		return
	end

	for slot7 = 1, #uv1 do
		if string.find(debug.getinfo(2, "S").source, uv1[slot7]) then
			uv0 = collectgarbage("count")

			return
		end
	end

	if uv2 then
		slot3 = string.format("%s__%d", slot3, slot1 - 1)
	end

	if not uv3[slot3] then
		uv3[slot3] = {
			slot3,
			1,
			slot2
		}
	else
		slot4[2] = slot4[2] + 1
		slot4[3] = slot4[3] + slot2
	end

	uv0 = collectgarbage("count")
end

function slot0.SC_StartRecordAlloc(slot0)
	if debug.gethook() then
		uv0.SC_StopRecordAllocAndDumpStat()

		return
	end

	uv1 = {}
	uv2 = collectgarbage("count")
	uv3 = not slot0

	debug.sethook(uv4, "l")
end

function slot0.SC_StopRecordAllocAndDumpStat(slot0)
	debug.sethook()

	if not uv0 then
		return
	end

	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		table.insert(slot1, slot6)
	end

	table.sort(slot1, function (slot0, slot1)
		return slot1[3] < slot0[3]
	end)

	if not io.open(slot0 or "memAlloc.csv", "w") then
		logError("can't open file:", slot0)

		return
	end

	slot8 = os.time() - uv1

	slot2:write("collectTotalTime:" .. slot8 .. " s \n")

	slot7 = "fileLine, count, mem K, avg K\n"

	slot2:write(slot7)

	for slot7, slot8 in ipairs(slot1) do
		slot2:write(string.format("%s, %d, %f, %f\n", slot8[1], slot8[2], slot8[3], slot8[3] / slot8[2]))
	end

	slot2:close()

	uv0 = nil
end

slot14 = {}
slot15 = false
slot16 = 0

function slot0.collectEventIsOpen(slot0)
	return uv0
end

function slot0.collectEventParams(slot0, slot1, slot2, slot3)
	if not uv0 then
		return
	end

	if not uv1 then
		uv1 = {}
	end

	slot4 = {}

	if slot2 then
		for slot8 = 1, #slot2 do
			table.insert(slot4, type(slot2[slot8]))
		end
	end

	if not uv1[slot1 .. (slot2 and #slot2 or 0)] then
		uv1[slot6] = {
			dispatchCount = 0,
			cbObjName = slot3,
			eventName = slot1,
			paramsCount = slot5,
			paramTypes = slot4
		}
	end

	uv1[slot6].dispatchCount = uv1[slot6].dispatchCount + 1
end

function slot0.collectEventParamsState(slot0)
	uv0 = not uv0

	if not uv0 then
		slot0:dumpEventInfos()

		uv1 = {}
	else
		uv2 = os.time()
	end
end

function slot0.dumpEventInfos(slot0)
	if not io.open(slot0.getFileName("eventInfos"), "w") then
		logError("can't open file:", slot1)

		return
	end

	table.sort(uv0, function (slot0, slot1)
		return slot1.dispatchCount < slot0.dispatchCount
	end)

	slot7 = os.time() - uv1

	slot2:write("collectTotalTime:" .. slot7 .. " s \n")

	slot6 = "cbObjName, eventName, paramsCount, paramTypes, dispatchCount\n"

	slot2:write(slot6)

	for slot6, slot7 in pairs(uv0) do
		slot2:write(string.format("%s, %s, %d, %s, %d\n", slot7.cbObjName, slot7.eventName, slot7.paramsCount, table.concat(slot7.paramTypes, "|"), slot7.dispatchCount))
	end

	slot2:close()
end

slot0.instance = slot0.New()

return slot0
