module("modules.logic.bossrush.model.V1a4_BossRush_ScheduleViewListModel", package.seeall)

slot0 = class("V1a4_BossRush_ScheduleViewListModel", ListScrollModel)

function slot0.setStaticData(slot0, slot1)
	slot0._staticData = slot1
end

function slot0.getStaticData(slot0)
	return slot0._staticData
end

function slot0.getFinishCount(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot1) do
		if not slot8.isGot and slot8.isAlready then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.setScheduleMoList(slot0, slot1)
	slot2 = BossRushModel.instance:getScheduleViewRewardList(slot1)

	for slot8, slot9 in pairs(slot2) do
		slot9.isAlready = slot9.stageRewardCO.rewardPointNum <= (BossRushModel.instance:getLastPointInfo(slot1) and slot3.cur or 0)
		slot9.stage = slot1
	end

	if slot0:getFinishCount(slot2, slot1) > 1 then
		table.insert(slot2, 1, {
			getAll = true,
			stage = slot1
		})
	end

	table.sort(slot2, slot0._sort)
	slot0:setList(slot2)
end

function slot0._sort(slot0, slot1)
	if slot0.getAll then
		return true
	end

	if slot1.getAll then
		return false
	end

	slot2 = slot0.stageRewardCO
	slot4 = slot2.id
	slot5 = slot2.id
	slot8 = slot0.isAlready and 1 or 0
	slot9 = slot1.isAlready and 1 or 0
	slot10 = slot2.rewardPointNum
	slot11 = slot1.stageRewardCO.rewardPointNum

	if (slot0.isGot and 1 or 0) ~= (slot1.isGot and 1 or 0) then
		return slot6 < slot7
	end

	if slot8 ~= slot9 then
		return slot9 < slot8
	end

	if slot10 ~= slot11 then
		return slot10 < slot11
	end

	return slot4 < slot5
end

slot0.instance = slot0.New()

return slot0
