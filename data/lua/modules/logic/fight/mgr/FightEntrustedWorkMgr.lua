module("modules.logic.fight.mgr.FightEntrustedWorkMgr", package.seeall)

local var_0_0 = class("FightEntrustedWorkMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._workList = {}

	arg_1_0:com_registMsg(FightMsgId.EntrustFightWork, arg_1_0._onEntrustFightWork)
	arg_1_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundSequenceFinish)
end

function var_0_0._onEntrustFightWork(arg_2_0, arg_2_1)
	table.insert(arg_2_0._workList, arg_2_1)
	arg_2_0:com_replyMsg(FightMsgId.EntrustFightWork, true)
end

function var_0_0._onRoundSequenceFinish(arg_3_0)
	for iter_3_0 = #arg_3_0._workList, 1, -1 do
		if arg_3_0._workList[iter_3_0].IS_DISPOSED then
			table.remove(arg_3_0._workList, iter_3_0)
		end
	end
end

function var_0_0.onDestructor(arg_4_0)
	for iter_4_0 = #arg_4_0._workList, 1, -1 do
		local var_4_0 = arg_4_0._workList[iter_4_0]

		var_4_0.FIGHT_WORK_ENTRUSTED = nil

		var_4_0:disposeSelf()
	end
end

return var_0_0
