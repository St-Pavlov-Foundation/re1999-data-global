module("modules.logic.gm.view.rouge.RougeProfileController", package.seeall)

slot0 = class("RougeProfileController")

function slot0.startRecordMemory(slot0)
	if slot0.startRecord then
		GameFacade.showToastString("recording ")

		return
	end

	slot0.startRecord = true
	slot0.memoryTimeList = {}
	slot0.maxMemory = collectgarbage("count")
	slot0.maxMemoryScene = GameSceneMgr.instance:getCurSceneType()
	slot0.maxOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	slot0.minMemory = slot0.maxMemory
	slot0.minMemoryScene = GameSceneMgr.instance:getCurSceneType()
	slot0.minOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")

	TaskDispatcher.runRepeat(slot0._calLuaMemory, slot0, 1)
end

function slot0._calLuaMemory(slot0)
	slot1 = collectgarbage("count")
	slot0.memoryTimeList[#slot0.memoryTimeList + 1] = {
		time = os.time(),
		memory = slot1,
		scene = GameSceneMgr.instance:getCurSceneType()
	}

	if slot0.maxMemory < slot1 then
		slot0.maxMemory = slot1
		slot0.maxMemoryScene = GameSceneMgr.instance:getCurSceneType()
		slot0.maxOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	end

	if slot1 < slot0.minMemory then
		slot0.minMemory = slot1
		slot0.minMemoryScene = GameSceneMgr.instance:getCurSceneType()
		slot0.minOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	end
end

function slot0.endRecord(slot0)
	if not slot0.startRecord then
		return
	end

	slot0.startRecord = nil

	TaskDispatcher.cancelTask(slot0._calLuaMemory, slot0)

	slot1 = "" .. string.format("占用最大内存 ：%s, 场景 ： %s, openView : %s\n", slot0.maxMemory / 1024, slot0.maxMemoryScene, slot0.maxOpenNameList) .. string.format([[
占用最小内存 ：%s, 场景 ： %s, openView : %s


]], slot0.minMemory / 1024, slot0.minMemoryScene, slot0.minOpenNameList)
	slot2 = {}
	slot3 = 0

	for slot8, slot9 in ipairs(slot0.memoryTimeList) do
		slot11 = slot9.memory / 1024

		if true then
			if slot11 < slot3 then
				table.insert(slot2, slot0:getLineLog(slot3, slot11, slot9.time, slot9.scene))

				slot4 = false
			end
		elseif slot3 < slot11 then
			table.insert(slot2, slot0:getLineLog(slot3, slot11, slot10, slot9.scene))

			slot4 = true
		end

		slot3 = slot11
	end

	slot9 = slot3

	table.insert(slot2, slot0:getLineLog(slot9, slot3, slot0.memoryTimeList[#slot0.memoryTimeList].time, slot0.memoryTimeList[#slot0.memoryTimeList].scene))

	slot8 = "\n"

	for slot8, slot9 in ipairs(slot0.memoryTimeList) do
		slot1 = slot1 .. table.concat(slot2, slot8) .. [[


详细内存统计 : 
]] .. slot9.time .. " : " .. slot9.memory / 1024 .. "MB\n"
	end

	slot6 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/luaMemoryTest/"

	SLFramework.FileHelper.WriteTextToPath(slot6 .. os.time() .. ".log", slot1)
	ZProj.OpenSelectFileWindow.OpenExplorer(slot6)

	slot0.memoryTimeList = nil
	slot0.maxMemory = nil
	slot0.maxMemoryScene = nil
	slot0.maxOpenNameList = nil
	slot0.minMemory = nil
	slot0.minMemoryScene = nil
	slot0.minOpenNameList = nil
end

function slot0.getLineLog(slot0, slot1, slot2, slot3, slot4)
	return string.format("preMemory : %s ---- curMemory : %s, time : %s, scene : %s", slot1, slot2, slot3, slot4)
end

slot0.instance = slot0.New()

return slot0
