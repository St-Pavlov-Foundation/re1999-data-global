module("modules.logic.social.model.SocialMessageMO", package.seeall)

local var_0_0 = pureTable("SocialMessageMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.msgId
	arg_1_0.msgId = arg_1_1.msgId
	arg_1_0.channelType = arg_1_1.channelType
	arg_1_0.senderId = arg_1_1.senderId
	arg_1_0.senderName = arg_1_1.senderName
	arg_1_0.portrait = arg_1_1.portrait
	arg_1_0.content = arg_1_1.content
	arg_1_0.sendTime = arg_1_1.sendTime
	arg_1_0.level = arg_1_1.level
	arg_1_0.recipientId = arg_1_1.recipientId
	arg_1_0.msgType = arg_1_1.msgType
	arg_1_0.extData = arg_1_1.extData
end

function var_0_0.getSenderName(arg_2_0)
	local var_2_0 = SocialModel.instance:getPlayerMO(arg_2_0.senderId)

	return var_2_0 and var_2_0.name or arg_2_0.senderName
end

function var_0_0.getPortrait(arg_3_0)
	local var_3_0 = SocialModel.instance:getPlayerMO(arg_3_0.senderId)

	return var_3_0 and var_3_0.portrait or arg_3_0.portrait
end

function var_0_0.getLevel(arg_4_0)
	local var_4_0 = SocialModel.instance:getPlayerMO(arg_4_0.senderId)

	return var_4_0 and var_4_0.level or arg_4_0.level
end

function var_0_0.isHasOp(arg_5_0)
	if ChatEnum.MsgType.RoomSeekShare == arg_5_0.msgType then
		return arg_5_0.recipientId == PlayerModel.instance:getMyUserId()
	elseif ChatEnum.MsgType.RoomShareCode == arg_5_0.msgType then
		return true
	end

	return false
end

return var_0_0
