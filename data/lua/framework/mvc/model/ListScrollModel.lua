module("framework.mvc.model.ListScrollModel", package.seeall)

local var_0_0 = class("ListScrollModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._scrollViews = {}
end

function var_0_0.reInitInternal(arg_2_0)
	var_0_0.super.reInitInternal(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._scrollViews) do
		if iter_2_1.clear then
			iter_2_1:clear()
		end
	end
end

function var_0_0.addScrollView(arg_3_0, arg_3_1)
	table.insert(arg_3_0._scrollViews, arg_3_1)
end

function var_0_0.removeScrollView(arg_4_0, arg_4_1)
	tabletool.removeValue(arg_4_0._scrollViews, arg_4_1)
end

function var_0_0.onModelUpdate(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._scrollViews) do
		iter_5_1:onModelUpdate()
	end
end

function var_0_0.selectCell(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._scrollViews) do
		iter_6_1:selectCell(arg_6_1, arg_6_2)
	end
end

function var_0_0.sort(arg_7_0, arg_7_1)
	var_0_0.super.sort(arg_7_0, arg_7_1)
	arg_7_0:onModelUpdate()
end

function var_0_0.addList(arg_8_0, arg_8_1)
	var_0_0.super.addList(arg_8_0, arg_8_1)
	arg_8_0:onModelUpdate()
end

function var_0_0.addAt(arg_9_0, arg_9_1, arg_9_2)
	var_0_0.super.addAt(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:onModelUpdate()
end

function var_0_0.removeAt(arg_10_0, arg_10_1)
	local var_10_0 = var_0_0.super.removeAt(arg_10_0, arg_10_1)

	arg_10_0:onModelUpdate()

	return var_10_0
end

function var_0_0.clear(arg_11_0)
	var_0_0.super.clear(arg_11_0)
	arg_11_0:onModelUpdate()
end

return var_0_0
