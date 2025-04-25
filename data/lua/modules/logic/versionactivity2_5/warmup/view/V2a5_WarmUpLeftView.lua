module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpLeftView", package.seeall)

slot0 = class("V2a5_WarmUpLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._goopen = gohelper.findChild(slot0.viewGO, "Middle/#go_open")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "Middle/#go_open/#go_drag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = -1
slot2 = 0
slot3 = 1
slot4 = SLFramework.AnimatorPlayer
slot5 = {
	SwipeDone = 1
}
slot6 = 5
slot7 = "onShowDay"

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0._lastEpisodeId = nil
	slot0._needWaitCount = 0
	slot0._draggedState = uv1
	slot0._dayItemList = {}
	slot0._drag = UIDragListenerHelper.New()
end

function slot0._editableInitView(slot0)
	slot0._middleGo = gohelper.findChild(slot0.viewGO, "Middle")
	slot0._guideGo = gohelper.findChild(slot0._middleGo, "guide")
	slot0._animatorPlayer = uv0.Get(slot0._middleGo)
	slot0._animtor = slot0._animatorPlayer.animator
	slot0._animEvent = gohelper.onceAddComponent(slot0._middleGo, gohelper.Type_AnimationEventWrap)

	slot0._drag:create(slot0._godrag)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
	slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)
	slot0:_editableInitView_days()
	slot0:_setActive_drag(true)
	slot0._animEvent:AddEventListener(uv1, slot0._onShowDay, slot0)
end

function slot0._editableInitView_days(slot0)
	for slot4 = 1, uv0 do
		slot6 = V2a5_WarmUpLeftView_Day.New({
			parent = slot0,
			baseViewContainer = slot0.viewContainer
		})

		slot6:setIndex(slot4)
		slot6:_internal_setEpisode(slot4)
		slot6:init(gohelper.findChild(slot0._middleGo, "#go_day" .. slot4))

		slot0._dayItemList[slot4] = slot6
	end
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	slot0._animEvent:RemoveEventListener(uv0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
	GameUtil.onDestroyViewMemberList(slot0, "_dayItemList")
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
	GameUtil.onDestroyViewMemberList(slot0, "_dayItemList")
end

function slot0.onDataUpdateFirst(slot0)
	if isDebugBuild then
		assert(slot0.viewContainer:getEpisodeCount() <= uv0, "invalid config json_activity125 actId: " .. slot0.viewContainer:actId())
	end

	slot0._draggedState = slot0:_checkIsDone() and uv1 or uv2
end

function slot0.onDataUpdate(slot0)
	slot0:_setActive_curEpisode(false)
	slot0:_refresh()
end

function slot0.onSwitchEpisode(slot0)
	if slot0._draggedState == uv0 and not slot0:_checkIsDone() then
		slot0._draggedState = uv1 - 1
	elseif slot0._draggedState < uv1 and slot1 then
		slot0._draggedState = uv0
	end

	slot0:_setActive_curEpisode(false)
	slot0:_refresh()
end

function slot0._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot0._episode2Index(slot0, slot1)
	return slot0.viewContainer:episode2Index(slot1 or slot0:_episodeId())
end

function slot0._checkIsDone(slot0, slot1)
	return slot0.viewContainer:checkIsDone(slot1 or slot0:_episodeId())
end

function slot0._saveStateDone(slot0, slot1, slot2)
	slot0.viewContainer:saveStateDone(slot2 or slot0:_episodeId(), slot1)
end

function slot0._saveState(slot0, slot1, slot2)
	assert(slot1 ~= 1999, "please call _saveStateDone instead")
	slot0.viewContainer:saveState(slot2 or slot0:_episodeId(), slot1)
end

function slot0._getState(slot0, slot1, slot2)
	return slot0.viewContainer:getState(slot2 or slot0:_episodeId(), slot1)
end

function slot0._setActive_drag(slot0, slot1)
	gohelper.setActive(slot0._godrag, slot1)
end

function slot0._setActive_guide(slot0, slot1)
	gohelper.setActive(slot0._guideGo, slot1)
end

function slot0._refresh(slot0)
	if slot0:_checkIsDone() then
		slot0:_playAnimOpend()
		slot0:_setActive_drag(false)
		slot0:_setActive_guide(false)
	elseif slot0:_getState() == 0 then
		slot0:_setActive_guide(not slot1 and slot0._draggedState <= uv0)
		slot0:_setActive_drag(true)
		slot0:_playAnimIdle()
	elseif uv1.SwipeDone == slot2 then
		slot0:_setActive_guide(false)
		slot0:_setActive_drag(false)
		slot0:_playAnimAfterSwipe()
	else
		logError("[V2a5_WarmUpLeftView] invalid state:" .. slot2)
	end
end

function slot0._getItem(slot0, slot1)
	return slot0._dayItemList[slot0:_episode2Index(slot1)]
end

function slot0._setActive_curEpisode(slot0, slot1)
	slot0:_setActiveByEpisode(slot0:_episodeId(), slot1)
end

function slot0._setActiveByEpisode(slot0, slot1, slot2)
	if slot0._lastEpisodeId then
		slot0:_getItem(slot0._lastEpisodeId):setActive(false)
	end

	slot0._lastEpisodeId = slot1

	slot0:_getItem(slot1):setActive(slot2)
end

function slot0._onDragBegin(slot0)
	slot0:_setActive_guide(false)
end

function slot0._onDragEnd(slot0)
	if slot0:_checkIsDone() then
		return
	end

	if slot0._drag:isSwipeLT() or slot0._drag:isSwipeRB() then
		slot0:_saveState(uv0.SwipeDone)
		slot0:_playAnimAfterSwipe()
		slot0.viewContainer:setLocalIsPlayCurByUser()
	end
end

function slot0._playAnimAfterSwipe(slot0)
	slot0:_playAnimOpen(function ()
		uv0:_saveStateDone(true)
		uv0.viewContainer:openDesc()
	end)
end

function slot0._playAnimIdle(slot0)
	slot0:_playAnim(UIAnimationName.Idle)
end

function slot0._playAnimOpen(slot0, slot1, slot2)
	slot0:_setActive_curEpisode(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_scissors_cut_25251415)
	slot0:_playAnim(UIAnimationName.Open, slot1, slot2)
end

function slot0._playAnimOpend(slot0)
	slot0:_setActive_curEpisode(true)
	slot0:_playAnim("finishidle")
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2 or function ()
	end, slot3)
end

function slot0._onShowDay(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dog_page_25001215)
end

return slot0
