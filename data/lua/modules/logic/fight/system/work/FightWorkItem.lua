module("modules.logic.fight.system.work.FightWorkItem", package.seeall)

local var_0_0 = class("FightWorkItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.CALLBACK = {}
	arg_1_0.SAFETIME = 0.5
	arg_1_0.WORK_IS_FINISHED = nil
	arg_1_0.STARTED = nil
	arg_1_0.SAFETIMER = nil
	arg_1_0.FIGHT_WORK_ENTRUSTED = nil
	arg_1_0.SUCCEEDED = nil
end

function var_0_0.start(arg_2_0, arg_2_1)
	return xpcall(var_0_0.__start, __G__TRACKBACK__, arg_2_0, arg_2_1)
end

function var_0_0.__start(arg_3_0, arg_3_1)
	if arg_3_0.WORK_IS_FINISHED then
		logError("work已经结束了,但是又被调用了start,请检查代码,类名:" .. arg_3_0.__cname)

		return
	end

	if arg_3_0.STARTED then
		logError("work已经开始了,但是又被调用了start,请检查代码,类名:" .. arg_3_0.__cname)

		return
	end

	if arg_3_0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了start,请检查代码,类名:" .. arg_3_0.__cname)

		return
	end

	arg_3_0.context = arg_3_1
	arg_3_0.STARTED = true
	arg_3_0.EXCLUSIVETIMER = {}
	arg_3_0.SAFETIMER = arg_3_0:com_registTimer(arg_3_0._fightWorkSafeTimer, arg_3_0.SAFETIME)

	table.insert(arg_3_0.EXCLUSIVETIMER, arg_3_0.SAFETIMER)
	arg_3_0:beforeStart()

	return arg_3_0:onStart()
end

function var_0_0.cancelFightWorkSafeTimer(arg_4_0)
	return arg_4_0:com_cancelTimer(arg_4_0.SAFETIMER)
end

function var_0_0._fightWorkSafeTimer(arg_5_0)
	logError("战斗保底 fightwork ondone, className = " .. arg_5_0.__cname)

	return arg_5_0:onDone(false)
end

function var_0_0._delayAfterPerformance(arg_6_0)
	return arg_6_0:onDone(true)
end

function var_0_0._delayDone(arg_7_0)
	return arg_7_0:onDone(true)
end

function var_0_0.finishWork(arg_8_0)
	return arg_8_0:onDone(true)
end

function var_0_0.playWorkAndDone(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return arg_9_0:onDone(true)
	end

	arg_9_1:registFinishCallback(arg_9_0.finishWork, arg_9_0)
	arg_9_0:cancelFightWorkSafeTimer()
	arg_9_1:start()
end

function var_0_0.com_registTimer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == arg_10_0._delayDone or arg_10_1 == arg_10_0._delayAfterPerformance or arg_10_1 == arg_10_0.finishWork then
		arg_10_0:releaseExclusiveTimer()

		local var_10_0 = var_0_0.super.com_registTimer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)

		table.insert(arg_10_0.EXCLUSIVETIMER, var_10_0)

		return var_10_0
	end

	return var_0_0.super.com_registTimer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.releaseExclusiveTimer(arg_11_0)
	if arg_11_0.EXCLUSIVETIMER then
		for iter_11_0 = #arg_11_0.EXCLUSIVETIMER, 1, -1 do
			arg_11_0:com_cancelTimer(arg_11_0.EXCLUSIVETIMER[iter_11_0])
			table.remove(arg_11_0.EXCLUSIVETIMER, iter_11_0)
		end
	end
end

function var_0_0.com_registWorkDoneFlowSequence(arg_12_0)
	local var_12_0 = arg_12_0:com_registCustomFlow(FightWorkDoneFlowSequence)

	var_12_0:registFinishCallback(arg_12_0.finishWork, arg_12_0)

	return var_12_0
end

function var_0_0.com_registWorkDoneFlowParallel(arg_13_0)
	local var_13_0 = arg_13_0:com_registCustomFlow(FightWorkDoneFlowParallel)

	var_13_0:registFinishCallback(arg_13_0.finishWork, arg_13_0)

	return var_13_0
end

function var_0_0.beforeStart(arg_14_0)
	return
end

function var_0_0.onStart(arg_15_0)
	return
end

function var_0_0.beforeClearWork(arg_16_0)
	return
end

function var_0_0.clearWork(arg_17_0)
	return
end

function var_0_0.registFinishCallback(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0.IS_DISPOSED or arg_18_0.WORK_IS_FINISHED then
		return arg_18_1(arg_18_2, arg_18_3)
	end

	table.insert(arg_18_0.CALLBACK, {
		callback = arg_18_1,
		handle = arg_18_2,
		param = arg_18_3
	})
end

function var_0_0.onDestructor(arg_19_0)
	if arg_19_0.STARTED then
		arg_19_0:beforeClearWork()

		return arg_19_0:clearWork()
	end
end

function var_0_0.onDestructorFinish(arg_20_0)
	arg_20_0:playCallback(arg_20_0.CALLBACK)

	arg_20_0.CALLBACK = nil
end

function var_0_0.playCallback(arg_21_0, arg_21_1)
	if arg_21_0.WORK_IS_FINISHED or arg_21_0.STARTED then
		local var_21_0 = arg_21_0.SUCCEEDED and true or false
		local var_21_1 = #arg_21_1

		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			local var_21_2 = arg_21_0.WORK_IS_FINISHED or arg_21_0.FIGHT_WORK_ENTRUSTED

			if not arg_21_0.WORK_IS_FINISHED and arg_21_0.STARTED then
				local var_21_3 = iter_21_1.handle

				if isTypeOf(var_21_3, FightBaseClass) and not var_21_3.IS_RELEASING then
					var_21_2 = true
				end
			end

			if var_21_2 then
				local var_21_4 = iter_21_1.handle
				local var_21_5 = iter_21_1.callback
				local var_21_6 = iter_21_1.param

				if var_21_4 then
					if not var_21_4.IS_DISPOSED then
						if iter_21_0 == var_21_1 then
							return var_21_5(var_21_4, var_21_6, var_21_0)
						else
							var_21_5(var_21_4, var_21_6, var_21_0)
						end
					end
				elseif iter_21_0 == var_21_1 then
					return var_21_5(var_21_6, var_21_0)
				else
					var_21_5(var_21_6, var_21_0)
				end
			end
		end
	end
end

function var_0_0.onDone(arg_22_0, arg_22_1)
	if arg_22_0.FIGHT_WORK_ENTRUSTED then
		arg_22_0.FIGHT_WORK_ENTRUSTED = nil
	end

	if arg_22_0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了onDone,请检查代码,类名:" .. arg_22_0.__cname)

		return
	end

	if arg_22_0.WORK_IS_FINISHED then
		logError("work已经完成了,但是又被调用了onDone,请检查代码,类名:" .. arg_22_0.__cname)

		return
	end

	arg_22_0.WORK_IS_FINISHED = true
	arg_22_0.SUCCEEDED = arg_22_1

	return arg_22_0:disposeSelf()
end

function var_0_0.onDoneAndKeepPlay(arg_23_0)
	arg_23_0.FIGHT_WORK_ENTRUSTED = true
	arg_23_0.SUCCEEDED = true

	local var_23_0 = tabletool.copy(arg_23_0.CALLBACK)

	arg_23_0.CALLBACK = {}

	arg_23_0:playCallback(var_23_0)

	if not arg_23_0:com_sendMsg(FightMsgId.EntrustFightWork, arg_23_0) then
		logError("托管fightwork未成功,类名:" .. arg_23_0.__cname)

		arg_23_0.FIGHT_WORK_ENTRUSTED = nil

		arg_23_0:disposeSelf()
	end
end

function var_0_0.isAlive(arg_24_0)
	return not arg_24_0.IS_DISPOSED and not arg_24_0.WORK_IS_FINISHED
end

function var_0_0.disposeSelf(arg_25_0)
	if arg_25_0.FIGHT_WORK_ENTRUSTED then
		return
	end

	var_0_0.super.disposeSelf(arg_25_0)
end

return var_0_0
