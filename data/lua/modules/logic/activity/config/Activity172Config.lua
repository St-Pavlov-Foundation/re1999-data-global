module("modules.logic.activity.config.Activity172Config", package.seeall)

slot0 = class("Activity172Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act172Task = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity172_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity172_task" then
		slot0._act172Task = slot2
	end
end

function slot0.getAct172TaskById(slot0, slot1)
	return slot0._act172Task.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
