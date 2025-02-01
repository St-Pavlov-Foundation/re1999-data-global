module("modules.logic.balanceumbrella.controller.BalanceUmbrellaController", package.seeall)

slot0 = class("BalanceUmbrellaController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onLoginEnd, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
end

function slot0._onLoginEnd(slot0)
	BalanceUmbrellaModel.instance:refreshUnlock(true)
end

function slot0._onUpdateDungeonInfo(slot0)
	BalanceUmbrellaModel.instance:refreshUnlock()
end

slot0.instance = slot0.New()

return slot0
