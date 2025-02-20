module("modules.logic.dungeon.model.DungeonAssistHeroMO", package.seeall)

slot0 = pureTable("DungeonAssistHeroMO")

function slot0.init(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return false
	end

	slot0.assistType = slot1
	slot0.heroUid = slot2.heroUid
	slot0.userId = slot2.userId
	slot0.name = slot2.name
	slot0.userLevel = slot2.userLevel
	slot0.portrait = slot2.portrait
	slot0.bg = slot2.bg
	slot0.isFriend = slot2.isFriend
	slot0.heroId = slot2.heroId
	slot0.level = slot2.level
	slot0.rank = slot2.rank
	slot0.skin = slot2.skin
	slot0.passiveSkillLevel = slot2.passiveSkillLevel
	slot0.exSkillLevel = slot2.exSkillLevel
	slot0.talent = slot2.talent
	slot0.balanceLevel = slot2.balanceLevel
	slot0.isOpenTalent = slot2.isOpenTalent
	slot0.style = slot2.style
	slot0.originalTalentCubeInfos = nil

	if slot2.talentCubeInfos then
		slot0.talentCubeInfos = HeroTalentCubeInfosMO.New()

		slot0.talentCubeInfos:init(slot2.talentCubeInfos)

		slot6 = slot0.heroId
		slot7 = slot0.talent

		slot0.talentCubeInfos:setOwnData(slot6, slot7)

		slot0.originalTalentCubeInfos = {}

		for slot6, slot7 in ipairs(slot2.talentCubeInfos) do
			slot0.originalTalentCubeInfos[slot6] = {
				cubeId = slot7.cubeId,
				direction = slot7.direction,
				posX = slot7.posX,
				posY = slot7.posY
			}
		end
	end

	slot0.destinyRank = slot2.destinyRank
	slot0.destinyLevel = slot2.destinyLevel
	slot0.destinyStone = slot2.destinyStone

	return true
end

function slot0.getHeroInfo(slot0)
	return {
		heroUid = slot0:getHeroUid(),
		userId = slot0:getUserId(),
		name = slot0:getName(),
		userLevel = slot0:getUserLevel(),
		portrait = slot0:getPortrait(),
		bg = slot0:getBg(),
		isFriend = slot0:getIsFriend(),
		heroId = slot0:getHeroId(),
		level = slot0:getLevel(),
		rank = slot0:getRank(),
		skin = slot0:getSkin(),
		passiveSkillLevel = slot0:getPassiveSkillLevel(),
		exSkillLevel = slot0:getExSkillLevel(),
		talent = slot0:getTalent(),
		talentCubeInfos = slot0:getOriginalTalentCubeInfos(),
		balanceLevel = slot0:getBalanceLevel(),
		isOpenTalent = slot0:getIsOpenTalent(),
		style = slot0:getTalentStyle(),
		destinyRank = slot0:getDestinyRank(),
		destinyLevel = slot0:getDestinyLevel(),
		destinyStone = slot0:getDestinyStone()
	}
end

function slot0.getHeroUid(slot0)
	return slot0.heroUid
end

function slot0.getUserId(slot0)
	return slot0.userId
end

function slot0.getName(slot0)
	return slot0.name
end

function slot0.getUserLevel(slot0)
	return slot0.userLevel or 0
end

function slot0.getPortrait(slot0)
	return slot0.portrait
end

function slot0.getBg(slot0)
	return slot0.bg
end

function slot0.getIsFriend(slot0)
	return slot0.isFriend
end

function slot0.getHeroId(slot0)
	return slot0.heroId
end

function slot0.getLevel(slot0)
	return slot0.level or 0
end

function slot0.getRank(slot0)
	return slot0.rank
end

function slot0.getSkin(slot0)
	return slot0.skin
end

function slot0.getPassiveSkillLevel(slot0)
	return slot0.passiveSkillLevel
end

function slot0.getExSkillLevel(slot0)
	return slot0.exSkillLevel
end

function slot0.getTalent(slot0)
	return slot0.talent
end

function slot0.getOriginalTalentCubeInfos(slot0)
	return slot0.originalTalentCubeInfos
end

function slot0.getTalentCubeInfos(slot0)
	return slot0.talentCubeInfos
end

function slot0.getBalanceLevel(slot0)
	return slot0.balanceLevel or 0
end

function slot0.getIsOpenTalent(slot0)
	return slot0.isOpenTalent
end

function slot0.getTalentStyle(slot0)
	return slot0.style
end

function slot0.getDestinyRank(slot0)
	return slot0.destinyRank
end

function slot0.getDestinyLevel(slot0)
	return slot0.destinyLevel
end

function slot0.getDestinyStone(slot0)
	return slot0.destinyStone
end

return slot0
