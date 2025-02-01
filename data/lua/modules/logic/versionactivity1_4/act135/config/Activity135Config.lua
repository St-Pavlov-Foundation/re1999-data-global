module("modules.logic.versionactivity1_4.act135.config.Activity135Config", package.seeall)

slot0 = class("Activity135Config", BaseConfig)

function slot0.ctor(slot0)
	slot0.rewardDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity135_reward"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("on%sConfigLoaded", slot1)] then
		slot4(slot0, slot1, slot2)
	end
end

function slot0.onactivity135_rewardConfigLoaded(slot0, slot1, slot2)
	slot0.rewardDict = slot2.configDict
end

function slot0.getEpisodeCos(slot0, slot1)
	return slot0.rewardDict[slot1]
end

slot0.instance = slot0.New()

return slot0
