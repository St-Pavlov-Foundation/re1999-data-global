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

	local var_4_1 = FlowParallel.New()
	local var_4_2 = FlowSequence.New()

	arg_4_0.flow:addWork(var_4_1)

	local var_4_3 = {}
	local var_4_4
	local var_4_5

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._steps) do
		local var_4_6 = iter_4_1._stepMo

		if var_4_6 then
			if var_4_6.type == SurvivalEnum.StepType.UnitMove then
				if var_4_3[var_4_6.id] then
					var_4_1 = FlowParallel.New()

					arg_4_0.flow:addWork(var_4_1)

					var_4_3 = {}

					logError("一个元件在同一个tick移动了2次！！" .. var_4_6.id)
				end

				if var_4_6.id == 0 then
					var_4_5 = true
				end

				var_4_3[var_4_6.id] = true
			end

			if var_4_6.type == SurvivalEnum.StepType.ShowEventPanel or var_4_6.type == SurvivalEnum.StepType.UpdateEventPanel then
				var_4_4 = true
			end

			if var_4_6.type == SurvivalEnum.StepType.MapTickAfter or var_4_6.type == SurvivalEnum.StepType.GameTimeUpdate or var_4_6.type == SurvivalEnum.StepType.UnitMove or var_4_6.type == SurvivalEnum.StepType.UpdateUnitData or var_4_6.type == SurvivalEnum.StepType.CircleShrinkFinish or var_4_6.type == SurvivalEnum.StepType.CircleUpdate or var_4_6.type == SurvivalEnum.StepType.UpdateSafeZoneInfo or var_4_6.type == SurvivalEnum.StepType.UpdatePoints or var_4_6.type == SurvivalEnum.StepType.PlayerMoveBack then
				var_4_1:addWork(iter_4_1)
			elseif var_4_6.type == SurvivalEnum.StepType.UnitShow then
				if var_4_5 then
					var_4_1 = FlowParallel.New()

					arg_4_0.flow:addWork(var_4_1)

					var_4_3 = {}
					var_4_5 = false
				end

				var_4_1:addWork(iter_4_1)
			elseif var_4_6.type == SurvivalEnum.StepType.UnitHide then
				local var_4_7 = false

				for iter_4_2, iter_4_3 in ipairs(var_4_6.paramInt) do
					if iter_4_2 ~= 1 and var_4_3[iter_4_3] then
						var_4_7 = true

						break
					end
				end

				if var_4_7 then
					var_4_2:addWork(iter_4_1)
				else
					if var_4_5 then
						var_4_1 = FlowParallel.New()

						arg_4_0.flow:addWork(var_4_1)

						var_4_3 = {}
						var_4_5 = false
					end

					var_4_1:addWork(iter_4_1)
				end
			elseif var_4_6.type == SurvivalEnum.StepType.FastBattle then
				arg_4_0.flow:addWork(iter_4_1)

				var_4_1 = FlowParallel.New()

				arg_4_0.flow:addWork(var_4_1)

				var_4_3 = {}
				var_4_5 = false
			elseif var_4_6.type == SurvivalEnum.StepType.RemoveEventPanel then
				if var_4_4 then
					var_4_2:addWork(iter_4_1)

					var_4_4 = false
				else
					var_4_1:addWork(iter_4_1)
				end
			else
				var_4_2:addWork(iter_4_1)
			end

			if var_4_6.type == SurvivalEnum.StepType.MapTickAfter then
				arg_4_0.flow:addWork(var_4_2)

				var_4_1 = FlowParallel.New()
				var_4_2 = FlowSequence.New()

				arg_4_0.flow:addWork(var_4_1)

				var_4_3 = {}
				var_4_5 = false
			end
		else
			var_4_2:addWork(iter_4_1)
		end
	end

	arg_4_0.flow:addWork(var_4_2)

	local var_4_8 = SurvivalShelterModel.instance:getWeekInfo()

	if var_4_8 and var_4_8.inSurvival then
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

function var_0_0.tryShowServerPanel(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 or arg_10_1.type == SurvivalEnum.PanelType.None then
		return
	end

	SurvivalMapModel.instance:setMoveToTarget(nil)

	local var_10_0 = arg_10_1.type

	if var_10_0 == SurvivalEnum.PanelType.Search then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapSearchView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapSearchView, {
			itemMos = arg_10_1:getSearchItems(),
			isFirst = arg_10_2
		})
	elseif var_10_0 == SurvivalEnum.PanelType.TreeEvent then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			panel = arg_10_1
		})
	elseif var_10_0 == SurvivalEnum.PanelType.DropSelect then
		local var_10_1 = arg_10_0:isInShelterScene()

		if var_10_1 then
			if ViewMgr.instance:isOpen(ViewName.SurvivalDropSelectView) then
				var_10_1 = false

				logError("已有掉落界面弹出了！")
			end

			if PopupController.instance:havePopupView(ViewName.SurvivalDropSelectView) then
				var_10_1 = false

				logError("已有掉落界面弹出了！！")
			end
		end

		if arg_10_0:isInShelterScene() then
			if var_10_1 then
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
	end
end

function var_0_0.getBlockRes(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getScene()

	if not var_11_0 then
		return
	end

	return var_11_0.preloader:getRes(arg_11_1)
end

function var_0_0.getScene(arg_12_0)
	local var_12_0 = GameSceneMgr.instance:getCurScene()

	if not var_12_0 or var_12_0.__cname ~= "SurvivalScene" and var_12_0.__cname ~= "SurvivalShelterScene" then
		return
	end

	return var_12_0
end

function var_0_0.getSceneCameraComp(arg_13_0)
	local var_13_0 = arg_13_0:getScene()

	return var_13_0 and var_13_0.camera
end

function var_0_0.getSceneFogComp(arg_14_0)
	local var_14_0 = arg_14_0:getScene()

	return var_14_0 and var_14_0.fog
end

function var_0_0.setDistance(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getSceneCameraComp()

	if var_15_0 then
		var_15_0:setDistance(arg_15_1)
	end
end

function var_0_0.setFocusPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:getSceneCameraComp()

	if var_16_0 then
		var_16_0:setFocus(arg_16_1, arg_16_2, arg_16_3)
	end
end

function var_0_0.setRotate(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getSceneCameraComp()

	if var_17_0 then
		var_17_0:setRotate(arg_17_1, arg_17_2)
	end
end

function var_0_0.applyDirectly(arg_18_0)
	local var_18_0 = arg_18_0:getSceneCameraComp()

	if var_18_0 then
		var_18_0:applyDirectly()
	end
end

function var_0_0.addEntity(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._allEntity[arg_19_1] = arg_19_2
end

function var_0_0.removeEntity(arg_20_0, arg_20_1)
	arg_20_0._allEntity[arg_20_1] = nil
end

function var_0_0.getEntity(arg_21_0, arg_21_1)
	return arg_21_0._allEntity[arg_21_1]
end

function var_0_0.getShopPanel(arg_22_0)
	local var_22_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_22_0 then
		return
	end

	if var_22_0.inSurvival then
		local var_22_1 = SurvivalMapModel.instance:getSceneMo()

		if not var_22_1 then
			return
		end

		if var_22_1.panel and var_22_1.panel.type == SurvivalEnum.PanelType.Store then
			return var_22_1.panel.shop, var_22_1.panel.uid
		end
	else
		local var_22_2 = var_22_0:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Shop)

		return var_22_2 and var_22_2.shop
	end
end

function var_0_0.getBagMo(arg_23_0)
	local var_23_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_23_0 then
		return
	end

	if var_23_0.inSurvival then
		local var_23_1 = SurvivalMapModel.instance:getSceneMo()

		if not var_23_1 then
			return
		end

		return var_23_1.bag
	else
		return var_23_0.bag
	end
end

function var_0_0.isInShelterScene(arg_24_0)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.SurvivalShelter
end

function var_0_0.clear(arg_25_0)
	if arg_25_0.flow then
		arg_25_0.flow:onDestroyInternal()

		arg_25_0.flow = nil
	end

	ViewMgr.instance:closeAllPopupViews()

	arg_25_0._steps = nil
	arg_25_0.serverFlow = nil
	arg_25_0._allEntity = {}
end

function var_0_0.gotoBuilding(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0:getScene()

	if not var_26_0 then
		return
	end

	local var_26_1 = var_26_0.unit:getBuildEntity(arg_26_1)

	if not var_26_1 then
		return
	end

	local var_26_2 = var_26_1.buildingCo.pointRangeList
	local var_26_3 = var_26_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_26_3:moveToByPosList(var_26_2, arg_26_0.interactiveBuilding, arg_26_0, arg_26_1, arg_26_3)
end

function var_0_0.interactiveBuilding(arg_27_0, arg_27_1)
	local var_27_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_27_1)

	if not var_27_0 then
		logError(string.format("建筑数据不存在，buildingId:%s not found", arg_27_1))

		return
	end

	ViewMgr.instance:closeAllPopupViews()

	if not var_27_0:isBuild() then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = arg_27_1
		})

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Decree) then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeView)

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Task) then
		ViewMgr.instance:openView(ViewName.ShelterTaskView)

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Explore) then
		SurvivalController.instance:enterSurvival()

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Health) then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = arg_27_1
		})

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Tent) then
		ViewMgr.instance:openView(ViewName.ShelterTentManagerView, {
			buildingId = arg_27_1
		})

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Equipment) then
		ViewMgr.instance:openView(ViewName.ShelterCompositeView)

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Npc) then
		ViewMgr.instance:openView(ViewName.ShelterRecruitView)

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Warehouse) then
		ViewMgr.instance:openView(ViewName.ShelterMapBagView)

		return
	end

	if var_27_0:isEqualType(SurvivalEnum.BuildingType.Shop) then
		ViewMgr.instance:openView(ViewName.SurvivalShopView)

		return
	end

	ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
		buildingId = arg_27_1
	})
end

function var_0_0.gotoUnit(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_1 == SurvivalEnum.ShelterUnitType.Npc then
		arg_28_0:gotoNpc(arg_28_2, arg_28_3)

		return
	end

	if arg_28_1 == SurvivalEnum.ShelterUnitType.Build then
		arg_28_0:gotoBuilding(arg_28_2, arg_28_3)

		return
	end

	if arg_28_1 == SurvivalEnum.ShelterUnitType.Monster then
		arg_28_0:gotoMonster(arg_28_2, arg_28_3)

		return
	end
end

function var_0_0.gotoNpc(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getScene()

	if not var_29_0 then
		return
	end

	local var_29_1 = var_29_0.unit:getNpcEntity(arg_29_1)

	if not var_29_1 then
		return
	end

	local var_29_2 = var_29_1.pos
	local var_29_3 = var_29_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_29_3:moveToByPos(arg_29_2 or var_29_2, arg_29_0.interactiveNpc, arg_29_0, arg_29_1)
end

function var_0_0.interactiveNpc(arg_30_0, arg_30_1)
	local var_30_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(arg_30_1)
	local var_30_1 = arg_30_0:getShelterNpcPriorityBehavior(arg_30_1)

	if var_30_1 then
		local var_30_2 = SurvivalBagItemMo.New()

		var_30_2:init({
			count = 1,
			id = var_30_0.id
		})
		ViewMgr.instance:closeAllPopupViews()

		local var_30_3 = {
			status = var_30_0:getShelterNpcStatus()
		}

		ViewMgr.instance:openView(ViewName.ShelterMapEventView, {
			conditionParam = var_30_3,
			title = var_30_0.co.name,
			behaviorConfig = var_30_1,
			unitResPath = var_30_0.co.resource,
			itemMo = var_30_2
		})
	end
end

function var_0_0.getShelterNpcPriorityBehavior(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getShelterNpcBehaviorList(arg_31_1)

	if #var_31_0 == 0 then
		return nil
	end

	local var_31_1 = var_31_0[1].priority
	local var_31_2 = {}

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if var_31_1 < iter_31_1.priority then
			var_31_1 = iter_31_1.priority
			var_31_2 = {
				iter_31_1
			}
		elseif iter_31_1.priority == var_31_1 then
			table.insert(var_31_2, iter_31_1)
		end
	end

	if #var_31_2 == 1 then
		return var_31_2[1]
	else
		return var_31_2[math.random(1, #var_31_2)]
	end
end

function var_0_0.getShelterNpcBehaviorList(arg_32_0, arg_32_1)
	local var_32_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(arg_32_1)
	local var_32_1 = string.splitToNumber(var_32_0.co.surBehavior, "#")
	local var_32_2 = {}
	local var_32_3 = {
		status = var_32_0:getShelterNpcStatus()
	}

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		local var_32_4 = lua_survival_behavior.configDict[iter_32_1]

		if var_32_4 and arg_32_0:isBehaviorMeetCondition(var_32_4.condition, var_32_3) then
			table.insert(var_32_2, var_32_4)
		end
	end

	if #var_32_2 > 1 then
		table.sort(var_32_2, SortUtil.keyUpper("priority"))
	end

	return var_32_2
end

function var_0_0.gotoMonster(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:getScene()

	if not var_33_0 then
		return
	end

	local var_33_1 = var_33_0.unit:getMonsterEntity(arg_33_1)

	if not var_33_1 then
		return
	end

	local var_33_2 = var_33_1.pos
	local var_33_3 = var_33_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_33_3:moveToByPos(arg_33_2 or var_33_2, arg_33_0.interactiveMonster, arg_33_0, arg_33_1, arg_33_3)
end

function var_0_0.interactiveMonster(arg_34_0, arg_34_1)
	local var_34_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_34_0 and var_34_0.fightId == arg_34_1 and var_34_0:canShowEntity() then
		ViewMgr.instance:closeAllPopupViews()
		ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
			showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Normal
		})
	end
end

function var_0_0.isBehaviorMeetCondition(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = GameUtil.splitString2(arg_35_1, false)

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		if not arg_35_0:checkSingleCondition(iter_35_1, arg_35_2) then
			return false
		end
	end

	return true
end

function var_0_0.checkSingleCondition(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1 then
		return true
	end

	if arg_36_1[1] == "NpcStatus" then
		return tonumber(arg_36_1[2]) == arg_36_2.status
	elseif arg_36_1[1] == "unFinishTask" then
		local var_36_0 = tonumber(arg_36_1[2])
		local var_36_1 = tonumber(arg_36_1[3])
		local var_36_2 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_36_0)
		local var_36_3 = var_36_2 and var_36_2:getTaskInfo(var_36_1)

		return var_36_3 and var_36_3:isUnFinish()
	elseif arg_36_1[1] == "unAcceptTask" then
		local var_36_4 = tonumber(arg_36_1[2])
		local var_36_5 = tonumber(arg_36_1[3])
		local var_36_6 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_36_4)

		return (var_36_6 and var_36_6:getTaskInfo(var_36_5)) == nil
	elseif arg_36_1[1] == "finishTask" then
		local var_36_7 = tonumber(arg_36_1[2])
		local var_36_8 = tonumber(arg_36_1[3])
		local var_36_9 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_36_7)
		local var_36_10 = var_36_9 and var_36_9:getTaskInfo(var_36_8)

		return var_36_10 and not var_36_10:isUnFinish() or false
	end

	return true
end

function var_0_0.getLocalShelterEntityPosAndDir(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = SurvivalConfig.instance:getCurShelterMapId()
	local var_37_1, var_37_2 = SurvivalConfig.instance:getLocalShelterEntityPosAndDir(var_37_0, arg_37_1, arg_37_2)

	if not var_37_1 then
		var_37_1, var_37_2 = arg_37_0:getRandomWalkPosAndDir()

		SurvivalConfig.instance:saveLocalShelterEntityPosAndDir(var_37_0, arg_37_1, arg_37_2, var_37_1, var_37_2)
	end

	if arg_37_3 then
		local var_37_3 = SurvivalConfig.instance:getShelterMapCo():getMainBuild()

		if var_37_3 then
			var_37_2 = SurvivalHelper.instance:getDirMustHave(var_37_1, var_37_3.pos)
		end
	end

	return var_37_1, var_37_2
end

function var_0_0.getRandomWalkPosAndDir(arg_38_0)
	local var_38_0 = arg_38_0:getScene()

	if not var_38_0 then
		return
	end

	local var_38_1 = SurvivalConfig.instance:getShelterMapCo().walkables
	local var_38_2 = {}

	if var_38_0 then
		var_38_0.unit:addUsedPos(var_38_2)
	end

	local var_38_3 = {}

	for iter_38_0, iter_38_1 in pairs(var_38_1) do
		for iter_38_2, iter_38_3 in pairs(iter_38_1) do
			if not SurvivalHelper.instance:isHaveNode(var_38_2, iter_38_3) then
				table.insert(var_38_3, iter_38_3)
			end
		end
	end

	if #var_38_3 == 0 then
		return nil
	end

	local var_38_4 = math.random(0, 5)

	return var_38_3[math.random(1, #var_38_3)], var_38_4
end

function var_0_0.getShelterEntity(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:getScene()

	if not var_39_0 then
		return
	end

	return var_39_0.unit:getEntity(arg_39_1, arg_39_2)
end

function var_0_0.addShelterEntity(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_0:getScene()

	if not var_40_0 then
		return
	end

	return var_40_0.unit:addEntity(arg_40_1, arg_40_2, arg_40_3)
end

function var_0_0.getAllShelterEntity(arg_41_0)
	local var_41_0 = arg_41_0:getScene()

	if not var_41_0 then
		return
	end

	return var_41_0.unit:getAllEntity()
end

function var_0_0.hideUnitVisible(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0:getAllShelterEntity()

	for iter_42_0, iter_42_1 in pairs(var_42_0) do
		if iter_42_0 == arg_42_1 and iter_42_1 then
			for iter_42_2, iter_42_3 in pairs(iter_42_1) do
				iter_42_3:setVisible(arg_42_2)
			end
		end
	end
end

function var_0_0.refreshPlayerEntity(arg_43_0)
	local var_43_0 = arg_43_0:getScene()

	if not var_43_0 then
		return
	end

	var_43_0.unit:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
end

function var_0_0.stopShelterPlayerMove(arg_44_0)
	local var_44_0 = arg_44_0:getScene()

	if not var_44_0 then
		return
	end

	local var_44_1 = var_44_0.unit:getPlayer()

	if var_44_1 then
		var_44_1:stopMove()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
