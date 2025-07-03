module("modules.logic.fight.system.work.FightWorkEffectCardLevelChange", package.seeall)

local var_0_0 = class("FightWorkEffectCardLevelChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	local var_1_0 = FightDataHelper.handCardMgr.handCard

	arg_1_0.cardIndex = tonumber(arg_1_0.actEffectData.targetId)

	local var_1_1 = var_1_0[arg_1_0.cardIndex]

	arg_1_0.oldSkillId = var_1_1 and var_1_1.skillId
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:_startChangeCardEffect()
end

function var_0_0._startChangeCardEffect(arg_3_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_3_0.actEffectData) then
		arg_3_0:onDone(true)

		return
	end

	if FightModel.instance:getVersion() < 1 then
		local var_3_0 = arg_3_0.actEffectData.entity.id
		local var_3_1 = FightHelper.getEntity(var_3_0)

		if not var_3_1 then
			arg_3_0:onDone(true)

			return
		end

		if not var_3_1:isMySide() then
			arg_3_0:onDone(true)

			return
		end
	end

	if not arg_3_0.oldSkillId then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardLevelChange, arg_3_0.cardIndex, arg_3_0.oldSkillId)
		arg_3_0:com_registTimer(arg_3_0._delayDone, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		arg_3_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
