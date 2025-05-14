module("modules.logic.explore.controller.steps.ExploreUpdateCoinStep", package.seeall)

local var_0_0 = class("ExploreUpdateCoinStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreSimpleModel.instance:onGetCoin(arg_1_0._data.id, arg_1_0._data.num)
	ExploreController.instance:dispatchEvent(ExploreEvent.CoinCountUpdate)
	arg_1_0:onDone()
end

return var_0_0
