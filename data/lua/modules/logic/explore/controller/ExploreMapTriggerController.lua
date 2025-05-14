module("modules.logic.explore.controller.ExploreMapTriggerController", package.seeall)

local var_0_0 = class("ExploreMapTriggerController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.triggerHandleDic = {
		[ExploreEnum.TriggerEvent.Award] = ExploreTriggerAward,
		[ExploreEnum.TriggerEvent.Story] = ExploreTriggerStory,
		[ExploreEnum.TriggerEvent.ChangeCamera] = ExploreTriggerCameraCO,
		[ExploreEnum.TriggerEvent.ChangeElevator] = ExploreTriggerElevator,
		[ExploreEnum.TriggerEvent.MoveCamera] = ExploreTriggerMoveCamera,
		[ExploreEnum.TriggerEvent.Guide] = ExploreTriggerGuide,
		[ExploreEnum.TriggerEvent.Rotate] = ExploreTriggerRotate,
		[ExploreEnum.TriggerEvent.Dialogue] = ExploreTriggerDialogue,
		[ExploreEnum.TriggerEvent.ItemUnit] = ExploreTriggerItem,
		[ExploreEnum.TriggerEvent.Spike] = ExploreTriggerSpike,
		[ExploreEnum.TriggerEvent.OpenArchiveView] = ExploreTriggerOpenArchiveView,
		[ExploreEnum.TriggerEvent.Audio] = ExploreTriggerPlayAudio,
		[ExploreEnum.TriggerEvent.BubbleDialogue] = ExploreTriggerBubbleDialogue,
		[ExploreEnum.TriggerEvent.HeroPlayAnim] = ExploreTriggerHeroPlayAnim
	}
	arg_1_0._triggerflowPool = LuaObjPool.New(5, function()
		return BaseExploreSequence.New()
	end, function(arg_3_0)
		arg_3_0:dispose()
	end, function()
		return
	end)
	arg_1_0._usingTriggerflowDic = {}
	arg_1_0._triggerHandlePoolDic = {}
end

function var_0_0.onInitFinish(arg_5_0)
	return
end

function var_0_0.addConstEvents(arg_6_0)
	ExploreController.instance:registerCallback(ExploreEvent.TryTriggerUnit, arg_6_0._tryTriggerUnit, arg_6_0)
	ExploreController.instance:registerCallback(ExploreEvent.TryCancelTriggerUnit, arg_6_0._tryCancelTriggerUnit, arg_6_0)
end

function var_0_0.reInit(arg_7_0)
	arg_7_0._triggerflowPool:dispose()
end

function var_0_0.getFlow(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._usingTriggerflowDic[arg_8_1]

	if var_8_0 == nil then
		var_8_0 = arg_8_0._triggerflowPool:getObject()
	end

	arg_8_0._usingTriggerflowDic[arg_8_1] = var_8_0

	return var_8_0
end

function var_0_0.releaseFlow(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._usingTriggerflowDic[arg_9_1]

	arg_9_0._triggerflowPool:putObject(var_9_0)

	arg_9_0._usingTriggerflowDic[arg_9_1] = nil
end

function var_0_0.getTriggerHandle(arg_10_0, arg_10_1)
	if arg_10_0.triggerHandleDic[arg_10_1] then
		local var_10_0 = arg_10_0._triggerHandlePoolDic[arg_10_1]

		if var_10_0 == nil then
			var_10_0 = LuaObjPool.New(5, function()
				return arg_10_0.triggerHandleDic[arg_10_1].New()
			end, function(arg_12_0)
				arg_12_0:clearWork()
			end, function()
				return
			end)
			arg_10_0._triggerHandlePoolDic[arg_10_1] = var_10_0
		end

		return var_10_0:getObject()
	end
end

function var_0_0.registerMap(arg_14_0, arg_14_1)
	arg_14_0._map = arg_14_1
end

function var_0_0.unRegisterMap(arg_15_0, arg_15_1)
	if arg_15_0._map == arg_15_1 then
		arg_15_0._map = nil
	end
end

function var_0_0.getMap(arg_16_0)
	return arg_16_0._map
end

function var_0_0._tryCancelTriggerUnit(arg_17_0, arg_17_1)
	if not arg_17_0._map:isInitDone() then
		return
	end

	local var_17_0 = arg_17_0._map:getUnit(arg_17_1)

	if var_17_0 then
		var_17_0:cancelTrigger()
	end
end

function var_0_0._tryTriggerUnit(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._map:isInitDone() then
		return
	end

	local var_18_0 = arg_18_0._map:getUnit(arg_18_1)

	if var_18_0 then
		local var_18_1 = ExploreModel.instance:getCarryUnit()

		if not arg_18_2 and var_18_1 and (not isTypeOf(var_18_0, ExplorePipeEntranceUnit) or var_18_0.mo:getColor() ~= ExploreEnum.PipeColor.None) then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantTrigger)

			return
		end

		local var_18_2 = {}

		if var_18_0.mo.isCanMove and not var_18_0.mo:isInteractFinishState() then
			table.insert(var_18_2, ExploreInteractOptionMO.New(luaLang("explore_op_move"), arg_18_0._beginMoveUnit, arg_18_0, var_18_0))
		end

		if not var_18_0.mo:isInteractEnabled() and var_18_0:getFixItemId() then
			table.insert(var_18_2, ExploreInteractOptionMO.New(luaLang("explore_op_fix"), arg_18_0._beginFixUnit, arg_18_0, var_18_0))
		end

		if var_18_0:canTrigger() then
			table.insert(var_18_2, ExploreInteractOptionMO.New(luaLang("explore_op_interact"), arg_18_0._beginTriggerUnit, arg_18_0, var_18_0, arg_18_2))
		end

		local var_18_3 = #var_18_2

		if var_18_3 == 1 then
			var_18_2[1].optionCallBack(var_18_2[1].optionCallObj, var_18_2[1].unit, var_18_2[1].isClient)
		elseif var_18_3 > 1 then
			ViewMgr.instance:openView(ViewName.ExploreInteractOptionView, var_18_2)
		end
	end
end

function var_0_0._beginMoveUnit(arg_19_0, arg_19_1)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetMoveUnit, arg_19_1)
end

function var_0_0._beginFixUnit(arg_20_0, arg_20_1)
	local var_20_0 = ExploreBackpackModel.instance:getItem(arg_20_1:getFixItemId())

	if not var_20_0 then
		ToastController.instance:showToast(ExploreConstValue.Toast.NoItem)

		return
	end

	local var_20_1 = ExploreController.instance:getMap():getHero()

	var_20_1:onCheckDir(var_20_1.nodePos, arg_20_1.nodePos)
	var_20_1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Fix, true, true)
	var_20_1.uiComp:addUI(ExploreRoleFixView):setFixUnit(arg_20_1)
	ExploreRpc.instance:sendExploreUseItemRequest(var_20_0.id, 0, 0, arg_20_1.id)

	local var_20_2, var_20_3, var_20_4, var_20_5 = ExploreConfig.instance:getUnitEffectConfig(arg_20_1:getResPath(), "fix")

	ExploreHelper.triggerAudio(var_20_4, var_20_5, arg_20_1.go)
end

function var_0_0._beginTriggerUnit(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:getUnitType()
	local var_21_1 = arg_21_1:tryTrigger()

	if var_21_0 ~= ExploreEnum.ItemType.Bonus then
		local var_21_2 = ExploreController.instance:getMap():getHero()

		if not arg_21_2 and ExploreHelper.getDistance(var_21_2.nodePos, arg_21_1.nodePos) == 1 then
			var_21_2:onCheckDir(var_21_2.nodePos, arg_21_1.nodePos)
		end

		if var_21_1 then
			local var_21_3 = ExploreAnimEnum.RoleAnimStatus.Interact

			if var_21_0 == ExploreEnum.ItemType.StoneTable or isTypeOf(arg_21_1, ExploreItemUnit) then
				var_21_3 = ExploreAnimEnum.RoleAnimStatus.CreateUnit
			end

			var_21_2:setHeroStatus(var_21_3, true, true)
		end
	end
end

function var_0_0.triggerUnit(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._map:isInitDone() == false then
		return
	end

	local var_22_0 = arg_22_1.id
	local var_22_1 = arg_22_0:getFlow(var_22_0)

	var_22_1:buildFlow()

	local var_22_2 = true
	local var_22_3 = arg_22_1:getUnitType()

	if var_22_3 == ExploreEnum.ItemType.BonusScene then
		local var_22_4 = ExploreTriggerBonusScene.New()

		var_22_4:setParam(nil, arg_22_1, 0, arg_22_2)
		var_22_1:addWork(var_22_4)
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_1:getExploreUnitMO().triggerEffects) do
		local var_22_5 = iter_22_1[1]
		local var_22_6 = arg_22_0:getTriggerHandle(var_22_5)

		if var_22_6 then
			var_22_6:setParam(iter_22_1[2], arg_22_1, iter_22_0, arg_22_2)

			if var_22_5 == ExploreEnum.TriggerEvent.Dialogue then
				if var_22_2 then
					var_22_2 = false
				else
					var_22_6.isNoFirstDialog = true
				end
			end

			var_22_1:addWork(var_22_6)
		end
	end

	if not ExploreEnum.ServerTriggerType[var_22_3] and arg_22_1.mo.triggerByClick or arg_22_1:getUnitType() == ExploreEnum.ItemType.Reset then
		local var_22_7 = ExploreTriggerNormal.New()

		var_22_7:setParam(nil, arg_22_1, 0, arg_22_2)
		var_22_1:addWork(var_22_7)
	end

	var_22_1:start(function(arg_23_0)
		if arg_23_0 then
			arg_22_0:triggerDone(var_22_0)
		end
	end)
end

function var_0_0.triggerDone(arg_24_0, arg_24_1)
	arg_24_0:releaseFlow(arg_24_1)
	arg_24_0:doDoneTrigger(arg_24_1)
end

function var_0_0.setDonePerformance(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1:getExploreUnitMO().doneEffects) do
		local var_25_0 = arg_25_0:getTriggerHandle(iter_25_1[1])

		if var_25_0 then
			var_25_0:setParam(iter_25_1[2], arg_25_1)
			var_25_0:onStart()
		else
			logError("Explore triggerHandle not find:", arg_25_1.id, iter_25_1[1])
		end
	end
end

function var_0_0.doDoneTrigger(arg_26_0, arg_26_1)
	if not arg_26_0._map then
		return
	end

	local var_26_0 = arg_26_0._map:getUnit(arg_26_1, true)

	if not var_26_0 then
		return
	end

	var_26_0:getExploreUnitMO().hasInteract = true

	local var_26_1 = arg_26_0:getFlow(arg_26_1)

	var_26_1:buildFlow()

	for iter_26_0, iter_26_1 in ipairs(var_26_0:getExploreUnitMO().doneEffects) do
		local var_26_2 = arg_26_0:getTriggerHandle(iter_26_1[1])

		if var_26_2 then
			var_26_2:setParam(iter_26_1[2], var_26_0)
			var_26_1:addWork(var_26_2)
		end
	end

	var_26_1:start(function()
		var_26_0:onTriggerDone()
		arg_26_0:releaseFlow(arg_26_1)
	end)
end

function var_0_0.triggerEvent(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getTriggerHandle(arg_28_1)

	if var_28_0 then
		var_28_0:handle(arg_28_2)
	end
end

function var_0_0.cancelTriggerEvent(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:getTriggerHandle(arg_29_1)

	if var_29_0 then
		var_29_0:setParam(arg_29_2, arg_29_3)
		var_29_0:cancel(arg_29_2)
	end
end

function var_0_0.cancelTrigger(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0._map:isInitDone() == false then
		return
	end

	local var_30_0 = arg_30_1.id
	local var_30_1 = arg_30_0:getFlow(var_30_0)

	var_30_1:buildFlow()

	for iter_30_0, iter_30_1 in ipairs(arg_30_1:getExploreUnitMO().triggerEffects) do
		local var_30_2 = arg_30_0:getTriggerHandle(iter_30_1[1])

		if var_30_2 then
			var_30_2:setParam(iter_30_1[2], arg_30_1, iter_30_0, arg_30_2, true)
			var_30_1:addWork(var_30_2)
		end
	end

	var_30_1:start(function(arg_31_0)
		arg_30_0:releaseFlow(var_30_0)
		arg_30_1:onTriggerDone()
	end)
end

var_0_0.instance = var_0_0.New()

return var_0_0
