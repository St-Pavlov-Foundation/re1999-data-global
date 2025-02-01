module("modules.logic.equip.rpc.EquipRpc", package.seeall)

slot0 = class("EquipRpc", BaseRpc)

function slot0.sendGetEquipInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(EquipModule_pb.GetEquipInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetEquipInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	EquipModel.instance:addEquips(slot2.equips)
end

function slot0.onReceiveEquipUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	EquipModel.instance:addEquips(slot2.equips)
end

function slot0.onReceiveEquipDeletePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	EquipModel.instance:removeEquips(slot2.uids)
end

function slot0.sendEquipStrengthenRequest(slot0, slot1, slot2)
	EquipModule_pb.EquipStrengthenRequest().targetUid = slot1
	slot4 = EquipModel.instance:getEquip(slot1)

	for slot8, slot9 in ipairs(slot2) do
		slot10 = EquipModule_pb.EatEquip()
		slot10.eatUid = slot9[1]
		slot10.count = slot9[2]

		table.insert(slot3.eatEquips, slot10)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveEquipStrengthenReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.EquipStrengthen)
	EquipController.instance:dispatchEvent(EquipEvent.onEquipStrengthenReply)
end

function slot0.sendEquipBreakRequest(slot0, slot1)
	slot2 = EquipModule_pb.EquipBreakRequest()
	slot2.targetUid = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveEquipBreakReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	EquipController.instance:dispatchEvent(EquipEvent.onBreakSuccess)
end

function slot0.sendEquipLockRequest(slot0, slot1, slot2)
	if not EquipModel.instance:getEquip(tostring(slot1)) or EquipHelper.isSpRefineEquip(slot3.config) then
		return
	end

	slot4 = EquipModule_pb.EquipLockRequest()
	slot4.targetUid = slot1
	slot4.lock = slot2

	slot0:sendMsg(slot4)
end

function slot0.onReceiveEquipLockReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot4 = slot2.lock

	EquipController.instance:dispatchEvent(EquipEvent.onEquipLockChange, {
		uid = slot2.targetUid,
		isLock = slot4
	})

	if slot4 then
		GameFacade.showToast(ToastEnum.EquipLock)
	else
		GameFacade.showToast(ToastEnum.EquipUnLock)
	end
end

function slot0.sendEquipDecomposeRequest(slot0)
	slot1 = EquipModule_pb.EquipDecomposeRequest()

	for slot5, slot6 in pairs(EquipDecomposeListModel.instance.selectedEquipDict) do
		table.insert(slot1.equipUids, slot5)
	end

	slot0:sendMsg(slot1)
end

function slot0.onReceiveEquipDecomposeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EquipController.instance:dispatchEvent(EquipEvent.onDecomposeSuccess)
	end
end

function slot0.sendEquipRefineRequest(slot0, slot1, slot2)
	EquipModule_pb.EquipRefineRequest().targetUid = slot1

	for slot7, slot8 in ipairs(slot2) do
		table.insert(slot3.eatUids, slot8)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveEquipRefineReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	EquipController.instance:dispatchEvent(EquipEvent.onEquipRefineReply)
end

slot0.instance = slot0.New()

return slot0
