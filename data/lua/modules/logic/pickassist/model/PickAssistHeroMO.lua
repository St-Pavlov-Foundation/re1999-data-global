module("modules.logic.pickassist.model.PickAssistHeroMO", package.seeall)

slot0 = pureTable("PickAssistHeroMO")

function slot1(slot0, slot1)
	slot2 = HeroConfig.instance:getHeroCO(slot0.heroId)
	HeroDef_pb.HeroInfo().uid = slot0.heroUid
	slot5 = slot0.rank
	slot6 = slot0.balanceLevel
	slot7 = false

	if slot1 and slot6 ~= slot0.level then
		slot4 = slot6
		slot8, slot5 = HeroConfig.instance:getShowLevel(slot6)
		slot7 = true
	end

	slot3.level = slot4
	slot3.heroId = slot0.heroId
	slot3.skin = slot0.skin
	slot3.defaultEquipUid = "0"
	slot3.rank = slot5
	slot3.talent = slot0.talent
	slot3.exSkillLevel = slot0.exSkillLevel

	if slot0.passiveSkillLevel then
		for slot11 = 1, #slot0.passiveSkillLevel do
			table.insert(slot3.passiveSkillLevel, slot0.passiveSkillLevel[slot11])
		end
	else
		for slot12 = 1, SkillConfig.instance:getHeroExSkillLevelByLevel(slot0.heroId, slot4) do
			table.insert(slot3.passiveSkillLevel, slot12)
		end
	end

	slot8 = SkillConfig.instance:getBaseAttr(slot0.heroId, slot4)
	slot3.baseAttr.attack = slot8.atk
	slot3.baseAttr.defense = slot8.def
	slot3.baseAttr.hp = slot8.hp
	slot3.baseAttr.mdefense = slot8.mdef
	slot3.baseAttr.technic = slot8.technic
	slot3.exAttr.addDmg = slot8.add_dmg
	slot3.exAttr.cri = slot8.cri
	slot3.exAttr.criDef = slot8.cri_def
	slot3.exAttr.dropDmg = slot8.drop_dmg
	slot3.exAttr.recri = slot8.recri
	slot3.exAttr.criDmg = slot8.cri_dmg
	slot9 = HeroMo.New()

	slot9:init(slot3, slot2)

	slot9.talentCubeInfos = slot0.talentCubeInfos

	slot9:setIsBelongOtherPlayer(true)
	slot9:setIsBalance(slot7)
	slot9:setOtherPlayerIsOpenTalent(slot0.isOpenTalent)
	slot9:setOtherPlayerTalentStyle(slot0.style)

	slot9.destinyRank = slot0.destinyRank
	slot9.destinyLevel = slot0.destinyLevel
	slot9.destinyStone = slot0.destinyStone
	slot9.destinyStoneMo = slot9.destinyStoneMo or HeroDestinyStoneMO.New(slot3.heroId)

	slot9.destinyStoneMo:refreshMo(slot0.destinyRank, slot0.destinyLevel, slot0.destinyStone, slot0.destinyStoneUnlock)

	return slot9
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.heroUid

	slot0:setHeroInfo(slot1)

	slot0.heroMO = uv0(slot0, true)
end

function slot0.setHeroInfo(slot0, slot1)
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

	slot0.destinyRank = slot1.destinyRank
	slot0.destinyLevel = slot1.destinyLevel
	slot0.destinyStone = slot1.destinyStone
	slot0.style = slot1.style
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.isSameHero(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = slot0:getId() == slot1:getId()
	end

	return slot2
end

function slot0.getPlayerInfo(slot0)
	return {
		userId = slot0.userId,
		name = slot0.name,
		level = slot0.userLevel,
		portrait = slot0.portrait,
		bg = slot0.bg
	}
end

function slot0.getCareer(slot0)
	slot1 = nil

	if slot0.heroMO and slot0.heroMO.config then
		slot1 = slot0.heroMO.config.career
	end

	return slot1
end

return slot0
