module("modules.logic.fight.mgr.FightEntrustedWorkMgr", package.seeall)

local var_0_0 = class("FightEntrustedWorkMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workList = {}

	arg_1_0:com_registMsg(FightMsgId.EntrustFightWork, arg_1_0.onEntrustFightWork)
end

function var_0_0.onEntrustFightWork(arg_2_0, arg_2_1)
	arg_2_1.FIGHT_WORK_ENTRUSTED = true

	local var_2_0 = arg_2_1.PARENT_ROOT_OBJECT

	if var_2_0 then
		local var_2_1 = var_2_0.INSTANTIATE_CLASS_LIST

		if var_2_1 then
			for iter_2_0, iter_2_1 in ipairs(var_2_1) do
				if iter_2_1 == arg_2_1 then
					local var_2_2 = setmetatable({}, FightBaseClass)

					var_2_2.class = FightBaseClass
					var_2_2.PARENT_ROOT_OBJECT = var_2_0

					var_2_2:ctor()

					var_2_1[iter_2_0] = var_2_2

					break
				end
			end
		end
	end

	table.insert(arg_2_0.workList, arg_2_1)
	FightMsgMgr.replyMsg(FightMsgId.EntrustFightWork, true)
end

function var_0_0.onDestructor(arg_3_0)
	for iter_3_0 = #arg_3_0.workList, 1, -1 do
		local var_3_0 = arg_3_0.workList[iter_3_0]

		var_3_0.FIGHT_WORK_ENTRUSTED = nil

		var_3_0:disposeSelf()
	end
end

return var_0_0
