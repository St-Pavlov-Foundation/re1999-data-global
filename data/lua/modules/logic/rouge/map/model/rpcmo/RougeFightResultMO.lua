module("modules.logic.rouge.map.model.rpcmo.RougeFightResultMO", package.seeall)

slot0 = pureTable("RougeFightResultMO")

function slot0.init(slot0, slot1)
	slot0.addCoin = slot1.addCoin
	slot0.dropCollectionNum = slot1.dropCollectionNum
	slot0.dropSelectNum = slot1.dropSelectNum
	slot0.addExp = slot1.addExp
	slot0.isWin = slot1.isWin
	slot0.retryNum = slot1.retryNum
	slot0.season = slot1.season
	slot5 = slot0.retryNum

	RougeModel.instance:updateRetryNum(slot5)

	slot0.battleHeroList = {}

	for slot5, slot6 in ipairs(slot1.teamInfo.battleHeroList) do
		table.insert(slot0.battleHeroList, {
			index = slot6.index,
			heroId = slot6.heroId,
			equipUid = slot6.equipUid,
			supportHeroId = slot6.supportHeroId,
			supportHeroSkill = slot6.supportHeroSkill
		})
	end

	slot0.heroLifeMap = {}

	for slot5, slot6 in ipairs(slot1.teamInfo.heroLifeList) do
		slot0.heroLifeMap[slot6.heroId] = slot6.life
	end
end

function slot0.getLife(slot0, slot1)
	return slot0.heroLifeMap[slot1]
end

return slot0
