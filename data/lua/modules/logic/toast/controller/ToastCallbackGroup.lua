module("modules.logic.toast.controller.ToastCallbackGroup", package.seeall)

local var_0_0 = class("ToastCallbackGroup")

function var_0_0.ctor(arg_1_0)
	arg_1_0.onOpen = nil
	arg_1_0.onOpenObj = nil
	arg_1_0.onOpenParam = nil
	arg_1_0.onClose = nil
	arg_1_0.onCloseObj = nil
	arg_1_0.onCloseParam = nil
end

function var_0_0.tryOnOpen(arg_2_0, arg_2_1)
	if arg_2_0.onOpen then
		arg_2_0.onOpen(arg_2_0.onOpenObj, arg_2_0.onOpenParam, arg_2_1)
	end
end

function var_0_0.tryOnClose(arg_3_0, arg_3_1)
	if arg_3_0.onClose then
		arg_3_0.onClose(arg_3_0.onCloseObj, arg_3_0.onCloseParam, arg_3_1)
	end
end

return var_0_0
