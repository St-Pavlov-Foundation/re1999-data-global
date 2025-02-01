module("modules.logic.versionactivity1_5.sportsnews.model.SportsNewsModel", package.seeall)

slot0 = class("SportsNewsModel", BaseModel)

function slot0.finishOrder(slot0, slot1, slot2)
	Activity106Rpc.instance:sendGet106OrderBonusRequest(slot1, slot2, 1, function ()
		ActivityWarmUpController.instance:dispatchEvent(ActivityWarmUpEvent.PlayOrderFinish, {
			actId = uv0,
			orderId = uv1
		})
	end, slot0)
end

function slot0.onReadEnd(slot0, slot1, slot2)
	SportsNewsRpc.instance:sendFinishReadTaskRequest(slot1, slot2)
	slot0:finishOrder(slot1, slot2)
end

function slot0.getSelectedDayTask(slot0, slot1)
	return ActivityWarmUpTaskListModel.instance._taskGroup and ActivityWarmUpTaskListModel.instance._taskGroup[slot1]
end

function slot0.getJumpToTab(slot0, slot1)
	if not slot0._JumpOrderId then
		return nil
	end

	return uv0.instance:getDayByOrderId(slot1, slot2)
end

function slot0.setJumpToOrderId(slot0, slot1)
	slot0._JumpOrderId = slot1
end

function slot0.getDayByOrderId(slot0, slot1, slot2)
	return Activity106Config.instance:getActivityWarmUpOrderCo(slot1, slot2) and slot3.openDay
end

function slot0.getPrefs(slot0, slot1)
	return PlayerPrefsHelper.getNumber(slot0:getPrefsKey(slot1), 0)
end

function slot0.setPrefs(slot0, slot1)
	PlayerPrefsHelper.setNumber(slot0:getPrefsKey(slot1), 1)
end

function slot0.getPrefsKey(slot0, slot1)
	return string.format("%s#%s#%s", VersionActivity1_5Enum.ActivityId.SportsNews, PlayerModel.instance:getPlayinfo().userId, slot1)
end

function slot0.hasCanFinishOrder(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(ActivityWarmUpModel.instance:getAllOrders()) do
		slot8 = false

		if slot7.cfg.listenerType == "ReadTask" then
			if slot7.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
				slot8 = true
			end
		elseif slot7.status == ActivityWarmUpEnum.OrderStatus.Collected then
			slot8 = true
		end

		if slot8 then
			slot10 = {
				slot7.id
			}

			if not slot1[slot7.cfg.openDay] then
				slot1[slot9] = {}
			end

			table.insert(slot1[slot9], slot10)
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
