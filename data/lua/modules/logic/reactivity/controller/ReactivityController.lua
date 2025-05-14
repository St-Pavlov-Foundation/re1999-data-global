module("modules.logic.reactivity.controller.ReactivityController", package.seeall)

local var_0_0 = class("ReactivityController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.openReactivityTaskView(arg_3_0, arg_3_1)
	arg_3_0:_enterActivityView(ViewName.ReactivityTaskView, arg_3_1, arg_3_0._openTaskView, arg_3_0)
end

function var_0_0._openTaskView(arg_4_0, arg_4_1, arg_4_2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(arg_4_1, {
			actId = arg_4_2
		})
	end)
end

function var_0_0.getCurReactivityId(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(ReactivityEnum.ActivityDefine) do
		local var_6_0 = ActivityHelper.getActivityStatus(iter_6_0)
		local var_6_1 = ActivityHelper.getActivityStatus(iter_6_1.storeActId)

		if var_6_0 == ActivityEnum.ActivityStatus.Normal or var_6_0 == ActivityEnum.ActivityStatus.NotUnlock or var_6_1 == ActivityEnum.ActivityStatus.Normal then
			return iter_6_0
		end
	end
end

function var_0_0.openReactivityStoreView(arg_7_0, arg_7_1)
	local var_7_0 = ReactivityEnum.ActivityDefine[arg_7_1]

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.storeActId

	arg_7_0:_enterActivityView(ViewName.ReactivityStoreView, var_7_1, arg_7_0._openStoreView, arg_7_0)
end

function var_0_0._openStoreView(arg_8_0, arg_8_1, arg_8_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_8_2, function()
		ViewMgr.instance:openView(arg_8_1, {
			actId = arg_8_2
		})
	end)
end

function var_0_0._enterActivityView(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0, var_10_1, var_10_2 = ActivityHelper.getActivityStatusAndToast(arg_10_2)

	if var_10_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_10_1 then
			GameFacade.showToastWithTableParam(var_10_1, var_10_2)
		end

		return
	end

	if arg_10_3 then
		arg_10_3(arg_10_4, arg_10_1, arg_10_2, arg_10_5)

		return
	end

	local var_10_3 = {
		actId = arg_10_2
	}

	if arg_10_5 then
		for iter_10_0, iter_10_1 in pairs(arg_10_5) do
			var_10_3[iter_10_0] = iter_10_1
		end
	end

	ViewMgr.instance:openView(arg_10_1, var_10_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
