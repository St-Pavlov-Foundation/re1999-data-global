module("modules.logic.antique.config.AntiqueConfig", package.seeall)

slot0 = class("AntiqueConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._antiqueConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"antique"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "antique" then
		slot0._antiqueConfig = slot2
	end
end

function slot0.getAntiquesCo(slot0)
	return slot0._antiqueConfig.configDict
end

function slot0.getAntiqueCo(slot0, slot1)
	return slot0._antiqueConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
