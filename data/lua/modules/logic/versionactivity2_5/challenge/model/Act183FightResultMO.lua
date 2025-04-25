module("modules.logic.versionactivity2_5.challenge.model.Act183FightResultMO", package.seeall)

slot0 = pureTable("Act183FightResultMO")

function slot0.init(slot0, slot1)
	slot0._episodeId = slot1.episodeId
	slot0._heroes = Act183Helper.rpcInfosToList(slot1.heroes, Act183HeroMO)
	slot0._unlockConditions = {}

	tabletool.addValues(slot0._unlockConditions, slot1.unlockConditions)
end

function slot0.getHeroes(slot0)
	return slot0._heroes
end

function slot0.isConditionPass(slot0, slot1)
	if slot0._unlockConditions then
		return tabletool.indexOf(slot0._unlockConditions, slot1) ~= nil
	end
end

return slot0
