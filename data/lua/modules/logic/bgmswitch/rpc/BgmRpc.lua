module("modules.logic.bgmswitch.rpc.BgmRpc", package.seeall)

local var_0_0 = class("BgmRpc", BaseRpc)

function var_0_0.sendGetBgmInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = BgmModule_pb.GetBgmInfoRequest()

	arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetBgmInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		BGMSwitchModel.instance:setBgmInfos(arg_2_2.bgmInfos)
		BGMSwitchModel.instance:setUsedBgmIdFromServer(arg_2_2.useBgmId)
		BGMSwitchModel.instance:setCurBgm(arg_2_2.useBgmId)
	end
end

function var_0_0.onReceiveUpdateBgmPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		BGMSwitchModel.instance:updateBgmInfos(arg_3_2.bgmInfos)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmUpdated)
	end
end

function var_0_0.sendSetUseBgmRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = BgmModule_pb.SetUseBgmRequest()

	var_4_0.bgmId = arg_4_1

	BGMSwitchModel.instance:recordInfoByType(BGMSwitchEnum.RecordInfoType.ListType, BGMSwitchModel.instance:getBGMSelectType(), true)
	arg_4_0:sendMsg(var_4_0, arg_4_2, arg_4_3)
end

function var_0_0.onReceiveSetUseBgmReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		BGMSwitchModel.instance:setUsedBgmIdFromServer(arg_5_2.bgmId)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmSwitched)
	end
end

function var_0_0.sendSetFavoriteBgmRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = BgmModule_pb.SetFavoriteBgmRequest()

	var_6_0.bgmId = arg_6_1
	var_6_0.favorite = arg_6_2

	local var_6_1 = BGMSwitchConfig.instance:getBGMSwitchCO(arg_6_1)

	if var_6_1 then
		StatController.instance:track(StatEnum.EventName.SetPreferenceBgm, {
			[StatEnum.EventProperties.AudioId] = tostring(arg_6_1),
			[StatEnum.EventProperties.AudioName] = var_6_1.audioName,
			[StatEnum.EventProperties.OperationType] = arg_6_2 and "setLove" or "setUnlove",
			[StatEnum.EventProperties.FavoriteAudio] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted())
		})
	end

	arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveSetFavoriteBgmReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		BGMSwitchModel.instance:setBgmFavorite(arg_7_2.bgmId, arg_7_2.favorite)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmFavorite, arg_7_2.bgmId)
	end
end

function var_0_0.sendReadBgmRequest(arg_8_0, arg_8_1)
	local var_8_0 = BgmModule_pb.ReadBgmRequest()

	var_8_0.bgmId = arg_8_1

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveReadBgmReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		BGMSwitchModel.instance:markRead(arg_9_2.bgmId)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmMarkRead, arg_9_2.bgmId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
