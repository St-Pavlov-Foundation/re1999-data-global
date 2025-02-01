module("modules.logic.versionactivity1_2.jiexika.model.Activity114Model", package.seeall)

slot0 = class("Activity114Model", BaseModel)
slot1 = {
	[Activity114Enum.EventType.Edu] = Activity114EduFlow,
	[Activity114Enum.EventType.Rest] = Activity114RestFlow,
	[Activity114Enum.EventType.Meet] = Activity114MeetingFlow,
	[Activity114Enum.EventType.Travel] = Activity114TravelFlow,
	[Activity114Enum.EventType.KeyDay] = Activity114KeyDayFlow
}

function slot0.onInit(slot0)
	slot0.eduSelectAttr = nil
	slot0.id = 0
	slot0._isEnd = true
	slot0.serverData = nil
	slot0.unLockMeetingDict = {}
	slot0.unLockTravelDict = {}
	slot0.attrDict = {}
	slot0.featuresDict = {}
	slot0.unLockEventDict = {}
	slot0.unLockPhotoDict = {}
	slot0.changeEventList = {}
	slot0.newPhotos = {}
	slot0.newUnLockTravel = {}
	slot0.newUnLockMeeting = {}
	slot0.newUnLockFeature = {}
	slot0.attrChangeDict = nil
	slot0.waitStoryFinish = false
	slot0.preServerData = nil
	slot0._nextWeekInfo = nil
	slot0._flow = nil
	slot0._storyFlow = nil
	slot0.attrAddPermillage = {}

	for slot4 = 1, Activity114Enum.Attr.End - 1 do
		slot0.attrAddPermillage[slot4] = 0
	end

	slot0.attentionAddPermillage = 0
	slot0.saveUnLockData = nil
	slot0.saveUnLockUserData = nil
	slot0.preEventType = nil
	slot0.preResult = nil
	slot0._statData = nil
	slot0.playedEduSuccessStory = nil
end

function slot0.clearFlow(slot0)
	if slot0._flow then
		slot0._flow:onDestroyInternal()
	end

	if slot0._storyFlow then
		slot0._storyFlow:onDestroyInternal()
	end
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.beginStoryFlow(slot0)
	if slot0._storyFlow then
		return
	end

	slot0._storyFlow = Activity114RoundBeginFlow.New()

	slot0._storyFlow:registerDoneListener(slot0.onStoryFlowDone, slot0)

	if not slot0._storyFlow:beginFlow() then
		slot0._storyFlow = nil
	end
end

function slot0.onStoryFlowDone(slot0, slot1)
	slot0._storyFlow = nil

	if slot1 then
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function slot0.have114StoryFlow(slot0)
	return slot0._storyFlow and true or false
end

function slot0.beginEvent(slot0, slot1)
	if slot0._flow then
		slot0._flow:onDestroy()
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		ViewMgr.instance:openView(ViewName.Activity114EmptyView, nil, true)
	end

	slot0._flow = uv0[slot1.type].New()

	slot0._flow:registerDoneListener(slot0.onFlowDone, slot0)
	slot0._flow:initParams(slot1)
	Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessStart)
end

function slot0.buildFlowAndSkipWork(slot0, slot1)
	if slot0._flow then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		ViewMgr.instance:openView(ViewName.Activity114EmptyView, nil, true)
	end

	slot0._flow = uv0[slot1.type].New()

	slot0._flow:registerDoneListener(slot0.onFlowDone, slot0)
	slot0._flow:initParams(slot1, true)
end

function slot0.setEventParams(slot0, slot1, slot2)
	if not slot0._flow then
		return
	end

	slot0._flow:getContext()[slot1] = slot2
end

function slot0.getEventParams(slot0, slot1)
	if not slot0._flow then
		return
	end

	return slot0._flow:getContext()[slot1]
end

function slot0.canFinishStory(slot0)
	if not slot0._flow then
		return true
	end

	return slot0._flow:canFinishStory()
end

function slot0.onFlowDone(slot0)
	if not slot0._flow then
		return
	end

	ViewMgr.instance:closeView(ViewName.Activity114EmptyView, true, true)
	slot0._flow:unregisterDoneListener(slot0.onFlowDone, slot0)

	slot0._flow = nil

	if slot0.newPhotos[1] then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		ViewMgr.instance:openView(ViewName.Activity114GetPhotoView)
	else
		slot0:_checkHaveNextWeekInfo()
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.Activity114GetPhotoView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:_checkHaveNextWeekInfo()
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function slot0._checkHaveNextWeekInfo(slot0)
	if not slot0._nextWeekInfo then
		return
	end

	slot4 = slot0._nextWeekInfo

	slot0:onGetInfo(slot0.id, slot4)

	for slot4 in pairs(slot0.changeEventList) do
		Activity114Controller.instance:dispatchEvent(slot4)
	end

	slot0.changeEventList = {}
	slot0._nextWeekInfo = nil
end

function slot0.onGetInfo(slot0, slot1, slot2)
	if slot0.serverData and slot0.serverData.week ~= slot2.week and slot0._flow then
		slot0._nextWeekInfo = slot2

		return
	end

	slot3 = false

	if not slot0.serverData then
		slot0.changeEventList[Activity114Event.OnAttentionUpdate] = true
		slot0.changeEventList[Activity114Event.OnCGUpdate] = true
		slot0.changeEventList[Activity114Event.OnAttrUpdate] = true
		slot0.changeEventList[Activity114Event.OnRoundUpdate] = true
		slot0.changeEventList[Activity114Event.OnNewFeature] = true
	else
		if slot2.week ~= slot0.serverData.week then
			slot0.playedEduSuccessStory = nil

			slot0:endStat(true)

			slot3 = true
		end

		if slot2.day ~= slot0.serverData.day or slot2.round ~= slot0.serverData.round or slot2.week ~= slot0.serverData.week then
			slot0.changeEventList[Activity114Event.OnRoundUpdate] = true
		end

		if #slot2.photos ~= #slot0.serverData.photos then
			for slot7 = 1, #slot2.photos do
				if not slot0.unLockPhotoDict[slot2.photos[slot7]] then
					table.insert(slot0.newPhotos, slot2.photos[slot7])
				end
			end

			slot0.changeEventList[Activity114Event.OnCGUpdate] = true
		end

		slot4, slot5 = Activity114Config.instance:getUnlockIds(slot1)

		if #slot2.meetings ~= #slot0.serverData.meetings then
			for slot9 = 1, #slot2.meetings do
				if slot4[slot2.meetings[slot9].meetingId] and not slot0.unLockMeetingDict[slot10] then
					table.insert(slot0.newUnLockMeeting, slot10)
				end
			end
		end

		if #slot2.travels ~= #slot0.serverData.travels then
			for slot9 = 1, #slot2.travels do
				if not slot0.unLockTravelDict[slot2.travels[slot9].travelId] and slot5[slot10] then
					table.insert(slot0.newUnLockTravel, slot10)
				end
			end
		end

		if #slot2.features ~= #slot0.serverData.features then
			slot0.changeEventList[Activity114Event.OnNewFeature] = true

			for slot9 = 1, #slot2.features do
				if not slot0.featuresDict[slot2.features[slot9]] then
					table.insert(slot0.newUnLockFeature, slot10)
				end
			end
		end

		if slot2.attention ~= slot0.serverData.attention then
			slot0.changeEventList[Activity114Event.OnAttentionUpdate] = true
		end

		for slot9 = 1, Activity114Enum.Attr.End - 1 do
			if slot2.attrs[slot9].value ~= slot0.serverData.attrs[slot9].value then
				slot0.changeEventList[Activity114Event.OnAttrUpdate] = true

				break
			end
		end
	end

	slot0.id = slot1
	slot0.serverData = slot2
	slot0._isEnd = false

	slot0:onMeetingChange(slot2.meetings)
	slot0:onTravelChange(slot2.travels)
	slot0:onAttrChange(slot2.attrs)
	slot0:onFeatureChange(slot2.features)
	slot0:onUnLockEventChange(slot2.unlockEventIds)
	slot0:onUnLockPhotoChange(slot2.photos)

	if isDebugBuild and not slot0._flow then
		TaskDispatcher.runDelay(function ()
			if not uv0._flow then
				for slot3 in pairs(uv0.changeEventList) do
					Activity114Controller.instance:dispatchEvent(slot3)
				end

				uv0.changeEventList = {}
			end
		end, nil, 0)
	end

	if slot3 then
		slot0:beginStat()
	end
end

function slot0.onAttrChange(slot0, slot1)
	slot0.attrDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.attrDict[slot6.attrId] = slot6.value
	end

	for slot5 = 1, Activity114Enum.Attr.End - 1 do
		slot0.attrDict[slot5] = slot0.attrDict[slot5] or 0
	end
end

function slot0.onFeatureChange(slot0, slot1)
	slot2 = {}
	slot0.featuresDict = {}

	for slot7, slot8 in ipairs(slot1) do
		slot0.featuresDict[slot8] = true

		if Activity114Config.instance:getFeatureCo(slot0.id, slot8) then
			if slot9.restEfficiency > 0 then
				slot3 = 0 + slot9.restEfficiency / 1000
			end

			if not string.nilorempty(slot9.courseEfficiency) then
				slot14 = "#"

				for slot14, slot15 in ipairs(GameUtil.splitString2(slot9.courseEfficiency, true, "|", slot14)) do
					slot2[slot15[1]] = (slot2[slot15[1]] or 0) + slot15[2] / 1000
				end
			end
		end
	end

	for slot7, slot8 in pairs(slot0.attrAddPermillage) do
		slot0.attrAddPermillage[slot7] = slot2[slot7] or 0
	end

	slot0.attentionAddPermillage = slot3
end

function slot0.onUnLockEventChange(slot0, slot1)
	slot0.unLockEventDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unLockEventDict[slot6] = true
	end
end

function slot0.onUnLockPhotoChange(slot0, slot1)
	slot0.unLockPhotoDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unLockPhotoDict[slot6] = true
	end
end

function slot0.onMeetingChange(slot0, slot1)
	slot0.unLockMeetingDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unLockMeetingDict[slot6.meetingId] = slot6
	end
end

function slot0.onTravelChange(slot0, slot1)
	slot0.unLockTravelDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unLockTravelDict[slot6.travelId] = slot6
	end
end

function slot0.haveUnLockMeeting(slot0)
	for slot4, slot5 in pairs(slot0.unLockMeetingDict) do
		if not slot0:getIsPlayUnLock(Activity114Enum.EventType.Meet, slot5.meetingId) then
			return true
		end
	end

	return false
end

function slot0.haveUnLockTravel(slot0)
	for slot4, slot5 in pairs(slot0.unLockTravelDict) do
		if not slot0:getIsPlayUnLock(Activity114Enum.EventType.Travel, slot5.travelId) then
			return true
		end
	end

	return false
end

function slot0.getIsPlayUnLock(slot0, slot1, slot2)
	if not slot0.saveUnLockData then
		if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.JieXiKaUnLock, "")) then
			slot0.saveUnLockData = cjson.decode(slot4)
			slot0.saveUnLockUserData = slot0.saveUnLockData[tostring(PlayerModel.instance:getMyUserId())]

			if slot0.saveUnLockData.activityId ~= slot0.id then
				slot0.saveUnLockData = nil
				slot0.saveUnLockUserData = nil
			end
		end

		if not slot0.saveUnLockData then
			slot0.saveUnLockData = {
				activityId = slot0.id
			}
		end

		if not slot0.saveUnLockUserData then
			slot0.saveUnLockUserData = {}
			slot0.saveUnLockData[slot3] = slot0.saveUnLockUserData
		end
	end

	if not slot0.saveUnLockUserData[slot1] or slot0.saveUnLockUserData[slot1] == cjson.null then
		return false
	end

	return slot0.saveUnLockUserData[slot1][slot2] == 1
end

function slot0.setIsPlayUnLock(slot0, slot1, slot2)
	if slot0:getIsPlayUnLock(slot1, slot2) then
		return
	end

	if not slot0.saveUnLockUserData[slot1] or slot0.saveUnLockUserData[slot1] == cjson.null then
		slot0.saveUnLockUserData[slot1] = {}
	end

	slot0.saveUnLockUserData[slot1][slot2] = 1

	PlayerPrefsHelper.setString(PlayerPrefsKey.JieXiKaUnLock, cjson.encode(slot0.saveUnLockData))
	Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
end

function slot0.setEnd(slot0)
	slot0._isEnd = true

	if slot0._flow then
		slot0._flow:destroy()

		slot0._flow = nil
	end

	if slot0._storyFlow then
		slot0._storyFlow:destroy()

		slot0._storyFlow = nil
	end
end

function slot0.isEnd(slot0)
	return slot0._isEnd
end

function slot0.beginStat(slot0)
	slot0._statData = {
		time = ServerTime.now(),
		beginRound = Activity114Config.instance:getRoundCount(slot0.id, slot0.serverData.day, slot0.serverData.round)
	}
end

function slot0.setResetRound(slot0)
	if not slot0._statData then
		return
	end

	slot0._statData.resetRound = Activity114Config.instance:getRoundCount(slot0.id, slot0.serverData.day, slot0.serverData.round)
end

function slot0.endStat(slot0, slot1, slot2)
	if not slot0._statData then
		return
	end

	slot3 = "中断"

	if slot1 then
		slot4, slot5, slot6, slot7 = Activity114Helper.getWeekEndScore()
		slot3 = Activity114Config.instance:getConstValue(slot0.id, Activity114Enum.ConstId.ScoreA) <= slot7 and "A" or Activity114Config.instance:getConstValue(slot0.id, Activity114Enum.ConstId.ScoreB) <= slot7 and "B" or Activity114Config.instance:getConstValue(slot0.id, Activity114Enum.ConstId.ScoreC) <= slot7 and "C" or "E"
	end

	if slot2 then
		slot3 = "重置"
	end

	slot4 = {
		[slot8] = slot0.serverData.photos[slot8]
	}

	for slot8 = 1, #slot0.serverData.photos do
	end

	slot6 = math.max(0, Activity114Config.instance:getRoundCount(slot0.id, slot0.serverData.day, slot0.serverData.round) - slot0._statData.beginRound)

	if slot2 then
		slot6 = 0
		slot5 = slot0._statData.resetRound or slot5
	end

	StatController.instance:track(StatEnum.EventName.Act114Exit, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._statData.time,
		[StatEnum.EventProperties.Act114Week] = slot0.serverData.week,
		[StatEnum.EventProperties.RoundNum] = slot5,
		[StatEnum.EventProperties.IncrementRoundNum] = slot6,
		[StatEnum.EventProperties.Act114AllPhoto] = slot4,
		[StatEnum.EventProperties.Result] = slot3
	})
end

slot0.instance = slot0.New()

return slot0
