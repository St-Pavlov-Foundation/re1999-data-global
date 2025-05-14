module("modules.logic.gm.view.rouge.RougeProfileController", package.seeall)

local var_0_0 = class("RougeProfileController")

function var_0_0.startRecordMemory(arg_1_0)
	if arg_1_0.startRecord then
		GameFacade.showToastString("recording ")

		return
	end

	arg_1_0.startRecord = true
	arg_1_0.memoryTimeList = {}
	arg_1_0.maxMemory = collectgarbage("count")
	arg_1_0.maxMemoryScene = GameSceneMgr.instance:getCurSceneType()
	arg_1_0.maxOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	arg_1_0.minMemory = arg_1_0.maxMemory
	arg_1_0.minMemoryScene = GameSceneMgr.instance:getCurSceneType()
	arg_1_0.minOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")

	TaskDispatcher.runRepeat(arg_1_0._calLuaMemory, arg_1_0, 1)
end

function var_0_0._calLuaMemory(arg_2_0)
	local var_2_0 = collectgarbage("count")

	arg_2_0.memoryTimeList[#arg_2_0.memoryTimeList + 1] = {
		time = os.time(),
		memory = var_2_0,
		scene = GameSceneMgr.instance:getCurSceneType()
	}

	if var_2_0 > arg_2_0.maxMemory then
		arg_2_0.maxMemory = var_2_0
		arg_2_0.maxMemoryScene = GameSceneMgr.instance:getCurSceneType()
		arg_2_0.maxOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	end

	if var_2_0 < arg_2_0.minMemory then
		arg_2_0.minMemory = var_2_0
		arg_2_0.minMemoryScene = GameSceneMgr.instance:getCurSceneType()
		arg_2_0.minOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	end
end

function var_0_0.endRecord(arg_3_0)
	if not arg_3_0.startRecord then
		return
	end

	arg_3_0.startRecord = nil

	TaskDispatcher.cancelTask(arg_3_0._calLuaMemory, arg_3_0)

	local var_3_0 = ("" .. string.format("占用最大内存 ：%s, 场景 ： %s, openView : %s\n", arg_3_0.maxMemory / 1024, arg_3_0.maxMemoryScene, arg_3_0.maxOpenNameList)) .. string.format("占用最小内存 ：%s, 场景 ： %s, openView : %s\n\n\n", arg_3_0.minMemory / 1024, arg_3_0.minMemoryScene, arg_3_0.minOpenNameList)
	local var_3_1 = {}
	local var_3_2 = 0
	local var_3_3 = true

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.memoryTimeList) do
		local var_3_4 = iter_3_1.time
		local var_3_5 = iter_3_1.memory / 1024

		if var_3_3 then
			if var_3_5 < var_3_2 then
				table.insert(var_3_1, arg_3_0:getLineLog(var_3_2, var_3_5, var_3_4, iter_3_1.scene))

				var_3_3 = false
			end
		elseif var_3_2 < var_3_5 then
			table.insert(var_3_1, arg_3_0:getLineLog(var_3_2, var_3_5, var_3_4, iter_3_1.scene))

			var_3_3 = true
		end

		var_3_2 = var_3_5
	end

	table.insert(var_3_1, arg_3_0:getLineLog(var_3_2, var_3_2, arg_3_0.memoryTimeList[#arg_3_0.memoryTimeList].time, arg_3_0.memoryTimeList[#arg_3_0.memoryTimeList].scene))

	local var_3_6 = (var_3_0 .. table.concat(var_3_1, "\n")) .. "\n\n详细内存统计 : \n"

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.memoryTimeList) do
		var_3_6 = var_3_6 .. iter_3_3.time .. " : " .. iter_3_3.memory / 1024 .. "MB\n"
	end

	local var_3_7 = os.time()
	local var_3_8 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/luaMemoryTest/"
	local var_3_9 = var_3_8 .. var_3_7 .. ".log"

	SLFramework.FileHelper.WriteTextToPath(var_3_9, var_3_6)
	ZProj.OpenSelectFileWindow.OpenExplorer(var_3_8)

	arg_3_0.memoryTimeList = nil
	arg_3_0.maxMemory = nil
	arg_3_0.maxMemoryScene = nil
	arg_3_0.maxOpenNameList = nil
	arg_3_0.minMemory = nil
	arg_3_0.minMemoryScene = nil
	arg_3_0.minOpenNameList = nil
end

function var_0_0.getLineLog(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	return string.format("preMemory : %s ---- curMemory : %s, time : %s, scene : %s", arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

var_0_0.instance = var_0_0.New()

return var_0_0
