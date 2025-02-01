module("modules.logic.seasonver.act123.controller.Season123HeroGroupController", package.seeall)

slot0 = class("Season123HeroGroupController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4)
	Season123Controller.instance:registerCallback(Season123Event.HeroGroupIndexChanged, slot0.handleHeroGroupIndexChanged, slot0)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, slot0.handleGetFightRecordGroupReply, slot0)

	if Season123Model.instance:getBattleContext() and DungeonConfig.instance:getEpisodeCO(slot5.episodeId) then
		HeroGroupTrialModel.instance:setTrialByBattleId(slot6.battleId)
	end

	CharacterModel.instance:setAppendHeroMOs(nil)
	Season123HeroGroupModel.instance:init(slot1, slot2, slot3, slot4)
	Season123HeroGroupEditModel.instance:init(slot1, slot2, slot3, slot4)
	Season123HeroGroupQuickEditModel.instance:init(slot1, slot2, slot3, slot4)
end

function slot0.onCloseView(slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.HeroGroupIndexChanged, slot0.handleHeroGroupIndexChanged, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0.handleGetFightRecordGroupReply, slot0)
	slot0:saveCurrentHeroGroup()
	CharacterModel.instance:setAppendHeroMOs(nil)
end

function slot0.checkSeason123HeroGroup(slot0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		uv0.checkHeroGroupAvailable(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer)
	end
end

function slot0.changeReplayMode2Manual(slot0)
	HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, HeroGroupModel.instance:getCurGroupMO().id)
	uv0.instance:checkSeason123HeroGroup(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer)
end

function slot0.switchHeroGroup(slot0, slot1)
	slot0:saveCurrentHeroGroup()
	Activity123Rpc.instance:sendAct123ChangeFightGroupRequest(Season123HeroGroupModel.instance.activityId, slot1)
end

function slot0.saveCurrentHeroGroup(slot0)
	if not Season123HeroGroupModel.instance.activityId then
		return
	end

	if not Season123Model.instance:getActInfo(slot1) then
		return
	end

	uv0.saveHeroGroup(slot1, slot2.heroGroupSnapshotSubId)
end

function slot0.saveHeroGroup(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0) then
		return
	end

	slot3 = nil

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		slot3 = slot2.heroGroupSnapshot[slot1]
	elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		slot3 = slot2.retailHeroGroups[slot1]
	end

	if not slot3 then
		return
	end

	uv0.instance:syncHeroGroup(slot3, slot2.heroGroupSnapshotSubId, slot0)
end

function slot0.openHeroGroupView(slot0, slot1, slot2)
	if not Season123Model.instance:getBattleContext() then
		return
	end

	Season123HeroGroupModel.instance:init(slot3.actId, slot3.layer, slot3.episodeId, slot3.stage)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(slot1, slot2)

	slot7 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) and (DungeonModel.instance:getEpisodeInfo(slot2) and slot5.star == DungeonEnum.StarType.Advanced and slot5.hasRecord) and not string.nilorempty(slot7) and cjson.decode(slot7)[tostring(slot2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, slot0.handleGetFightRecordGroupReply, slot0)
		FightRpc.instance:sendGetFightRecordGroupRequest(slot2)

		return
	end

	Season123Controller.instance:openHeroGroupFightView({
		actId = slot3.actId,
		layer = slot3.layer,
		episodeId = slot3.episodeId,
		stage = slot3.stage
	})
end

function slot0.handleGetFightRecordGroupReply(slot0, slot1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0.handleGetFightRecordGroupReply, slot0)
	HeroGroupModel.instance:setReplayParam(slot1)

	if Season123Model.instance:getBattleContext() then
		Season123Controller.instance:openHeroGroupFightView({
			actId = slot2.actId,
			layer = slot2.layer,
			episodeId = slot2.episodeId,
			stage = slot2.stage
		})
	end
end

function slot0.changeEquipFromSelect(slot0, slot1, slot2)
	slot3 = Season123HeroGroupModel.instance.activityId
	slot4 = {
		index = slot1,
		equipUid = {}
	}

	for slot8, slot9 in ipairs(slot2) do
		table.insert(slot4.equipUid, slot9)
	end

	slot5 = HeroGroupModel.instance:getCurGroupMO()
	slot5.equips[slot1].equipUid = slot2

	slot5:updatePosEquips(slot4)
	uv0.instance:syncHeroGroup(slot5, slot0)
end

function slot0.checkUnloadHero(slot0, slot1, slot2, slot3)
	if not HeroGroupModel.instance:getCurGroupMO().heroList then
		return
	end

	if not Season123Model.instance:getActInfo(slot0) then
		return
	end

	slot6 = false
	slot7 = nil

	for slot11, slot12 in ipairs(slot4.heroList) do
		if slot12 ~= Activity123Enum.EmptyUid and (Season123Model.instance:getSeasonHeroMO(slot0, slot1, slot2, slot12) == nil or slot13.hpRate == nil or slot13.hpRate <= 0) then
			if slot3 then
				slot4.heroList[slot11] = Activity123Enum.EmptyUid
			end

			(slot7 or {})[slot12] = true
			slot6 = true
		end
	end

	return slot6, slot7
end

function slot0.checkUnlockLockPos(slot0, slot1, slot2)
	slot3 = HeroGroupModel.instance:getCurGroupMO()
	slot4 = Season123HeroGroupUtils.getUnlockSlotSet(slot0)

	if not Season123Model.instance:getActInfo(slot0) then
		return false
	end

	if not slot5:getStageMO(slot1) then
		return false
	end

	slot7 = false
	slot8 = nil

	for slot12, slot13 in pairs(slot3.activity104Equips) do
		if slot13.equipUid then
			for slot17, slot18 in pairs(slot13.equipUid) do
				if not slot4[Season123Model.instance:getUnlockCardIndex(slot13.index, slot17)] and not string.nilorempty(slot18) and slot18 ~= Activity123Enum.EmptyUid then
					slot13.equipUid[slot17] = Activity123Enum.EmptyUid

					table.insert(slot8 or {}, slot19)

					slot7 = true
				end
			end
		end
	end

	return slot7
end

function slot0.checkHeroGroupAvailable(slot0, slot1, slot2)
	if uv0.checkUnloadHero(slot0, slot1, slot2, true) or uv0.checkUnlockLockPos(slot0, slot1, slot2) or uv0.checkEquipClothSkill() then
		slot6 = HeroGroupModel.instance:getCurGroupMO()

		if not Season123Model.instance:getActInfo(slot0) or not slot6 then
			return
		end

		logNormal(string.format("season heroGroupId = [%s] role need unload.", slot7.heroGroupSnapshotSubId))
		uv0.instance:syncHeroGroup(slot6, slot7.heroGroupSnapshotSubId, slot0)
	end
end

function slot0.syncHeroGroup(slot0, slot1, slot2, slot3)
	Season123HeroGroupModel.instance.lastSyncGroupActId = slot3 or Season123HeroGroupModel.instance.activityId

	if HeroGroupModel.instance:getCurGroupMO() == slot1 then
		HeroSingleGroupModel.instance:setSingleGroup(slot4, true)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123, DungeonModel.instance.curSendEpisodeId, true, {
			groupIndex = slot2,
			heroGroup = slot1
		})
	elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123Retail, DungeonModel.instance.curSendEpisodeId, true, slot5)
	end
end

function slot0.handleHeroGroupIndexChanged(slot0)
	slot2 = Season123HeroGroupModel.instance.stage
	slot3 = Season123HeroGroupModel.instance.layer

	slot0:checkSeason123HeroGroup()

	if Season123Model.instance:getActInfo(Season123HeroGroupModel.instance.activityId) and HeroGroupModel.instance:getCurGroupMO() == slot4:getCurHeroGroup() then
		HeroGroupModel.instance:setCurGroupId(HeroGroupModel.instance:getCurGroupId())
	end
end

function slot0.sendStartAct123Battle(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot10 = Season123HeroGroupModel.instance.activityId
	slot11 = Season123HeroGroupModel.instance.layer

	if Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		slot11 = -1
	end

	Activity123Rpc.instance:sendStartAct123BattleRequest(slot10, slot11, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
end

function slot0.replaceHeroesDefaultEquip(slot0, slot1)
	slot4 = HeroGroupModel.instance:getCurGroupMO().equips
	slot5 = nil

	for slot9, slot10 in ipairs(slot1) do
		if Season123HeroUtils.getHeroMO(Season123HeroGroupModel.instance.activityId, slot10, Season123HeroGroupModel.instance.stage) and slot5:hasDefaultEquip() then
			for slot14, slot15 in pairs(slot4) do
				if slot15.equipUid[1] == slot5.defaultEquipUid then
					slot15.equipUid[1] = "0"

					break
				end
			end

			slot4[slot9 - 1].equipUid[1] = slot5.defaultEquipUid
		end
	end
end

function slot0.setMultiplication(slot0, slot1)
	if slot1 <= Season123HeroGroupModel.instance:getMultiplicationTicket() then
		Season123HeroGroupModel.instance.multiplication = slot1

		Season123HeroGroupModel.instance:saveMultiplication()
	end
end

function slot0.checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	if PlayerClothModel.instance:getById(HeroGroupModel.instance:getCurGroupMO().clothId) then
		return
	end

	for slot5, slot6 in ipairs(PlayerClothModel.instance:getList()) do
		if PlayerClothModel.instance:hasCloth(slot6.id) then
			HeroGroupModel.instance:replaceCloth(slot6.id)

			return true
		end
	end
end

function slot0.processReplayGroupMO(slot0)
	if slot0.isReplay then
		if slot0.replay_activity104Equip_data["-100000"] and slot0.activity104Equips[Activity123Enum.MainCharPos] then
			for slot6 = 1, #slot1 do
				slot2.equipUid[slot6] = slot1[slot6].equipUid
			end
		end

		Season123HeroGroupUtils.formation104Equips(slot0)
	end
end

slot0.instance = slot0.New()

return slot0
