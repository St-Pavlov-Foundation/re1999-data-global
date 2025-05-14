module("modules.logic.versionactivity1_9.dungeon.controller.VersionActivity1_9DungeonController", package.seeall)

local var_0_0 = class("VersionActivity1_9DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.Dungeon)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_1 then
			GameFacade.showToast(var_3_1, var_3_2)
		end

		return
	end

	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.Dungeon
	})

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_7) then
		local var_3_3 = true

		DungeonController.instance:enterDungeonView(true, var_3_3)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_7))
	end
end

function var_0_0.openStoreView(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.DungeonStore)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_4_1 then
			GameFacade.showToast(var_4_1, var_4_2)
		end

		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_9Enum.ActivityId.DungeonStore, arg_4_0._openStoreView, arg_4_0)
end

function var_0_0._openStoreView(arg_5_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_9StoreView)
end

function var_0_0.openTaskView(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.Dungeon)

	if var_6_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_6_1 then
			GameFacade.showToast(var_6_1, var_6_2)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_9TaskView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
