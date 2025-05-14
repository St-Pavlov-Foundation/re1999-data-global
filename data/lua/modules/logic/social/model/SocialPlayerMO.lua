module("modules.logic.social.model.SocialPlayerMO", package.seeall)

local var_0_0 = pureTable("SocialPlayerMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.userId
	arg_1_0.userId = arg_1_1.userId
	arg_1_0.name = arg_1_1.name
	arg_1_0.level = arg_1_1.level
	arg_1_0.portrait = arg_1_1.portrait
	arg_1_0.time = arg_1_1.time
	arg_1_0.desc = arg_1_1.desc
	arg_1_0.infos = arg_1_1.infos
	arg_1_0.bg = arg_1_1.bg or 0
end

function var_0_0.isSendAddFriend(arg_2_0)
	return arg_2_0._isAdded or false
end

function var_0_0.setAddedFriend(arg_3_0)
	arg_3_0._isAdded = true
end

function var_0_0.isMyFriend(arg_4_0)
	return SocialModel.instance:isMyFriendByUserId(arg_4_0.userId)
end

function var_0_0.isMyBlackList(arg_5_0)
	return SocialModel.instance:isMyBlackListByUserId(arg_5_0.userId)
end

return var_0_0
