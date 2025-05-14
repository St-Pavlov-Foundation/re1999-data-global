module("modules.logic.fight.system.work.FightWorkEffectDistributeCard", package.seeall)

local var_0_0 = class("FightWorkEffectDistributeCard", FightEffectBase)

var_0_0.handCardScale = 0.52
var_0_0.handCardScaleTime = 0.25

function var_0_0.getHandCardScaleTime()
	return var_0_0.handCardScaleTime / FightModel.instance:getUISpeed()
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_registTimer(arg_2_0._delayDone, 20)

	if FightCardModel.instance:isDissolving() then
		FightController.instance:registerCallback(FightEvent.OnDissolveCombineEnd, arg_2_0._onDissolveCombineEnd, arg_2_0)

		local var_2_0 = FightModel.instance:getUISpeed()
		local var_2_1 = 10 / Mathf.Clamp(var_2_0, 0.01, 100)

		TaskDispatcher.runDelay(arg_2_0._dissolveTimeout, arg_2_0, var_2_1)
	else
		TaskDispatcher.runDelay(arg_2_0._delayDistribute, arg_2_0, 0.01)
	end
end

function var_0_0._onDissolveCombineEnd(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, arg_3_0._onDissolveCombineEnd, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._dissolveTimeout, arg_3_0)
	arg_3_0:_delayDistribute()
end

function var_0_0._dissolveTimeout(arg_4_0)
	logError("溶牌超时，继续发牌")
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, arg_4_0._onDissolveCombineEnd, arg_4_0)
	arg_4_0:_delayDistribute()
end

function var_0_0._delayDistribute(arg_5_0)
	local var_5_0 = FightModel.instance:getCurRoundMO()

	if not var_5_0 then
		logError("回合数据不存在")
		arg_5_0:onDone(false)

		return
	end

	FightController.instance:setCurStage(FightEnum.Stage.FillCard)

	if arg_5_0._actEffectMO.effectType == FightEnum.EffectType.DEALCARD2 then
		local var_5_1 = var_5_0.beforeCards2
		local var_5_2 = var_5_0.teamACards2

		if #var_5_1 > 0 or #var_5_2 > 0 then
			FightCardModel.instance:clearDistributeQueue()
			FightCardModel.instance:enqueueDistribute(var_5_1, var_5_2)
			FightController.instance:registerCallback(FightEvent.OnDistributeCards, arg_5_0._distributeDone, arg_5_0)
			FightViewPartVisible.set(false, true, false, false, false)
			FightController.instance:dispatchEvent(FightEvent.DistributeCards)
		else
			arg_5_0:_distributeDone()
		end
	else
		arg_5_0:onDone(true)
	end
end

function var_0_0._distributeDone(arg_6_0)
	FightController.instance:setCurStage(FightEnum.Stage.Play)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_6_0._distributeDone, arg_6_0)

	local var_6_0 = FightViewHandCard.handCardContainer
	local var_6_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	local var_6_2 = arg_6_0:_checkHasEnemySkill()

	if not gohelper.isNil(var_6_0) and #var_6_1 > 0 and var_6_2 then
		FightViewPartVisible.set(false, true, false, true, false)

		local var_6_3 = var_0_0.handCardScale
		local var_6_4 = var_0_0.getHandCardScaleTime()

		ZProj.TweenHelper.DOScale(var_6_0.transform, var_6_3, var_6_3, var_6_3, var_6_4, arg_6_0._onHandCardsShrink, arg_6_0)
	else
		arg_6_0:_onHandCardsShrink()
	end
end

function var_0_0._checkHasEnemySkill(arg_7_0)
	local var_7_0 = FightModel.instance:getCurRoundMO()
	local var_7_1 = false

	for iter_7_0, iter_7_1 in ipairs(var_7_0.fightStepMOs) do
		if not var_7_1 and iter_7_1.actType == FightEnum.ActType.EFFECT then
			for iter_7_2, iter_7_3 in ipairs(iter_7_1.actEffectMOs) do
				if iter_7_3.effectType == FightEnum.EffectType.DEALCARD2 then
					var_7_1 = true

					break
				end
			end
		elseif var_7_1 and iter_7_1.actType == FightEnum.ActType.SKILL then
			local var_7_2 = FightHelper.getEntity(iter_7_1.fromId)

			if var_7_2 and var_7_2:isEnemySide() then
				return true
			end
		end
	end

	return false
end

function var_0_0._onHandCardsShrink(arg_8_0)
	arg_8_0:onDone(true)
end

function var_0_0.clearWork(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayDistribute, arg_9_0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_9_0._distributeDone, arg_9_0)
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, arg_9_0._onDissolveCombineEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._dissolveTimeout, arg_9_0)
end

function var_0_0._delayDone(arg_10_0)
	arg_10_0:onDone(true)
end

return var_0_0
