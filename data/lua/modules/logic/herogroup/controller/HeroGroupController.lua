module("modules.logic.herogroup.controller.HeroGroupController", package.seeall)

slot0 = class("HeroGroupController", BaseController)

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

	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(slot1, slot2, slot3)

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
	if not slot0.ActivityIdToHeroGroupView then
		slot0.ActivityIdToHeroGroupView = {
			[VersionActivity1_2Enum.ActivityId.Dungeon] = ViewName.V1a2_HeroGroupFightView,
			[VersionActivity1_3Enum.ActivityId.Dungeon] = ViewName.V1a3_HeroGroupFightView,
			[VersionActivity1_5Enum.ActivityId.Dungeon] = ViewName.V1a5_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.Dungeon] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.DungeonBossRush] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity2_5Enum.ActivityId.Challenge] = ViewName.Act183HeroGroupFightView
		}
		slot0.ChapterTypeToHeroGroupView = {
			[DungeonEnum.ChapterType.WeekWalk] = ViewName.HeroGroupFightWeekwalkView,
			[DungeonEnum.ChapterType.TowerPermanent] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBoss] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerLimited] = ViewName.TowerHeroGroupFightView
		}
	end

	if DungeonConfig.instance:getEpisodeCO(slot1) and DungeonConfig.instance:getChapterCO(slot2.chapterId) then
		return slot0.ActivityIdToHeroGroupView[slot3.actId] or slot0.ChapterTypeToHeroGroupView[slot3.type] or ViewName.HeroGroupFightView
	end

	return ViewName.HeroGroupFightView
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

slot0.instance = slot0.New()

return slot0
