module("modules.logic.open.rpc.OpenRpc", package.seeall)

slot0 = class("OpenRpc", BaseRpc)

function slot0.onReceiveUpdateOpenPush(slot0, slot1, slot2)
	if slot1 == 0 then
		OpenModel.instance:updateOpenInfo(slot2.openInfos)
		MainController.instance:dispatchEvent(MainEvent.OnFuncUnlockRefresh)

		slot3 = {}

		for slot7, slot8 in ipairs(slot2.openInfos) do
			if slot8.isOpen then
				table.insert(slot3, slot8.id)
			end
		end

		if #slot3 > 0 then
			OpenController.instance:dispatchEvent(OpenEvent.NewFuncUnlock, slot3)
		end
	end
end

slot0.instance = slot0.New()

return slot0
