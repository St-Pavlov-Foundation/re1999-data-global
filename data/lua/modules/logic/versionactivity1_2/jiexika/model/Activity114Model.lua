module("modules.logic.versionactivity1_2.jiexika.model.Activity114Model", package.seeall)

local var_0_0 = class("Activity114Model", BaseModel)
local var_0_1 = {
	[Activity114Enum.EventType.Edu] = Activity114EduFlow,
	[Activity114Enum.EventType.Rest] = Activity114RestFlow,
	[Activity114Enum.EventType.Meet] = Activity114MeetingFlow,
	[Activity114Enum.EventType.Travel] = Activity114TravelFlow,
	[Activity114Enum.EventType.KeyDay] = Activity114KeyDayFlow
}

function var_0_0.onInit(arg_1_0)
	arg_1_0.eduSelectAttr = nil
	arg_1_0.id = 0
	arg_1_0._isEnd = true
	arg_1_0.serverData = nil
	arg_1_0.unLockMeetingDict = {}
	arg_1_0.unLockTravelDict = {}
	arg_1_0.attrDict = {}
	arg_1_0.featuresDict = {}
	arg_1_0.unLockEventDict = {}
	arg_1_0.unLockPhotoDict = {}
	arg_1_0.changeEventList = {}
	arg_1_0.newPhotos = {}
	arg_1_0.newUnLockTravel = {}
	arg_1_0.newUnLockMeeting = {}
	arg_1_0.newUnLockFeature = {}
	arg_1_0.attrChangeDict = nil
	arg_1_0.waitStoryFinish = false
	arg_1_0.preServerData = nil
	arg_1_0._nextWeekInfo = nil
	arg_1_0._flow = nil
	arg_1_0._storyFlow = nil
	arg_1_0.attrAddPermillage = {}

	for iter_1_0 = 1, Activity114Enum.Attr.End - 1 do
		arg_1_0.attrAddPermillage[iter_1_0] = 0
	end

	arg_1_0.attentionAddPermillage = 0
	arg_1_0.saveUnLockData = nil
	arg_1_0.saveUnLockUserData = nil
	arg_1_0.preEventType = nil
	arg_1_0.preResult = nil
	arg_1_0._statData = nil
	arg_1_0.playedEduSuccessStory = nil
end

function var_0_0.clearFlow(arg_2_0)
	if arg_2_0._flow then
		arg_2_0._flow:onDestroyInternal()
	end

	if arg_2_0._storyFlow then
		arg_2_0._storyFlow:onDestroyInternal()
	end
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:onInit()
end

function var_0_0.beginStoryFlow(arg_4_0)
	if arg_4_0._storyFlow then
		return
	end

	arg_4_0._storyFlow = Activity114RoundBeginFlow.New()

	arg_4_0._storyFlow:registerDoneListener(arg_4_0.onStoryFlowDone, arg_4_0)

	if not arg_4_0._storyFlow:beginFlow() then
		arg_4_0._storyFlow = nil
	end
end

function var_0_0.onStoryFlowDone(arg_5_0, arg_5_1)
	arg_5_0._storyFlow = nil

	if arg_5_1 then
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function var_0_0.have114StoryFlow(arg_6_0)
	return arg_6_0._storyFlow and true or false
end

function var_0_0.beginEvent(arg_7_0, arg_7_1)
	if arg_7_0._flow then
		arg_7_0._flow:onDestroy()
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		ViewMgr.instance:openView(ViewName.Activity114EmptyView, nil, true)
	end

	arg_7_0._flow = var_0_1[arg_7_1.type].New()

	arg_7_0._flow:registerDoneListener(arg_7_0.onFlowDone, arg_7_0)
	arg_7_0._flow:initParams(arg_7_1)
	Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessStart)
end

function var_0_0.buildFlowAndSkipWork(arg_8_0, arg_8_1)
	if arg_8_0._flow then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		ViewMgr.instance:openView(ViewName.Activity114EmptyView, nil, true)
	end

	arg_8_0._flow = var_0_1[arg_8_1.type].New()

	arg_8_0._flow:registerDoneListener(arg_8_0.onFlowDone, arg_8_0)
	arg_8_0._flow:initParams(arg_8_1, true)
end

function var_0_0.setEventParams(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._flow then
		return
	end

	arg_9_0._flow:getContext()[arg_9_1] = arg_9_2
end

function var_0_0.getEventParams(arg_10_0, arg_10_1)
	if not arg_10_0._flow then
		return
	end

	return arg_10_0._flow:getContext()[arg_10_1]
end

function var_0_0.canFinishStory(arg_11_0)
	if not arg_11_0._flow then
		return true
	end

	return arg_11_0._flow:canFinishStory()
end

function var_0_0.onFlowDone(arg_12_0)
	if not arg_12_0._flow then
		return
	end

	ViewMgr.instance:closeView(ViewName.Activity114EmptyView, true, true)
	arg_12_0._flow:unregisterDoneListener(arg_12_0.onFlowDone, arg_12_0)

	arg_12_0._flow = nil

	if arg_12_0.newPhotos[1] then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_12_0._onCloseViewFinish, arg_12_0)
		ViewMgr.instance:openView(ViewName.Activity114GetPhotoView)
	else
		arg_12_0:_checkHaveNextWeekInfo()
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.Activity114GetPhotoView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_13_0._onCloseViewFinish, arg_13_0)
		arg_13_0:_checkHaveNextWeekInfo()
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function var_0_0._checkHaveNextWeekInfo(arg_14_0)
	if not arg_14_0._nextWeekInfo then
		return
	end

	arg_14_0:onGetInfo(arg_14_0.id, arg_14_0._nextWeekInfo)

	for iter_14_0 in pairs(arg_14_0.changeEventList) do
		Activity114Controller.instance:dispatchEvent(iter_14_0)
	end

	arg_14_0.changeEventList = {}
	arg_14_0._nextWeekInfo = nil
end

function var_0_0.onGetInfo(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.serverData and arg_15_0.serverData.week ~= arg_15_2.week and arg_15_0._flow then
		arg_15_0._nextWeekInfo = arg_15_2

		return
	end

	local var_15_0 = false

	if not arg_15_0.serverData then
		arg_15_0.changeEventList[Activity114Event.OnAttentionUpdate] = true
		arg_15_0.changeEventList[Activity114Event.OnCGUpdate] = true
		arg_15_0.changeEventList[Activity114Event.OnAttrUpdate] = true
		arg_15_0.changeEventList[Activity114Event.OnRoundUpdate] = true
		arg_15_0.changeEventList[Activity114Event.OnNewFeature] = true
	else
		if arg_15_2.week ~= arg_15_0.serverData.week then
			arg_15_0.playedEduSuccessStory = nil

			arg_15_0:endStat(true)

			var_15_0 = true
		end

		if arg_15_2.day ~= arg_15_0.serverData.day or arg_15_2.round ~= arg_15_0.serverData.round or arg_15_2.week ~= arg_15_0.serverData.week then
			arg_15_0.changeEventList[Activity114Event.OnRoundUpdate] = true
		end

		if #arg_15_2.photos ~= #arg_15_0.serverData.photos then
			for iter_15_0 = 1, #arg_15_2.photos do
				if not arg_15_0.unLockPhotoDict[arg_15_2.photos[iter_15_0]] then
					table.insert(arg_15_0.newPhotos, arg_15_2.photos[iter_15_0])
				end
			end

			arg_15_0.changeEventList[Activity114Event.OnCGUpdate] = true
		end

		local var_15_1, var_15_2 = Activity114Config.instance:getUnlockIds(arg_15_1)

		if #arg_15_2.meetings ~= #arg_15_0.serverData.meetings then
			for iter_15_1 = 1, #arg_15_2.meetings do
				local var_15_3 = arg_15_2.meetings[iter_15_1].meetingId

				if var_15_1[var_15_3] and not arg_15_0.unLockMeetingDict[var_15_3] then
					table.insert(arg_15_0.newUnLockMeeting, var_15_3)
				end
			end
		end

		if #arg_15_2.travels ~= #arg_15_0.serverData.travels then
			for iter_15_2 = 1, #arg_15_2.travels do
				local var_15_4 = arg_15_2.travels[iter_15_2].travelId

				if not arg_15_0.unLockTravelDict[var_15_4] and var_15_2[var_15_4] then
					table.insert(arg_15_0.newUnLockTravel, var_15_4)
				end
			end
		end

		if #arg_15_2.features ~= #arg_15_0.serverData.features then
			arg_15_0.changeEventList[Activity114Event.OnNewFeature] = true

			for iter_15_3 = 1, #arg_15_2.features do
				local var_15_5 = arg_15_2.features[iter_15_3]

				if not arg_15_0.featuresDict[var_15_5] then
					table.insert(arg_15_0.newUnLockFeature, var_15_5)
				end
			end
		end

		if arg_15_2.attention ~= arg_15_0.serverData.attention then
			arg_15_0.changeEventList[Activity114Event.OnAttentionUpdate] = true
		end

		for iter_15_4 = 1, Activity114Enum.Attr.End - 1 do
			if arg_15_2.attrs[iter_15_4].value ~= arg_15_0.serverData.attrs[iter_15_4].value then
				arg_15_0.changeEventList[Activity114Event.OnAttrUpdate] = true

				break
			end
		end
	end

	arg_15_0.id = arg_15_1
	arg_15_0.serverData = arg_15_2
	arg_15_0._isEnd = false

	arg_15_0:onMeetingChange(arg_15_2.meetings)
	arg_15_0:onTravelChange(arg_15_2.travels)
	arg_15_0:onAttrChange(arg_15_2.attrs)
	arg_15_0:onFeatureChange(arg_15_2.features)
	arg_15_0:onUnLockEventChange(arg_15_2.unlockEventIds)
	arg_15_0:onUnLockPhotoChange(arg_15_2.photos)

	if isDebugBuild and not arg_15_0._flow then
		TaskDispatcher.runDelay(function()
			if not arg_15_0._flow then
				for iter_16_0 in pairs(arg_15_0.changeEventList) do
					Activity114Controller.instance:dispatchEvent(iter_16_0)
				end

				arg_15_0.changeEventList = {}
			end
		end, nil, 0)
	end

	if var_15_0 then
		arg_15_0:beginStat()
	end
end

function var_0_0.onAttrChange(arg_17_0, arg_17_1)
	arg_17_0.attrDict = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0.attrDict[iter_17_1.attrId] = iter_17_1.value
	end

	for iter_17_2 = 1, Activity114Enum.Attr.End - 1 do
		arg_17_0.attrDict[iter_17_2] = arg_17_0.attrDict[iter_17_2] or 0
	end
end

function var_0_0.onFeatureChange(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = 0

	arg_18_0.featuresDict = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		arg_18_0.featuresDict[iter_18_1] = true

		local var_18_2 = Activity114Config.instance:getFeatureCo(arg_18_0.id, iter_18_1)

		if var_18_2 then
			if var_18_2.restEfficiency > 0 then
				var_18_1 = var_18_1 + var_18_2.restEfficiency / 1000
			end

			if not string.nilorempty(var_18_2.courseEfficiency) then
				local var_18_3 = GameUtil.splitString2(var_18_2.courseEfficiency, true, "|", "#")

				for iter_18_2, iter_18_3 in ipairs(var_18_3) do
					var_18_0[iter_18_3[1]] = (var_18_0[iter_18_3[1]] or 0) + iter_18_3[2] / 1000
				end
			end
		end
	end

	for iter_18_4, iter_18_5 in pairs(arg_18_0.attrAddPermillage) do
		arg_18_0.attrAddPermillage[iter_18_4] = var_18_0[iter_18_4] or 0
	end

	arg_18_0.attentionAddPermillage = var_18_1
end

function var_0_0.onUnLockEventChange(arg_19_0, arg_19_1)
	arg_19_0.unLockEventDict = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		arg_19_0.unLockEventDict[iter_19_1] = true
	end
end

function var_0_0.onUnLockPhotoChange(arg_20_0, arg_20_1)
	arg_20_0.unLockPhotoDict = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		arg_20_0.unLockPhotoDict[iter_20_1] = true
	end
end

function var_0_0.onMeetingChange(arg_21_0, arg_21_1)
	arg_21_0.unLockMeetingDict = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		arg_21_0.unLockMeetingDict[iter_21_1.meetingId] = iter_21_1
	end
end

function var_0_0.onTravelChange(arg_22_0, arg_22_1)
	arg_22_0.unLockTravelDict = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		arg_22_0.unLockTravelDict[iter_22_1.travelId] = iter_22_1
	end
end

function var_0_0.haveUnLockMeeting(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.unLockMeetingDict) do
		if not arg_23_0:getIsPlayUnLock(Activity114Enum.EventType.Meet, iter_23_1.meetingId) then
			return true
		end
	end

	return false
end

function var_0_0.haveUnLockTravel(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.unLockTravelDict) do
		if not arg_24_0:getIsPlayUnLock(Activity114Enum.EventType.Travel, iter_24_1.travelId) then
			return true
		end
	end

	return false
end

function var_0_0.getIsPlayUnLock(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0.saveUnLockData then
		local var_25_0 = tostring(PlayerModel.instance:getMyUserId())
		local var_25_1 = PlayerPrefsHelper.getString(PlayerPrefsKey.JieXiKaUnLock, "")

		if not string.nilorempty(var_25_1) then
			arg_25_0.saveUnLockData = cjson.decode(var_25_1)
			arg_25_0.saveUnLockUserData = arg_25_0.saveUnLockData[var_25_0]

			if arg_25_0.saveUnLockData.activityId ~= arg_25_0.id then
				arg_25_0.saveUnLockData = nil
				arg_25_0.saveUnLockUserData = nil
			end
		end

		if not arg_25_0.saveUnLockData then
			arg_25_0.saveUnLockData = {}
			arg_25_0.saveUnLockData.activityId = arg_25_0.id
		end

		if not arg_25_0.saveUnLockUserData then
			arg_25_0.saveUnLockUserData = {}
			arg_25_0.saveUnLockData[var_25_0] = arg_25_0.saveUnLockUserData
		end
	end

	if not arg_25_0.saveUnLockUserData[arg_25_1] or arg_25_0.saveUnLockUserData[arg_25_1] == cjson.null then
		return false
	end

	return arg_25_0.saveUnLockUserData[arg_25_1][arg_25_2] == 1
end

function var_0_0.setIsPlayUnLock(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0:getIsPlayUnLock(arg_26_1, arg_26_2) then
		return
	end

	if not arg_26_0.saveUnLockUserData[arg_26_1] or arg_26_0.saveUnLockUserData[arg_26_1] == cjson.null then
		arg_26_0.saveUnLockUserData[arg_26_1] = {}
	end

	arg_26_0.saveUnLockUserData[arg_26_1][arg_26_2] = 1

	PlayerPrefsHelper.setString(PlayerPrefsKey.JieXiKaUnLock, cjson.encode(arg_26_0.saveUnLockData))
	Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
end

function var_0_0.setEnd(arg_27_0)
	arg_27_0._isEnd = true

	if arg_27_0._flow then
		arg_27_0._flow:destroy()

		arg_27_0._flow = nil
	end

	if arg_27_0._storyFlow then
		arg_27_0._storyFlow:destroy()

		arg_27_0._storyFlow = nil
	end
end

function var_0_0.isEnd(arg_28_0)
	return arg_28_0._isEnd
end

function var_0_0.beginStat(arg_29_0)
	arg_29_0._statData = {}
	arg_29_0._statData.time = ServerTime.now()
	arg_29_0._statData.beginRound = Activity114Config.instance:getRoundCount(arg_29_0.id, arg_29_0.serverData.day, arg_29_0.serverData.round)
end

function var_0_0.setResetRound(arg_30_0)
	if not arg_30_0._statData then
		return
	end

	arg_30_0._statData.resetRound = Activity114Config.instance:getRoundCount(arg_30_0.id, arg_30_0.serverData.day, arg_30_0.serverData.round)
end

function var_0_0.endStat(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._statData then
		return
	end

	local var_31_0 = "中断"

	if arg_31_1 then
		local var_31_1, var_31_2, var_31_3, var_31_4 = Activity114Helper.getWeekEndScore()

		var_31_0 = var_31_4 >= Activity114Config.instance:getConstValue(arg_31_0.id, Activity114Enum.ConstId.ScoreA) and "A" or var_31_4 >= Activity114Config.instance:getConstValue(arg_31_0.id, Activity114Enum.ConstId.ScoreB) and "B" or var_31_4 >= Activity114Config.instance:getConstValue(arg_31_0.id, Activity114Enum.ConstId.ScoreC) and "C" or "E"
	end

	if arg_31_2 then
		var_31_0 = "重置"
	end

	local var_31_5 = {}

	for iter_31_0 = 1, #arg_31_0.serverData.photos do
		var_31_5[iter_31_0] = arg_31_0.serverData.photos[iter_31_0]
	end

	local var_31_6 = Activity114Config.instance:getRoundCount(arg_31_0.id, arg_31_0.serverData.day, arg_31_0.serverData.round)
	local var_31_7 = math.max(0, var_31_6 - arg_31_0._statData.beginRound)

	if arg_31_2 then
		var_31_7 = 0
		var_31_6 = arg_31_0._statData.resetRound or var_31_6
	end

	StatController.instance:track(StatEnum.EventName.Act114Exit, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_31_0._statData.time,
		[StatEnum.EventProperties.Act114Week] = arg_31_0.serverData.week,
		[StatEnum.EventProperties.RoundNum] = var_31_6,
		[StatEnum.EventProperties.IncrementRoundNum] = var_31_7,
		[StatEnum.EventProperties.Act114AllPhoto] = var_31_5,
		[StatEnum.EventProperties.Result] = var_31_0
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
