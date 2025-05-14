module("modules.logic.signin.model.SignInListModel", package.seeall)

local var_0_0 = class("SignInListModel", ListScrollModel)

function var_0_0.setPropList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0.clearPropList(arg_2_0)
	arg_2_0._moList = nil

	arg_2_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
