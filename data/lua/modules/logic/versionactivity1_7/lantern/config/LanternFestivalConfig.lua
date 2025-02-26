module("modules.logic.versionactivity1_7.lantern.config.LanternFestivalConfig", package.seeall)

slot0 = class("LanternFestivalConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity154",
		"activity154_options"
	}
end

function slot0.onInit(slot0)
	slot0._actCfgDict = nil
	slot0._actOptions = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity154" then
		slot0._actCfgDict = slot2.configDict
	elseif slot1 == "activity154_options" then
		slot0._actOptions = slot2.configDict
	end
end

function slot0.getAct154Co(slot0, slot1, slot2)
	return slot0._actCfgDict[slot1 or ActivityEnum.Activity.LanternFestival][slot2]
end

function slot0.getPuzzleCo(slot0, slot1)
	for slot5, slot6 in pairs(slot0._actCfgDict[ActivityEnum.Activity.LanternFestival]) do
		if slot6.puzzleId == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.getAct154Cos(slot0)
	return slot0._actCfgDict[ActivityEnum.Activity.LanternFestival]
end

function slot0.getAct154Options(slot0, slot1)
	return slot0._actOptions[slot1]
end

slot0.instance = slot0.New()

return slot0
