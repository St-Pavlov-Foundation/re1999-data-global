-- chunkname: @modules/logic/tower/work/TowerEnterWork.lua

module("modules.logic.tower.work.TowerEnterWork", package.seeall)

local TowerEnterWork = class("TowerEnterWork", BaseWork)

function TowerEnterWork:onStart(context)
	TowerRpc.instance:sendGetTowerInfoRequest(self._openMainView, self)
end

function TowerEnterWork:_openMainView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function(_, taskCode, _)
		if taskCode == 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function(_, _, storeCode)
				if storeCode == 0 then
					ViewMgr.instance:openView(ViewName.TowerMainView)
					self:onDone(true)
				end
			end, self)
		end
	end)
end

function TowerEnterWork:clearWork()
	return
end

return TowerEnterWork
