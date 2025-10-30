module("modules.logic.versionactivity1_3.act125.controller.Activity125Testing", package.seeall)

local var_0_0 = _G.class("TestingBase")
local var_0_1 = TaskEnum.TaskType.Activity125

function var_0_0.ctor(arg_1_0)
	arg_1_0._pb = Activity125Module_pb
	arg_1_0._cCfg = Activity125Config
	arg_1_0._cTaskCfg = TaskConfig
	arg_1_0._pbTask = TaskModule_pb
end

function var_0_0.build_test(arg_2_0)
	return
end

function var_0_0.link(arg_3_0, arg_3_1)
	arg_3_0._obj = arg_3_1
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = "myserver error"
local var_0_5 = "returnCode: -2"
local var_0_6 = _G.class("STesting", var_0_0)

function var_0_6.ctor(arg_4_0)
	var_0_0.ctor(arg_4_0)

	arg_4_0._actId2InfoDict = {}
	arg_4_0._taskInfoDict = {}
	arg_4_0._taskActivityInfoDict = {}
end

function var_0_6._make_Act125Episode(arg_5_0, arg_5_1, arg_5_2)
	return {
		id = arg_5_1,
		state = arg_5_2 or math.random(0, 99999) % 2 == 0 and var_0_3 or var_0_2
	}
end

function var_0_6._make_Info(arg_6_0, arg_6_1)
	assert(arg_6_1, var_0_4)

	local var_6_0 = arg_6_0._cCfg.instance
	local var_6_1 = assert(var_6_0:getAct125Config(arg_6_1), var_0_4 .. arg_6_1)
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_3 = iter_6_1.id

		var_6_2[var_6_3] = arg_6_0:_make_Act125Episode(var_6_3, var_0_2)
	end

	local var_6_4 = {
		activityId = arg_6_1,
		act125Episodes = var_6_2
	}
	local var_6_5 = 0

	for iter_6_2 = 1, var_6_5 do
		var_6_2[iter_6_2].state = var_0_3
	end

	return var_6_4
end

function var_0_6.handleGetInfos(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.activityId

	if not arg_7_0:_getInfo(var_7_0) then
		local var_7_1 = arg_7_0:_make_Info(var_7_0)

		arg_7_0._actId2InfoDict[var_7_0] = var_7_1
	end

	rawset(arg_7_2, "activityId", var_7_0)
	rawset(arg_7_2, "act125Episodes", arg_7_0:_getEpisodeList(var_7_0))
end

function var_0_6.handleFinishAct125Episode(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.activityId
	local var_8_1 = arg_8_1.episodeId
	local var_8_2 = arg_8_1.targetFrequency
	local var_8_3 = arg_8_0._cCfg.instance
	local var_8_4 = var_8_3:getAct125Config(var_8_0)
	local var_8_5 = assert(arg_8_0:_getInfo(var_8_0), var_0_4)
	local var_8_6 = var_8_3:getEpisodeConfig(var_8_0, var_8_1)
	local var_8_7 = {}

	if var_8_2 >= var_8_6.targetFrequency then
		local var_8_8 = arg_8_0:_retainEpisodeNewState(var_8_0, var_8_1, var_0_3)

		table.insert(var_8_7, var_8_8)
	end

	rawset(arg_8_2, "activityId", var_8_0)
	rawset(arg_8_2, "episodeId", var_8_1)
	rawset(arg_8_2, "updateAct125Episodes", var_8_7)
end

function var_0_6._make_taskInfos(arg_9_0, arg_9_1)
	local var_9_0 = {}

	if arg_9_1 == var_0_1 then
		for iter_9_0, iter_9_1 in ipairs(lua_activity125_task.configList) do
			local var_9_1 = iter_9_1.id
			local var_9_2 = iter_9_1.activityId

			var_9_0[var_9_2] = var_9_0[var_9_2] or {}

			if iter_9_1.isOnline then
				var_9_0[var_9_2][var_9_1] = arg_9_0:_make_TaskInfo(var_9_1, arg_9_1)
			end
		end
	else
		assert(false, "please init task type: " .. arg_9_1)
	end

	return var_9_0
end

function var_0_6._make_TaskActivityInfo(arg_10_0, arg_10_1)
	return {
		defineId = 0,
		expiryTime = 0,
		value = 0,
		gainValue = 0,
		typeId = arg_10_1
	}
end

function var_0_6.handleGetTaskInfoReply(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1.typeIds
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not arg_11_0._taskInfoDict[iter_11_1] then
			arg_11_0._taskInfoDict[iter_11_1] = arg_11_0:_make_taskInfos(iter_11_1)
		end

		if not arg_11_0._taskActivityInfoDict[iter_11_1] then
			arg_11_0._taskActivityInfoDict[iter_11_1] = arg_11_0:_make_TaskActivityInfo(iter_11_1)
		end

		for iter_11_2, iter_11_3 in pairs(arg_11_0._taskInfoDict[iter_11_1]) do
			if iter_11_2 == 12436 then
				for iter_11_4, iter_11_5 in pairs(iter_11_3) do
					table.insert(var_11_1, iter_11_5)
				end
			end
		end

		table.insert(var_11_2, arg_11_0._taskActivityInfoDict[iter_11_1])
	end

	rawset(arg_11_2, "taskInfo", var_11_1)
	rawset(arg_11_2, "activityInfo", var_11_2)
	rawset(arg_11_2, "typeIds", var_11_0)
end

function var_0_6._getInfo(arg_12_0, arg_12_1)
	return arg_12_0._actId2InfoDict[arg_12_1]
end

function var_0_6._getEpisodeList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:_getInfo(arg_13_1)
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0.act125Episodes) do
		table.insert(var_13_1, iter_13_1)
	end

	table.sort(var_13_1, function(arg_14_0, arg_14_1)
		return arg_14_0.id < arg_14_1.id
	end)

	return var_13_1
end

function var_0_6._retainEpisodeNewState(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	assert(arg_15_1, var_0_4)
	assert(arg_15_2, var_0_4)
	assert(arg_15_3, var_0_4)

	local var_15_0 = assert(arg_15_0:_getInfo(arg_15_1), var_0_4).act125Episodes[arg_15_2]

	if not var_15_0 then
		logError(var_0_5)

		return
	end

	var_15_0.state = arg_15_3

	return var_15_0
end

function var_0_6._make_TaskInfo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = TaskModel.instance:getTaskConfig(arg_16_2, arg_16_1)

	assert(var_16_0, var_0_4)

	local var_16_1 = var_16_0.maxProgress
	local var_16_2 = {
		hasFinished = false,
		expiryTime = 0,
		finishCount = 0,
		id = arg_16_1,
		type = arg_16_2,
		progress = math.random(0, var_16_1)
	}

	var_16_2.hasFinished = var_16_2.progress == var_16_1

	return var_16_2
end

local var_0_7 = 0
local var_0_8 = _G.class("CTesting", var_0_0)

function var_0_8.ctor(arg_17_0)
	var_0_0.ctor(arg_17_0)

	arg_17_0._cRpc = Activity125Rpc
	arg_17_0._cCtrl = Activity125Controller
	arg_17_0._cModel = Activity125Model
	arg_17_0._cActivity125ViewBaseContainer = Activity125ViewBaseContainer
	arg_17_0._cTaskRpc = TaskRpc
	arg_17_0._cTaskModel = TaskModel
	arg_17_0._cTaskController = TaskController
end

function var_0_8.build_test(arg_18_0)
	arg_18_0:build_test__Act125()
	arg_18_0:build_test__Task()
	arg_18_0:build_test__Player()
end

function var_0_8.build_test__Player(arg_19_0)
	function PlayerModel.forceSetSimpleProperty()
		return
	end
end

function var_0_8.build_test__Act125(arg_21_0)
	local var_21_0 = arg_21_0._cCfg.instance
	local var_21_1 = arg_21_0._cRpc.instance
	local var_21_2 = arg_21_0._cCtrl.instance
	local var_21_3 = arg_21_0._cModel.instance
	local var_21_4 = arg_21_0._pb

	function arg_21_0._cRpc.sendGetAct125InfosRequest(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		local var_22_0 = var_21_4.GetAct125InfosRequest()

		var_22_0.activityId = arg_22_1

		local var_22_1 = var_21_4.GetAct125InfosReply()

		arg_21_0._obj:handleGetInfos(var_22_0, var_22_1)
		var_21_1:onReceiveGetAct125InfosReply(var_0_7, var_22_1)

		local var_22_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_22_0.__cname)

		if arg_22_2 then
			if arg_22_3 then
				arg_22_2(arg_22_3, var_22_2, var_0_7)
			else
				arg_22_2(var_22_2, var_0_7)
			end
		end
	end

	function arg_21_0._cRpc.sendFinishAct125EpisodeRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
		local var_23_0 = var_21_4.FinishAct125EpisodeRequest()

		var_23_0.activityId = arg_23_1
		var_23_0.episodeId = arg_23_2
		var_23_0.targetFrequency = arg_23_3

		local var_23_1 = var_21_4.FinishAct125EpisodeReply()

		arg_21_0._obj:handleFinishAct125Episode(var_23_0, var_23_1)
		var_21_1:onReceiveFinishAct125EpisodeReply(var_0_7, var_23_1)

		local var_23_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_23_0.__cname)

		if arg_23_4 then
			if arg_23_5 then
				arg_23_4(arg_23_5, var_23_2, var_0_7)
			else
				arg_23_4(var_23_2, var_0_7)
			end
		end
	end

	local var_21_5 = Activity125MO
	local var_21_6 = true
	local var_21_7 = true
	local var_21_8 = true

	if var_21_6 and var_21_5 then
		local var_21_9 = {}

		function var_21_5.setLocalIsPlay(arg_24_0, arg_24_1)
			var_21_9[arg_24_0.id] = var_21_9[arg_24_0.id] or {}
			var_21_9[arg_24_0.id][arg_24_1] = true
		end

		function var_21_5.checkLocalIsPlay(arg_25_0, arg_25_1)
			var_21_9[arg_25_0.id] = var_21_9[arg_25_0.id] or {}

			return var_21_9[arg_25_0.id][arg_25_1]
		end
	end

	if not var_21_8 then
		function arg_21_0._cActivity125ViewBaseContainer.saveInt(arg_26_0, arg_26_1, arg_26_2)
			logError("[Activity125Testing] saveInt: key=" .. arg_26_1 .. " value=" .. tostring(arg_26_2))
		end
	end

	if var_21_7 and var_21_5 then
		function var_21_5.isEpisodeDayOpen(arg_27_0, arg_27_1)
			return true
		end

		function var_21_5.isEpisodeReallyOpen(arg_28_0, arg_28_1)
			return true
		end

		function var_21_5.isEpisodeUnLock(arg_29_0, arg_29_1)
			return true
		end
	end
end

function var_0_8.build_test__Task(arg_30_0)
	local var_30_0 = arg_30_0._cTaskCfg.instance
	local var_30_1 = arg_30_0._cTaskRpc.instance
	local var_30_2 = arg_30_0._cTaskController.instance
	local var_30_3 = arg_30_0._cTaskModel.instance
	local var_30_4 = arg_30_0._pbTask

	function arg_30_0._cTaskRpc.sendGetTaskInfoRequest(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = var_30_4.GetTaskInfoRequest()

		for iter_31_0, iter_31_1 in pairs(arg_31_1) do
			table.insert(var_31_0.typeIds, iter_31_1)
		end

		if #arg_31_1 == 1 and arg_31_1[1] == var_0_1 then
			local var_31_1 = var_30_4.GetTaskInfoReply()

			arg_30_0._obj:handleGetTaskInfoReply(var_31_0, var_31_1)
			var_30_1:onReceiveGetTaskInfoReply(var_0_7, var_31_1)

			local var_31_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_31_0.__cname)

			if arg_31_2 then
				if arg_31_3 then
					arg_31_2(arg_31_3, var_31_2, var_0_7)
				else
					arg_31_2(var_31_2, var_0_7)
				end
			end
		else
			return arg_31_0:sendMsg(var_31_0, arg_31_2, arg_31_3)
		end
	end
end

local var_0_9 = _G.class("Activity125Testing")

function var_0_9.ctor(arg_32_0)
	arg_32_0._client = var_0_8.New()
	arg_32_0._sever = var_0_6.New()

	arg_32_0._sever:link(arg_32_0._client)
	arg_32_0._client:link(arg_32_0._sever)
end

function var_0_9._test(arg_33_0)
	arg_33_0._client:build_test()
	arg_33_0._sever:build_test()
end

function var_0_9._offline_test(arg_34_0)
	local var_34_0 = lua_activity125.configList or {}
	local var_34_1 = var_34_0[#var_34_0]

	for iter_34_0 = #var_34_0, math.max(1, #var_34_0 - 5), -1 do
		local var_34_2 = var_34_0[iter_34_0]
		local var_34_3 = var_34_2.activityId

		if lua_activity125_link.configDict[var_34_3] then
			var_34_1 = var_34_2

			break
		end
	end

	local var_34_4 = var_34_1 and var_34_1.activityId or nil

	logError(var_34_4)

	if not var_34_4 then
		logError("Activity125Testing offline test error: can not found actid")

		return
	end

	local var_34_5 = os.time() * 1000
	local var_34_6 = var_34_5 + 259200
	local var_34_7 = {
		activityInfos = {
			{
				currentStage = 0,
				isUnlock = true,
				online = true,
				isReceiveAllBonus = false,
				isNewStage = false,
				id = var_34_4,
				startTime = var_34_5,
				endTime = var_34_6
			}
		}
	}

	ActivityModel.instance:setActivityInfo(var_34_7)
	var_0_9.instance:_test()
	Activity125Model.instance:setSelectEpisodeId(var_34_4, 1)
	ActivityModel.instance:setTargetActivityCategoryId(var_34_4)
	ViewMgr.instance:openView(ViewName.ActivityBeginnerView)
end

var_0_9.instance = var_0_9.New()

return var_0_9
