module("modules.logic.gm.gaosiniao.GaoSiNiaoTesting", package.seeall)

local var_0_0 = GaoSiNiaoEnum.GridType.Empty
local var_0_1 = GaoSiNiaoEnum.GridType.Start
local var_0_2 = GaoSiNiaoEnum.GridType.End
local var_0_3 = GaoSiNiaoEnum.GridType.Wall
local var_0_4 = GaoSiNiaoEnum.GridType.Portal
local var_0_5 = GaoSiNiaoEnum.GridType.Path
local var_0_6 = GaoSiNiaoEnum.PathType.RB
local var_0_7 = GaoSiNiaoEnum.PathType.LT
local var_0_8 = GaoSiNiaoEnum.PathType.LRTB
local var_0_9 = GaoSiNiaoEnum.PathType.TB
local var_0_10 = GaoSiNiaoEnum.PathType.LB
local var_0_11 = GaoSiNiaoEnum.PathType.RT
local var_0_12 = GaoSiNiaoEnum.PathType.LR
local var_0_13 = GaoSiNiaoEnum.PathType.LTB
local var_0_14 = GaoSiNiaoEnum.PathType.RTB
local var_0_15 = GaoSiNiaoEnum.PathType.LRB
local var_0_16 = GaoSiNiaoEnum.PathType.LRT

local function var_0_17()
	local var_1_0 = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local var_1_1 = {
		id = -11235,
		height = 4,
		width = 4,
		bagList = {
			var_1_0:make_bagCO(var_0_7, 1),
			var_1_0:make_bagCO(var_0_6, 2),
			var_1_0:make_bagCO(var_0_10, 3),
			(var_1_0:make_bagCO(var_0_8, 4))
		},
		gridList = {}
	}

	math.randomseed(os.time())
	GaoSiNiaoBattleMapMO.s_foreachGrid(var_1_1.width, var_1_1.height, function(arg_2_0, arg_2_1, arg_2_2)
		var_1_1.gridList[arg_2_0] = math.random(0, GaoSiNiaoEnum.GridType.__End)
	end)
end

local function var_0_18()
	local var_3_0 = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local var_3_1 = {
		id = 1000,
		height = 4,
		width = 4,
		bagList = {
			var_3_0:make_bagCO(var_0_9, 2),
			var_3_0:make_bagCO(var_0_10, 1),
			var_3_0:make_bagCO(var_0_12, 2),
			(var_3_0:make_bagCO(var_0_11, 1))
		}
	}

	local function var_3_2(...)
		return var_3_0:make_gridCO(...)
	end

	local function var_3_3(...)
		return var_3_0:make_gridCOZot(...)
	end

	var_3_1.gridList = {
		[0] = var_3_2(var_0_1),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_3),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		var_3_2(var_0_3),
		var_3_2(var_0_3),
		var_3_2(var_0_0),
		var_3_2(var_0_0),
		(var_3_3(var_0_2, 90))
	}

	return var_3_1
end

local function var_0_19()
	local var_6_0 = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local var_6_1 = {
		id = 1001,
		height = 5,
		width = 5,
		bagList = {
			var_6_0:make_bagCO(var_0_10, 3),
			var_6_0:make_bagCO(var_0_11, 2),
			(var_6_0:make_bagCO(var_0_12, 2))
		}
	}

	local function var_6_2(...)
		return var_6_0:make_gridCO(...)
	end

	local function var_6_3(...)
		return var_6_0:make_gridCOZot(...)
	end

	var_6_1.gridList = {
		[0] = var_6_2(var_0_1),
		var_6_2(var_0_0),
		var_6_2(var_0_0),
		var_6_2(var_0_0),
		var_6_2(var_0_5, var_0_10),
		var_6_2(var_0_0),
		var_6_2(var_0_5, var_0_11),
		var_6_2(var_0_0),
		var_6_2(var_0_5, var_0_12),
		var_6_2(var_0_0),
		var_6_2(var_0_5, var_0_9),
		var_6_2(var_0_3),
		var_6_2(var_0_5, var_0_9),
		var_6_2(var_0_3),
		var_6_2(var_0_0),
		var_6_2(var_0_0),
		var_6_2(var_0_0),
		var_6_2(var_0_0),
		var_6_2(var_0_5, var_0_12),
		var_6_2(var_0_0),
		var_6_2(var_0_5, var_0_11),
		var_6_2(var_0_0),
		var_6_2(var_0_3),
		var_6_2(var_0_0),
		(var_6_3(var_0_2, 90))
	}

	return var_6_1
end

local function var_0_20()
	local var_9_0 = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local var_9_1 = {
		id = 1002,
		height = 5,
		width = 5,
		bagList = {
			var_9_0:make_bagCO(var_0_12, 3),
			var_9_0:make_bagCO(var_0_10, 2),
			var_9_0:make_bagCO(var_0_6, 2),
			var_9_0:make_bagCO(var_0_9, 1),
			var_9_0:make_bagCO(var_0_7, 3),
			(var_9_0:make_bagCO(var_0_11, 1))
		}
	}

	local function var_9_2(...)
		return var_9_0:make_gridCO(...)
	end

	local function var_9_3(...)
		return var_9_0:make_gridCOZot(...)
	end

	var_9_1.gridList = {
		[0] = var_9_2(var_0_1),
		var_9_2(var_0_0),
		var_9_2(var_0_0),
		var_9_2(var_0_0),
		var_9_2(var_0_0),
		var_9_2(var_0_0),
		var_9_2(var_0_3),
		var_9_2(var_0_3),
		var_9_2(var_0_5, var_0_11),
		var_9_2(var_0_0),
		var_9_2(var_0_3),
		var_9_2(var_0_0),
		var_9_2(var_0_4),
		var_9_2(var_0_3),
		var_9_2(var_0_0),
		var_9_2(var_0_0),
		var_9_2(var_0_5, var_0_9),
		var_9_2(var_0_3),
		var_9_2(var_0_0),
		var_9_2(var_0_0),
		var_9_2(var_0_2),
		var_9_2(var_0_0),
		var_9_2(var_0_4),
		var_9_2(var_0_0),
		(var_9_2(var_0_0))
	}

	return var_9_1
end

local function var_0_21()
	local var_12_0 = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local var_12_1 = {
		id = 1003,
		height = 5,
		width = 5,
		bagList = {
			var_12_0:make_bagCO(var_0_9, 2),
			var_12_0:make_bagCO(var_0_12, 2),
			var_12_0:make_bagCO(var_0_13, 1),
			var_12_0:make_bagCO(var_0_10, 1),
			var_12_0:make_bagCO(var_0_7, 1),
			(var_12_0:make_bagCO(var_0_6, 1))
		}
	}

	local function var_12_2(...)
		return var_12_0:make_gridCO(...)
	end

	local function var_12_3(...)
		return var_12_0:make_gridCOZot(...)
	end

	var_12_1.gridList = {
		[0] = var_12_2(var_0_1),
		var_12_2(var_0_0),
		var_12_2(var_0_0),
		var_12_2(var_0_3),
		var_12_3(var_0_2, 180),
		var_12_2(var_0_0),
		var_12_2(var_0_4),
		var_12_2(var_0_5, var_0_11),
		var_12_2(var_0_0),
		var_12_2(var_0_5, var_0_7),
		var_12_2(var_0_5, var_0_11),
		var_12_2(var_0_0),
		var_12_2(var_0_3),
		var_12_2(var_0_0),
		var_12_2(var_0_0),
		var_12_2(var_0_3),
		var_12_2(var_0_5, var_0_11),
		var_12_2(var_0_0),
		var_12_2(var_0_4),
		var_12_2(var_0_0),
		var_12_2(var_0_2),
		var_12_2(var_0_0),
		var_12_2(var_0_0),
		var_12_2(var_0_0),
		(var_12_2(var_0_3))
	}

	return var_12_1
end

local function var_0_22()
	local var_15_0 = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local var_15_1 = {
		id = 1004,
		height = 6,
		width = 6,
		bagList = {
			var_15_0:make_bagCO(var_0_12, 5),
			var_15_0:make_bagCO(var_0_7, 2),
			var_15_0:make_bagCO(var_0_6, 2),
			var_15_0:make_bagCO(var_0_11, 2),
			var_15_0:make_bagCO(var_0_10, 1),
			(var_15_0:make_bagCO(var_0_13, 1))
		}
	}

	local function var_15_2(...)
		return var_15_0:make_gridCO(...)
	end

	local function var_15_3(...)
		return var_15_0:make_gridCOZot(...)
	end

	var_15_1.gridList = {
		[0] = var_15_2(var_0_1),
		var_15_2(var_0_0),
		var_15_2(var_0_5, var_0_12),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_3),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_3),
		var_15_2(var_0_4),
		var_15_2(var_0_5, var_0_9),
		var_15_3(var_0_2, 180),
		var_15_2(var_0_5, var_0_11),
		var_15_2(var_0_0),
		var_15_2(var_0_3),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_5, var_0_9),
		var_15_2(var_0_3),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_5, var_0_12),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		var_15_2(var_0_3),
		var_15_2(var_0_3),
		var_15_2(var_0_4),
		var_15_2(var_0_0),
		var_15_2(var_0_3),
		var_15_2(var_0_0),
		var_15_2(var_0_0),
		(var_15_3(var_0_2, 90))
	}

	return var_15_1
end

local function var_0_23()
	return var_0_22()
end

local var_0_24 = _G.class("TestingBase")
local var_0_25 = TaskEnum.TaskType.Activity210

function var_0_24.ctor(arg_19_0)
	arg_19_0._pb = Activity210Module_pb
	arg_19_0._cCfg = GaoSiNiaoConfig
	arg_19_0._cTaskCfg = TaskConfig
	arg_19_0._pbTask = TaskModule_pb
end

function var_0_24.build_test(arg_20_0)
	return
end

function var_0_24.link(arg_21_0, arg_21_1)
	arg_21_0._obj = arg_21_1
end

function var_0_24.actId(arg_22_0)
	return arg_22_0._cCfg.instance:actId()
end

function var_0_24.getEpisodeCO(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._cCfg.instance

	if not arg_23_1 or arg_23_1 == 0 then
		return
	end

	return (var_23_0:getEpisodeCO(arg_23_1))
end

local var_0_26 = "myserver error"
local var_0_27 = "returnCode: -2"
local var_0_28 = _G.class("STesting", var_0_24)

function var_0_28.ctor(arg_24_0)
	var_0_24.ctor(arg_24_0)

	arg_24_0._actId2InfoDict = {}
	arg_24_0._taskInfoDict = {}
	arg_24_0._taskActivityInfoDict = {}
end

function var_0_28._make_Act210EpisodeRecord(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	return {
		episodeId = arg_25_1,
		isFinished = arg_25_2 or false,
		progress = arg_25_3 or "",
		unlockBranchIds = {}
	}
end

local var_0_29 = 6
local var_0_30 = 1311800

function var_0_28._make_Act210Info(arg_26_0, arg_26_1)
	assert(arg_26_1, var_0_26)

	local var_26_0 = assert(lua_activity210_episode.configDict[arg_26_1], var_0_26 .. arg_26_1)
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		local var_26_2 = iter_26_1.episodeId

		var_26_1[var_26_2] = arg_26_0:_make_Act210EpisodeRecord(var_26_2)
	end

	var_26_1[0] = arg_26_0:_make_Act210EpisodeRecord(0)

	local var_26_3 = {
		activityId = arg_26_1,
		episodeId2Act210EpisodeRecord = var_26_1
	}

	for iter_26_2 = 1, var_0_29 do
		var_26_1[var_0_30 + iter_26_2].isFinished = true
	end

	return var_26_3
end

function var_0_28.handleGetAct210Info(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1.activityId

	if not arg_27_0:_getInfo(var_27_0) then
		local var_27_1 = arg_27_0:_make_Act210Info(var_27_0)

		arg_27_0._actId2InfoDict[var_27_0] = var_27_1
	end

	rawset(arg_27_2, "activityId", var_27_0)
	rawset(arg_27_2, "episodes", arg_27_0:_getEpisodeList(var_27_0))
end

function var_0_28.handleAct210FinishEpisode(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1.activityId
	local var_28_1 = arg_28_1.episodeId
	local var_28_2 = arg_28_1.progress
	local var_28_3 = assert(arg_28_0:_getInfo(var_28_0), var_0_26)
	local var_28_4 = assert(var_28_3.episodeId2Act210EpisodeRecord[var_28_1], var_0_26)

	if var_28_1 == 0 then
		var_28_4.isFinished = true
	else
		local var_28_5 = assert(arg_28_0:getEpisodeCO(var_28_1), var_0_26)

		if var_28_5.preEpisodeId > 0 then
			local var_28_6 = var_28_3.episodeId2Act210EpisodeRecord[var_28_5.preEpisodeId]

			assert(var_28_6.isFinished, var_0_26)
		end

		var_28_4.isFinished = true
	end

	rawset(arg_28_2, "activityId", var_28_0)
	rawset(arg_28_2, "episodeId", var_28_1)
	rawset(arg_28_2, "progress", var_28_2)
end

function var_0_28.handleAct210SaveEpisodeProgress(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.activityId
	local var_29_1 = arg_29_1.episodeId
	local var_29_2 = arg_29_1.progress

	if var_29_1 == 0 then
		-- block empty
	else
		local var_29_3 = assert(arg_29_0:_getInfo(var_29_0), var_0_26)
		local var_29_4 = assert(var_29_3.episodeId2Act210EpisodeRecord[var_29_1], var_0_26)
		local var_29_5 = assert(arg_29_0:getEpisodeCO(var_29_1), var_0_26)
	end

	rawset(arg_29_2, "activityId", var_29_0)
	rawset(arg_29_2, "episodeId", var_29_1)
	rawset(arg_29_2, "progress", var_29_2)
end

function var_0_28.handleAct210ChooseEpisodeBranch(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1.activityId
	local var_30_1 = arg_30_1.episodeId
	local var_30_2 = arg_30_1.branchId

	rawset(arg_30_2, "activityId", var_30_0)
	rawset(arg_30_2, "episodeId", var_30_1)
	rawset(arg_30_2, "branchId", var_30_2)
end

function var_0_28._make_taskInfos(arg_31_0, arg_31_1)
	local var_31_0 = {}

	if arg_31_1 == var_0_25 then
		for iter_31_0, iter_31_1 in ipairs(lua_activity210_task.configList) do
			local var_31_1 = iter_31_1.id
			local var_31_2 = iter_31_1.activityId

			var_31_0[var_31_2] = var_31_0[var_31_2] or {}

			if iter_31_1.isOnline then
				var_31_0[var_31_2][var_31_1] = arg_31_0:_make_TaskInfo(var_31_1, arg_31_1)
			end
		end
	else
		assert(false, "please init task type: " .. arg_31_1)
	end

	return var_31_0
end

function var_0_28._make_TaskActivityInfo(arg_32_0, arg_32_1)
	return {
		defineId = 0,
		expiryTime = 0,
		value = 0,
		gainValue = 0,
		typeId = arg_32_1
	}
end

function var_0_28.handleGetTaskInfoReply(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1.typeIds
	local var_33_1 = {}
	local var_33_2 = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		if not arg_33_0._taskInfoDict[iter_33_1] then
			arg_33_0._taskInfoDict[iter_33_1] = arg_33_0:_make_taskInfos(iter_33_1)
		end

		if not arg_33_0._taskActivityInfoDict[iter_33_1] then
			arg_33_0._taskActivityInfoDict[iter_33_1] = arg_33_0:_make_TaskActivityInfo(iter_33_1)
		end

		for iter_33_2, iter_33_3 in pairs(arg_33_0._taskInfoDict[iter_33_1]) do
			if iter_33_2 == arg_33_0:actId() then
				for iter_33_4, iter_33_5 in pairs(iter_33_3) do
					table.insert(var_33_1, iter_33_5)
				end
			end
		end

		table.insert(var_33_2, arg_33_0._taskActivityInfoDict[iter_33_1])
	end

	rawset(arg_33_2, "taskInfo", var_33_1)
	rawset(arg_33_2, "activityInfo", var_33_2)
	rawset(arg_33_2, "typeIds", var_33_0)
end

function var_0_28._getInfo(arg_34_0, arg_34_1)
	return arg_34_0._actId2InfoDict[arg_34_1]
end

function var_0_28._getEpisodeList(arg_35_0, arg_35_1)
	local var_35_0 = assert(arg_35_0:_getInfo(arg_35_1), var_0_26)
	local var_35_1 = {}

	for iter_35_0, iter_35_1 in pairs(var_35_0.episodeId2Act210EpisodeRecord) do
		table.insert(var_35_1, iter_35_1)
	end

	table.sort(var_35_1, function(arg_36_0, arg_36_1)
		return arg_36_0.episodeId < arg_36_1.episodeId
	end)

	return var_35_1
end

function var_0_28._make_TaskInfo(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = TaskModel.instance:getTaskConfig(arg_37_2, arg_37_1)

	assert(var_37_0, var_0_26)

	local var_37_1 = var_37_0.maxProgress
	local var_37_2 = {
		hasFinished = false,
		expiryTime = 0,
		finishCount = 0,
		id = arg_37_1,
		type = arg_37_2,
		progress = math.random(0, var_37_1)
	}

	var_37_2.hasFinished = var_37_2.progress == var_37_1

	return var_37_2
end

local var_0_31 = 0
local var_0_32 = _G.class("CTesting", var_0_24)

function var_0_32.ctor(arg_38_0)
	var_0_24.ctor(arg_38_0)

	arg_38_0._cRpc = Activity210Rpc
	arg_38_0._cCtrl = GaoSiNiaoController
	arg_38_0._cSysModel = GaoSiNiaoSysModel
	arg_38_0._cBattleModel = GaoSiNiaoBattleModel
	arg_38_0._cTaskRpc = TaskRpc
	arg_38_0._cTaskModel = TaskModel
	arg_38_0._cTaskController = TaskController
	arg_38_0._cGaoSiNiaoLevelViewContainer = V3a1_GaoSiNiao_LevelViewContainer
	arg_38_0._cV3a1_GaoSiNiao_GameView = V3a1_GaoSiNiao_GameView
	arg_38_0._cV3a1_GaoSiNiao_GameViewContainer = V3a1_GaoSiNiao_GameViewContainer
	arg_38_0._cGaoSiNiaoMapInfo = GaoSiNiaoMapInfo
	arg_38_0._cActivity210ViewBaseContainer = Activity210ViewBaseContainer
end

function var_0_32.build_test(arg_39_0)
	arg_39_0:build_test__Act210()
	arg_39_0:build_test__Task()
end

function var_0_32.build_test__Act210(arg_40_0)
	local var_40_0 = arg_40_0._cCfg.instance
	local var_40_1 = arg_40_0._cRpc.instance
	local var_40_2 = arg_40_0._cCtrl.instance
	local var_40_3 = arg_40_0._cSysModel.instance
	local var_40_4 = arg_40_0._pb

	function arg_40_0._cRpc.sendGetAct210InfoRequest(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
		local var_41_0 = var_40_4.GetAct210InfoRequest()

		var_41_0.activityId = arg_41_1

		local var_41_1 = var_40_4.GetAct210InfoReply()

		arg_40_0._obj:handleGetAct210Info(var_41_0, var_41_1)
		var_40_1:onReceiveGetAct210InfoReply(var_0_31, var_41_1)

		local var_41_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_41_0.__cname)

		if arg_41_2 then
			if arg_41_3 then
				arg_41_2(arg_41_3, var_41_2, var_0_31)
			else
				arg_41_2(var_41_2, var_0_31)
			end
		end
	end

	function arg_40_0._cRpc.sendAct210FinishEpisodeRequest(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
		local var_42_0 = var_40_4.Act210FinishEpisodeRequest()

		var_42_0.activityId = arg_42_1
		var_42_0.episodeId = arg_42_2
		var_42_0.progress = arg_42_3 or ""

		local var_42_1 = var_40_4.Act210FinishEpisodeReply()

		arg_40_0._obj:handleAct210FinishEpisode(var_42_0, var_42_1)
		var_40_1:onReceiveAct210FinishEpisodeReply(var_0_31, var_42_1)

		local var_42_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_42_0.__cname)

		if arg_42_4 then
			if arg_42_5 then
				arg_42_4(arg_42_5, var_42_2, var_0_31)
			else
				arg_42_4(var_42_2, var_0_31)
			end
		end
	end

	function arg_40_0._cRpc.sendAct210SaveEpisodeProgressRequest(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
		local var_43_0 = var_40_4.Act210SaveEpisodeProgressRequest()

		var_43_0.activityId = arg_43_1
		var_43_0.episodeId = arg_43_2
		var_43_0.progress = arg_43_3 or ""

		local var_43_1 = var_40_4.Act210SaveEpisodeProgressReply()

		arg_40_0._obj:handleAct210SaveEpisodeProgress(var_43_0, var_43_1)
		var_40_1:onReceiveAct210FinishEpisodeReply(var_0_31, var_43_1)

		local var_43_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_43_0.__cname)

		if arg_43_4 then
			if arg_43_5 then
				arg_43_4(arg_43_5, var_43_2, var_0_31)
			else
				arg_43_4(var_43_2, var_0_31)
			end
		end
	end

	function arg_40_0._cRpc.sendAct210ChooseEpisodeBranchRequest(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
		local var_44_0 = var_40_4.Act210ChooseEpisodeBranchRequest()

		var_44_0.activityId = arg_44_1
		var_44_0.episodeId = arg_44_2
		var_44_0.branchId = arg_44_3

		local var_44_1 = var_40_4.Act210ChooseEpisodeBranchReply()

		arg_40_0._obj:handleAct210ChooseEpisodeBranch(var_44_0, var_44_1)
		var_40_1:onReceiveAct210ChooseEpisodeBranchReply(var_0_31, var_44_1)

		local var_44_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_44_0.__cname)

		if arg_44_4 then
			if arg_44_5 then
				arg_44_4(arg_44_5, var_44_2, var_0_31)
			else
				arg_44_4(var_44_2, var_0_31)
			end
		end
	end

	function arg_40_0._cSysModel.hasPassPreStory()
		return true
	end

	function arg_40_0._cSysModel.hasPassPostStory()
		return true
	end

	function arg_40_0._cSysModel.hasPassPrePostStory()
		return true
	end

	function arg_40_0._cGaoSiNiaoLevelViewContainer.onContainerInit()
		return
	end

	function arg_40_0._cGaoSiNiaoLevelViewContainer.buildViews(arg_49_0)
		return {
			V3a1_GaoSiNiao_LevelView.New()
		}
	end

	arg_40_0._cGaoSiNiaoLevelViewContainer.s_episodeIdSet = arg_40_0._cGaoSiNiaoLevelViewContainer.s_episodeIdSet or {}

	local var_40_5 = arg_40_0._cGaoSiNiaoLevelViewContainer.s_episodeIdSet

	function arg_40_0._cGaoSiNiaoLevelViewContainer.saveHasPlayedUnlockedAnimPath(arg_50_0, arg_50_1)
		var_40_5[arg_50_1] = true
	end

	function arg_40_0._cGaoSiNiaoLevelViewContainer.hasPlayedUnlockedAnimPath(arg_51_0, arg_51_1)
		return var_40_5[arg_51_1] == true
	end

	function arg_40_0._cGaoSiNiaoLevelViewContainer.isEpisodeOpen(arg_52_0, arg_52_1)
		local var_52_0 = var_0_30 + (var_0_29 + 1)

		return arg_52_1 <= GameUtil.clamp(var_52_0, 1311801, 1311809)
	end

	function arg_40_0._cV3a1_GaoSiNiao_GameViewContainer.openInternal(arg_53_0, arg_53_1, ...)
		local var_53_0 = var_0_23()
		local var_53_1 = require("modules.logic.gm.gaosiniao.ser")
		local var_53_2 = {
			var_0_18(),
			var_0_19(),
			var_0_20(),
			var_0_21(),
			var_0_22()
		}

		ddde("file=", var_53_1(var_53_2))

		local var_53_3 = arg_40_0._cBattleModel.instance

		var_53_3._episodeId = var_53_3._episodeId, var_53_3:onInit()

		local var_53_4 = var_53_3._mapMO

		var_53_4.__info._mapCO = var_53_0

		var_53_4:_createMap(var_53_0)
		arg_40_0._cV3a1_GaoSiNiao_GameViewContainer.super.openInternal(arg_53_0, arg_53_1, ...)
	end

	function arg_40_0._cV3a1_GaoSiNiao_GameViewContainer.buildViews(arg_54_0)
		return {
			V3a1_GaoSiNiao_GameView.New()
		}
	end

	function arg_40_0._cGaoSiNiaoMapInfo.mapCO(arg_55_0)
		if not arg_55_0._mapCO then
			arg_55_0._mapCO = var_0_23()
		end

		return arg_55_0._mapCO
	end

	function arg_40_0._cActivity210ViewBaseContainer.saveInt(arg_56_0, arg_56_1)
		logError("saveInt:" .. tostring(arg_56_0) .. " value=" .. tostring(arg_56_1))
	end
end

function var_0_32.build_test__Task(arg_57_0)
	local var_57_0 = arg_57_0._cTaskCfg.instance
	local var_57_1 = arg_57_0._cTaskRpc.instance
	local var_57_2 = arg_57_0._cTaskController.instance
	local var_57_3 = arg_57_0._cTaskModel.instance
	local var_57_4 = arg_57_0._pbTask

	function arg_57_0._cTaskRpc.sendGetTaskInfoRequest(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
		local var_58_0 = var_57_4.GetTaskInfoRequest()

		for iter_58_0, iter_58_1 in pairs(arg_58_1) do
			table.insert(var_58_0.typeIds, iter_58_1)
		end

		if #arg_58_1 == 1 and arg_58_1[1] == var_0_25 then
			local var_58_1 = var_57_4.GetTaskInfoReply()

			arg_57_0._obj:handleGetTaskInfoReply(var_58_0, var_58_1)
			var_57_1:onReceiveGetTaskInfoReply(var_0_31, var_58_1)

			local var_58_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_58_0.__cname)

			if arg_58_2 then
				if arg_58_3 then
					arg_58_2(arg_58_3, var_58_2, var_0_31)
				else
					arg_58_2(var_58_2, var_0_31)
				end
			end
		else
			return arg_58_0:sendMsg(var_58_0, arg_58_2, arg_58_3)
		end
	end
end

function var_0_32.switchMode(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0._cBattleModel.instance

	if var_59_0._mapMO.class.__cname == "GaoSiNiaoBattleMapMO__Edit" == arg_59_1 then
		return
	end

	if arg_59_1 then
		GaoSiNiaoBattleMapMO__Edit.move_ctor(var_59_0, "_mapMO", var_59_0, "_mapMO")
	else
		GaoSiNiaoBattleMapMO.move_ctor(var_59_0, "_mapMO", var_59_0, "_mapMO")
	end
end

local var_0_33 = _G.class("GaoSiNiaoTesting")

function var_0_33.ctor(arg_60_0)
	arg_60_0._client = var_0_32.New()
	arg_60_0._sever = var_0_28.New()

	arg_60_0._sever:link(arg_60_0._client)
	arg_60_0._client:link(arg_60_0._sever)
end

function var_0_33._test(arg_61_0)
	addGlobalModule("modules.logic.gm.gaosiniao.GaoSiNiaoBattleMapMO__Edit", "GaoSiNiaoBattleMapMO__Edit")
	arg_61_0._client:build_test()
	arg_61_0._sever:build_test()
end

function var_0_33._offline_test(arg_62_0)
	local var_62_0 = arg_62_0._client:actId()

	logError(var_62_0)

	if not var_62_0 then
		logError("GaoSiNiaoTesting offline test error: can not found actId")

		return
	end

	local var_62_1 = os.time() * 1000
	local var_62_2 = var_62_1 + 259200
	local var_62_3 = {
		activityInfos = {
			{
				currentStage = 0,
				isUnlock = true,
				online = true,
				isReceiveAllBonus = false,
				isNewStage = false,
				id = var_62_0,
				startTime = var_62_1,
				endTime = var_62_2
			}
		}
	}

	ActivityModel.instance:setActivityInfo(var_62_3)
	var_0_33.instance:_test()

	if not var_0_33.s_fistOpenGm then
		GMController.instance:openGMView()

		var_0_33.s_fistOpenGm = true

		return
	end

	ViewMgr.instance:closeView(ViewName.GMToolView)
	ViewMgr.instance:closeView(ViewName.GMToolView2)

	if not var_0_33.s_V3a1_GaoSiNiao_GameView then
		ViewMgr.instance:openView(ViewName.V3a1_GaoSiNiao_GameView)

		var_0_33.s_V3a1_GaoSiNiao_GameView = true
	else
		var_0_33.s_V3a1_GaoSiNiao_GameView = false

		ViewMgr.instance:closeView(ViewName.V3a1_GaoSiNiao_GameView)
	end
end

function var_0_33.cSwitchMode(arg_63_0, arg_63_1)
	arg_63_0._client:switchMode(arg_63_1 or false)
end

var_0_33.instance = var_0_33.New()

return var_0_33
