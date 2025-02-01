module("modules.logic.versionactivity1_4.act129.model.Activity129Model", package.seeall)

slot0 = class("Activity129Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0.selectPoolId = nil
end

function slot0.setInfo(slot0, slot1)
	slot0:getActivityMo(slot1.activityId):init(slot1)
end

function slot0.onLotterySuccess(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9 = 1, #slot1.rewards do
		slot10 = slot2[slot9]
		slot16 = slot10.rewardId
		slot11 = Activity129Config.instance:getRewardConfig(slot1.poolId, slot10.rare, slot10.rewardType, slot16)

		for slot16 = 1, slot10.num do
			if slot10.rare == 5 then
				if Activity129Config.instance:getPoolConfig(slot1.activityId, slot1.poolId).type ~= Activity129Enum.PoolType.Unlimite then
					table.insert(slot4, slot11)
				end

				table.insert(slot3, slot11)
			else
				table.insert(slot5, slot11)
			end
		end
	end

	tabletool.addValues(slot3, slot5)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnShowSpecialReward, slot4, slot3)
	slot0:getActivityMo(slot1.activityId):onLotterySuccess(slot1)
end

function slot0.getActivityMo(slot0, slot1)
	if not slot0:getById(slot1) then
		slot0:addAtLast(Activity129Mo.New(slot1))
	end

	return slot2
end

function slot0.getShopVoiceConfig(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getHeroShopVoice(slot1, slot4) or not next(slot6) then
		return {}
	end

	for slot10, slot11 in pairs(slot6) do
		if slot11.type == slot2 and (not slot3 or slot3(slot11)) then
			table.insert(slot5, slot11)
		end
	end

	return slot5
end

function slot0.getHeroShopVoice(slot0, slot1, slot2)
	if not CharacterDataConfig.instance:getCharacterShopVoicesCo(slot1) then
		return {}
	end

	for slot8, slot9 in pairs(slot4) do
		if slot0:_checkSkin(slot9, slot2) then
			slot3[slot9.audio] = slot9
		end
	end

	return slot3
end

function slot0._checkSkin(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	if string.nilorempty(slot1.skins) or not slot2 then
		return true
	end

	return string.find(slot1.skins, slot2)
end

function slot0.setSelectPoolId(slot0, slot1, slot2)
	slot0.selectPoolId = slot1

	if not slot2 then
		Activity129Controller.instance:dispatchEvent(Activity129Event.OnEnterPool)
	end
end

function slot0.getSelectPoolId(slot0)
	return slot0.selectPoolId
end

function slot0.checkPoolIsEmpty(slot0, slot1, slot2)
	return slot0:getActivityMo(slot1):checkPoolIsEmpty(slot2)
end

slot0.instance = slot0.New()

return slot0
