module("modules.logic.versionactivity1_2.jiexika.rpc.Activity114Rpc", package.seeall)

slot0 = class("Activity114Rpc", BaseRpc)

function slot0.sendGet114InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity114Module_pb.Get114InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet114InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance:onGetInfo(slot2.activityId, slot2.infos)
		Activity114FeaturesModel.instance:onFeatureListUpdate(slot2.infos.features)
		Activity114TaskModel.instance:onGetTaskList(slot2.act114Tasks)
	end
end

function slot0.onReceiveAct114InfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance:onGetInfo(slot2.activityId, slot2.infos)
		Activity114FeaturesModel.instance:onFeatureListUpdate(slot2.infos.features)
	end
end

function slot0.onReceiveAct114TaskPush(slot0, slot1, slot2)
	if slot1 == 0 then
		if Activity114Model.instance:isEnd() then
			return
		end

		Activity114TaskModel.instance:onTaskListUpdate(slot2.act114Tasks, slot2.deleteTasks)
	end
end

function slot0.receiveTaskReward(slot0, slot1, slot2)
	slot3 = Activity114Module_pb.ReceiveAct114TaskRewardRequest()
	slot3.activityId = slot1
	slot3.taskId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveReceiveAct114TaskRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0._clearNewUnLock(slot0)
	Activity114Model.instance.newUnLockFeature = {}
	Activity114Model.instance.newUnLockMeeting = {}
	Activity114Model.instance.newUnLockTravel = {}
end

function slot0.eduRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity114Module_pb.Act114EducateRequest()
	slot5.activityId = slot1
	slot5.attrId = slot2

	slot0:_clearNewUnLock()
	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct114EducateReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if not Activity114Model.instance:getEventParams("eventCo") then
			return
		end

		Activity114Model.instance:setEventParams("result", slot2.isSuccess and Activity114Enum.Result.Success or Activity114Enum.Result.Fail)

		slot5 = nil

		if slot2.isSuccess then
			slot6 = string.splitToNumber(slot3.config.successStoryId, "#")

			if Activity114Model.instance.playedEduSuccessStory and slot6 then
				tabletool.removeValue(slot6, Activity114Model.instance.playedEduSuccessStory)
			end

			if slot6 and #slot6 > 0 then
				slot5 = slot6[math.random(1, #slot6)]
			end

			Activity114Model.instance.playedEduSuccessStory = slot5
		else
			slot5 = slot3.config.failureStoryId
		end

		Activity114Model.instance:setEventParams("storyId", slot5)
	end
end

function slot0.travelRequest(slot0, slot1, slot2)
	slot3 = Activity114Module_pb.Act114TravelRequest()
	slot3.activityId = slot1
	slot3.travelId = slot2

	slot0:_clearNewUnLock()
	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct114TravelReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ViewMgr.instance:closeView(ViewName.Activity114TravelView)

		slot4 = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[slot2.travelId]

		if Activity114Model.instance.unLockTravelDict[slot2.travelId].hasSpecialEvent and slot4.specialEvents > 0 then
			Activity114Model.instance:beginEvent({
				type = Activity114Enum.EventType.Meet,
				eventId = slot4.specialEvents
			})

			return
		end

		slot7 = string.splitToNumber(slot4.events, "#")[slot3.times + 1]

		if slot3.isBlock == 1 or not slot6[slot3.times + 1] or not Activity114Model.instance.unLockEventDict[slot6[slot3.times + 1]] then
			slot7 = slot4.residentEvent
		end

		Activity114Model.instance:beginEvent({
			type = Activity114Enum.EventType.Travel,
			eventId = slot7
		})
	end
end

function slot0.meetRequest(slot0, slot1, slot2)
	slot3 = Activity114Module_pb.Act114MeetingRequest()
	slot3.activityId = slot1
	slot3.meetingId = slot2

	slot0:_clearNewUnLock()
	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct114MeetingReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ViewMgr.instance:closeView(ViewName.Activity114MeetView)
		Activity114Model.instance:beginEvent({
			type = Activity114Enum.EventType.Meet,
			eventId = string.splitToNumber(Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)[slot2.meetingId].events, "#")[Activity114Model.instance.unLockMeetingDict[slot2.meetingId].times + 1]
		})
	end
end

function slot0.checkRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity114Module_pb.CheckEventRequest()
	slot5.activityId = slot1
	slot5.isCheck = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveCheckEventReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if not Activity114Model.instance:getEventParams("eventCo") then
			return
		end

		slot4, slot5 = nil

		if slot3.config.isCheckEvent == 0 then
			slot5 = nil
			slot4 = Activity114Enum.Result.Success
		elseif slot2.dices[1] then
			slot5 = slot2.dices
			slot4 = slot2.isSuccess and Activity114Enum.Result.Success or Activity114Enum.Result.Fail
		else
			slot5 = nil
			slot4 = Activity114Enum.Result.None
		end

		Activity114Model.instance:setEventParams("diceResult", slot5)
		Activity114Model.instance:setEventParams("result", slot4)

		if Activity114Model.instance.serverData.testEventId <= 0 then
			ViewMgr.instance:closeView(ViewName.Activity114EventSelectView)
		else
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseView, ViewName.Activity114EventSelectView)
		end
	end
end

function slot0.keyDayRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity114Module_pb.Act114KeyDayRequest()
	slot4.activityId = slot1

	slot0:_clearNewUnLock()
	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct114KeyDayReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.answerRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity114Module_pb.Act114TestRequest()
	slot5.activityId = slot1
	slot5.choice = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct114TestReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance.serverData.currentTest = slot2.currentTest

		if slot2.successStatus ~= Activity114Enum.Result.NoFinish then
			Activity114Model.instance:setEventParams("result", slot2.successStatus)
			Activity114Model.instance:setEventParams("totalScore", slot2.score)
			ViewMgr.instance:closeView(ViewName.Activity114EventSelectView)
		else
			Activity114Model.instance:setEventParams("answerIds", Activity114Model.instance.serverData.testIds)
		end
	end
end

function slot0.resetRequest(slot0, slot1)
	slot2 = Activity114Module_pb.Act114ResetRequest()
	slot2.activityId = slot1

	Activity114Model.instance:setResetRound()
	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct114ResetReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance:endStat(false, true)
		Activity114Model.instance:beginStat()

		Activity114Model.instance.playedEduSuccessStory = nil

		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEnterSchoolUpdate)
	end
end

function slot0.restRequest(slot0, slot1)
	slot2 = Activity114Module_pb.Act114RestRequest()
	slot2.activityId = slot1

	slot0:_clearNewUnLock()

	Activity114Model.instance.preServerData = Activity114Model.instance.serverData

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct114RestReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if not Activity114Config.instance:getRestEventCo(slot2.activityId, slot2.successStatus) then
			logError("没有洁西卡休息事件配置" .. slot2.activityId .. "  ++++ " .. slot2.successStatus)

			return
		end

		Activity114Model.instance:beginEvent({
			type = Activity114Enum.EventType.Rest,
			eventId = slot3.config.id,
			result = slot2.successStatus,
			preAttention = Activity114Model.instance.preServerData.attention,
			nowDay = Activity114Model.instance.preServerData.day,
			nowRound = Activity114Model.instance.preServerData.round
		})
	end

	Activity114Model.instance.preServerData = nil
end

function slot0.beforeBattle(slot0, slot1)
	slot2 = Activity114Module_pb.BeforeAct114BattleRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveBeforeAct114BattleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.enterSchool(slot0, slot1)
	slot2 = Activity114Module_pb.EnterSchoolRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveEnterSchoolReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance.serverData.isEnterSchool = true
	end
end

function slot0.markRoundStory(slot0, slot1, slot2, slot3)
	slot4 = Activity114Module_pb.MarkRoundStoryRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveMarkRoundStoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.markMeetingPlayUnlock(slot0, slot1, slot2)
	slot3 = Activity114Module_pb.MarkMeetingPlayUnlockRequest()
	slot3.activityId = slot1
	slot3.meetingId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveMarkMeetingPlayUnlockReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance.unLockMeetingDict[slot2.meetingId].isPlayUnlock = 1

		Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	end
end

function slot0.markTravelPlayUnlock(slot0, slot1, slot2)
	slot3 = Activity114Module_pb.MarkTravelPlayUnlockRequest()
	slot3.activityId = slot1
	slot3.travelId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveMarkTravelPlayUnlockReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity114Model.instance.unLockTravelDict[slot2.travelId].isPlayUnlock = 1

		Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	end
end

function slot0.markPhotoRed(slot0, slot1)
	slot2 = Activity114Module_pb.MarkUnlockNewPhotoRedDotRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkUnlockNewPhotoRedDotReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

slot0.instance = slot0.New()

return slot0
