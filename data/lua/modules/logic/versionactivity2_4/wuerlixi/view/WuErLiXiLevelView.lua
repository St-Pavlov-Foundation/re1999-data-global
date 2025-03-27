module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelView", package.seeall)

slot0 = class("WuErLiXiLevelView", BaseView)
slot1 = 464
slot2 = 0
slot3 = 4
slot4 = 0.3

function slot0.onInitView(slot0)
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._taskAnim = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	slot0._goTaskReddot = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._animTask = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	slot0._goepisodescroll = gohelper.findChild(slot0.viewGO, "#scroll_StateList")
	slot0._goepisodecontent = gohelper.findChild(slot0.viewGO, "#scroll_StateList/Viewport/Content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTask:RemoveClickListener()
end

function slot0._btnTaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.WuErLiXiTaskView)
end

function slot0._onEpisodeFinished(slot0)
	if WuErLiXiModel.instance:getNewFinishEpisode() then
		slot0:_playStoryFinishAnim()
	end
end

function slot0._playStoryFinishAnim(slot0)
	if WuErLiXiModel.instance:getNewFinishEpisode() then
		for slot5, slot6 in ipairs(slot0._episodeItems) do
			if slot6.id == slot1 then
				slot0._finishEpisodeIndex = slot5

				slot6:playFinish()
				slot6:playStarAnim()
				TaskDispatcher.runDelay(slot0._finishStoryEnd, slot0, 1.5)

				break
			end
		end

		WuErLiXiModel.instance:clearFinishEpisode()
	end
end

function slot0._onBackToLevel(slot0)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	slot0._anim:Play("back", 0, 0)
	slot0:_refreshTask()
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a4WuErLiXiTask, 0) then
		slot0._taskAnim:Play("loop", 0, 0)
	else
		slot0._taskAnim:Play("idle", 0, 0)
	end
end

function slot0._onCloseTask(slot0)
	slot0:_refreshTask()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.EpisodeFinished, slot0._onEpisodeFinished, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.OnBackToLevel, slot0._onBackToLevel, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.OnCloseTask, slot0._onCloseTask, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.EpisodeFinished, slot0._onEpisodeFinished, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.OnCloseTask, slot0._onCloseTask, slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	slot0.actConfig = ActivityConfig.instance:getActivityCo(slot0.actId)

	slot0:_initLevelItems()
	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._goTaskReddot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_jinru)
	slot0:_refreshLeftTime()
	slot0:_refreshTask()
	TaskDispatcher.runRepeat(slot0._refreshLeftTime, slot0, 1)
end

function slot0._refreshLeftTime(slot0)
	slot0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0._initLevelItems(slot0)
	slot0._episodeItems = {}

	for slot6 = 1, #WuErLiXiConfig.instance:getEpisodeCoList(slot0.actId) do
		slot0._episodeItems[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goepisodecontent), WuErLiXiLevelItem, slot0)

		slot0._episodeItems[slot6]:setParam(slot2[slot6], slot6, slot0.actId)

		if slot0._episodeItems[slot6]:isUnlock() then
			slot0._curEpisodeIndex = slot6
		end
	end

	slot0._curEpisodeIndex = WuErLiXiModel.instance:getCurEpisodeIndex() > 0 and slot3 or slot0._curEpisodeIndex

	slot0:_focusLvItem(slot0._curEpisodeIndex)
end

function slot0._finishStoryEnd(slot0)
	if slot0._finishEpisodeIndex == #slot0._episodeItems then
		slot0._curEpisodeIndex = slot0._finishEpisodeIndex
		slot0._finishEpisodeIndex = nil
	else
		slot0._curEpisodeIndex = slot0._finishEpisodeIndex + 1

		slot0:_unlockStory()
	end
end

function slot0._unlockStory(slot0)
	slot0._episodeItems[slot0._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(slot0._unlockLvEnd, slot0, 1.5)
end

function slot0._unlockLvEnd(slot0)
	slot0._episodeItems[slot0._finishEpisodeIndex + 1]:refreshUI()

	slot0._finishEpisodeIndex = nil
end

function slot0._focusLvItem(slot0, slot1, slot2)
	if slot2 then
		ZProj.TweenHelper.DOLocalMoveY(slot0._goepisodecontent.transform, slot1 < uv0 and uv1 or uv1 + (slot1 - uv0) * (uv2 - uv1) / (#WuErLiXiConfig.instance:getEpisodeCoList(VersionActivity2_4Enum.ActivityId.WuErLiXi) - uv0), uv3, slot0._onFocusEnd, slot0, slot1)
	else
		ZProj.TweenHelper.DOLocalMoveY(slot0._goepisodecontent.transform, slot4, uv3)
	end

	WuErLiXiModel.instance:setCurEpisodeIndex(slot1)
end

function slot0._onFocusEnd(slot0, slot1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0._unlockLvEnd, slot0)
	TaskDispatcher.cancelTask(slot0._finishStoryEnd, slot0)
	TaskDispatcher.cancelTask(slot0._unlockStory, slot0)
	TaskDispatcher.cancelTask(slot0._playStoryFinishAnim, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()

	slot0._episodeItems = nil
end

return slot0
