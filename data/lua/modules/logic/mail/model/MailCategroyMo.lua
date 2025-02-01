module("modules.logic.mail.model.MailCategroyMo", package.seeall)

slot0 = class("MailCategroyMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.mailId = 1
	slot0.state = MailEnum.ReadStatus.Unread
	slot0.createTime = 0
	slot0.params = ""
	slot0.itemGroup = {}
	slot0.sender = ""
	slot0.senderMap = {}
	slot0.senderType = 1
	slot0.titleMap = {}
	slot0.title = ""
	slot0.contentMap = {}
	slot0.icon = ""
	slot0.addressee = ""
	slot0.copy = ""
	slot0.jumpTitle = ""
	slot0.jump = ""
	slot0.expireTime = 0
	slot0.image = ""
	slot0.needShowToast = 0
	slot0.specialTag = nil
end

function slot0.init(slot0, slot1)
	slot0.mailId = slot1.id
	slot0.sender = slot0:getTemplateSender()
	slot0.title = slot0:getTemplateTitle()
	slot0.icon = slot1.icon
	slot0.addressee = slot1.addressee
	slot0.copy = slot1.copy
	slot0.jumpTitle = slot0:getTemplateJumpTitle()
	slot0.jump = slot1.jump
	slot0.image = slot1.image
	slot0.specialTag = slot1.specialTag
	slot0.senderType = slot1.senderType
end

function slot0.getItem(slot0, slot1, slot2)
	slot3 = {}

	if slot2 then
		for slot7, slot8 in ipairs(slot2) do
			slot9 = string.split(slot8, "#")

			for slot13, slot14 in ipairs(slot1) do
				if slot9[1] == string.split(slot14, "#")[1] and slot9[2] == slot15[2] and slot9[3] == slot15[3] then
					table.insert(slot3, slot14)
					table.remove(slot1, slot13)

					break
				end
			end
		end
	end

	for slot7 = 1, #slot1 do
		table.insert(slot3, slot1[slot7])
	end

	for slot7, slot8 in pairs(slot3) do
		table.insert(slot0.itemGroup, string.split(slot8, "#"))
	end
end

function slot0.getExpireTime(slot0, slot1)
	slot0.expireTime = slot1
end

function slot0.getRpc(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.id = tonumber(slot4)
	slot0.state = slot1
	slot0.createTime = slot2
	slot0.params = slot3
	slot0.needShowToast = slot5
	slot0.mailId = slot6
end

function slot0.getMailType1(slot0, slot1)
	slot0.mailId = 0
	slot0.id = tonumber(slot1.incrId)
	slot0.params = slot1.params
	slot0.state = slot1.state
	slot0.createTime = slot1.createTime
	slot0.senderMap = cjson.decode(slot1.sender)
	slot0.titleMap = cjson.decode(slot1.title)
	slot0.contentMap = cjson.decode(slot1.content)
	slot0.copy = slot1.copy
	slot0.expireTime = slot1.expireTime
	slot0.senderType = slot1.senderType or 1
	slot0.jumpTitle = not string.nilorempty(slot1.jumpTitle) and cjson.decode(slot1.jumpTitle) or nil
	slot0.jump = not string.nilorempty(slot1.jump) and cjson.decode(slot1.jump) or nil
end

function slot0.getLangTitle(slot0)
	if string.nilorempty(slot0.titleMap[LangSettings.instance:getCurLangShortcut()]) then
		slot2 = slot0.titleMap[LangSettings.instance:getDefaultLangShortcut()] or slot0:getTemplateTitle()
	end

	if slot2 then
		return slot2
	end
end

function slot0.getJumpLink(slot0)
	if slot0.mailId == 0 then
		if slot0.jump then
			if string.nilorempty(slot0.jump[LangSettings.instance:getCurLangShortcut()]) then
				slot2 = slot0.jump[LangSettings.instance:getDefaultLangShortcut()] or ""
			end

			return slot2
		end
	end

	return slot0.jump
end

function slot0.getSenderType(slot0)
	if slot0.senderType == 0 or slot0.senderType == nil then
		return 1
	end

	return slot0.senderType
end

function slot0.getTemplateTitle(slot0)
	if not lua_mail.configDict[slot0.mailId] then
		return ""
	end

	return slot1.title
end

function slot0.getTemplateJumpTitle(slot0)
	if slot0.mailId == 0 then
		if slot0.jumpTitle then
			if string.nilorempty(slot0.jumpTitle[LangSettings.instance:getCurLangShortcut()]) then
				slot2 = slot0.jumpTitle[LangSettings.instance:getDefaultLangShortcut()] or ""
			end

			return slot2
		else
			return ""
		end
	end

	return lua_mail.configDict[slot0.mailId].jumpTitle
end

function slot0.getLangSender(slot0)
	if string.nilorempty(slot0.senderMap[LangSettings.instance:getCurLangShortcut()]) then
		slot2 = slot0.senderMap[LangSettings.instance:getDefaultLangShortcut()] or slot0:getTemplateSender()
	end

	if slot2 then
		return slot2
	end
end

function slot0.getTemplateSender(slot0)
	if not lua_mail.configDict[slot0.mailId] then
		return ""
	end

	return slot1.sender
end

function slot0.haveBonus(slot0)
	return slot0.itemGroup[1][3] ~= nil
end

function slot0.getLangContent(slot0)
	if string.nilorempty(slot0.contentMap[LangSettings.instance:getCurLangShortcut()]) then
		slot2 = slot0.contentMap[LangSettings.instance:getDefaultLangShortcut()] or slot0:getTemplateContent()
	end

	if slot2 then
		return slot2
	end
end

function slot0.getTemplateContent(slot0)
	if not lua_mail.configDict[slot0.mailId] then
		return ""
	end

	if slot0.params ~= "" then
		slot2 = slot1.content

		for slot7, slot8 in ipairs(string.split(slot0.params, "#")) do
			slot3[slot7] = serverLang(slot8)
		end

		return GameUtil.getSubPlaceholderLuaLang(slot2, slot3)
	else
		return slot1.content
	end
end

return slot0
