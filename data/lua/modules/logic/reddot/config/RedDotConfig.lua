module("modules.logic.reddot.config.RedDotConfig", package.seeall)

slot0 = class("RedDotConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._dotConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"reddot"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "reddot" then
		slot0._dotConfig = slot2
	end
end

function slot0.getRedDotsCO(slot0)
	return slot0._dotConfig.configDict
end

function slot0.getRedDotCO(slot0, slot1)
	return slot0._dotConfig.configDict[slot1]
end

function slot0.getParentRedDotId(slot0, slot1)
	return slot0:getRedDotCO(slot1) and slot2.parent or 0
end

slot0.instance = slot0.New()

return slot0
