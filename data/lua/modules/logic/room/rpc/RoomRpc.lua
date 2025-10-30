module("modules.logic.room.rpc.RoomRpc", package.seeall)

local var_0_0 = class("RoomRpc", BaseRpc)

var_0_0.GainProductionLineRequest = -29380

function var_0_0.sendGetRoomInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = RoomModule_pb.GetRoomInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetRoomInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		RoomModel.instance:setEditInfo(arg_2_2)
	end
end

function var_0_0.sendUseBlockRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local var_3_0 = RoomModule_pb.UseBlockRequest()

	var_3_0.blockId = arg_3_1
	var_3_0.blockPackageId = arg_3_2
	var_3_0.rotate = arg_3_3
	var_3_0.x = arg_3_4
	var_3_0.y = arg_3_5

	return arg_3_0:sendMsg(var_3_0, arg_3_6, arg_3_7)
end

function var_0_0.onReceiveUseBlockReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		RoomMapController.instance:useBlockReply(arg_4_2)
		RoomStatController.instance:blockOp({
			arg_4_2.blockId
		}, true)
	end
end

function var_0_0.sendUnUseBlockRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = RoomModule_pb.UnUseBlockRequest()

	for iter_5_0 = 1, #arg_5_1 do
		table.insert(var_5_0.blockIds, arg_5_1[iter_5_0])
	end

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveUnUseBlockReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		RoomMapController.instance:unUseBlockReply(arg_6_2)
		RoomStatController.instance:blockOp(arg_6_2.blockIds, false)
	end
end

function var_0_0.sendGetBlockPackageInfoRequset(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = RoomModule_pb.GetBlockPackageInfoRequset()

	return arg_7_0:sendMsg(var_7_0, arg_7_1, arg_7_2)
end

function var_0_0.onReceiveGetBlockPackageInfoReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		RoomController.instance:getBlockPackageInfoReply(arg_8_2)
	end
end

function var_0_0.onReceiveBlockPackageGainPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		RoomController.instance:blockPackageGainPush(arg_9_2)
		RoomMapController.instance:dispatchEvent(RoomEvent.NewBlockPackagePush)
	end
end

function var_0_0.onReceiveGainSpecialBlockPush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		RoomController.instance:gainSpecialBlockPush(arg_10_2)
	end
end

function var_0_0.sendGetBuildingInfoRequest(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = RoomModule_pb.GetBuildingInfoRequest()

	return arg_11_0:sendMsg(var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.onReceiveGetBuildingInfoReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		RoomController.instance:getBuildingInfoReply(arg_12_2)
	end
end

function var_0_0.sendResetRoomRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RoomModule_pb.ResetRoomRequest()

	return arg_13_0:sendMsg(var_13_0, arg_13_1, arg_13_2)
end

function var_0_0.onReceiveResetRoomReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveBuildingGainPush(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		RoomModel.instance:updateBuildingInfos(arg_15_2.buildingInfos)
		RoomInventoryBuildingModel.instance:addBuilding(arg_15_2.buildingInfos)
		RoomMapController.instance:buildingLevelUpByInfos(arg_15_2.buildingInfos)
		RoomMapController.instance:dispatchEvent(RoomEvent.NewBuildingPush)
	end
end

function var_0_0.sendUseBuildingRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = RoomModule_pb.UseBuildingRequest()

	var_16_0.uid = arg_16_1
	var_16_0.rotate = arg_16_2
	var_16_0.x = arg_16_3
	var_16_0.y = arg_16_4

	return arg_16_0:sendMsg(var_16_0, arg_16_5, arg_16_6)
end

function var_0_0.onReceiveUseBuildingReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		RoomModel.instance:updateBuildingInfos({
			arg_17_2.buildingInfo
		})
		RoomMapController.instance:useBuildingReply(arg_17_2)
		RoomMapController.instance:dispatchEvent(RoomEvent.UseBuildingReply)
	end
end

function var_0_0.sendUnUseBuildingRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = RoomModule_pb.UnUseBuildingRequest()

	var_18_0.uid = arg_18_1

	return arg_18_0:sendMsg(var_18_0, arg_18_2, arg_18_3)
end

function var_0_0.onReceiveUnUseBuildingReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		RoomModel.instance:updateBuildingInfos(arg_19_2.buildingInfos)
		RoomMapController.instance:unUseBuildingReply(arg_19_2)
	end
end

function var_0_0.sendGetRoomObInfoRequest(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = RoomModule_pb.GetRoomObInfoRequest()

	var_20_0.needBlockData = arg_20_1

	return arg_20_0:sendMsg(var_20_0, arg_20_2, arg_20_3)
end

function var_0_0.onReceiveGetRoomObInfoReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		RoomModel.instance:updateRoomLevel(arg_21_2.roomLevel)
		RoomModel.instance:updateBuildingInfos(arg_21_2.buildingInfos)
		RoomModel.instance:setFormulaInfos(arg_21_2.formulaInfos)
		RoomModel.instance:setGetThemeRewardIds(arg_21_2.hasGetRoomThemes)

		if arg_21_2.needBlockData == true then
			local var_21_0 = RoomLayoutHelper.createInfoByObInfo(arg_21_2)

			var_21_0.id = RoomEnum.LayoutUsedPlanId

			RoomLayoutModel.instance:updateRoomPlanInfoReply(var_21_0)
			RoomModel.instance:setCharacterList(arg_21_2.roomHeroDatas)
		end

		RoomProductionModel.instance:updateProductionLines(arg_21_2.productionLines)
		RoomSkinModel.instance:updateRoomSkinInfo(arg_21_2.skins, true)
	end
end

function var_0_0.sendRoomConfirmRequest(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = RoomModule_pb.RoomConfirmRequest()

	return arg_22_0:sendMsg(var_22_0, arg_22_1, arg_22_2)
end

function var_0_0.onReceiveRoomConfirmReply(arg_23_0, arg_23_1, arg_23_2)
	return
end

function var_0_0.sendRoomRevertRequest(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = RoomModule_pb.RoomRevertRequest()

	return arg_24_0:sendMsg(var_24_0, arg_24_1, arg_24_2)
end

function var_0_0.onReceiveRoomRevertReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveFormulaGainPush(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		RoomModel.instance:addFormulaInfos(arg_26_2.formulaInfos)
		RoomFormulaModel.instance:addFormulaList(arg_26_2.formulaInfos)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.NewFormulaPush)
	end
end

function var_0_0.sendBuildingChangeLevelRequest(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = RoomModule_pb.BuildingChangeLevelRequest()

	var_27_0.buildingUid = arg_27_1

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		table.insert(var_27_0.levels, iter_27_1)
	end

	return arg_27_0:sendMsg(var_27_0, arg_27_3, arg_27_4)
end

function var_0_0.onReceiveBuildingChangeLevelReply(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		RoomMapBuildingModel.instance:updateBuildingLevels(arg_28_2.buildingUid, arg_28_2.levels)
		RoomResourceModel.instance:clearResourceAreaList()
		RoomBuildingController.instance:dispatchEvent(RoomEvent.UpdateBuildingLevels, arg_28_2.buildingUid)
	end
end

function var_0_0.sendRoomAccelerateRequest(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = RoomModule_pb.RoomAccelerateRequest()

	var_29_0.buildingUid = arg_29_1
	var_29_0.useItemCount = arg_29_2
	var_29_0.slot = arg_29_3 or 0

	return arg_29_0:sendMsg(var_29_0, arg_29_4, arg_29_5)
end

function var_0_0.onReceiveRoomAccelerateReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		RoomBuildingController.instance:dispatchEvent(RoomEvent.AccelerateSuccess)
	end
end

function var_0_0.sendGetOtherRoomObInfoRequest(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = RoomModule_pb.GetOtherRoomObInfoRequest()

	var_31_0.targetUid = arg_31_1

	return arg_31_0:sendMsg(var_31_0, arg_31_2, arg_31_3)
end

function var_0_0.onReceiveGetOtherRoomObInfoReply(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendRoomLevelUpRequest(arg_33_0, arg_33_1, arg_33_2)
	RoomMapModel.instance:setRoomLeveling(true)

	local var_33_0 = RoomModule_pb.RoomLevelUpRequest()

	return arg_33_0:sendMsg(var_33_0, arg_33_1, arg_33_2)
end

function var_0_0.onReceiveRoomLevelUpReply(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == 0 then
		RoomModel.instance:updateRoomLevel(arg_34_2.roomLevel)
		RoomMapModel.instance:updateRoomLevel(arg_34_2.roomLevel)
		RoomProductionModel.instance:checkUnlockLine(arg_34_2.roomLevel)
		RoomProductionModel.instance:updateProductionLines(arg_34_2.productionLines)
		RoomProductionModel.instance:updateLineMaxLevel()
		RoomMapController.instance:dispatchEvent(RoomEvent.UpdateRoomLevel)
	end

	RoomMapModel.instance:setRoomLeveling(false)
end

function var_0_0.sendStartProductionLineRequest(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
	local var_35_0 = RoomModule_pb.StartProductionLineRequest()

	var_35_0.id = arg_35_1

	for iter_35_0, iter_35_1 in ipairs(arg_35_2) do
		local var_35_1 = RoomModule_pb.FormulaProduce()

		var_35_1.formulaId = iter_35_1.formulaId
		var_35_1.count = iter_35_1.count

		table.insert(var_35_0.formulaProduce, var_35_1)
	end

	if arg_35_3 then
		for iter_35_2, iter_35_3 in ipairs(arg_35_3) do
			local var_35_2 = MaterialModule_pb.MaterialData()

			var_35_2.materilType = iter_35_3.type
			var_35_2.materilId = iter_35_3.id
			var_35_2.quantity = iter_35_3.quantity

			table.insert(var_35_0.costCheck, var_35_2)
		end
	end

	return arg_35_0:sendMsg(var_35_0, arg_35_4, arg_35_5)
end

function var_0_0.onReceiveStartProductionLineReply(arg_36_0, arg_36_1, arg_36_2)
	RoomController.instance:dispatchEvent(RoomEvent.StartProductionLineReply, arg_36_1, arg_36_2)
end

function var_0_0.sendProductionLineInfoRequest(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = RoomModule_pb.ProductionLineInfoRequest()

	if arg_37_1 ~= nil then
		for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
			table.insert(var_37_0.ids, iter_37_1)
		end
	end

	return arg_37_0:sendMsg(var_37_0, arg_37_2, arg_37_3)
end

function var_0_0.onReceiveProductionLineInfoReply(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == 0 then
		RoomProductionModel.instance:updateProductionLines(arg_38_2.productionLines)
	end
end

function var_0_0.sendGainProductionLineRequest(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = RoomModule_pb.GainProductionLineRequest()

	if arg_39_1 ~= nil then
		for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
			table.insert(var_39_0.ids, iter_39_1)
		end
	end

	arg_39_2 = arg_39_2 or false
	GameMsgLockState.IgnoreCmds[var_0_0.GainProductionLineRequest] = arg_39_2

	return arg_39_0:sendMsg(var_39_0)
end

function var_0_0.onReceiveGainProductionLineReply(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0

	if arg_40_1 == 0 then
		var_40_0 = {}

		local var_40_1 = arg_40_2.productionLines

		RoomProductionModel.instance:updateProductionLines(var_40_1)

		for iter_40_0, iter_40_1 in ipairs(var_40_1) do
			if iter_40_1.id ~= 0 then
				table.insert(var_40_0, iter_40_1.id)
			end
		end
	end

	RoomController.instance:dispatchEvent(RoomEvent.GainProductionLineReply, arg_40_1, var_40_0)
end

function var_0_0.sendProductionLineLvUpRequest(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = RoomModule_pb.ProductionLineLvUpRequest()

	var_41_0.id = arg_41_1
	var_41_0.newLevel = arg_41_2

	return arg_41_0:sendMsg(var_41_0, arg_41_3, arg_41_4)
end

function var_0_0.onReceiveProductionLineLvUpReply(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == 0 then
		RoomProductionModel.instance:updateProductionLines({
			arg_42_2.productionLine
		})
		RoomController.instance:dispatchEvent(RoomEvent.ProduceLineLevelUp)
	end
end

function var_0_0.sendProductionLineAccelerateRequest(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = RoomModule_pb.ProductionLineAccelerateRequest()

	var_43_0.id = arg_43_1
	var_43_0.useItemCount = arg_43_2

	return arg_43_0:sendMsg(var_43_0, arg_43_3, arg_43_4)
end

function var_0_0.onReceiveProductionLineAccelerateReply(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 == 0 then
		RoomProductionModel.instance:updateProductionLines({
			arg_44_2.productionLine
		})
	end
end

function var_0_0.sendUpdateRoomHeroDataRequest(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = RoomModule_pb.UpdateRoomHeroDataRequest()

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		table.insert(var_45_0.roomHeroIds, iter_45_1)
	end

	return arg_45_0:sendMsg(var_45_0, arg_45_2, arg_45_3)
end

function var_0_0.onReceiveUpdateRoomHeroDataReply(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 == 0 then
		RoomModel.instance:setCharacterList(arg_46_2.roomHeroDatas)
	end
end

function var_0_0.sendGainRoomHeroFaithRequest(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = RoomModule_pb.GainRoomHeroFaithRequest()

	if arg_47_1 then
		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			table.insert(var_47_0.heroIds, iter_47_1)
		end
	end

	return arg_47_0:sendMsg(var_47_0, arg_47_2, arg_47_3)
end

function var_0_0.onReceiveGainRoomHeroFaithReply(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_1 == 0 then
		RoomCharacterController.instance:updateCharacterFaith(arg_48_2.roomHeroDatas)
		RoomCharacterController.instance:playCharacterFaithEffect(arg_48_2.roomHeroDatas)
	end
end

function var_0_0.sendHideBuildingReddotRequset(arg_49_0, arg_49_1)
	local var_49_0 = RoomModule_pb.HideBuildingReddotRequset()

	var_49_0.id = arg_49_1

	return arg_49_0:sendMsg(var_49_0)
end

function var_0_0.onReceiveHideBuildingReddotReply(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendHideBlockPackageReddotRequest(arg_51_0, arg_51_1)
	local var_51_0 = RoomModule_pb.HideBlockPackageReddotRequest()

	var_51_0.id = arg_51_1

	return arg_51_0:sendMsg(var_51_0)
end

function var_0_0.onReceiveHideBlockPackageReddotReply(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendStartCharacterInteractionRequest(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	local var_53_0 = RoomModule_pb.StartCharacterInteractionRequest()

	var_53_0.id = arg_53_1

	return arg_53_0:sendMsg(var_53_0, arg_53_2, arg_53_3)
end

function var_0_0.onReceiveStartCharacterInteractionReply(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1 == 0 then
		RoomModel.instance:interactStart(arg_54_2.id)
	end
end

function var_0_0.sendGetCharacterInteractionBonusRequest(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = RoomModule_pb.GetCharacterInteractionBonusRequest()

	var_55_0.id = arg_55_1

	if arg_55_2 then
		for iter_55_0, iter_55_1 in ipairs(arg_55_2) do
			table.insert(var_55_0.selectIds, iter_55_1)
		end
	end

	return arg_55_0:sendMsg(var_55_0)
end

function var_0_0.onReceiveGetCharacterInteractionBonusReply(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_1 == 0 then
		RoomModel.instance:interactComplete(arg_56_2.id)
	end
end

function var_0_0.sendGetCharacterInteractionInfoRequest(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = RoomModule_pb.GetCharacterInteractionInfoRequest()

	return arg_57_0:sendMsg(var_57_0, arg_57_1, arg_57_2)
end

function var_0_0.onReceiveGetCharacterInteractionInfoReply(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_1 == 0 then
		RoomModel.instance:updateInteraction(arg_58_2)
	end
end

function var_0_0.sendGetRoomThemeCollectionBonusRequest(arg_59_0, arg_59_1)
	local var_59_0 = RoomModule_pb.GetRoomThemeCollectionBonusRequest()

	var_59_0.id = arg_59_1

	return arg_59_0:sendMsg(var_59_0)
end

function var_0_0.onReceiveGetRoomThemeCollectionBonusReply(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1 == 0 then
		RoomController.instance:getRoomThemeCollectionBonusReply(arg_60_2)
	end
end

function var_0_0.sendGetRoomPlanInfoRequest(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = RoomModule_pb.GetRoomPlanInfoRequest()

	arg_61_0:sendMsg(var_61_0, arg_61_1, arg_61_2)
end

function var_0_0.onReceiveGetRoomPlanInfoReply(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 == 0 then
		RoomLayoutController.instance:getRoomPlanInfoReply(arg_62_2)
	end
end

function var_0_0.sendGetRoomPlanDetailsRequest(arg_63_0, arg_63_1)
	local var_63_0 = RoomModule_pb.GetRoomPlanDetailsRequest()

	var_63_0.id = arg_63_1

	arg_63_0:sendMsg(var_63_0)
end

function var_0_0.onReceiveGetRoomPlanDetailsReply(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_1 == 0 then
		RoomLayoutController.instance:getRoomPlanDestailsReply(arg_64_2)
	end
end

function var_0_0.sendSetRoomPlanRequest(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0 = RoomModule_pb.SetRoomPlanRequest()

	var_65_0.id = arg_65_1
	var_65_0.coverId = arg_65_2 or 1
	var_65_0.name = arg_65_3 or ""

	arg_65_0:sendMsg(var_65_0)
end

function var_0_0.onReceiveSetRoomPlanReply(arg_66_0, arg_66_1, arg_66_2)
	if arg_66_1 == 0 then
		RoomLayoutController.instance:setRoomPlanReply(arg_66_2)
	end
end

function var_0_0.sendSetRoomPlanNameRequest(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	local var_67_0 = RoomModule_pb.SetRoomPlanNameRequest()

	var_67_0.id = arg_67_1
	var_67_0.name = arg_67_2

	arg_67_0:sendMsg(var_67_0, arg_67_3, arg_67_4)
end

function var_0_0.onReceiveSetRoomPlanNameReply(arg_68_0, arg_68_1, arg_68_2)
	if arg_68_1 == 0 then
		RoomLayoutController.instance:setRoomPlanNameReply(arg_68_2)
	end
end

function var_0_0.sendSetRoomPlanCoverRequest(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = RoomModule_pb.SetRoomPlanCoverRequest()

	var_69_0.id = arg_69_1
	var_69_0.coverId = arg_69_2

	arg_69_0:sendMsg(var_69_0)
end

function var_0_0.onReceiveSetRoomPlanCoverReply(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1 == 0 then
		RoomLayoutController.instance:setRoomPlanCoverReply(arg_70_2)
	end
end

function var_0_0.sendUseRoomPlanRequest(arg_71_0, arg_71_1)
	local var_71_0 = RoomModule_pb.UseRoomPlanRequest()

	var_71_0.id = arg_71_1

	arg_71_0:sendMsg(var_71_0)
end

function var_0_0.onReceiveUseRoomPlanReply(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_1 == 0 then
		RoomLayoutController.instance:useRoomPlanReply(arg_72_2)
	end
end

function var_0_0.sendSwitchRoomPlanRequest(arg_73_0, arg_73_1, arg_73_2, arg_73_3, arg_73_4)
	local var_73_0 = RoomModule_pb.SwitchRoomPlanRequest()

	var_73_0.idA = arg_73_1
	var_73_0.idB = arg_73_2

	arg_73_0:sendMsg(var_73_0, arg_73_3, arg_73_4)
end

function var_0_0.onReceiveSwitchRoomPlanReply(arg_74_0, arg_74_1, arg_74_2)
	if arg_74_1 == 0 then
		RoomLayoutController.instance:switchRoomPlanReply(arg_74_2)
	end
end

function var_0_0.sendDeleteRoomPlanRequest(arg_75_0, arg_75_1)
	local var_75_0 = RoomModule_pb.DeleteRoomPlanRequest()

	var_75_0.id = arg_75_1

	arg_75_0:sendMsg(var_75_0)
end

function var_0_0.onReceiveDeleteRoomPlanReply(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_1 == 0 then
		RoomLayoutController.instance:deleteRoomPlanReply(arg_76_2)
	end
end

function var_0_0.sendCopyOtherRoomPlanRequest(arg_77_0, arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5, arg_77_6)
	local var_77_0 = RoomModule_pb.CopyOtherRoomPlanRequest()

	var_77_0.targetUid = arg_77_1
	var_77_0.id = arg_77_2
	var_77_0.coverId = arg_77_3
	var_77_0.name = arg_77_4

	arg_77_0:sendMsg(var_77_0, arg_77_5, arg_77_6)
end

function var_0_0.onReceiveCopyOtherRoomPlanReply(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_1 == 0 then
		RoomLayoutController.instance:copyOtherRoomPlanReply(arg_78_2)
	end
end

function var_0_0.sendGetRoomShareRequest(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	local var_79_0 = RoomModule_pb.GetRoomShareRequest()

	var_79_0.shareCode = arg_79_1

	arg_79_0:sendMsg(var_79_0, arg_79_2, arg_79_3)
end

function var_0_0.onReceiveGetRoomShareReply(arg_80_0, arg_80_1, arg_80_2)
	if arg_80_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendUseRoomShareRequest(arg_81_0, arg_81_1, arg_81_2, arg_81_3, arg_81_4, arg_81_5, arg_81_6)
	local var_81_0 = RoomModule_pb.UseRoomShareRequest()

	var_81_0.shareCode = arg_81_1
	var_81_0.id = arg_81_2
	var_81_0.coverId = arg_81_3
	var_81_0.name = arg_81_4

	arg_81_0:sendMsg(var_81_0, arg_81_5, arg_81_6)
end

function var_0_0.onReceiveUseRoomShareReply(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_1 == 0 then
		RoomLayoutController.instance:useRoomShareReply(arg_82_2)
	end
end

function var_0_0.sendShareRoomPlanRequest(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
	local var_83_0 = RoomModule_pb.ShareRoomPlanRequest()

	var_83_0.id = arg_83_1

	arg_83_0:sendMsg(var_83_0, arg_83_2, arg_83_3)
end

function var_0_0.onReceiveShareRoomPlanReply(arg_84_0, arg_84_1, arg_84_2)
	if arg_84_1 == 0 then
		RoomLayoutController.instance:shareRoomPlanReply(arg_84_2)
	end
end

function var_0_0.sendDeleteRoomShareRequest(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	local var_85_0 = RoomModule_pb.DeleteRoomShareRequest()

	var_85_0.id = arg_85_1

	arg_85_0:sendMsg(var_85_0, arg_85_2, arg_85_3)
end

function var_0_0.onReceiveDeleteRoomShareReply(arg_86_0, arg_86_1, arg_86_2)
	if arg_86_1 == 0 then
		RoomLayoutController.instance:deleteRoomShareReply(arg_86_2)
	end
end

function var_0_0.sendReportRoomRequest(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4, arg_87_5, arg_87_6)
	local var_87_0 = RoomModule_pb.ReportRoomRequest()

	var_87_0.reportedUserId = arg_87_1
	var_87_0.reportType = arg_87_2 or ""
	var_87_0.content = arg_87_3 or ""
	var_87_0.shareCode = arg_87_4 or ""

	arg_87_0:sendMsg(var_87_0, arg_87_5, arg_87_6)
end

function var_0_0.onReceiveReportRoomReply(arg_88_0, arg_88_1, arg_88_2)
	return
end

function var_0_0.onReceiveBuildingLevelUpPush(arg_89_0, arg_89_1, arg_89_2)
	if arg_89_1 == 0 then
		RoomModel.instance:updateBuildingInfos(arg_89_2.buildingInfos)
		RoomInventoryBuildingModel.instance:addBuilding(arg_89_2.buildingInfos)
		RoomMapController.instance:buildingLevelUpByInfos(arg_89_2.buildingInfos, true)
	end
end

function var_0_0.sendSetWaterTypeRequest(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	if not arg_90_1 then
		return
	end

	local var_90_0 = RoomModule_pb.SetWaterTypeRequest()

	for iter_90_0, iter_90_1 in pairs(arg_90_1) do
		local var_90_1 = RoomModule_pb.WaterInfo()

		var_90_1.blockId = iter_90_0
		var_90_1.waterType = iter_90_1

		table.insert(var_90_0.waterInfos, var_90_1)
	end

	arg_90_0:sendMsg(var_90_0, arg_90_2, arg_90_3)
end

function var_0_0.onReceiveSetWaterTypeReply(arg_91_0, arg_91_1, arg_91_2)
	if arg_91_1 ~= 0 then
		return
	end

	local var_91_0 = {}
	local var_91_1 = RoomMapBlockModel.instance:getBlockMODict()

	for iter_91_0, iter_91_1 in pairs(var_91_1) do
		for iter_91_2, iter_91_3 in pairs(iter_91_1) do
			var_91_0[iter_91_3.id] = iter_91_3
		end
	end

	for iter_91_4, iter_91_5 in ipairs(arg_91_2.infos) do
		local var_91_2 = var_91_0[iter_91_5.blockId]

		if var_91_2 then
			var_91_2:setWaterType(iter_91_5.waterType)
			var_91_2:setTempWaterType()
		end
	end

	GameFacade.showToast(ToastEnum.WaterReformSuccess)
	RoomWaterReformController.instance:refreshSelectWaterBlockEntity()
	RoomWaterReformController.instance:dispatchEvent(RoomEvent.WaterReformChangeWaterType)
end

function var_0_0.sendSetRoomSkinRequest(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4)
	if not arg_92_1 or not arg_92_2 then
		return
	end

	local var_92_0 = RoomModule_pb.SetRoomSkinRequest()

	var_92_0.id = arg_92_1
	var_92_0.skinId = arg_92_2

	arg_92_0:sendMsg(var_92_0, arg_92_3, arg_92_4)
end

function var_0_0.onReceiveSetRoomSkinReply(arg_93_0, arg_93_1, arg_93_2)
	if arg_93_1 ~= 0 then
		return
	end

	local var_93_0 = arg_93_2.skin.id
	local var_93_1 = arg_93_2.skin.skinId

	RoomSkinModel.instance:setRoomSkinEquipped(var_93_0, var_93_1)
	RoomSkinController.instance:dispatchEvent(RoomSkinEvent.ChangeEquipRoomSkin)
end

function var_0_0.sendReadRoomSkinRequest(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	if not arg_94_1 then
		return
	end

	local var_94_0 = RoomModule_pb.ReadRoomSkinRequest()

	var_94_0.skinId = arg_94_1

	arg_94_0:sendMsg(var_94_0, arg_94_2, arg_94_3)
end

function var_0_0.onReceiveReadRoomSkinReply(arg_95_0, arg_95_1, arg_95_2)
	if arg_95_1 ~= 0 then
		return
	end

	RoomSkinController.instance:dispatchEvent(RoomSkinEvent.RoomSkinMarkUpdate)
end

function var_0_0.sendBuyManufactureBuildingRequest(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	local var_96_0 = RoomModule_pb.BuyManufactureBuildingRequest()

	var_96_0.buildingId = arg_96_1

	arg_96_0:sendMsg(var_96_0, arg_96_2, arg_96_3)
end

function var_0_0.onReceiveBuyManufactureBuildingInfoReply(arg_97_0, arg_97_1, arg_97_2)
	if arg_97_1 == 0 then
		RoomBuildingController.instance:buyManufactureBuildingInfoReply(arg_97_2)
	end
end

function var_0_0.sendGenerateRoadRequest(arg_98_0, arg_98_1, arg_98_2, arg_98_3, arg_98_4)
	local var_98_0 = RoomModule_pb.GenerateRoadRequest()

	for iter_98_0, iter_98_1 in ipairs(arg_98_1) do
		local var_98_1 = RoomModule_pb.RoadInfo()

		var_98_1.id = iter_98_1.id > 0 and iter_98_1.id or 0
		var_98_1.fromType = iter_98_1.fromType
		var_98_1.toType = iter_98_1.toType
		var_98_1.critterUid = iter_98_1.critterUid or 0
		var_98_1.buildingUid = iter_98_1.buildingUid or 0
		var_98_1.blockCleanType = iter_98_1.blockCleanType or 0

		local var_98_2 = iter_98_1:getHexPointList()

		for iter_98_2, iter_98_3 in ipairs(var_98_2) do
			local var_98_3 = RoomModule_pb.RoadPoint()

			var_98_3.x = iter_98_3.x
			var_98_3.y = iter_98_3.y

			table.insert(var_98_1.roadPoints, var_98_3)
		end

		table.insert(var_98_0.roadInfos, var_98_1)
	end

	if arg_98_2 then
		for iter_98_4, iter_98_5 in ipairs(arg_98_2) do
			table.insert(var_98_0.ids, iter_98_5)
		end
	end

	arg_98_0:sendMsg(var_98_0, arg_98_3, arg_98_4)
end

function var_0_0.onReceiveGenerateRoadReply(arg_99_0, arg_99_1, arg_99_2)
	if arg_99_1 == 0 then
		RoomModel.instance:setRoadInfoListByMode(arg_99_2.validRoadInfos, RoomEnum.GameMode.Edit)
	end
end

function var_0_0.sendDeleteRoadRequest(arg_100_0, arg_100_1, arg_100_2, arg_100_3)
	local var_100_0 = RoomModule_pb.DeleteRoadRequest()

	for iter_100_0, iter_100_1 in ipairs(arg_100_1) do
		table.insert(var_100_0.ids, iter_100_1)
	end

	arg_100_0:sendMsg(var_100_0, arg_100_2, arg_100_3)
end

function var_0_0.onReceiveDeleteRoadReply(arg_101_0, arg_101_1, arg_101_2)
	if arg_101_1 == 0 then
		local var_101_0 = {}

		tabletool.addValues(var_101_0, arg_101_2.ids)
		RoomModel.instance:removeRoadInfoByIdsMode(var_101_0, RoomEnum.GameMode.Edit)
		RoomTransportController.instance:deleteRoadReply(arg_101_2)
	end
end

function var_0_0.sendAllotCritterRequestt(arg_102_0, arg_102_1, arg_102_2, arg_102_3, arg_102_4)
	local var_102_0 = RoomModule_pb.AllotCritterRequest()

	var_102_0.id = arg_102_1
	var_102_0.critterUid = arg_102_2

	arg_102_0:sendMsg(var_102_0, arg_102_3, arg_102_4)
end

function var_0_0.onReceiveAllotCritterReply(arg_103_0, arg_103_1, arg_103_2)
	if arg_103_1 == 0 then
		RoomTransportController.instance:allotCritterReply(arg_103_2)

		local var_103_0 = {
			arg_103_2.critterUid
		}
		local var_103_1 = {
			[arg_103_2.id] = var_103_0
		}

		ManufactureController.instance:removeRestingCritterList(var_103_0)
		CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, var_103_1, true)
	end
end

function var_0_0.sendAllotVehicleRequest(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4, arg_104_5)
	local var_104_0 = RoomModule_pb.AllotVehicleRequest()

	var_104_0.id = arg_104_1
	var_104_0.buildingUid = arg_104_2
	var_104_0.skinId = arg_104_3

	arg_104_0:sendMsg(var_104_0, arg_104_4, arg_104_5)
end

function var_0_0.onReceiveAllotVehicleReply(arg_105_0, arg_105_1, arg_105_2)
	if arg_105_1 == 0 then
		RoomTransportController.instance:allotVehicleReply(arg_105_2)
	end
end

function var_0_0.sendGetManufactureInfoRequest(arg_106_0, arg_106_1, arg_106_2)
	local var_106_0 = RoomModule_pb.GetManufactureInfoRequest()

	arg_106_0:sendMsg(var_106_0, arg_106_1, arg_106_2)
end

function var_0_0.onReceiveGetManufactureInfoReply(arg_107_0, arg_107_1, arg_107_2)
	if arg_107_1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManufactureInfo(arg_107_2)
end

function var_0_0.onReceiveManuBuildingInfoPush(arg_108_0, arg_108_1, arg_108_2)
	if arg_108_1 ~= 0 then
		return
	end

	ManufactureController.instance:updateFrozenItem(arg_108_2.frozenItems2Count)
	ManufactureController.instance:updateManuBuildingInfoList(arg_108_2.manuBuildingInfos)

	local var_108_0 = ManufactureController.instance:getPlayAddEffDict(arg_108_2.manuBuildingInfos)

	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayAddManufactureItemEff, var_108_0)
end

function var_0_0.sendManuBuildingUpgradeRequest(arg_109_0, arg_109_1, arg_109_2, arg_109_3)
	local var_109_0 = RoomModule_pb.ManuBuildingUpgradeRequest()

	var_109_0.uid = arg_109_1

	arg_109_0:sendMsg(var_109_0, arg_109_2, arg_109_3)
end

function var_0_0.onReceiveManuBuildingUpgradeReply(arg_110_0, arg_110_1, arg_110_2)
	if arg_110_1 ~= 0 then
		return
	end

	local var_110_0 = arg_110_2.manuBuildingInfo

	ManufactureController.instance:updateManuBuildingInfo(var_110_0)
end

function var_0_0.sendSelectSlotProductionPlanRequest(arg_111_0, arg_111_1, arg_111_2)
	local var_111_0 = RoomModule_pb.SelectSlotProductionPlanRequest()

	var_111_0.uid = arg_111_1

	for iter_111_0, iter_111_1 in ipairs(arg_111_2) do
		local var_111_1 = RoomModule_pb.OperationInfo()

		var_111_1.slotId = iter_111_1.slotId
		var_111_1.operation = iter_111_1.operation
		var_111_1.productionId = iter_111_1.productionId
		var_111_1.priority = iter_111_1.priority

		table.insert(var_111_0.operationInfos, var_111_1)
	end

	arg_111_0:sendMsg(var_111_0)
end

function var_0_0.onReceiveSelectSlotProductionPlanReply(arg_112_0, arg_112_1, arg_112_2)
	if arg_112_1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfoList(arg_112_2.manuBuildingInfos, true)

	local var_112_0 = ManufactureController.instance:getPlayAddEffDict(arg_112_2.manuBuildingInfos)

	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayAddManufactureItemEff, var_112_0)
end

function var_0_0.sendManufactureAccelerateRequest(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
	local var_113_0 = RoomModule_pb.ManufactureAccelerateRequest()

	var_113_0.uid = arg_113_1
	var_113_0.slotId = arg_113_3
	var_113_0.useItemData.materilType = arg_113_2.type
	var_113_0.useItemData.materilId = arg_113_2.id
	var_113_0.useItemData.quantity = arg_113_2.quantity

	arg_113_0:sendMsg(var_113_0)
end

function var_0_0.onReceiveManufactureAccelerateReply(arg_114_0, arg_114_1, arg_114_2)
	if arg_114_1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfoList(arg_114_2.manuBuildingInfos, true)
end

function var_0_0.sendReapFinishSlotRequest(arg_115_0, arg_115_1)
	local var_115_0 = RoomModule_pb.ReapFinishSlotRequest()

	var_115_0.buildingUid = arg_115_1

	arg_115_0:sendMsg(var_115_0)
end

function var_0_0.onReceiveReapFinishSlotReply(arg_116_0, arg_116_1, arg_116_2)
	if arg_116_1 ~= 0 then
		return
	end

	local var_116_0 = {}

	for iter_116_0, iter_116_1 in ipairs(arg_116_2.normalReapItem) do
		local var_116_1 = MaterialDataMO.New()

		var_116_1:init(iter_116_1)
		table.insert(var_116_0, var_116_1)
	end

	for iter_116_2, iter_116_3 in ipairs(arg_116_2.criReapItem) do
		local var_116_2 = MaterialDataMO.New()

		var_116_2:init(iter_116_3)

		var_116_2.isShowExtra = true

		table.insert(var_116_0, var_116_2)
	end

	local var_116_3 = {}

	for iter_116_4, iter_116_5 in ipairs(arg_116_2.occupiedCriItem) do
		local var_116_4 = MaterialDataMO.New()

		var_116_4:init(iter_116_5)
		table.insert(var_116_3, var_116_4)
	end

	if next(var_116_0) or next(var_116_3) then
		ViewMgr.instance:openView(ViewName.RoomManufactureGetView, {
			normalList = var_116_0,
			usedList = var_116_3
		})
	else
		GameFacade.showToast(ToastEnum.RoomNoManufactureItemGet)
	end

	ManufactureController.instance:updateManuBuildingInfoList(arg_116_2.manuBuildingInfos, true)
end

function var_0_0.sendDispatchCritterRequest(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	local var_117_0 = RoomModule_pb.DispatchCritterRequest()

	var_117_0.buildingUid = arg_117_1
	var_117_0.critterUid = arg_117_2
	var_117_0.critterSlotId = arg_117_3

	arg_117_0:sendMsg(var_117_0)
end

function var_0_0.onReceiveDispatchCritterReply(arg_118_0, arg_118_1, arg_118_2)
	if arg_118_1 ~= 0 then
		return
	end

	ManufactureController.instance:updateWorkCritterInfo(arg_118_2.buildingUid)

	if arg_118_2.putSlotId then
		local var_118_0 = {
			[arg_118_2.buildingUid] = {
				[arg_118_2.putSlotId] = arg_118_2.critterUid
			}
		}

		CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, var_118_0)
	end

	if arg_118_2.infos then
		for iter_118_0, iter_118_1 in ipairs(arg_118_2.infos) do
			RoomTransportController.instance:allotCritterReply(iter_118_1)
		end
	end
end

function var_0_0.sendBuyRestSlotRequest(arg_119_0, arg_119_1, arg_119_2)
	local var_119_0 = RoomModule_pb.BuyRestSlotRequest()

	var_119_0.buildingUid = arg_119_1
	var_119_0.buySlotId = arg_119_2

	arg_119_0:sendMsg(var_119_0)
end

function var_0_0.onReceiveBuyRestSlotReply(arg_120_0, arg_120_1, arg_120_2)
	if arg_120_1 ~= 0 then
		return
	end

	CritterController.instance:buySeatSlotCb(arg_120_2.buildingUid, arg_120_2.buySlotId)
end

function var_0_0.sendChangeRestCritterRequest(arg_121_0, arg_121_1, arg_121_2, arg_121_3, arg_121_4, arg_121_5, arg_121_6, arg_121_7)
	local var_121_0 = RoomModule_pb.ChangeRestCritterRequest()

	var_121_0.buildingUid = arg_121_1
	var_121_0.operation = arg_121_2
	var_121_0.slotId1 = arg_121_3
	var_121_0.critterUid = arg_121_4
	var_121_0.slotId2 = arg_121_5

	arg_121_0:sendMsg(var_121_0, arg_121_6, arg_121_7)
end

function var_0_0.onReceiveChangeRestCritterReply(arg_122_0, arg_122_1, arg_122_2)
	if arg_122_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveRestBuildingInfoPush(arg_123_0, arg_123_1, arg_123_2)
	if arg_123_1 ~= 0 then
		return
	end

	CritterController.instance:setCritterBuildingInfoList(arg_123_2.restBuildingInfos)
end

function var_0_0.onReceiveRoadInfoPush(arg_124_0, arg_124_1, arg_124_2)
	if arg_124_1 ~= 0 then
		return
	end

	RoomTransportController.instance:batchCritterReply(arg_124_2.roadInfos)
end

function var_0_0.sendFeedCritterRequest(arg_125_0, arg_125_1, arg_125_2, arg_125_3, arg_125_4)
	local var_125_0 = RoomModule_pb.FeedCritterRequest()

	var_125_0.critterUid = arg_125_1
	var_125_0.useFoodData.materilType = arg_125_2.type
	var_125_0.useFoodData.materilId = arg_125_2.id
	var_125_0.useFoodData.quantity = arg_125_2.quantity

	arg_125_0:sendMsg(var_125_0, arg_125_3, arg_125_4)
end

function var_0_0.onReceiveFeedCritterReply(arg_126_0, arg_126_1, arg_126_2)
	if arg_126_1 ~= 0 then
		return
	end
end

function var_0_0.sendBatchDispatchCrittersRequest(arg_127_0, arg_127_1)
	local var_127_0 = RoomModule_pb.BatchDispatchCrittersRequest()

	var_127_0.type = arg_127_1

	arg_127_0:sendMsg(var_127_0)
end

function var_0_0.onReceiveBatchDispatchCrittersReply(arg_128_0, arg_128_1, arg_128_2)
	if arg_128_1 ~= 0 then
		return
	end

	ManufactureController.instance:openRouseCritterView(arg_128_2)
end

function var_0_0.sendRouseCrittersRequest(arg_129_0, arg_129_1, arg_129_2)
	local var_129_0 = RoomModule_pb.RouseCrittersRequest()

	var_129_0.type = arg_129_1

	for iter_129_0, iter_129_1 in ipairs(arg_129_2) do
		local var_129_1 = RoomModule_pb.BatchDispatchInfo()

		var_129_1.buildingUid = iter_129_1.buildingUid
		var_129_1.roadId = iter_129_1.roadId

		for iter_129_2, iter_129_3 in ipairs(iter_129_1.critterUids) do
			table.insert(var_129_1.critterUids, iter_129_3)
		end

		table.insert(var_129_0.infos, var_129_1)
	end

	arg_129_0:sendMsg(var_129_0)
end

function var_0_0.onReceiveRouseCrittersReply(arg_130_0, arg_130_1, arg_130_2)
	if arg_130_1 ~= 0 then
		return
	end

	local var_130_0 = {}
	local var_130_1 = arg_130_2.type == CritterEnum.OneKeyType.Transport

	if var_130_1 then
		RoomTransportController.instance:batchCritterReply(arg_130_2.roadInfos)
	end

	local var_130_2 = {}

	if arg_130_2.validInfos then
		for iter_130_0, iter_130_1 in ipairs(arg_130_2.validInfos) do
			local var_130_3 = var_130_1 and iter_130_1.roadId or iter_130_1.buildingUid

			var_130_0[var_130_3] = var_130_0[var_130_3] or {}

			for iter_130_2, iter_130_3 in ipairs(iter_130_1.infos) do
				local var_130_4 = iter_130_3.critterUid

				var_130_0[var_130_3][iter_130_3.slotId] = var_130_4
				var_130_2[#var_130_2 + 1] = var_130_4
			end
		end
	end

	ManufactureController.instance:removeRestingCritterList(var_130_2)
	CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, var_130_0, var_130_1)
end

function var_0_0.sendBatchAddProctionsRequest(arg_131_0, arg_131_1, arg_131_2, arg_131_3, arg_131_4, arg_131_5)
	local var_131_0 = RoomModule_pb.BatchAddProctionsRequest()

	var_131_0.type = arg_131_1
	var_131_0.freeInfo.buildingType = arg_131_2 or 0
	var_131_0.freeInfo.buildingDefineId = arg_131_3 or 0

	local var_131_1 = MaterialModule_pb.M2QEntry()

	var_131_1.materialId = arg_131_4 or 0
	var_131_1.quantity = arg_131_5 or 0

	table.insert(var_131_0.freeInfo.item2Count, var_131_1)
	arg_131_0:sendMsg(var_131_0)
end

function var_0_0.onReceiveBatchAddProctionsReply(arg_132_0, arg_132_1, arg_132_2)
	if arg_132_1 ~= 0 then
		return
	end
end

function var_0_0.sendGetFrozenItemInfoRequest(arg_133_0)
	local var_133_0 = RoomModule_pb.GetFrozenItemInfoRequest()

	arg_133_0:sendMsg(var_133_0)
end

function var_0_0.onReceiveGetFrozenItemInfoReply(arg_134_0, arg_134_1, arg_134_2)
	if arg_134_1 ~= 0 then
		return
	end

	ManufactureController.instance:updateFrozenItem(arg_134_2.frozenItems2Count)
end

function var_0_0.sendGetOrderInfoRequest(arg_135_0, arg_135_1, arg_135_2)
	local var_135_0 = RoomModule_pb.GetOrderInfoRequest()

	arg_135_0:sendMsg(var_135_0, arg_135_1, arg_135_2)
end

function var_0_0.onReceiveGetOrderInfoReply(arg_136_0, arg_136_1, arg_136_2)
	if arg_136_1 ~= 0 then
		return
	end

	RoomTradeModel.instance:onGetOrderInfo(arg_136_2)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeOrderInfo)
end

function var_0_0.sendFinishOrderRequest(arg_137_0, arg_137_1, arg_137_2, arg_137_3)
	local var_137_0 = RoomModule_pb.FinishOrderRequest()

	var_137_0.orderType = arg_137_1
	var_137_0.orderId = arg_137_2

	if arg_137_3 then
		var_137_0.sellCount = arg_137_3
	end

	arg_137_0:sendMsg(var_137_0)
end

function var_0_0.onReceiveFinishOrderReply(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_1 ~= 0 then
		return
	end

	RoomTradeController.instance:onFinishOrderReply(arg_138_2)
end

function var_0_0.sendRefreshPurchaseOrderRequest(arg_139_0, arg_139_1, arg_139_2, arg_139_3, arg_139_4, arg_139_5)
	local var_139_0 = RoomModule_pb.RefreshPurchaseOrderRequest()

	var_139_0.orderId = arg_139_1
	var_139_0.guideId = arg_139_2 or 0
	var_139_0.step = arg_139_3 or 0

	arg_139_0:sendMsg(var_139_0, arg_139_4, arg_139_5)
end

function var_0_0.onReceiveRefreshPurchaseOrderReply(arg_140_0, arg_140_1, arg_140_2)
	if arg_140_1 ~= 0 then
		return
	end

	RoomTradeController.instance:onRefreshDailyOrderReply(arg_140_2)
end

function var_0_0.sendChangePurchaseOrderTraceStateRequest(arg_141_0, arg_141_1, arg_141_2)
	local var_141_0 = RoomModule_pb.ChangePurchaseOrderTraceStateRequest()

	var_141_0.orderId = arg_141_1
	var_141_0.isTrace = arg_141_2

	arg_141_0:sendMsg(var_141_0)
end

function var_0_0.onReceiveChangePurchaseOrderTraceStateReply(arg_142_0, arg_142_1, arg_142_2)
	if arg_142_1 ~= 0 then
		return
	end

	RoomTradeController.instance:onTracedDailyOrderReply(arg_142_2)
end

function var_0_0.sendLockOrderRequest(arg_143_0, arg_143_1, arg_143_2)
	local var_143_0 = RoomModule_pb.LockOrderRequest()

	var_143_0.orderId = arg_143_1
	var_143_0.operation = arg_143_2 and 1 or 2

	arg_143_0:sendMsg(var_143_0)
end

function var_0_0.onReceiveLockOrderReply(arg_144_0, arg_144_1, arg_144_2)
	if arg_144_1 ~= 0 then
		return
	end

	RoomTradeController.instance:onLockedDailyOrderReply(arg_144_2)
end

function var_0_0.sendGetTradeTaskInfoRequest(arg_145_0, arg_145_1, arg_145_2)
	local var_145_0 = RoomModule_pb.GetTradeTaskInfoRequest()

	arg_145_0:sendMsg(var_145_0, arg_145_1, arg_145_2)
end

function var_0_0.onReceiveGetTradeTaskInfoReply(arg_146_0, arg_146_1, arg_146_2)
	if arg_146_1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onGetTradeTaskInfo(arg_146_2)
end

function var_0_0.sendReadNewTradeTaskRequest(arg_147_0, arg_147_1)
	local var_147_0 = RoomModule_pb.ReadNewTradeTaskRequest()

	for iter_147_0, iter_147_1 in pairs(arg_147_1) do
		var_147_0.ids:append(iter_147_1)
	end

	arg_147_0:sendMsg(var_147_0)
end

function var_0_0.onReceiveReadNewTradeTaskReply(arg_148_0, arg_148_1, arg_148_2)
	if arg_148_1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onReadNewTradeTask(arg_148_2.ids)
end

function var_0_0.sendGetTradeSupportBonusRequest(arg_149_0, arg_149_1)
	local var_149_0 = RoomModule_pb.GetTradeSupportBonusRequest()

	var_149_0.id = arg_149_1

	arg_149_0:sendMsg(var_149_0)
end

function var_0_0.onReceiveGetTradeSupportBonusReply(arg_150_0, arg_150_1, arg_150_2)
	if arg_150_1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onGetLevelBonus(arg_150_2.id)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeSupportBonusReply)
end

function var_0_0.sendTradeLevelUpRequest(arg_151_0)
	local var_151_0 = RoomModule_pb.TradeLevelUpRequest()

	arg_151_0:sendMsg(var_151_0)
end

function var_0_0.onReceiveTradeLevelUpReply(arg_152_0, arg_152_1, arg_152_2)
	if arg_152_1 ~= 0 then
		return
	end

	ManufactureModel.instance:setTradeLevel(arg_152_2.level)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnTradeLevelUpReply, arg_152_2.level)
end

function var_0_0.onReceiveTradeTaskPush(arg_153_0, arg_153_1, arg_153_2)
	if arg_153_1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onRefeshTaskMo(arg_153_2.infos)
	arg_153_0:sendGetTradeTaskInfoRequest()
end

function var_0_0.sendGetTradeTaskExtraBonusRequest(arg_154_0)
	local var_154_0 = RoomModule_pb.GetTradeTaskExtraBonusRequest()

	arg_154_0:sendMsg(var_154_0)
end

function var_0_0.onReceiveGetTradeTaskExtraBonusReply(arg_155_0, arg_155_1, arg_155_2)
	if arg_155_1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:setCanGetExtraBonus()
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeTaskExtraBonusReply)
end

function var_0_0.sendGetRoomLogRequest(arg_156_0)
	local var_156_0 = RoomModule_pb.GetRoomLogRequest()

	arg_156_0:sendMsg(var_156_0)
end

function var_0_0.onReceiveGetRoomLogReply(arg_157_0, arg_157_1, arg_157_2)
	if arg_157_1 ~= 0 then
		return
	end

	RoomLogModel.instance:setInfos(arg_157_2.infos)
end

function var_0_0.sendReadRoomLogNewRequest(arg_158_0, arg_158_1)
	local var_158_0 = RoomModule_pb.ReadRoomLogNewRequest()

	arg_158_0:sendMsg(var_158_0)
end

function var_0_0.onReceiveReadRoomLogNewReply(arg_159_0, arg_159_1, arg_159_2)
	if arg_159_1 ~= 0 then
		return
	end
end

function var_0_0.sendGainGuideBuildingRequest(arg_160_0, arg_160_1, arg_160_2)
	local var_160_0 = RoomModule_pb.GainGuideBuildingRequest()

	var_160_0.guideId = arg_160_1
	var_160_0.step = arg_160_2

	arg_160_0:sendMsg(var_160_0)
end

function var_0_0.onReceiveGainGuideBuildingReply(arg_161_0, arg_161_1, arg_161_2)
	if arg_161_1 ~= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.GetGuideBuilding, arg_161_2)
end

function var_0_0.sendAccelerateGuidePlanRequest(arg_162_0, arg_162_1, arg_162_2)
	local var_162_0 = RoomModule_pb.AccelerateGuidePlanRequest()

	var_162_0.guideId = arg_162_1
	var_162_0.step = arg_162_2

	arg_162_0:sendMsg(var_162_0)
end

function var_0_0.onReceiveAccelerateGuidePlanReply(arg_163_0, arg_163_1, arg_163_2)
	if arg_163_1 ~= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.AccelerateGuidePlan, arg_163_2)
end

function var_0_0.sendUnloadRestBuildingCrittersRequest(arg_164_0, arg_164_1, arg_164_2, arg_164_3)
	local var_164_0 = RoomModule_pb.UnloadRestBuildingCrittersRequest()

	var_164_0.buildingUid = arg_164_1

	arg_164_0:sendMsg(var_164_0, arg_164_2, arg_164_3)
end

function var_0_0.onReceiveUnloadRestBuildingCrittersReply(arg_165_0, arg_165_1, arg_165_2)
	return
end

function var_0_0.sendReplaceRestBuildingCrittersRequest(arg_166_0, arg_166_1, arg_166_2, arg_166_3)
	local var_166_0 = RoomModule_pb.ReplaceRestBuildingCrittersRequest()

	var_166_0.buildingUid = arg_166_1

	arg_166_0:sendMsg(var_166_0, arg_166_2, arg_166_3)
end

function var_0_0.onReceiveReplaceRestBuildingCrittersReply(arg_167_0, arg_167_1, arg_167_2)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
