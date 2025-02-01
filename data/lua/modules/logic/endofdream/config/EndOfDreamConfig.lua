module("modules.logic.endofdream.config.EndOfDreamConfig", package.seeall)

slot0 = class("EndOfDreamConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._levelConfig = nil
	slot0._episodeConfig = nil
end

function slot0.reqConfigNames(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getLevelConfig(slot0, slot1)
	return slot0._levelConfig.configDict[slot1]
end

function slot0.getLevelConfigList(slot0)
	return slot0._levelConfig.configList
end

function slot0.getLevelConfigByEpisodeId(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getLevelConfigList()) do
		if slot7.episodeId == slot1 then
			return slot7, false
		elseif slot7.hardEpisodeId == slot1 then
			return slot7, true
		end
	end
end

function slot0.getFirstLevelConfig(slot0)
	return slot0:getLevelConfigList()[1]
end

function slot0.getEpisodeConfig(slot0, slot1)
end

function slot0.getEpisodeConfigByLevelId(slot0, slot1, slot2)
	return slot0:getLevelConfig(slot1) and slot3.hardEpisodeId
end

slot0.instance = slot0.New()

return slot0
