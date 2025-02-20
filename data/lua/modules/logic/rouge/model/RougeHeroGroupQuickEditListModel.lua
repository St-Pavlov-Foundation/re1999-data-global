module("modules.logic.rouge.model.RougeHeroGroupQuickEditListModel", package.seeall)

slot0 = class("RougeHeroGroupQuickEditListModel", ListScrollModel)

function slot0.calcTotalCapacity(slot0)
	for slot5, slot6 in pairs(slot0._inTeamHeroUidList) do
		if HeroModel.instance:getById(slot6) then
			slot1 = 0 + RougeController.instance:getRoleStyleCapacity(slot7, RougeEnum.FightTeamNormalHeroNum < slot5 and not slot0._skipAssitType)
		end
	end

	return slot1 + slot0:_getAssitCapacity() + RougeHeroGroupEditListModel.instance:getAssistCapacity()
end

function slot0._isTeamCapacityEnough(slot0, slot1, slot2)
	slot3 = 0
	slot4 = false

	for slot8, slot9 in pairs(slot0._inTeamHeroUidList) do
		slot10 = HeroModel.instance:getById(slot9)

		if slot9 == slot2 then
			slot4 = true
		end

		if slot10 then
			slot3 = slot3 + RougeController.instance:getRoleStyleCapacity(slot10, RougeEnum.FightTeamNormalHeroNum < slot8 and not slot0._skipAssitType)
		end
	end

	if not slot4 and HeroModel.instance:getById(slot2) then
		slot3 = slot3 + RougeController.instance:getRoleStyleCapacity(slot5, RougeEnum.FightTeamNormalHeroNum < slot1 and not slot0._skipAssitType)
	end

	return slot3 + slot0:_getAssitCapacity(slot1, slot2) + RougeHeroGroupEditListModel.instance:getAssistCapacity() <= RougeHeroGroupEditListModel.instance:getTotalCapacity()
end

function slot0._getAssitCapacity(slot0, slot1, slot2)
	if slot0._edityType ~= RougeEnum.HeroGroupEditType.Fight then
		return 0
	end

	slot3 = nil

	if slot1 and slot2 then
		slot3 = {
			[slot7] = slot8
		}

		for slot7, slot8 in pairs(slot0._inTeamHeroUidList) do
			if HeroModel.instance:getById(slot8) then
				-- Nothing
			elseif slot2 then
				slot3[slot7] = slot2
				slot2 = nil
			end
		end
	end

	slot4 = 0
	slot7 = {
		[slot14.heroId] = slot14
	}

	for slot11, slot12 in ipairs(RougeHeroSingleGroupModel.instance:getList()) do
		if slot11 <= RougeEnum.FightTeamNormalHeroNum then
			if HeroModel.instance:getById((slot3 or slot0._inTeamHeroUidList)[slot11]) then
				-- Nothing
			end
		elseif slot12:getHeroMO() and not slot7[slot13.heroId] and slot6[slot11 - RougeEnum.FightTeamNormalHeroNum] then
			slot6[slot11] = slot13
		end
	end

	for slot11, slot12 in pairs({
		[slot11] = nil,
		[slot11] = slot14
	}) do
		if RougeEnum.FightTeamNormalHeroNum < slot11 then
			slot4 = slot4 + RougeController.instance:getRoleStyleCapacity(slot12, RougeEnum.FightTeamNormalHeroNum < slot11 and not slot0._skipAssitType)
		end
	end

	return slot4
end

function slot0.copyQuickEditCardList(slot0)
	slot0._edityType = RougeHeroGroupEditListModel.instance:getHeroGroupEditType()
	slot0._isSelectHeroType = slot0._edityType == RougeEnum.HeroGroupEditType.SelectHero
	slot0._isInitType = slot0._edityType == RougeEnum.HeroGroupEditType.Init
	slot0._skipAssitType = not slot0._isSelectHeroType and not slot0._isInitType

	if slot0._isInitType then
		slot0._battleRoleNum = RougeEnum.InitTeamHeroNum
	else
		slot0._battleRoleNum = RougeEnum.DefaultTeamHeroNum
	end

	slot1 = nil
	slot1 = (not slot0._isSelectHeroType or RougeHeroGroupEditListModel.instance:getSelectHeroList(CharacterBackpackCardListModel.instance:getCharacterCardList())) and (slot0._edityType ~= RougeEnum.HeroGroupEditType.Init or CharacterBackpackCardListModel.instance:getCharacterCardList()) and RougeHeroGroupEditListModel.instance:getTeamList(CharacterBackpackCardListModel.instance:getCharacterCardList())
	slot3 = {}
	slot0._inTeamHeroUidMap = {}
	slot0._inTeamHeroUidList = {}
	slot0._originalHeroUidList = {}
	slot0._assitPosIndex = {}
	slot0._selectUid = nil

	for slot8, slot9 in ipairs(RougeHeroSingleGroupModel.instance:getList()) do
		if tonumber(slot9.heroUid) > 0 and not slot3[slot11] then
			table.insert({}, HeroModel.instance:getById(slot11))

			if slot0:isPositionOpen(slot8) then
				slot0._inTeamHeroUidMap[slot11] = 1
			end

			slot3[slot11] = true
		elseif RougeHeroSingleGroupModel.instance:getByIndex(slot8).trial then
			table.insert(slot2, HeroGroupTrialModel.instance:getById(slot11))

			if slot10 then
				slot0._inTeamHeroUidMap[slot11] = 1
			end

			slot3[slot11] = true
		end

		if slot10 then
			table.insert(slot0._inTeamHeroUidList, slot11)
			table.insert(slot0._originalHeroUidList, slot11)
		end

		if RougeEnum.FightTeamNormalHeroNum < slot8 then
			slot0._assitPosIndex[slot11] = slot8
		end
	end

	slot5 = RougeHeroGroupEditListModel.instance:getAssistHeroId()

	for slot10, slot11 in ipairs(slot1) do
		if not slot3[slot11.uid] then
			slot3[slot11.uid] = true

			if slot0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(slot11.heroId) > 0 then
					table.insert({}, slot11)
				else
					table.insert(slot2, slot11)
				end
			elseif slot11.heroId ~= slot5 then
				table.insert(slot2, slot11)
			end
		end
	end

	if slot0.adventure then
		tabletool.addValues(slot2, slot6)
	end

	slot0:setList(slot2)
end

function slot0.keepSelect(slot0, slot1)
	slot0._selectIndex = slot1
	slot2 = slot0:getList()

	if #slot0._scrollViews > 0 then
		for slot6, slot7 in ipairs(slot0._scrollViews) do
			slot7:selectCell(slot1, true)
		end

		if slot2[slot1] then
			return slot2[slot1]
		end
	end
end

function slot0.isInTeamHero(slot0, slot1)
	return slot0._inTeamHeroUidMap and slot0._inTeamHeroUidMap[slot1]
end

function slot0.getHeroTeamPos(slot0, slot1)
	if slot0._inTeamHeroUidList then
		for slot5, slot6 in pairs(slot0._inTeamHeroUidList) do
			if slot6 == slot1 then
				return slot5
			end
		end
	end

	return 0
end

function slot0.selectHero(slot0, slot1)
	if slot0:getHeroTeamPos(slot1) ~= 0 then
		slot0._inTeamHeroUidList[slot2] = "0"
		slot0._inTeamHeroUidMap[slot1] = nil

		slot0:onModelUpdate()

		slot0._selectUid = nil

		return true
	else
		if slot0._isInitType and not slot0:_isTeamCapacityEnough(slot2, slot1) then
			GameFacade.showToast(ToastEnum.RougeTeamCapacityFull)

			return false
		end

		if slot0._isSelectHeroType and not slot0:_isTeamCapacityEnough(slot2, slot1) then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return false
		end

		if slot0._edityType == RougeEnum.HeroGroupEditType.Fight and not slot0:_isTeamCapacityEnough(slot2, slot1) then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return false
		end

		if slot0:isTeamFull() then
			GameFacade.showToast(ToastEnum.RougeTeamFull)

			return false
		end

		slot3 = 0

		for slot7 = 1, #slot0._inTeamHeroUidList do
			if slot0._inTeamHeroUidList[slot7] == 0 or slot8 == "0" and not slot0:_skipAssistPos(slot7) then
				slot0._inTeamHeroUidList[slot7] = slot1
				slot0._inTeamHeroUidMap[slot1] = 1

				slot0:onModelUpdate()

				return true
			end
		end

		slot0._selectUid = slot1
	end

	return false
end

function slot0.isRepeatHero(slot0, slot1, slot2)
	if not slot0._inTeamHeroUidMap then
		return false
	end

	for slot6 in pairs(slot0._inTeamHeroUidMap) do
		if slot0:getById(slot6).heroId == slot1 and slot2 ~= slot7.uid then
			return true
		end
	end

	return false
end

function slot0.isTrialLimit(slot0)
	if not slot0._inTeamHeroUidMap then
		return false
	end

	for slot5 in pairs(slot0._inTeamHeroUidMap) do
		if slot0:getById(slot5):isTrial() then
			slot1 = 0 + 1
		end
	end

	return HeroGroupTrialModel.instance:getLimitNum() <= slot1
end

function slot0.inInTeam(slot0, slot1)
	if not slot0._inTeamHeroUidMap then
		return false
	end

	return slot0._inTeamHeroUidMap[slot1] and true or false
end

function slot0.getHeroUids(slot0)
	return slot0._inTeamHeroUidList
end

function slot0.getHeroUidByPos(slot0, slot1)
	return slot0._inTeamHeroUidList[slot1]
end

function slot0.getAssitPosIndex(slot0, slot1)
	return slot0._assitPosIndex[slot1]
end

function slot0.getIsDirty(slot0)
	for slot4 = 1, #slot0._inTeamHeroUidList do
		if slot0._inTeamHeroUidList[slot4] ~= slot0._originalHeroUidList[slot4] then
			return true
		end
	end

	return false
end

function slot0.cancelAllSelected(slot0)
	if slot0._scrollViews then
		for slot4, slot5 in ipairs(slot0._scrollViews) do
			slot5:selectCell(slot0:getIndex(slot5:getFirstSelect()), false)
		end
	end
end

function slot0.isPositionOpen(slot0, slot1)
	if slot0._isSelectHeroType or slot0._isInitType then
		return true
	end

	return RougeHeroGroupModel.instance:isPositionOpen(slot1)
end

function slot0.isTeamFull(slot0)
	if slot0._isSelectHeroType then
		return false
	end

	slot5 = slot0._battleRoleNum

	for slot5 = 1, math.min(slot5, #slot0._inTeamHeroUidList) do
		if slot0._inTeamHeroUidList[slot5] == "0" and slot0:isPositionOpen(slot5) and not slot0:_skipAssistPos(slot5) then
			return false
		end
	end

	return true
end

function slot0._skipAssistPos(slot0, slot1)
	return RougeHeroGroupEditListModel.instance:getAssistPos() == slot1
end

function slot0.setParam(slot0, slot1)
	slot0.adventure = slot1
end

function slot0.clear(slot0)
	slot0._inTeamHeroUidMap = nil
	slot0._inTeamHeroUidList = nil
	slot0._originalHeroUidList = nil
	slot0._selectIndex = nil
	slot0._selectUid = nil

	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
