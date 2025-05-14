module("modules.logic.versionactivity1_2.jiexika.rpc.Activity114Rpc", package.seeall)

local var_0_0 = class("Activity114Rpc", BaseRpc)

function var_0_0.sendGet114InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity114Module_pb.Get114InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet114InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity114Model.instance:onGetInfo(arg_2_2.activityId, arg_2_2.infos)
		Activity114FeaturesModel.instance:onFeatureListUpdate(arg_2_2.infos.features)
		Activity114TaskModel.instance:onGetTaskList(arg_2_2.act114Tasks)
	end
end

function var_0_0.onReceiveAct114InfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		Activity114Model.instance:onGetInfo(arg_3_2.activityId, arg_3_2.infos)
		Activity114FeaturesModel.instance:onFeatureListUpdate(arg_3_2.infos.features)
	end
end

function var_0_0.onReceiveAct114TaskPush(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		if Activity114Model.instance:isEnd() then
			return
		end

		Activity114TaskModel.instance:onTaskListUpdate(arg_4_2.act114Tasks, arg_4_2.deleteTasks)
	end
end

function var_0_0.receiveTaskReward(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity114Module_pb.ReceiveAct114TaskRewardRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.taskId = arg_5_2

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveReceiveAct114TaskRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		-- block empty
	end
end

function var_0_0._clearNewUnLock(arg_7_0)
	Activity114Model.instance.newUnLockFeature = {}
	Activity114Model.instance.newUnLockMeeting = {}
	Activity114Model.instance.newUnLockTravel = {}
end

function var_0_0.eduRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = Activity114Module_pb.Act114EducateRequest()

	var_8_0.activityId = arg_8_1
	var_8_0.attrId = arg_8_2

	arg_8_0:_clearNewUnLock()
	arg_8_0:sendMsg(var_8_0, arg_8_3, arg_8_4)
end

function var_0_0.onReceiveAct114EducateReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		local var_9_0 = Activity114Model.instance:getEventParams("eventCo")

		if not var_9_0 then
			return
		end

		local var_9_1 = arg_9_2.isSuccess and Activity114Enum.Result.Success or Activity114Enum.Result.Fail

		Activity114Model.instance:setEventParams("result", var_9_1)

		local var_9_2

		if arg_9_2.isSuccess then
			local var_9_3 = string.splitToNumber(var_9_0.config.successStoryId, "#")

			if Activity114Model.instance.playedEduSuccessStory and var_9_3 then
				tabletool.removeValue(var_9_3, Activity114Model.instance.playedEduSuccessStory)
			end

			if var_9_3 and #var_9_3 > 0 then
				var_9_2 = var_9_3[math.random(1, #var_9_3)]
			end

			Activity114Model.instance.playedEduSuccessStory = var_9_2
		else
			var_9_2 = var_9_0.config.failureStoryId
		end

		Activity114Model.instance:setEventParams("storyId", var_9_2)
	end
end

function var_0_0.travelRequest(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = Activity114Module_pb.Act114TravelRequest()

	var_10_0.activityId = arg_10_1
	var_10_0.travelId = arg_10_2

	arg_10_0:_clearNewUnLock()
	arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveAct114TravelReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		ViewMgr.instance:closeView(ViewName.Activity114TravelView)

		local var_11_0 = Activity114Model.instance.unLockTravelDict[arg_11_2.travelId]
		local var_11_1 = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[arg_11_2.travelId]

		if var_11_0.hasSpecialEvent and var_11_1.specialEvents > 0 then
			local var_11_2 = {
				type = Activity114Enum.EventType.Meet,
				eventId = var_11_1.specialEvents
			}

			Activity114Model.instance:beginEvent(var_11_2)

			return
		end

		local var_11_3 = Activity114Model.instance.unLockEventDict
		local var_11_4 = string.splitToNumber(var_11_1.events, "#")
		local var_11_5 = var_11_4[var_11_0.times + 1]

		if var_11_0.isBlock == 1 or not var_11_4[var_11_0.times + 1] or not var_11_3[var_11_4[var_11_0.times + 1]] then
			var_11_5 = var_11_1.residentEvent
		end

		local var_11_6 = {
			type = Activity114Enum.EventType.Travel,
			eventId = var_11_5
		}

		Activity114Model.instance:beginEvent(var_11_6)
	end
end

function var_0_0.meetRequest(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = Activity114Module_pb.Act114MeetingRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.meetingId = arg_12_2

	arg_12_0:_clearNewUnLock()
	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveAct114MeetingReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		ViewMgr.instance:closeView(ViewName.Activity114MeetView)

		local var_13_0 = Activity114Model.instance.unLockMeetingDict[arg_13_2.meetingId]
		local var_13_1 = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)[arg_13_2.meetingId]
		local var_13_2 = string.splitToNumber(var_13_1.events, "#")
		local var_13_3 = {
			type = Activity114Enum.EventType.Meet,
			eventId = var_13_2[var_13_0.times + 1]
		}

		Activity114Model.instance:beginEvent(var_13_3)
	end
end

function var_0_0.checkRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Activity114Module_pb.CheckEventRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.isCheck = arg_14_2

	arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveCheckEventReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		local var_15_0 = Activity114Model.instance:getEventParams("eventCo")

		if not var_15_0 then
			return
		end

		local var_15_1
		local var_15_2

		if var_15_0.config.isCheckEvent == 0 then
			var_15_2 = nil
			var_15_1 = Activity114Enum.Result.Success
		elseif arg_15_2.dices[1] then
			var_15_2 = arg_15_2.dices
			var_15_1 = arg_15_2.isSuccess and Activity114Enum.Result.Success or Activity114Enum.Result.Fail
		else
			var_15_2 = nil
			var_15_1 = Activity114Enum.Result.None
		end

		Activity114Model.instance:setEventParams("diceResult", var_15_2)
		Activity114Model.instance:setEventParams("result", var_15_1)

		if Activity114Model.instance.serverData.testEventId <= 0 then
			ViewMgr.instance:closeView(ViewName.Activity114EventSelectView)
		else
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseView, ViewName.Activity114EventSelectView)
		end
	end
end

function var_0_0.keyDayRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = Activity114Module_pb.Act114KeyDayRequest()

	var_16_0.activityId = arg_16_1

	arg_16_0:_clearNewUnLock()
	arg_16_0:sendMsg(var_16_0, arg_16_2, arg_16_3)
end

function var_0_0.onReceiveAct114KeyDayReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		-- block empty
	end
end

function var_0_0.answerRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = Activity114Module_pb.Act114TestRequest()

	var_18_0.activityId = arg_18_1
	var_18_0.choice = arg_18_2

	arg_18_0:sendMsg(var_18_0, arg_18_3, arg_18_4)
end

function var_0_0.onReceiveAct114TestReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		Activity114Model.instance.serverData.currentTest = arg_19_2.currentTest

		if arg_19_2.successStatus ~= Activity114Enum.Result.NoFinish then
			Activity114Model.instance:setEventParams("result", arg_19_2.successStatus)
			Activity114Model.instance:setEventParams("totalScore", arg_19_2.score)
			ViewMgr.instance:closeView(ViewName.Activity114EventSelectView)
		else
			Activity114Model.instance:setEventParams("answerIds", Activity114Model.instance.serverData.testIds)
		end
	end
end

function var_0_0.resetRequest(arg_20_0, arg_20_1)
	local var_20_0 = Activity114Module_pb.Act114ResetRequest()

	var_20_0.activityId = arg_20_1

	Activity114Model.instance:setResetRound()
	arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveAct114ResetReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		Activity114Model.instance:endStat(false, true)
		Activity114Model.instance:beginStat()

		Activity114Model.instance.playedEduSuccessStory = nil

		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEnterSchoolUpdate)
	end
end

function var_0_0.restRequest(arg_22_0, arg_22_1)
	local var_22_0 = Activity114Module_pb.Act114RestRequest()

	var_22_0.activityId = arg_22_1

	arg_22_0:_clearNewUnLock()

	Activity114Model.instance.preServerData = Activity114Model.instance.serverData

	arg_22_0:sendMsg(var_22_0)
end

function var_0_0.onReceiveAct114RestReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		local var_23_0 = Activity114Config.instance:getRestEventCo(arg_23_2.activityId, arg_23_2.successStatus)

		if not var_23_0 then
			logError("没有洁西卡休息事件配置" .. arg_23_2.activityId .. "  ++++ " .. arg_23_2.successStatus)

			return
		end

		local var_23_1 = {
			type = Activity114Enum.EventType.Rest,
			eventId = var_23_0.config.id,
			result = arg_23_2.successStatus,
			preAttention = Activity114Model.instance.preServerData.attention,
			nowDay = Activity114Model.instance.preServerData.day,
			nowRound = Activity114Model.instance.preServerData.round
		}

		Activity114Model.instance:beginEvent(var_23_1)
	end

	Activity114Model.instance.preServerData = nil
end

function var_0_0.beforeBattle(arg_24_0, arg_24_1)
	local var_24_0 = Activity114Module_pb.BeforeAct114BattleRequest()

	var_24_0.activityId = arg_24_1

	arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveBeforeAct114BattleReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		-- block empty
	end
end

function var_0_0.enterSchool(arg_26_0, arg_26_1)
	local var_26_0 = Activity114Module_pb.EnterSchoolRequest()

	var_26_0.activityId = arg_26_1

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveEnterSchoolReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == 0 then
		Activity114Model.instance.serverData.isEnterSchool = true
	end
end

function var_0_0.markRoundStory(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = Activity114Module_pb.MarkRoundStoryRequest()

	var_28_0.activityId = arg_28_1

	arg_28_0:sendMsg(var_28_0, arg_28_2, arg_28_3)
end

function var_0_0.onReceiveMarkRoundStoryReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == 0 then
		-- block empty
	end
end

function var_0_0.markMeetingPlayUnlock(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = Activity114Module_pb.MarkMeetingPlayUnlockRequest()

	var_30_0.activityId = arg_30_1
	var_30_0.meetingId = arg_30_2

	arg_30_0:sendMsg(var_30_0)
end

function var_0_0.onReceiveMarkMeetingPlayUnlockReply(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == 0 then
		Activity114Model.instance.unLockMeetingDict[arg_31_2.meetingId].isPlayUnlock = 1

		Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	end
end

function var_0_0.markTravelPlayUnlock(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = Activity114Module_pb.MarkTravelPlayUnlockRequest()

	var_32_0.activityId = arg_32_1
	var_32_0.travelId = arg_32_2

	arg_32_0:sendMsg(var_32_0)
end

function var_0_0.onReceiveMarkTravelPlayUnlockReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 == 0 then
		Activity114Model.instance.unLockTravelDict[arg_33_2.travelId].isPlayUnlock = 1

		Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	end
end

function var_0_0.markPhotoRed(arg_34_0, arg_34_1)
	local var_34_0 = Activity114Module_pb.MarkUnlockNewPhotoRedDotRequest()

	var_34_0.activityId = arg_34_1

	arg_34_0:sendMsg(var_34_0)
end

function var_0_0.onReceiveMarkUnlockNewPhotoRedDotReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == 0 then
		-- block empty
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
