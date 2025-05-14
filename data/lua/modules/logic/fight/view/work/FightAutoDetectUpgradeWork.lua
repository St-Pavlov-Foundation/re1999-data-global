module("modules.logic.fight.view.work.FightAutoDetectUpgradeWork", package.seeall)

local var_0_0 = class("FightAutoDetectUpgradeWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = FightPlayerOperateMgr.detectUpgrade()

	if #var_2_0 > 0 then
		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 20)
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_2_0._onRespUseClothSkillFail, arg_2_0)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)

		arg_2_0._count = #var_2_0

		for iter_2_0 = #var_2_0, 1, -1 do
			local var_2_1 = var_2_0[iter_2_0]

			FightRpc.instance:sendUseClothSkillRequest(var_2_1.id, var_2_1.entityId, var_2_1.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
			table.remove(var_2_0, iter_2_0)
		end

		return
	end

	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._onRespUseClothSkillFail(arg_4_0)
	arg_4_0:_onClothSkillRoundSequenceFinish()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_5_0)
	arg_5_0._count = arg_5_0._count - 1

	if arg_5_0._count == 0 then
		arg_5_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, arg_6_0._onRespUseClothSkillFail, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_6_0._onClothSkillRoundSequenceFinish, arg_6_0)
end

return var_0_0
