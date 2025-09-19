module("modules.logic.versionactivity2_8.dungeontaskstore.controller.VersionActivity2_8DungeonTaskStoreController", package.seeall)

local var_0_0 = class("VersionActivity2_8DungeonTaskStoreController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(arg_3_1)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_1 then
			GameFacade.showToast(var_3_1, var_3_2)
		end

		return
	end

	local var_3_3, var_3_4, var_3_5 = ActivityHelper.getActivityStatusAndToast(arg_3_2)

	if var_3_3 == ActivityEnum.ActivityStatus.Normal then
		ActivityEnterMgr.instance:enterActivity(arg_3_2)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			arg_3_2
		})
	end

	if DungeonModel.instance:chapterIsLock(arg_3_3) then
		local var_3_6 = true

		DungeonController.instance:enterDungeonView(true, var_3_6)
	else
		JumpController.instance:jumpTo("3#" .. tostring(arg_3_3))
	end
end

function var_0_0.getModuleConfig(arg_4_0)
	return arg_4_0._moduleConfig
end

function var_0_0.openTaskView(arg_5_0, arg_5_1)
	arg_5_0._moduleConfig = arg_5_1
	module_views.VersionActivity2_8TaskView.mainRes = arg_5_0._moduleConfig.TaskViewRes
	module_views.VersionActivity2_8TaskView.otherRes[1] = arg_5_0._moduleConfig.TaskItemRes

	local var_5_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_5_0, arg_5_0._openTaskViewAfterRpc, arg_5_0)
end

function var_0_0._openTaskViewAfterRpc(arg_6_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8TaskView)
end

function var_0_0.openStoreView(arg_7_0, arg_7_1)
	arg_7_0._moduleConfig = arg_7_1
	module_views.VersionActivity2_8StoreView.mainRes = arg_7_0._moduleConfig.StoreViewRes

	local var_7_0 = var_0_0.instance:getModuleConfig().DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_7_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_7_0, arg_7_0._openStoreViewAfterRpc, arg_7_0)
end

function var_0_0._openStoreViewAfterRpc(arg_8_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8StoreView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
