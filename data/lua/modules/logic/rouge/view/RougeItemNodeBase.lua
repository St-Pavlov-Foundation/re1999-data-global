module("modules.logic.rouge.view.RougeItemNodeBase", package.seeall)

local var_0_0 = class("RougeItemNodeBase", UserDataDispose)
local var_0_1 = table.insert

function var_0_0.ctor(arg_1_0, arg_1_1)
	assert(isTypeOf(arg_1_1, RougeSimpleItemBase), "[RougeItemNodeBase] ctor failed: parent must inherited from RougeSimpleItemBase type(parent)=" .. (arg_1_1.__cname or "nil"))
	arg_1_0:__onInit()

	arg_1_0._parent = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1

	arg_2_0:onInitView()
	arg_2_0:addEventListeners()
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0:onDestroyView()
end

function var_0_0.staticData(arg_4_0)
	if not arg_4_0._parent then
		return
	end

	return arg_4_0._parent._staticData
end

function var_0_0.parent(arg_5_0)
	return arg_5_0._parent
end

function var_0_0.baseViewContainer(arg_6_0)
	local var_6_0 = arg_6_0:staticData()

	if not var_6_0 then
		return
	end

	return var_6_0.baseViewContainer
end

function var_0_0.dispatchEvent(arg_7_0, arg_7_1, ...)
	if not arg_7_0._parent then
		logWarn("dispatchEvent")

		return
	end

	local var_7_0 = arg_7_0:baseViewContainer()

	if not var_7_0 then
		return
	end

	var_7_0:dispatchEvent(arg_7_1, ...)
end

function var_0_0.index(arg_8_0)
	if not arg_8_0._parent then
		return
	end

	return arg_8_0._parent:index()
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.viewGO, arg_9_1)
end

function var_0_0.posX(arg_10_0)
	if not arg_10_0._parent then
		return
	end

	return arg_10_0._parent:posX()
end

function var_0_0.posY(arg_11_0)
	if not arg_11_0._parent then
		return
	end

	return arg_11_0._parent:posY()
end

function var_0_0._fillUserDataTb(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = 1
	local var_12_1 = arg_12_0[arg_12_1 .. var_12_0]

	while not gohelper.isNil(var_12_1) do
		if arg_12_2 then
			var_0_1(arg_12_2, var_12_1.gameObject)
		end

		if arg_12_3 then
			var_0_1(arg_12_3, var_12_1)
		end

		var_12_0 = var_12_0 + 1
		var_12_1 = arg_12_0[arg_12_1 .. var_12_0]
	end
end

function var_0_0._onSetScrollParentGameObject(arg_13_0, arg_13_1)
	if gohelper.isNil(arg_13_1) then
		return
	end

	local var_13_0 = arg_13_0:baseViewContainer()

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0:getScrollViewGo()

	if gohelper.isNil(var_13_1) then
		return
	end

	arg_13_1.parentGameObject = var_13_1
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0:setData(arg_14_1)
end

function var_0_0.addEventListeners(arg_15_0)
	arg_15_0:addEvents()
end

function var_0_0.removeEventListeners(arg_16_0)
	arg_16_0:removeEvents()
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0:removeEventListeners()
	arg_17_0:__onDispose()
end

function var_0_0.setData(arg_18_0, arg_18_1)
	arg_18_0._mo = arg_18_1
end

return var_0_0
