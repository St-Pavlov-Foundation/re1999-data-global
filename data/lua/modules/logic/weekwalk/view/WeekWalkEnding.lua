module("modules.logic.weekwalk.view.WeekWalkEnding", package.seeall)

slot0 = class("WeekWalkEnding", BaseView)

function slot0.onInitView(slot0)
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._scrollnull = gohelper.findChildScrollRect(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null")
	slot0._gostartemplate = gohelper.findChild(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animator = slot0._gofinish:GetComponent(typeof(UnityEngine.Animator))
	slot0._mapId = WeekWalkModel.instance:getCurMapId()
	slot0._animEventWrap = slot0._gofinish:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("star", slot0._startShowStars, slot0)
end

function slot0._startShowStars(slot0)
	if not slot0._starList then
		return
	end

	slot0:_starsAppear()
end

function slot0._starsAppear(slot0)
	slot0._curAppearIndex = 1

	TaskDispatcher.cancelTask(slot0._oneStarAppear, slot0)
	TaskDispatcher.runRepeat(slot0._oneStarAppear, slot0, 0.12)
end

function slot0._oneStarAppear(slot0)
	gohelper.setActive(slot0._starList[slot0._curAppearIndex], true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_challenge_success_star)

	slot0._curAppearIndex = slot0._curAppearIndex + 1

	if slot0._curNum < slot0._curAppearIndex then
		TaskDispatcher.cancelTask(slot0._oneStarAppear, slot0)
	end
end

function slot0._addStarList(slot0)
	slot0._starList = slot0:getUserDataTb_()

	for slot5 = 1, slot0._maxNum do
		slot6 = gohelper.cloneInPlace(slot0._gostartemplate)

		gohelper.setActive(slot6, true)

		slot7 = gohelper.findChild(slot6, "star")

		gohelper.setActive(slot7, false)
		table.insert(slot0._starList, slot7)
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, slot0._onWeekwalkResetLayer, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, slot0._onWeekwalkInfoUpdate, slot0)
	slot0:_showFinishAnim()
end

function slot0._onWeekwalkResetLayer(slot0)
	gohelper.setActive(slot0._gofinish, false)
end

function slot0._onWeekwalkInfoUpdate(slot0)
	slot0:_showFinishAnim()
end

function slot0._showFinishAnim(slot0)
	slot0._mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not slot0._mapInfo then
		return
	end

	slot0._curNum, slot0._maxNum = slot0._mapInfo:getCurStarInfo()

	if not WeekWalkView._canShowFinishAnim(slot0._mapId) then
		slot0:_onShowFinishAnimDone()

		return
	end

	slot0:_addStarList()

	if slot0._mapInfo.isFinished == 1 then
		WeekWalkModel.instance:setFinishMapId(slot0._mapId)
	end

	WeekwalkRpc.instance:sendMarkShowFinishedRequest()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showFinishAnim")
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_challenge_success)
	gohelper.setActive(slot0._gofinish, true)

	slot0._viewAnim.enabled = true

	if slot0._curNum == slot0._maxNum then
		slot0._animator:Play("ending2")
		slot0._viewAnim:Play("finish_map2")

		slot1 = 2.83 + 2
	else
		slot0._animator:Play("ending1")
		slot0._viewAnim:Play("finish_map1")
	end

	TaskDispatcher.runDelay(slot0._closeFinishAnim, slot0, slot1)

	slot0._isPlayMapFinishClip = nil

	TaskDispatcher.runRepeat(slot0._checkAnimClip, slot0, 0)
end

function slot0._checkAnimClip(slot0)
	if slot0._isPlayMapFinishClip then
		TaskDispatcher.cancelTask(slot0._checkAnimClip, slot0)

		return
	end

	if slot0._animator:GetCurrentAnimatorStateInfo(0):IsName("open") then
		slot0._isPlayMapFinishClip = true

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	end
end

function slot0._closeFinishAnim(slot0)
	TaskDispatcher.cancelTask(slot0._checkAnimClip, slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("showFinishAnim")
	gohelper.setActive(slot0._gofinish, slot0._curNum == slot0._maxNum)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnShowFinishAnimDone)
	slot0:_onShowFinishAnimDone()
end

function slot0._onShowFinishAnimDone(slot0)
	TaskDispatcher.runDelay(slot0._showIdle, slot0, 0)

	if WaitGuideActionOpenViewWithCondition.weekWalkFinishLayer() then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideFinishLayer)
	end
end

function slot0._showIdle(slot0)
	if slot0._mapInfo.isFinish == 1 and slot0._curNum == slot0._maxNum then
		gohelper.setActive(slot0._gofinish, true)
		slot0._animator:Play(UIAnimationName.Idle)
	end
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._gofinish, false)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._checkAnimClip, slot0)
	TaskDispatcher.cancelTask(slot0._oneStarAppear, slot0)
	TaskDispatcher.cancelTask(slot0._closeFinishAnim, slot0)
	TaskDispatcher.cancelTask(slot0._showIdle, slot0)
	slot0._animEventWrap:RemoveAllEventListener()
end

return slot0
