module("modules.logic.fight.model.data.FightLYDataMgr", package.seeall)

slot0 = FightDataClass("FightLYDataMgr")

function slot0.onConstructor(slot0)
	slot0.LYCardAreaSize = 0
	slot0.LYPointAreaSize = 0
	slot0.pointList = nil
end

function slot0.setLYCardAreaBuff(slot0, slot1)
	slot0.cardAreaBuff = slot1
	slot0.LYCardAreaSize = 0

	if FightBuffHelper.getFeatureList(slot1 and slot1:getCO(), FightEnum.BuffType_CardAreaRedOrBlue) then
		slot0.LYCardAreaSize = tonumber(slot3[2])
	end

	FightController.instance:dispatchEvent(FightEvent.LY_CardAreaSizeChange)
end

function slot0.getCardColor(slot0, slot1, slot2)
	if (slot1 and #slot1 or 0) - slot2 < slot0.LYCardAreaSize and slot2 <= slot0.LYCardAreaSize then
		return FightEnum.CardColor.Both
	end

	if slot4 then
		return FightEnum.CardColor.Blue
	end

	if slot5 then
		return FightEnum.CardColor.Red
	end

	return FightEnum.CardColor.None
end

function slot0.setLYCountBuff(slot0, slot1)
	slot0.countBuff = slot1

	slot0:refreshPointList()
	slot0:refreshShowAreaSize()
end

function slot0.setLYChangeTriggerBuff(slot0, slot1)
	slot0.changeTriggerBuff = slot1

	slot0:refreshShowAreaSize()
end

function slot0.refreshShowAreaSize(slot0)
	slot0.LYPointAreaSize = 0

	if slot0.countBuff then
		if FightBuffHelper.getFeatureList(slot0.countBuff:getCO(), FightEnum.BuffType_RedOrBlueCount) then
			slot0.LYPointAreaSize = tonumber(slot2[2])
		end

		if slot0.changeTriggerBuff and FightBuffHelper.getFeatureList(slot0.changeTriggerBuff:getCO(), FightEnum.BuffType_RedOrBlueChangeTrigger) then
			slot0.LYPointAreaSize = slot0.LYPointAreaSize + (tonumber(slot2[2]) or 0) * slot0.changeTriggerBuff.layer
		end
	end

	FightController.instance:dispatchEvent(FightEvent.LY_PointAreaSizeChange)
end

function slot0.getPointList(slot0)
	return slot0.pointList
end

function slot0.refreshPointList(slot0, slot1)
	slot2 = slot0.pointList and #slot0.pointList or 0

	if not slot0.countBuff then
		slot0.pointList = nil

		FightController.instance:dispatchEvent(FightEvent.LY_HadRedAndBluePointChange, slot0.pointList, slot2)

		return
	end

	if not slot1 and slot2 > #FightStrUtil.instance:getSplitToNumberCache(slot0.countBuff.actCommonParams, "#") then
		return
	end

	slot0.pointList = tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(slot0.countBuff.actCommonParams, "#"))

	table.remove(slot0.pointList, 1)
	FightController.instance:dispatchEvent(FightEvent.LY_HadRedAndBluePointChange, slot0.pointList, slot2)
end

function slot0.hasCountBuff(slot0)
	return slot0.countBuff ~= nil
end

return slot0
