module("modules.logic.permanent.config.PermanentConfig", package.seeall)

slot0 = class("PermanentConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"permanent"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "permanent" then
		slot0._permanentConfig = slot2
	end
end

function slot0.getKvIconName(slot0, slot1)
	return slot0:getPermanentCO(slot1).kvIcon
end

function slot0.getPermanentDic(slot0)
	return slot0._permanentConfig.configDict
end

function slot0.getPermanentCO(slot0, slot1)
	if not slot0._permanentConfig.configDict[slot1] then
		logError("config permanent no activityId" .. slot1)
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
