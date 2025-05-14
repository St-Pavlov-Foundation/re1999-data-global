module("modules.logic.room.model.mainview.bubble.RoomNavigateBubbleCategoryMO", package.seeall)

local var_0_0 = pureTable("RoomNavigateBubbleCategoryMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.showType = arg_1_1
	arg_1_0._buildingBubblesDict = {}
	arg_1_0._buildingBubblesList = {}
end

local var_0_1 = {}

function var_0_0.getOrCreateBubbleMO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._buildingBubblesDict[arg_2_1]

	if not var_2_0 then
		var_2_0 = (var_0_1[arg_2_1] or RoomNavigateBaseBubble).New()

		var_2_0:init(arg_2_1)

		arg_2_0._buildingBubblesDict[arg_2_1] = var_2_0
		arg_2_0._buildingBubblesList[#arg_2_0._buildingBubblesList + 1] = var_2_0
	end

	return var_2_0
end

function var_0_0.cleanBubble(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._buildingBubblesDict[arg_3_1]

	if var_3_0 then
		var_3_0:clear()
	end
end

function var_0_0.getBubbles(arg_4_0)
	return arg_4_0._buildingBubblesList
end

function var_0_0.getBubbleByType(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_0._buildingBubblesDict and arg_5_1 then
		var_5_0 = arg_5_0._buildingBubblesDict[arg_5_1]
	end

	return var_5_0
end

function var_0_0.getBubblesCount(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0._buildingBubblesDict) do
		var_6_0 = var_6_0 + iter_6_1:getBubbleCount()
	end

	return var_6_0
end

function var_0_0.sort(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._buildingBubblesDict) do
		local var_7_0 = RoomNavigateBubbleController.sortFunc[arg_7_0.showType][iter_7_1.showType]

		if var_7_0 then
			iter_7_1:sort(var_7_0)
		end
	end
end

return var_0_0
