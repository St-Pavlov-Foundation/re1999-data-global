module("modules.logic.tower.rpc.TowerDeepRpc", package.seeall)

local var_0_0 = class("TowerDeepRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sendTowerDeepGetInfoRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = TowerDeepModule_pb.TowerDeepGetInfoRequest()

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveTowerDeepGetInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		TowerPermanentDeepModel.instance:onReceiveTowerDeepGetInfoReply(arg_4_2.info)
	end
end

function var_0_0.sendTowerDeepSaveArchiveRequest(arg_5_0, arg_5_1)
	local var_5_0 = TowerDeepModule_pb.TowerDeepSaveArchiveRequest()

	var_5_0.archiveNo = arg_5_1

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveTowerDeepSaveArchiveReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		TowerPermanentDeepModel.instance:updateSaveGroupMo(arg_6_2.archive)
		TowerController.instance:dispatchEvent(TowerEvent.OnSaveTeamSuccess, arg_6_2.archive)
	end
end

function var_0_0.sendTowerDeepLoadArchiveRequest(arg_7_0, arg_7_1)
	local var_7_0 = TowerDeepModule_pb.TowerDeepLoadArchiveRequest()

	var_7_0.archiveNo = arg_7_1

	return arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveTowerDeepLoadArchiveReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		TowerPermanentDeepModel.instance:updateSaveGroupMo(arg_8_2.archive)
		TowerPermanentDeepModel.instance:updateCurGroupMo(arg_8_2.archive.group)
		TowerController.instance:dispatchEvent(TowerEvent.OnLoadTeamSuccess, arg_8_2.archive)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function var_0_0.sendTowerDeepResetRequest(arg_9_0)
	local var_9_0 = TowerDeepModule_pb.TowerDeepResetRequest()

	return arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveTowerDeepResetReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		TowerPermanentDeepModel.instance:updateCurGroupMo(arg_10_2.group)
		TowerController.instance:dispatchEvent(TowerEvent.OnTowerDeepReset)
	end
end

function var_0_0.onReceiveTowerDeepFightSettlePush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		TowerPermanentDeepModel.instance:updateFightResult(arg_11_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
