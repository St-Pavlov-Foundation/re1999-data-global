module("modules.logic.versionactivity2_5.challenge.view.Act183TaskOneKeyItem", package.seeall)

slot0 = class("Act183TaskOneKeyItem", Act183TaskBaseItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.go, "#btn_getall")
	slot0._txtdesc = gohelper.findChildText(slot0.go, "txt_desc")
end

function slot0.addEventListeners(slot0)
	uv0.super.addEventListeners(slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	uv0.super.removeEventListeners(slot0)
	slot0._btngetall:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	uv0.super.onUpdateMO(slot0, slot1, slot2, slot3)

	slot0._canGetRewardTasks = slot1.data
end

function slot0._btngetallOnClick(slot0)
	if not slot0._canGetRewardTasks or #slot0._canGetRewardTasks <= 0 then
		return
	end

	slot0:setBlock(true)

	slot4 = slot0._sendRpcToFinishTask
	slot5 = slot0

	slot0._animatorPlayer:Play("finish", slot4, slot5)

	slot0._canGetRewardTaskIds = {}

	for slot4, slot5 in ipairs(slot0._canGetRewardTasks) do
		table.insert(slot0._canGetRewardTaskIds, slot5.id)
		Act183Controller.instance:dispatchEvent(Act183Event.ClickToGetReward, slot5.id)
	end
end

function slot0._sendRpcToFinishTask(slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity183, 0, slot0._canGetRewardTaskIds, function (slot0, slot1)
		if slot1 ~= 0 then
			return
		end

		Act183Helper.showToastWhileCanTaskRewards(uv0._canGetRewardTaskIds)
	end, nil, Act183Model.instance:getActivityId())
	slot0:setBlock(false)
end

return slot0
