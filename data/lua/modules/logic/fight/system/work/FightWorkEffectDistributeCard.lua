module("modules.logic.fight.system.work.FightWorkEffectDistributeCard", package.seeall)

local var_0_0 = class("FightWorkEffectDistributeCard", FightEffectBase)

var_0_0.handCardScale = 0.52
var_0_0.handCardScaleTime = 0.25

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.skipAutoPlayData = true
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_registTimer(arg_2_0._delayDone, 20)
	TaskDispatcher.runDelay(arg_2_0._delayDistribute, arg_2_0, 0.01)
end

function var_0_0._delayDistribute(arg_3_0)
	if not FightDataHelper.roundMgr:getRoundData() then
		logError("回合数据不存在")
		arg_3_0:onDone(false)

		return
	end

	FightController.instance:setCurStage(FightEnum.Stage.FillCard)

	if arg_3_0.actEffectData.effectType == FightEnum.EffectType.DEALCARD2 then
		local var_3_0 = FightDataHelper.handCardMgr.beforeCards2
		local var_3_1 = FightDataHelper.handCardMgr.teamACards2

		if #var_3_0 > 0 or #var_3_1 > 0 then
			FightController.instance:registerCallback(FightEvent.OnDistributeCards, arg_3_0._distributeDone, arg_3_0)
			FightViewPartVisible.set(false, true, false, false, false)
			FightController.instance:dispatchEvent(FightEvent.DistributeCards, var_3_0, var_3_1)
		else
			arg_3_0:_distributeDone()
		end
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._distributeDone(arg_4_0)
	FightController.instance:setCurStage(FightEnum.Stage.Play)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_4_0._distributeDone, arg_4_0)

	local var_4_0 = FightViewHandCard.handCardContainer
	local var_4_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	local var_4_2 = arg_4_0:_checkHasEnemySkill()

	if not gohelper.isNil(var_4_0) and #var_4_1 > 0 and var_4_2 then
		FightViewPartVisible.set(false, true, false, true, false)

		local var_4_3 = var_0_0.handCardScale
		local var_4_4 = var_0_0.getHandCardScaleTime()

		arg_4_0.tweenId = ZProj.TweenHelper.DOScale(var_4_0.transform, var_4_3, var_4_3, var_4_3, var_4_4, arg_4_0._onHandCardsShrink, arg_4_0)
	else
		arg_4_0:_onHandCardsShrink()
	end
end

function var_0_0._checkHasEnemySkill(arg_5_0)
	local var_5_0 = FightDataHelper.roundMgr:getRoundData()
	local var_5_1 = false

	for iter_5_0, iter_5_1 in ipairs(var_5_0.fightStep) do
		if not var_5_1 and iter_5_1.actType == FightEnum.ActType.EFFECT then
			for iter_5_2, iter_5_3 in ipairs(iter_5_1.actEffect) do
				if iter_5_3.effectType == FightEnum.EffectType.DEALCARD2 then
					var_5_1 = true

					break
				end
			end
		elseif var_5_1 and iter_5_1.actType == FightEnum.ActType.SKILL then
			local var_5_2 = FightHelper.getEntity(iter_5_1.fromId)

			if var_5_2 and var_5_2:isEnemySide() then
				return true
			end
		end
	end

	return false
end

function var_0_0._onHandCardsShrink(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.getHandCardScaleTime()
	return var_0_0.handCardScaleTime / FightModel.instance:getUISpeed()
end

function var_0_0.clearWork(arg_8_0)
	if arg_8_0.tweenId then
		ZProj.TweenHelper.KillById(arg_8_0.tweenId)

		arg_8_0.tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_8_0._delayDistribute, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_8_0._distributeDone, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, arg_8_0._onDissolveCombineEnd, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._dissolveTimeout, arg_8_0)
end

function var_0_0._delayDone(arg_9_0)
	arg_9_0:onDone(true)
end

return var_0_0
