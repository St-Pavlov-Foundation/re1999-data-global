module("modules.logic.seasonver.act123.model.Season123AssistHeroMO", package.seeall)

slot0 = pureTable("Season123AssistHeroMO")

function slot0.init(slot0, slot1, slot2)
	slot0.heroId = slot1.heroId
	slot0.heroUid = tostring(slot1.heroUid)
	slot0.userId = tostring(slot1.userId)
	slot0.name = slot1.name
	slot0.userLevel = slot1.userLevel
	slot0.portrait = slot1.portrait
	slot0.bg = slot1.bg
	slot0.isFriend = slot1.isFriend
	slot0.heroId = tonumber(slot1.heroId)
	slot0.level = tonumber(slot1.level)
	slot0.rank = slot1.rank
	slot0.skin = slot1.skin
	slot0.passiveSkillLevel = slot1.passiveSkillLevel
	slot0.exSkillLevel = slot1.exSkillLevel
	slot0.balanceLevel = slot1.balanceLevel
	slot0.isOpenTalent = slot1.isOpenTalent
	slot0.talent = slot1.talent
	slot0.talentCubeInfos = HeroTalentCubeInfosMO.New()

	slot0.talentCubeInfos:init(slot1.talentCubeInfos)
	slot0.talentCubeInfos:setOwnData(slot0.heroId, slot0.talent)

	slot0.style = slot1.style
	slot0.destinyRank = slot1.destinyRank
	slot0.destinyLevel = slot1.destinyLevel
	slot0.destinyStone = slot1.destinyStone
end

return slot0
