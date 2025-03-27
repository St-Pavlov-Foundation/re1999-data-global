module("modules.logic.activity.controller.ActivityBeginnerController", package.seeall)

slot0 = class("ActivityBeginnerController", BaseController)

function slot0.onInit(slot0)
	slot0:_initHandlers()
end

function slot0.reInit(slot0)
end

function slot0._initHandlers(slot0)
	if slot0._handlerList then
		return
	end

	slot0._handlerList = {
		[ActivityEnum.Activity.StoryShow] = {
			slot0.checkRedDotWithActivityId,
			slot0.checkFirstEnter
		},
		[ActivityEnum.Activity.DreamShow] = {
			slot0.checkRedDot,
			slot0.checkFirstEnter
		},
		[ActivityEnum.Activity.ClassShow] = {
			slot0.checkRedDotWithActivityId,
			slot0.checkFirstEnter
		},
		[ActivityEnum.Activity.V2a4_WarmUp] = {
			slot0.checkRedDotWithActivityId,
			Activity125Controller.checkRed_Task
		}
	}
	slot0._defaultHandler = {
		slot0.checkRedDotWithActivityId
	}
end

function slot0.showRedDot(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._handlerList[slot1] or (slot1 ~= DoubleDropModel.instance:getActId() or slot0._handlerList[ActivityEnum.Activity.ClassShow]) and slot0._defaultHandler) do
		if slot7(slot0, slot1) then
			return true
		end
	end

	return false
end

function slot0._getRedDotId(slot0, slot1)
	if not ActivityConfig.instance:getActivityCo(slot1) then
		return 0
	end

	if slot2.redDotId > 0 then
		return slot3
	end

	if not ActivityConfig.instance:getActivityCenterCo(slot2.showCenter) then
		return 0
	end

	return slot2.reddotid
end

function slot0.checkRedDot(slot0, slot1)
	if slot0:_getRedDotId(slot1) > 0 then
		return RedDotModel.instance:isDotShow(slot2)
	end

	return false
end

function slot0.checkRedDotWithActivityId(slot0, slot1)
	if slot0:_getRedDotId(slot1) > 0 then
		return RedDotModel.instance:isDotShow(slot2, slot1)
	end

	return false
end

function slot0.checkFirstEnter(slot0, slot1)
	return string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(slot1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), ""))
end

function slot0.setFirstEnter(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(slot1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), "hasEnter")
end

function slot0.checkActivityNewStage(slot0, slot1)
	return ActivityModel.instance:getActivityInfo()[slot1]:isNewStageOpen()
end

slot0.instance = slot0.New()

return slot0
