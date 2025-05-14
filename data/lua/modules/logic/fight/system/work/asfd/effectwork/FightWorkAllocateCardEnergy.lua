﻿module("modules.logic.fight.system.work.asfd.effectwork.FightWorkAllocateCardEnergy", package.seeall)

local var_0_0 = class("FightWorkAllocateCardEnergy", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 3
end

var_0_0.AllocateEnum = {
	Clear = 0,
	Allocate = 1
}

function var_0_0.onStart(arg_2_0)
	if arg_2_0._actEffectMO.effectNum1 ~= var_0_0.AllocateEnum.Allocate then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightCardModel.instance:getHandCardData()
	local var_2_1 = arg_2_0._actEffectMO.cardInfoList

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = var_2_1 and var_2_1[iter_2_0]

		if var_2_2 then
			iter_2_1:init(var_2_2)
		end
	end

	FightController.instance:registerCallback(FightEvent.ASFD_AllocateCardEnergyDone, arg_2_0.allocateCardEnergyDone, arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_StartAllocateCardEnergy)
end

function var_0_0.allocateCardEnergyDone(arg_3_0)
	return arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_AllocateCardEnergyDone, arg_4_0.allocateCardEnergyDone, arg_4_0)
end

return var_0_0
