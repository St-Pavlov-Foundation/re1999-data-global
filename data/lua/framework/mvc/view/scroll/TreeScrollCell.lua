module("framework.mvc.view.scroll.TreeScrollCell", package.seeall)

local var_0_0 = class("TreeScrollCell", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._rootIndex = nil
	arg_1_0._nodeIndex = nil
	arg_1_0._go = nil
	arg_1_0._view = nil
	arg_1_0._isRoot = nil
	arg_1_0._isNode = nil
end

function var_0_0.initInternal(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._go = arg_2_1
	arg_2_0._view = arg_2_2
end

function var_0_0.onUpdateRootMOInternal(arg_3_0, arg_3_1)
	if not arg_3_0._isRoot then
		arg_3_0._isRoot = true

		arg_3_0:initRoot()
	end

	arg_3_0:onUpdateRootMO(arg_3_1)
end

function var_0_0.onUpdateNodeMOInternal(arg_4_0, arg_4_1)
	if not arg_4_0._isNode then
		arg_4_0._isNode = true

		arg_4_0:initNode()
	end

	arg_4_0:onUpdateNodeMO(arg_4_1)
end

function var_0_0.initRoot(arg_5_0)
	return
end

function var_0_0.initNode(arg_6_0)
	return
end

function var_0_0.addEventListeners(arg_7_0)
	return
end

function var_0_0.removeEventListeners(arg_8_0)
	return
end

function var_0_0.onUpdateRootMO(arg_9_0, arg_9_1)
	return
end

function var_0_0.onUpdateNodeMO(arg_10_0, arg_10_1)
	return
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroy(arg_12_0)
	return
end

return var_0_0
