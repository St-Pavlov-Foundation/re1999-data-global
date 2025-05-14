module("modules.logic.dialogue.rpc.DialogueRpc", package.seeall)

local var_0_0 = class("DialogueRpc", BaseRpc)

function var_0_0.sendGetDialogInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = DialogModule_pb.GetDialogInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetDialogInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	DialogueModel.instance:initDialogue(arg_2_2.dialogIds)
end

function var_0_0.sendRecordDialogInfoRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = DialogModule_pb.RecordDialogInfoRequest()

	var_3_0.dialogId = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveRecordDialogInfoReplay(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	DialogueModel.instance:updateDialogueInfo(arg_4_2.dialogId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
