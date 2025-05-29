module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroController", package.seeall)

local var_0_0 = class("DiceHeroController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._onActivityRefresh, arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_1_0._onGetOpenInfoSuccess, arg_1_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_1_0._onGetOpenInfoSuccess, arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_1_0._newFuncUnlock, arg_1_0)
end

function var_0_0._onActivityRefresh(arg_2_0, arg_2_1)
	if arg_2_1 and arg_2_1 ~= VersionActivity2_6Enum.ActivityId.DiceHero then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) then
		arg_2_0:_getInfo()
	end
end

function var_0_0._onGetOpenInfoSuccess(arg_3_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) then
		arg_3_0:_getInfo()
	end
end

function var_0_0._newFuncUnlock(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1 == OpenEnum.UnlockFunc.DiceHero then
			arg_4_0:_getInfo()

			break
		end
	end
end

function var_0_0._getInfo(arg_5_0)
	if not ActivityHelper.isOpen(VersionActivity2_6Enum.ActivityId.DiceHero) then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroGetInfo()
end

var_0_0.instance = var_0_0.New()

return var_0_0
