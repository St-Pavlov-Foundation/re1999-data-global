module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractHandleBase", package.seeall)

local var_0_0 = class("YaXianInteractHandleBase")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._interactObject = arg_1_1
end

function var_0_0.onSelectCall(arg_2_0)
	return
end

function var_0_0.onCancelSelect(arg_3_0)
	return
end

function var_0_0.onSelectPos(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.onAvatarLoaded(arg_5_0)
	arg_5_0:faceTo(arg_5_0._interactObject.interactMo.direction)
end

function var_0_0.faceTo(arg_6_0, arg_6_1)
	arg_6_0._interactObject.interactMo:setDirection(arg_6_1)

	if arg_6_0._interactObject:isDelete() then
		return
	end

	if not arg_6_0._interactObject.directionAvatarDict then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0._interactObject.directionAvatarDict) do
		gohelper.setActive(iter_6_1, iter_6_0 == arg_6_1)
	end
end

function var_0_0.moveTo(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == arg_7_0._interactObject.interactMo.posX and arg_7_2 == arg_7_0._interactObject.interactMo.posY then
		if arg_7_0.stepData then
			arg_7_0:faceTo(arg_7_0.stepData.direction)
		end

		if arg_7_3 then
			return arg_7_3(arg_7_4)
		end

		return
	end

	if arg_7_0._interactObject:isDelete() then
		if arg_7_3 then
			arg_7_0._interactObject.interactMo:setXY(arg_7_1, arg_7_2)

			if arg_7_0.stepData then
				arg_7_0:faceTo(arg_7_0.stepData.direction)
			end

			return arg_7_3(arg_7_4)
		end

		return
	end

	arg_7_0._moveCallback = arg_7_3
	arg_7_0._moveCallbackObj = arg_7_4

	local var_7_0 = arg_7_0._interactObject.interactMo
	local var_7_1 = YaXianGameHelper.getDirection(var_7_0.posX, var_7_0.posY, arg_7_1, arg_7_2)

	arg_7_0:faceTo(var_7_1)
	var_7_0:setXY(arg_7_1, arg_7_2)

	if arg_7_0.stepData and arg_7_0.stepData.assassinateSourceStep then
		arg_7_0:handleAssassinate()

		return
	end

	local var_7_2, var_7_3, var_7_4 = YaXianGameHelper.calcTilePosInScene(arg_7_1, arg_7_2)

	arg_7_0:killMoveTween()

	arg_7_0.moveWork = YaXianInteractMoveWork.New({
		transform = arg_7_0._interactObject.interactItemContainerTr,
		targetX = var_7_2,
		targetY = var_7_3,
		targetZ = var_7_4,
		isPlayer = arg_7_0._interactObject:isPlayer(),
		interactMo = var_7_0
	})

	arg_7_0.moveWork:registerDoneListener(arg_7_0.onMoveCompleted, arg_7_0)
	arg_7_0.moveWork:onStart()
end

function var_0_0.handleAssassinate(arg_8_0)
	local var_8_0 = YaXianGameController.instance.stepMgr:getStepData(arg_8_0.stepData.deleteStepIndex)
	local var_8_1 = var_8_0 and var_8_0.id or 0
	local var_8_2 = YaXianGameController.instance:getInteractItem(var_8_1)
	local var_8_3 = var_8_0 and var_8_0.sourceId or 0
	local var_8_4 = YaXianGameController.instance:getInteractItem(var_8_3)

	arg_8_0:stopFlow()

	arg_8_0.flow = FlowSequence.New()

	local var_8_5 = arg_8_0._interactObject.interactMo.posX
	local var_8_6 = arg_8_0._interactObject.interactMo.posY
	local var_8_7 = arg_8_0._interactObject.interactMo.prePosX
	local var_8_8 = arg_8_0._interactObject.interactMo.prePosY

	if var_8_2.interactMo.posX ~= var_8_4.interactMo.posX or var_8_2.interactMo.posY ~= var_8_4.interactMo.posY then
		local var_8_9, var_8_10, var_8_11 = YaXianGameHelper.calcTilePosInScene(var_8_5, var_8_6)

		arg_8_0.flow:addWork(YaXianInteractMoveWork.New({
			transform = arg_8_0._interactObject.interactItemContainerTr,
			targetX = var_8_9,
			targetY = var_8_10,
			targetZ = var_8_11,
			isPlayer = arg_8_0._interactObject:isPlayer(),
			interactMo = arg_8_0._interactObject.interactMo
		}))
		arg_8_0.flow:addWork(YaXianInteractEffectWork.New(var_8_1, YaXianGameEnum.EffectType.Assassinate))
		arg_8_0.flow:addWork(YaXianInteractEffectWork.New(var_8_1, YaXianGameEnum.EffectType.Die))
		arg_8_0.flow:addWork(YaXianInteractEffectWork.New(var_8_3, YaXianGameEnum.EffectType.FightSuccess))
	else
		local var_8_12 = YaXianGameHelper.getDirection(var_8_7, var_8_8, var_8_5, var_8_6)
		local var_8_13 = YaXianGameEnum.OppositeDirection[var_8_12]
		local var_8_14, var_8_15, var_8_16 = YaXianGameHelper.calBafflePosInScene(var_8_5, var_8_6, var_8_13)

		arg_8_0.flow:addWork(YaXianInteractMoveWork.New({
			transform = arg_8_0._interactObject.interactItemContainerTr,
			targetX = var_8_14,
			targetY = var_8_15,
			targetZ = var_8_16,
			isPlayer = arg_8_0._interactObject:isPlayer(),
			interactMo = arg_8_0._interactObject.interactMo
		}))

		local var_8_17

		if var_8_1 == arg_8_0._interactObject.id then
			var_8_17 = var_8_4
		else
			var_8_17 = var_8_2
		end

		local var_8_18, var_8_19, var_8_20 = YaXianGameHelper.calBafflePosInScene(var_8_5, var_8_6, var_8_12)

		arg_8_0.flow:addWork(YaXianInteractMoveWork.New({
			transform = var_8_17.interactItemContainerTr,
			targetX = var_8_18,
			targetY = var_8_19,
			targetZ = var_8_20
		}))
		arg_8_0.flow:addWork(YaXianInteractEffectWork.New(var_8_1, YaXianGameEnum.EffectType.Assassinate))

		local var_8_21 = FlowParallel.New()

		var_8_21:addWork(YaXianInteractEffectWork.New(var_8_1, YaXianGameEnum.EffectType.Die))

		local var_8_22, var_8_23, var_8_24 = YaXianGameHelper.calcTilePosInScene(var_8_5, var_8_6)

		var_8_21:addWork(YaXianInteractMoveWork.New({
			transform = var_8_4.interactItemContainerTr,
			targetX = var_8_22,
			targetY = var_8_23,
			targetZ = var_8_24
		}))
		arg_8_0.flow:addWork(var_8_21)
		arg_8_0.flow:addWork(YaXianInteractEffectWork.New(var_8_3, YaXianGameEnum.EffectType.FightSuccess))
	end

	arg_8_0.flow:registerDoneListener(arg_8_0.onMoveCompleted, arg_8_0)
	arg_8_0.flow:start()
end

function var_0_0.onMoveCompleted(arg_9_0)
	arg_9_0:killMoveTween()
	arg_9_0:stopFlow()

	if arg_9_0.stepData and arg_9_0._interactObject.interactMo.direction ~= arg_9_0.stepData.direction then
		TaskDispatcher.runDelay(arg_9_0.doMoveCallback, arg_9_0, YaXianGameEnum.SwitchDirectionDelay)

		return
	end

	arg_9_0:doMoveCallback()
end

function var_0_0.doMoveCallback(arg_10_0)
	if arg_10_0.stepData then
		arg_10_0:faceTo(arg_10_0.stepData.direction)

		arg_10_0.stepData = nil
	end

	if arg_10_0._interactObject:isPlayer() then
		local var_10_0 = YaXianGameModel.instance:getExitInteractMo()

		if arg_10_0._interactObject.interactMo.posX == var_10_0.posX and arg_10_0._interactObject.interactMo.posY == var_10_0.posY then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
		end
	end

	if arg_10_0._moveCallback then
		local var_10_1 = arg_10_0._moveCallback
		local var_10_2 = arg_10_0._moveCallbackObj

		arg_10_0._moveCallback = nil
		arg_10_0._moveCallbackObj = nil

		return var_10_1(var_10_2)
	end
end

function var_0_0.killMoveTween(arg_11_0)
	if arg_11_0.moveWork then
		arg_11_0.moveWork:onDestroy()

		arg_11_0.moveWork = nil
	end
end

function var_0_0.moveToFromMoveStep(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.stepData = arg_12_1

	arg_12_0:moveTo(arg_12_0.stepData.x, arg_12_0.stepData.y, arg_12_2, arg_12_3)
end

function var_0_0.stopFlow(arg_13_0)
	if arg_13_0.flow then
		arg_13_0.flow:destroy()

		arg_13_0.flow = nil
	end
end

function var_0_0.stopAllAction(arg_14_0)
	arg_14_0:stopFlow()
	arg_14_0:killMoveTween()
	TaskDispatcher.cancelTask(arg_14_0.doMoveCallback, arg_14_0)
end

function var_0_0.dispose(arg_15_0)
	arg_15_0:stopAllAction()
end

return var_0_0
