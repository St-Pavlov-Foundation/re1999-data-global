module("modules.logic.fight.system.work.FightWorkFlowParallel", package.seeall)

local var_0_0 = class("FightWorkFlowParallel", FightWorkFlowBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._workList = {}
	arg_1_0._finishCount = 0
end

function var_0_0.registWork(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0:newClass(arg_2_1, ...)

	arg_2_0:addWork(var_2_0)

	return var_2_0
end

function var_0_0.addWork(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	if not arg_3_1.IS_FIGHT_WORK then
		arg_3_1 = FightWorkPlayNormalWork.New(arg_3_1)
	end

	arg_3_1:registFinishCallback(arg_3_0.onWorkItemDone, arg_3_0, arg_3_1)
	table.insert(arg_3_0._workList, arg_3_1)
end

function var_0_0.listen2Work(arg_4_0, arg_4_1)
	return arg_4_0:registWork(FightWorkListen2WorkDone, arg_4_1)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0:cancelFightWorkSafeTimer()

	if #arg_5_0._workList == 0 then
		return arg_5_0:onDone(true)
	else
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._workList) do
			if iter_5_1.WORK_IS_FINISHED or iter_5_1.IS_DISPOSED then
				arg_5_0._finishCount = arg_5_0._finishCount + 1
			elseif not iter_5_1.STARTED then
				xpcall(iter_5_1.start, __G__TRACKBACK__, iter_5_1, arg_5_0.context)
			end
		end

		if not arg_5_0.IS_DISPOSED and arg_5_0._finishCount == #arg_5_0._workList then
			return arg_5_0:onDone(true)
		end
	end
end

function var_0_0.onWorkItemDone(arg_6_0, arg_6_1)
	arg_6_0._finishCount = arg_6_0._finishCount + 1

	if arg_6_0._finishCount == #arg_6_0._workList then
		return arg_6_0:onDone(true)
	end
end

function var_0_0.onDestructor(arg_7_0)
	for iter_7_0 = #arg_7_0._workList, 1, -1 do
		arg_7_0._workList[iter_7_0]:disposeSelf()
	end
end

return var_0_0
