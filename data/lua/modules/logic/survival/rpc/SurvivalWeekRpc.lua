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
		SurvivalShelterModel.instance:setWeekData(arg_9_2.weekInfo, true)

		if arg_9_2.weekInfo.difficulty ~= SurvivalEnum.FirstPlayDifficulty then
			ViewMgr.instance:closeView(ViewName.SurvivalHardView)
		end

		local var_9_0 = arg_9_2.weekInfo.difficulty == SurvivalEnum.FirstPlayDifficulty

		ViewMgr.instance:openView(ViewName.SurvivalSelectTalentTreeView, {
			isFirstPlayer = var_9_0
		})
	end
end

function var_0_0.sendSurvivalStartWeekChooseTalent(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = SurvivalWeekModule_pb.SurvivalStartWeekChooseTalentRequest()

	var_10_0.groupId = arg_10_1

	return arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveSurvivalStartWeekChooseTalentReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		SurvivalShelterModel.instance:setWeekData(arg_11_2.weekInfo, true)
		SurvivalController.instance:startNewWeek()
	end
end

function var_0_0.sendSurvivalGetWeekInfo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = SurvivalWeekModule_pb.SurvivalGetWeekInfoRequest()

	return arg_12_0:sendMsg(var_12_0, arg_12_1, arg_12_2)
end

function var_0_0.onReceiveSurvivalGetWeekInfoReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		local var_13_0 = SurvivalShelterModel.instance:haveBoss()

		SurvivalShelterModel.instance:setWeekData(arg_13_2.weekInfo)

		if not var_13_0 and SurvivalShelterModel.instance:haveBoss() then
			SurvivalShelterModel.instance:setNeedShowBossInvade(true)
		end
	end
end

function var_0_0.onReceiveSurvivalWeekInfoPush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		local var_14_0 = SurvivalShelterModel.instance:haveBoss()

		SurvivalShelterModel.instance:setWeekData(arg_14_2.weekInfo)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnWeekInfoUpdate)

		if not var_14_0 and SurvivalShelterModel.instance:haveBoss() then
			SurvivalShelterModel.instance:setNeedShowBossInvade(true)
		end
	end
end

function var_0_0.sendSurvivalGetEquipInfo(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = SurvivalWeekModule_pb.SurvivalGetEquipInfoRequest()

	return arg_15_0:sendMsg(var_15_0, arg_15_1, arg_15_2)
end

function var_0_0.onReceiveSurvivalGetEquipInfoReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().equipBox:init(arg_16_2.equipBox)
	end
end

function var_0_0.sendSurvivalEquipSetNewFlagRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = SurvivalWeekModule_pb.SurvivalEquipSetNewFlagRequest()

	if arg_17_1 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			table.insert(var_17_0.slotId, iter_17_1)
		end
	end

	return arg_17_0:sendMsg(var_17_0, arg_17_2, arg_17_3)
end

function var_0_0.onReceiveSurvivalEquipSetNewFlagReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		local var_18_0 = SurvivalShelterModel.instance:getWeekInfo()

		for iter_18_0, iter_18_1 in ipairs(arg_18_2.slots) do
			if var_18_0.equipBox.slots[iter_18_1.slotId] then
				var_18_0.equipBox.slots[iter_18_1.slotId]:init(iter_18_1)
			end
		end

		var_18_0.equipBox:calcAttrs()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
	end
end

function var_0_0.sendSurvivalEquipSwitchPlan(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = SurvivalWeekModule_pb.SurvivalEquipSwitchPlanRequest()

	var_19_0.newPlanId = arg_19_1

	return arg_19_0:sendMsg(var_19_0, arg_19_2, arg_19_3)
end

function var_0_0.onReceiveSurvivalEquipSwitchPlanReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().equipBox:init(arg_20_2.equipBox)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
		SurvivalEquipRedDotHelper.instance:checkRed()
	end
end

function var_0_0.sendSurvivalEquipWear(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = SurvivalWeekModule_pb.SurvivalEquipWearRequest()

	var_21_0.slotId = arg_21_1
	var_21_0.uid = arg_21_2

	return arg_21_0:sendMsg(var_21_0, arg_21_3, arg_21_4)
end

function var_0_0.onReceiveSurvivalEquipWearReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalEquipDemount(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = SurvivalWeekModule_pb.SurvivalEquipDemountRequest()

	var_23_0.slotId = arg_23_1

	return arg_23_0:sendMsg(var_23_0, arg_23_2, arg_23_3)
end

function var_0_0.onReceiveSurvivalEquipDemountReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalEquipOneKeyWear(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = SurvivalWeekModule_pb.SurvivalEquipOneKeyWearRequest()

	var_25_0.tagId = arg_25_1
	arg_25_0.oneKeyTagId = arg_25_1

	return arg_25_0:sendMsg(var_25_0, arg_25_2, arg_25_3)
end

function var_0_0.onReceiveSurvivalEquipOneKeyWearReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		local var_26_0 = SurvivalShelterModel.instance:getWeekInfo()

		if not var_26_0 or not arg_26_0.oneKeyTagId then
			return
		end

		local var_26_1 = var_26_0.equipBox.maxTagId

		if var_26_1 ~= arg_26_0.oneKeyTagId then
			local var_26_2 = true

			for iter_26_0, iter_26_1 in pairs(var_26_0.equipBox.slots) do
				if not iter_26_1.item:isEmpty() then
					var_26_2 = false

					break
				end
			end

			if var_26_2 then
				return
			end

			local var_26_3 = lua_survival_equip_found.configDict[arg_26_0.oneKeyTagId]
			local var_26_4 = lua_survival_equip_found.configDict[var_26_1]

			if not var_26_3 or not var_26_4 then
				GameFacade.showToast(ToastEnum.SurvivalEquipTagNoEnough2)
			else
				GameFacade.showToast(ToastEnum.SurvivalEquipTagNoEnough, var_26_3.name, var_26_4.name)
			end
		end
	end
end

function var_0_0.sendSurvivalEquipOneKeyDemount(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = SurvivalWeekModule_pb.SurvivalEquipOneKeyDemountRequest()

	return arg_27_0:sendMsg(var_27_0, arg_27_1, arg_27_2)
end

function var_0_0.onReceiveSurvivalEquipOneKeyDemountReply(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalEquipUpdatePush(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().equipBox:init(arg_29_2.equipBox)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
		SurvivalEquipRedDotHelper.instance:checkRed()
	end
end

function var_0_0.sendSurvivalEquipCompound(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = SurvivalWeekModule_pb.SurvivalEquipCompoundRequest()

	if arg_30_1 then
		for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
			table.insert(var_30_0.uid, iter_30_1)
		end
	end

	return arg_30_0:sendMsg(var_30_0, arg_30_2, arg_30_3)
end

function var_0_0.onReceiveSurvivalEquipCompoundReply(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalChooseBooty(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = SurvivalWeekModule_pb.SurvivalChooseBootyRequest()

	if arg_32_1 then
		for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
			table.insert(var_32_0.npcId, iter_32_1)
		end
	end

	if arg_32_2 then
		for iter_32_2, iter_32_3 in ipairs(arg_32_2) do
			table.insert(var_32_0.equipId, iter_32_3)
		end
	end

	return arg_32_0:sendMsg(var_32_0, arg_32_3, arg_32_4)
end

function var_0_0.onReceiveSurvivalChooseBootyReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 == 0 then
		local var_33_0 = SurvivalModel.instance:getOutSideInfo()

		if var_33_0 then
			var_33_0.inWeek = false
		end

		SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
	end
end

function var_0_0.sendSurvivalAbandonWeek(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = SurvivalWeekModule_pb.SurvivalAbandonWeekRequest()

	return arg_34_0:sendMsg(var_34_0, arg_34_1, arg_34_2)
end

function var_0_0.onReceiveSurvivalAbandonWeekReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalSettleWeekPush(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		SurvivalController.instance:playSettleWork(arg_36_2)
	end
end

function var_0_0.sendSurvivalBuildRequest(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = SurvivalWeekModule_pb.SurvivalBuildRequest()

	var_37_0.id = arg_37_1

	return arg_37_0:sendMsg(var_37_0, arg_37_2, arg_37_3)
end

function var_0_0.onReceiveSurvivalBuildReply(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == 0 then
		local var_38_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_38_0 then
			var_38_0:updateBuildingInfo(arg_38_2.building)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate, arg_38_2.building.id)
		end
	end
end

function var_0_0.sendSurvivalRepairRequest(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = SurvivalWeekModule_pb.SurvivalRepairRequest()

	var_39_0.id = arg_39_1

	return arg_39_0:sendMsg(var_39_0, arg_39_2, arg_39_3)
end

function var_0_0.onReceiveSurvivalRepairReply(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 == 0 then
		local var_40_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_40_0 then
			var_40_0:updateBuildingInfo(arg_40_2.building)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate)
		end
	end
end

function var_0_0.sendSurvivalUpgradeRequest(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = SurvivalWeekModule_pb.SurvivalUpgradeRequest()

	var_41_0.id = arg_41_1

	local var_41_1 = SurvivalShelterModel.instance:getWeekInfo()

	if var_41_1 then
		var_41_1:lockBuildingLevel(arg_41_1)
	end

	return arg_41_0:sendMsg(var_41_0, arg_41_2, arg_41_3)
end

function var_0_0.onReceiveSurvivalUpgradeReply(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == 0 then
		local var_42_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_42_0 then
			var_42_0:updateBuildingInfo(arg_42_2.building, true)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate, arg_42_2.building.id)
		end
	end
end

function var_0_0.onReceiveSurvivalAttrContainerUpdatePush(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 == 0 then
		local var_43_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_43_0 then
			var_43_0:updateAttrs(arg_43_2.updates)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnAttrUpdate)
	end
end

function var_0_0.sendSurvivalNpcChangePositionRequest(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	local var_44_0 = SurvivalWeekModule_pb.SurvivalNpcChangePositionRequest()

	var_44_0.npcId = arg_44_1
	var_44_0.buildingId = arg_44_2
	var_44_0.position = arg_44_3

	return arg_44_0:sendMsg(var_44_0, arg_44_4, arg_44_5)
end

function var_0_0.onReceiveSurvivalNpcChangePositionReply(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 == 0 then
		local var_45_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_45_0 then
			var_45_0:changeNpcPostion(arg_45_2.npcId, arg_45_2.buildingId, arg_45_2.position)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNpcPostionChange)
		end
	end
end

function var_0_0.sendSurvivalNpcExchangePositionRequest(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = SurvivalWeekModule_pb.SurvivalNpcExchangePositionRequest()

	var_46_0.srcNpcId = arg_46_1
	var_46_0.targetNpcId = arg_46_2

	return arg_46_0:sendMsg(var_46_0, arg_46_3, arg_46_4)
end

function var_0_0.onReceiveSurvivalNpcExchangePositionReply(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 == 0 then
		local var_47_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_47_0 then
			var_47_0:exchangeNpcPosition(arg_47_2.srcNpcId, arg_47_2.targetNpcId)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNpcPostionChange)
		end
	end
end

function var_0_0.sendSurvivalBatchHeroChangePositionRequest(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = SurvivalWeekModule_pb.SurvivalBatchHeroChangePositionRequest()

	if arg_48_1 then
		for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
			table.insert(var_48_0.heroId, iter_48_1)
		end
	end

	var_48_0.buildingId = arg_48_2

	return arg_48_0:sendMsg(var_48_0, arg_48_3, arg_48_4)
end

function var_0_0.onReceiveSurvivalBatchHeroChangePositionReply(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 == 0 then
		local var_49_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_49_0 then
			var_49_0:batchHeroPostion(arg_49_2.heroId, arg_49_2.buildingId)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate)
		end
	end
end

function var_0_0.sendSurvivalHeroChangePositionRequest(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5)
	local var_50_0 = SurvivalWeekModule_pb.SurvivalHeroChangePositionRequest()

	var_50_0.heroId = arg_50_1
	var_50_0.buildingId = arg_50_2
	var_50_0.position = arg_50_3

	return arg_50_0:sendMsg(var_50_0, arg_50_4, arg_50_5)
end

function var_0_0.onReceiveSurvivalHeroChangePositionReply(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 == 0 then
		local var_51_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_51_0 then
			var_51_0:changeHeroPostion(arg_51_2.heroId, arg_51_2.buildingId, arg_51_2.position)
		end
	end
end

function var_0_0.sendSurvivalHeroExchangePositionRequest(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	local var_52_0 = SurvivalWeekModule_pb.SurvivalHeroExchangePositionRequest()

	var_52_0.srcHeroId = arg_52_1
	var_52_0.targetHeroId = arg_52_2

	return arg_52_0:sendMsg(var_52_0, arg_52_3, arg_52_4)
end

function var_0_0.onReceiveSurvivalHeroExchangePositionReply(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_1 == 0 then
		local var_53_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_53_0 then
			var_53_0:exchangeHeroPosition(arg_53_2.srcHeroId, arg_53_2.targetHeroId)
		end
	end
end

function var_0_0.sendSurvivalShopSellRequest(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	local var_54_0 = SurvivalWeekModule_pb.SurvivalShopSellRequest()

	var_54_0.uid = arg_54_1
	var_54_0.count = arg_54_2

	return arg_54_0:sendMsg(var_54_0, arg_54_3, arg_54_4)
end

function var_0_0.onReceiveSurvivalShopSellReply(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalShopBuyRequest(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	local var_56_0 = SurvivalWeekModule_pb.SurvivalShopBuyRequest()

	var_56_0.uid = arg_56_1
	var_56_0.count = arg_56_2

	return arg_56_0:sendMsg(var_56_0, arg_56_3, arg_56_4)
end

function var_0_0.onReceiveSurvivalShopBuyReply(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_1 == 0 then
		local var_57_0 = SurvivalMapHelper.instance:getShopPanel()

		if var_57_0 then
			var_57_0:removeItem(arg_57_2.uid, arg_57_2.count)
		end
	end
end

function var_0_0.onReceiveSurvivalTaskUpdatePush(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalTaskUpdatePush", arg_58_2)
	end
end

function var_0_0.onReceiveSurvivalHeroUpdatePush(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalHeroUpdatePush", arg_59_2)
	end
end

function var_0_0.onReceiveSurvivalItemTipsPush(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalItemTipsPush", arg_60_2)
	end
end

function var_0_0.sendSurvivalIntrudeExterminateRequest(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	local var_61_0 = SurvivalWeekModule_pb.SurvivalIntrudeExterminateRequest()

	if arg_61_1 then
		for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
			table.insert(var_61_0.npcId, iter_61_1)
		end
	end

	return arg_61_0:sendMsg(var_61_0, arg_61_2, arg_61_3)
end

function var_0_0.onReceiveSurvivalIntrudeExterminateReply(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 == 0 then
		local var_62_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_62_0 then
			var_62_0.intrudeBox.fight:init(arg_62_2.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateView)
	end
end

function var_0_0.sendSurvivalIntrudeReExterminateRequest(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = SurvivalWeekModule_pb.SurvivalIntrudeReExterminateRequest()

	return arg_63_0:sendMsg(var_63_0, arg_63_1, arg_63_2)
end

function var_0_0.onReceiveSurvivalIntrudeReExterminateReply(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_1 == 0 then
		local var_64_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_64_0 then
			var_64_0.intrudeBox.fight:init(arg_64_2.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateView)
	end
end

function var_0_0.sendSurvivalIntrudeAbandonExterminateRequest(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = SurvivalWeekModule_pb.SurvivalIntrudeAbandonExterminateRequest()

	return arg_65_0:sendMsg(var_65_0, arg_65_1, arg_65_2)
end

function var_0_0.onReceiveSurvivalIntrudeAbandonExterminateReply(arg_66_0, arg_66_1, arg_66_2)
	if arg_66_1 == 0 then
		local var_66_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_66_0 then
			var_66_0.intrudeBox.fight:init(arg_66_2.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.AbandonFight)
	end
end

function var_0_0.onReceiveSurvivalIntrudeFightSettlePush(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_1 == 0 then
		local var_67_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_67_0 then
			var_67_0.intrudeBox.fight:init(arg_67_2.fight)

			local var_67_1 = arg_67_2.fight.fightId

			if arg_67_2.fight.status == SurvivalEnum.ShelterMonsterFightState.Win and var_67_1 ~= nil and var_67_1 ~= 0 then
				SurvivalShelterModel.instance:setNeedShowFightSuccess(true, var_67_1)
			end
		end
	end
end

function var_0_0.onReceiveSurvivalStepPush(arg_68_0, arg_68_1, arg_68_2)
	if arg_68_1 == 0 then
		SurvivalMapHelper.instance:cacheSteps(arg_68_2.step)
	end
end

function var_0_0.sendSurvivalDecreePromulgateRequest(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = SurvivalWeekModule_pb.SurvivalDecreePromulgateRequest()

	var_69_0.no = arg_69_1

	return arg_69_0:sendMsg(var_69_0, arg_69_2, arg_69_3)
end

function var_0_0.onReceiveSurvivalDecreePromulgateReply(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1 == 0 then
		local var_70_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_70_0 then
			var_70_0:getDecreeBox():updateDecreeInfo(arg_70_2.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalDecreeChoosePolicyRequest(arg_71_0, arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	local var_71_0 = SurvivalWeekModule_pb.SurvivalDecreeChoosePolicyRequest()

	var_71_0.no = arg_71_1
	var_71_0.policyIndex = arg_71_2

	return arg_71_0:sendMsg(var_71_0, arg_71_3, arg_71_4)
end

function var_0_0.onReceiveSurvivalDecreeChoosePolicyReply(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_1 == 0 then
		local var_72_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_72_0 then
			local var_72_1 = var_72_0:getDecreeBox()

			var_72_1:updateDecreeInfo(arg_72_2.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)

			local var_72_2 = var_72_1:getDecreeInfo(arg_72_2.decree.no)

			SurvivalController.instance:startDecreeVote(var_72_2)
		end
	else
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function var_0_0.onReceiveSurvivalDecreeChangeUpdatePush(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_1 == 0 then
		local var_73_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_73_0 then
			var_73_0:getDecreeBox():updateDecreeInfo(arg_73_2.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)
		end
	end
end

function var_0_0.onReceiveMsg(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5, arg_74_6)
	var_0_0.super.onReceiveMsg(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5, arg_74_6)

	if arg_74_1 == 0 and string.find(arg_74_3, "Reply$") then
		SurvivalMapHelper.instance:tryStartFlow(arg_74_3)
	end
end

function var_0_0.sendSurvivalRefreshRecruitTagRequest(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = SurvivalWeekModule_pb.SurvivalRefreshRecruitTagRequest()

	return arg_75_0:sendMsg(var_75_0, arg_75_1, arg_75_2)
end

function var_0_0.onReceiveSurvivalRefreshRecruitTagReply(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_1 == 0 then
		local var_76_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_76_0 then
			var_76_0:updateRecruitInfo(arg_76_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitRefresh)
		end
	end
end

function var_0_0.sendSurvivalPublishRecruitTagRequest(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = SurvivalWeekModule_pb.SurvivalPublishRecruitTagRequest()

	if arg_77_1 then
		for iter_77_0, iter_77_1 in ipairs(arg_77_1) do
			table.insert(var_77_0.tagId, iter_77_1)
		end
	end

	return arg_77_0:sendMsg(var_77_0, arg_77_2, arg_77_3)
end

function var_0_0.onReceiveSurvivalPublishRecruitTagReply(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_1 == 0 then
		local var_78_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_78_0 then
			var_78_0:updateRecruitInfo(arg_78_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalRecruitNpcRequest(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	local var_79_0 = SurvivalWeekModule_pb.SurvivalRecruitNpcRequest()

	var_79_0.npcId = arg_79_1

	return arg_79_0:sendMsg(var_79_0, arg_79_2, arg_79_3)
end

function var_0_0.onReceiveSurvivalRecruitNpcReply(arg_80_0, arg_80_1, arg_80_2)
	if arg_80_1 == 0 then
		local var_80_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_80_0 then
			var_80_0:updateRecruitInfo(arg_80_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalAbandonRecruitNpcRequest(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0 = SurvivalWeekModule_pb.SurvivalAbandonRecruitNpcRequest()

	return arg_81_0:sendMsg(var_81_0, arg_81_1, arg_81_2)
end

function var_0_0.onReceiveSurvivalAbandonRecruitNpcReply(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_1 == 0 then
		local var_82_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_82_0 then
			var_82_0:updateRecruitInfo(arg_82_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.onReceiveSurvivalRecruitInfoPush(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_1 == 0 then
		local var_83_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_83_0 then
			var_83_0:updateRecruitInfo(arg_83_2.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function var_0_0.sendSurvivalNpcAcceptTaskRequest(arg_84_0, arg_84_1, arg_84_2, arg_84_3, arg_84_4)
	local var_84_0 = SurvivalWeekModule_pb.SurvivalNpcAcceptTaskRequest()

	var_84_0.npcId = arg_84_1
	var_84_0.behaviorId = arg_84_2

	return arg_84_0:sendMsg(var_84_0, arg_84_3, arg_84_4)
end

function var_0_0.onReceiveSurvivalNpcAcceptTaskReply(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalReceiveTaskRewardRequest(arg_86_0, arg_86_1, arg_86_2, arg_86_3, arg_86_4)
	local var_86_0 = SurvivalWeekModule_pb.SurvivalReceiveTaskRewardRequest()

	var_86_0.moduleId = arg_86_1
	var_86_0.taskId = arg_86_2

	return arg_86_0:sendMsg(var_86_0, arg_86_3, arg_86_4)
end

function var_0_0.onReceiveSurvivalReceiveTaskRewardReply(arg_87_0, arg_87_1, arg_87_2)
	if arg_87_1 == 0 then
		local var_87_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_87_0 then
			local var_87_1 = var_87_0.taskPanel:getTaskBoxMo(arg_87_2.moduleId):getTaskInfo(arg_87_2.taskId)

			if var_87_1 then
				var_87_1:setTaskFinish()
				SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskDataUpdate)
			end
		end
	end
end

function var_0_0.sendSurvivalSurvivalWeekClientData(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	local var_88_0 = SurvivalWeekModule_pb.SurvivalSurvivalWeekClientDataRequest()

	var_88_0.data = arg_88_1

	return arg_88_0:sendMsg(var_88_0, arg_88_2, arg_88_3)
end

function var_0_0.onReceiveSurvivalSurvivalWeekClientDataReply(arg_89_0, arg_89_1, arg_89_2)
	if arg_89_1 == 0 then
		-- block empty
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
