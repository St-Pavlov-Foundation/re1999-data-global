module("modules.logic.survival.controller.work.step.SurvivalUnitMoveWork", package.seeall)

local var_0_0 = class("SurvivalUnitMoveWork", SurvivalStepBaseWork)
local var_0_1 = {
	[SurvivalEnum.PlayerMoveReason.Fly] = "flyTo",
	[SurvivalEnum.PlayerMoveReason.Transfer] = "transferTo",
	[SurvivalEnum.PlayerMoveReason.Tornado] = "tornadoTransfer",
	[SurvivalEnum.PlayerMoveReason.Swap] = "swapPos",
	[SurvivalEnum.PlayerMoveReason.Summon] = "summonPos"
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0.context.fastExecute then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = SurvivalMapHelper.instance:getEntity(arg_1_0._stepMo.id)

	if var_1_0 then
		local var_1_1 = arg_1_0._stepMo.paramInt[1] or 0
		local var_1_2 = SurvivalMapModel.instance:getSceneMo()
		local var_1_3 = var_1_0[var_0_1[var_1_1]] or var_1_0.moveTo

		if arg_1_0._stepMo.id == 0 then
			if var_1_1 ~= SurvivalEnum.PlayerMoveReason.Normal then
				if var_1_1 ~= SurvivalEnum.PlayerMoveReason.Back then
					SurvivalMapModel.instance:setMoveToTarget(nil)

					arg_1_1.tryTrigger = true
				end
			else
				for iter_1_0, iter_1_1 in pairs(var_1_2.unitsById) do
					if not iter_1_1.fall and iter_1_1:isPointInWarming(arg_1_0._stepMo.position) then
						SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, iter_1_1.id, 2, 0.2)
					end
				end
			end

			ViewMgr.instance:closeAllPopupViews()
			var_1_3(var_1_0, arg_1_0._stepMo.position, arg_1_0._stepMo.dir, arg_1_0._onMoveFinish, arg_1_0)
		else
			if var_1_1 == SurvivalEnum.PlayerMoveReason.Normal then
				local var_1_4 = var_1_2.unitsById[arg_1_0._stepMo.id]

				if var_1_4 and var_1_2:getBlockTypeByPos(var_1_4.pos) == SurvivalEnum.UnitSubType.Miasma then
					SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, var_1_4.id, 1, 0.2)
				end
			end

			local var_1_5 = ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
				ViewName.SurvivalToastView,
				ViewName.SurvivalCommonTipsView,
				ViewName.GuideView,
				ViewName.GuideView2,
				ViewName.GuideStepEditor
			})

			var_1_3(var_1_0, arg_1_0._stepMo.position, arg_1_0._stepMo.dir, var_1_5 and arg_1_0._onMoveFinish, var_1_5 and arg_1_0)

			if not var_1_5 then
				arg_1_0:onDone(true)
			end
		end
	else
		local var_1_6 = SurvivalMapModel.instance:getSceneMo()
		local var_1_7 = var_1_6 and var_1_6.unitsById[arg_1_0._stepMo.id]

		if not var_1_7 then
			logError("找不到对应实体" .. arg_1_0._stepMo.id)
		else
			var_1_6:onUnitUpdatePos(var_1_7, arg_1_0._stepMo.position)
		end

		arg_1_0:onDone(true)
	end
end

function var_0_0._onMoveFinish(arg_2_0)
	if arg_2_0._stepMo.id == 0 then
		local var_2_0 = SurvivalMapHelper.instance:getSceneCameraComp()

		if var_2_0 and var_2_0:checkIsInMiasma() then
			arg_2_0:doRotateCameraTween()

			return
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0.doRotateCameraTween(arg_3_0)
	if SurvivalMapModel.instance:getTargetPos() ~= arg_3_0._stepMo.position then
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()
	end

	if SurvivalMapHelper.instance:tweenToHeroPosIfNeed(0.2) then
		TaskDispatcher.runDelay(arg_3_0._playCameraRotate, arg_3_0, 0.2)
	else
		arg_3_0:_playCameraRotate()
	end
end

function var_0_0._playCameraRotate(arg_4_0)
	local var_4_0 = SurvivalMapHelper.instance:getSceneCameraComp()

	if var_4_0 then
		UIBlockHelper.instance:startBlock("SurvivalUnitMoveWork_playCameraRotate", SurvivalConst.CameraTraceTime)

		local var_4_1 = SurvivalMapModel.instance:isInMiasma() and math.random(5) or 0

		if var_4_1 > 2 then
			var_4_1 = var_4_1 - 6
		end

		var_4_0:setRotate(var_4_1 * 60)
		TaskDispatcher.runDelay(arg_4_0._delayOnDone, arg_4_0, SurvivalConst.CameraTraceTime)
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0._delayOnDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._playCameraRotate, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayOnDone, arg_6_0)
end

function var_0_0.getRunOrder(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1.moveIdSet[arg_7_0._stepMo.id] then
		arg_7_1.beforeFlow = FlowParallel.New()

		arg_7_2:addWork(arg_7_1.beforeFlow)

		arg_7_1.moveIdSet = {}
	end

	if arg_7_0._stepMo.id == 0 then
		arg_7_1.haveHeroMove = true
	end

	arg_7_1.moveIdSet[arg_7_0._stepMo.id] = true

	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
