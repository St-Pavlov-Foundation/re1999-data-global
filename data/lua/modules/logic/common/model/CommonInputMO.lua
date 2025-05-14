module("modules.logic.common.model.CommonInputMO", package.seeall)

local var_0_0 = class("CommonInputMO")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.title = arg_1_1 or ""
	arg_1_0.defaultInput = arg_1_2 or ""
	arg_1_0.characterLimit = 50
	arg_1_0.cancelBtnName = luaLang("cancel")
	arg_1_0.sureBtnName = luaLang("sure")
	arg_1_0.cancelCallback = nil
	arg_1_0.sureCallback = arg_1_3
	arg_1_0.callbackObj = arg_1_4
end

return var_0_0
