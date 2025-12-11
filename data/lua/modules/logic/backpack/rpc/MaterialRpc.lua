module("modules.logic.backpack.rpc.MaterialRpc", package.seeall)

local var_0_0 = class("MaterialRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:set_onReceiveMaterialChangePushOnce(nil, nil)
end

function var_0_0.receiveMaterial(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.dataList) do
		local var_3_4
		local var_3_5 = MaterialDataMO.New()

		if iter_3_1.materilType == MaterialEnum.MaterialType.PowerPotion then
			local var_3_6 = ItemPowerModel.instance:getLatestPowerChange()

			for iter_3_2, iter_3_3 in pairs(var_3_6) do
				if tonumber(iter_3_3.itemid) == tonumber(iter_3_1.materilId) then
					var_3_4 = iter_3_3.uid
				end
			end
		elseif iter_3_1.materilType == MaterialEnum.MaterialType.NewInsight then
			local var_3_7 = ItemInsightModel.instance:getLatestInsightChange()

			for iter_3_4, iter_3_5 in pairs(var_3_7) do
				if tonumber(iter_3_5.itemid) == tonumber(iter_3_1.materilId) then
					var_3_4 = iter_3_5.uid
				end
			end
		end

		var_3_5:initValue(iter_3_1.materilType, iter_3_1.materilId, iter_3_1.quantity, var_3_4, iter_3_1.roomBuildingLevel)

		if iter_3_1.materilType == MaterialEnum.MaterialType.Faith then
			table.insert(var_3_1, var_3_5)
		elseif iter_3_1.materilType == MaterialEnum.MaterialType.EquipCard then
			for iter_3_6 = 1, iter_3_1.quantity do
				table.insert(var_3_2, iter_3_1.materilId)
			end
		elseif iter_3_1.materilType == MaterialEnum.MaterialType.Season123EquipCard then
			for iter_3_7 = 1, iter_3_1.quantity do
				table.insert(var_3_3, iter_3_1.materilId)
			end
		elseif iter_3_1.materilType == MaterialEnum.MaterialType.Act186Like then
			-- block empty
		else
			table.insert(var_3_0, var_3_5)
		end
	end

	return var_3_0, var_3_1, var_3_2, var_3_3
end

function var_0_0.set_onReceiveMaterialChangePushOnce(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._materialChangePushOnceCb = arg_4_1
	arg_4_0._materialChangePushOnceCbObj = arg_4_2
end

function var_0_0.onReceiveMaterialChangePush(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._materialChangePushOnceCb

	if var_5_0 then
		local var_5_1 = arg_5_0._materialChangePushOnceCbObj

		arg_5_0:set_onReceiveMaterialChangePushOnce(nil, nil)
		var_5_0(var_5_1, arg_5_1, arg_5_2)

		return
	end

	if arg_5_1 ~= 0 then
		return
	end

	local var_5_2, var_5_3, var_5_4, var_5_5 = var_0_0.receiveMaterial(arg_5_2)

	arg_5_0:_onReceiveMaterialChangePush(arg_5_2, var_5_2, var_5_3, var_5_4, var_5_5)
end

function var_0_0._onReceiveMaterialChangePush(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0 = arg_6_1.getApproach

	if var_6_0 == MaterialEnum.GetApproach.Charge then
		PayController.instance:onReceiveMaterialChangePush(arg_6_2)
	end

	if PopupCacheModel.instance:isIgnoreGetPropView(var_6_0) then
		return
	end

	if PopupCacheController.instance:tryCacheGetPropView(var_6_0, {
		materialDataMOList = arg_6_2
	}) then
		return
	end

	if var_6_0 == MaterialEnum.GetApproach.RoomProductLine then
		RoomController.instance:MaterialChangeByRoomProductLine(arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.Explore then
		-- block empty
	elseif var_6_0 == MaterialEnum.GetApproach.BattlePass then
		BpController.instance:_showCommonPropView(arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.DungeonRewardPoint then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointRewardMaterials, arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.AstrologyStarReward then
		VersionActivity1_3AstrologyModel.instance:setStarReward(arg_6_2)

		return
	elseif var_6_0 == MaterialEnum.GetApproach.Task or arg_6_1.getApproach == MaterialEnum.GetApproach.TaskAct then
		if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
			WeekWalkTaskListModel.instance:setTaskRewardList(arg_6_2)

			return
		end

		if ViewMgr.instance:isOpen(ViewName.WeekWalk_2LayerRewardView) then
			WeekWalk_2TaskListModel.instance:setTaskRewardList(arg_6_2)

			return
		end

		TaskController.instance:getRewardByLine(var_6_0, ViewName.CommonPropView, arg_6_2)

		if #arg_6_4 > 0 then
			Activity104Model.instance:addCardGetData(arg_6_4)
			Activity104Controller.instance:checkShowEquipSelfChoiceView()
		end

		if #arg_6_5 > 0 then
			Season123Model.instance:addCardGetData(arg_6_5)
		end
	elseif var_6_0 == MaterialEnum.GetApproach.RoomInteraction then
		RoomController.instance:showInteractionRewardToast(arg_6_2)

		if #arg_6_3 > 0 then
			RoomCharacterController.instance:showGainFaithToast(arg_6_3)
		end
	elseif var_6_0 == MaterialEnum.GetApproach.NoviceStageReward then
		TaskModel.instance:setHasTaskNoviceStageReward(true)
	elseif var_6_0 == MaterialEnum.GetApproach.SignIn then
		SignInController.instance:setSigninReward(arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.Act1_6SkillLvDown or var_6_0 == MaterialEnum.GetApproach.Act1_6SkillReset then
		VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.SkillPointReturnBack)

		return
	elseif var_6_0 == MaterialEnum.GetApproach.v1a8Act157ComponentReward then
		return
	elseif var_6_0 == MaterialEnum.GetApproach.v2a2Act169SummonNewPick and not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		SummonNewCustomPickChoiceController.instance:setSummonReward(arg_6_2)

		return
	elseif var_6_0 == MaterialEnum.GetApproach.LifeCircleSign then
		LifeCircleController.instance:openLifeCircleRewardView(arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.AutoChessRankReward or var_6_0 == MaterialEnum.GetApproach.AutoChessPveReward then
		AutoChessController.instance:addPopupView(ViewName.CommonPropView, arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.Activity197View then
		Activity197Controller.instance:setRummageReward(ViewName.CommonPropView, arg_6_2)
	elseif var_6_0 == MaterialEnum.GetApproach.SkinCoupon then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.SkinCouponTipView, ViewName.SkinCouponTipView, arg_6_2)
	else
		arg_6_0:_onReceiveMaterialChangePush_default(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	end
end

function var_0_0._onReceiveMaterialChangePush_default(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = arg_7_1.getApproach

	if #arg_7_3 > 0 and var_7_0 == MaterialEnum.GetApproach.RoomGainFaith then
		RoomCharacterController.instance:showGainFaithToast(arg_7_3)
	end

	if #arg_7_4 > 0 then
		Activity104Model.instance:addCardGetData(arg_7_4)
	end

	if #arg_7_5 > 0 then
		Season123Model.instance:addCardGetData(arg_7_5)
	end

	if #arg_7_2 == 1 and arg_7_2[1].materilType == MaterialEnum.MaterialType.HeroSkin then
		return
	end

	if #arg_7_2 == 1 and arg_7_2[1].materilType == MaterialEnum.MaterialType.Item then
		local var_7_1 = MainSceneSwitchConfig.instance:getConfigByItemId(arg_7_2[1].materilId)

		if var_7_1 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainSceneSwitchInfoView, {
				sceneSkinId = var_7_1.id,
				materialDataMOList = arg_7_2
			})

			return
		end
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_2 = MainSceneSwitchConfig.instance:getConfigByItemId(iter_7_1.materilId)

		if var_7_2 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainSceneSwitchInfoView, {
				sceneSkinId = var_7_2.id,
				materialDataMOList = arg_7_2
			})
		end

		local var_7_3 = MainUISwitchConfig.instance:getUISwitchCoByItemId(iter_7_1.materilId)

		if var_7_3 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainUISwitchInfoBlurMaskView, {
				SkinId = var_7_3.id
			})
		end
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_2) do
		local var_7_4 = FightUISwitchModel.instance:getStyleMoByItemId(iter_7_3.materilId)

		if var_7_4 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.FightUISwitchEquipView, {
				mo = var_7_4
			})
		end
	end

	local var_7_5 = #arg_7_2

	if var_7_5 ~= 0 and arg_7_2[1].materilType == MaterialEnum.MaterialType.Critter then
		CritterController.instance:popUpCritterGetView()

		if var_7_5 == 1 then
			return
		end
	end

	local var_7_6 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)

	if var_7_6 and #var_7_6 > 0 then
		for iter_7_4, iter_7_5 in ipairs(var_7_6) do
			if #arg_7_2 == 1 and iter_7_5.id == arg_7_2[1].materilId then
				PlayerCardController.instance:ShowChangeBgSkin(iter_7_5.id)
			end
		end
	end

	arg_7_0:simpleShowView(arg_7_2)
end

function var_0_0.simpleShowView(arg_8_0, arg_8_1)
	if not #arg_8_1 or #arg_8_1 == 0 then
		return
	end

	RoomController.instance:popUpRoomBlockPackageView(arg_8_1)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_8_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
