module("modules.logic.survival.rpc.SurvivalWeekRpc", package.seeall)

local var_0_0 = class("SurvivalWeekRpc", BaseRpc)

function var_0_0.onReceiveSurvivalBagUpdatePush(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalBagUpdatePush", arg_1_2)
	end
end

function var_0_0.sendSurvivalRemoveBagItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = SurvivalWeekModule_pb.SurvivalRemoveBagItemRequest()

	var_2_0.bagType = arg_2_1
	var_2_0.uid = arg_2_2
	var_2_0.count = arg_2_3

	return arg_2_0:sendMsg(var_2_0, arg_2_4, arg_2_5)
end

function var_0_0.onReceiveSurvivalRemoveBagItemReply(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalPanelOperationRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = SurvivalWeekModule_pb.SurvivalPanelOperationRequest()

	var_4_0.panelUid = arg_4_1
	var_4_0.operation = arg_4_2

	return arg_4_0:sendMsg(var_4_0, arg_4_3, arg_4_4)
end

function var_0_0.onReceiveSurvivalPanelOperationReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalClosePanelRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = SurvivalWeekModule_pb.SurvivalClosePanelRequest()

	var_6_0.panelUid = arg_6_1

	return arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveSurvivalClosePanelReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalStartWeekChooseDiff(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = SurvivalWeekModule_pb.SurvivalStartWeekChooseDiffRequest()

	var_8_0.difficulty = arg_8_1

	if arg_8_2 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
			table.insert(var_8_0.hardnessId, iter_8_1)
		end
	end

	return arg_8_0:sendMsg(var_8_0, arg_8_3, arg_8_4)
end

function var_0_0.onReceiveSurvivalStartWeekChooseDiffReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		SurvivalShelterModel.instance:setWeekData(arg_9_2.weekInfo, true, arg_9_2.extendScore)

		if arg_9_2.weekInfo.difficulty ~= SurvivalConst.FirstPlayDifficulty then
			ViewMgr.instance:closeView(ViewName.SurvivalHardView)
		end

		local var_9_0 = arg_9_2.weekInfo.difficulty == SurvivalConst.FirstPlayDifficulty

		ViewMgr.instance:openView(ViewName.SurvivalSelectTalentTreeView, {
			isFirstPlayer = var_9_0
		})
	end
end

function var_0_0.sendSurvivalGetWeekInfo(arg_10_0, arg_10_1, arg_10_2)
	SurvivalMapHelper.instance:clearSteps()

	local var_10_0 = SurvivalWeekModule_pb.SurvivalGetWeekInfoRequest()

	return arg_10_0:sendMsg(var_10_0, arg_10_1, arg_10_2)
end

function var_0_0.onReceiveSurvivalGetWeekInfoReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		local var_11_0 = SurvivalShelterModel.instance:haveBoss()

		SurvivalShelterModel.instance:setWeekData(arg_11_2.weekInfo)

		if not var_11_0 and SurvivalShelterModel.instance:haveBoss() then
			SurvivalShelterModel.instance:setNeedShowBossInvade(true)
		end
	end
end

function var_0_0.onReceiveSurvivalWeekInfoPush(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		local var_12_0 = SurvivalShelterModel.instance:haveBoss()

		SurvivalShelterModel.instance:setWeekData(arg_12_2.weekInfo)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnWeekInfoUpdate)

		if not var_12_0 and SurvivalShelterModel.instance:haveBoss() then
			SurvivalShelterModel.instance:setNeedShowBossInvade(true)
		end
	end
end

function var_0_0.sendSurvivalGetEquipInfo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SurvivalWeekModule_pb.SurvivalGetEquipInfoRequest()

	return arg_13_0:sendMsg(var_13_0, arg_13_1, arg_13_2)
end

function var_0_0.onReceiveSurvivalGetEquipInfoReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().equipBox:init(arg_14_2.equipBox)
	end
end

function var_0_0.sendSurvivalEquipSetNewFlagRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = SurvivalWeekModule_pb.SurvivalEquipSetNewFlagRequest()

	if arg_15_1 then
		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			table.insert(var_15_0.slotId, iter_15_1)
		end
	end

	return arg_15_0:sendMsg(var_15_0, arg_15_2, arg_15_3)
end

function var_0_0.onReceiveSurvivalEquipSetNewFlagReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		local var_16_0 = SurvivalShelterModel.instance:getWeekInfo()

		for iter_16_0, iter_16_1 in ipairs(arg_16_2.slots) do
			if var_16_0.equipBox.slots[iter_16_1.slotId] then
				var_16_0.equipBox.slots[iter_16_1.slotId]:init(iter_16_1)
			end
		end

		var_16_0.equipBox:calcAttrs()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
	end
end

function var_0_0.sendSurvivalEquipSwitchPlan(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = SurvivalWeekModule_pb.SurvivalEquipSwitchPlanRequest()

	var_17_0.newPlanId = arg_17_1

	return arg_17_0:sendMsg(var_17_0, arg_17_2, arg_17_3)
end

function var_0_0.onReceiveSurvivalEquipSwitchPlanReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().equipBox:init(arg_18_2.equipBox)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
		SurvivalEquipRedDotHelper.instance:checkRed()
	end
end

function var_0_0.sendSurvivalEquipWear(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = SurvivalWeekModule_pb.SurvivalEquipWearRequest()

	var_19_0.slotId = arg_19_1
	var_19_0.uid = arg_19_2

	return arg_19_0:sendMsg(var_19_0, arg_19_3, arg_19_4)
end

function var_0_0.onReceiveSurvivalEquipWearReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalEquipDemount(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = SurvivalWeekModule_pb.SurvivalEquipDemountRequest()

	var_21_0.slotId = arg_21_1

	return arg_21_0:sendMsg(var_21_0, arg_21_2, arg_21_3)
end

function var_0_0.onReceiveSurvivalEquipDemountReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalJewelryEquipWear(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = SurvivalWeekModule_pb.SurvivalJewelryEquipWearRequest()

	var_23_0.slotId = arg_23_1
	var_23_0.uid = arg_23_2

	return arg_23_0:sendMsg(var_23_0, arg_23_3, arg_23_4)
end

function var_0_0.onReceiveSurvivalJewelryEquipWearReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalJewelryEquipDemount(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = SurvivalWeekModule_pb.SurvivalJewelryEquipDemountRequest()

	var_25_0.slotId = arg_25_1

	return arg_25_0:sendMsg(var_25_0, arg_25_2, arg_25_3)
end

function var_0_0.onReceiveSurvivalJewelryEquipDemountReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalEquipOneKeyWear(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = SurvivalWeekModule_pb.SurvivalEquipOneKeyWearRequest()

	var_27_0.tagId = arg_27_1
	arg_27_0.oneKeyTagId = arg_27_1

	return arg_27_0:sendMsg(var_27_0, arg_27_2, arg_27_3)
end

function var_0_0.onReceiveSurvivalEquipOneKeyWearReply(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		local var_28_0 = SurvivalShelterModel.instance:getWeekInfo()

		if not var_28_0 or not arg_28_0.oneKeyTagId then
			return
		end

		local var_28_1 = var_28_0.equipBox.maxTagId

		if var_28_1 ~= arg_28_0.oneKeyTagId then
			local var_28_2 = true

			for iter_28_0, iter_28_1 in pairs(var_28_0.equipBox.slots) do
				if not iter_28_1.item:isEmpty() then
					var_28_2 = false

					break
				end
			end

			if var_28_2 then
				return
			end

			local var_28_3 = lua_survival_equip_found.configDict[arg_28_0.oneKeyTagId]
			local var_28_4 = lua_survival_equip_found.configDict[var_28_1]

			if not var_28_3 or not var_28_4 then
				GameFacade.showToast(ToastEnum.SurvivalEquipTagNoEnough2)
			else
				GameFacade.showToast(ToastEnum.SurvivalEquipTagNoEnough, var_28_3.name, var_28_4.name)
			end
		end
	end
end

function var_0_0.sendSurvivalEquipOneKeyDemount(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = SurvivalWeekModule_pb.SurvivalEquipOneKeyDemountRequest()

	return arg_29_0:sendMsg(var_29_0, arg_29_1, arg_29_2)
end

function var_0_0.onReceiveSurvivalEquipOneKeyDemountReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalEquipUpdatePush(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().equipBox:init(arg_31_2.equipBox)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
		SurvivalEquipRedDotHelper.instance:checkRed()
	end
end

function var_0_0.sendSurvivalEquipCompound(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = SurvivalWeekModule_pb.SurvivalEquipCompoundRequest()

	if arg_32_1 then
		for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
			table.insert(var_32_0.uid, iter_32_1)
		end
	end

	return arg_32_0:sendMsg(var_32_0, arg_32_2, arg_32_3)
end

function var_0_0.onReceiveSurvivalEquipCompoundReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalChooseBooty(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	local var_34_0 = SurvivalWeekModule_pb.SurvivalChooseBootyRequest()

	if arg_34_1 then
		for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
			table.insert(var_34_0.npcId, iter_34_1)
		end
	end

	if arg_34_2 then
		for iter_34_2, iter_34_3 in ipairs(arg_34_2) do
			table.insert(var_34_0.equipId, iter_34_3)
		end
	end

	if arg_34_5 then
		UIBlockHelper.instance:startBlock(UIBlockKey.SurvivalCommon, 3)

		arg_34_0.isBlock = true
	end

	return arg_34_0:sendMsg(var_34_0, arg_34_3, arg_34_4)
end

function var_0_0.onReceiveSurvivalChooseBootyReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0.isBlock then
		UIBlockMgr.instance:endBlock(UIBlockKey.SurvivalCommon)

		arg_35_0.isBlock = nil
	end

	if arg_35_1 == 0 then
		SurvivalShelterModel.instance:setWeekData(arg_35_2.weekInfo, true)

		local var_35_0 = SurvivalModel.instance:getOutSideInfo()

		if var_35_0 then
			var_35_0.inWeek = true
		end

		SurvivalController.instance:enterSurvivalShelterScene()
	end
end

function var_0_0.sendSurvivalAbandonWeek(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = SurvivalWeekModule_pb.SurvivalAbandonWeekRequest()

	return arg_36_0:sendMsg(var_36_0, arg_36_1, arg_36_2)
end

function var_0_0.onReceiveSurvivalAbandonWeekReply(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 == 0 then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
	end
end

function var_0_0.onReceiveSurvivalSettleWeekPush(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == 0 then
		SurvivalController.instance:playSettleWork(arg_38_2)
	end
end

function var_0_0.sendSurvivalBuildRequest(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = SurvivalWeekModule_pb.SurvivalBuildRequest()

	var_39_0.id = arg_39_1

	return arg_39_0:sendMsg(var_39_0, arg_39_2, arg_39_3)
end

function var_0_0.onReceiveSurvivalBuildReply(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 == 0 then
		local var_40_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_40_0 then
			var_40_0:updateBuildingInfo(arg_40_2.building)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate, arg_40_2.building.id)
		end
	end
end

function var_0_0.sendSurvivalRepairRequest(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = SurvivalWeekModule_pb.SurvivalRepairRequest()

	var_41_0.id = arg_41_1

	return arg_41_0:sendMsg(var_41_0, arg_41_2, arg_41_3)
end

function var_0_0.onReceiveSurvivalRepairReply(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == 0 then
		local var_42_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_42_0 then
			var_42_0:updateBuildingInfo(arg_42_2.building)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate)
		end
	end
end

function var_0_0.sendSurvivalUpgradeRequest(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = SurvivalWeekModule_pb.SurvivalUpgradeRequest()

	var_43_0.id = arg_43_1

	local var_43_1 = SurvivalShelterModel.instance:getWeekInfo()

	if var_43_1 then
		var_43_1:lockBuildingLevel(arg_43_1)
	end

	return arg_43_0:sendMsg(var_43_0, arg_43_2, arg_43_3)
end

function var_0_0.onReceiveSurvivalUpgradeReply(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 == 0 then
		local var_44_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_44_0 then
			var_44_0:updateBuildingInfo(arg_44_2.building, true)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate, arg_44_2.building.id)
		end
	end
end

function var_0_0.onReceiveSurvivalAttrContainerUpdatePush(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 == 0 then
		local var_45_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_45_0 then
			var_45_0:updateAttrs(arg_45_2.updates)
		end
	end
end

function var_0_0.sendSurvivalNpcChangePositionRequest(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = SurvivalWeekModule_pb.SurvivalNpcChangePositionRequest()

	var_46_0.npcId = arg_46_1
	var_46_0.buildingId = arg_46_2
	var_46_0.position = arg_46_3

	return arg_46_0:sendMsg(var_46_0, arg_46_4, arg_46_5)
end

function var_0_0.onReceiveSurvivalNpcChangePositionReply(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 == 0 then
		local var_47_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_47_0 then
			var_47_0:changeNpcPostion(arg_47_2.npcId, arg_47_2.buildingId, arg_47_2.position)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNpcPostionChange)
		end
	end
end

function var_0_0.sendSurvivalNpcExchangePositionRequest(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = SurvivalWeekModule_pb.SurvivalNpcExchangePositionRequest()

	var_48_0.srcNpcId = arg_48_1
	var_48_0.targetNpcId = arg_48_2

	return arg_48_0:sendMsg(var_48_0, arg_48_3, arg_48_4)
end

function var_0_0.onReceiveSurvivalNpcExchangePositionReply(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 == 0 then
		local var_49_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_49_0 then
			var_49_0:exchangeNpcPosition(arg_49_2.srcNpcId, arg_49_2.targetNpcId)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNpcPostionChange)
		end
	end
end

function var_0_0.sendSurvivalBatchHeroChangePositionRequest(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	local var_50_0 = SurvivalWeekModule_pb.SurvivalBatchHeroChangePositionRequest()

	if arg_50_1 then
		for iter_50_0, iter_50_1 in ipairs(arg_50_1) do
			table.insert(var_50_0.heroId, iter_50_1)
		end
	end

	var_50_0.buildingId = arg_50_2

	return arg_50_0:sendMsg(var_50_0, arg_50_3, arg_50_4)
end

function var_0_0.onReceiveSurvivalBatchHeroChangePositionReply(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 == 0 then
		local var_51_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_51_0 then
			var_51_0:batchHeroPostion(arg_51_2.heroId, arg_51_2.buildingId)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate)
		end
	end
end

function var_0_0.sendSurvivalHeroChangePositionRequest(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = SurvivalWeekModule_pb.SurvivalHeroChangePositionRequest()

	var_52_0.heroId = arg_52_1
	var_52_0.buildingId = arg_52_2
	var_52_0.position = arg_52_3

	return arg_52_0:sendMsg(var_52_0, arg_52_4, arg_52_5)
end

function var_0_0.onReceiveSurvivalHeroChangePositionReply(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_1 == 0 then
		local var_53_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_53_0 then
			var_53_0:changeHeroPostion(arg_53_2.heroId, arg_53_2.buildingId, arg_53_2.position)
		end
	end
end

function var_0_0.sendSurvivalHeroExchangePositionRequest(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	local var_54_0 = SurvivalWeekModule_pb.SurvivalHeroExchangePositionRequest()

	var_54_0.srcHeroId = arg_54_1
	var_54_0.targetHeroId = arg_54_2

	return arg_54_0:sendMsg(var_54_0, arg_54_3, arg_54_4)
end

function var_0_0.onReceiveSurvivalHeroExchangePositionReply(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 == 0 then
		local var_55_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_55_0 then
			var_55_0:exchangeHeroPosition(arg_55_2.srcHeroId, arg_55_2.targetHeroId)
		end
	end
end

function var_0_0.sendSurvivalShopSellRequest(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4, arg_56_5, arg_56_6)
	local var_56_0 = SurvivalWeekModule_pb.SurvivalShopSellRequest()

	var_56_0.uid = arg_56_1
	var_56_0.count = arg_56_4
	var_56_0.shopType = arg_56_2
	var_56_0.shopId = arg_56_3

	return arg_56_0:sendMsg(var_56_0, arg_56_5, arg_56_6)
end

function var_0_0.onReceiveSurvivalShopSellReply(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalShopBuyRequest(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4, arg_58_5, arg_58_6)
	local var_58_0 = SurvivalWeekModule_pb.SurvivalShopBuyRequest()

	var_58_0.uid = arg_58_1
	var_58_0.count = arg_58_2
	var_58_0.shopType = arg_58_3
	var_58_0.shopId = arg_58_4

	UIBlockHelper.instance:startBlock(UIBlockKey.SurvivalBagInfoPart, 2)

	return arg_58_0:sendMsg(var_58_0, arg_58_5, arg_58_6)
end

function var_0_0.onReceiveSurvivalShopBuyReply(arg_59_0, arg_59_1, arg_59_2)
	UIBlockHelper.instance:endBlock(UIBlockKey.SurvivalBagInfoPart)

	if arg_59_1 == 0 then
		local var_59_0 = arg_59_2.shopType
		local var_59_1 = arg_59_2.shopId
		local var_59_2 = SurvivalMapHelper.instance:getShopById(var_59_1)

		if var_59_0 == SurvivalEnum.ShopType.Reputation then
			local var_59_3 = var_59_2:getItemByUid(arg_59_2.uid)

			if var_59_3:isNPC() then
				local var_59_4 = SurvivalBagItemMo.New()

				var_59_4:init({
					id = var_59_3.id,
					count = arg_59_2.count
				})

				local var_59_5 = {
					var_59_4
				}

				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
					items = var_59_5
				})
			end
		end

		if var_59_0 == SurvivalEnum.ShopType.Reputation or var_59_0 == SurvivalEnum.ShopType.PreExplore or var_59_0 == SurvivalEnum.ShopType.GeneralShop then
			var_59_2:reduceItem(arg_59_2.uid, arg_59_2.count)
		else
			var_59_2:removeItem(arg_59_2.uid, arg_59_2.count)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalShopBuyReply, arg_59_2)
	end
end

function var_0_0.onReceiveSurvivalShopUpdatePush(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1 == 0 then
		local var_60_0 = arg_60_2.shop.id
		local var_60_1 = SurvivalMapHelper.instance:getShopById(var_60_0)

		if var_60_1 then
			var_60_1:init(arg_60_2.shop, var_60_1.reputationId, var_60_1.reputationLevel)
		end
	end
end

function var_0_0.sendSurvivalReputationRewardRequest(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	local var_61_0 = SurvivalWeekModule_pb.SurvivalReputationRewardRequest()

	var_61_0.reputationId = arg_61_1
	var_61_0.level = arg_61_2

	return arg_61_0:sendMsg(var_61_0, arg_61_3, arg_61_4)
end

function var_0_0.onReceiveSurvivalReputationRewardReply(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 == 0 then
		local var_62_0 = arg_62_2.reputationId
		local var_62_1 = arg_62_2.level
		local var_62_2 = SurvivalShelterModel.instance:getWeekInfo():getBuildingMoByReputationId(var_62_0)

		var_62_2.survivalReputationPropMo:onReceiveSurvivalReputationRewardReply(var_62_1)
		var_62_2:refreshReputationRedDot()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalReputationRewardReply, arg_62_2)

		local var_62_3 = SurvivalConfig.instance:getShopFreeReward(var_62_0, var_62_1)
		local var_62_4 = SurvivalBagItemMo.New()

		var_62_4:init({
			id = var_62_3[1],
			var_62_3[2]
		})

		if var_62_4:isNPC() then
			local var_62_5 = {
				var_62_4
			}

			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
				items = var_62_5
			})
		end
	end
end

function var_0_0.onReceiveSurvivalTaskUpdatePush(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalTaskUpdatePush", arg_63_2)
	end
end

function var_0_0.onReceiveSurvivalHeroUpdatePush(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalHeroUpdatePush", arg_64_2)
	end
end

function var_0_0.onReceiveSurvivalItemTipsPush(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalItemTipsPush", arg_65_2)
	end
end

function var_0_0.sendSurvivalIntrudeReExterminateRequest(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = SurvivalWeekModule_pb.SurvivalIntrudeReExterminateRequest()

	return arg_66_0:sendMsg(var_66_0, arg_66_1, arg_66_2)
end

function var_0_0.onReceiveSurvivalIntrudeReExterminateReply(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_1 == 0 then
		local var_67_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_67_0 then
			var_67_0.intrudeBox.fight:init(arg_67_2.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateView)
	end
end

function var_0_0.sendSurvivalIntrudeAbandonExterminateRequest(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = SurvivalWeekModule_pb.SurvivalIntrudeAbandonExterminateRequest()

	return arg_68_0:sendMsg(var_68_0, arg_68_1, arg_68_2)
end

function var_0_0.onReceiveSurvivalIntrudeAbandonExterminateReply(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_1 == 0 then
		local var_69_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_69_0 then
			var_69_0.intrudeBox.fight:init(arg_69_2.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.AbandonFight)
	end
end

function var_0_0.onReceiveSurvivalIntrudeFightSettlePush(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1 == 0 then
		local var_70_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_70_0 then
			var_70_0.intrudeBox.fight:init(arg_70_2.fight)

			local var_70_1 = arg_70_2.fight.fightId

			if arg_70_2.fight.status == SurvivalEnum.ShelterMonsterFightState.Win and var_70_1 ~= nil and var_70_1 ~= 0 then
				SurvivalShelterModel.instance:setNeedShowFightSuccess(true, var_70_1)
			end
		end
	end
end

function var_0_0.onReceiveSurvivalStepPush(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_1 == 0 then
		SurvivalMapHelper.instance:cacheSteps(arg_71_2.step)
	end
end

function var_0_0.sendSurvivalDecreePromulgateRequest(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = SurvivalWeekModule_pb.SurvivalDecreePromulgateRequest()

	var_72_0.no = arg_72_1

	return arg_72_0:sendMsg(var_72_0, arg_72_2, arg_72_3)
end

function var_0_0.onReceiveSurvivalDecreePromulgateReply(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_1 == 0 then
		local var_73_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_73_0 then
			var_73_0:getDecreeBox():updateDecreeInfo(arg_73_2.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalDecreeChoosePolicyRequest(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4)
	local var_74_0 = SurvivalWeekModule_pb.SurvivalDecreeChoosePolicyRequest()

	var_74_0.no = arg_74_1
	var_74_0.policyIndex = arg_74_2

	return arg_74_0:sendMsg(var_74_0, arg_74_3, arg_74_4)
end

function var_0_0.onReceiveSurvivalDecreeChoosePolicyReply(arg_75_0, arg_75_1, arg_75_2)
	if arg_75_1 == 0 then
		local var_75_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_75_0 then
			local var_75_1 = var_75_0:getDecreeBox()

			var_75_1:updateDecreeInfo(arg_75_2.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)

			local var_75_2 = var_75_1:getDecreeInfo(arg_75_2.decree.no)

			SurvivalController.instance:startDecreeVote(var_75_2)
		end
	else
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function var_0_0.onReceiveSurvivalDecreeChangeUpdatePush(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_1 == 0 then
		local var_76_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_76_0 then
			var_76_0:getDecreeBox():updateDecreeInfo(arg_76_2.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)
		end
	end
end

function var_0_0.onReceiveMsg(arg_77_0, arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5, arg_77_6)
	var_0_0.super.onReceiveMsg(arg_77_0, arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5, arg_77_6)

	if arg_77_1 == 0 and string.find(arg_77_3, "Reply$") then
		SurvivalMapHelper.instance:tryStartFlow(arg_77_3)
	end
end

function var_0_0.sendSurvivalRefreshRecruitTagRequest(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = SurvivalWeekModule_pb.SurvivalRefreshRecruitTagRequest()

	return arg_78_0:sendMsg(var_78_0, arg_78_1, arg_78_2)
end

function var_0_0.onReceiveSurvivalRefreshRecruitTagReply(arg_79_0, arg_79_1, arg_79_2)
	if arg_79_1 == 0 then
		local var_79_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_79_0 then
			var_79_0:updateRecruitInfo(arg_79_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitRefresh)
		end
	end
end

function var_0_0.sendSurvivalPublishRecruitTagRequest(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	local var_80_0 = SurvivalWeekModule_pb.SurvivalPublishRecruitTagRequest()

	if arg_80_1 then
		for iter_80_0, iter_80_1 in ipairs(arg_80_1) do
			table.insert(var_80_0.tagId, iter_80_1)
		end
	end

	return arg_80_0:sendMsg(var_80_0, arg_80_2, arg_80_3)
end

function var_0_0.onReceiveSurvivalPublishRecruitTagReply(arg_81_0, arg_81_1, arg_81_2)
	if arg_81_1 == 0 then
		local var_81_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_81_0 then
			var_81_0:updateRecruitInfo(arg_81_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalRecruitNpcRequest(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = SurvivalWeekModule_pb.SurvivalRecruitNpcRequest()

	var_82_0.npcId = arg_82_1

	return arg_82_0:sendMsg(var_82_0, arg_82_2, arg_82_3)
end

function var_0_0.onReceiveSurvivalRecruitNpcReply(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_1 == 0 then
		local var_83_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_83_0 then
			var_83_0:updateRecruitInfo(arg_83_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalAbandonRecruitNpcRequest(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = SurvivalWeekModule_pb.SurvivalAbandonRecruitNpcRequest()

	return arg_84_0:sendMsg(var_84_0, arg_84_1, arg_84_2)
end

function var_0_0.onReceiveSurvivalAbandonRecruitNpcReply(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_1 == 0 then
		local var_85_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_85_0 then
			var_85_0:updateRecruitInfo(arg_85_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.onReceiveSurvivalRecruitInfoPush(arg_86_0, arg_86_1, arg_86_2)
	if arg_86_1 == 0 then
		local var_86_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_86_0 then
			var_86_0:updateRecruitInfo(arg_86_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalNpcAcceptTaskRequest(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	local var_87_0 = SurvivalWeekModule_pb.SurvivalNpcAcceptTaskRequest()

	var_87_0.npcId = arg_87_1
	var_87_0.behaviorId = arg_87_2

	return arg_87_0:sendMsg(var_87_0, arg_87_3, arg_87_4)
end

function var_0_0.onReceiveSurvivalNpcAcceptTaskReply(arg_88_0, arg_88_1, arg_88_2)
	if arg_88_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalReceiveTaskRewardRequest(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4)
	local var_89_0 = SurvivalWeekModule_pb.SurvivalReceiveTaskRewardRequest()

	var_89_0.moduleId = arg_89_1
	var_89_0.taskId = arg_89_2

	return arg_89_0:sendMsg(var_89_0, arg_89_3, arg_89_4)
end

function var_0_0.onReceiveSurvivalReceiveTaskRewardReply(arg_90_0, arg_90_1, arg_90_2)
	if arg_90_1 == 0 then
		local var_90_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_90_0 then
			local var_90_1 = var_90_0.taskPanel:getTaskBoxMo(arg_90_2.moduleId):getTaskInfo(arg_90_2.taskId)

			if var_90_1 then
				var_90_1:setTaskFinish()
				SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskDataUpdate)
			end
		end
	end
end

function var_0_0.sendSurvivalSurvivalWeekClientData(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	local var_91_0 = SurvivalWeekModule_pb.SurvivalSurvivalWeekClientDataRequest()

	var_91_0.data = arg_91_1

	return arg_91_0:sendMsg(var_91_0, arg_91_2, arg_91_3)
end

function var_0_0.onReceiveSurvivalSurvivalWeekClientDataReply(arg_92_0, arg_92_1, arg_92_2)
	if arg_92_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalBuildingUpdatePush(arg_93_0, arg_93_1, arg_93_2)
	return
end

function var_0_0.sendSurvivalReputationExpRequest(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	local var_94_0 = SurvivalWeekModule_pb.SurvivalReputationExpRequest()

	var_94_0.reputationId = arg_94_1

	UIBlockHelper.instance:startBlock(UIBlockKey.SurvivalReputationSelectView, 2)

	return arg_94_0:sendMsg(var_94_0, arg_94_2, arg_94_3)
end

function var_0_0.onReceiveSurvivalReputationExpReply(arg_95_0, arg_95_1, arg_95_2)
	UIBlockHelper.instance:endBlock(UIBlockKey.SurvivalReputationSelectView)

	if arg_95_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_95_2.building.id):setReputationData(arg_95_2.building.reputationProp)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalReputationExpReply, {
			msg = arg_95_2
		})
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
