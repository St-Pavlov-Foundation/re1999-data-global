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

function var_0_0.com_registTimer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 == arg_8_0._delayDone or arg_8_1 == arg_8_0._delayAfterPerformance then
		arg_8_0:releaseExclusiveTimer()

		local var_8_0 = var_0_0.super.com_registTimer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)

		table.insert(arg_8_0.EXCLUSIVETIMER, var_8_0)

		return var_8_0
	end

	return var_0_0.super.com_registTimer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.releaseExclusiveTimer(arg_9_0)
	if arg_9_0.EXCLUSIVETIMER then
		for iter_9_0 = #arg_9_0.EXCLUSIVETIMER, 1, -1 do
			arg_9_0:com_cancelTimer(arg_9_0.EXCLUSIVETIMER[iter_9_0])
			table.remove(arg_9_0.EXCLUSIVETIMER, iter_9_0)
		end
	end
end

function var_0_0.com_registWorkDoneFlowSequence(arg_10_0)
	local var_10_0 = arg_10_0:com_registCustomFlow(FightWorkDoneFlowSequence)

	var_10_0:registFinishCallback(arg_10_0.finishWork, arg_10_0)

	return var_10_0
end

function var_0_0.com_registWorkDoneFlowParallel(arg_11_0)
	local var_11_0 = arg_11_0:com_registCustomFlow(FightWorkDoneFlowParallel)

	var_11_0:registFinishCallback(arg_11_0.finishWork, arg_11_0)

	return var_11_0
end

function var_0_0.beforeStart(arg_12_0)
	return
end

function var_0_0.onStart(arg_13_0)
	return
end

function var_0_0.beforeClearWork(arg_14_0)
	return
end

function var_0_0.clearWork(arg_15_0)
	return
end

function var_0_0.registFinishCallback(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0.IS_DISPOSED or arg_16_0.WORKFINISHED then
		return arg_16_1(arg_16_2, arg_16_3)
	end

	table.insert(arg_16_0.CALLBACK, {
		callback = arg_16_1,
		handle = arg_16_2,
		param = arg_16_3
	})
end

function var_0_0.onDestructor(arg_17_0)
	if arg_17_0.STARTED then
		arg_17_0:beforeClearWork()

		return arg_17_0:clearWork()
	end
end

function var_0_0.onDestructorFinish(arg_18_0)
	arg_18_0:playCallback(arg_18_0.CALLBACK)

	arg_18_0.CALLBACK = nil
end

function var_0_0.playCallback(arg_19_0, arg_19_1)
	if arg_19_0.WORKFINISHED or arg_19_0.STARTED then
		local var_19_0 = arg_19_0.SUCCEEDED and true or false
		local var_19_1 = #arg_19_1

		for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
			local var_19_2 = arg_19_0.WORKFINISHED

			if not arg_19_0.WORKFINISHED and arg_19_0.STARTED then
				local var_19_3 = iter_19_1.handle

				if isTypeOf(var_19_3, FightBaseClass) and not var_19_3.IS_RELEASING then
					var_19_2 = true
				end
			end

			if var_19_2 then
				local var_19_4 = iter_19_1.handle
				local var_19_5 = iter_19_1.callback
				local var_19_6 = iter_19_1.param

				if var_19_4 then
					if not var_19_4.IS_DISPOSED then
						if iter_19_0 == var_19_1 then
							return var_19_5(var_19_4, var_19_6, var_19_0)
						else
							var_19_5(var_19_4, var_19_6, var_19_0)
						end
					end
				elseif iter_19_0 == var_19_1 then
					return var_19_5(var_19_6, var_19_0)
				else
					var_19_5(var_19_6, var_19_0)
				end
			end
		end
	end
end

function var_0_0.onDone(arg_20_0, arg_20_1)
	if arg_20_0.FIGHT_WORK_ENTRUSTED then
		arg_20_0.FIGHT_WORK_ENTRUSTED = nil
	end

	if arg_20_0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了onDone,请检查代码,类名:" .. arg_20_0.__cname)

		return
	end

	if arg_20_0.WORKFINISHED then
		logError("work已经完成了,但是又被调用了onDone,请检查代码,类名:" .. arg_20_0.__cname)

		return
	end

	arg_20_0.WORKFINISHED = true
	arg_20_0.SUCCEEDED = arg_20_1

	return arg_20_0:disposeSelf()
end

function var_0_0.onDoneAndKeepPlay(arg_21_0)
	arg_21_0.FIGHT_WORK_ENTRUSTED = true
	arg_21_0.SUCCEEDED = true

	local var_21_0 = tabletool.copy(arg_21_0.CALLBACK)

	arg_21_0.CALLBACK = {}

	arg_21_0:playCallback(var_21_0)

	if not arg_21_0:com_sendMsg(FightMsgId.EntrustFightWork, arg_21_0) then
		logError("托管fightwork未成功,类名:" .. arg_21_0.__cname)

		arg_21_0.FIGHT_WORK_ENTRUSTED = nil

		arg_21_0:disposeSelf()
	end
end

function var_0_0.disposeSelf(arg_22_0)
	if arg_22_0.FIGHT_WORK_ENTRUSTED then
		return
	end

	var_0_0.super.disposeSelf(arg_22_0)
end

return var_0_0
