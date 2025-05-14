module("modules.logic.mail.model.MailCategroyMo", package.seeall)

local var_0_0 = class("MailCategroyMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.mailId = 1
	arg_1_0.state = MailEnum.ReadStatus.Unread
	arg_1_0.createTime = 0
	arg_1_0.params = ""
	arg_1_0.itemGroup = {}
	arg_1_0.sender = ""
	arg_1_0.senderMap = {}
	arg_1_0.senderType = 1
	arg_1_0.titleMap = {}
	arg_1_0.title = ""
	arg_1_0.contentMap = {}
	arg_1_0.icon = ""
	arg_1_0.addressee = ""
	arg_1_0.copy = ""
	arg_1_0.jumpTitle = ""
	arg_1_0.jump = ""
	arg_1_0.expireTime = 0
	arg_1_0.image = ""
	arg_1_0.needShowToast = 0
	arg_1_0.specialTag = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.mailId = arg_2_1.id
	arg_2_0.sender = arg_2_0:getTemplateSender()
	arg_2_0.title = arg_2_0:getTemplateTitle()
	arg_2_0.icon = arg_2_1.icon
	arg_2_0.addressee = arg_2_1.addressee
	arg_2_0.copy = arg_2_1.copy
	arg_2_0.jumpTitle = arg_2_0:getTemplateJumpTitle()
	arg_2_0.jump = arg_2_1.jump
	arg_2_0.image = arg_2_1.image
	arg_2_0.specialTag = arg_2_1.specialTag
	arg_2_0.senderType = arg_2_1.senderType
end

function var_0_0.getItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}

	if arg_3_2 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			local var_3_1 = string.split(iter_3_1, "#")

			for iter_3_2, iter_3_3 in ipairs(arg_3_1) do
				local var_3_2 = string.split(iter_3_3, "#")

				if var_3_1[1] == var_3_2[1] and var_3_1[2] == var_3_2[2] and var_3_1[3] == var_3_2[3] then
					table.insert(var_3_0, iter_3_3)
					table.remove(arg_3_1, iter_3_2)

					break
				end
			end
		end
	end

	for iter_3_4 = 1, #arg_3_1 do
		local var_3_3 = arg_3_1[iter_3_4]

		table.insert(var_3_0, var_3_3)
	end

	for iter_3_5, iter_3_6 in pairs(var_3_0) do
		local var_3_4 = string.split(iter_3_6, "#")

		table.insert(arg_3_0.itemGroup, var_3_4)
	end
end

function var_0_0.getExpireTime(arg_4_0, arg_4_1)
	arg_4_0.expireTime = arg_4_1
end

function var_0_0.getRpc(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	arg_5_0.id = tonumber(arg_5_4)
	arg_5_0.state = arg_5_1
	arg_5_0.createTime = arg_5_2
	arg_5_0.params = arg_5_3
	arg_5_0.needShowToast = arg_5_5
	arg_5_0.mailId = arg_5_6
end

function var_0_0.getMailType1(arg_6_0, arg_6_1)
	arg_6_0.mailId = 0
	arg_6_0.id = tonumber(arg_6_1.incrId)
	arg_6_0.params = arg_6_1.params
	arg_6_0.state = arg_6_1.state
	arg_6_0.createTime = arg_6_1.createTime
	arg_6_0.senderMap = cjson.decode(arg_6_1.sender)
	arg_6_0.titleMap = cjson.decode(arg_6_1.title)
	arg_6_0.contentMap = cjson.decode(arg_6_1.content)
	arg_6_0.copy = arg_6_1.copy
	arg_6_0.expireTime = arg_6_1.expireTime
	arg_6_0.senderType = arg_6_1.senderType or 1
	arg_6_0.jumpTitle = not string.nilorempty(arg_6_1.jumpTitle) and cjson.decode(arg_6_1.jumpTitle) or nil
	arg_6_0.jump = not string.nilorempty(arg_6_1.jump) and cjson.decode(arg_6_1.jump) or nil
end

function var_0_0.getLangTitle(arg_7_0)
	local var_7_0 = LangSettings.instance:getCurLangShortcut()
	local var_7_1 = arg_7_0.titleMap[var_7_0]

	if string.nilorempty(var_7_1) then
		local var_7_2 = LangSettings.instance:getDefaultLangShortcut()

		var_7_1 = arg_7_0.titleMap[var_7_2] or arg_7_0:getTemplateTitle()
	end

	if var_7_1 then
		return var_7_1
	end
end

function var_0_0.getJumpLink(arg_8_0)
	if arg_8_0.mailId == 0 then
		local var_8_0 = LangSettings.instance:getCurLangShortcut()

		if arg_8_0.jump then
			local var_8_1 = arg_8_0.jump[var_8_0]

			if string.nilorempty(var_8_1) then
				local var_8_2 = LangSettings.instance:getDefaultLangShortcut()

				var_8_1 = arg_8_0.jump[var_8_2] or ""
			end

			return var_8_1
		end
	end

	return arg_8_0.jump
end

function var_0_0.getSenderType(arg_9_0)
	if arg_9_0.senderType == 0 or arg_9_0.senderType == nil then
		return 1
	end

	return arg_9_0.senderType
end

function var_0_0.getTemplateTitle(arg_10_0)
	local var_10_0 = lua_mail.configDict[arg_10_0.mailId]

	if not var_10_0 then
		return ""
	end

	return var_10_0.title
end

function var_0_0.getTemplateJumpTitle(arg_11_0)
	if arg_11_0.mailId == 0 then
		local var_11_0 = LangSettings.instance:getCurLangShortcut()

		if arg_11_0.jumpTitle then
			local var_11_1 = arg_11_0.jumpTitle[var_11_0]

			if string.nilorempty(var_11_1) then
				local var_11_2 = LangSettings.instance:getDefaultLangShortcut()

				var_11_1 = arg_11_0.jumpTitle[var_11_2] or ""
			end

			return var_11_1
		else
			return ""
		end
	end

	return lua_mail.configDict[arg_11_0.mailId].jumpTitle
end

function var_0_0.getLangSender(arg_12_0)
	local var_12_0 = LangSettings.instance:getCurLangShortcut()
	local var_12_1 = arg_12_0.senderMap[var_12_0]

	if string.nilorempty(var_12_1) then
		local var_12_2 = LangSettings.instance:getDefaultLangShortcut()

		var_12_1 = arg_12_0.senderMap[var_12_2] or arg_12_0:getTemplateSender()
	end

	if var_12_1 then
		return var_12_1
	end
end

function var_0_0.getTemplateSender(arg_13_0)
	local var_13_0 = lua_mail.configDict[arg_13_0.mailId]

	if not var_13_0 then
		return ""
	end

	return var_13_0.sender
end

function var_0_0.haveBonus(arg_14_0)
	return arg_14_0.itemGroup[1][3] ~= nil
end

function var_0_0.getLangContent(arg_15_0)
	local var_15_0 = LangSettings.instance:getCurLangShortcut()
	local var_15_1 = arg_15_0.contentMap[var_15_0]

	if string.nilorempty(var_15_1) then
		local var_15_2 = LangSettings.instance:getDefaultLangShortcut()

		var_15_1 = arg_15_0.contentMap[var_15_2] or arg_15_0:getTemplateContent()
	end

	if var_15_1 then
		return var_15_1
	end
end

function var_0_0.getTemplateContent(arg_16_0)
	local var_16_0 = lua_mail.configDict[arg_16_0.mailId]

	if not var_16_0 then
		return ""
	end

	if arg_16_0.params ~= "" then
		local var_16_1 = var_16_0.content
		local var_16_2 = string.split(arg_16_0.params, "#")

		for iter_16_0, iter_16_1 in ipairs(var_16_2) do
			var_16_2[iter_16_0] = serverLang(iter_16_1)
		end

		return (GameUtil.getSubPlaceholderLuaLang(var_16_1, var_16_2))
	else
		return var_16_0.content
	end
end

return var_0_0
