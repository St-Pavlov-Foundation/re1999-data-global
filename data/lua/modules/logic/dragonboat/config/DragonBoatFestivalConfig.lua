module("modules.logic.dragonboat.config.DragonBoatFestivalConfig", package.seeall)

slot0 = class("DragonBoatFestivalConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity101_dragonboat"
	}
end

function slot0.onInit(slot0)
	slot0._dragonConfig = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity101_dragonboat" then
		slot0._dragonConfig = slot2
	end
end

function slot0.getDragonBoatCos(slot0)
	return slot0._dragonConfig.configDict[ActivityEnum.Activity.DragonBoatFestival]
end

function slot0.getDragonBoatCo(slot0, slot1)
	return slot0._dragonConfig.configDict[ActivityEnum.Activity.DragonBoatFestival][slot1]
end

slot0.instance = slot0.New()

return slot0
