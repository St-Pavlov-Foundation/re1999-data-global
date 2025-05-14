module("modules.logic.weather.controller.WeatherEggContainerComp", package.seeall)

local var_0_0 = class("WeatherEggContainerComp")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onSceneHide(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._switchEgg, arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._serialEggList) do
		iter_2_1:onDisable()
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_0._parallelEggList) do
		iter_2_3:onDisable()
	end
end

function var_0_0.onSceneShow(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._parallelEggList) do
		iter_3_1:onEnable()
	end

	arg_3_0:_startTimer()
end

function var_0_0.onReportChange(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._serialEggList) do
		iter_4_1:onReportChange(arg_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._parallelEggList) do
		iter_4_3:onReportChange(arg_4_1)
	end
end

function var_0_0.onInit(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._context = {
		isMainScene = arg_5_2
	}
	arg_5_0._sceneId = arg_5_1

	local var_5_0 = lua_scene_switch.configDict[arg_5_1]

	arg_5_0._eggList = var_5_0.eggList
	arg_5_0._eggSwitchTime = var_5_0.eggSwitchTime
	arg_5_0._serialEggList = {}
	arg_5_0._parallelEggList = {}
	arg_5_0._index = 0
end

function var_0_0._startTimer(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._switchEgg, arg_6_0)

	if #arg_6_0._serialEggList > 0 then
		arg_6_0._time = arg_6_0._time or Time.time

		TaskDispatcher.runRepeat(arg_6_0._switchEgg, arg_6_0, 0)
	end
end

function var_0_0._switchEgg(arg_7_0)
	if not arg_7_0._time or Time.time - arg_7_0._time <= arg_7_0._eggSwitchTime then
		return
	end

	arg_7_0._time = Time.time

	local var_7_0 = arg_7_0._serialEggList[arg_7_0._index]

	if var_7_0 then
		var_7_0:onDisable()
	end

	local var_7_1 = arg_7_0:getNextIndex()
	local var_7_2 = arg_7_0._serialEggList[var_7_1]

	if var_7_2 then
		var_7_2:onEnable()
	end
end

function var_0_0.getNextIndex(arg_8_0)
	arg_8_0._index = arg_8_0._index + 1

	if arg_8_0._index > #arg_8_0._serialEggList then
		arg_8_0._index = 1
	end

	return arg_8_0._index
end

function var_0_0.getSceneNode(arg_9_0, arg_9_1)
	return gohelper.findChild(arg_9_0._sceneGo, arg_9_1)
end

function var_0_0.getGoList(arg_10_0, arg_10_1)
	local var_10_0 = string.split(arg_10_1, "|")

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:getSceneNode(iter_10_1)

		var_10_0[iter_10_0] = var_10_1

		if not var_10_1 then
			logError(string.format("WeatherEggContainerComp can not find go by path:%s", iter_10_1))
		end
	end

	return var_10_0
end

function var_0_0.initSceneGo(arg_11_0, arg_11_1)
	arg_11_0._sceneGo = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._eggList) do
		local var_11_0 = lua_scene_eggs.configDict[iter_11_1]
		local var_11_1 = _G[var_11_0.actionClass].New()
		local var_11_2 = arg_11_0:getGoList(var_11_0.path)

		var_11_1:init(arg_11_0._sceneGo, var_11_2, var_11_0, arg_11_0._context)

		if var_11_0.parallel == 1 then
			table.insert(arg_11_0._parallelEggList, var_11_1)
		else
			table.insert(arg_11_0._serialEggList, var_11_1)
		end
	end

	arg_11_0:_startTimer()
end

function var_0_0.onSceneClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._switchEgg, arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._serialEggList) do
		iter_12_1:onSceneClose()
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._parallelEggList) do
		iter_12_3:onSceneClose()
	end
end

return var_0_0
