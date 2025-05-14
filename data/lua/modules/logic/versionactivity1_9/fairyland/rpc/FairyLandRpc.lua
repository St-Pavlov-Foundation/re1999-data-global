module("modules.logic.versionactivity1_9.fairyland.rpc.FairyLandRpc", package.seeall)

local var_0_0 = class("FairyLandRpc", BaseRpc)

function var_0_0.sendGetFairylandInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = FairylandModule_pb.GetFairylandInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetFairylandInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	FairyLandModel.instance:onGetFairylandInfoReply(arg_2_2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.UpdateInfo)
end

function var_0_0.sendResolvePuzzleRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = FairylandModule_pb.ResolvePuzzleRequest()

	var_3_0.passPuzzleId = arg_3_1
	var_3_0.answer = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveResolvePuzzleReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	FairyLandModel.instance:onResolvePuzzleReply(arg_4_2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ResolveSuccess)
end

function var_0_0.sendRecordDialogRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = FairylandModule_pb.RecordDialogRequest()

	var_5_0.dialogId = arg_5_1

	FairyLandModel.instance:setFinishDialog(arg_5_1)

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveRecordDialogReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	FairyLandModel.instance:onRecordDialogReply(arg_6_2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.DialogFinish)
end

function var_0_0.sendRecordElementRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = FairylandModule_pb.RecordElementRequest()

	var_7_0.elementId = arg_7_1

	return arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveRecordElementReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	FairyLandModel.instance:onRecordElementReply(arg_8_2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ElementFinish)
end

var_0_0.instance = var_0_0.New()

return var_0_0
