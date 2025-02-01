module("modules.logic.antique.rpc.AntiqueRpc", package.seeall)

slot0 = class("AntiqueRpc", BaseRpc)

function slot0.sendGetAntiqueInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(AntiqueModule_pb.GetAntiqueInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetAntiqueInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AntiqueModel.instance:setAntiqueInfo(slot2.antiques)
end

function slot0.onReceiveAntiqueUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	for slot6, slot7 in ipairs(slot2.antiques) do
		if not AntiqueModel.instance:getAntique(slot7.antiqueId) then
			GameFacade.showToast(ToastEnum.AntiqueNewGet)
		end
	end

	AntiqueModel.instance:updateAntiqueInfo(slot2.antiques)
end

slot0.instance = slot0.New()

return slot0
