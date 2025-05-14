module("modules.logic.social.model.SocialMessageListModel", package.seeall)

local var_0_0 = class("SocialMessageListModel", MixScrollModel)

function var_0_0.setMessageList(arg_1_0, arg_1_1)
	arg_1_0._moList = {}

	local var_1_0 = 0
	local var_1_1 = ServerTime.now()

	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			local var_1_2 = tonumber(iter_1_1.sendTime) / 1000

			if TimeUtil.getDiffDay(var_1_1, var_1_2) >= 1 then
				if var_1_0 == 0 or TimeUtil.getDiffDay(var_1_0, var_1_2) >= 1 then
					local var_1_3 = {
						chattime = TimeUtil.timestampToString2(var_1_2)
					}

					table.insert(arg_1_0._moList, var_1_3)

					var_1_0 = var_1_2
				end
			elseif var_1_2 - var_1_0 >= 300 or var_1_0 == 0 or TimeUtil.getDiffDay(var_1_0, var_1_2) >= 1 then
				local var_1_4 = {
					chattime = TimeUtil.timestampToString4(var_1_2)
				}

				table.insert(arg_1_0._moList, var_1_4)

				var_1_0 = var_1_2
			end

			table.insert(arg_1_0._moList, iter_1_1)

			if SocialConfig.instance:isMsgViolation(iter_1_1.content) then
				local var_1_5 = {}

				var_1_5.showWarm = 1

				table.insert(arg_1_0._moList, var_1_5)
			end
		end
	end

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0._sortFunction(arg_2_0, arg_2_1)
	return arg_2_0.sendTime < arg_2_1.sendTime
end

function var_0_0.getInfoList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getList()

	if not var_3_0 or #var_3_0 <= 0 then
		return {}
	end

	local var_3_1 = gohelper.findChildText(arg_3_1, "#txt_contentself")
	local var_3_2 = gohelper.findChildText(arg_3_1, "#txt_contentothers")
	local var_3_3 = gohelper.findChildText(arg_3_1, "#txt_warm")
	local var_3_4
	local var_3_5 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_6 = 1
		local var_3_7 = 0

		if iter_3_1.chattime then
			var_3_7 = 48
		elseif iter_3_1.showWarm then
			if not var_3_4 and var_3_3 then
				var_3_3.text = luaLang("socialmessageitem_warningtips")
				var_3_4 = 62.9 + var_3_3.preferredHeight
				var_3_3.text = ""
			end

			var_3_7 = var_3_4 or 0
		else
			local var_3_8 = PlayerModel.instance:getMyUserId()
			local var_3_9 = 0
			local var_3_10 = var_3_0[iter_3_0 + 1]

			if var_3_10 then
				if var_3_10.senderId == var_3_8 and iter_3_1.senderId ~= var_3_8 then
					var_3_9 = 13
				elseif var_3_10.senderId ~= var_3_8 and iter_3_1.senderId == var_3_8 then
					var_3_9 = 13
				end
			end

			local var_3_11 = var_3_8 == iter_3_1.senderId and GameUtil.getTextHeightByLine(var_3_1, iter_3_1.content, 37.1) or GameUtil.getTextHeightByLine(var_3_2, iter_3_1.content, 37.1)

			if iter_3_1:isHasOp() then
				var_3_11 = var_3_11 + 40
			end

			var_3_7 = math.max(var_3_11 + 82.9, 120) - var_3_9
		end

		local var_3_12 = SLFramework.UGUI.MixCellInfo.New(var_3_6, var_3_7, nil)

		table.insert(var_3_5, var_3_12)
	end

	return var_3_5
end

var_0_0.instance = var_0_0.New()

return var_0_0
