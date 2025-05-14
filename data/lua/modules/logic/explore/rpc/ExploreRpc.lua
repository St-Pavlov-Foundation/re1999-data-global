module("modules.logic.explore.rpc.ExploreRpc", package.seeall)

local var_0_0 = class("ExploreRpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendChangeMapRequest(arg_1_0, arg_1_1)
	local var_1_0 = ExploreModule_pb.ChangeMapRequest()

	var_1_0.mapId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveChangeMapReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ExploreModel.instance.isFirstEnterMap = arg_2_2.exploreInfo.exploreMap.isFirstEnter and ExploreEnum.EnterMode.First or ExploreEnum.EnterMode.Normal

		ExploreSimpleModel.instance:setNowMapId(arg_2_2.exploreInfo.exploreMap.mapId)
		ExploreModel.instance:updateExploreInfo(arg_2_2.exploreInfo)
		ExploreController.instance:enterExploreMap(arg_2_2.exploreInfo.exploreMap.mapId)
	end
end

function var_0_0.sendGetExploreInfoRequest(arg_3_0)
	local var_3_0 = ExploreModule_pb.GetExploreInfoRequest()

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveGetExploreInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ExploreModel.instance:updateExploreInfo(arg_4_2.exploreInfo)
		ExploreController.instance:enterExploreMap(ExploreModel.instance:getMapId())
	end
end

function var_0_0.sendGetExploreSimpleInfoRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ExploreModule_pb.GetExploreSimpleInfoRequest()

	return arg_5_0:sendMsg(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onReceiveGetExploreSimpleInfoReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		ExploreSimpleModel.instance:onGetInfo(arg_6_2)
	end
end

function var_0_0.sendExploreMoveRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = ExploreModule_pb.ExploreMoveRequest()

	var_7_0.posx = arg_7_1
	var_7_0.posy = arg_7_2

	if arg_7_3 then
		var_7_0.interactId = arg_7_3
	end

	return arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveExploreMoveReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		-- block empty
	else
		ExploreStepController.instance:forceAsyncPos()
	end
end

function var_0_0.sendExploreInteractSetStatusRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = ExploreModule_pb.ExploreInteractSetStatusRequest()

	var_9_0.type = arg_9_1
	var_9_0.id = arg_9_2
	var_9_0.status = arg_9_3

	return arg_9_0:sendMsg(var_9_0, arg_9_4, arg_9_5)
end

function var_0_0.onReceiveExploreInteractSetStatusReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		ExploreModel.instance:updateInteractStatus(arg_10_2.mapId, arg_10_2.id, arg_10_2.status)
	end
end

function var_0_0.sendExploreInteractRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = ExploreModule_pb.ExploreInteractRequest()

	var_11_0.id = arg_11_1

	if not string.nilorempty(arg_11_3) then
		var_11_0.params = arg_11_3
	end

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.BeginInteract)

	return arg_11_0:sendMsg(var_11_0, arg_11_4, arg_11_5)
end

function var_0_0.onReceiveExploreInteractReply(arg_12_0, arg_12_1, arg_12_2)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.BeginInteract)
	ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractEnd)

	if arg_12_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveStartExplorePush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendExploreItemInteractRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = ExploreModule_pb.ExploreItemInteractRequest()

	var_14_0.id = arg_14_1
	var_14_0.params = arg_14_2

	return arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveExploreItemInteractReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendExploreUseItemRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = ExploreModule_pb.ExploreUseItemRequest()

	var_16_0.uid = arg_16_1
	var_16_0.posx = arg_16_2
	var_16_0.posy = arg_16_3

	if arg_16_4 then
		var_16_0.interactId = arg_16_4
	end

	return arg_16_0:sendMsg(var_16_0, arg_16_5, arg_16_6)
end

function var_0_0.onReceiveExploreUseItemReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveExploreItemChangePush(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		ExploreBackpackModel.instance:updateItems(arg_18_2.exploreItems)
	end
end

function var_0_0.onReceiveExploreStepPush(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		ExploreStepController.instance:onExploreStepPush(arg_19_2)
	end
end

function var_0_0.sendResetExploreRequest(arg_20_0)
	local var_20_0 = ExploreModule_pb.ResetExploreRequest()

	ExploreController.instance:getMap():getHero():stopMoving(true)

	local var_20_1 = {
		stepType = ExploreEnum.StepType.ResetBegin
	}

	ExploreStepController.instance:insertClientStep(var_20_1, 1)
	ExploreStepController.instance:startStep()
	arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveResetExploreReply(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {
		stepType = ExploreEnum.StepType.ResetEnd
	}

	ExploreStepController.instance:insertClientStep(var_21_0)
	ExploreStepController.instance:startStep()
end

return var_0_0
