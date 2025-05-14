module("modules.logic.settings.rpc.UserSettingRpc", package.seeall)

local var_0_0 = class("UserSettingRpc", BaseRpc)

function var_0_0.sendGetSettingInfosRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = UserSettingModule_pb.GetSettingInfosRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetSettingInfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	SettingsModel.instance:setPushState(arg_2_2.infos)
end

function var_0_0.sendUpdateSettingInfoRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = UserSettingModule_pb.UpdateSettingInfoRequest()

	var_3_0.type = arg_3_1
	var_3_0.param = arg_3_2

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveUpdateSettingInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	SettingsModel.instance:updatePushState(arg_4_2.type, arg_4_2.param)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangePushType)
end

var_0_0.instance = var_0_0.New()

return var_0_0
