module("modules.logic.versionactivity2_5.challenge.model.Act183EpisodeRecordMO", package.seeall)

slot0 = pureTable("Act183EpisodeRecordMO")

function slot0.init(slot0, slot1)
	slot0._episodeId = slot1.episodeId
	slot0._passOrder = slot1.passOrder
	slot0._heroes = Act183Helper.rpcInfosToList(slot1.heroes, Act183HeroMO)
	slot0._useBadgeNum = slot1.useBadgeNum
	slot0._passConditions = {}

	tabletool.addValues(slot0._passConditions, slot1.unlockConditions)

	slot0._chooseConditions = {}

	tabletool.addValues(slot0._chooseConditions, slot1.chooseConditions)

	slot0._repress = Act183RepressMO.New()

	slot0._repress:init(slot1.repress)

	slot0._config = Act183Config.instance:getEpisodeCo(slot0._episodeId)
	slot0._params = slot1.params
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.getEpisodeId(slot0)
	return slot0._episodeId
end

function slot0.getPassOrder(slot0)
	return slot0._passOrder
end

function slot0.getUseBadgeNum(slot0)
	return slot0._useBadgeNum
end

function slot0.getHeroMos(slot0)
	return slot0._heroes
end

function slot0.getEpisodeType(slot0)
	return Act183Helper.getEpisodeType(slot0._episodeId)
end

function slot0.getGroupType(slot0)
	return slot0._config and slot0._config.type
end

function slot0.getConditionIds(slot0)
	if slot0._config then
		return string.splitToNumber(slot0._config.condition, "#")
	end
end

function slot0.getPassConditions(slot0)
	return slot0._passConditions
end

function slot0.getChooseConditions(slot0)
	return slot0._chooseConditions
end

function slot0.isConditionPass(slot0, slot1)
	if slot0._passConditions then
		return tabletool.indexOf(slot0._passConditions, slot1) ~= nil
	end
end

function slot0.getAllConditions(slot0)
	return string.splitToNumber(slot0._config.condition, "#")
end

function slot0.isAllConditionPass(slot0)
	for slot5, slot6 in ipairs(slot0:getAllConditions()) do
		if not slot0:isConditionPass(slot6) then
			return false
		end
	end

	return true
end

function slot0.getRuleStatus(slot0, slot1)
	if slot0._repress:getRuleIndex() == slot1 then
		return Act183Enum.RuleStatus.Repress
	end

	return Act183Enum.RuleStatus.Escape
end

return slot0
