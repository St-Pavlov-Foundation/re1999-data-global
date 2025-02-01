module("modules.logic.versionactivity1_3.astrology.model.VersionActivity1_3AstrologyModel", package.seeall)

slot0 = class("VersionActivity1_3AstrologyModel", BaseModel)

function slot0.onInit(slot0)
	slot0._planetList = {}
end

function slot0.reInit(slot0)
	slot0._planetList = {}
	slot0._rewardList = nil
	slot0._exchangeList = nil
end

function slot0.initData(slot0)
	if string.nilorempty(Activity126Model.instance:getStarProgressStr()) then
		slot1 = Activity126Config.instance:getConst(VersionActivity1_3Enum.ActivityId.Act310, Activity126Enum.constId.initAngle).value2
	end

	for slot6 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		slot0:_addPlanetData(slot6, string.splitToNumber(slot1, "#")[slot6 - 1] or 0, ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, VersionActivity1_3AstrologyEnum.PlanetItem[slot6]))
	end
end

function slot0._addPlanetData(slot0, slot1, slot2, slot3)
	slot4 = slot0._planetList[slot1] or VersionActivity1_3AstrologyPlanetMo.New()

	slot4:init({
		id = slot1,
		angle = slot2,
		previewAngle = slot2,
		num = slot3
	})

	slot0._planetList[slot1] = slot4
end

function slot0.getQuadrantResult(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in pairs(slot0._planetList) do
		slot9 = slot1[slot7:getQuadrant()] or {
			minId = 100,
			num = 0,
			quadrant = slot8,
			planetList = {}
		}
		slot9.num = slot9.num + 1

		if slot6 < slot9.minId then
			slot9.minId = slot6
		end

		slot1[slot8] = slot9
		slot2[slot6] = slot8
	end

	if slot2[VersionActivity1_3AstrologyEnum.Planet.yueliang] == 7 or slot3 == 8 then
		return slot3
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot1) do
		table.insert(slot4, slot9)
	end

	table.sort(slot4, slot0._sortResult)

	return slot4[1].quadrant
end

function slot0._sortResult(slot0, slot1)
	if slot0.num == slot1.num then
		return slot0.minId < slot1.minId
	end

	return slot1.num < slot0.num
end

function slot0.generateStarProgressStr(slot0)
	for slot5 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		slot7 = slot0._planetList[slot5].previewAngle
		slot1 = (not string.nilorempty(nil) or string.format("%s", slot7)) and string.format("%s#%s", string.format("%s", slot7), slot7)
	end

	return slot1
end

function slot0.generateStarProgressCost(slot0)
	slot1 = {}

	for slot6 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		if slot0._planetList[slot6]:getCostNum() > 0 then
			for slot12 = 1, slot8 do
				table.insert(slot1, VersionActivity1_3AstrologyEnum.PlanetItem[slot6])
			end
		end
	end

	return slot1, {
		[slot6] = true
	}
end

function slot0.getPlanetMo(slot0, slot1)
	return slot0._planetList[slot1]
end

function slot0.hasAdjust(slot0)
	for slot4, slot5 in pairs(slot0._planetList) do
		if slot5:hasAdjust() then
			return true
		end
	end
end

function slot0.isEffectiveAdjust(slot0)
	if Activity126Model.instance:getStarNum() >= 10 then
		return false
	end

	return slot0:hasAdjust()
end

function slot0.getAdjustNum(slot0)
	for slot5, slot6 in pairs(slot0._planetList) do
		slot1 = 0 + slot6:getCostNum()
	end

	return slot1
end

function slot0.setStarReward(slot0, slot1)
	slot0._rewardList = slot1
end

function slot0.getStarReward(slot0)
	return slot0._rewardList
end

function slot0.setExchangeList(slot0, slot1)
	slot0._exchangeList = slot1
end

function slot0.getExchangeList(slot0)
	return slot0._exchangeList
end

slot0.instance = slot0.New()

return slot0
