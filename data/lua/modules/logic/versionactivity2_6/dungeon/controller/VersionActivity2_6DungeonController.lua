module("modules.logic.versionactivity2_6.dungeon.controller.VersionActivity2_6DungeonController", package.seeall)

local var_0_0 = class("VersionActivity2_6DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.EnterView)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_1 then
			GameFacade.showToast(var_3_1, var_3_2)
		end

		return
	end

	local var_3_3, var_3_4, var_3_5 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.Dungeon)

	if var_3_3 == ActivityEnum.ActivityStatus.Normal then
		ActivityEnterMgr.instance:enterActivity(VersionActivity2_6Enum.ActivityId.Dungeon)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			VersionActivity2_6Enum.ActivityId.Dungeon
		})
	end

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_9) then
		local var_3_6 = true

		DungeonController.instance:enterDungeonView(true, var_3_6)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_9))
	end
end

function var_0_0.openTaskView(arg_4_0)
	local var_4_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_4_0, arg_4_0._openTaskViewAfterRpc, arg_4_0)
end

function var_0_0._openTaskViewAfterRpc(arg_5_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_6TaskView)
end

function var_0_0.openStoreView(arg_6_0)
	local var_6_0 = VersionActivity2_6Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_6_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_6_0, arg_6_0._openStoreViewAfterRpc, arg_6_0)
end

function var_0_0._openStoreViewAfterRpc(arg_7_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_6StoreView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
