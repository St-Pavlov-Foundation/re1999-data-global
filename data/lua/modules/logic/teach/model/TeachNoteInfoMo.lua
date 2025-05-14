module("modules.logic.teach.model.TeachNoteInfoMo", package.seeall)

local var_0_0 = pureTable("TeachNoteInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.unlockIds = {}
	arg_1_0.getRewardIds = {}
	arg_1_0.getFinalReward = false
	arg_1_0.openIds = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:update(arg_2_1)
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.unlockIds = arg_3_0:_getUnlockTopicIds(arg_3_1.unlockIds)
	arg_3_0.getRewardIds = arg_3_1.getRewardIds
	arg_3_0.getFinalReward = arg_3_1.getFinalReward
	arg_3_0.openIds = arg_3_0:_getUnlockTopicIds(arg_3_1.openIds)
end

function var_0_0._getUnlockTopicIds(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_1 = TeachNoteConfig.instance:getInstructionLevelCos()

		for iter_4_2, iter_4_3 in pairs(var_4_1) do
			if iter_4_1 == iter_4_3.episodeId then
				table.insert(var_4_0, iter_4_3.id)
			end
		end
	end

	return var_4_0
end

return var_0_0
