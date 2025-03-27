module("modules.logic.versionactivity2_4.pinball.model.PinballBuildingMo", package.seeall)

slot0 = pureTable("PinballBuildingMo")

function slot0.init(slot0, slot1)
	slot0.configId = slot1.configId
	slot0.level = slot1.level
	slot0.index = slot1.index
	slot0.food = slot1.food
	slot0.interact = slot1.interact

	slot0:refreshCo()
end

function slot0.refreshCo(slot0)
	if not lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0.configId] then
		logError("没有建筑配置" .. tostring(slot0.configId))

		return
	end

	slot0.co = slot1[slot0.level]
	slot0.baseCo = slot1[1]
	slot0.nextCo = slot1[slot0.level + 1]
	slot0._foodCost = 0
	slot0._playDemand = 0

	if slot0.co then
		for slot6, slot7 in pairs(GameUtil.splitString2(slot0.co.effect, true) or {}) do
			if slot7[1] == PinballEnum.BuildingEffectType.CostFood then
				slot0._foodCost = slot0._foodCost + slot7[2]
			elseif slot7[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				slot0._playDemand = slot0._playDemand + slot7[2]
			end
		end
	end
end

function slot0.upgrade(slot0)
	slot0.level = slot0.level + 1

	slot0:refreshCo()
end

function slot0.isMainCity(slot0)
	return slot0.co.type == PinballEnum.BuildingType.MainCity
end

function slot0.isTalent(slot0)
	return slot0.co.type == PinballEnum.BuildingType.Talent
end

function slot0.getFoodCost(slot0)
	return slot0._foodCost
end

function slot0.getPlayDemand(slot0)
	return slot0._playDemand
end

return slot0
