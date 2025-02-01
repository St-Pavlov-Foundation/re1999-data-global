module("modules.logic.activitywelfare.config.Activity160Config", package.seeall)

slot0 = class("Activity160Config", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity160_mission"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity160_mission" then
		slot0._missionConfig = slot2
	end
end

function slot0.getActivityMissions(slot0, slot1)
	return slot0._missionConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
