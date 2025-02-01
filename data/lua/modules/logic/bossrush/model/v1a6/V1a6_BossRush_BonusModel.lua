module("modules.logic.bossrush.model.v1a6.V1a6_BossRush_BonusModel", package.seeall)

slot0 = class("V1a6_BossRush_BonusModel", BaseModel)

function slot0.selecAchievementTab(slot0, slot1)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setAchievementMoList(slot1)
end

function slot0.selectScheduleTab(slot0, slot1)
	V1a4_BossRush_ScheduleViewListModel.instance:setScheduleMoList(slot1)
end

function slot0.selectSpecialScheduleTab(slot0, slot1)
	V2a1_BossRush_SpecialScheduleViewListModel.instance:setMoList(slot1)
end

function slot0.getScheduleRewardData(slot0, slot1)
	if BossRushModel.instance:getScheduleViewRewardList(slot1) then
		slot5 = BossRushModel.instance:getLastPointInfo(slot1) and slot4.cur or 0
		slot6 = {
			dataCount = #slot2,
			curNum = slot5,
			lastIndex = 0,
			nextIndex = 1
		}

		if slot5 == 0 then
			-- Nothing
		elseif slot4.max <= slot5 then
			slot6.lastIndex = slot3
			slot6.nextIndex = slot3
		else
			for slot10, slot11 in pairs(slot2) do
				if slot5 <= slot11.stageRewardCO.rewardPointNum then
					slot6.lastIndex = slot5 == slot12 and slot10 or slot10 - 1
					slot6.nextIndex = slot10

					break
				end
			end
		end

		slot6.lastIndex = slot6.lastIndex or 0
		slot6.nextIndex = slot6.nextIndex or 1
		slot6.lastNum = slot2[slot6.lastIndex] and slot2[slot6.lastIndex].stageRewardCO.rewardPointNum or 0
		slot6.nextNum = slot2[slot6.nextIndex] and slot2[slot6.nextIndex].stageRewardCO.rewardPointNum or 0

		return slot6
	end
end

function slot0.getScheduleProgressWidth(slot0, slot1, slot2, slot3)
	slot5, slot6 = nil

	if slot0:getScheduleRewardData(slot1) then
		slot5 = (slot4.dataCount - 1) * slot2 + slot3

		if slot4.lastIndex and slot4.nextIndex then
			if slot4.lastIndex == slot4.nextIndex then
				slot6 = slot4.lastIndex > 1 and (slot4.lastIndex - 1) * slot2 + slot3 or slot3
			else
				slot8 = (slot4.curNum - slot4.lastNum) / (slot4.nextNum - slot4.lastNum)
				slot6 = slot4.lastIndex > 0 and (slot4.lastIndex - 1 + slot8) * slot2 + slot3 or slot8 * slot3
			end
		end
	end

	return slot5, slot6
end

function slot0.getLayer4RewardData(slot0, slot1)
	if BossRushModel.instance:getSpecialScheduleViewRewardList(slot1) then
		slot4 = BossRushModel.instance:getLayer4CurScore(slot1)
		slot5 = BossRushModel.instance:getLayer4MaxRewardScore(slot1)
		slot6 = {
			dataCount = #slot2,
			curNum = slot4,
			lastIndex = 0,
			nextIndex = 1
		}

		if slot4 == 0 then
			-- Nothing
		elseif slot5 <= slot4 then
			slot6.lastIndex = slot3
			slot6.nextIndex = slot3
		else
			for slot10, slot11 in pairs(slot2) do
				if slot4 <= slot11.config.maxProgress then
					slot6.lastIndex = slot4 == slot12 and slot10 or slot10 - 1
					slot6.nextIndex = slot10

					break
				end
			end
		end

		slot6.lastIndex = slot6.lastIndex or 0
		slot6.nextIndex = slot6.nextIndex or 1
		slot6.lastNum = slot2[slot6.lastIndex] and slot2[slot6.lastIndex].config.maxProgress or 0
		slot6.nextNum = slot2[slot6.nextIndex] and slot2[slot6.nextIndex].config.maxProgress or 0

		return slot6
	end
end

function slot0.getLayer4ProgressWidth(slot0, slot1, slot2, slot3)
	slot5, slot6 = nil

	if slot0:getLayer4RewardData(slot1) then
		slot5 = (slot4.dataCount - 1) * slot2 + slot3

		if slot4.lastIndex and slot4.nextIndex then
			if slot4.lastIndex == slot4.nextIndex then
				slot6 = slot4.lastIndex > 1 and (slot4.lastIndex - 1) * slot2 + slot3 or slot3
			else
				slot8 = (slot4.curNum - slot4.lastNum) / (slot4.nextNum - slot4.lastNum)
				slot6 = slot4.lastIndex > 0 and (slot4.lastIndex - 1 + slot8) * slot2 + slot3 or slot8 * slot3
			end
		end
	end

	return slot5, slot6
end

slot0.instance = slot0.New()

return slot0
