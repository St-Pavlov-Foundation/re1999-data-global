module("modules.logic.fight.system.work.FightWorkItem", package.seeall)

local var_0_0 = class("FightWorkItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.CALLBACK = {}
	arg_1_0.SAFETIME = 0.5
end

function var_0_0.start(arg_2_0, arg_2_1)
	if arg_2_0.WORKFINISHED then
		logError("work已经结束了,但是又被调用了start,请检查代码,类名:" .. arg_2_0.__cname)

		return
	end

	if arg_2_0.STARTED then
		logError("work已经开始了,但是又被调用了start,请检查代码,类名:" .. arg_2_0.__cname)

		return
	end

	if arg_2_0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了start,请检查代码,类名:" .. arg_2_0.__cname)

		return
	end

	arg_2_0.context = arg_2_1
	arg_2_0.STARTED = true
	arg_2_0.EXCLUSIVETIMER = {}
	arg_2_0.SAFETIMER = arg_2_0:com_registTimer(arg_2_0._fightWorkSafeTimer, arg_2_0.SAFETIME)

	table.insert(arg_2_0.EXCLUSIVETIMER, arg_2_0.SAFETIMER)
	arg_2_0:beforeStart()

	return arg_2_0:onStart()
end

function var_0_0.cancelFightWorkSafeTimer(arg_3_0)
	return arg_3_0:com_cancelTimer(arg_3_0.SAFETIMER)
end

function var_0_0._fightWorkSafeTimer(arg_4_0)
	logError("战斗保底 fightwork ondone, className = " .. arg_4_0.__cname)

	return arg_4_0:onDone(false)
end

function var_0_0._delayAfterPerformance(arg_5_0)
	return arg_5_0:onDone(true)
end

function var_0_0._delayDone(arg_6_0)
	return arg_6_0:onDone(true)
end

function var_0_0.finishWork(arg_7_0)
	return arg_7_0:onDone(true)
end

function var_0_0.playWorkAndDone(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return arg_8_0:onDone(true)
	end

	arg_8_1:registFinishCallback(arg_8_0.finishWork, arg_8_0)
	arg_8_0:cancelFightWorkSafeTimer()
	arg_8_1:start()
end

function var_0_0.com_registTimer(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == arg_9_0._delayDone or arg_9_1 == arg_9_0._delayAfterPerformance or arg_9_1 == arg_9_0.finishWork then
		arg_9_0:releaseExclusiveTimer()

		local var_9_0 = var_0_0.super.com_registTimer(arg_9_0, arg_9_1, arg_9_2, arg_9_3)

		table.insert(arg_9_0.EXCLUSIVETIMER, var_9_0)

		return var_9_0
	end

	return var_0_0.super.com_registTimer(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.releaseExclusiveTimer(arg_10_0)
	if arg_10_0.EXCLUSIVETIMER then
		for iter_10_0 = #arg_10_0.EXCLUSIVETIMER, 1, -1 do
			arg_10_0:com_cancelTimer(arg_10_0.EXCLUSIVETIMER[iter_10_0])
			table.remove(arg_10_0.EXCLUSIVETIMER, iter_10_0)
		end
	end
end

function var_0_0.com_registWorkDoneFlowSequence(arg_11_0)
	local var_11_0 = arg_11_0:com_registCustomFlow(FightWorkDoneFlowSequence)

	var_11_0:registFinishCallback(arg_11_0.finishWork, arg_11_0)

	return var_11_0
end

function var_0_0.com_registWorkDoneFlowParallel(arg_12_0)
	local var_12_0 = arg_12_0:com_registCustomFlow(FightWorkDoneFlowParallel)

	var_12_0:registFinishCallback(arg_12_0.finishWork, arg_12_0)

	return var_12_0
end

function var_0_0.beforeStart(arg_13_0)
	return
end

function var_0_0.onStart(arg_14_0)
	return
end

function var_0_0.beforeClearWork(arg_15_0)
	return
end

function var_0_0.clearWork(arg_16_0)
	return
end

function var_0_0.registFinishCallback(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0.IS_DISPOSED or arg_17_0.WORKFINISHED then
		return arg_17_1(arg_17_2, arg_17_3)
	end

	table.insert(arg_17_0.CALLBACK, {
		callback = arg_17_1,
		handle = arg_17_2,
		param = arg_17_3
	})
end

function var_0_0.onDestructor(arg_18_0)
	if arg_18_0.STARTED then
		arg_18_0:beforeClearWork()

		return arg_18_0:clearWork()
	end
end

function var_0_0.onDestructorFinish(arg_19_0)
	arg_19_0:playCallback(arg_19_0.CALLBACK)

	arg_19_0.CALLBACK = nil
end

function var_0_0.playCallback(arg_20_0, arg_20_1)
	if arg_20_0.WORKFINISHED or arg_20_0.STARTED then
		local var_20_0 = arg_20_0.SUCCEEDED and true or false
		local var_20_1 = #arg_20_1

		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			local var_20_2 = arg_20_0.WORKFINISHED

			if not arg_20_0.WORKFINISHED and arg_20_0.STARTED then
				local var_20_3 = iter_20_1.handle

				if isTypeOf(var_20_3, FightBaseClass) and not var_20_3.IS_RELEASING then
					var_20_2 = true
				end
			end

			if var_20_2 then
				local var_20_4 = iter_20_1.handle
				local var_20_5 = iter_20_1.callback
				local var_20_6 = iter_20_1.param

				if var_20_4 then
					if not var_20_4.IS_DISPOSED then
						if iter_20_0 == var_20_1 then
							return var_20_5(var_20_4, var_20_6, var_20_0)
						else
							var_20_5(var_20_4, var_20_6, var_20_0)
						end
					end
				elseif iter_20_0 == var_20_1 then
					return var_20_5(var_20_6, var_20_0)
				else
					var_20_5(var_20_6, var_20_0)
				end
			end
		end
	end
end

function var_0_0.onDone(arg_21_0, arg_21_1)
	if arg_21_0.FIGHT_WORK_ENTRUSTED then
		arg_21_0.FIGHT_WORK_ENTRUSTED = nil
	end

	if arg_21_0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了onDone,请检查代码,类名:" .. arg_21_0.__cname)

		return
	end

	if arg_21_0.WORKFINISHED then
		logError("work已经完成了,但是又被调用了onDone,请检查代码,类名:" .. arg_21_0.__cname)

		return
	end

	arg_21_0.WORKFINISHED = true
	arg_21_0.SUCCEEDED = arg_21_1

	return arg_21_0:disposeSelf()
end

function var_0_0.onDoneAndKeepPlay(arg_22_0)
	arg_22_0.FIGHT_WORK_ENTRUSTED = true
	arg_22_0.SUCCEEDED = true

	local var_22_0 = tabletool.copy(arg_22_0.CALLBACK)

	arg_22_0.CALLBACK = {}

	arg_22_0:playCallback(var_22_0)

	if not arg_22_0:com_sendMsg(FightMsgId.EntrustFightWork, arg_22_0) then
		logError("托管fightwork未成功,类名:" .. arg_22_0.__cname)

		arg_22_0.FIGHT_WORK_ENTRUSTED = nil

		arg_22_0:disposeSelf()
	end
end

function var_0_0.disposeSelf(arg_23_0)
	if arg_23_0.FIGHT_WORK_ENTRUSTED then
		return
	end

	var_0_0.super.disposeSelf(arg_23_0)
end

return var_0_0
