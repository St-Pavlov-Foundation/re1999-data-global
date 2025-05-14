module("modules.logic.versionactivity1_4.act133.model.Activity133ListMO", package.seeall)

local var_0_0 = pureTable("Activity133ListMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actid = arg_1_1.activityId
	arg_1_0.id = arg_1_1.id
	arg_1_0.config = arg_1_1
	arg_1_0.desc = arg_1_1.desc
	arg_1_0.icon = arg_1_1.icon
	arg_1_0.bonus = arg_1_1.bonus
	arg_1_0.needTokens = arg_1_1.needTokens
	arg_1_0.title = arg_1_1.title
	arg_1_0.pos = arg_1_1.pos
end

function var_0_0.isLock(arg_2_0)
	return false
end

function var_0_0.isReceived(arg_3_0)
	return Activity133Model.instance:checkBonusReceived(arg_3_0.id)
end

function var_0_0.getPos(arg_4_0)
	local var_4_0 = string.split(arg_4_0.pos, "#")

	return var_4_0[1], var_4_0[2]
end

return var_0_0
