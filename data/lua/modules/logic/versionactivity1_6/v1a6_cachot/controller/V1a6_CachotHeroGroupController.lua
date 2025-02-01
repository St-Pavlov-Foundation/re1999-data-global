module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotHeroGroupController", package.seeall)

slot0 = class("V1a6_CachotHeroGroupController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
end

function slot0.reInit(slot0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
end

function slot0._onGetInfoFinish(slot0)
	HeroGroupModel.instance:setParam()
end

function slot0.openGroupFightView(slot0, slot1, slot2, slot3)
	slot0._groupFightName = slot0:_getGroupFightViewName(slot2)

	V1a6_CachotHeroGroupModel.instance:clear()
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
	V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(V1a6_CachotModel.instance:getTeamInfo():getGroupInfos())
	V1a6_CachotHeroGroupModel.instance:setReplayParam(nil)
	V1a6_CachotHeroGroupModel.instance:setParam(slot1, slot2, slot3)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(slot1, slot2, slot3)
	ViewMgr.instance:openView(slot0._groupFightName)

	if V1a6_CachotModel.instance:getRogueInfo() then
		V1a6_CachotController.instance.heartNum = slot4.heart
	end
end

function slot0._getGroupFightViewName(slot0, slot1)
	return ViewName.V1a6_CachotHeroGroupFightView
end

function slot0.changeToDefaultEquip(slot0)
	slot1 = HeroGroupModel.instance:getCurGroupMO()
	slot2 = slot1.equips
	slot4, slot5 = nil
	slot6 = false

	for slot10, slot11 in ipairs(slot1.heroList) do
		slot5 = slot10 - 1

		if HeroModel.instance:getById(slot11) and slot4:hasDefaultEquip() and slot4.defaultEquipUid ~= slot2[slot5].equipUid[1] then
			if slot5 <= slot0:_checkEquipInPreviousEquip(slot5 - 1, slot4.defaultEquipUid, slot2) then
				if slot0:_checkEquipInBehindEquip(slot5 + 1, slot4.defaultEquipUid, slot2) > 0 then
					slot2[slot13].equipUid[1] = slot2[slot5].equipUid[1]
				end

				slot2[slot5].equipUid[1] = slot4.defaultEquipUid
			elseif slot2[slot5].equipUid[1] == slot4.defaultEquipUid then
				slot2[slot5].equipUid[1] = "0"
			end

			slot6 = true
		end
	end

	return slot6
end

function slot0._checkEquipInBehindEquip(slot0, slot1, slot2, slot3)
	if not EquipModel.instance:getEquip(slot2) then
		return -1
	end

	for slot7 = slot1, #slot3 do
		if slot2 == slot3[slot7].equipUid[1] then
			return slot7
		end
	end

	return -1
end

function slot0._checkEquipInPreviousEquip(slot0, slot1, slot2, slot3)
	if not EquipModel.instance:getEquip(slot2) then
		return slot1 + 1
	end

	for slot7 = slot1, 0, -1 do
		if slot2 == slot3[slot7].equipUid[1] then
			return slot7
		end
	end

	return slot1 + 1
end

function slot0._onGetFightRecordGroupReply(slot0, slot1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
	HeroGroupModel.instance:setReplayParam(slot1)
	ViewMgr.instance:openView(slot0._groupFightName)
end

function slot0.onReceiveHeroGroupSnapshot(slot0, slot1)
	slot2 = slot1.snapshotId
	slot3 = slot1.snapshotSubId
end

function slot0.removeEquip(slot0, slot1)
	if HeroSingleGroupModel.instance:isTemp() or slot1 then
		slot2, slot3, slot4 = EquipTeamListModel.instance:_getRequestData(slot0, "0")

		V1a6_CachotHeroGroupModel.instance:replaceEquips({
			index = slot3,
			equipUid = slot4
		}, EquipTeamListModel.instance:getCurGroupMo())

		if not slot1 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot3)
		end
	else
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end
end

function slot0.replaceEquip(slot0, slot1, slot2)
	if HeroSingleGroupModel.instance:isTemp() or slot2 then
		slot3, slot4, slot5 = EquipTeamListModel.instance:_getRequestData(slot0, slot1)

		V1a6_CachotHeroGroupModel.instance:replaceEquips({
			index = slot4,
			equipUid = slot5
		}, EquipTeamListModel.instance:getCurGroupMo())

		if not slot2 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot4)
		end
	else
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end
end

function slot0.getFightFocusEquipInfo(slot0, slot1)
	slot3 = slot1.equipMO

	if not V1a6_CachotTeamModel.instance:getSeatLevel(slot1.posIndex) then
		return slot3
	end

	if V1a6_CachotTeamModel.instance:getEquipMaxLevel(slot3, slot4) == slot3.level then
		return slot3
	end

	slot6 = EquipMO.New()

	slot6:initByConfig(nil, slot3.equipId, slot5, slot3.refineLv)

	return slot6
end

function slot0.getCharacterTipEquipInfo(slot0, slot1)
	slot3 = slot1.equipMO

	if V1a6_CachotTeamModel.instance:getEquipMaxLevel(slot3, slot1.seatLevel) == slot3.level then
		return slot3
	end

	slot5 = EquipMO.New()

	slot5:initByConfig(nil, slot3.equipId, slot4, slot3.refineLv)

	return slot5
end

slot0.instance = slot0.New()

return slot0
