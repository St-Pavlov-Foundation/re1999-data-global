module("framework.mvc.ModuleMgr", package.seeall)

local var_0_0 = class("ModuleMgr")
local var_0_1 = xpcall
local var_0_2 = __G__TRACKBACK__

function var_0_0.ctor(arg_1_0)
	arg_1_0._moduleSetting = nil
	arg_1_0._models = {}
	arg_1_0._rpcs = {}
	arg_1_0._controllers = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._moduleSetting = arg_2_1
	arg_2_0._onInitCallback = arg_2_2
	arg_2_0._onInitCallbackObj = arg_2_3

	arg_2_0:_initModules()
end

function var_0_0.reInit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._models) do
		var_0_1(iter_3_1.instance.reInitInternal, var_0_2, iter_3_1.instance)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0._rpcs) do
		var_0_1(iter_3_3.instance.reInitInternal, var_0_2, iter_3_3.instance)
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_0._controllers) do
		var_0_1(iter_3_5.instance.reInit, var_0_2, iter_3_5.instance)
	end
end

function var_0_0.getSetting(arg_4_0, arg_4_1)
	return arg_4_0._moduleSetting[arg_4_1]
end

function var_0_0._initModules(arg_5_0)
	arg_5_0._frameHandleNum = 5
	arg_5_0._nowHandNum = 0
	arg_5_0._allHandNum = tabletool.len(arg_5_0._moduleSetting)
	arg_5_0._moduleSettingList = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._moduleSetting) do
		table.insert(arg_5_0._moduleSettingList, iter_5_1)
	end

	TaskDispatcher.runRepeat(arg_5_0._initModulesRepeat, arg_5_0, 0.01)
end

function var_0_0._initModulesRepeat(arg_6_0)
	for iter_6_0 = 1, arg_6_0._frameHandleNum do
		arg_6_0._nowHandNum = arg_6_0._nowHandNum + 1

		local var_6_0 = arg_6_0._moduleSettingList[arg_6_0._nowHandNum]

		arg_6_0:_initConfigs(var_6_0.config)
		arg_6_0:_initModels(var_6_0.model)
		arg_6_0:_initRpcs(var_6_0.rpc)
		arg_6_0:_initControllers(var_6_0.controller)

		if arg_6_0._nowHandNum == arg_6_0._allHandNum then
			TaskDispatcher.cancelTask(arg_6_0._initModulesRepeat, arg_6_0)
			arg_6_0:_initFinish()

			break
		end
	end
end

function var_0_0._initConfigs(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = _G[iter_7_1]

		if var_7_0 then
			var_7_0.instance:onInit()
			ConfigMgr.instance:addRequestor(var_7_0.instance)
		else
			logError("config not found: " .. iter_7_1)
		end
	end
end

function var_0_0._initModels(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = _G[iter_8_1]

		if var_8_0 then
			var_8_0.instance:onInit()
			table.insert(arg_8_0._models, var_8_0)
		else
			logError("model not found: " .. iter_8_1)
		end
	end
end

function var_0_0._initRpcs(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = _G[iter_9_1]

		if var_9_0 then
			var_9_0.instance:onInitInternal()
			table.insert(arg_9_0._rpcs, var_9_0)
		else
			logError("rpc not found: " .. iter_9_1)
		end
	end
end

function var_0_0._initControllers(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = _G[iter_10_1]

		if var_10_0 then
			LuaEventSystem.addEventMechanism(var_10_0.instance)
			var_10_0.instance:__onInit()
			var_10_0.instance:onInit()
			table.insert(arg_10_0._controllers, var_10_0)
		else
			logError("controller not found: " .. iter_10_1)
		end
	end
end

function var_0_0._initFinish(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._controllers) do
		iter_11_1.instance:onInitFinish()
		iter_11_1.instance:addConstEvents()
	end

	arg_11_0._onInitCallback(arg_11_0._onInitCallbackObj)
end

var_0_0.instance = var_0_0.New()

return var_0_0
