module("modules.logic.activity.view.ActivityCategoryItem", package.seeall)

slot0 = class("ActivityCategoryItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goselect = gohelper.findChild(slot1, "beselected")
	slot0._gounselect = gohelper.findChild(slot1, "noselected")
	slot0._txtnamecn = gohelper.findChildText(slot1, "beselected/activitynamecn")
	slot0._txtnameen = gohelper.findChildText(slot1, "beselected/activitynamecn/activitynameen")
	slot0._txtunselectnamecn = gohelper.findChildText(slot1, "noselected/noactivitynamecn")
	slot0._txtunselectnameen = gohelper.findChildText(slot1, "noselected/noactivitynamecn/noactivitynameen")
	slot0._goreddot = gohelper.findChild(slot1, "#go_reddot")
	slot0._itemClick = gohelper.getClickWithAudio(slot0.go)
	slot0._anim = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._openAnimTime = 0.43

	slot0:playEnterAnim()
end

function slot0.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._itemClick:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	if slot0._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	ActivityRpc.instance:sendGetActivityInfosRequest()
	slot0:setRedDotData()
	ActivityModel.instance:setTargetActivityCategoryId(slot0._mo.id)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()

	if slot0._openAnimTime < Time.realtimeSinceStartup - ActivityBeginnerCategoryListModel.instance.openViewTime then
		slot0._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function slot0._refreshItem(slot0)
	slot1, slot2 = nil
	slot4 = ActivityConfig.instance:getActivityCo(slot0._mo.id)
	slot5 = slot4.redDotId
	slot6 = slot4.typeId

	if slot0._mo.type == ActivityEnum.ActivityType.Normal then
		slot2 = ActivityConfig.instance:getActivityCenterCo(ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NorSign).showCenter).reddotid

		if slot0._mo.id == ActivityEnum.Activity.NoviceInsight then
			RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.ActivityNoviceInsight)
		else
			RedDotController.instance:addRedDot(slot0._goreddot, slot2, slot0._mo.id)
		end

		slot0._selected = slot0._mo.id == ActivityModel.instance:getTargetActivityCategoryId(slot1)
	elseif slot0._mo.type == ActivityEnum.ActivityType.Beginner then
		slot0._selected = slot0._mo.id == ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)
		slot2 = ActivityConfig.instance:getActivityCenterCo(ActivityEnum.ActivityType.Beginner).reddotid

		if slot0._mo.id == ActivityEnum.Activity.DreamShow then
			RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId, nil, slot0.checkActivityShowFirstEnter, slot0)
		elseif slot0._mo.id == DoubleDropModel.instance:getActId() then
			RedDotController.instance:addRedDot(slot0._goreddot, slot2, slot0._mo.id, slot0.checkActivityShowFirstEnter, slot0)
		elseif slot0._mo.id == ActivityEnum.Activity.Activity1_7WarmUp then
			if slot0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(slot0._mo.id)
				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(RedDotConfig.instance:getRedDotCO(slot2).parent)] = true
				})
			end

			RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId, nil, slot0.checkIsV1A7WarmupRed, slot0)
		elseif slot0._mo.id == ActivityEnum.Activity.Activity1_5WarmUp then
			if slot0._selected then
				Activity146Controller.instance:saveEnterActDateInfo()
				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(RedDotConfig.instance:getRedDotCO(slot2).parent)] = true
				})
			end

			RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId, nil, slot0.checkIsAct146NeedReddot, slot0)
		elseif slot0._mo.id == ActivityEnum.Activity.Activity1_8WarmUp then
			if slot0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(slot0._mo.id)
				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(RedDotConfig.instance:getRedDotCO(slot2).parent)] = true
				})
			end

			RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId, nil, slot0.checkIsV1A8WarmupRed, slot0)
		elseif slot0._mo.id == ActivityEnum.Activity.V2a2_TurnBack_H5 then
			RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId, nil, slot0.checkActivityShowFirstEnter, slot0)
		elseif slot0._mo.id == VersionActivity2_2Enum.ActivityId.LimitDecorate then
			RedDotController.instance:addRedDot(slot0._goreddot, slot2, slot0._mo.id, slot0.checkActivityShowFirstEnter, slot0)
		elseif slot0._mo.id == ActivityEnum.Activity.Activity1_9WarmUp or slot0._mo.id == ActivityEnum.Activity.V2a0_WarmUp or slot0._mo.id == ActivityEnum.Activity.V2a1_WarmUp or slot0._mo.id == ActivityEnum.Activity.V2a2_WarmUp or slot0._mo.id == ActivityEnum.Activity.V2a3_WarmUp or slot0._mo.id == ActivityEnum.Activity.RoomSign or slot0._mo.id == ActivityEnum.Activity.V2a5_WarmUp then
			slot8 = ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId

			if slot0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(slot7)
				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(RedDotConfig.instance:getRedDotCO(slot2).parent)] = true
				})
			end

			RedDotController.instance:addRedDot(slot0._goreddot, slot8, nil, slot0.checkIsV1A9WarmupRed, slot0)
		elseif slot0._mo.id == ActivityEnum.Activity.V2a4_WarmUp then
			if ActivityConfig.instance:getActivityCo(slot0._mo.id).redDotId == 0 then
				slot8 = RedDotEnum.DotNode.Activity125Task
			end

			if slot0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(slot7)
				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(RedDotConfig.instance:getRedDotCO(slot2).parent)] = true
				})
			end

			RedDotController.instance:addRedDot(slot0._goreddot, slot8, nil, slot0._checkIsV2a4WarmupRed, slot0)
		elseif slot6 == ActivityEnum.ActivityTypeID.Act189 then
			RedDotController.instance:addMultiRedDot(slot0._goreddot, {
				{
					id = slot5,
					uid = slot3
				},
				{
					id = RedDotEnum.DotNode.Activity189Task,
					uid = slot3
				},
				{
					id = RedDotEnum.DotNode.Activity189OnceReward,
					uid = slot3
				}
			})
		elseif slot6 == ActivityEnum.ActivityTypeID.Act201 then
			RedDotController.instance:addRedDot(slot0._goreddot, slot5, nil, slot0.checkActivityShowFirstEnter, slot0)
		else
			RedDotController.instance:addRedDot(slot0._goreddot, slot2, slot0._mo.id)
		end
	end

	slot7 = ActivityConfig.instance:getActivityCo(slot0._mo.id)
	slot0._txtnamecn.text = slot7.name
	slot0._txtnameen.text = slot7.nameEn
	slot0._txtunselectnamecn.text = slot7.name
	slot0._txtunselectnameen.text = slot7.nameEn

	if slot0._selected and slot0._mo.id == ActivityEnum.Activity.NoviceInsight then
		RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.ActivityNoviceInsight, false)
	end

	gohelper.setActive(slot0._goselect, slot0._selected)
	gohelper.setActive(slot0._gounselect, not slot0._selected)
end

function slot0.checkActivityShowFirstEnter(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = ActivityBeginnerController.instance:checkFirstEnter(slot0._mo.id)

		slot1:showRedDot(RedDotEnum.Style.NewTag)
	end
end

function slot0.checkActivityNewStage(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = ActivityBeginnerController.instance:checkActivityNewStage(slot0._mo.id)

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.checkIsAct146NeedReddot(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward())

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.checkIsV1A7WarmupRed(slot0, slot1)
	slot1.show = Activity125Controller.instance:checkActRed(ActivityEnum.Activity.Activity1_7WarmUp)

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

function slot0.checkIsV1A8WarmupRed(slot0, slot1)
	slot1.show = Activity125Controller.instance:checkActRed1(ActivityEnum.Activity.Activity1_8WarmUp)

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

function slot0.checkIsV1A9WarmupRed(slot0, slot1)
	slot1.show = Activity125Controller.instance:checkActRed2(slot0._mo.id)

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

function slot0.setRedDotData(slot0)
	ActivityBeginnerController.instance:setFirstEnter(slot0._mo.id)
end

function slot0.playEnterAnim(slot0)
	slot0._anim:Play(UIAnimationName.Open, 0, Mathf.Clamp01((Time.realtimeSinceStartup - ActivityBeginnerCategoryListModel.instance.openViewTime) / slot0._openAnimTime))
end

function slot0.onDestroy(slot0)
end

function slot0._checkIsV2a4WarmupRed(slot0, slot1)
	slot1.show = Activity125Controller.instance:checkActRed3(slot0._mo.id)

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

return slot0
