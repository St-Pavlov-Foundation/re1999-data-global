module("framework.mvc.model.TreeScrollModel", package.seeall)

local var_0_0 = class("TreeScrollModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0._stopUpdate = false
	arg_1_0._scrollViews = {}
	arg_1_0._moList = {}
end

function var_0_0.reInitInternal(arg_2_0)
	var_0_0.super.reInitInternal(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._scrollViews) do
		if iter_2_1.clear then
			iter_2_1:clear()
		end
	end
end

function var_0_0.clear(arg_3_0)
	arg_3_0._stopUpdate = false
	arg_3_0._moList = {}

	arg_3_0:onModelUpdate()
end

function var_0_0.getInfoList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0:getRootCount()

	for iter_4_0 = 1, var_4_1 do
		local var_4_2 = {}
		local var_4_3 = arg_4_0._moList[iter_4_0].treeRootParam

		var_4_2.rootType = var_4_3.rootType or 0
		var_4_2.rootIndex = iter_4_0 - 1
		var_4_2.rootLength = var_4_3.rootLength or 0
		var_4_2.nodeType = var_4_3.nodeType or 0
		var_4_2.nodeLength = var_4_3.nodeLength or 0
		var_4_2.nodeStartSpace = var_4_3.nodeStartSpace or 0
		var_4_2.nodeEndSpace = var_4_3.nodeEndSpace or 0
		var_4_2.nodeCountEachLine = var_4_3.nodeCountEachLine or 0
		var_4_2.isExpanded = var_4_3.isExpanded or false
		var_4_2.nodeCount = arg_4_0:getNodeCount(iter_4_0)

		if var_4_2.nodeCountEachLine <= 0 then
			var_4_2.nodeCountEachLine = 1
		end

		var_4_0[iter_4_0] = var_4_2
	end

	return var_4_0
end

function var_0_0.getRootCount(arg_5_0)
	return #arg_5_0._moList
end

function var_0_0.getNodeCount(arg_6_0, arg_6_1)
	return #arg_6_0._moList[arg_6_1].children
end

function var_0_0.getByIndex(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == 0 then
		return arg_7_0._moList[arg_7_1].mo
	else
		return arg_7_0._moList[arg_7_1].children[arg_7_2]
	end
end

function var_0_0.addRoot(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = #arg_8_0._moList

	if not arg_8_3 or arg_8_3 > var_8_0 + 1 then
		arg_8_3 = var_8_0 + 1
	elseif arg_8_3 < 1 then
		arg_8_3 = 1
	end

	table.insert(arg_8_0._moList, arg_8_3, {
		mo = arg_8_1,
		treeRootParam = arg_8_2,
		children = {}
	})
	arg_8_0:onModelUpdate()
end

function var_0_0.addNode(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0._moList[arg_9_2].children
	local var_9_1 = #var_9_0

	if not arg_9_3 or arg_9_3 > var_9_1 + 1 then
		arg_9_3 = var_9_1 + 1
	elseif arg_9_3 < 1 then
		arg_9_3 = 1
	end

	table.insert(var_9_0, arg_9_3, arg_9_1)

	arg_9_0._moList[arg_9_2].children = var_9_0

	arg_9_0:onModelUpdate()
end

function var_0_0.removeRoot(arg_10_0, arg_10_1)
	if not arg_10_1 or arg_10_1 < 1 then
		return nil
	end

	if arg_10_1 > #arg_10_0._moList then
		return nil
	end

	local var_10_0 = table.remove(arg_10_0._moList, arg_10_1)

	arg_10_0:onModelUpdate()

	return var_10_0.mo
end

function var_0_0.removeNode(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 or arg_11_1 < 1 then
		return nil
	end

	if arg_11_1 > #arg_11_0._moList then
		return nil
	end

	local var_11_0 = table.remove(arg_11_0._moList[arg_11_1].children, arg_11_2)

	arg_11_0:onModelUpdate()

	return var_11_0
end

function var_0_0.stopUpdate(arg_12_0)
	arg_12_0._stopUpdate = true
end

function var_0_0.resumeUpdate(arg_13_0)
	arg_13_0._stopUpdate = false

	arg_13_0:onModelUpdate()
end

function var_0_0.onModelUpdate(arg_14_0)
	if arg_14_0._stopUpdate then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._scrollViews) do
		iter_14_1:onModelUpdate()
	end
end

function var_0_0.addScrollView(arg_15_0, arg_15_1)
	table.insert(arg_15_0._scrollViews, arg_15_1)
end

function var_0_0.removeScrollView(arg_16_0, arg_16_1)
	tabletool.removeValue(arg_16_0._scrollViews, arg_16_1)
end

return var_0_0
