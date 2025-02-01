module("modules.logic.social.controller.SocialMessageController", package.seeall)

slot0 = class("SocialMessageController", BaseController)

function slot0.onInit(slot0)
	slot0._tempListDict = {
		[SocialEnum.ChannelType.Friend] = {}
	}
end

function slot0.reInit(slot0)
	slot0._tempListDict = {
		[SocialEnum.ChannelType.Friend] = {}
	}
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.readSocialMessages(slot0, slot1, slot2)
	slot5 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(SocialConfig.instance:getSocialMessagesKey(slot1, slot2), nil)) then
		slot5 = slot0:_convertToList(slot1, slot2, slot4)
	end

	SocialMessageModel.instance:loadSocialMessages(slot1, slot2, slot5)
end

function slot0.writeSocialMessages(slot0, slot1, slot2, slot3)
	slot4 = SocialConfig.instance:getSocialMessagesKey(slot1, slot2)
	slot5 = ""

	if slot3 and #slot3 > 0 then
		slot5 = slot0:_convertToPrefs(slot1, slot2, slot3)
	end

	if not string.nilorempty(slot5) then
		PlayerPrefsHelper.setString(slot4, slot5)
	else
		PlayerPrefsHelper.deleteKey(slot4)
	end
end

function slot0._convertToList(slot0, slot1, slot2, slot3)
	slot6 = SocialConfig.instance:getSocialMessageFields()

	for slot11, slot12 in ipairs(cjson.decode(slot3)) do
		setmetatable(slot12, {
			__index = function (slot0, slot1)
				if rawget(slot0, uv0[slot1]) == cjson.null then
					slot3 = nil
				end

				return slot3
			end
		})
	end

	slot0._tempListDict[slot1][slot2] = slot5

	return slot5
end

function slot0._convertToPrefs(slot0, slot1, slot2, slot3)
	slot4 = SocialConfig.instance:getSocialMessageFields()
	slot5 = {}
	slot6 = 1

	if slot0._tempListDict[slot1][slot2] and #slot3 > #slot0._tempListDict[slot1][slot2] then
		slot6 = #slot0._tempListDict[slot1][slot2] + 1
		slot5 = slot0._tempListDict[slot1][slot2]
	end

	for slot10 = slot6, #slot3 do
		for slot16, slot17 in pairs(slot3[slot10]) do
			if slot4[slot16] then
				-- Nothing
			end
		end

		table.insert(slot5, {
			[slot4[slot16]] = slot17
		})
	end

	slot7 = {}

	if SocialEnum.MaxSaveMessageCount < #slot5 then
		for slot13 = 1, slot9 do
			slot7[slot13] = slot5[slot8 - slot9 + slot13]
		end
	else
		slot7 = slot5
	end

	slot0._tempListDict[slot1][slot2] = slot5

	return cjson.encode(slot7)
end

function slot0.readMessageUnread(slot0)
	slot3 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(SocialConfig.instance:getMessageUnreadKey(), nil)) then
		slot8 = "#"

		for slot8, slot9 in ipairs(GameUtil.splitString2(slot2, false, "|", slot8)) do
			if #slot9 >= 4 then
				slot3[tonumber(slot9[1])] = slot3[tonumber(slot9[1])] or {}
				slot3[tonumber(slot9[1])][slot9[2]] = {
					count = tonumber(slot9[3]) or 0,
					lastTime = tonumber(slot9[4]) or 0
				}
			end
		end
	end

	SocialMessageModel.instance:loadMessageUnread(slot3)
end

function slot0.writeMessageUnread(slot0, slot1)
	slot2 = SocialConfig.instance:getMessageUnreadKey()
	slot3 = ""
	slot4 = true

	if slot1 then
		for slot8, slot9 in pairs(slot1) do
			for slot13, slot14 in pairs(slot9) do
				if not slot4 then
					slot3 = slot3 .. "|"
				end

				slot4 = false
				slot3 = string.format("%s%s#%s#%s#%s", slot3, slot8, slot13, slot14.count, slot14.lastTime)
			end
		end
	end

	PlayerPrefsHelper.setString(slot2, slot3)
end

function slot0.opMessageOnClick(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:_getOpFuncByMsgType(slot1.msgType) then
		slot2(slot1)
	end
end

function slot0._getOpFuncByMsgType(slot0, slot1)
	if not slot0._opFuncMsgDict then
		slot0._opFuncMsgDict = {
			[ChatEnum.MsgType.RoomSeekShare] = function (slot0)
				RoomChatShareController.instance:chatSeekShare(slot0)
			end,
			[ChatEnum.MsgType.RoomShareCode] = function (slot0)
				RoomChatShareController.instance:chatShareCode(slot0)
			end
		}
	end

	return slot0._opFuncMsgDict[slot1]
end

slot0.instance = slot0.New()

return slot0
