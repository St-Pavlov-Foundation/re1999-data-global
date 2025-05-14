module("modules.logic.social.model.SocialMessageModel", package.seeall)

local var_0_0 = class("SocialMessageModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._socialMessageMOListDict = {}
	arg_1_0._socialMessageMOListDict[SocialEnum.ChannelType.Friend] = {}
	arg_1_0._messageUnreadDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._socialMessageMOListDict = {}
	arg_2_0._socialMessageMOListDict[SocialEnum.ChannelType.Friend] = {}
	arg_2_0._messageUnreadDict = nil
end

function var_0_0.loadSocialMessages(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0._socialMessageMOListDict[arg_3_1][arg_3_2] then
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_3) do
			local var_3_1 = SocialMessageMO.New()

			var_3_1:init(iter_3_1)
			table.insert(var_3_0, var_3_1)
		end

		arg_3_0._socialMessageMOListDict[arg_3_1][arg_3_2] = var_3_0
	end
end

function var_0_0.saveSocialMessages(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._socialMessageMOListDict[arg_4_1][arg_4_2] then
		SocialMessageController.instance:writeSocialMessages(arg_4_1, arg_4_2, arg_4_0._socialMessageMOListDict[arg_4_1][arg_4_2])
	end
end

function var_0_0.getSocialMessageMOList(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 or not arg_5_2 then
		return
	end

	if not arg_5_0._socialMessageMOListDict[arg_5_1][arg_5_2] then
		SocialMessageController.instance:readSocialMessages(arg_5_1, arg_5_2)
	end

	return arg_5_0._socialMessageMOListDict[arg_5_1][arg_5_2]
end

function var_0_0.loadMessageUnread(arg_6_0, arg_6_1)
	arg_6_0._messageUnreadDict = arg_6_1
end

function var_0_0.saveMessageUnread(arg_7_0)
	if arg_7_0._messageUnreadDict then
		SocialMessageController.instance:writeMessageUnread(arg_7_0._messageUnreadDict)
	end
end

function var_0_0.getMessageUnread(arg_8_0)
	if not arg_8_0._messageUnreadDict then
		SocialMessageController.instance:readMessageUnread()
	end

	return arg_8_0._messageUnreadDict
end

function var_0_0.getUnReadLastMsgTime(arg_9_0, arg_9_1)
	if not arg_9_0._messageUnreadDict then
		arg_9_0._messageUnreadDict = arg_9_0:getMessageUnread()
	end

	arg_9_0._messageUnreadDict[SocialEnum.ChannelType.Friend] = arg_9_0._messageUnreadDict[SocialEnum.ChannelType.Friend] or {}

	if not arg_9_0._messageUnreadDict[SocialEnum.ChannelType.Friend][arg_9_1] then
		return 0
	end

	return arg_9_0._messageUnreadDict[SocialEnum.ChannelType.Friend][arg_9_1].lastTime
end

function var_0_0.addMessageUnread(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_0._messageUnreadDict then
		arg_10_0._messageUnreadDict = arg_10_0:getMessageUnread()
	end

	arg_10_0._messageUnreadDict[arg_10_1] = arg_10_0._messageUnreadDict[arg_10_1] or {}
	arg_10_0._messageUnreadDict[arg_10_1][arg_10_2] = arg_10_0._messageUnreadDict[arg_10_1][arg_10_2] or {
		count = 0,
		lastTime = 0
	}
	arg_10_0._messageUnreadDict[arg_10_1][arg_10_2].count = arg_10_0._messageUnreadDict[arg_10_1][arg_10_2].count + arg_10_3

	if arg_10_4 then
		local var_10_0 = tonumber(arg_10_4)

		if var_10_0 > arg_10_0._messageUnreadDict[arg_10_1][arg_10_2].lastTime then
			arg_10_0._messageUnreadDict[arg_10_1][arg_10_2].lastTime = var_10_0
		end
	end

	if arg_10_3 ~= 0 then
		arg_10_0:updateRedDotGroup()
	end

	arg_10_0:saveMessageUnread()
end

function var_0_0.clearMessageUnread(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_0._messageUnreadDict then
		arg_11_0._messageUnreadDict = arg_11_0:getMessageUnread()
	end

	arg_11_0._messageUnreadDict[arg_11_1] = arg_11_0._messageUnreadDict[arg_11_1] or {}

	if arg_11_3 then
		arg_11_0._messageUnreadDict[arg_11_1][arg_11_2] = nil
	elseif arg_11_0._messageUnreadDict[arg_11_1][arg_11_2] then
		arg_11_0._messageUnreadDict[arg_11_1][arg_11_2].count = 0
		arg_11_0._messageUnreadDict[arg_11_1][arg_11_2].lastTime = 0
	end

	arg_11_0:updateRedDotGroup()
	arg_11_0:saveMessageUnread()
end

function var_0_0.getFriendMessageUnread(arg_12_0, arg_12_1)
	if not arg_12_0._messageUnreadDict then
		arg_12_0._messageUnreadDict = arg_12_0:getMessageUnread()
	end

	arg_12_0._messageUnreadDict[SocialEnum.ChannelType.Friend] = arg_12_0._messageUnreadDict[SocialEnum.ChannelType.Friend] or {}

	local var_12_0 = arg_12_0._messageUnreadDict[SocialEnum.ChannelType.Friend][arg_12_1]

	return var_12_0 and var_12_0.count or 0
end

function var_0_0.getMessageUnreadRedDotGroup(arg_13_0)
	local var_13_0 = {}

	var_13_0.defineId = 1006

	local var_13_1 = {}
	local var_13_2 = SocialModel.instance:getFriendIdDict()

	for iter_13_0, iter_13_1 in pairs(var_13_2) do
		local var_13_3 = {
			id = tonumber(iter_13_0),
			value = arg_13_0:getFriendMessageUnread(iter_13_0)
		}

		var_13_3.time = 0
		var_13_3.ext = ""

		table.insert(var_13_1, var_13_3)
	end

	if #var_13_1 <= 0 then
		local var_13_4 = {}

		var_13_4.id = 0
		var_13_4.value = 0
		var_13_4.time = 0

		table.insert(var_13_1, var_13_4)
	end

	var_13_0.infos = var_13_1
	var_13_0.replaceAll = true

	return var_13_0
end

function var_0_0.updateRedDotGroup(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = arg_14_0:getMessageUnreadRedDotGroup()

	table.insert(var_14_1, var_14_2)

	var_14_0.redDotInfos = var_14_1
	var_14_0.replaceAll = false

	RedDotModel.instance:updateRedDotInfo(var_14_0.redDotInfos)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateFriendInfoDot, var_14_0.redDotInfos)
end

function var_0_0.addSocialMessage(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.channelType
	local var_15_1 = 0
	local var_15_2 = false

	if var_15_0 == SocialEnum.ChannelType.Friend then
		if PlayerModel.instance:getMyUserId() == arg_15_1.senderId then
			var_15_1 = arg_15_1.recipientId
			var_15_2 = true
		else
			var_15_1 = arg_15_1.senderId
		end
	end

	if not arg_15_0._socialMessageMOListDict[var_15_0][var_15_1] then
		arg_15_0._socialMessageMOListDict[var_15_0][var_15_1] = arg_15_0:getSocialMessageMOList(var_15_0, var_15_1)
	end

	local var_15_3 = arg_15_0._socialMessageMOListDict[var_15_0][var_15_1]

	for iter_15_0, iter_15_1 in ipairs(var_15_3) do
		if iter_15_1.msgId == arg_15_1.msgId then
			return
		end
	end

	local var_15_4 = SocialMessageMO.New()

	var_15_4:init(arg_15_1)
	table.insert(var_15_3, var_15_4)
	arg_15_0:saveSocialMessages(var_15_0, var_15_1)

	if var_15_2 then
		arg_15_0:addMessageUnread(var_15_0, var_15_1, 0)
	else
		arg_15_0:addMessageUnread(var_15_0, var_15_1, 1, arg_15_1.sendTime)
	end

	SocialController.instance:dispatchEvent(SocialEvent.MessageInfoChanged)
end

function var_0_0.deleteSocialMessage(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._socialMessageMOListDict[arg_16_1][arg_16_2] = {}

	arg_16_0:saveSocialMessages(arg_16_1, arg_16_2)
	arg_16_0:clearMessageUnread(arg_16_1, arg_16_2, true)
	SocialController.instance:dispatchEvent(SocialEvent.MessageInfoChanged)
end

function var_0_0.ensureDeleteSocialMessage(arg_17_0)
	local var_17_0 = arg_17_0:getMessageUnread()[SocialEnum.ChannelType.Friend]

	if not var_17_0 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if not SocialModel.instance:isMyFriendByUserId(iter_17_0) then
			arg_17_0:deleteSocialMessage(SocialEnum.ChannelType.Friend, iter_17_0)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
