module("modules.logic.rouge.view.RougeFactionItemSelected_DescItem", package.seeall)

local var_0_0 = class("RougeFactionItemSelected_DescItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0:__onInit()

	arg_4_0._parent = arg_4_1
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()
end

function var_0_0.setIndex(arg_6_0, arg_6_1)
	arg_6_0._index = arg_6_1
end

function var_0_0.index(arg_7_0)
	return arg_7_0._index
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txt = gohelper.findChildText(arg_8_0.viewGO, "")

	arg_8_0:setData(nil)
end

function var_0_0.setData(arg_9_0, arg_9_1)
	arg_9_0._txt.text = arg_9_1 or ""

	arg_9_0:setActive(not string.nilorempty(arg_9_1))
end

function var_0_0.setActive(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0.viewGO, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0:__onDispose()
end

return var_0_0
