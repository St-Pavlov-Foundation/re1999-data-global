module("modules.logic.main.controller.work.MainUseExpireItemWork", package.seeall)

slot0 = class("MainUseExpireItemWork", BaseWork)

function slot0.onStart(slot0, slot1)
	ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
