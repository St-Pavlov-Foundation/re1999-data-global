module("modules.logic.sp01.act204.controller.Activity204Controller", package.seeall)

local var_0_0 = class("Activity204Controller", BaseController)

function var_0_0.reInit(arg_1_0)
	arg_1_0:_destroyRpcFlow()
end

function var_0_0.setPlayerPrefs(arg_2_0, arg_2_1, arg_2_2)
	if string.nilorempty(arg_2_1) or not arg_2_2 then
		return
	end

	if type(arg_2_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_2_1, arg_2_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_2_1, arg_2_2)
	end

	arg_2_0:dispatchEvent(Activity204Event.LocalKeyChange)
end

function var_0_0.getPlayerPrefs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2 or ""

	if string.nilorempty(arg_3_1) then
		return var_3_0
	end

	if type(var_3_0) == "number" then
		var_3_0 = GameUtil.playerPrefsGetNumberByUserId(arg_3_1, var_3_0)
	else
		var_3_0 = GameUtil.playerPrefsGetStringByUserId(arg_3_1, var_3_0)
	end

	return var_3_0
end

function var_0_0.getBubbleActIdList(arg_4_0)
	local var_4_0 = Activity204Config.instance:getConstStr(Activity204Enum.ConstId.BubbleActIds)

	return (string.splitToNumber(var_4_0, "#"))
end

function var_0_0.sendRpc2GetMainTaskInfo(arg_5_0, arg_5_1, arg_5_2)
	if ActivityHelper.isOpen(ActivityEnum.Activity.V2a9_Act204) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Activity173
		})
		Activity204Rpc.instance:sendGetAct204InfoRequest(ActivityEnum.Activity.V2a9_Act204, arg_5_1, arg_5_2)
	end
end

function var_0_0.getAllEntranceActInfo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_destroyRpcFlow()

	arg_6_0._rpcFlow = FlowSequence.New()

	local var_6_0 = arg_6_0:getBubbleActIdList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		arg_6_0._rpcFlow:addWork(Activity204RpcWork.New(iter_6_1, Activity101Rpc.sendGet101InfosRequest, Activity101Rpc.instance, iter_6_1))
	end

	arg_6_0._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_AssassinChase, AssassinChaseRpc.sendAct206GetInfoRequest, AssassinChaseRpc.instance, ActivityEnum.Activity.V2a9_AssassinChase))
	arg_6_0._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_LoginSign, Activity101Rpc.sendGet101InfosRequest, Activity101Rpc.instance, ActivityEnum.Activity.V2a9_LoginSign))
	arg_6_0._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_Act204, TaskRpc.sendGetTaskInfoRequest, TaskRpc.instance, {
		TaskEnum.TaskType.Activity173
	}))
	arg_6_0._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_Act204, Activity204Rpc.sendGetAct204InfoRequest, Activity204Rpc.instance, ActivityEnum.Activity.V2a9_Act204))

	if arg_6_1 then
		arg_6_0._rpcFlow:registerDoneListener(arg_6_1, arg_6_2)
	end

	arg_6_0._rpcFlow:start()
end

function var_0_0._destroyRpcFlow(arg_7_0)
	if arg_7_0._rpcFlow then
		arg_7_0._rpcFlow:destroy()

		arg_7_0._rpcFlow = nil
	end
end

function var_0_0.jumpToActivity(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_1 then
		logError("jump failed !!! activityId is nil")

		return
	end

	local var_8_0, var_8_1, var_8_2 = ActivityHelper.getActivityStatusAndToast(arg_8_1)

	if var_8_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_8_1 then
			GameFacade.showToastWithTableParam(var_8_1, var_8_2)
		end

		return
	end

	local var_8_3 = var_0_0.jumpHandleFunc[arg_8_1]

	if not var_8_3 then
		logError("jump failed !!! jump handle function is nil")

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.Activity204EntranceView) then
		local var_8_4 = ActivityEnum.Activity.V2a9_ActCollection
		local var_8_5 = var_0_0.jumpHandleFunc[var_8_4]

		if var_8_5 then
			local var_8_6 = {
				actId = var_8_4,
				entranceIds = Activity204Enum.EntranceIdList
			}

			var_8_5(arg_8_0, var_8_4, var_8_6, function()
				var_8_3(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
			end)

			return
		end
	end

	var_8_3(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
end

function var_0_0.jumpTo_130517(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0:getAllEntranceActInfo(function()
		ViewMgr.instance:openView(ViewName.Activity204EntranceView, arg_10_2)

		if arg_10_3 then
			arg_10_3(arg_10_4)
		end
	end)
end

function var_0_0.jumpTo_130518(arg_12_0, arg_12_1)
	var_0_0.instance:sendRpc2GetMainTaskInfo(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Activity204TaskView, {
			actId = arg_12_1
		})
	end)
end

function var_0_0.jumpTo_130519(arg_14_0, arg_14_1)
	Act205Controller.instance:openGameStartView(arg_14_1)
end

function var_0_0.jumpTo_130521(arg_15_0, arg_15_1)
	Activity101Rpc.instance:sendGet101InfosRequest(arg_15_1, function(arg_16_0, arg_16_1)
		if arg_16_1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.V2a9_LoginSign_FullView, {
			actId = arg_15_1
		})
	end)
end

function var_0_0.jumpTo_130520(arg_17_0)
	AssassinChaseController.instance:openGameStartView(ActivityEnum.Activity.V2a9_AssassinChase)
end

var_0_0.jumpHandleFunc = {
	[ActivityEnum.Activity.V2a9_ActCollection] = var_0_0.jumpTo_130517,
	[ActivityEnum.Activity.V2a9_Act204] = var_0_0.jumpTo_130518,
	[ActivityEnum.Activity.V2a9_Act205] = var_0_0.jumpTo_130519,
	[ActivityEnum.Activity.V2a9_AssassinChase] = var_0_0.jumpTo_130520,
	[ActivityEnum.Activity.V2a9_LoginSign] = var_0_0.jumpTo_130521
}

function var_0_0.checkCanGetReward_130518(arg_18_0, arg_18_1)
	local var_18_0 = Activity204Model.instance:getActMo(arg_18_1)

	return var_18_0 and var_18_0:hasActivityReward()
end

function var_0_0.checkCanGetReward_130520(arg_19_0, arg_19_1)
	return AssassinChaseModel.instance:isActHaveReward(arg_19_1)
end

function var_0_0.checkCanGetReward_130521(arg_20_0, arg_20_1)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(arg_20_1)
end

function var_0_0.checkCanGetReward_130524(arg_21_0)
	local var_21_0 = arg_21_0:getBubbleActIdList()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if ActivityType101Model.instance:isType101RewardCouldGetAnyOne(iter_21_1) then
			return true
		end
	end
end

var_0_0.checkCanGetRewardFunc = {
	[ActivityEnum.Activity.V2a9_Act204] = var_0_0.checkCanGetReward_130518,
	[ActivityEnum.Activity.V2a9_AssassinChase] = var_0_0.checkCanGetReward_130520,
	[ActivityEnum.Activity.V2a9_LoginSign] = var_0_0.checkCanGetReward_130521,
	[ActivityEnum.Activity.V2a9_Bubble] = var_0_0.checkCanGetReward_130524
}

function var_0_0.isAnyActCanGetReward(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(var_0_0.checkCanGetRewardFunc) do
		if iter_22_1(arg_22_0, iter_22_0) then
			return true
		end
	end
end

function var_0_0.checkOceanNewOpenRedDot(arg_23_0)
	local var_23_0 = Act205Model.instance:isGameTimeOpen(Act205Enum.GameStageId.Ocean) and var_0_0.instance:getPlayerPrefs(PlayerPrefsKey.Activity204OceanOpenReddot, 0) == 0 and 1 or 0
	local var_23_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.V2a9_Act205OceanOpen,
			value = var_23_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_23_1, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
