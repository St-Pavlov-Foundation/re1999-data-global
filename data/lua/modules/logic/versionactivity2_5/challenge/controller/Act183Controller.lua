module("modules.logic.versionactivity2_5.challenge.controller.Act183Controller", package.seeall)

local var_0_0 = class("Act183Controller", BaseController)

function var_0_0.openAct183MainView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Act183Model.instance:getActivityId()

	if not var_1_0 then
		logError("挑战玩法活动id为空!!!先设置活动id再请求数据")

		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity183
	}, function()
		return
	end)
	Activity183Rpc.instance:sendAct183GetInfoRequest(var_1_0, function(arg_3_0, arg_3_1)
		if arg_3_1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Act183MainView, arg_1_1)

		if arg_1_2 then
			arg_1_2(arg_1_3)
		end
	end)
end

function var_0_0.openAct183DungeonView(arg_4_0, arg_4_1)
	ViewMgr.instance:openView(ViewName.Act183DungeonView, arg_4_1)
end

function var_0_0.openAct183TaskView(arg_5_0, arg_5_1)
	local var_5_0 = Act183Model.instance:getActivityId()
	local var_5_1 = ActivityHelper.getActivityStatus(var_5_0)

	if not Act183Model.instance:isInitDone() and var_5_1 == ActivityEnum.ActivityStatus.Normal then
		Activity183Rpc.instance:sendAct183GetInfoRequest(var_5_0)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity183
	}, function()
		ViewMgr.instance:openView(ViewName.Act183TaskView, arg_5_1)
	end)
end

function var_0_0.openAct183BadgeView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.Act183BadgeView, arg_7_1)
end

function var_0_0.openAct183ReportView(arg_8_0, arg_8_1)
	local var_8_0 = Act183Model.instance:getActivityId()

	Activity183Rpc.instance:sendAct183GetRecordRequest(var_8_0, function(arg_9_0, arg_9_1)
		if arg_9_1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Act183ReportView, arg_8_1)
	end)
end

function var_0_0.openAct183FinishView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.Act183FinishView, arg_10_1)
end

function var_0_0.openAct183SettlementView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.Act183SettlementView, arg_11_1)
end

function var_0_0.openAct183RepressView(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.Act183RepressView, arg_12_1)
end

function var_0_0.resetGroupEpisode(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 and arg_13_1 ~= 0 and arg_13_2 and arg_13_2 ~= 0 then
		arg_13_0:_clearGroupEpisodeRefreshAnimRecord(arg_13_2)
		Activity183Rpc.instance:sendAct183ResetGroupRequest(arg_13_1, arg_13_2)
	end
end

function var_0_0.updateResetGroupEpisodeInfo(arg_14_0, arg_14_1, arg_14_2)
	Act183Model.instance:getActInfo():updateGroupMo(arg_14_2)
	arg_14_0:dispatchEvent(Act183Event.OnUpdateGroupInfo)
end

function var_0_0.resetEpisode(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_2 then
		return
	end

	local var_15_0 = Act183Model.instance:getEpisodeMoById(arg_15_2)
	local var_15_1 = var_15_0 and var_15_0:getGroupId()

	arg_15_0:_clearGroupEpisodeRefreshAnimRecord(var_15_1)
	Activity183Rpc.instance:sendAct183ResetEpisodeRequest(arg_15_1, arg_15_2)
end

function var_0_0._clearGroupEpisodeRefreshAnimRecord(arg_16_0, arg_16_1)
	local var_16_0 = Act183Model.instance:getGroupEpisodeMo(arg_16_1)
	local var_16_1 = var_16_0 and var_16_0:getEpisodeListByPassOrder()
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1 or {}) do
		Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(iter_16_1:getEpisodeId(), var_16_2)
	end
end

function var_0_0.updateResetEpisodeInfo(arg_17_0, arg_17_1)
	Act183Model.instance:getActInfo():updateGroupMo(arg_17_1)
	arg_17_0:dispatchEvent(Act183Event.OnUpdateGroupInfo)
end

function var_0_0.tryChooseRepress(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	Activity183Rpc.instance:sendAct183ChooseRepressRequest(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
end

function var_0_0.updateChooseRepressInfo(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = Act183Model.instance:getActInfo()

	if not var_19_0 then
		return
	end

	local var_19_1 = Act183Config.instance:getEpisodeCo(arg_19_1)
	local var_19_2 = var_19_0:getGroupEpisodeMo(var_19_1.groupId):getEpisodeMo(arg_19_1)

	var_19_2:updateRepressMo(arg_19_2)
	Act183Model.instance:recordLastRepressEpisodeId(arg_19_1)
	var_0_0.instance:dispatchEvent(Act183Event.OnUpdateRepressInfo, arg_19_1, var_19_2)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
