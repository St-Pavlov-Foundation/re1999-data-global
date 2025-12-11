module("modules.logic.scene.survival.comp.SurvivalSceneViewComp", package.seeall)

local var_0_0 = class("SurvivalSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	if not SurvivalMapModel.instance.isFightEnter or not arg_1_0._beginDt then
		arg_1_0._beginDt = ServerTime.now()
	end

	SurvivalMapModel.instance.isFightEnter = false

	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	if var_1_0.battleInfo.status ~= SurvivalEnum.FightStatu.None then
		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.FightBack, "")
	else
		SurvivalMapHelper.instance:tryShowServerPanel(var_1_0.panel)
	end

	TaskDispatcher.runDelay(arg_1_0._processGuideEvent, arg_1_0, 0.3)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._processGuideEvent, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.onFlowEnd, arg_1_0._processGuideEvent, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_1_0._processGuideEvent, arg_1_0)
end

function var_0_0._processGuideEvent(arg_2_0)
	if ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
		ViewName.SurvivalToastView,
		ViewName.SurvivalCommonTipsView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	}) and not SurvivalMapHelper.instance:isInFlow() then
		if not arg_2_0:isGuideLock() and arg_2_0:isHaveEquip() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitHaveEquip)
		end

		if not arg_2_0:isGuideLock() and arg_2_0:isInSpRain() then
			local var_2_0 = SurvivalMapModel.instance:getSceneMo()

			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitSpRain, tostring(var_2_0._mapInfo.rainCo.type))
		end

		if not arg_2_0:isGuideLock() then
			arg_2_0:processSpBlockGuide()
		end
	end
end

function var_0_0.isHaveEquip(arg_3_0)
	local var_3_0 = false
	local var_3_1 = SurvivalMapHelper.instance:getBagMo()

	for iter_3_0, iter_3_1 in ipairs(var_3_1.items) do
		if iter_3_1.equipCo then
			var_3_0 = true

			break
		end
	end

	return var_3_0
end

function var_0_0.isInSpRain(arg_4_0)
	local var_4_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_4_0._mapInfo.rainCo then
		return false
	end

	return var_4_0._mapInfo.rainCo.type ~= 1
end

function var_0_0.processSpBlockGuide(arg_5_0)
	local var_5_0 = SurvivalMapModel.instance:getSceneMo()

	for iter_5_0, iter_5_1 in ipairs(SurvivalHelper.instance:getAllPointsByDis(var_5_0.player.pos, 2)) do
		local var_5_1 = var_5_0:getBlockTypeByPos(iter_5_1)

		if var_5_1 and var_5_1 ~= SurvivalEnum.UnitSubType.Block then
			SurvivalMapModel.instance.guideSpBlockPos = iter_5_1:clone()

			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitSpBlock, tostring(var_5_1))
		end

		if arg_5_0:isGuideLock() then
			return
		end
	end
end

function var_0_0.isGuideLock(arg_6_0)
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SurvivalGuideLock)
end

function var_0_0.onSceneClose(arg_7_0, arg_7_1, arg_7_2)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_7_0._processGuideEvent, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_7_0._processGuideEvent, arg_7_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.onFlowEnd, arg_7_0._processGuideEvent, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._processGuideEvent, arg_7_0)
	ViewMgr.instance:closeView(ViewName.SurvivalMapMainView)
	ViewMgr.instance:closeView(ViewName.SurvivalToastView)
	ViewMgr.instance:closeAllPopupViews()

	if GameSceneMgr.instance:getNextSceneType() ~= SceneType.Fight then
		local var_7_0 = SurvivalShelterModel.instance:getWeekInfo()
		local var_7_1 = "settle"

		if var_7_0 and var_7_0.inSurvival then
			var_7_1 = "topleft"
		end

		SurvivalStatHelper.instance:statMapClose(ServerTime.now() - arg_7_0._beginDt, var_7_1)
	end
end

return var_0_0
