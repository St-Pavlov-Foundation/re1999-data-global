module("modules.logic.activity.model.warmup.ActivityWarmUpOrderMO", package.seeall)

local var_0_0 = pureTable("ActivityWarmUpOrderMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.cfg = nil
	arg_1_0.progress = nil
	arg_1_0.hasGetBonus = false
	arg_1_0.accept = false
	arg_1_0.status = ActivityWarmUpEnum.OrderStatus.None
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.cfg = arg_2_1
end

function var_0_0.initServerData(arg_3_0, arg_3_1)
	arg_3_0.progress = arg_3_1.process
	arg_3_0.hasGetBonus = arg_3_1.hasGetBonus
	arg_3_0.accept = arg_3_1.accept

	if arg_3_0.hasGetBonus then
		arg_3_0.status = ActivityWarmUpEnum.OrderStatus.Finished
	elseif not arg_3_0.accept then
		arg_3_0.status = ActivityWarmUpEnum.OrderStatus.WaitForAccept
	elseif arg_3_0.accept and not arg_3_0:isColleted() then
		arg_3_0.status = ActivityWarmUpEnum.OrderStatus.Accepted
	elseif arg_3_0.accept and arg_3_0:isColleted() and not arg_3_0.hasGetBonus then
		arg_3_0.status = ActivityWarmUpEnum.OrderStatus.Collected
	end
end

function var_0_0.getStatus(arg_4_0)
	return arg_4_0.status
end

function var_0_0.isColleted(arg_5_0)
	if arg_5_0.progress then
		return arg_5_0.progress >= arg_5_0.cfg.maxProgress
	else
		return false
	end
end

function var_0_0.canFinish(arg_6_0)
	return arg_6_0.status == ActivityWarmUpEnum.OrderStatus.Collected
end

return var_0_0
