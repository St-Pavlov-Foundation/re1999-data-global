module("modules.logic.rouge.controller.RougeHeroGroupController", package.seeall)

slot0 = class("RougeHeroGroupController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
end

function slot0.reInit(slot0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
end

function slot0._onGetInfoFinish(slot0)
end

function slot0.openGroupFightView(slot0, slot1, slot2, slot3)
	slot0._groupFightName = slot0:_getGroupFightViewName(slot2)

	RougeTeamListModel.addAssistHook()
	RougeHeroGroupModel.instance:clear()
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.FightTeamHeroNum)
	RougeHeroGroupModel.instance:onGetHeroGroupList(RougeModel.instance:getTeamInfo():getGroupInfos())
	RougeHeroGroupModel.instance:setReplayParam(nil)
	RougeHeroGroupModel.instance:setParam(slot1, slot2, slot3)
	HeroGroupModel.instance:setReplayParam(nil)

	HeroGroupModel.instance.battleId = slot1
	HeroGroupModel.instance.episodeId = slot2
	HeroGroupModel.instance.adventure = slot3
	slot7 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) and (DungeonModel.instance:getEpisodeInfo(slot2) and slot5.star == DungeonEnum.StarType.Advanced and slot5.hasRecord) and not string.nilorempty(slot7) and cjson.decode(slot7)[tostring(slot2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
		FightRpc.instance:sendGetFightRecordGroupRequest(slot2)

		return
	end

	if slot0:changeToDefaultEquip() and not HeroGroupModel.instance:getCurGroupMO().temp then
		HeroGroupModel.instance:saveCurGroupData(function ()
			ViewMgr.instance:openView(uv0._groupFightName)
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		slot8:saveData()
	end

	ViewMgr.instance:openView(slot0._groupFightName)
end

function slot0._getGroupFightViewName(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1) and DungeonConfig.instance:getChapterCO(slot2.chapterId) then
		if slot3.actId == VersionActivity1_2Enum.ActivityId.Dungeon then
			return ViewName.VersionActivity_1_2_HeroGroupView
		end

		if slot3.type == DungeonEnum.ChapterType.RoleStoryChallenge then
			return ViewName.RoleStoryHeroGroupFightView
		end
	end

	return ViewName.RougeHeroGroupFightView
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

function slot0.setFightHeroSingleGroup(slot0)
	if not FightModel.instance:getFightParam() then
		return false
	end

	if not RougeHeroGroupModel.instance:getCurGroupMO() then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot3 = RougeModel.instance:getTeamInfo()
	slot4, slot5 = slot2:getMainList()
	slot6, slot7 = slot2:getSubList()
	slot8 = RougeHeroSingleGroupModel.instance:getList()
	slot9, slot10 = slot2:getAllHeroEquips()

	for slot14 = 1, #slot4 do
		if slot4[slot14] ~= slot8[slot14].heroUid then
			slot4[slot14] = "0"
			slot5 = slot5 - 1

			if slot9[slot14] then
				slot9[slot14].heroUid = "0"
			end
		end
	end

	slot14 = #slot8

	for slot14 = #slot4 + 1, math.min(#slot4 + #slot6, slot14) do
		if slot6[slot14 - #slot4] ~= slot8[slot14].heroUid then
			slot6[slot14 - #slot4] = "0"
			slot7 = slot7 - 1

			if slot9[slot14] then
				slot9[slot14].heroUid = "0"
			end
		end
	end

	for slot14, slot15 in ipairs(slot8) do
		if slot3:getAssistHeroMoByUid(slot15.heroUid) then
			slot1:setAssistHeroInfo(slot15.heroUid)

			break
		end
	end

	for slot14, slot15 in ipairs(slot9) do
		if RougeEnum.FightTeamNormalHeroNum < slot14 then
			rawset(slot9, slot14, nil)
		end
	end

	if (not slot2.aidDict or #slot2.aidDict <= 0) and slot5 + slot7 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot11 = nil
	slot13 = slot1.battleId and lua_battle.configDict[slot12]

	slot1:setMySide(slot13 and slot13.noClothSkill == 0 and slot2.clothId or 0, slot4, slot6, slot9, (not Season123Controller.isEpisodeFromSeason123(slot1.episodeId) or Season123HeroGroupUtils.getAllHeroActivity123Equips(slot2)) and slot2:getAllHeroActivity104Equips(), nil, slot3:getSupportSkillStrList())

	if slot10 then
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end

	return true
end

function slot0.removeEquip(slot0, slot1)
	if HeroSingleGroupModel.instance:isTemp() or slot1 then
		slot2, slot3, slot4 = EquipTeamListModel.instance:_getRequestData(slot0, "0")

		HeroGroupModel.instance:replaceEquips({
			index = slot3,
			equipUid = slot4
		}, EquipTeamListModel.instance:getCurGroupMo())

		if not slot1 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot3)
		end
	else
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end
end

function slot0.replaceEquip(slot0, slot1, slot2)
	if HeroSingleGroupModel.instance:isTemp() or slot2 then
		slot3, slot4, slot5 = EquipTeamListModel.instance:_getRequestData(slot0, slot1)

		HeroGroupModel.instance:replaceEquips({
			index = slot4,
			equipUid = slot5
		}, EquipTeamListModel.instance:getCurGroupMo())

		if not slot2 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot4)
		end
	else
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end
end

slot0.instance = slot0.New()

return slot0
