module("modules.logic.backpack.rpc.MaterialRpc", package.seeall)

slot0 = class("MaterialRpc", BaseRpc)

function slot0.receiveMaterial(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot0.dataList) do
		slot10 = nil
		slot11 = MaterialDataMO.New()

		if slot9.materilType == MaterialEnum.MaterialType.PowerPotion then
			for slot16, slot17 in pairs(ItemPowerModel.instance:getLatestPowerChange()) do
				if tonumber(slot17.itemid) == tonumber(slot9.materilId) then
					slot10 = slot17.uid
				end
			end
		elseif slot9.materilType == MaterialEnum.MaterialType.NewInsight then
			for slot16, slot17 in pairs(ItemInsightModel.instance:getLatestInsightChange()) do
				if tonumber(slot17.itemid) == tonumber(slot9.materilId) then
					slot10 = slot17.uid
				end
			end
		end

		slot11:initValue(slot9.materilType, slot9.materilId, slot9.quantity, slot10, slot9.roomBuildingLevel)

		if slot9.materilType == MaterialEnum.MaterialType.Faith then
			table.insert(slot2, slot11)
		elseif slot9.materilType == MaterialEnum.MaterialType.EquipCard then
			for slot15 = 1, slot9.quantity do
				table.insert(slot3, slot9.materilId)
			end
		elseif slot9.materilType == MaterialEnum.MaterialType.Season123EquipCard then
			for slot15 = 1, slot9.quantity do
				table.insert(slot4, slot9.materilId)
			end
		else
			table.insert(slot1, slot11)
		end
	end

	return slot1, slot2, slot3, slot4
end

function slot0.onReceiveMaterialChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3, slot4, slot5, slot6 = uv0.receiveMaterial(slot2)

	if PopupCacheController.instance:tryCacheGetPropView(slot2.getApproach, {
		materialDataMOList = slot3
	}) then
		return
	end

	if slot7 == MaterialEnum.GetApproach.RoomProductLine then
		RoomController.instance:MaterialChangeByRoomProductLine(slot3)
	elseif slot7 == MaterialEnum.GetApproach.Explore then
		-- Nothing
	elseif slot7 == MaterialEnum.GetApproach.BattlePass then
		BpController.instance:_showCommonPropView(slot3)
	elseif slot7 == MaterialEnum.GetApproach.DungeonRewardPoint then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointRewardMaterials, slot3)
	elseif slot7 == MaterialEnum.GetApproach.AstrologyStarReward then
		VersionActivity1_3AstrologyModel.instance:setStarReward(slot3)

		return
	elseif slot7 == MaterialEnum.GetApproach.Task or slot2.getApproach == MaterialEnum.GetApproach.TaskAct then
		if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
			WeekWalkTaskListModel.instance:setTaskRewardList(slot3)

			return
		end

		TaskController.instance:getRewardByLine(slot7, ViewName.CommonPropView, slot3)

		if #slot5 > 0 then
			Activity104Model.instance:addCardGetData(slot5)
			Activity104Controller.instance:checkShowEquipSelfChoiceView()
		end

		if #slot6 > 0 then
			Season123Model.instance:addCardGetData(slot6)
		end
	elseif slot7 == MaterialEnum.GetApproach.RoomInteraction then
		RoomController.instance:showInteractionRewardToast(slot3)

		if #slot4 > 0 then
			RoomCharacterController.instance:showGainFaithToast(slot4)
		end
	elseif slot7 == MaterialEnum.GetApproach.NoviceStageReward then
		TaskModel.instance:setHasTaskNoviceStageReward(true)
	elseif slot7 == MaterialEnum.GetApproach.SignIn then
		SignInController.instance:setSigninReward(slot3)
	elseif slot7 == MaterialEnum.GetApproach.Act1_6SkillLvDown or slot7 == MaterialEnum.GetApproach.Act1_6SkillReset then
		VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.SkillPointReturnBack)

		return
	elseif slot7 == MaterialEnum.GetApproach.v1a8Act157ComponentReward then
		return
	elseif slot7 == MaterialEnum.GetApproach.v2a2Act169SummonNewPick and not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		SummonNewCustomPickChoiceController.instance:setSummonReward(slot3)

		return
	else
		if #slot4 > 0 and slot7 == MaterialEnum.GetApproach.RoomGainFaith then
			RoomCharacterController.instance:showGainFaithToast(slot4)
		end

		if #slot5 > 0 then
			Activity104Model.instance:addCardGetData(slot5)
		end

		if #slot6 > 0 then
			Season123Model.instance:addCardGetData(slot6)
		end

		if #slot3 == 1 and slot3[1].materilType == MaterialEnum.MaterialType.HeroSkin then
			return
		end

		if #slot3 == 1 and slot3[1].materilType == MaterialEnum.MaterialType.Item and MainSceneSwitchConfig.instance:getConfigByItemId(slot3[1].materilId) then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainSceneSwitchInfoView, {
				sceneSkinId = slot9.id
			})

			return
		end

		if #slot3 > 0 then
			RoomController.instance:popUpRoomBlockPackageView(slot3)
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot3)
		end
	end
end

slot0.instance = slot0.New()

return slot0
