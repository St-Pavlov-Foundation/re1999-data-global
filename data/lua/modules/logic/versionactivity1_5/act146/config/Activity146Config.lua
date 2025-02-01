module("modules.logic.versionactivity1_5.act146.config.Activity146Config", package.seeall)

slot0 = class("Activity146Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._configList = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity146"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity146" then
		slot0._configList = slot2.configDict
	end
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	return slot0._configList[slot1][slot2]
end

function slot0.getAllEpisodeConfigs(slot0, slot1)
	return slot0._configList and slot0._configList[slot1]
end

function slot0.getEpisodeRewardConfig(slot0, slot1, slot2)
	if slot0._configList and slot0._configList[slot1] and slot0._configList[slot1][slot2] then
		return string.split(slot0._configList[slot1][slot2].bonus, "|")
	end
end

function slot0.getEpisodeDesc(slot0, slot1, slot2)
	if slot0._configList and slot0._configList[slot1] and slot0._configList[slot1][slot2] then
		return slot0._configList[slot1][slot2].text
	end
end

function slot0.getEpisodeTitle(slot0, slot1, slot2)
	if slot0._configList and slot0._configList[slot1] and slot0._configList[slot1][slot2] then
		return slot0._configList[slot1][slot2].name
	end
end

function slot0.getPreEpisodeConfig(slot0, slot1, slot2)
	if slot0._configList and slot0._configList[slot1] and slot0._configList[slot1][slot2] then
		return slot0._configList[slot1][slot0._configList[slot1][slot2].preId]
	end
end

function slot0.getEpisodePhoto(slot0, slot1, slot2)
	if slot0._configList and slot0._configList[slot1] and slot0._configList[slot1][slot2] then
		return slot0._configList[slot1][slot2].photo
	end
end

function slot0.getEpisodeInteractType(slot0, slot1, slot2)
	if slot0._configList and slot0._configList[slot1] and slot0._configList[slot1][slot2] then
		return slot0._configList[slot1][slot2].interactType or 1
	end
end

slot0.instance = slot0.New()

return slot0
