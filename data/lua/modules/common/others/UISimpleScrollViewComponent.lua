module("modules.common.others.UISimpleScrollViewComponent", package.seeall)

local var_0_0 = class("UISimpleScrollViewComponent", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()

	arg_1_0._sign_index = 0
end

function var_0_0.registScrollView(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0._scroll_view then
		arg_2_0._scroll_view = {}
	end

	local var_2_0 = UISimpleScrollViewItem.New(arg_2_0.parentClass, arg_2_1, arg_2_2)

	var_2_0:__onInit()
	var_2_0:startLogic(arg_2_1, arg_2_2)

	arg_2_0._sign_index = arg_2_0._sign_index + 1
	var_2_0.sign_index = arg_2_0._sign_index

	table.insert(arg_2_0._scroll_view, var_2_0)

	return var_2_0
end

function var_0_0.registSimpleScrollView(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0:registScrollView(arg_3_1)

	var_3_0:useDefaultParam(arg_3_2, arg_3_3)

	return var_3_0
end

function var_0_0.releaseSelf(arg_4_0)
	if arg_4_0._scroll_view then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._scroll_view) do
			if iter_4_1.releaseSelf then
				iter_4_1:releaseSelf()
			end

			iter_4_1:__onDispose()
		end
	end

	arg_4_0._scroll_view = nil

	arg_4_0:__onDispose()
end

return var_0_0
