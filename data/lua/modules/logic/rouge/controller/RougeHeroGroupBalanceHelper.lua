module("modules.logic.rouge.controller.RougeHeroGroupBalanceHelper", package.seeall)

slot0 = class("RougeHeroGroupBalanceHelper")
slot0.BalanceColor = "#bfdaff"
slot0.BalanceIconColor = "#81abe5"

function slot0.canShowBalanceSwitchBtn()
	if not FightModel.instance:getFightParam() or not slot0.episodeId then
		return false
	end

	if DungeonConfig.instance:getEpisodeCO(slot0.episodeId).firstBattleId and slot2 > 0 and DungeonModel.instance:getEpisodeInfo(slot0.episodeId) and DungeonEnum.StarType.None < slot3.star and lua_battle.configDict[slot2] then
		return not string.nilorempty(slot4.balance)
	end

	return false
end

function slot0.switchBalanceMode()
	uv0._isClickBalance = false

	if not FightModel.instance:getFightParam() then
		return
	end

	if uv0.getIsBalanceMode() then
		slot0.battleId = DungeonConfig.instance:getEpisodeCO(slot0.episodeId).battleId
	else
		uv0._isClickBalance = true
		slot0.battleId = slot2.firstBattleId
	end

	slot0:setBattleId(slot0.battleId)

	HeroGroupModel.instance.battleId = slot0.battleId

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
end

function slot0.clearBalanceStatus()
	uv0._isClickBalance = false
end

function slot0.isClickBalance()
	return uv0._isClickBalance
end

function slot0.getIsBalanceMode()
	if not RougeModel.instance:getDifficulty() then
		return false
	end

	return RougeConfig1.instance:getDifficultyCO(slot0) and not string.nilorempty(slot1.balanceLevel) or false
end

slot1, slot2 = nil

function slot0.getBalanceLv()
	if not RougeModel.instance:getDifficulty() then
		return
	end

	if not RougeConfig1.instance:getDifficultyCO(slot0) then
		return
	end

	slot3 = string.splitToNumber(slot1.balanceLevel, "#")[1] or 0
	slot4 = slot2[2] or 0
	slot5 = slot2[3] or 0

	if uv0 == nil then
		uv0 = #lua_character_cosume.configDict
	end

	if uv1 == nil then
		uv1 = 1

		for slot9, slot10 in pairs(lua_character_talent.configList) do
			if uv1 < slot10.talentId then
				uv1 = slot10.talentId
			end
		end
	end

	return Mathf.Clamp(slot3, 1, uv0), Mathf.Clamp(slot4, 1, uv1), Mathf.Clamp(slot5, 1, EquipConfig.MaxLevel)
end

function slot0.getHeroBalanceLv(slot0)
	if not uv0.getBalanceLv() then
		return 0
	end

	for slot7 in pairs(SkillConfig.instance:getherolevelsCO(slot0)) do
		if 0 < slot7 then
			slot2 = slot7
		end
	end

	return math.min(slot2, slot1)
end

function slot0.getHeroBalanceInfo(slot0)
	if not HeroModel.instance:getByHeroId(slot0) then
		return
	end

	slot2, slot3, slot4 = uv0.getBalanceLv()

	if not slot2 then
		return
	end

	for slot10 in pairs(SkillConfig.instance:getherolevelsCO(slot0)) do
		if 0 < slot10 then
			slot5 = slot10
		end
	end

	slot7, slot8 = SkillConfig.instance:getHeroExSkillLevelByLevel(slot0, math.max(slot1.level, math.min(slot5, slot2)))
	slot9 = 1

	for slot13 = slot3, 1, -1 do
		if lua_character_talent.configDict[slot0][slot13] and slot14.requirement <= slot8 then
			slot9 = slot13

			break
		end
	end

	slot10 = slot1.talentCubeInfos

	if (slot1.talent < slot9 or slot1.rank < CharacterEnum.TalentRank) and CharacterEnum.TalentRank <= slot8 then
		slot11 = {}
		slot12 = lua_character_talent.configDict[slot0][slot9]
		slot20 = ","

		for slot20, slot21 in ipairs(GameUtil.splitString2(lua_talent_scheme.configDict[slot9][slot12.talentMould][string.splitToNumber(slot12.exclusive, "#")[1]].talenScheme, true, "#", slot20)) do
			HeroDef_pb.TalentCubeInfo().cubeId = slot21[1]
			slot22.direction = slot21[2] or 0
			slot22.posX = slot21[3] or 0
			slot22.posY = slot21[4] or 0

			table.insert(slot11, slot22)
		end

		slot10 = HeroTalentCubeInfosMO.New()

		slot10:init(slot11)
		slot10:setOwnData(slot0, slot9)
	end

	return slot2, slot8, slot9, slot10, slot4
end

return slot0
