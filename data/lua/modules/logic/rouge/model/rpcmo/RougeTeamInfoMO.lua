module("modules.logic.rouge.model.rpcmo.RougeTeamInfoMO", package.seeall)

slot0 = pureTable("RougeTeamInfoMO")

function slot0.init(slot0, slot1)
	slot0.battleHeroList, slot0.battleHeroMap = GameUtil.rpcInfosToListAndMap(slot1.battleHeroList, RougeBattleHeroMO, "index")
	slot0.heroLifeList, slot0.heroLifeMap = GameUtil.rpcInfosToListAndMap(slot1.heroLifeList, RougeHeroLifeMO, "heroId")
	slot0.heroInfoList, slot0.heroInfoMap = GameUtil.rpcInfosToListAndMap(slot1.heroInfoList, RougeHeroInfoMO, "heroId")
	slot0._assistHeroMO = nil

	if slot1:HasField("assistHeroInfo") then
		slot2 = Season123AssistHeroMO.New()

		slot2:init(slot1.assistHeroInfo)

		slot0._assistHeroMO = Season123HeroUtils.createHeroMOByAssistMO(slot2)

		if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
			slot0._assistHeroMO:setOtherPlayerIsOpenTalent(true)
		end
	end

	slot0:_initSupportHeroAndSkill()
	slot0:_initTeamList()
	slot0:updateDeadHeroNum()
end

function slot0._initSupportHeroAndSkill(slot0)
	slot0._supportSkillMap = {}
	slot0._supportBattleHeroMap = {}

	for slot4, slot5 in ipairs(slot0.battleHeroList) do
		if slot5.supportHeroId > 0 and slot5.supportHeroSkill > 0 then
			slot0._supportSkillMap[slot5.supportHeroId] = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(slot5.supportHeroId, nil, slot0:getAssistHeroMo(slot5.supportHeroId)) and slot6[slot5.supportHeroSkill]
			slot0._supportBattleHeroMap[slot5.index + RougeEnum.FightTeamNormalHeroNum] = {
				heroId = slot5.supportHeroId
			}
		end
	end
end

function slot0._initTeamList(slot0)
	slot0._teamMap = {}
	slot0._teamAssistMap = {}

	for slot4, slot5 in ipairs(slot0.battleHeroList) do
		if slot5.heroId ~= 0 then
			slot0._teamMap[slot5.heroId] = slot5
		end

		if slot5.supportHeroId ~= 0 then
			slot0._teamAssistMap[slot5.supportHeroId] = slot5
		end
	end
end

function slot0.getAssistHeroMo(slot0, slot1)
	if slot1 then
		if slot0._assistHeroMO and slot0._assistHeroMO.heroId == slot1 then
			return slot0._assistHeroMO
		end
	else
		return slot0._assistHeroMO
	end
end

function slot0.getAssistHeroMoByUid(slot0, slot1)
	if slot0._assistHeroMO and slot0._assistHeroMO.uid == slot1 then
		return slot0._assistHeroMO
	end
end

function slot0.isAssistHero(slot0, slot1)
	return slot0._assistHeroMO and slot0._assistHeroMO.heroId == slot1
end

function slot0.inTeam(slot0, slot1)
	return slot0._teamMap[slot1] ~= nil
end

function slot0.inTeamAssist(slot0, slot1)
	return slot0._teamAssistMap[slot1] ~= nil
end

function slot0.getAssistTargetHero(slot0, slot1)
	return slot0._teamAssistMap and slot0._teamAssistMap[slot1]
end

function slot0.getHeroHp(slot0, slot1)
	return slot0.heroLifeMap[slot1]
end

function slot0.getSupportSkillStrList(slot0)
	for slot5 = 1, RougeEnum.FightTeamNormalHeroNum do
		if slot0.battleHeroMap[slot5] and slot6.supportHeroSkill ~= 0 then
			-- Nothing
		else
			slot1[slot5] = ""
		end
	end

	return {
		[slot5] = string.format("%s#%s", slot6.supportHeroId, slot6.supportHeroSkill)
	}
end

function slot0.getSupportSkillIndex(slot0, slot1)
	if not slot0:getSupportSkill(slot1) then
		return
	end

	if not SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(slot1) then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot8 == slot2 then
			return slot7
		end
	end
end

function slot0.getSupportSkill(slot0, slot1)
	return slot0._supportSkillMap[slot1]
end

function slot0.setSupportSkill(slot0, slot1, slot2)
	slot0._supportSkillMap[slot1] = slot2
end

function slot0.getGroupInfos(slot0)
	slot2 = {}

	RougeHeroGroupMO.New():setMaxHeroCount(RougeEnum.FightTeamHeroNum)

	for slot7 = 1, RougeEnum.FightTeamHeroNum do
		slot8 = slot0.battleHeroMap[slot7] or slot0._supportBattleHeroMap[slot7]
		slot10 = HeroModel.instance:getByHeroId(slot8 and slot8.heroId or 0)

		table.insert(slot2, slot10 and slot10.uid or "0")

		if slot7 <= RougeEnum.FightTeamNormalHeroNum then
			HeroGroupEquipMO.New():init({
				index = slot7 - 1,
				equipUid = {
					slot8 and slot8.equipUid or "0"
				}
			})
		end
	end

	slot1:init({
		id = 1,
		heroList = slot2,
		equips = {
			[slot13] = slot12
		}
	})

	return {
		slot1
	}
end

function slot0.getBattleHeroList(slot0)
	return slot0.battleHeroList
end

function slot0.updateTeamLife(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroLifeMap[slot6.heroId] then
			slot7:update(slot6)
		else
			slot7 = RougeHeroLifeMO.New()

			slot7:init(slot6)

			slot0.heroLifeMap[slot7.heroId] = slot7

			table.insert(slot0.heroLifeList, slot7)
		end
	end

	slot0:updateDeadHeroNum()
end

function slot0.updateExtraHeroInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroInfoMap[slot6.heroId] then
			slot7:update(slot6)
		else
			slot7 = RougeHeroInfoMO.New()

			slot7:init(slot6)

			slot0.heroInfoMap[slot7.heroId] = slot7

			table.insert(slot0.heroInfoList, slot7)
		end
	end
end

function slot0.updateTeamLifeAndDispatchEvent(slot0, slot1)
	slot2 = RougeMapEnum.LifeChangeStatus.Idle

	for slot6, slot7 in ipairs(slot1) do
		if slot0.heroLifeMap[slot7.heroId] then
			if RougeMapHelper.getLifeChangeStatus(slot8.life, slot7.life) ~= RougeMapEnum.LifeChangeStatus.Idle then
				slot2 = slot9
			end

			slot8:update(slot7)
		else
			slot8 = RougeHeroLifeMO.New()

			slot8:init(slot7)

			slot0.heroLifeMap[slot8.heroId] = slot8

			table.insert(slot0.heroLifeList, slot8)
		end
	end

	if slot2 ~= RougeMapEnum.LifeChangeStatus.Idle then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onTeamLifeChange, slot2)
	end

	slot0:updateDeadHeroNum()
end

function slot0.getAllHeroCount(slot0)
	return #slot0.heroLifeList
end

function slot0.getAllHeroId(slot0)
	slot1 = {}

	if slot0.heroLifeList then
		for slot5, slot6 in ipairs(slot0.heroLifeList) do
			table.insert(slot1, slot6.heroId)
		end
	end

	return slot1
end

function slot0.updateDeadHeroNum(slot0)
	slot0.deadHeroNum = 0

	if slot0.heroLifeList then
		for slot4, slot5 in ipairs(slot0.heroLifeList) do
			if slot5.life <= 0 then
				slot0.deadHeroNum = slot0.deadHeroNum + 1
			end
		end
	end
end

function slot0.getDeadHeroNum(slot0)
	return slot0.deadHeroNum
end

function slot0.getHeroInfo(slot0, slot1)
	return slot0.heroInfoMap and slot0.heroInfoMap[slot1]
end

return slot0
