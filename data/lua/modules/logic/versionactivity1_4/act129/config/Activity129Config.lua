module("modules.logic.versionactivity1_4.act129.config.Activity129Config", package.seeall)

slot0 = class("Activity129Config", BaseConfig)

function slot0.ctor(slot0)
	slot0.poolDict = {}
	slot0.constDict = {}
	slot0.goodsDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity129_pool",
		"activity129_const",
		"activity129_goods"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("on%sConfigLoaded", slot1)] then
		slot4(slot0, slot1, slot2)
	end
end

function slot0.onactivity129_poolConfigLoaded(slot0, slot1, slot2)
	slot0.poolDict = slot2.configDict
end

function slot0.onactivity129_constConfigLoaded(slot0, slot1, slot2)
	slot0.constDict = slot2.configDict
end

function slot0.onactivity129_goodsConfigLoaded(slot0, slot1, slot2)
	slot0.goodsDict = slot2.configDict
end

function slot0.getConstValue1(slot0, slot1, slot2)
	if not (slot0.constDict[slot1] and slot3[slot2] and slot3[slot2].value1) then
		logError(string.format("can not find constvalue! activityId:%s constId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getConstValue2(slot0, slot1, slot2)
	if not (slot0.constDict[slot1] and slot3[slot2] and slot3[slot2].value2) then
		logError(string.format("can not find constvalue! activityId:%s constId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getPoolConfig(slot0, slot1, slot2)
	if not (slot0.poolDict[slot1] and slot3[slot2]) then
		logError(string.format("can not find pool config! activityId:%s poolId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getPoolDict(slot0, slot1)
	return slot0.poolDict[slot1]
end

function slot0.getGoodsDict(slot0, slot1)
	return slot0.goodsDict[slot1]
end

function slot0.getRewardConfig(slot0, slot1, slot2, slot3, slot4)
	if not slot0.rewardDict then
		slot0.rewardDict = {}

		for slot8, slot9 in pairs(slot0.goodsDict) do
			slot0.rewardDict[slot8] = {}

			for slot13, slot14 in pairs(slot9) do
				slot0.rewardDict[slot8][slot13] = {}

				if GameUtil.splitString2(slot14.goodsId, true) then
					for slot19, slot20 in ipairs(slot15) do
						if not slot0.rewardDict[slot8][slot13][slot20[1]] then
							slot0.rewardDict[slot8][slot13][slot20[1]] = {}
						end

						slot0.rewardDict[slot8][slot13][slot20[1]][slot20[2]] = slot20
					end
				end
			end
		end
	end

	if not slot0.rewardDict[slot1] then
		return
	end

	if not slot0.rewardDict[slot1][slot2] then
		return
	end

	if not slot0.rewardDict[slot1][slot2][slot3] then
		return
	end

	return slot0.rewardDict[slot1][slot2][slot3][slot4]
end

slot0.instance = slot0.New()

return slot0
