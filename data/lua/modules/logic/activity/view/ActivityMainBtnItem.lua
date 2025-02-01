module("modules.logic.activity.view.ActivityMainBtnItem", package.seeall)

slot0 = class("ActivityMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0._centerId = slot1
	slot0._centerCo = ActivityConfig.instance:getActivityCenterCo(slot1)
	slot0.go = gohelper.cloneInPlace(slot2)

	gohelper.setActive(slot0.go, true)

	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.getClick(gohelper.findChild(slot0.go, "bg"))
	slot0._reddotitem = gohelper.findChild(slot0.go, "go_activityreddot")

	slot0:_refreshItem()
	slot0:addEvent()
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
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, slot0._centerCo.icon)

	if slot0._centerCo.id == ActivityEnum.ActivityType.Welfare then
		RedDotController.instance:addRedDot(slot0._reddotitem, tonumber(RedDotConfig.instance:getRedDotCO(slot0._centerCo.reddotid).parent), nil, slot0._safeCheckActivityWelfareRedDot, slot0)
	else
		RedDotController.instance:addRedDot(slot0._reddotitem, tonumber(slot1), nil, slot0._safeCheckActivityShowRedDotData, slot0)
	end
end

function slot0._safeCheckActivityWelfareRedDot(slot0, slot1)
	slot0._curActId = nil
	slot2, slot3 = pcall(slot0._checkActivityWelfareRedDot, slot0, slot1)

	if not slot2 then
		logError(string.format("ActivityMainBtnItem:_safeCheckActivityWelfareRedDot actId:%s error:%s", slot0._curActId, slot3))
	end
end

function slot0._safeCheckActivityShowRedDotData(slot0, slot1)
	slot0._curActId = nil
	slot2, slot3 = pcall(slot0._checkActivityShowRedDotData, slot0, slot1)

	if not slot2 then
		logError(string.format("ActivityMainBtnItem:_safeCheckActivityShowRedDotData actId:%s error:%s", slot0._curActId, slot3))
	end
end

function slot0._checkActivityShowRedDotData(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		for slot6, slot7 in pairs(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)) do
			slot0._curActId = slot7

			if slot7 == DoubleDropModel.instance:getActId() and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end

			if slot7 == ActivityEnum.Activity.DreamShow then
				slot8 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)

				if slot8[1].finishCount < slot8[1].config.maxFinishCount and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
					slot0:_showRedDotType(slot1, slot7)

					return
				end
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

			if (slot7 == ActivityEnum.Activity.Activity1_9WarmUp or slot7 == ActivityEnum.Activity.V2a0_WarmUp or slot7 == ActivityEnum.Activity.V2a1_WarmUp or slot7 == ActivityEnum.Activity.V2a2_WarmUp) and Activity125Controller.instance:checkActRed2(slot7) then
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

			if slot7 == VoyageConfig.instance:getActivityId() and string.nilorempty(slot0:getActivityShowRedDotData(slot7)) then
				slot0:_showRedDotType(slot1, slot7)

				return
			end
		end
	end
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
	gohelper.setActive(slot0.go, false)
	gohelper.destroy(slot0.go)

	slot0.go = nil
	slot0._imgitem = nil
	slot0._btnitem = nil
	slot0._reddotitem = nil
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

function slot0.getSortPriority(slot0)
	return slot0._centerCo.sortPriority
end

return slot0
