module("modules.logic.versionactivity1_6.v1a6_warmup.config.Activity156Config", package.seeall)

slot0 = class("Activity156Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._configTab = nil
	slot0._channelValueList = {}
	slot0._episodeCount = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity125"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity125" then
		slot0._configTab = slot2.configDict[ActivityEnum.Activity.Activity1_6WarmUp]
	end
end

function slot0.getActConfig(slot0, slot1, slot2)
	if slot1 and slot2 and slot0._configTab and slot0._configTab[slot1] then
		return slot0._configTab[slot1][slot2]
	end

	return nil
end

function slot0.getAct156Config(slot0)
	return slot0._configTab
end

function slot0.getEpisodeDesc(slot0, slot1)
	if slot0._configTab and slot0._configTab[slot1] then
		return slot0._configTab[slot1].text
	end
end

function slot0.getEpisodeConfig(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._configTab) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function slot0.getEpisodeOpenDay(slot0, slot1)
	if slot0:getEpisodeConfig(slot1) then
		return slot2.openDay
	end
end

function slot0.getEpisodeRewardConfig(slot0, slot1)
	if slot0._configTab and slot0._configTab and slot0._configTab[slot1] then
		return string.split(slot0._configTab[slot1].bonus, "|")
	end
end

function slot0.getPreEpisodeConfig(slot0, slot1)
	if slot0._configTab and slot0._configTab[slot1] then
		return slot0._configTab[slot0._configTab[slot1].preId]
	end
end

function slot0.getEpisodeCount(slot0, slot1)
	slot2 = slot0._episodeCount or tabletool.len(slot0:getAct156Config(slot1))
	slot0._episodeCount = slot2

	return slot2
end

slot0.instance = slot0.New()

return slot0
