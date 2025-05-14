module("modules.logic.seasonver.act123.rpc.Activity123Rpc", package.seeall)

local var_0_0 = class("Activity123Rpc", BaseRpc)

function var_0_0.sendGet123InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity123Module_pb.Get123InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet123InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Season123Model.instance:setActInfo(arg_2_2)
	Season123Controller.instance:dispatchEvent(Season123Event.GetActInfo, arg_2_2.activityId)
end

function var_0_0.onReceiveAct123BattleFinishPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	Season123Model.instance:updateActInfoBattle(arg_3_2)
	Season123Controller.instance:dispatchEvent(Season123Event.GetActInfoBattleFinish)
end

function var_0_0.sendAct123EnterStageRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = Activity123Module_pb.Act123EnterStageRequest()

	var_4_0.activityId = arg_4_1
	var_4_0.stage = arg_4_2

	for iter_4_0 = 1, #arg_4_3 do
		var_4_0.heroUids:append(arg_4_3[iter_4_0])
	end

	return arg_4_0:sendMsg(var_4_0, arg_4_5, arg_4_6)
end

function var_0_0.onReceiveAct123EnterStageReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	Season123EpisodeListController.instance:onReceiveEnterStage(arg_5_2.stage)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterStageSuccess)
end

function var_0_0.sendAct123ChangeFightGroupRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = Activity123Module_pb.Act123ChangeFightGroupRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.heroGroupSnapshotSubId = arg_6_2

	return arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveAct123ChangeFightGroupReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	local var_7_0 = Season123Model.instance:getActInfo(arg_7_2.activityId)

	if var_7_0 then
		var_7_0.heroGroupSnapshotSubId = arg_7_2.heroGroupSnapshotSubId

		Season123Controller.instance:dispatchEvent(Season123Event.HeroGroupIndexChanged, {
			actId = arg_7_2.activityId,
			groupIndex = arg_7_2.heroGroupSnapshotSubId
		})
	end
end

function var_0_0.sendAct123EndStageRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = Activity123Module_pb.Act123EndStageRequest()

	var_8_0.activityId = arg_8_1
	var_8_0.stage = arg_8_2

	return arg_8_0:sendMsg(var_8_0, arg_8_3, arg_8_4)
end

function var_0_0.onReceiveAct123EndStageReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	Season123Controller.instance:dispatchEvent(Season123Event.ResetStageFinished, arg_9_2.activityId)
end

function var_0_0.onReceiveAct123ItemChangePush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = Season123Model.instance:getCurSeasonId()

	Season123Model.instance:updateItemMap(var_10_0, arg_10_2.act123Items, arg_10_2.deleteItems)
	Season123Controller.instance:dispatchEvent(Season123Event.OnEquipItemChange)
end

function var_0_0.sendStartAct123BattleRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8, arg_11_9, arg_11_10, arg_11_11)
	local var_11_0 = Activity123Module_pb.StartAct123BattleRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.layer = arg_11_2

	DungeonRpc.instance:packStartDungeonRequest(var_11_0.startDungeonRequest, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8, arg_11_9)
	Season123HeroGroupUtils.processFightGroupAssistHero(ModuleEnum.HeroGroupType.Season123, var_11_0.startDungeonRequest.fightGroup, arg_11_8)

	return arg_11_0:sendMsg(var_11_0, arg_11_10, arg_11_11)
end

function var_0_0.onReceiveStartAct123BattleReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		local var_12_0 = Season123Model.instance:getBattleContext()

		if var_12_0.actId == arg_12_2.activityId and (var_12_0.layer == nil or var_12_0.layer == arg_12_2.layer) then
			local var_12_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

			if var_12_1 and DungeonModel.isBattleEpisode(var_12_1) then
				DungeonFightController.instance:onReceiveStartDungeonReply(arg_12_1, arg_12_2.startDungeonReply)
			end
		end

		if arg_12_2.updateAct123Stages and #arg_12_2.updateAct123Stages > 0 then
			local var_12_2 = Season123Model.instance:getActInfo(arg_12_2.activityId)

			if var_12_2 then
				var_12_2:updateStages(arg_12_2.updateAct123Stages)
				Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
			end
		end
	else
		Season123Controller.instance:dispatchEvent(Season123Event.StartFightFailed)
	end
end

function var_0_0.sendComposeAct123EquipRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = Activity123Module_pb.ComposeAct123EquipRequest()

	var_13_0.activityId = arg_13_1
	var_13_0.equipId = arg_13_2

	return arg_13_0:sendMsg(var_13_0, arg_13_3, arg_13_4)
end

function var_0_0.onReceiveComposeAct123EquipReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	Season123EquipBookModel.instance:refreshBackpack()
	Season123DecomposeModel.instance:initDatas(arg_14_2.activityId)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnItemChange)
end

function var_0_0.sendDecomposeAct123EquipRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Activity123Module_pb.DecomposeAct123EquipRequest()

	var_15_0.activityId = arg_15_1

	for iter_15_0, iter_15_1 in pairs(arg_15_2) do
		table.insert(var_15_0.equipUids, iter_15_1)
	end

	return arg_15_0:sendMsg(var_15_0, arg_15_3, arg_15_4)
end

function var_0_0.onReceiveDecomposeAct123EquipReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	Season123DecomposeModel.instance:removeHasDecomposeItems(arg_16_2.equipUids)
	Season123EquipController.instance:checkHeroGroupCardExist(arg_16_2.activityId)
	Season123EquipBookModel.instance:removeDecomposeEquipItem(arg_16_2.equipUids)
	Season123DecomposeModel.instance:initDatas(arg_16_2.activityId)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnItemChange)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.CloseBatchDecomposeEffect)
end

function var_0_0.sendAct123OpenCardBagRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = Activity123Module_pb.Act123OpenCardBagRequest()

	var_17_0.activityId = arg_17_1
	var_17_0.itemId = arg_17_2

	return arg_17_0:sendMsg(var_17_0, arg_17_3, arg_17_4)
end

function var_0_0.onReceiveAct123OpenCardBagReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	Season123CardPackageModel.instance:initData(arg_18_2.activityId)
	Season123CardPackageModel.instance:setCardItemList(arg_18_2.act123EquipIds)
	Season123Controller.instance:dispatchEvent(Season123Event.OnCardPackageOpen)
end

function var_0_0.sendAct123ResetOtherStageRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = Activity123Module_pb.Act123ResetOtherStageRequest()

	var_19_0.activityId = arg_19_1
	var_19_0.enterStage = arg_19_2

	return arg_19_0:sendMsg(var_19_0, arg_19_3, arg_19_4)
end

function var_0_0.onReceiveAct123ResetOtherStageReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 and arg_20_2.updateAct123Stages and #arg_20_2.updateAct123Stages > 0 then
		local var_20_0 = Season123Model.instance:getActInfo(arg_20_2.activityId)

		if var_20_0 then
			var_20_0:updateStages(arg_20_2.updateAct123Stages)
			Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
		end
	end
end

function var_0_0.sendAct123ResetHighLayerRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = Activity123Module_pb.Act123ResetHighLayerRequest()

	var_21_0.activityId = arg_21_1
	var_21_0.stage = arg_21_2
	var_21_0.layer = arg_21_3

	return arg_21_0:sendMsg(var_21_0, arg_21_4, arg_21_5)
end

function var_0_0.onReceiveAct123ResetHighLayerReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 and arg_22_2.updateAct123Stages and #arg_22_2.updateAct123Stages > 0 then
		local var_22_0 = Season123Model.instance:getActInfo(arg_22_2.activityId)

		if var_22_0 then
			var_22_0.stage = arg_22_2.stage

			var_22_0:updateStages(arg_22_2.updateAct123Stages)
			Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
		end
	end
end

function var_0_0.sendGetUnlockAct123EquipIdsRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = Activity123Module_pb.GetUnlockAct123EquipIdsRequest()

	var_23_0.activityId = arg_23_1

	return arg_23_0:sendMsg(var_23_0, arg_23_2, arg_23_3)
end

function var_0_0.onReceiveGetUnlockAct123EquipIdsReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end

	Season123Model.instance:setUnlockAct123EquipIds(arg_24_2)
end

function var_0_0.sendGetAct123StageRecordRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = Activity123Module_pb.GetAct123StageRecordRequest()

	var_25_0.activityId = arg_25_1
	var_25_0.stage = arg_25_2

	return arg_25_0:sendMsg(var_25_0, arg_25_3, arg_25_4)
end

function var_0_0.onReceiveGetAct123StageRecordReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 ~= 0 then
		return
	end

	Season123RecordModel.instance:setSeason123ServerRecordData(arg_26_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
