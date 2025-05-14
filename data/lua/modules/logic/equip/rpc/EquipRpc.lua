module("modules.logic.equip.rpc.EquipRpc", package.seeall)

local var_0_0 = class("EquipRpc", BaseRpc)

function var_0_0.sendGetEquipInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = EquipModule_pb.GetEquipInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetEquipInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.equips

	EquipModel.instance:addEquips(var_2_0)
end

function var_0_0.onReceiveEquipUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	local var_3_0 = arg_3_2.equips

	EquipModel.instance:addEquips(var_3_0)
end

function var_0_0.onReceiveEquipDeletePush(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.uids

	EquipModel.instance:removeEquips(var_4_0)
end

function var_0_0.sendEquipStrengthenRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = EquipModule_pb.EquipStrengthenRequest()

	var_5_0.targetUid = arg_5_1

	local var_5_1 = EquipModel.instance:getEquip(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_2 = EquipModule_pb.EatEquip()

		var_5_2.eatUid = iter_5_1[1]
		var_5_2.count = iter_5_1[2]

		table.insert(var_5_0.eatEquips, var_5_2)
	end

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveEquipStrengthenReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.EquipStrengthen)
	EquipController.instance:dispatchEvent(EquipEvent.onEquipStrengthenReply)
end

function var_0_0.sendEquipBreakRequest(arg_7_0, arg_7_1)
	local var_7_0 = EquipModule_pb.EquipBreakRequest()

	var_7_0.targetUid = arg_7_1

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveEquipBreakReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	EquipController.instance:dispatchEvent(EquipEvent.onBreakSuccess)
end

function var_0_0.sendEquipLockRequest(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = EquipModel.instance:getEquip(tostring(arg_9_1))

	if not var_9_0 or EquipHelper.isSpRefineEquip(var_9_0.config) then
		return
	end

	local var_9_1 = EquipModule_pb.EquipLockRequest()

	var_9_1.targetUid = arg_9_1
	var_9_1.lock = arg_9_2

	arg_9_0:sendMsg(var_9_1)
end

function var_0_0.onReceiveEquipLockReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.targetUid
	local var_10_1 = arg_10_2.lock

	EquipController.instance:dispatchEvent(EquipEvent.onEquipLockChange, {
		uid = var_10_0,
		isLock = var_10_1
	})

	if var_10_1 then
		GameFacade.showToast(ToastEnum.EquipLock)
	else
		GameFacade.showToast(ToastEnum.EquipUnLock)
	end
end

function var_0_0.sendEquipDecomposeRequest(arg_11_0)
	local var_11_0 = EquipModule_pb.EquipDecomposeRequest()

	for iter_11_0, iter_11_1 in pairs(EquipDecomposeListModel.instance.selectedEquipDict) do
		table.insert(var_11_0.equipUids, iter_11_0)
	end

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveEquipDecomposeReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		EquipController.instance:dispatchEvent(EquipEvent.onDecomposeSuccess)
	end
end

function var_0_0.sendEquipRefineRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = EquipModule_pb.EquipRefineRequest()

	var_13_0.targetUid = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		table.insert(var_13_0.eatUids, iter_13_1)
	end

	arg_13_0:sendMsg(var_13_0)
end

function var_0_0.onReceiveEquipRefineReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	EquipController.instance:dispatchEvent(EquipEvent.onEquipRefineReply)
end

var_0_0.instance = var_0_0.New()

return var_0_0
