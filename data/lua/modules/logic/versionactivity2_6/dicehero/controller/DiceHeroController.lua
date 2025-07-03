module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroController", package.seeall)

local var_0_0 = class("DiceHeroController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_1_0._onGetOpenInfoSuccess, arg_1_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_1_0._onGetOpenInfoSuccess, arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_1_0._newFuncUnlock, arg_1_0)
end

function var_0_0._onGetOpenInfoSuccess(arg_2_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) then
		arg_2_0:_getInfo()
	end
end

function var_0_0._newFuncUnlock(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1 == OpenEnum.UnlockFunc.DiceHero then
			arg_3_0:_getInfo()

			break
		end
	end
end

function var_0_0._getInfo(arg_4_0)
	DiceHeroRpc.instance:sendDiceHeroGetInfo()
end

var_0_0.instance = var_0_0.New()

return var_0_0
