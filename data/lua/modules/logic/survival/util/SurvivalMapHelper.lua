module("modules.logic.survival.util.SurvivalMapHelper", package.seeall)

local var_0_0 = class("SurvivalMapHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.flow = nil
	arg_1_0._allEntity = {}
	arg_1_0._steps = nil
end

function var_0_0.cacheSteps(arg_2_0, arg_2_1)
	arg_2_0._steps = arg_2_0._steps or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = SurvivalMapStepMo.New()

		var_2_0:init(iter_2_1)

		local var_2_1 = SurvivalEnum.StepTypeToName[iter_2_1.type] or ""
		local var_2_2 = _G[string.format("Survival%sWork", var_2_1)]

		if var_2_2 then
			table.insert(arg_2_0._steps, var_2_2.New(var_2_0))
		end
	end
end

function var_0_0.addPushToFlow(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._steps = arg_3_0._steps or {}

	local var_3_0 = (_G[string.format("%sWork", arg_3_1)] or SurvivalMsgPushWork).New(arg_3_1, arg_3_2)

	table.insert(arg_3_0._steps, var_3_0)
end

function var_0_0.tryStartFlow(arg_4_0, arg_4_1)
	if not arg_4_0._steps or #arg_4_0._steps <= 0 then
		return
	end

	local var_4_0 = false

	if not arg_4_0.flow then
		arg_4_0.flow = FlowSequence.New()
		var_4_0 = true
	end

	if arg_4_1 == "EnterSurvivalReply" then
		arg_4_0.flow:addWork(SurvivalWaitSceneFinishWork.New())
	end

	local var_4_1 = {
		beforeFlow = FlowParallel.New(),
		afterFlow = FlowSequence.New(),
		moveIdSet = {}
	}

	arg_4_0.flow:addWork(var_4_1.beforeFlow)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._steps) do
		local var_4_2 = iter_4_1._stepMo

		if var_4_2 then
			local var_4_3 = iter_4_1:getRunOrder(var_4_1, arg_4_0.flow, iter_4_0, arg_4_0._steps)

			if var_4_3 == SurvivalEnum.StepRunOrder.Before then
				var_4_1.beforeFlow:addWork(iter_4_1)
			elseif var_4_3 == SurvivalEnum.StepRunOrder.After then
				var_4_1.afterFlow:addWork(iter_4_1)
			end

			if var_4_2.type == SurvivalEnum.StepType.MapTickAfter then
				arg_4_0.flow:addWork(var_4_1.afterFlow)

				var_4_1.beforeFlow = FlowParallel.New()
				var_4_1.afterFlow = FlowSequence.New()

				arg_4_0.flow:addWork(var_4_1.beforeFlow)

				var_4_1.moveIdSet = {}
				var_4_1.haveHeroMove = false
			end
		else
			var_4_1.afterFlow:addWork(iter_4_1)
		end
	end

	arg_4_0.flow:addWork(var_4_1.afterFlow)

	local var_4_4 = SurvivalShelterModel.instance:getWeekInfo()

	if var_4_4 and var_4_4.inSurvival then
		arg_4_0.flow:addWork(SurvivalContinueMoveWork.New())
	end

	if var_4_0 then
		arg_4_0.flow:registerDoneListener(arg_4_0.flowDone, arg_4_0)
		arg_4_0.flow:start({
			beginDt = ServerTime.now()
		})
	end

	arg_4_0._steps = nil
end

function var_0_0.flowDone(arg_5_0)
	local var_5_0 = false

	if arg_5_0.flow and arg_5_0.flow.context.fastExecute then
		SurvivalController.instance:exitMap()

		var_5_0 = true
	end

	arg_5_0.flow = nil
	arg_5_0.serverFlow = nil
	arg_5_0._steps = nil

	if not var_5_0 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.onFlowEnd)
	end

	if false then
		local var_5_1 = SurvivalShelterModel.instance:getWeekInfo()
		local var_5_2 = ""

		for iter_5_0, iter_5_1 in pairs(var_5_1.attrs) do
			if not string.nilorempty(var_5_2) then
				var_5_2 = var_5_2 .. "|"
			end

			var_5_2 = var_5_2 .. iter_5_0 .. "#" .. iter_5_1
		end

		GMRpc.instance:sendGMRequest("surTestAttr " .. var_5_2)
	end
end

function var_0_0.isInFlow(arg_6_0)
	return arg_6_0.flow ~= nil or arg_6_0._steps and #arg_6_0._steps > 0
end

function var_0_0.fastDoFlow(arg_7_0)
	if not arg_7_0.flow then
		arg_7_0._steps = nil

		return
	end

	if not arg_7_0:tryRemoveFlow() then
		arg_7_0.flow.context.fastExecute = true
	end
end

function var_0_0.tryRemoveFlow(arg_8_0)
	if not arg_8_0.flow then
		return
	end

	if ServerTime.now() - arg_8_0.flow.context.beginDt > 5 then
		logError("可能卡主了，清掉数据吧")

		arg_8_0._steps = nil

		arg_8_0.flow:onDestroyInternal()

		arg_8_0.flow = nil

		return true
	end
end

function var_0_0.tryShowEventView(arg_9_0, arg_9_1)
	SurvivalMapModel.instance:setMoveToTarget(nil)

	local var_9_0 = SurvivalMapModel.instance:getSceneMo()

	arg_9_1 = arg_9_1 or var_9_0.player.pos

	local var_9_1 = var_9_0:getUnitByPos(arg_9_1, true)

	if var_9_1[1] then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			if iter_9_1.unitType == SurvivalEnum.UnitType.Treasure then
				SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", iter_9_1.id)
				SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.TriggerEvent, tostring(iter_9_1.id))

				return
			end
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			pos = arg_9_1,
			allUnitMo = var_9_1
		})
		SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", var_9_1[1].id)
	end
end

function var_0_0.tryShowServerPanel(arg_10_0, arg_10_1)
	if not arg_10_1 or arg_10_1.type == SurvivalEnum.PanelType.None then
		return
	end

	SurvivalMapModel.instance:setMoveToTarget(nil)

	local var_10_0 = arg_10_1.type

	if var_10_0 == SurvivalEnum.PanelType.Search then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapSearchView
		})

		local var_10_1 = arg_10_1:getSearchItems()
		local var_10_2

		if SurvivalMapModel.instance.searchChangeItems and SurvivalMapModel.instance.searchChangeItems.panelUid == arg_10_1.uid then
			var_10_2 = tabletool.copy(var_10_1)

			for iter_10_0, iter_10_1 in ipairs(SurvivalMapModel.instance.searchChangeItems.items) do
				if var_10_2[iter_10_1.uid] then
					var_10_2[iter_10_1.uid] = iter_10_1
				end
			end
		end

		ViewMgr.instance:openView(ViewName.SurvivalMapSearchView, {
			itemMos = arg_10_1:getSearchItems(),
			isFirst = arg_10_1.isFirstSearch,
			preItems = var_10_2
		})
	elseif var_10_0 == SurvivalEnum.PanelType.TreeEvent then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			panel = arg_10_1
		})
	elseif var_10_0 == SurvivalEnum.PanelType.DropSelect then
		local var_10_3 = arg_10_0:isInShelterScene()

		if var_10_3 then
			if ViewMgr.instance:isOpen(ViewName.SurvivalDropSelectView) then
				var_10_3 = false

				logError("已有掉落界面弹出了！")
			end

			if PopupController.instance:havePopupView(ViewName.SurvivalDropSelectView) then
				var_10_3 = false

				logError("已有掉落界面弹出了！！")
			end
		end

		if arg_10_0:isInShelterScene() then
			if var_10_3 then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalDropSelectView, {
					panel = arg_10_1
				})
			end
		else
			ViewMgr.instance:closeAllPopupViews({
				ViewName.SurvivalDropSelectView
			})
			ViewMgr.instance:openView(ViewName.SurvivalDropSelectView, {
				panel = arg_10_1
			})
		end
	elseif var_10_0 == SurvivalEnum.PanelType.Store then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalShopView
		})
		ViewMgr.instance:openView(ViewName.SurvivalShopView)
	elseif var_10_0 == SurvivalEnum.PanelType.Decrees then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalDecreeSelectView
		})
		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			panel = arg_10_1
		})
	end
end

function var_0_0.getBlockRes(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getScene()

	if not var_11_0 then
		return
	end

	return var_11_0.preloader:getRes(arg_11_1)
end

function var_0_0.getSpBlockRes(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getScene()

	if not var_12_0 then
		return
	end

	return var_12_0.preloader:getBlockRes(arg_12_1, arg_12_2)
end

function var_0_0.getScene(arg_13_0)
	local var_13_0 = GameSceneMgr.instance:getCurScene()

	if not var_13_0 or var_13_0.__cname ~= "SurvivalScene" and var_13_0.__cname ~= "SurvivalShelterScene" and var_13_0.__cname ~= "SurvivalSummaryAct" then
		return
	end

	return var_13_0
end

function var_0_0.getSceneCameraComp(arg_14_0)
	local var_14_0 = arg_14_0:getScene()

	return var_14_0 and var_14_0.camera
end

function var_0_0.getSceneFogComp(arg_15_0)
	local var_15_0 = arg_15_0:getScene()

	return var_15_0 and var_15_0.fog
end

function var_0_0.getSurvivalBubbleComp(arg_16_0)
	local var_16_0 = arg_16_0:getScene()

	return var_16_0 and var_16_0.bubble
end

function var_0_0.updateCloudShow(arg_17_0, ...)
	local var_17_0 = arg_17_0:getScene()
	local var_17_1 = var_17_0 and var_17_0.cloud

	if var_17_1 then
		var_17_1:updateCloudShow(...)
	end
end

function var_0_0.setDistance(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getSceneCameraComp()

	if var_18_0 then
		var_18_0:setDistance(arg_18_1)
	end
end

function var_0_0.setFocusPos(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:getSceneCameraComp()

	if var_19_0 then
		var_19_0:setFocus(arg_19_1, arg_19_2, arg_19_3)
	end
end

function var_0_0.setCameraYaw(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getSceneCameraComp()

	if var_20_0 then
		var_20_0:setRotate(arg_20_1)
	end
end

function var_0_0.setRotate(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getSceneCameraComp()

	if var_21_0 then
		var_21_0:setRotate(arg_21_1, arg_21_2)
	end
end

function var_0_0.applyDirectly(arg_22_0)
	local var_22_0 = arg_22_0:getSceneCameraComp()

	if var_22_0 then
		var_22_0:applyDirectly()
	end
end

function var_0_0.addEntity(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._allEntity[arg_23_1] = arg_23_2
end

function var_0_0.removeEntity(arg_24_0, arg_24_1)
	arg_24_0._allEntity[arg_24_1] = nil
end

function var_0_0.getEntity(arg_25_0, arg_25_1)
	return arg_25_0._allEntity[arg_25_1]
end

function var_0_0.getShopById(arg_26_0, arg_26_1)
	local var_26_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_26_0 then
		return
	end

	local var_26_1

	if var_26_0.inSurvival then
		local var_26_2 = SurvivalMapModel.instance:getSceneMo()

		if not var_26_2 then
			return
		end

		if var_26_2.panel and var_26_2.panel.type == SurvivalEnum.PanelType.Store then
			var_26_1 = var_26_2.panel.shop, var_26_2.panel.uid
		end
	elseif SurvivalConfig.instance:getShopType(arg_26_1) == SurvivalEnum.ShopType.PreExplore then
		var_26_1 = var_26_0.preExploreShop
	else
		var_26_1 = var_26_0:getBuildShop(arg_26_1)
	end

	return var_26_1
end

function var_0_0.getShopPanel(arg_27_0)
	local var_27_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_27_0 then
		return
	end

	if var_27_0.inSurvival then
		local var_27_1 = SurvivalMapModel.instance:getSceneMo()

		if not var_27_1 then
			return
		end

		if var_27_1.panel and var_27_1.panel.type == SurvivalEnum.PanelType.Store then
			return var_27_1.panel.shop, var_27_1.panel.uid
		end
	else
		local var_27_2 = var_27_0:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Shop)

		return var_27_2 and var_27_2.shop
	end
end

function var_0_0.getBagMo(arg_28_0)
	local var_28_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_28_0 then
		return
	end

	if var_28_0.inSurvival then
		return var_28_0:getBag(SurvivalEnum.ItemSource.Map)
	else
		return var_28_0:getBag(SurvivalEnum.ItemSource.Shelter)
	end
end

function var_0_0.isInSurvivalScene(arg_29_0)
	local var_29_0 = GameSceneMgr.instance:getCurSceneType()

	return var_29_0 == SceneType.Survival or var_29_0 == SceneType.SurvivalShelter or var_29_0 == SceneType.SurvivalSummaryAct
end

function var_0_0.isInShelterScene(arg_30_0)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.SurvivalShelter
end

function var_0_0.clearSteps(arg_31_0)
	arg_31_0._steps = nil
end

function var_0_0.clear(arg_32_0)
	if arg_32_0.flow then
		arg_32_0.flow:onDestroyInternal()

		arg_32_0.flow = nil
	end

	ViewMgr.instance:closeAllPopupViews()

	arg_32_0._steps = nil
	arg_32_0.serverFlow = nil
	arg_32_0._allEntity = {}
end

function var_0_0.gotoBuilding(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:getScene()

	if not var_33_0 then
		return
	end

	local var_33_1 = var_33_0.unit:getBuildEntity(arg_33_1)

	if not var_33_1 then
		return
	end

	local var_33_2 = var_33_1.buildingCo.pointRangeList
	local var_33_3 = var_33_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_33_3:moveToByPosList(var_33_2, arg_33_0.interactiveBuilding, arg_33_0, arg_33_1, arg_33_3)
end

function var_0_0.interactiveBuilding(arg_34_0, arg_34_1)
	local var_34_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_34_1)

	if not var_34_0 then
		logError(string.format("建筑数据不存在，buildingId:%s not found", arg_34_1))

		return
	end

	if not (var_34_0.baseCo.unName ~= 1) then
		return
	end

	ViewMgr.instance:closeAllPopupViews()

	if not var_34_0:isBuild() then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = arg_34_1
		})

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Decree) then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeView)

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Task) then
		ViewMgr.instance:openView(ViewName.ShelterTaskView)

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Explore) then
		if SurvivalShelterModel.instance:getWeekInfo():getMonsterFight():needKillBoss() then
			local var_34_1 = var_0_0.instance:getSurvivalBubbleComp()

			if not var_34_1:isPlayerBubbleShow() then
				local var_34_2 = SurvivalBubbleParam.New()

				var_34_2.content = luaLang("SurvivalBubble_1")
				var_34_2.duration = -1
				arg_34_0.bubbleId = var_34_1:showPlayerBubble(var_34_2)
			end
		else
			SurvivalController.instance:enterSurvival()
		end

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Health) then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = arg_34_1
		})

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Tent) then
		ViewMgr.instance:openView(ViewName.ShelterTentManagerView, {
			buildingId = arg_34_1
		})

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Equipment) then
		ViewMgr.instance:openView(ViewName.ShelterCompositeView)

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Npc) then
		ViewMgr.instance:openView(ViewName.ShelterRecruitView)

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Warehouse) then
		ViewMgr.instance:openView(ViewName.ShelterMapBagView)

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.Shop) then
		local var_34_3 = var_34_0:getShop()

		ViewMgr.instance:openView(ViewName.SurvivalShopView, {
			shopMo = var_34_3
		})

		return
	end

	if var_34_0:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		ViewMgr.instance:openView(ViewName.SurvivalReputationShopView, {
			buildingId = arg_34_1
		})

		return
	end

	ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
		buildingId = arg_34_1
	})
end

function var_0_0.gotoUnit(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_1 == SurvivalEnum.ShelterUnitType.Npc then
		arg_35_0:gotoNpc(arg_35_2, arg_35_3)

		return
	end

	if arg_35_1 == SurvivalEnum.ShelterUnitType.Build then
		arg_35_0:gotoBuilding(arg_35_2, arg_35_3)

		return
	end

	if arg_35_1 == SurvivalEnum.ShelterUnitType.Monster then
		arg_35_0:gotoMonster(arg_35_2, arg_35_3)

		return
	end
end

function var_0_0.gotoNpc(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0:getScene()

	if not var_36_0 then
		return
	end

	local var_36_1 = var_36_0.unit:getNpcEntity(arg_36_1)

	if not var_36_1 then
		return
	end

	local var_36_2 = var_36_1.pos
	local var_36_3 = var_36_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_36_3:moveToByPos(arg_36_2 or var_36_2, arg_36_0.interactiveNpc, arg_36_0, arg_36_1)
end

function var_0_0.interactiveNpc(arg_37_0, arg_37_1)
	local var_37_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(arg_37_1)
	local var_37_1 = arg_37_0:getShelterNpcPriorityBehavior(arg_37_1)

	if var_37_1 then
		local var_37_2 = SurvivalBagItemMo.New()

		var_37_2:init({
			count = 1,
			id = var_37_0.id
		})
		ViewMgr.instance:closeAllPopupViews()

		local var_37_3 = {
			status = var_37_0:getShelterNpcStatus()
		}

		ViewMgr.instance:openView(ViewName.ShelterMapEventView, {
			conditionParam = var_37_3,
			title = var_37_0.co.name,
			behaviorConfig = var_37_1,
			unitResPath = var_37_0.co.resource,
			itemMo = var_37_2
		})
	end
end

function var_0_0.getShelterNpcPriorityBehavior(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getShelterNpcBehaviorList(arg_38_1)

	if #var_38_0 == 0 then
		return nil
	end

	local var_38_1 = var_38_0[1].priority
	local var_38_2 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if var_38_1 < iter_38_1.priority then
			var_38_1 = iter_38_1.priority
			var_38_2 = {
				iter_38_1
			}
		elseif iter_38_1.priority == var_38_1 then
			table.insert(var_38_2, iter_38_1)
		end
	end

	if #var_38_2 == 1 then
		return var_38_2[1]
	else
		return var_38_2[math.random(1, #var_38_2)]
	end
end

function var_0_0.getShelterNpcBehaviorList(arg_39_0, arg_39_1)
	local var_39_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(arg_39_1)
	local var_39_1 = string.splitToNumber(var_39_0.co.surBehavior, "#")
	local var_39_2 = {}
	local var_39_3 = {
		status = var_39_0:getShelterNpcStatus()
	}

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		local var_39_4 = lua_survival_behavior.configDict[iter_39_1]

		if var_39_4 and arg_39_0:isBehaviorMeetCondition(var_39_4.condition, var_39_3) then
			table.insert(var_39_2, var_39_4)
		end
	end

	if #var_39_2 > 1 then
		table.sort(var_39_2, SortUtil.keyUpper("priority"))
	end

	return var_39_2
end

function var_0_0.gotoMonster(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_0:getScene()

	if not var_40_0 then
		return
	end

	local var_40_1 = var_40_0.unit:getMonsterEntity(arg_40_1)

	if not var_40_1 then
		return
	end

	local var_40_2 = var_40_1.pos
	local var_40_3 = var_40_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_40_3:moveToByPos(arg_40_2 or var_40_2, arg_40_0.interactiveMonster, arg_40_0, arg_40_1, arg_40_3)
end

function var_0_0.interactiveMonster(arg_41_0, arg_41_1)
	local var_41_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_41_0 and var_41_0.fightId == arg_41_1 and var_41_0:canShowEntity() then
		ViewMgr.instance:closeAllPopupViews()
		ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
			showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Normal
		})
	end
end

function var_0_0.isBehaviorMeetCondition(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = GameUtil.splitString2(arg_42_1, false)

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if not arg_42_0:checkSingleCondition(iter_42_1, arg_42_2) then
			return false
		end
	end

	return true
end

function var_0_0.checkSingleCondition(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1 then
		return true
	end

	if arg_43_1[1] == "NpcStatus" then
		return tonumber(arg_43_1[2]) == arg_43_2.status
	elseif arg_43_1[1] == "unFinishTask" then
		local var_43_0 = tonumber(arg_43_1[2])
		local var_43_1 = tonumber(arg_43_1[3])
		local var_43_2 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_43_0)
		local var_43_3 = var_43_2 and var_43_2:getTaskInfo(var_43_1)

		return var_43_3 and var_43_3:isUnFinish()
	elseif arg_43_1[1] == "unAcceptTask" then
		local var_43_4 = tonumber(arg_43_1[2])
		local var_43_5 = tonumber(arg_43_1[3])
		local var_43_6 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_43_4)

		return (var_43_6 and var_43_6:getTaskInfo(var_43_5)) == nil
	elseif arg_43_1[1] == "finishTask" then
		local var_43_7 = tonumber(arg_43_1[2])
		local var_43_8 = tonumber(arg_43_1[3])
		local var_43_9 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_43_7)
		local var_43_10 = var_43_9 and var_43_9:getTaskInfo(var_43_8)

		return var_43_10 and not var_43_10:isUnFinish() or false
	end

	return true
end

function var_0_0.getLocalShelterEntityPosAndDir(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = SurvivalConfig.instance:getCurShelterMapId()
	local var_44_1, var_44_2 = SurvivalConfig.instance:getLocalShelterEntityPosAndDir(var_44_0, arg_44_1, arg_44_2)

	if not var_44_1 or not arg_44_0:isPosValid(var_44_1, true) then
		var_44_1, var_44_2 = arg_44_0:getRandomWalkPosAndDir()

		local var_44_3 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight().fightCo.toward

		if not string.nilorempty(var_44_3) then
			local var_44_4 = string.splitToNumber(var_44_3, true)

			var_44_2 = SurvivalHelper.instance:getDirMustHave(var_44_1, SurvivalHexNode.New(var_44_4[1], var_44_4[2]))
		end

		SurvivalConfig.instance:saveLocalShelterEntityPosAndDir(var_44_0, arg_44_1, arg_44_2, var_44_1, var_44_2)
	end

	return var_44_1, var_44_2
end

function var_0_0.getRandomWalkPosAndDir(arg_45_0)
	local var_45_0 = arg_45_0:getScene()

	if not var_45_0 then
		return
	end

	local var_45_1 = SurvivalConfig.instance:getShelterMapCo().walkables
	local var_45_2 = {}

	if var_45_0 then
		var_45_0.unit:addUsedPos(var_45_2)
	end

	local var_45_3 = {}

	for iter_45_0, iter_45_1 in pairs(var_45_1) do
		for iter_45_2, iter_45_3 in pairs(iter_45_1) do
			if not SurvivalHelper.instance:getValueFromDict(var_45_2, iter_45_3) then
				table.insert(var_45_3, iter_45_3)
			end
		end
	end

	if #var_45_3 == 0 then
		return nil
	end

	local var_45_4 = math.random(0, 5)

	return var_45_3[math.random(1, #var_45_3)], var_45_4
end

function var_0_0.isPosValid(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0:getScene()
	local var_46_1 = {}

	var_46_0.unit:addUsedPos(var_46_1, arg_46_2)

	if SurvivalHelper.instance:getValueFromDict(var_46_1, arg_46_1) then
		return false
	else
		local var_46_2 = SurvivalConfig.instance:getShelterMapCo().walkables

		for iter_46_0, iter_46_1 in pairs(var_46_2) do
			for iter_46_2, iter_46_3 in pairs(iter_46_1) do
				if arg_46_1 == iter_46_3 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.getShelterEntity(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0:getScene()

	if not var_47_0 then
		return
	end

	return var_47_0.unit:getEntity(arg_47_1, arg_47_2)
end

function var_0_0.addShelterEntity(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0:getScene()

	if not var_48_0 then
		return
	end

	return var_48_0.unit:addEntity(arg_48_1, arg_48_2, arg_48_3)
end

function var_0_0.getAllShelterEntity(arg_49_0)
	local var_49_0 = arg_49_0:getScene()

	if not var_49_0 then
		return
	end

	return var_49_0.unit:getAllEntity()
end

function var_0_0.hideUnitVisible(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0:getAllShelterEntity()

	for iter_50_0, iter_50_1 in pairs(var_50_0) do
		if iter_50_0 == arg_50_1 and iter_50_1 then
			for iter_50_2, iter_50_3 in pairs(iter_50_1) do
				iter_50_3:setVisible(arg_50_2)
			end
		end
	end
end

function var_0_0.refreshPlayerEntity(arg_51_0)
	local var_51_0 = arg_51_0:getScene()

	if not var_51_0 then
		return
	end

	var_51_0.unit:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
end

function var_0_0.stopShelterPlayerMove(arg_52_0)
	local var_52_0 = arg_52_0:getScene()

	if not var_52_0 then
		return
	end

	local var_52_1 = var_52_0.unit:getPlayer()

	if var_52_1 then
		var_52_1:stopMove()
	end
end

local var_0_1 = Vector3()

function var_0_0.tweenToHeroPosIfNeed(arg_53_0, arg_53_1)
	arg_53_1 = arg_53_1 or 0

	local var_53_0 = SurvivalMapModel.instance:getSceneMo().player.pos
	local var_53_1 = UnityEngine.Screen.width
	local var_53_2 = UnityEngine.Screen.height

	var_0_1:Set(var_53_1 / 2, var_53_2 / 2, 0)

	local var_53_3 = var_0_1
	local var_53_4 = SurvivalHelper.instance:getScene3DPos(var_53_3)
	local var_53_5 = SurvivalHexNode.New(SurvivalHelper.instance:worldPointToHex(var_53_4.x, var_53_4.y, var_53_4.z))

	if SurvivalHelper.instance:getDistance(var_53_0, var_53_5) > 2 then
		local var_53_6 = Vector3.New(SurvivalHelper.instance:hexPointToWorldPoint(var_53_0.q, var_53_0.r))

		SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, var_53_6, arg_53_1)

		return true
	end
end

local var_0_2

function var_0_0.addPointEffect(arg_54_0, arg_54_1, arg_54_2)
	arg_54_2 = arg_54_2 or SurvivalPointEffectComp.ResPaths.explode

	if (var_0_2 == nil or var_0_2 + 0.5 < UnityEngine.Time.realtimeSinceStartup) and arg_54_2 == SurvivalPointEffectComp.ResPaths.explode then
		AudioMgr.instance:trigger(AudioEnum3_1.Survival.ExplodeEffect)

		var_0_2 = UnityEngine.Time.realtimeSinceStartup
	end

	local var_54_0, var_54_1, var_54_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_54_1.q, arg_54_1.r)

	var_0_1:Set(var_54_0, var_54_1, var_54_2)
	arg_54_0:getScene().pointEffect:addAutoDisposeEffect(arg_54_2, var_0_1, 2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
