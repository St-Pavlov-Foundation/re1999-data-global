module("modules.logic.patface.model.PatFaceModel", package.seeall)

local var_0_0 = class("PatFaceModel", BaseModel)
local var_0_1 = {
	Disable = 0,
	Enable = 1
}

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()

	local var_1_0 = false

	if isDebugBuild then
		var_1_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewSkipPatFace)
	end

	local var_1_1 = var_1_0 == var_0_1.Enable

	arg_1_0:setIsSkipPatFace(var_1_1)
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.getIsPatting(arg_3_0)
	return arg_3_0._isPattingFace and true or false
end

function var_0_0.getIsSkipPatFace(arg_4_0)
	return arg_4_0._isSkipPatFace and true or false
end

function var_0_0.setIsPatting(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0._isPattingFace then
		return
	end

	arg_5_0._isPattingFace = arg_5_1
end

function var_0_0.setIsSkipPatFace(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 and true or false

	arg_6_0._isSkipPatFace = var_6_0

	local var_6_1 = var_6_0 and ToastEnum.SkipPatFace or ToastEnum.CancelSkipPatFace

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewSkipPatFace, var_6_0 and var_0_1.Enable or var_0_1.Disable)

	if arg_6_2 then
		GameFacade.showToast(var_6_1)
	end
end

function var_0_0.clear(arg_7_0)
	arg_7_0:setIsPatting(false)
	var_0_0.super.clear(arg_7_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
