module("modules.logic.patface.controller.work.PatFaceWorkBase", package.seeall)

slot0 = class("PatFaceWorkBase", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._patFaceId = slot1
end

function slot0.onStart(slot0, slot1)
	if not slot0._patFaceId or slot0._patFaceId == PatFaceEnum.NoneNum then
		slot0:patComplete()

		return
	end

	slot0._patViewName = PatFaceConfig.instance:getPatFaceViewName(slot0._patFaceId)
	slot0._patStoryId = PatFaceConfig.instance:getPatFaceStoryId(slot0._patFaceId)
	slot0._patFaceType = slot1 and slot1.patFaceType

	if slot0:checkCanPat() then
		slot0:startPat()
	else
		slot0:patComplete()
	end
end

function slot0.checkCanPat(slot0)
	slot1 = false

	return (not PatFaceEnum.CustomCheckCanPatFun[slot0._patFaceId] or slot2(slot0._patFaceId)) and slot0:defaultCheckCanPat()
end

function slot0.defaultCheckCanPat(slot0)
	slot1 = false

	if PatFaceConfig.instance:getPatFaceActivityId(slot0._patFaceId) and slot2 ~= PatFaceEnum.NoneNum then
		slot1 = ActivityHelper.getActivityStatus(slot2) == ActivityEnum.ActivityStatus.Normal
	else
		logNormal(string.format("PatFaceWorkBase:defaultCheckCanPat error, actId invalid,patFaceId:%s, actId:%s", slot0._patFaceId, slot2))
	end

	return slot1
end

function slot0.startPat(slot0)
	if not string.nilorempty(slot0._patViewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
		slot0:patView()
	elseif slot0._patStoryId and slot0._patStoryId ~= PatFaceEnum.NoneNum then
		slot0:patStory()
	else
		slot0:patComplete()
	end
end

function slot0.onResume(slot0)
	if not string.nilorempty(slot0._patViewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	end
end

function slot0.patView(slot0)
	if PatFaceEnum.CustomPatFun[slot0._patFaceId] then
		slot1(slot0._patFaceId)
	else
		ViewMgr.instance:openView(slot0._patViewName)
	end
end

function slot0.patStory(slot0)
	StoryController.instance:playStory(slot0._patStoryId, nil, slot0.onPlayPatStoryFinish, slot0)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if string.nilorempty(slot0._patViewName) or slot0._patViewName == slot1 then
		slot0:patComplete()
	end
end

function slot0.onPlayPatStoryFinish(slot0)
	slot0:patComplete()
end

function slot0.patComplete(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

return slot0
