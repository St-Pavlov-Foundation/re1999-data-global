module("modules.logic.rouge.model.RougeTeamListModel", package.seeall)

slot0 = class("RougeTeamListModel", ListScrollModel)

function slot0.getHp(slot0, slot1)
	return slot0._heroLifeMap[slot1.heroId] and slot3.life or 0
end

function slot0.isInTeam(slot0, slot1)
	return slot0._teamInfo:inTeam(slot1.heroId)
end

function slot0.isAssit(slot0, slot1)
	return slot0._teamInfo:inTeamAssist(slot1.heroId)
end

function slot0.getTeamType(slot0)
	return slot0._teamType
end

function slot0.getSelectedHeroMap(slot0)
	return slot0._selectedHeroMap
end

function slot0.getSelectedHeroList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._selectedHeroMap) do
		table.insert(slot1, slot5)
	end

	function slot5(slot0, slot1)
		return uv0._selectedHeroMap[slot0] < uv0._selectedHeroMap[slot1]
	end

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot1[slot5] = slot6.heroId
	end

	return slot1
end

function slot0.isHeroSelected(slot0, slot1)
	return slot0._selectedHeroMap[slot1] ~= nil
end

function slot0.selectHero(slot0, slot1)
	if slot0._selectedHeroMap[slot1] then
		slot0._selectedHeroMap[slot1] = nil

		return
	end

	if slot0._heroNum <= tabletool.len(slot0._selectedHeroMap) then
		GameFacade.showToast(ToastEnum.RougeTeamSelectedFull)

		return
	end

	slot0._selectedHeroMap[slot1] = UnityEngine.Time.frameCount
end

function slot0.initList(slot0, slot1, slot2)
	slot3 = RougeModel.instance:getTeamInfo()
	slot0._heroLifeMap = slot3.heroLifeMap
	slot0._teamInfo = slot3
	slot0._teamType = slot1
	slot0._heroNum = slot2
	slot0._selectedHeroMap = {}

	if slot1 == RougeEnum.TeamType.View then
		slot0:_getViewList(slot3.heroLifeList, {})
	elseif slot1 == RougeEnum.TeamType.Treat then
		slot0:_getTreatList(slot4, slot5)
	elseif slot1 == RougeEnum.TeamType.Revive then
		slot0:_getReviveList(slot4, slot5)
	elseif slot1 == RougeEnum.TeamType.Assignment then
		slot0:_getAssignmentList(slot4, slot5)
	end

	slot0:setList(slot5)
end

function slot0._getViewList(slot0, slot1, slot2)
	for slot6 = #slot1, 1, -1 do
		slot7 = slot1[slot6]

		if slot7.life > 0 then
			table.insert(slot2, 1, slot0:getByHeroId(slot7.heroId))
		else
			table.insert(slot2, slot8)
		end
	end
end

function slot0._getTreatList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.life > 0 then
			table.insert(slot2, slot0:getByHeroId(slot7.heroId))
		end
	end
end

function slot0._getReviveList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.life <= 0 then
			table.insert(slot2, slot0:getByHeroId(slot7.heroId))
		end
	end
end

function slot0._getAssignmentList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.life > 0 then
			table.insert(slot2, slot0:getByHeroId(slot7.heroId))
		end
	end
end

function slot0.getByHeroId(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1)
end

function slot0.addAssistHook()
	HeroModel.instance:addHookGetHeroId(uv0.addHookGetHeroId)
	HeroModel.instance:addHookGetHeroUid(uv0.addHookGetHeroUid)
end

function slot0.removeAssistHook()
	HeroModel.instance:removeHookGetHeroId(uv0.addHookGetHeroId)
	HeroModel.instance:removeHookGetHeroUid(uv0.addHookGetHeroUid)
end

function slot0.addHookGetHeroId(slot0)
	return RougeModel.instance:getTeamInfo():getAssistHeroMo(slot0)
end

function slot0.addHookGetHeroUid(slot0)
	return RougeModel.instance:getTeamInfo():getAssistHeroMoByUid(slot0)
end

slot0.instance = slot0.New()

return slot0
