module("modules.logic.activity.config.Activity106Config", package.seeall)

slot0 = class("Activity106Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act106Task = nil
	slot0._act106Order = nil
	slot0._act106MiniGame = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity106_task",
		"activity106_order",
		"activity106_minigame"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity106_task" then
		slot0._act106Task = slot2
	elseif slot1 == "activity106_order" then
		slot0._act106Order = slot2
	elseif slot1 == "activity106_minigame" then
		slot0._act106MiniGame = slot2
	end
end

function slot0.getActivityWarmUpTaskCo(slot0, slot1)
	return slot0._act106Task.configDict[slot1]
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._act106Task.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getActivityWarmUpAllOrderCo(slot0, slot1)
	return slot0._act106Order.configDict[slot1]
end

function slot0.getActivityWarmUpOrderCo(slot0, slot1, slot2)
	return slot0._act106Order.configDict[slot1][slot2]
end

function slot0.getMiniGameSettings(slot0, slot1)
	return slot0._act106MiniGame.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
