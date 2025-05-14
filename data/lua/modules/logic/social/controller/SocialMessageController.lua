module("modules.logic.social.controller.SocialMessageController", package.seeall)

local var_0_0 = class("SocialMessageController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._tempListDict = {}
	arg_1_0._tempListDict[SocialEnum.ChannelType.Friend] = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._tempListDict = {}
	arg_2_0._tempListDict[SocialEnum.ChannelType.Friend] = {}
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.readSocialMessages(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = SocialConfig.instance:getSocialMessagesKey(arg_5_1, arg_5_2)
	local var_5_1 = PlayerPrefsHelper.getString(var_5_0, nil)
	local var_5_2 = {}

	if not string.nilorempty(var_5_1) then
		var_5_2 = arg_5_0:_convertToList(arg_5_1, arg_5_2, var_5_1)
	end

	SocialMessageModel.instance:loadSocialMessages(arg_5_1, arg_5_2, var_5_2)
end

function var_0_0.writeSocialMessages(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = SocialConfig.instance:getSocialMessagesKey(arg_6_1, arg_6_2)
	local var_6_1 = ""

	if arg_6_3 and #arg_6_3 > 0 then
		var_6_1 = arg_6_0:_convertToPrefs(arg_6_1, arg_6_2, arg_6_3)
	end

	if not string.nilorempty(var_6_1) then
		PlayerPrefsHelper.setString(var_6_0, var_6_1)
	else
		PlayerPrefsHelper.deleteKey(var_6_0)
	end
end

function var_0_0._convertToList(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = cjson.decode(arg_7_3)
	local var_7_1 = SocialConfig.instance:getSocialMessageFields()
	local var_7_2 = {
		__index = function(arg_8_0, arg_8_1)
			local var_8_0 = var_7_1[arg_8_1]
			local var_8_1 = rawget(arg_8_0, var_8_0)

			if var_8_1 == cjson.null then
				var_8_1 = nil
			end

			return var_8_1
		end
	}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		setmetatable(iter_7_1, var_7_2)
	end

	arg_7_0._tempListDict[arg_7_1][arg_7_2] = var_7_0

	return var_7_0
end

function var_0_0._convertToPrefs(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = SocialConfig.instance:getSocialMessageFields()
	local var_9_1 = {}
	local var_9_2 = 1

	if arg_9_0._tempListDict[arg_9_1][arg_9_2] and #arg_9_3 > #arg_9_0._tempListDict[arg_9_1][arg_9_2] then
		var_9_2 = #arg_9_0._tempListDict[arg_9_1][arg_9_2] + 1
		var_9_1 = arg_9_0._tempListDict[arg_9_1][arg_9_2]
	end

	for iter_9_0 = var_9_2, #arg_9_3 do
		local var_9_3 = arg_9_3[iter_9_0]
		local var_9_4 = {}

		for iter_9_1, iter_9_2 in pairs(var_9_3) do
			if var_9_0[iter_9_1] then
				var_9_4[var_9_0[iter_9_1]] = iter_9_2
			end
		end

		table.insert(var_9_1, var_9_4)
	end

	local var_9_5 = {}
	local var_9_6 = #var_9_1
	local var_9_7 = SocialEnum.MaxSaveMessageCount

	if var_9_7 < var_9_6 then
		for iter_9_3 = 1, var_9_7 do
			var_9_5[iter_9_3] = var_9_1[var_9_6 - var_9_7 + iter_9_3]
		end
	else
		var_9_5 = var_9_1
	end

	local var_9_8 = cjson.encode(var_9_5)

	arg_9_0._tempListDict[arg_9_1][arg_9_2] = var_9_1

	return var_9_8
end

function var_0_0.readMessageUnread(arg_10_0)
	local var_10_0 = SocialConfig.instance:getMessageUnreadKey()
	local var_10_1 = PlayerPrefsHelper.getString(var_10_0, nil)
	local var_10_2 = {}

	if not string.nilorempty(var_10_1) then
		local var_10_3 = GameUtil.splitString2(var_10_1, false, "|", "#")

		for iter_10_0, iter_10_1 in ipairs(var_10_3) do
			if #iter_10_1 >= 4 then
				var_10_2[tonumber(iter_10_1[1])] = var_10_2[tonumber(iter_10_1[1])] or {}

				local var_10_4 = {
					count = tonumber(iter_10_1[3]) or 0,
					lastTime = tonumber(iter_10_1[4]) or 0
				}

				var_10_2[tonumber(iter_10_1[1])][iter_10_1[2]] = var_10_4
			end
		end
	end

	SocialMessageModel.instance:loadMessageUnread(var_10_2)
end

function var_0_0.writeMessageUnread(arg_11_0, arg_11_1)
	local var_11_0 = SocialConfig.instance:getMessageUnreadKey()
	local var_11_1 = ""
	local var_11_2 = true

	if arg_11_1 then
		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			for iter_11_2, iter_11_3 in pairs(iter_11_1) do
				if not var_11_2 then
					var_11_1 = var_11_1 .. "|"
				end

				var_11_2 = false
				var_11_1 = string.format("%s%s#%s#%s#%s", var_11_1, iter_11_0, iter_11_2, iter_11_3.count, iter_11_3.lastTime)
			end
		end
	end

	PlayerPrefsHelper.setString(var_11_0, var_11_1)
end

function var_0_0.opMessageOnClick(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0:_getOpFuncByMsgType(arg_12_1.msgType)

	if var_12_0 then
		var_12_0(arg_12_1)
	end
end

function var_0_0._getOpFuncByMsgType(arg_13_0, arg_13_1)
	if not arg_13_0._opFuncMsgDict then
		arg_13_0._opFuncMsgDict = {
			[ChatEnum.MsgType.RoomSeekShare] = function(arg_14_0)
				RoomChatShareController.instance:chatSeekShare(arg_14_0)
			end,
			[ChatEnum.MsgType.RoomShareCode] = function(arg_15_0)
				RoomChatShareController.instance:chatShareCode(arg_15_0)
			end
		}
	end

	return arg_13_0._opFuncMsgDict[arg_13_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
