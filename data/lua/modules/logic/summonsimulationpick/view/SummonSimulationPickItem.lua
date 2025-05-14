module("modules.logic.summonsimulationpick.view.SummonSimulationPickItem", package.seeall)

local var_0_0 = class("SummonSimulationPickItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "heroicon/#image_icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._heroItems = {}
	arg_2_0._goheroItem = gohelper.findChild(arg_2_0._go, "#scroll_result/Viewport/content/#go_heroitem")
	arg_2_0._root = gohelper.findChild(arg_2_0._go, "#scroll_result/Viewport/content")

	gohelper.setActive(arg_2_0._goheroItem, false)
end

function var_0_0.refreshData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.selectType = arg_3_2

	local var_3_0 = arg_3_0._heroItems
	local var_3_1 = #var_3_0
	local var_3_2 = arg_3_1 and #arg_3_1 or 0

	for iter_3_0 = 1, var_3_2 do
		local var_3_3

		if var_3_1 < iter_3_0 then
			local var_3_4 = arg_3_0:getItem()

			var_3_3 = SummonSimulationPickListItem.New()

			var_3_3:init(var_3_4)
			table.insert(var_3_0, var_3_3)
		else
			var_3_3 = var_3_0[iter_3_0]
		end

		gohelper.setActive(var_3_3.go, true)

		local var_3_5 = arg_3_1[iter_3_0]

		var_3_3:setData(var_3_5, arg_3_0.selectType)
	end

	if var_3_2 < var_3_1 then
		for iter_3_1 = var_3_2 + 1, var_3_1 do
			local var_3_6 = var_3_0[iter_3_1]

			gohelper.setActive(var_3_6.go, false)
		end
	end
end

function var_0_0.getItem(arg_4_0)
	local var_4_0 = arg_4_0._goheroItem

	return (gohelper.clone(var_4_0, arg_4_0._root))
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._go, arg_5_1)
end

function var_0_0.setParent(arg_6_0, arg_6_1)
	arg_6_0._go.transform.parent = arg_6_1.transform

	transformhelper.setLocalPosXY(arg_6_0._go.transform, 0, 0)
end

function var_0_0.getTransform(arg_7_0)
	return arg_7_0._go.transform
end

function var_0_0.onDestroy(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._heroItems) do
		iter_8_1:onDestroy()
	end
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
