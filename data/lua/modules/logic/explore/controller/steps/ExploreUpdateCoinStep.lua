module("modules.logic.explore.controller.steps.ExploreUpdateCoinStep", package.seeall)

slot0 = class("ExploreUpdateCoinStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreSimpleModel.instance:onGetCoin(slot0._data.id, slot0._data.num)
	ExploreController.instance:dispatchEvent(ExploreEvent.CoinCountUpdate)
	slot0:onDone()
end

return slot0
