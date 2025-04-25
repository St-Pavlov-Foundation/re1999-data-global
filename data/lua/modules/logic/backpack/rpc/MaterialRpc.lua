module("modules.logic.backpack.rpc.MaterialRpc", package.seeall)

slot0 = class("MaterialRpc", BaseRpc)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:set_onReceiveMaterialChangePushOnce(nil, )
end

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
		elseif slot9.materilType ~= MaterialEnum.MaterialType.Act186Like then
			table.insert(slot1, slot11)
		end
	end

	return slot1, slot2, slot3, slot4
end

function slot0.set_onReceiveMaterialChangePushOnce(slot0, slot1, slot2)
	slot0._materialChangePushOnceCb = slot1
	slot0._materialChangePushOnceCbObj = slot2
end

function slot0.onReceiveMaterialChangePush(slot0, slot1, slot2)
	if slot0._materialChangePushOnceCb then
		slot0:set_onReceiveMaterialChangePushOnce(nil, )
		slot3(slot0._materialChangePushOnceCbObj, slot1, slot2)

		return
	end

	if slot1 ~= 0 then
		return
	end

	slot4, slot5, slot6, slot7 = uv0.receiveMaterial(slot2)

	slot0:_onReceiveMaterialChangePush(slot2, slot4, slot5, slot6, slot7)
end

function slot0._onReceiveMaterialChangePush(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1.getApproach == MaterialEnum.GetApproach.Charge then
		PayController.instance:onReceiveMaterialChangePush(slot2)
	end

	if PopupCacheController.instance:tryCacheGetPropView(slot6, {
		materialDataMOList = slot2
	}) then
		return
	end

	if slot6 == MaterialEnum.GetApproach.RoomProductLine then
		RoomController.instance:MaterialChangeByRoomProductLine(slot2)
	elseif slot6 == MaterialEnum.GetApproach.Explore then
		-- Nothing
	elseif slot6 == MaterialEnum.GetApproach.BattlePass then
		BpController.instance:_showCommonPropView(slot2)
	elseif slot6 == MaterialEnum.GetApproach.DungeonRewardPoint then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointRewardMaterials, slot2)
	elseif slot6 == MaterialEnum.GetApproach.AstrologyStarReward then
		VersionActivity1_3AstrologyModel.instance:setStarReward(slot2)

		return
	elseif slot6 == MaterialEnum.GetApproach.Task or slot1.getApproach == MaterialEnum.GetApproach.TaskAct then
		if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
			WeekWalkTaskListModel.instance:setTaskRewardList(slot2)

			return
		end

		TaskController.instance:getRewardByLine(slot6, ViewName.CommonPropView, slot2)

		if #slot4 > 0 then
			Activity104Model.instance:addCardGetData(slot4)
			Activity104Controller.instance:checkShowEquipSelfChoiceView()
		end

		if #slot5 > 0 then
			Season123Model.instance:addCardGetData(slot5)
		end
	elseif slot6 == MaterialEnum.GetApproach.RoomInteraction then
		RoomController.instance:showInteractionRewardToast(slot2)

		if #slot3 > 0 then
			RoomCharacterController.instance:showGainFaithToast(slot3)
		end
	elseif slot6 == MaterialEnum.GetApproach.NoviceStageReward then
		TaskModel.instance:setHasTaskNoviceStageReward(true)
	elseif slot6 == MaterialEnum.GetApproach.SignIn then
		SignInController.instance:setSigninReward(slot2)
	elseif slot6 == MaterialEnum.GetApproach.Act1_6SkillLvDown or slot6 == MaterialEnum.GetApproach.Act1_6SkillReset then
		VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.SkillPointReturnBack)

		return
	elseif slot6 == MaterialEnum.GetApproach.v1a8Act157ComponentReward then
		return
	elseif slot6 == MaterialEnum.GetApproach.v2a2Act169SummonNewPick and not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		SummonNewCustomPickChoiceController.instance:setSummonReward(slot2)

		return
	elseif slot6 == MaterialEnum.GetApproach.LifeCircleSign then
		LifeCircleController.instance:openLifeCircleRewardView(slot2)
	elseif slot6 == MaterialEnum.GetApproach.AutoChessRankReward or slot6 == MaterialEnum.GetApproach.AutoChessPveReward then
		AutoChessController.instance:addPopupView(ViewName.CommonPropView, slot2)
	else
		slot0:_onReceiveMaterialChangePush_default(slot1, slot2, slot3, slot4, slot5)
	end
end

function slot0._onReceiveMaterialChangePush_default(slot0, slot1, slot2, slot3, slot4, slot5)
	if #slot3 > 0 and slot1.getApproach == MaterialEnum.GetApproach.RoomGainFaith then
		RoomCharacterController.instance:showGainFaithToast(slot3)
	end

	if #slot4 > 0 then
		Activity104Model.instance:addCardGetData(slot4)
	end

	if #slot5 > 0 then
		Season123Model.instance:addCardGetData(slot5)
	end

	if #slot2 == 1 and slot2[1].materilType == MaterialEnum.MaterialType.HeroSkin then
		return
	end

	if #slot2 == 1 and slot2[1].materilType == MaterialEnum.MaterialType.Item and MainSceneSwitchConfig.instance:getConfigByItemId(slot2[1].materilId) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainSceneSwitchInfoView, {
			sceneSkinId = slot7.id
		})

		return
	end

	if #slot2 ~= 0 and slot2[1].materilType == MaterialEnum.MaterialType.Critter then
		CritterController.instance:popUpCritterGetView()

		if slot7 == 1 then
			return
		end
	end

	slot0:simpleShowView(slot2)
end

function slot0.simpleShowView(slot0, slot1)
	if slot1 or #slot1 == 0 then
		return
	end

	RoomController.instance:popUpRoomBlockPackageView(slot1)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
end

slot0.instance = slot0.New()

return slot0
