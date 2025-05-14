module("modules.logic.act189.controller.Activity189Testing", package.seeall)

local var_0_0 = table.insert
local var_0_1 = _G.class("TestingBase")
local var_0_2 = TaskEnum.TaskType.Activity189

function var_0_1.ctor(arg_1_0)
	arg_1_0._pb = Activity189Module_pb
	arg_1_0._cCfg = Activity189Config
	arg_1_0._cTaskCfg = TaskConfig
	arg_1_0._pbTask = TaskModule_pb
end

function var_0_1.build_test(arg_2_0)
	return
end

function var_0_1.link(arg_3_0, arg_3_1)
	arg_3_0._obj = arg_3_1
end

local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = "服务器异常"
local var_0_6 = "returnCode: -2"
local var_0_7 = _G.class("STesting", var_0_1)

function var_0_7.ctor(arg_4_0)
	var_0_1.ctor(arg_4_0)

	arg_4_0._taskInfoDict = {}
	arg_4_0._taskActivityInfoDict = {}
end

function var_0_7._make_taskInfos(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_1 == var_0_2 then
		for iter_5_0, iter_5_1 in ipairs(lua_activity189_task.configList) do
			local var_5_1 = iter_5_1.id
			local var_5_2 = iter_5_1.activityId

			var_5_0[var_5_2] = var_5_0[var_5_2] or {}

			if iter_5_1.isOnline then
				var_5_0[var_5_2][var_5_1] = arg_5_0:_make_TaskInfo(var_5_1, arg_5_1)
			end
		end
	else
		assert(false, "please init task type: " .. arg_5_1)
	end

	return var_5_0
end

function var_0_7._make_TaskActivityInfo(arg_6_0, arg_6_1)
	return {
		defineId = 0,
		expiryTime = 0,
		value = 0,
		gainValue = 0,
		typeId = arg_6_1
	}
end

function var_0_7.handleGetTaskInfoReply(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.typeIds
	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if not arg_7_0._taskInfoDict[iter_7_1] then
			arg_7_0._taskInfoDict[iter_7_1] = arg_7_0:_make_taskInfos(iter_7_1)
		end

		if not arg_7_0._taskActivityInfoDict[iter_7_1] then
			arg_7_0._taskActivityInfoDict[iter_7_1] = arg_7_0:_make_TaskActivityInfo(iter_7_1)
		end

		for iter_7_2, iter_7_3 in pairs(arg_7_0._taskInfoDict[iter_7_1]) do
			for iter_7_4, iter_7_5 in pairs(iter_7_3) do
				var_0_0(var_7_1, iter_7_5)
			end
		end

		var_0_0(var_7_2, arg_7_0._taskActivityInfoDict[iter_7_1])
	end

	rawset(arg_7_2, "taskInfo", var_7_1)
	rawset(arg_7_2, "activityInfo", var_7_2)
	rawset(arg_7_2, "typeIds", var_7_0)
end

function var_0_7._make_TaskInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = TaskModel.instance:getTaskConfig(arg_8_2, arg_8_1)

	assert(var_8_0, var_0_5)

	local var_8_1 = var_8_0.maxProgress
	local var_8_2 = {
		hasFinished = false,
		expiryTime = 0,
		finishCount = 0,
		id = arg_8_1,
		type = arg_8_2,
		progress = math.random(0, var_8_1)
	}

	var_8_2.hasFinished = var_8_2.progress == var_8_1

	return var_8_2
end

local var_0_8 = 0
local var_0_9 = _G.class("CTesting", var_0_1)

function var_0_9.ctor(arg_9_0)
	var_0_1.ctor(arg_9_0)

	arg_9_0._cRpc = Activity189Rpc
	arg_9_0._cCtrl = Activity189Controller
	arg_9_0._cModel = Activity189Model
	arg_9_0._cTaskRpc = TaskRpc
	arg_9_0._cTaskModel = TaskModel
	arg_9_0._cTaskController = TaskController
end

function var_0_9.build_test(arg_10_0)
	arg_10_0:build_test__Task()
	arg_10_0:build_test__Player()
end

function var_0_9.build_test__Player(arg_11_0)
	function PlayerModel.forceSetSimpleProperty()
		return
	end
end

function var_0_9.build_test__Task(arg_13_0)
	local var_13_0 = arg_13_0._cTaskCfg.instance
	local var_13_1 = arg_13_0._cTaskRpc.instance
	local var_13_2 = arg_13_0._cTaskController.instance
	local var_13_3 = arg_13_0._cTaskModel.instance
	local var_13_4 = arg_13_0._pbTask

	function arg_13_0._cTaskRpc.sendGetTaskInfoRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		local var_14_0 = var_13_4.GetTaskInfoRequest()

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			table.insert(var_14_0.typeIds, iter_14_1)
		end

		if #arg_14_1 == 1 and arg_14_1[1] == var_0_2 then
			local var_14_1 = var_13_4.GetTaskInfoReply()

			arg_13_0._obj:handleGetTaskInfoReply(var_14_0, var_14_1)
			var_13_1:onReceiveGetTaskInfoReply(var_0_8, var_14_1)

			local var_14_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_14_0.__cname)

			if arg_14_2 then
				if arg_14_3 then
					arg_14_2(arg_14_3, var_14_2, var_0_8)
				else
					arg_14_2(var_14_2, var_0_8)
				end
			end
		else
			return arg_14_0:sendMsg(var_14_0, arg_14_2, arg_14_3)
		end
	end
end

local var_0_10 = _G.class("Activity189Testing")

function var_0_10.ctor(arg_15_0)
	arg_15_0._client = var_0_9.New()
	arg_15_0._sever = var_0_7.New()

	arg_15_0._sever:link(arg_15_0._client)
	arg_15_0._client:link(arg_15_0._sever)
end

function var_0_10._test(arg_16_0)
	arg_16_0._client:build_test()
	arg_16_0._sever:build_test()
end

var_0_10.instance = var_0_10.New()

return var_0_10
