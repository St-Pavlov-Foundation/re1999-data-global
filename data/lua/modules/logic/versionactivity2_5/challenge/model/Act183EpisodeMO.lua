module("modules.logic.versionactivity2_5.challenge.model.Act183EpisodeMO", package.seeall)

slot0 = pureTable("Act183EpisodeMO")

function slot0.init(slot0, slot1)
	slot0._episodeId = slot1.episodeId
	slot0._isPass = tonumber(slot1.status) == 1
	slot0._passOrder = slot1.passOrder or 0
	slot0._heroes = Act183Helper.rpcInfosToList(slot1.heroes, Act183HeroMO)
	slot0._useBadgeNum = slot1.useBadgeNum
	slot0._unlockConditions = {}

	tabletool.addValues(slot0._unlockConditions, slot1.unlockConditions)

	slot0._chooseConditions = {}

	tabletool.addValues(slot0._chooseConditions, slot1.chooseConditions)

	slot0._repress = Act183RepressMO.New()

	slot0._repress:init(slot1.repress)

	slot0._config = Act183Config.instance:getEpisodeCo(slot0._episodeId)
	slot0._groupId = slot0._config and slot0._config.groupId
	slot0._params = slot1.params

	slot0:_buildEscapeRules()
end

function slot0._buildEscapeRules(slot0)
	slot2 = slot0._config and slot0._config.ruleDesc2
	slot0._escapeRules = {}

	if slot0._repress:getRuleIndex() ~= 1 then
		table.insert(slot0._escapeRules, slot0._config and slot0._config.ruleDesc1)
	end

	if slot3 ~= 2 then
		table.insert(slot0._escapeRules, slot2)
	end
end

function slot0.getEpisodeId(slot0)
	return slot0._episodeId
end

function slot0.getStatus(slot0)
	if slot0._isPass then
		return Act183Enum.EpisodeStatus.Finished
	end

	if slot0:getPreEpisodeIds() then
		for slot5, slot6 in ipairs(slot1) do
			if Act183Model.instance:getEpisodeMo(slot0._groupId, slot6) then
				if not slot7:isFinished() then
					return Act183Enum.EpisodeStatus.Locked
				end
			else
				logError(string.format("前置关卡不存在 curEpisodeId = %s, preEpisodeId = %s", slot0._episodeId, slot6))
			end
		end
	end

	return Act183Enum.EpisodeStatus.Unlocked
end

function slot0.getPreEpisodeIds(slot0)
	if slot0._config and not string.nilorempty(slot0._config.preEpisodeIds) then
		return string.splitToNumber(slot0._config.preEpisodeIds, "#")
	end
end

function slot0.isLocked(slot0)
	return slot0:getStatus() == Act183Enum.EpisodeStatus.Locked
end

function slot0.isFinished(slot0)
	return slot0:getStatus() == Act183Enum.EpisodeStatus.Finished
end

function slot0.getPassConditions(slot0)
	return slot0._unlockConditions
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.getEpisodeType(slot0)
	return Act183Helper.getEpisodeType(slot0._episodeId)
end

function slot0.getGroupType(slot0)
	return slot0._config and slot0._config.type
end

function slot0.getRepressMo(slot0)
	return slot0._repress
end

function slot0.updateRepressMo(slot0, slot1)
	if not slot0._repress then
		slot0._repress = Act183RepressMO.New()
	end

	slot0._repress:init(slot1)
	slot0:_buildEscapeRules()
end

function slot0.getRuleStatus(slot0, slot1)
	if slot0:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
		return Act183Enum.RuleStatus.Enabled
	end

	if slot0._repress:getRuleIndex() == slot1 then
		return Act183Enum.RuleStatus.Repress
	end

	return Act183Enum.RuleStatus.Escape
end

function slot0.getPassOrder(slot0)
	return slot0._passOrder
end

function slot0.getConfigOrder(slot0)
	return slot0._config.order
end

function slot0.getConditionIds(slot0)
	if slot0._config then
		return string.splitToNumber(slot0._config.condition, "#")
	end
end

function slot0.isConditionPass(slot0, slot1)
	if slot0._unlockConditions then
		return tabletool.indexOf(slot0._unlockConditions, slot1) ~= nil
	end
end

function slot0.isAllConditionPass(slot0)
	if slot0:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
		return false
	end

	for slot6, slot7 in ipairs(string.splitToNumber(slot0._config.condition, "#")) do
		if not slot0:isConditionPass(slot7) then
			return false
		end
	end

	return true
end

function slot0.getEscapeRules(slot0)
	return slot0._escapeRules
end

function slot0.getUseBadgeNum(slot0)
	return slot0._useBadgeNum
end

function slot0.getHeroes(slot0)
	return slot0._heroes
end

function slot0.getRepressHeroMo(slot0)
	if slot0._repress:hasRepress() then
		return slot0._heroes[slot0._repress:getHeroIndex()]
	end
end

function slot0.isHeroRepress(slot0, slot1)
	if slot0:getRepressHeroMo() then
		return slot2:getHeroId() == slot1
	end
end

function slot0.setSelectConditions(slot0, slot1)
	slot0._selectConditionIds = slot1
end

function slot0.getGroupId(slot0)
	return slot0._groupId
end

return slot0
