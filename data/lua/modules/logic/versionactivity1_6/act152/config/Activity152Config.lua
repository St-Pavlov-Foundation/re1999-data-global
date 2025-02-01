module("modules.logic.versionactivity1_6.act152.config.Activity152Config", package.seeall)

slot0 = class("Activity152Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._activityConfig = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity152"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity152" then
		slot0._activityConfig = slot2.configDict
	end
end

function slot0.getAct152Co(slot0, slot1)
	return slot0._activityConfig[ActivityEnum.Activity.NewYearEve][slot1]
end

function slot0.getAct152Cos(slot0)
	return slot0._activityConfig[ActivityEnum.Activity.NewYearEve]
end

slot0.instance = slot0.New()

return slot0
