module("modules.logic.room.model.mainview.RoomNavigateBubbleModel", package.seeall)

slot0 = class("RoomNavigateBubbleModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0._categoryMap = nil

	uv0.super.clear(slot0)
end

function slot0.buildCategory(slot0)
	slot0:clear()

	slot0._categoryMap = {}

	slot0:updateFactoryProgress()
	slot0:updateBuildingUpgrade()
	slot0:updateHeroFaith()
	slot0:updateRoomGift()
	slot0:updateManufacture()
	slot0:updateCritterEvent()
end

function slot0.checkCreateCategory(slot0, slot1)
	if slot0._categoryMap[slot1] == nil then
		slot2 = RoomNavigateBubbleCategoryMO.New()

		slot2:init(slot1)

		slot0._categoryMap[slot1] = slot2
	end

	return slot2
end

function slot0.updateFactoryProgress(slot0)
	slot1 = slot0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	slot1:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)
	slot1:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)

	for slot6, slot7 in ipairs(RoomProductionModel.instance:getList()) do
		slot0:collectFactoryProductProgress(slot7)
	end
end

function slot0.updateBuildingUpgrade(slot0)
	slot1 = slot0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	slot1:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
	slot1:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
	slot0:collectHallUpgrade()

	for slot6, slot7 in ipairs(RoomProductionModel.instance:getList()) do
		slot0:collectFactoryUpgrade(slot7)
	end
end

function slot0.updateHeroFaith(slot0)
	slot1 = slot0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	slot1:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
	slot1:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
	slot1:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull)

	for slot6, slot7 in ipairs(RoomCharacterModel.instance:getList()) do
		slot0:collectHeroFaithReward(slot7)
	end
end

function slot0.updateRoomGift(slot0)
	slot0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory):cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift)
	slot0:collectRoomGift()
end

function slot0.updateManufacture(slot0)
	slot0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory):cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture)
	slot0:collectManufacture()
end

function slot0.collectFactoryProductProgress(slot0, slot1)
	if (slot1.config and slot2.type) ~= RoomProductLineEnum.ProductItemType.ProductExp and slot3 ~= RoomProductLineEnum.ProductItemType.ProductGold then
		return
	end

	if slot1.finishCount ~= 0 then
		slot4, slot5 = slot1:getReservePer()

		if slot5 >= 100 then
			slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress):addBubbleData(slot1.id)
		end
	end
end

function slot0.collectHallUpgrade(slot0)
	slot1, slot2 = RoomInitBuildingHelper.canLevelUp()

	if slot1 then
		slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade):addBubbleData(RoomNavigateBubbleEnum.HallId)
	end
end

function slot0.collectFactoryUpgrade(slot0, slot1)
	if RoomProductionHelper.canLevelUp(slot1) then
		slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade):addBubbleData(slot1.id)
	end
end

function slot0.collectHeroFaithReward(slot0, slot1)
	if slot1.currentFaith > 0 then
		slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward):addBubbleData(slot1.heroId)
	end
end

function slot0.collectHeroFaithFull(slot0, slot1)
	if RoomCharacterController.instance:isCharacterFaithFull(slot1.heroId) and RoomCharacterModel.instance:isShowFaithFull(slot2) then
		slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull):addBubbleData(slot2)
	end
end

function slot0.collectRoomGift(slot0)
	if not RoomGiftModel.instance:isCanGetBonus() then
		return
	end

	slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift):addBubbleData(RoomNavigateBubbleEnum.HallId)
end

function slot0.collectManufacture(slot0)
	if not ManufactureModel.instance:getAllBuildingCanClaimProducts() or #slot1 <= 0 then
		return
	end

	for slot7, slot8 in ipairs(slot1) do
		slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture):addBubbleData(slot8.uid)
	end
end

function slot0.updateCritterEvent(slot0)
	slot3 = slot0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.Critter)
	slot4 = nil

	for slot8 = 1, #CritterModel.instance:getAllCritters() do
		slot9 = slot1[slot8]

		if slot9:isNoMoodWorking() or slot9:isCultivating() and (slot9.trainInfo:isHasEventTrigger() or slot9.trainInfo:isTrainFinish()) then
			table.insert(slot4 or {}, slot9)
		end
	end

	slot3:clear()

	if slot4 then
		slot8 = CritterHelper.sortEvent

		table.sort(slot4, slot8)

		for slot8, slot9 in ipairs(slot4) do
			slot3:addBubbleData(slot9.id)
		end
	end
end

function slot0.sortCategory(slot0)
	for slot4, slot5 in pairs(slot0._categoryMap) do
		slot5:sort()
	end
end

function slot0.getCategoryMap(slot0)
	return slot0._categoryMap
end

slot0.instance = slot0.New()

return slot0
