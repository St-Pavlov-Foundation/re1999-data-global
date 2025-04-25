module("modules.logic.activity.view.ActivityMainBtnItem", package.seeall)

slot0 = class("ActivityMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._centerId = slot1
	slot0._centerCo = ActivityConfig.instance:getActivityCenterCo(slot1)
	slot0.go = gohelper.cloneInPlace(slot2)

	gohelper.setActive(slot0.go, true)

	slot0._imgGo = gohelper.findChild(slot0.go, "bg")
	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.getClick(slot0._imgGo)

	slot0:_initReddotitem(slot0.go)

	slot0._reddotitem = gohelper.findChild(slot0.go, "go_activityreddot")

	slot0:addEvent()
	slot0:_refreshItem()
end

function slot0.addEvent(slot0)
	slot0._btnitem:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEvent(slot0)
	slot0._btnitem:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Activity) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Activity))

		return
	end

	if slot0._centerId == ActivityEnum.ActivityType.Normal then
		ActivityController.instance:openActivityNormalView()
	elseif slot0._centerId == ActivityEnum.ActivityType.Beginner then
		ActivityRpc.instance:sendGetActivityInfosRequest(slot0.openActivityBeginnerView, slot0)
	elseif slot0._centerId == ActivityEnum.ActivityType.Welfare then
		ActivityController.instance:openActivityWelfareView()
	end
end

function slot0.openActivityBeginnerView(slot0)
	ActivityController.instance:openActivityBeginnerView()
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, ActivityModel.showActivityEffect() and ActivityConfig.instance:getMainActAtmosphereConfig().mainViewActBtnPrefix .. slot0._centerCo.icon or slot0._centerCo.icon, true)

	if not slot1 and ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot8, slot9 in ipairs(slot4.mainViewActBtn) do
			if gohelper.findChild(slot0.go, slot9) then
				gohelper.setActive(slot10, slot1)
			end
		end
	end

	slot0._redDot:refreshDot()
end

function slot0._showRedDotType(slot0, slot1, slot2)
	slot1.show = true

	slot1:showRedDot(ActivityConfig.instance:getActivityCo(slot2).redDotId ~= 0 and RedDotConfig.instance:getRedDotCO(slot4).style or RedDotEnum.Style.Normal)
end

function slot0.getActivityShowRedDotData(slot0, slot1)
	return PlayerPrefsHelper.getString(PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(slot1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), "")
end

function slot0.destroy(slot0)
	slot0:removeEvent()
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

function slot0.getSortPriority(slot0)
	return slot0._centerCo.sortPriority
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot.show
end

function slot0._initReddotitem(slot0, slot1)
	if slot0._centerCo.id == ActivityEnum.ActivityType.Welfare then
		slot0._redDot = RedDotController.instance:addRedDot(gohelper.findChild(slot1, "go_activityreddot"), tonumber(RedDotConfig.instance:getRedDotCO(slot0._centerCo.reddotid).parent), false, slot0._onRefreshDot_Welfare, slot0)
	else
		slot0._redDot = RedDotController.instance:addRedDot(slot2, slot3, false, slot0._onRefreshDot_ActivityBeginner, slot0)
	end

	return

	for slot8 = 1, gohelper.findChild(slot1, "go_activityreddot/#go_special_reds").transform.childCount do
		gohelper.setActive(slot3:GetChild(slot8 - 1).gameObject, false)
	end

	slot5 = nil

	if slot0._centerCo.id == ActivityEnum.ActivityType.Welfare then
		slot0._redDot = RedDotController.instance:addRedDotTag(gohelper.findChild(slot2, "#go_welfare_red"), tonumber(RedDotConfig.instance:getRedDotCO(slot0._centerCo.reddotid).parent), false, slot0._onRefreshDot_Welfare, slot0)
	else
		slot0._redDot = RedDotController.instance:addRedDotTag(gohelper.findChild(slot2, "#go_activity_beginner_red"), slot6, false, slot0._onRefreshDot_ActivityBeginner, slot0)
	end

	slot0._btnitem2 = gohelper.getClick(slot5)
end

function slot0._onRefreshDot_Welfare(slot0, slot1)
	slot0._curActId = nil
	slot2, slot3 = pcall(slot1.dotId and slot0._checkRed_Welfare or slot0._checkActivityWelfareRedDot, slot0, slot1)

	if not slot2 then
		logError(string.format("ActivityMainBtnItem:_checkRed_Welfare actId:%s error:%s", slot0._curActId, slot3))
	end
end

function slot0._onRefreshDot_ActivityBeginner(slot0, slot1)
	slot0._curActId = nil
	slot2, slot3 = pcall(slot1.dotId and slot0._checkRed_ActivityBeginner or slot0._checkActivityShowRedDotData, slot0, slot1)

	if not slot2 then
		logError(string.format("ActivityMainBtnItem:_checkRed_ActivityBeginner actId:%s error:%s", slot0._curActId, slot3))
	end
end

function slot0._checkRed_ActivityBeginner(slot0, slot1)
	slot2 = slot0:_checkIsShowRed_ActivityBeginner(slot1.dotId, 0)
	slot1.show = slot2

	gohelper.setActive(slot1.go, slot2)
	gohelper.setActive(slot0._imgGo, not slot2)
end

function slot0._checkRed_Welfare(slot0, slot1)
	slot2 = slot0:_checkIsShowRed_Welfare(slot1.dotId, 0)
	slot1.show = slot2

	gohelper.setActive(slot1.go, slot2)
	gohelper.setActive(slot0._imgGo, not slot2)
end

function slot0._checkIsShowRed_Welfare(slot0, slot1, slot2)
	if RedDotModel.instance:isDotShow(slot1, slot2 or 0) then
		return true
	end

	for slot7, slot8 in pairs(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)) do
		slot0._curActId = slot8

		if slot8 == ActivityEnum.Activity.StoryShow and not TaskModel.instance:isFinishAllNoviceTask() and string.nilorempty(slot0:getActivityShowRedDotData(slot8)) then
			return true
		end

		if slot8 == ActivityEnum.Activity.ClassShow and not TeachNoteModel.instance:isFinalRewardGet() and string.nilorempty(slot0:getActivityShowRedDotData(slot8)) then
			return true
		end
	end

	return false
end

function slot0._checkIsShowRed_ActivityBeginner(slot0, slot1, slot2)
	if RedDotModel.instance:isDotShow(slot1, slot2 or 0) then
		return true
	end

	for slot7, slot8 in pairs(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)) do
		slot0._curActId = slot8

		if slot8 == DoubleDropModel.instance:getActId() and string.nilorempty(slot0:getActivityShowRedDotData(slot8)) then
			return true
		end

		if slot8 == ActivityEnum.Activity.DreamShow and TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow) and slot9[1] and slot10.config and slot10.finishCount < slot10.config.maxFinishCount and string.nilorempty(slot0:getActivityShowRedDotData(slot8)) then
			return true
		end

		if slot8 == ActivityEnum.Activity.Activity1_7WarmUp and Activity125Controller.instance:checkActRed(slot8) then
			return true
		end

		if slot8 == ActivityEnum.Activity.Activity1_8WarmUp and Activity125Controller.instance:checkActRed1(slot8) then
			return true
		end

		if (slot8 == ActivityEnum.Activity.Activity1_9WarmUp or slot8 == ActivityEnum.Activity.V2a0_WarmUp or slot8 == ActivityEnum.Activity.V2a1_WarmUp or slot8 == ActivityEnum.Activity.V2a2_WarmUp or slot8 == ActivityEnum.Activity.V2a3_WarmUp or slot8 == ActivityEnum.Activity.V2a5_WarmUp) and Activity125Controller.instance:checkActRed2(slot8) then
			return true
		end

		if slot8 == ActivityEnum.Activity.Activity1_5WarmUp and Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward()) then
			return true
		end

		if slot8 == ActivityEnum.Activity.V2a2_TurnBack_H5 and ActivityBeginnerController.instance:checkFirstEnter(slot8) then
			return true
		end

		if slot8 == VersionActivity2_2Enum.ActivityId.LimitDecorate and ActivityBeginnerController.instance:checkFirstEnter(slot8) then
			return true
		end

		if typeId == ActivityEnum.ActivityTypeID.Act125 and Activity125Controller.instance:checkActRed2(slot8) then
			return true
		end

		if typeId == ActivityEnum.ActivityTypeID.Act201 and ActivityBeginnerController.instance:checkFirstEnter(slot8) then
			return true
		end
	end

	return false
end

function slot0._checkActivityShowRedDotData(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		for slot6, slot7 in pairs(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)) do
			slot9 = ActivityConfig.instance:getActivityCo(slot7).typeId
			slot0._curActId = slot7

			if slot7 == VoyageConfig.instance:getActivityId() and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == DoubleDropModel.instance:getActId() and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.DreamShow and TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow) and slot10[1] and slot11.config and slot11.finishCount < slot11.config.maxFinishCount and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.WeekWalkDeepShow and ActivityModel.instance:getActivityInfo()[slot7]:isNewStageOpen() then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.Activity1_7WarmUp and Activity125Controller.instance:checkActRed(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.Activity1_8WarmUp and Activity125Controller.instance:checkActRed1(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if (slot7 == ActivityEnum.Activity.Activity1_9WarmUp or slot7 == ActivityEnum.Activity.V2a0_WarmUp or slot7 == ActivityEnum.Activity.V2a1_WarmUp or slot7 == ActivityEnum.Activity.V2a2_WarmUp or slot7 == ActivityEnum.Activity.V2a3_WarmUp or slot7 == ActivityEnum.Activity.V2a5_WarmUp) and Activity125Controller.instance:checkActRed2(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.Activity1_5WarmUp and Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward()) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.V2a2_TurnBack_H5 and ActivityBeginnerController.instance:checkFirstEnter(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == VersionActivity2_2Enum.ActivityId.LimitDecorate and ActivityBeginnerController.instance:checkFirstEnter(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.V2a4_WarmUp and Activity125Controller.instance:checkActRed3(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot9 == ActivityEnum.ActivityTypeID.Act201 and ActivityBeginnerController.instance:checkFirstEnter(slot7) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end
		end
	end
end

function slot0._checkActivityWelfareRedDot(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		for slot6, slot7 in pairs(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)) do
			slot0._curActId = slot7

			if slot7 == ActivityEnum.Activity.StoryShow and not TaskModel.instance:isFinishAllNoviceTask() and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.ClassShow and not TeachNoteModel.instance:isFinalRewardGet() and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end
		end
	end
end

return slot0
