module("modules.logic.tower.work.TowerEnterWork", package.seeall)

local var_0_0 = class("TowerEnterWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	TowerRpc.instance:sendGetTowerInfoRequest(arg_1_0._openMainView, arg_1_0)
end

function var_0_0._openMainView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_1 == 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function(arg_4_0, arg_4_1, arg_4_2)
				if arg_4_2 == 0 then
					ViewMgr.instance:openView(ViewName.TowerMainView)
					arg_2_0:onDone(true)
				end
			end, arg_2_0)
		end
	end)
end

function var_0_0.clearWork(arg_5_0)
	return
end

return var_0_0
