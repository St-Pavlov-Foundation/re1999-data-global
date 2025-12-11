module("modules.logic.fight.view.work.FightAutoDetectUpgradeWork", package.seeall)

local var_0_0 = class("FightAutoDetectUpgradeWork", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 10
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = FightPlayerOperateMgr.detectUpgrade()

	if #var_2_0 > 0 then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_2_0._onRespUseClothSkillFail, arg_2_0)

		for iter_2_0 = #var_2_0, 1, -1 do
			local var_2_1 = var_2_0[iter_2_0]

			FightRpc.instance:sendUseClothSkillRequest(var_2_1.id, var_2_1.entityId, var_2_1.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)

			return
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0._onRespUseClothSkillFail(arg_3_0)
	arg_3_0:_onClothSkillRoundSequenceFinish()
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, arg_4_0._onRespUseClothSkillFail, arg_4_0)
end

return var_0_0
