module("modules.logic.seasonver.act123.model.Season123HeroGroupModel", package.seeall)

slot0 = class("Season123HeroGroupModel", BaseModel)

function slot0.release(slot0)
	slot0.curUnlockIndexSet = nil
	slot0.curUnlockSlotSet = nil
	slot0.animRecord = nil
	slot0.multiplication = nil
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.activityId = slot1
	slot0.layer = slot2
	slot0.episodeId = slot3
	slot0.stage = slot4
	slot0.multiplication = 1
	slot0.unlockTweenKey = Activity123Enum.AnimRecord.UnlockTweenPos .. tostring(slot0.stage)
	slot0.animRecord = Season123UnlockLocalRecord.New()

	slot0.animRecord:init(slot0.activityId, PlayerPrefsKey.Season123UnlockAnimAlreadyPlay)
	slot0:initUnlockIndex()
	slot0:initMultiplication()
end

function slot0.initUnlockIndex(slot0)
	slot0.curUnlockIndexSet = {}
	slot0.curUnlockSlotSet = {}

	if not DungeonConfig.instance:getEpisodeCO(slot0.episodeId) then
		return
	end

	if slot1.type == DungeonEnum.EpisodeType.Season123 then
		if not Season123Model.instance:getActInfo(slot0.activityId) then
			return
		end

		slot0.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(slot0.activityId)

		for slot6, slot7 in pairs(slot0.curUnlockIndexSet) do
			slot0.curUnlockIndexSet[slot6] = true

			slot0:checkAddUnlockSlot(slot6)
		end
	end
end

function slot0.initMultiplication(slot0)
	if slot0:isEpisodeSeason123Retail() then
		slot0.multiplication = math.min(PlayerPrefsHelper.getNumber(slot0:getMultiplicationKey(), 1), slot0:getMultiplicationTicket())
	else
		slot0.multiplication = slot1
	end
end

function slot0.getMultiplicationKey(slot0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), slot0.episodeId)
end

function slot0.saveMultiplication(slot0)
	PlayerPrefsHelper.setNumber(slot0:getMultiplicationKey(), slot0.multiplication)
end

function slot0.getMultiplicationTicket(slot0)
	if Season123Config.instance:getEquipItemCoin(slot0.activityId, Activity123Enum.Const.UttuTicketsCoin) then
		return CurrencyModel.instance:getCurrency(slot2) and slot3.quantity or 0
	end

	return 0
end

function slot0.checkAddUnlockSlot(slot0, slot1)
	slot2 = nil

	if slot1 >= 1 and slot1 <= Activity123Enum.MainCharPos then
		slot2 = 1
	elseif Activity123Enum.MainCharPos < slot1 and slot1 <= Activity123Enum.MainCharPos * 2 then
		slot2 = 2
	end

	if slot2 and not slot0.curUnlockSlotSet[slot2] then
		slot0.curUnlockSlotSet[slot2] = true
	end
end

function slot0.isSeasonChapter(slot0)
	if not DungeonModel.instance.curSendEpisodeId or slot1 == 0 then
		return false
	end

	if DungeonConfig.instance:getEpisodeCO(slot1).type == DungeonEnum.EpisodeType.Season123 then
		return true
	end

	return false
end

function slot0.getMainPosEquipId(slot0, slot1)
	slot2 = ModuleEnum.MaxHeroCountInGroup + 1

	if HeroGroupModel.instance:getCurGroupMO() then
		if slot3.isReplay then
			if slot3.replay_activity104Equip_data["-100000"] and slot5[slot1] then
				return slot5[slot1].equipId
			end
		elseif slot3.activity104Equips[slot2 - 1] and slot5.equipUid[slot1] then
			return uv0.instance:getItemIdByUid(slot5.equipUid[slot1])
		end
	end
end

function slot0.getItemIdByUid(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return 0
	end

	if not slot2:getItemIdByUid(slot1) then
		return 0
	end

	return slot3
end

function slot0.buildAidHeroGroup(slot0)
	if Season123Model.instance:getBattleContext() then
		if not Season123Model.instance:getActInfo(slot1.actId) then
			return
		end

		if not HeroGroupModel.instance.battleConfig or string.nilorempty(slot4.aid) then
			return
		end

		if #string.splitToNumber(slot4.aid, "#") > 0 or slot4.trialLimit > 0 then
			slot6 = {
				[slot10] = HeroGroupModel.instance:generateTempGroup(slot11)
			}

			for slot10, slot11 in ipairs(slot0.heroGroupSnapshot) do
				slot6[slot10]:setTemp(false)
				Season123HeroGroupUtils.formation104Equips(slot6[slot10])
			end

			slot0.tempHeroGroupSnapshot = slot6
		end
	end
end

function slot0.getCurrentHeroGroup(slot0)
	if not Season123Model.instance:getBattleContext() then
		return
	end

	if not Season123Model.instance:getActInfo(slot1.actId) then
		return
	end

	slot3 = nil

	if HeroGroupModel.instance.battleConfig and not string.nilorempty(slot4.aid) and (#string.splitToNumber(slot4.aid, "#") > 0 or slot4.trialLimit > 0) then
		return slot0.tempHeroGroupSnapshot[(not uv0.instance:isEpisodeSeason123(slot1.episodeId) or slot2.heroGroupSnapshotSubId) and 1]
	end

	if slot0:isEpisodeSeason123Retail(slot1.episodeId) then
		return Season123Model.instance:getRetailHeroGroup(slot3)
	elseif slot0:isEpisodeSeason123(slot1.episodeId) then
		return Season123Model.instance:getSnapshotHeroGroup(slot3)
	end
end

function slot0.isContainGroupCardUnlockTweenPos(slot0, slot1)
	if not Season123Config.instance:getSeasonEpisodeCo(slot0.activityId, slot0.stage, slot0.layer - 1) then
		return true
	end

	if not tabletool.indexOf(string.splitToNumber(slot2.unlockEquipIndex, "#"), slot1) then
		return true
	end

	return slot0.animRecord:contain(slot1, slot0.unlockTweenKey)
end

function slot0.saveGroupCardUnlockTweenPos(slot0, slot1)
	slot0.animRecord:add(slot1, slot0.unlockTweenKey)
end

function slot0.isEquipCardPosUnlock(slot0, slot1, slot2)
	return slot0.curUnlockIndexSet[Season123Model.instance:getUnlockCardIndex(slot2, slot1)] == true
end

function slot0.isSlotNeedShow(slot0, slot1)
	return slot0.curUnlockSlotSet[slot1] == true
end

function slot0.isEpisodeSeason123(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1 or slot0.episodeId) and slot2.type == DungeonEnum.EpisodeType.Season123 then
		return true
	end

	return false
end

function slot0.isEpisodeSeason123Retail(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1 or slot0.episodeId) and slot2.type == DungeonEnum.EpisodeType.Season123Retail then
		return true
	end

	return false
end

function slot0.isCardPosLimit(slot0, slot1, slot2)
	slot3, slot4 = Season123Config.instance:getCardLimitPosDict(slot1)

	if slot3 == nil or slot3[slot2 + 1] then
		return false
	end

	return true, slot4
end

function slot0.filterRule(slot0, slot1)
	slot4 = {
		[slot9] = true
	}

	for slot8, slot9 in ipairs(string.splitToNumber(Season123Config.instance:getSeasonConstStr(slot0, Activity123Enum.Const.HideRule), "#")) do
		-- Nothing
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot1) do
		slot11 = slot10[1]

		if not slot4[slot10[2]] then
			table.insert(slot5, slot10)
		end
	end

	return slot5
end

slot0.instance = slot0.New()

return slot0
