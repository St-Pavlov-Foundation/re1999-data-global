module("modules.logic.fight.system.work.asfd.effectwork.FightWorkAllocateCardEnergy", package.seeall)

local var_0_0 = class("FightWorkAllocateCardEnergy", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 3
end

var_0_0.AllocateEnum = {
	Clear = 0,
	Allocate = 1
}

function var_0_0.onStart(arg_2_0)
	if arg_2_0.actEffectData.effectNum1 ~= var_0_0.AllocateEnum.Allocate then
		arg_2_0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.ASFD_AllocateCardEnergyDone, arg_2_0.allocateCardEnergyDone, arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_StartAllocateCardEnergy)
end

var_0_0.ASFDOpenTime = 0.5

function var_0_0.allocateCardEnergyDone(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, var_0_0.ASFDOpenTime / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_AllocateCardEnergyDone, arg_4_0.allocateCardEnergyDone, arg_4_0)
end

return var_0_0
