module("modules.logic.versionactivity1_6.act148.model.Activity148Model", package.seeall)

slot0 = 4
slot1 = class("Activity148Model", BaseModel)

function slot1.onInit(slot0)
	slot0:initActivity148Mo()
end

function slot1.reInit(slot0)
	slot0:initActivity148Mo()
end

function slot1.initActivity148Mo(slot0)
	slot0._act148MoDict = {}

	for slot4 = 1, uv0 do
		slot5 = slot4
		slot7 = Activity148Mo.New()

		slot7:init(slot5, 0)

		slot0._act148MoDict[slot5] = slot7
	end
end

function slot1.getAct148SkillMo(slot0, slot1)
	if not slot0._act148MoDict then
		slot0:initActivity148Mo()
	end

	return slot0._act148MoDict[slot1]
end

function slot1.getTotalGotSkillPointNum(slot0)
	return slot0._totalSkillPoint and slot0._totalSkillPoint or 0
end

function slot1.onReceiveInfos(slot0, slot1)
	if not slot0._act148MoDict then
		slot0:initActivity148Mo()
	end

	slot0._actId = slot1.activityId
	slot0._totalSkillPoint = slot1.totalSkillPoint

	if #slot1.skillTrees > 0 then
		for slot6 = 1, #slot2 do
			slot0:updateAct148Mo(slot2[slot6])
		end
	else
		slot0:initActivity148Mo()
	end
end

function slot1.onReceiveLevelUpReply(slot0, slot1)
	slot0:updateAct148Mo(slot1.skillTree)
end

function slot1.onReceiveLevelDownReply(slot0, slot1)
	slot0:updateAct148Mo(slot1.skillTree)
end

function slot1.onResetSkillInfos(slot0, slot1)
	slot0._act148MoDict = {}

	for slot5 = 1, uv0 do
		slot6 = slot5
		slot8 = Activity148Mo.New()

		slot8:init(slot6, 0)

		slot0._act148MoDict[slot6] = slot8
	end
end

function slot1.updateAct148Mo(slot0, slot1)
	if not slot0._act148MoDict[slot1.type] then
		slot4 = Activity148Mo.New()

		slot4:init(slot2, slot1.level)

		slot0._act148MoDict[slot2] = slot4
	end

	slot4:updateByServerData(slot1)
end

function slot1.getAllSkillPoint(slot0)
	if not slot0._act148MoDict then
		return 0
	end

	for slot5 = 1, uv0 do
		slot8 = slot0._act148MoDict[slot5] and slot7:getLevel() or 0
		slot1 = slot1 + (slot8 > 0 and Activity148Config.instance:getAct148SkillPointCost(slot6, slot8) or 0)
	end

	return slot1 + (CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill) and slot2.quantity or 0)
end

slot1.instance = slot1.New()

return slot1
