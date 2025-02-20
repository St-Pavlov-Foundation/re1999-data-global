module("modules.logic.seasonver.act123.utils.Season123HeroUtils", package.seeall)

slot0 = class("Season123HeroUtils")

function slot0.createHeroMOByAssistMO(slot0, slot1)
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
		slot12 = slot4

		for slot12 = 1, SkillConfig.instance:getHeroExSkillLevelByLevel(slot0.heroId, slot12) do
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

	slot9.destinyStoneMo = HeroDestinyStoneMO.New(slot0.heroId)

	slot9.destinyStoneMo:refreshMo(slot0.destinyRank, slot0.destinyLevel, slot0.destinyStone, slot0.destinyStoneUnlock)

	return slot9
end

function slot0.createSeasonPickAssistMO(slot0)
	if not slot0 then
		return
	end

	slot2 = Season123PickAssistMO.New()

	slot2:init(slot0:getHeroInfo())

	return slot2
end

function slot0.getHeroMO(slot0, slot1, slot2)
	if not HeroModel.instance:getById(slot1) and slot2 ~= nil then
		slot4, slot5 = Season123Model.instance:getAssistData(slot0, slot2)

		if slot5 and slot5.heroUid == slot1 then
			return slot4
		end
	else
		return slot3
	end
end

return slot0
