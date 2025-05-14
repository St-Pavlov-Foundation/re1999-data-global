module("modules.logic.balanceumbrella.controller.BalanceUmbrellaController", package.seeall)

local var_0_0 = class("BalanceUmbrellaController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onLoginEnd, arg_1_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_1_0._onUpdateDungeonInfo, arg_1_0)
end

function var_0_0._onLoginEnd(arg_2_0)
	BalanceUmbrellaModel.instance:refreshUnlock(true)
end

function var_0_0._onUpdateDungeonInfo(arg_3_0)
	BalanceUmbrellaModel.instance:refreshUnlock()
end

var_0_0.instance = var_0_0.New()

return var_0_0
