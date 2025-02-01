module("modules.logic.social.model.SocialMessageListModel", package.seeall)

slot0 = class("SocialMessageListModel", MixScrollModel)

function slot0.setMessageList(slot0, slot1)
	slot0._moList = {}
	slot2 = 0
	slot3 = ServerTime.now()

	if slot1 then
		for slot7, slot8 in pairs(slot1) do
			if TimeUtil.getDiffDay(slot3, tonumber(slot8.sendTime) / 1000) >= 1 then
				if slot2 == 0 or TimeUtil.getDiffDay(slot2, slot9) >= 1 then
					table.insert(slot0._moList, {
						chattime = TimeUtil.timestampToString2(slot9)
					})

					slot2 = slot9
				end
			elseif slot9 - slot2 >= 300 or slot2 == 0 or TimeUtil.getDiffDay(slot2, slot9) >= 1 then
				table.insert(slot0._moList, {
					chattime = TimeUtil.timestampToString4(slot9)
				})

				slot2 = slot9
			end

			table.insert(slot0._moList, slot8)

			if SocialConfig.instance:isMsgViolation(slot8.content) then
				table.insert(slot0._moList, {
					showWarm = 1
				})
			end
		end
	end

	slot0:setList(slot0._moList)
end

function slot0._sortFunction(slot0, slot1)
	return slot0.sendTime < slot1.sendTime
end

function slot0.getInfoList(slot0, slot1)
	if not slot0:getList() or #slot2 <= 0 then
		return {}
	end

	slot3 = gohelper.findChildText(slot1, "#txt_contentself")
	slot4 = gohelper.findChildText(slot1, "#txt_contentothers")
	slot5 = gohelper.findChildText(slot1, "#txt_warm")
	slot6 = nil
	slot7 = {}

	for slot11, slot12 in ipairs(slot2) do
		slot13 = 1
		slot14 = 0

		if slot12.chattime then
			slot14 = 48
		elseif slot12.showWarm then
			if not slot6 and slot5 then
				slot5.text = luaLang("socialmessageitem_warningtips")
				slot6 = 62.9 + slot5.preferredHeight
				slot5.text = ""
			end

			if not slot6 then
				slot14 = 0
			end
		else
			slot15 = PlayerModel.instance:getMyUserId()
			slot16 = 0

			if slot2[slot11 + 1] then
				if slot17.senderId == slot15 and slot12.senderId ~= slot15 then
					slot16 = 13
				elseif slot17.senderId ~= slot15 and slot12.senderId == slot15 then
					slot16 = 13
				end
			end

			if slot12:isHasOp() then
				slot18 = (slot15 == slot12.senderId and GameUtil.getTextHeightByLine(slot3, slot12.content, 37.1) or GameUtil.getTextHeightByLine(slot4, slot12.content, 37.1)) + 40
			end

			slot14 = math.max(slot18 + 82.9, 120) - slot16
		end

		table.insert(slot7, SLFramework.UGUI.MixCellInfo.New(slot13, slot14, nil))
	end

	return slot7
end

slot0.instance = slot0.New()

return slot0
