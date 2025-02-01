module("modules.logic.versionactivity1_2.jiexika.config.Activity114Config", package.seeall)

slot0 = class("Activity114Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity114_photo",
		"activity114_round",
		"activity114_task",
		"activity114_meeting",
		"activity114_difficulty",
		"activity114_const",
		"activity114_test",
		"activity114_motion",
		"activity114_event",
		"activity114_feature",
		"activity114_attribute",
		"activity114_travel"
	}
end

function slot0.onInit(slot0)
	slot0._attrVerify = nil
	slot0._eventDict = nil
	slot0._eduEventDict = nil
	slot0._restEventDict = nil
	slot0._rateDescDict = nil
	slot0._allActivityIds = nil
	slot0._answerFailDict = nil
	slot0._motionDic = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity114_attribute" then
		slot0._attrVerify = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot9 = {
				[slot13] = string.splitToNumber(slot14, "#")
			}

			for slot13, slot14 in ipairs(string.split(slot7.attributeNum, "|")) do
				-- Nothing
			end

			if not slot0._attrVerify[slot7.activityId] then
				slot0._attrVerify[slot7.activityId] = {}
			end

			slot0._attrVerify[slot7.activityId][slot7.id] = slot9
		end
	elseif slot1 == "activity114_event" then
		slot0._eventDict = {}
		slot0._eduEventDict = {}
		slot0._restEventDict = {}
		slot0._allActivityIds = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			if not slot0._eventDict[slot7.activityId] then
				slot0._eventDict[slot7.activityId] = {}
			end

			slot0._allActivityIds[slot7.activityId] = true
			slot8 = {}
			slot9 = {}
			slot10 = {}
			slot11 = {}
			slot12 = {}
			slot13 = {}

			slot0:_splitVerifyInfo(slot7.successVerify, slot9, slot8)
			slot0:_splitVerifyInfo(slot7.failureVerify, slot11, slot10)
			slot0:_splitVerifyInfo(slot7.successBattle, slot13, slot12)

			slot0._eventDict[slot7.activityId][slot7.id] = {
				config = slot7,
				successVerify = slot8,
				failureVerify = slot10,
				successFeatures = slot9,
				failureFeatures = slot11,
				successBattleFeatures = slot13,
				successBattleVerify = slot12
			}

			if slot7.eventType == Activity114Enum.EventType.Edu then
				if not slot0._eduEventDict[slot7.activityId] then
					slot0._eduEventDict[slot7.activityId] = {}
				end

				slot0._eduEventDict[slot7.activityId][tonumber(slot7.param)] = slot14
			elseif slot7.eventType == Activity114Enum.EventType.Rest then
				if not slot0._restEventDict[slot7.activityId] then
					slot0._restEventDict[slot7.activityId] = {}
				end

				slot0._restEventDict[slot7.activityId][tonumber(slot7.param)] = slot14
			end
		end
	elseif slot1 == "activity114_difficulty" then
		slot0._rateDescDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot8 = string.splitToNumber(slot7.interval, ",")
			slot0._rateDescDict[slot6] = {
				min = slot8[1],
				max = slot8[2],
				co = slot7
			}
		end
	elseif slot1 == "activity114_test" then
		slot0._answerFailDict = {}

		for slot6, slot7 in pairs(slot2.configDict) do
			slot0._answerFailDict[slot6] = {}

			for slot11, slot12 in pairs(slot7) do
				if not slot0._answerFailDict[slot6][slot12.testId] then
					slot0._answerFailDict[slot6][slot12.testId] = string.splitToNumber(slot12.result, "#")[1]
				end
			end
		end
	elseif slot1 == "activity114_motion" then
		slot0._motionDic = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			if slot7.type == Activity114Enum.MotionType.Time then
				if not slot0._motionDic[slot7.type] then
					slot0._motionDic[slot7.type] = {}
					slot0._motionDic.firstTime = string.splitToNumber(slot7.param, "#")[1] or 0
					slot0._motionDic.nextTime = slot8[2] or 0
				end

				table.insert(slot0._motionDic[slot7.type], slot7)
			elseif slot7.type == Activity114Enum.MotionType.Click then
				slot0._motionDic[slot7.type] = slot7
			else
				if not slot0._motionDic[slot7.type] then
					slot0._motionDic[slot7.type] = {}
				end

				slot0._motionDic[slot7.type][tonumber(slot7.param)] = slot7
			end
		end
	end
end

function slot0._splitVerifyInfo(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot1) then
		return
	end

	slot7 = "|"

	for slot7, slot8 in pairs(string.split(slot1, slot7)) do
		if not string.splitToNumber(slot8, "#")[1] then
			logError("洁西卡事件奖励配置错误：" .. slot1)
		end

		if slot9[1] == Activity114Enum.AddAttrType.Feature then
			table.insert(slot2, slot9[2])
		elseif slot9[1] and slot9[1] < Activity114Enum.Attr.End or slot9[1] == Activity114Enum.AddAttrType.Attention or slot9[1] == Activity114Enum.AddAttrType.KeyDayScore or slot9[1] == Activity114Enum.AddAttrType.LastKeyDayScore then
			slot3[slot9[1]] = (slot3[slot9[1]] or 0) + slot9[2]
		elseif slot9[1] then
			slot3[slot9[1]] = slot3[slot9[1]] or {}

			table.insert(slot3[slot9[1]], slot9[2])
		end
	end
end

function slot0.getUnlockIds(slot0, slot1)
	slot2 = {
		[slot8.id] = true
	}
	slot3 = {}

	for slot7, slot8 in pairs(lua_activity114_meeting.configDict[slot1]) do
		if string.find(slot8.condition, "^1#") then
			-- Nothing
		end
	end

	for slot7, slot8 in pairs(lua_activity114_travel.configDict[slot1]) do
		if string.find(slot8.condition, "^1#") then
			slot3[slot8.id] = true
		end
	end

	return slot2, slot3
end

function slot0.getAllActivityIds(slot0)
	return slot0._allActivityIds
end

function slot0.getFeatureCo(slot0, slot1, slot2)
	return lua_activity114_feature.configDict[slot1][slot2]
end

function slot0.getFeatureName(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(lua_activity114_feature.configDict[slot1]) do
		table.insert(slot2, slot7.features)
	end

	return slot2
end

function slot0.getMotionCo(slot0)
	return slot0._motionDic
end

function slot0.getAttrVerify(slot0, slot1, slot2, slot3)
	if not slot0._attrVerify[slot1][slot2] then
		return 0
	end

	slot4 = nil

	for slot8, slot9 in ipairs(slot0._attrVerify[slot1][slot2]) do
		if slot9[1] <= slot3 then
			slot4 = slot9[2]
		else
			break
		end
	end

	return slot4 or 0
end

function slot0.getEduEventCo(slot0, slot1, slot2)
	return slot0._eduEventDict[slot1][slot2]
end

function slot0.getRestEventCo(slot0, slot1, slot2)
	return slot0._restEventDict[slot1][slot2]
end

function slot0.getEventCoById(slot0, slot1, slot2)
	return slot0._eventDict[slot1][slot2]
end

function slot0.getMeetingCoList(slot0, slot1)
	return lua_activity114_meeting.configDict[slot1]
end

function slot0.getTravelCoList(slot0, slot1)
	return lua_activity114_travel.configDict[slot1]
end

function slot0.getTaskCoById(slot0, slot1, slot2)
	return lua_activity114_task.configDict[slot1][slot2]
end

function slot0.getAnswerCo(slot0, slot1, slot2)
	return lua_activity114_test.configDict[slot1][slot2]
end

function slot0.getAnswerResult(slot0, slot1, slot2, slot3)
	slot5 = string.splitToNumber(slot0:getAnswerCo(slot1, slot2).result, "#")

	for slot9 = 3, 1, -1 do
		if slot5[slot9] > 0 then
			slot10, slot11 = slot0:getConstValue(slot1, slot5[slot9])

			if slot10 <= slot3 then
				return slot9, slot11
			end
		end
	end

	if slot5[1] > 0 then
		slot6, slot7 = slot0:getConstValue(slot1, slot5[1])

		return 1, slot7
	end

	logError("查找结果失败>>" .. slot4.id .. " >>> " .. slot3)

	return 1, ""
end

function slot0.getRoundCo(slot0, slot1, slot2, slot3)
	return lua_activity114_round.configDict[slot1][slot2][slot3]
end

function slot0.getRoundCount(slot0, slot1, slot2, slot3)
	for slot8 = 1, slot2 - 1 do
		slot4 = slot3 + #lua_activity114_round.configDict[slot1][slot8]
	end

	return slot4
end

function slot0.getKeyDayCo(slot0, slot1, slot2)
	while true do
		if not lua_activity114_round.configDict[slot1][slot2 + 1] or not slot3[1] then
			return
		end

		if slot3[1].type == Activity114Enum.RoundType.KeyDay then
			return slot3[1]
		end

		slot2 = slot2 + 1
	end
end

function slot0.getPhotoCoList(slot0, slot1)
	return lua_activity114_photo.configDict[slot1]
end

function slot0.getRateDes(slot0, slot1)
	for slot5, slot6 in pairs(slot0._rateDescDict) do
		if slot6.min <= slot1 and slot1 <= slot6.max then
			return slot6.co.word, slot5
		end
	end

	return "??", 1
end

function slot0.getEduSuccessRate(slot0, slot1, slot2, slot3)
	if not slot0:getAttrCo(slot1, slot2) then
		return 0
	end

	slot6, slot7, slot8 = nil
	slot3 = Mathf.Clamp(slot3, 0, 100)

	return Mathf.Clamp(Mathf.Floor((string.splitToNumber(slot4.educationAttentionConsts, "#")[1] or 0) / 1000 * slot3^2 + (slot5[2] or 0) / 1000 * slot3 + (slot5[3] or 0) / 1000), 0, 100)
end

function slot0.getAttrName(slot0, slot1, slot2)
	return lua_activity114_attribute.configDict[slot1][slot2].attrName
end

function slot0.getAttrCo(slot0, slot1, slot2)
	return lua_activity114_attribute.configDict[slot1][slot2]
end

function slot0.getAttrMaxValue(slot0, slot1, slot2)
	if not slot0._attrVerify[slot1][slot2] then
		return 0
	end

	return slot3[#slot3][1]
end

function slot0.getConstValue(slot0, slot1, slot2)
	if not (lua_activity114_const.configDict[slot1] and slot3[slot2]) then
		return 0, ""
	end

	return slot4.value, slot4.value2
end

function slot0.getDiceRate(slot0, slot1)
	if slot1 <= 2 then
		return 100
	end

	if slot1 > 12 then
		return 0
	end

	if slot1 >= 7 then
		for slot6 = 1, 14 - slot1 - 1 do
			slot2 = 0 + slot6
		end

		return Mathf.Round(slot2 / 36 * 100)
	else
		for slot6 = 2, slot1 - 1 do
			slot2 = 0 + slot6 - 1
		end

		return Mathf.Round(100 - slot2 / 36 * 100)
	end
end

slot0.instance = slot0.New()

return slot0
