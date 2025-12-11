module("modules.logic.versionactivity3_1.towerdeep.controller.TowerDeepOperActController", package.seeall)

local var_0_0 = class("TowerDeepOperActController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0.dailyRefresh, arg_4_0)
end

function var_0_0.dailyRefresh(arg_5_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity3_1Enum.ActivityId.TowerDeep) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerDeep
	})
end

function var_0_0.openTowerPanelView(arg_6_0)
	ViewMgr.instance:openView(ViewName.TowerDeepOperActPanelView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
