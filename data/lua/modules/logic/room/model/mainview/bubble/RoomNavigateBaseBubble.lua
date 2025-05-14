module("modules.logic.room.model.mainview.bubble.RoomNavigateBaseBubble", package.seeall)

local var_0_0 = pureTable("RoomNavigateBaseBubble")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.showType = arg_1_1
	arg_1_0.bubbleDatas = {}
	arg_1_0.bubbleDataSet = {}
end

function var_0_0.addBubbleData(arg_2_0, arg_2_1)
	if arg_2_0.bubbleDataSet[arg_2_1] then
		return
	end

	table.insert(arg_2_0.bubbleDatas, arg_2_1)

	arg_2_0.bubbleDataSet[arg_2_1] = true
end

function var_0_0.removeBubbleData(arg_3_0, arg_3_1)
	if not arg_3_0.bubbleDataSet[arg_3_1] then
		return
	end

	tabletool.removeValue(arg_3_0.bubbleDatas, arg_3_1)

	arg_3_0.bubbleDataSet[arg_3_1] = nil
end

function var_0_0.clear(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.bubbleDatas) do
		arg_4_0.bubbleDatas[iter_4_0] = nil
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.bubbleDataSet) do
		arg_4_0.bubbleDataSet[iter_4_2] = nil
	end
end

function var_0_0.getShowType(arg_5_0)
	return arg_5_0.showType
end

function var_0_0.getBubbleCount(arg_6_0)
	return #arg_6_0.bubbleDatas
end

function var_0_0.getFirstBubble(arg_7_0)
	return arg_7_0.bubbleDatas[1]
end

function var_0_0.sort(arg_8_0, arg_8_1)
	if arg_8_1 then
		table.sort(arg_8_0.bubbleDatas, arg_8_1)
	end
end

return var_0_0
