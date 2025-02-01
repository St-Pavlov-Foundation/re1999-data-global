module("modules.logic.seasonver.act123.model.Season123RecordModel", package.seeall)

slot0 = class("Season123RecordModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setServerDataVerifiableId(slot0, slot1, slot2)
	slot0._tmpVerifiableActId = slot1
	slot0._tmpVerifiableStage = slot2
end

function slot0.setSeason123ServerRecordData(slot0, slot1)
	slot0:clear()

	if not slot1 then
		return
	end

	slot2, slot3 = slot0:getServerDataVerifiableId()

	if slot1.activityId ~= slot2 or slot1.stage ~= slot3 then
		return
	end

	slot0:setServerDataVerifiableId()

	if not slot1.stageRecords then
		return
	end

	for slot8 = 1, Activity123Enum.RecordItemCount do
		if slot4[slot8] then
			-- Nothing
		else
			slot9.isEmpty = true
		end

		slot0:addAtLast({
			round = slot10.round,
			isBest = slot10.isBest,
			heroList = slot0:_getHeroDataByServerData(slot10.stageRecordHeros),
			attackStatistics = slot0:_geAttackStatisticsByServerData(slot10.attackStatistics, slot12)
		})
	end
end

function slot0.getServerDataVerifiableId(slot0)
	return slot0._tmpVerifiableActId, slot0._tmpVerifiableStage
end

function slot0.getRecordList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		slot9 = slot8.isBest

		if slot1 and slot9 or not slot1 and not slot9 then
			slot2[#slot2 + 1] = slot8
		end
	end

	return slot2
end

function slot0._getHeroDataByServerData(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {}
	slot3 = {}

	for slot7 = 1, Activity123Enum.PickHeroCount do
		slot9 = {
			heroId = 0,
			uid = 0,
			uid = slot8.heroUid,
			heroId = slot8.heroId,
			skinId = slot8.skinId,
			isAssist = slot8.isAssist,
			isBalance = slot8.isBalance,
			level = slot8.level
		}

		if slot1[slot7] then
			-- Nothing
		end

		slot2[slot7] = slot9
		slot3[slot9.uid] = slot9
	end

	return slot2, slot3
end

function slot0._geAttackStatisticsByServerData(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = {
			heroUid = slot8.heroUid,
			harm = slot8.harm,
			hurt = slot8.hurt,
			heal = slot8.heal
		}

		for slot14, slot15 in ipairs(slot8.cards) do
			-- Nothing
		end

		slot9.cards = {
			[slot14] = {
				skillId = slot15.skillId,
				useCount = slot15.useCount
			}
		}
		slot9.getBuffs = slot8.getBuffs
		slot11 = slot2 and slot2[slot9.heroUid] or {}
		slot9.entityMO = FightHelper.getEmptyFightEntityMO(slot9.heroUid, slot11 and slot11.heroId or 0, slot11 and slot11.level or 1, slot11 and slot11.skinId)
		slot3[slot7] = slot9
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
