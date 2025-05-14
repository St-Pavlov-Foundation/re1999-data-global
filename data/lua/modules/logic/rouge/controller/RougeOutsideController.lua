module("modules.logic.rouge.controller.RougeOutsideController", package.seeall)

local var_0_0 = class("RougeOutsideController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._model = RougeOutsideModel.instance
end

function var_0_0.addConstEvents(arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_2_0._onGetOpenInfoSuccess, arg_2_0)
end

function var_0_0._onGetOpenInfoSuccess(arg_3_0)
	local var_3_0 = arg_3_0._model:config():openUnlockId()

	if OpenModel.instance:isFunctionUnlock(var_3_0) then
		return
	end

	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_3_0._onNewFuncUnlock, arg_3_0)
end

function var_0_0.checkOutSideStageInfo(arg_4_0)
	return
end

function var_0_0._onNewFuncUnlock(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._model:config():openUnlockId()
	local var_5_1 = false

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if iter_5_1 == var_5_0 then
			var_5_1 = true

			break
		end
	end

	if not var_5_1 then
		return
	end

	arg_5_0._model:setIsNewUnlockDifficulty(1, true)
end

function var_0_0.isOpen(arg_6_0)
	return arg_6_0._model:isUnlock()
end

var_0_0.instance = var_0_0.New()

return var_0_0
