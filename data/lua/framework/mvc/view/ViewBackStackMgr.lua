module("framework.mvc.view.ViewBackStackMgr", package.seeall)

local var_0_0 = class("ViewBackStackMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._backStack = {}
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0._onFullOpen(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0:isFull(arg_3_1) then
		arg_3_0:_backStackPush(arg_3_1)
	end
end

function var_0_0._onFullClose(arg_4_0, arg_4_1)
	if arg_4_0:isFull(arg_4_1) then
		if arg_4_0:_backStackTop() == arg_4_1 then
			arg_4_0:_backStackPop()
		else
			arg_4_0:removeInBackStack()
		end
	end
end

function var_0_0._backStackPush(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:removeInBackStack(arg_5_1)
	table.insert(arg_5_0._backStack, {
		viewName = arg_5_1,
		viewParam = arg_5_2
	})
end

function var_0_0._backStackPop(arg_6_0, arg_6_1)
	local var_6_0 = #arg_6_0._backStack
	local var_6_1 = arg_6_0._backStack[var_6_0]

	if var_6_1 and var_6_1.viewName == arg_6_1 then
		table.remove(arg_6_0._backStack, var_6_0)

		return var_6_1
	else
		logError("view not in stack top, can't remove: " .. arg_6_1)
	end
end

function var_0_0._backStackTop(arg_7_0)
	return arg_7_0._backStack[#arg_7_0._backStack]
end

function var_0_0.removeInBackStack(arg_8_0, arg_8_1)
	tabletool.removeValue(arg_8_0._backStack, arg_8_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
