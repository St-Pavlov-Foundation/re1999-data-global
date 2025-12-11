module("modules.logic.fight.entity.comp.FightPlayerReadyAttackComp", package.seeall)

local var_0_0 = class("FightPlayerReadyAttackComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_2_0._onPlayHandCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRevertCard, arg_2_0._onRevertCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_2_0._onResetCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_2_0._beforePlaySkill, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_2_0._onStageChange, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_3_0._onPlayHandCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnRevertCard, arg_3_0._onRevertCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnResetCard, arg_3_0._onResetCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_3_0._beforePlaySkill, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StageChanged, arg_3_0._onStageChange, arg_3_0)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0:_clearReadyAttackWork()
end

function var_0_0._onPlayHandCard(arg_5_0, arg_5_1)
	if arg_5_1.uid ~= arg_5_0.entity.id then
		return
	end

	if #FightDataHelper.operationDataMgr:getEntityOps(arg_5_1.uid, FightEnum.CardOpType.PlayCard) > 0 and not arg_5_0._readyAttackWork then
		local var_5_0 = FightDataHelper.entityMgr:getById(arg_5_1.uid)
		local var_5_1 = var_5_0 and FightDataHelper.operationDataMgr:getOpList()
		local var_5_2 = var_5_1 and FightBuffHelper.simulateBuffList(var_5_0, var_5_1[#var_5_1])

		if FightViewHandCardItemLock.canUseCardSkill(arg_5_1.uid, arg_5_1.skillId, var_5_2) then
			arg_5_0._readyAttackWork = FightReadyAttackWork.New()

			arg_5_0._readyAttackWork:onStart(arg_5_0.entity)
		end
	end
end

function var_0_0._onRevertCard(arg_6_0, arg_6_1)
	if arg_6_1.belongToEntityId ~= arg_6_0.entity.id then
		return
	end

	if arg_6_1:isPlayCard() then
		local var_6_0 = FightDataHelper.operationDataMgr:getEntityOps(arg_6_0.entity.id)

		if (not var_6_0 or #var_6_0 == 0) and arg_6_0._readyAttackWork then
			arg_6_0.entity:resetAnimState()
			arg_6_0:_clearReadyAttackWork()
		end
	end
end

function var_0_0._onResetCard(arg_7_0)
	if arg_7_0._readyAttackWork then
		arg_7_0.entity:resetAnimState()
		arg_7_0:_clearReadyAttackWork()
	end
end

function var_0_0._beforePlaySkill(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.entity == arg_8_1 then
		arg_8_0:_clearReadyAttackWork()
	end
end

function var_0_0._onStageChange(arg_9_0)
	arg_9_0:_clearReadyAttackWork()
end

function var_0_0._clearReadyAttackWork(arg_10_0)
	if arg_10_0._readyAttackWork then
		arg_10_0._readyAttackWork:onStop()

		arg_10_0._readyAttackWork = nil
	end
end

return var_0_0
