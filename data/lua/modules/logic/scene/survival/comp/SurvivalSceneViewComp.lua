module("modules.logic.scene.survival.comp.SurvivalSceneViewComp", package.seeall)

local var_0_0 = class("SurvivalSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	if not SurvivalMapModel.instance.isFightEnter or not arg_1_0._beginDt then
		arg_1_0._beginDt = ServerTime.now()
	end

	SurvivalMapModel.instance.isFightEnter = false

	ViewMgr.instance:openView(ViewName.SurvivalMapMainView)

	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	if var_1_0.battleInfo.status ~= SurvivalEnum.FightStatu.None then
		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.FightBack, "")
	else
		SurvivalMapHelper.instance:tryShowServerPanel(var_1_0.panel)
	end

	TaskDispatcher.runDelay(arg_1_0._processGuideEvent, arg_1_0, 0.3)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._processGuideEvent, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_1_0._onAttrUpdate, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.onFlowEnd, arg_1_0._processGuideEvent, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_1_0._processGuideEvent, arg_1_0)
end

function var_0_0._onAttrUpdate(arg_2_0, arg_2_1)
	if arg_2_1 == SurvivalEnum.AttrType.HeroFightLevel then
		SurvivalMapModel.instance.isFightLvUp = true

		arg_2_0:_processGuideEvent()
	end
end

function var_0_0._processGuideEvent(arg_3_0)
	if ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	}) and not SurvivalMapHelper.instance:isInFlow() then
		local var_3_0 = false
		local var_3_1 = false
		local var_3_2 = SurvivalMapModel.instance:getSceneMo()

		for iter_3_0, iter_3_1 in ipairs(var_3_2.bag.items) do
			if iter_3_1.equipCo then
				var_3_0 = true
			end

			if iter_3_1.co and iter_3_1.co.type == SurvivalEnum.ItemType.Quick then
				var_3_1 = true
			end
		end

		if var_3_0 and not arg_3_0:isGuideLock() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitHaveEquip)
		end

		if var_3_1 and not arg_3_0:isGuideLock() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitHaveQuickItem)
		end

		local var_3_3 = false

		for iter_3_2, iter_3_3 in ipairs(var_3_2.safeZone) do
			if var_3_2.gameTime >= iter_3_3.startTime and var_3_2.gameTime <= iter_3_3.endTime then
				var_3_3 = true

				break
			end
		end

		if var_3_3 and not arg_3_0:isGuideLock() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitInCircle)
		end

		if SurvivalMapModel.instance.isHealthSub and not arg_3_0:isGuideLock() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitHealthSub)
		end

		if SurvivalMapModel.instance.isFightLvUp and not arg_3_0:isGuideLock() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitFightLvUp)
		end

		if SurvivalMapModel.instance.isGetTalent and not arg_3_0:isGuideLock() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitTalentGet)
		end
	end
end

function var_0_0.isGuideLock(arg_4_0)
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SurvivalGuideLock)
end

function var_0_0.onSceneClose(arg_5_0, arg_5_1, arg_5_2)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_5_0._processGuideEvent, arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_5_0._onAttrUpdate, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._processGuideEvent, arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.onFlowEnd, arg_5_0._processGuideEvent, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._processGuideEvent, arg_5_0)
	ViewMgr.instance:closeView(ViewName.SurvivalMapMainView)
	ViewMgr.instance:closeView(ViewName.SurvivalToastView)
	ViewMgr.instance:closeAllPopupViews()

	if GameSceneMgr.instance:getNextSceneType() ~= SceneType.Fight then
		local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()
		local var_5_1 = "settle"

		if var_5_0 and var_5_0.inSurvival then
			var_5_1 = "topleft"
		end

		SurvivalStatHelper.instance:statMapClose(ServerTime.now() - arg_5_0._beginDt, var_5_1)
	end
end

return var_0_0
