module("modules.logic.tower.work.TowerEnterWork", package.seeall)

slot0 = class("TowerEnterWork", BaseWork)

function slot0.onStart(slot0, slot1)
	TowerRpc.instance:sendGetTowerInfoRequest(slot0._openMainView, slot0)
end

function slot0._openMainView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function (slot0, slot1, slot2)
		if slot1 == 0 then
			ViewMgr.instance:openView(ViewName.TowerMainView)
			uv0:onDone(true)
		end
	end)
end

function slot0.clearWork(slot0)
end

return slot0
