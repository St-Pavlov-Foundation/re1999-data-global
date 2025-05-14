module("modules.logic.room.model.mainview.RoomNavigateBubbleModel", package.seeall)

local var_0_0 = class("RoomNavigateBubbleModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._categoryMap = nil

	var_0_0.super.clear(arg_3_0)
end

function var_0_0.buildCategory(arg_4_0)
	arg_4_0:clear()

	arg_4_0._categoryMap = {}

	arg_4_0:updateFactoryProgress()
	arg_4_0:updateBuildingUpgrade()
	arg_4_0:updateHeroFaith()
	arg_4_0:updateRoomGift()
	arg_4_0:updateManufacture()
	arg_4_0:updateCritterEvent()
end

function var_0_0.checkCreateCategory(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._categoryMap[arg_5_1]

	if var_5_0 == nil then
		var_5_0 = RoomNavigateBubbleCategoryMO.New()

		var_5_0:init(arg_5_1)

		arg_5_0._categoryMap[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0.updateFactoryProgress(arg_6_0)
	local var_6_0 = arg_6_0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	var_6_0:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)
	var_6_0:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)

	local var_6_1 = RoomProductionModel.instance:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		arg_6_0:collectFactoryProductProgress(iter_6_1)
	end
end

function var_0_0.updateBuildingUpgrade(arg_7_0)
	local var_7_0 = arg_7_0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	var_7_0:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
	var_7_0:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
	arg_7_0:collectHallUpgrade()

	local var_7_1 = RoomProductionModel.instance:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		arg_7_0:collectFactoryUpgrade(iter_7_1)
	end
end

function var_0_0.updateHeroFaith(arg_8_0)
	local var_8_0 = arg_8_0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory)

	var_8_0:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
	var_8_0:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
	var_8_0:cleanBubble(RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull)

	local var_8_1 = RoomCharacterModel.instance:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		arg_8_0:collectHeroFaithReward(iter_8_1)
	end
end

function var_0_0.updateRoomGift(arg_9_0)
	local var_9_0 = RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift

	arg_9_0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory):cleanBubble(var_9_0)
	arg_9_0:collectRoomGift()
end

function var_0_0.updateManufacture(arg_10_0)
	local var_10_0 = RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture

	arg_10_0:checkCreateCategory(RoomNavigateBubbleEnum.CategoryType.Factory):cleanBubble(var_10_0)
	arg_10_0:collectManufacture()
end

function var_0_0.collectFactoryProductProgress(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.config
	local var_11_1 = var_11_0 and var_11_0.type

	if var_11_1 ~= RoomProductLineEnum.ProductItemType.ProductExp and var_11_1 ~= RoomProductLineEnum.ProductItemType.ProductGold then
		return
	end

	if arg_11_1.finishCount ~= 0 then
		local var_11_2, var_11_3 = arg_11_1:getReservePer()

		if var_11_3 >= 100 then
			local var_11_4 = arg_11_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress)
			local var_11_5 = arg_11_1.id

			var_11_4:addBubbleData(var_11_5)
		end
	end
end

function var_0_0.collectHallUpgrade(arg_12_0)
	local var_12_0, var_12_1 = RoomInitBuildingHelper.canLevelUp()

	if var_12_0 then
		arg_12_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade):addBubbleData(RoomNavigateBubbleEnum.HallId)
	end
end

function var_0_0.collectFactoryUpgrade(arg_13_0, arg_13_1)
	if RoomProductionHelper.canLevelUp(arg_13_1) then
		local var_13_0 = arg_13_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
		local var_13_1 = arg_13_1.id

		var_13_0:addBubbleData(var_13_1)
	end
end

function var_0_0.collectHeroFaithReward(arg_14_0, arg_14_1)
	if arg_14_1.currentFaith > 0 then
		local var_14_0 = arg_14_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward)
		local var_14_1 = arg_14_1.heroId

		var_14_0:addBubbleData(var_14_1)
	end
end

function var_0_0.collectHeroFaithFull(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.heroId

	if RoomCharacterController.instance:isCharacterFaithFull(var_15_0) and RoomCharacterModel.instance:isShowFaithFull(var_15_0) then
		arg_15_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull):addBubbleData(var_15_0)
	end
end

function var_0_0.collectRoomGift(arg_16_0)
	if not RoomGiftModel.instance:isCanGetBonus() then
		return
	end

	arg_16_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift):addBubbleData(RoomNavigateBubbleEnum.HallId)
end

function var_0_0.collectManufacture(arg_17_0)
	local var_17_0 = ManufactureModel.instance:getAllBuildingCanClaimProducts()

	if not var_17_0 or #var_17_0 <= 0 then
		return
	end

	local var_17_1 = arg_17_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture)

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		var_17_1:addBubbleData(iter_17_1.uid)
	end
end

function var_0_0.updateCritterEvent(arg_18_0)
	local var_18_0 = CritterModel.instance:getAllCritters()
	local var_18_1 = arg_18_0._categoryMap[RoomNavigateBubbleEnum.CategoryType.Factory]:getOrCreateBubbleMO(RoomNavigateBubbleEnum.FactoryBubbleType.Critter)
	local var_18_2

	for iter_18_0 = 1, #var_18_0 do
		local var_18_3 = var_18_0[iter_18_0]
		local var_18_4 = var_18_3:isNoMoodWorking()
		local var_18_5 = var_18_3:isCultivating()
		local var_18_6 = var_18_3.trainInfo:isHasEventTrigger()
		local var_18_7 = var_18_3.trainInfo:isTrainFinish()

		if var_18_4 or var_18_5 and (var_18_6 or var_18_7) then
			var_18_2 = var_18_2 or {}

			table.insert(var_18_2, var_18_3)
		end
	end

	var_18_1:clear()

	if var_18_2 then
		table.sort(var_18_2, CritterHelper.sortEvent)

		for iter_18_1, iter_18_2 in ipairs(var_18_2) do
			var_18_1:addBubbleData(iter_18_2.id)
		end
	end
end

function var_0_0.sortCategory(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._categoryMap) do
		iter_19_1:sort()
	end
end

function var_0_0.getCategoryMap(arg_20_0)
	return arg_20_0._categoryMap
end

var_0_0.instance = var_0_0.New()

return var_0_0
