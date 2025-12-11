module("modules.logic.fight.system.work.FightWorkFlowSequence", package.seeall)

local var_0_0 = class("FightWorkFlowSequence", FightWorkFlowBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._workList = {}
	arg_1_0._curIndex = 0
	arg_1_0._startIndex = 0
	arg_1_0._playStartCount = 0
end

function var_0_0.registWork(arg_2_0, arg_2_1, ...)
	return arg_2_0:registWorkAtIndex(#arg_2_0._workList + 1, arg_2_1, ...)
end

function var_0_0.registWorkAtIndex(arg_3_0, arg_3_1, arg_3_2, ...)
	local var_3_0 = arg_3_0:newClass(arg_3_2, ...)

	arg_3_0:addWorkAtIndex(arg_3_1, var_3_0)

	return var_3_0
end

function var_0_0.addWork(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	if not arg_4_1.IS_FIGHT_WORK then
		arg_4_1 = FightWorkPlayNormalWork.New(arg_4_1)
	end

	arg_4_0:addWorkAtIndex(#arg_4_0._workList + 1, arg_4_1)
end

function var_0_0.addWorkAtIndex(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 then
		return
	end

	arg_5_2:registFinishCallback(arg_5_0.onWorkItemDone, arg_5_0, arg_5_2)
	table.insert(arg_5_0._workList, arg_5_1, arg_5_2)
end

function var_0_0.listen2Work(arg_6_0, arg_6_1)
	arg_6_0:listen2WorkAtIndex(#arg_6_0._workList + 1, arg_6_1)
end

function var_0_0.listen2WorkAtIndex(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:registWorkAtIndex(arg_7_1, FightWorkListen2WorkDone, arg_7_2)
end

function var_0_0.onStart(arg_8_0)
	arg_8_0:cancelFightWorkSafeTimer()

	return arg_8_0:_playNext()
end

function var_0_0._playNext(arg_9_0)
	arg_9_0._curIndex = arg_9_0._curIndex + 1

	local var_9_0 = arg_9_0._workList[arg_9_0._curIndex]

	if var_9_0 then
		if var_9_0.WORK_IS_FINISHED or var_9_0.IS_DISPOSED then
			return arg_9_0:_playNext()
		elseif not var_9_0.STARTED then
			arg_9_0._playStartCount = arg_9_0._playStartCount + 1

			if arg_9_0._playStartCount == 1 then
				arg_9_0._startIndex = arg_9_0._curIndex

				while arg_9_0._playStartCount ~= 0 do
					local var_9_1 = arg_9_0._workList[arg_9_0._startIndex]

					xpcall(var_9_1.start, __G__TRACKBACK__, var_9_1, arg_9_0.context)

					arg_9_0._playStartCount = arg_9_0._playStartCount - 1
					arg_9_0._startIndex = arg_9_0._startIndex + 1
				end

				if arg_9_0._curIndex > #arg_9_0._workList then
					return arg_9_0:onDone(true)
				end
			elseif arg_9_0._playStartCount < 1 then
				return arg_9_0:onDone(true)
			end
		end
	elseif arg_9_0._playStartCount == 0 then
		return arg_9_0:onDone(true)
	end
end

function var_0_0.onWorkItemDone(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0._workList[arg_10_0._curIndex] then
		return arg_10_0:_playNext()
	end
end

function var_0_0.onDestructor(arg_11_0)
	for iter_11_0 = #arg_11_0._workList, 1, -1 do
		arg_11_0._workList[iter_11_0]:disposeSelf()
	end
end

function var_0_0.registWorkAtNext(arg_12_0, arg_12_1, ...)
	return arg_12_0:registWorkAtIndex(arg_12_0._curIndex + 1, arg_12_1, ...)
end

function var_0_0.addWorkAtNext(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	arg_13_0:addWorkAtIndex(arg_13_0._curIndex + 1, arg_13_1)
end

function var_0_0.listen2WorkAtNext(arg_14_0, arg_14_1)
	arg_14_0:listen2WorkAtIndex(arg_14_0._curIndex + 1, arg_14_1)
end

return var_0_0
