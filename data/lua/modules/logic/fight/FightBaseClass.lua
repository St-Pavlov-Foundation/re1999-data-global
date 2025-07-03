module("modules.logic.fight.FightBaseClass", package.seeall)

local var_0_0 = class("FightBaseClass", FightObject)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.onAwake(arg_2_0, ...)
	return
end

function var_0_0.releaseSelf(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	if arg_4_0.USER_DATA_LIST then
		local var_4_0 = arg_4_0.USER_DATA_LIST

		for iter_4_0 = #var_4_0, 1, -1 do
			local var_4_1 = var_4_0[iter_4_0]

			for iter_4_1 in pairs(var_4_1) do
				rawset(var_4_1, iter_4_1, nil)
			end

			rawset(var_4_0, iter_4_0, nil)
		end

		arg_4_0.USER_DATA_LIST = nil
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0) do
		if type(iter_4_3) == "userdata" then
			rawset(arg_4_0, iter_4_2, nil)
		end
	end
end

function var_0_0.onDestructorFinish(arg_5_0)
	return
end

function var_0_0.newUserDataTable(arg_6_0)
	if arg_6_0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用注册table的方法,请检查代码,类名:" .. arg_6_0.__cname)
	end

	if not arg_6_0.USER_DATA_LIST then
		arg_6_0.USER_DATA_LIST = {}
	end

	local var_6_0 = {}

	table.insert(arg_6_0.USER_DATA_LIST, var_6_0)

	return var_6_0
end

function var_0_0.getUserDataTb_(arg_7_0)
	return arg_7_0:newUserDataTable()
end

function var_0_0.getComponent(arg_8_0, arg_8_1)
	if arg_8_0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了获取组件的方法,请检查代码,类名:" .. arg_8_0.__cname)
	end

	local var_8_0 = arg_8_1.__cname

	if arg_8_0[var_8_0] then
		return arg_8_0[var_8_0]
	end

	local var_8_1 = arg_8_0:addComponent(arg_8_1)

	arg_8_0[var_8_0] = var_8_1

	return var_8_1
end

function var_0_0.killComponent(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_1.__cname
	local var_9_1 = arg_9_0[var_9_0]

	if var_9_1 then
		var_9_1:disposeSelf()

		arg_9_0[var_9_0] = nil
	end
end

function var_0_0.com_loadAsset(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:getComponent(FightLoaderComponent):loadAsset(arg_10_1, arg_10_2, arg_10_0, arg_10_3)
end

function var_0_0.com_loadListAsset(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0:getComponent(FightLoaderComponent):loadListAsset(arg_11_1, arg_11_2, arg_11_3, arg_11_0, arg_11_4)
end

function var_0_0.com_registFlowSequence(arg_12_0)
	return arg_12_0:com_registCustomFlow(FightWorkFlowSequence)
end

function var_0_0.com_registFlowParallel(arg_13_0)
	return arg_13_0:com_registCustomFlow(FightWorkFlowParallel)
end

function var_0_0.com_registCustomFlow(arg_14_0, arg_14_1)
	return arg_14_0:getComponent(FightFlowComponent):registCustomFlow(arg_14_1)
end

function var_0_0.com_registWork(arg_15_0, arg_15_1, ...)
	return arg_15_0:getComponent(FightWorkComponent):registWork(arg_15_1, ...)
end

function var_0_0.com_playWork(arg_16_0, arg_16_1, ...)
	arg_16_0:getComponent(FightWorkComponent):playWork(arg_16_1, ...)
end

function var_0_0.com_cancelTimer(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	arg_17_1.isDone = true
end

function var_0_0.com_registTimer(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return arg_18_0:com_registRepeatTimer(arg_18_1, arg_18_2, 1, arg_18_3)
end

function var_0_0.com_registRepeatTimer(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	return arg_19_0:getComponent(FightTimerComponent):registRepeatTimer(arg_19_1, arg_19_0, arg_19_2, arg_19_3, arg_19_4)
end

function var_0_0.com_registSingleTimer(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	return arg_20_0:getComponent(FightTimerComponent):registSingleTimer(arg_20_1, arg_20_0, arg_20_2, 1, arg_20_3)
end

function var_0_0.com_restartTimer(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	return arg_21_0:com_restartRepeatTimer(arg_21_1, arg_21_2, 1, arg_21_3)
end

function var_0_0.com_restartRepeatTimer(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if not arg_22_1.isDone then
		arg_22_1:restart(arg_22_2, arg_22_3, arg_22_4)

		return
	end

	return arg_22_0:getComponent(FightTimerComponent):restartRepeatTimer(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
end

function var_0_0.com_registFightEvent(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0:com_registEvent(FightController.instance, arg_23_1, arg_23_2, arg_23_3)
end

function var_0_0.com_registEvent(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	arg_24_0:getComponent(FightEventComponent):registEvent(arg_24_1, arg_24_2, arg_24_3, arg_24_0, arg_24_4)
end

function var_0_0.com_cancelFightEvent(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:com_cancelEvent(FightController.instance, arg_25_1, arg_25_2)
end

function var_0_0.com_cancelEvent(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0:getComponent(FightEventComponent):cancelEvent(arg_26_1, arg_26_2, arg_26_3, arg_26_0)
end

function var_0_0.com_lockEvent(arg_27_0)
	arg_27_0:getComponent(FightEventComponent):lockEvent()
end

function var_0_0.com_unlockEvent(arg_28_0)
	arg_28_0:getComponent(FightEventComponent):unlockEvent()
end

function var_0_0.com_sendFightEvent(arg_29_0, arg_29_1, ...)
	FightController.instance:dispatchEvent(arg_29_1, ...)
end

function var_0_0.com_sendEvent(arg_30_0, arg_30_1, arg_30_2, ...)
	arg_30_1:dispatchEvent(arg_30_2, ...)
end

function var_0_0.com_registMsg(arg_31_0, arg_31_1, arg_31_2)
	return arg_31_0:getComponent(FightMsgComponent):registMsg(arg_31_1, arg_31_2, arg_31_0)
end

function var_0_0.com_removeMsg(arg_32_0, arg_32_1)
	return arg_32_0:getComponent(FightMsgComponent):removeMsg(arg_32_1)
end

function var_0_0.com_sendMsg(arg_33_0, arg_33_1, ...)
	return FightMsgMgr.sendMsg(arg_33_1, ...)
end

function var_0_0.com_replyMsg(arg_34_0, arg_34_1, arg_34_2)
	return FightMsgMgr.replyMsg(arg_34_1, arg_34_2)
end

function var_0_0.com_lockMsg(arg_35_0)
	return arg_35_0:getComponent(FightMsgComponent):lockMsg()
end

function var_0_0.com_unlockMsg(arg_36_0)
	return arg_36_0:getComponent(FightMsgComponent):unlockMsg()
end

function var_0_0.com_registUpdate(arg_37_0, arg_37_1, arg_37_2)
	return arg_37_0:getComponent(FightUpdateComponent):registUpdate(arg_37_1, arg_37_0, arg_37_2)
end

function var_0_0.com_cancelUpdate(arg_38_0, arg_38_1)
	return arg_38_0:getComponent(FightUpdateComponent):cancelUpdate(arg_38_1)
end

return var_0_0
