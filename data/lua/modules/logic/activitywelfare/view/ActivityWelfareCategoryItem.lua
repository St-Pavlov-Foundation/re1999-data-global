module("modules.logic.activitywelfare.view.ActivityWelfareCategoryItem", package.seeall)

slot0 = class("ActivityWelfareCategoryItem", ListScrollCell)

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
	slot0._gonewwelfare = gohelper.findChild(slot1, "#go_newwelfare")
	slot0._goselectwelfare = gohelper.findChild(slot1, "#go_newwelfare/selecticon")

	slot0:playEnterAnim()
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.SwitchWelfareActivity, slot0.refreshSelect, slot0)
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

	if slot0._mo.id == ActivityEnum.Activity.StoryShow or slot0._mo.id == ActivityEnum.Activity.ClassShow then
		ActivityBeginnerController.instance:setFirstEnter(slot0._mo.id)
		slot0.redDot:refreshDot()
	end

	ActivityModel.instance:setTargetActivityCategoryId(slot0._mo.id)
	ActivityController.instance:dispatchEvent(ActivityEvent.SwitchWelfareActivity)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()

	if slot0._openAnimTime < Time.realtimeSinceStartup - ActivityWelfareListModel.instance.openViewTime then
		slot0._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function slot0._refreshItem(slot0)
	slot1 = nil

	if slot0._mo.type == ActivityEnum.ActivityType.Welfare then
		if slot0._mo.id == ActivityEnum.Activity.StoryShow or slot0._mo.id == ActivityEnum.Activity.ClassShow then
			slot0.redDot = RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCenterCo(ActivityEnum.ActivityType.Welfare).reddotid, slot0._mo.id, slot0.checkActivityShowFirstEnter, slot0)
		else
			slot0.redDot = RedDotController.instance:addRedDot(slot0._goreddot, slot1, slot0._mo.id)
		end
	end

	slot2 = ActivityConfig.instance:getActivityCo(slot0._mo.id)
	slot0._txtnamecn.text = slot2.name
	slot0._txtnameen.text = slot2.nameEn
	slot0._txtunselectnamecn.text = slot2.name
	slot0._txtunselectnameen.text = slot2.nameEn

	slot0:refreshSelect()
end

function slot0.refreshSelect(slot0)
	slot0._selected = slot0._mo.id == ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)
	slot1 = slot0._mo.id == ActivityEnum.Activity.NewWelfare

	gohelper.setActive(slot0._gonewwelfare, slot1)
	gohelper.setActive(slot0._goselectwelfare, slot1 and slot0._selected)
	gohelper.setActive(slot0._goselect, not slot1 and slot0._selected)
	gohelper.setActive(slot0._gounselect, not slot1 and not slot0._selected)
end

function slot0.checkActivityShowFirstEnter(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = ActivityBeginnerController.instance:checkFirstEnter(slot0._mo.id)

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.playEnterAnim(slot0)
	slot0._anim:Play(UIAnimationName.Open, 0, Mathf.Clamp01((Time.realtimeSinceStartup - ActivityWelfareListModel.instance.openViewTime) / slot0._openAnimTime))
end

function slot0.onDestroy(slot0)
end

return slot0
