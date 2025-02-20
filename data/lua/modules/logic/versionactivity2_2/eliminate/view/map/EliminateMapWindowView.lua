module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapWindowView", package.seeall)

slot0 = class("EliminateMapWindowView", BaseView)

function slot0.onInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "window/bottom/node1/#go_select")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_index")
	slot0._txtnodenameen = gohelper.findChildText(slot0.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_nodename_en")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "window/title/#simage_title")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "window/title/#txt_time")

	gohelper.setActive(slot0._txttime, false)

	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "window/bottom/#simage_bottom")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.UnlockKey = "EliminateMapWindowViewUnlockKey"

function slot0.onRewardClick(slot0)
	ViewMgr.instance:openView(ViewName.EliminateTaskView)
end

function slot0._editableInitView(slot0)
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "excessive")
	slot0._rewardAnimator = gohelper.findChild(slot0.viewGO, "window/righttop/reward/ani"):GetComponent("Animator")
	slot0.rewardClick = gohelper.findChildClick(slot0.viewGO, "window/righttop/reward/clickArea")

	slot0.rewardClick:AddClickListener(slot0.onRewardClick, slot0)
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()

	slot0.goRedDot = gohelper.findChild(slot0.viewGO, "window/righttop/reward/reddot")
	slot5 = slot0.goRedDot
	slot0._redDotComp = RedDotController.instance:addNotEventRedDot(slot5, slot0._isShowRedDot, slot0)
	slot0.chapterNodeList = {}
	slot0.chapterAnimatorList = slot0:getUserDataTb_()

	for slot5 = 1, EliminateMapModel.getChapterNum() do
		slot6 = slot0:getUserDataTb_()
		slot6.index = slot5
		slot6.go = gohelper.findChild(slot0.viewGO, "window/bottom/node" .. slot5)
		slot6.goSelect = gohelper.findChild(slot6.go, "#go_unlock/#go_select")
		slot6.goUnSelect = gohelper.findChild(slot6.go, "#go_unlock/#go_unselect")
		slot6.goLock = gohelper.findChild(slot6.go, "#go_lock")
		slot6.goUnLock = gohelper.findChild(slot6.go, "#go_unlock")
		slot6.goUnLockCanvasGroup = slot6.goUnLock:GetComponent(typeof(UnityEngine.CanvasGroup))
		slot6.click = gohelper.findChildClick(slot6.go, "clickarea")

		slot6.click:AddClickListener(slot0.onClickChapterItem, slot0, slot6)
		table.insert(slot0.chapterAnimatorList, slot6.goLock:GetComponent(typeof(UnityEngine.Animator)))
		table.insert(slot0.chapterNodeList, slot6)
	end

	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, slot0.onSelectChapterChange, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnUpdateEpisodeInfo, slot0.onUpdateEpisodeInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.UpdateTask, slot0._updateTaskHandler, slot0, LuaEventSystem.Low)
end

function slot0._isShowRedDot(slot0)
	return EliminateTaskListModel.instance:getFinishTaskCount() > 0
end

function slot0._updateTaskHandler(slot0)
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()
	slot0._rewardAnimator:Play(EliminateTaskListModel.instance:getFinishTaskCount() > 0 and "loop" or "idle")
	slot0._redDotComp:refreshRedDot()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.lastCanFightChapterId = EliminateMapModel.instance:getLastCanFightChapterId()
	slot0.chapterCoList = EliminateMapModel.getChapterConfigList()

	slot0:refreshUI()
	slot0:_updateTaskHandler()
end

function slot0.refreshUI(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId

	slot0:refreshChapterUI()
end

function slot0.refreshChapterUI(slot0)
	for slot4, slot5 in ipairs(slot0.chapterCoList) do
		slot0:refreshChapterItem(slot5, slot0.chapterNodeList[slot4])
	end

	if slot0:isPlayedChapterUnlockAnimation(slot0.chapterId) then
		return
	end

	slot0:playChapterUnlockAnimation(slot0.chapterId, slot0.unlockAnimationDone)
end

function slot0.refreshChapterItem(slot0, slot1, slot2)
	slot3 = slot0.chapterId == slot1.id

	gohelper.setActive(slot2.goSelect, slot3)
	gohelper.setActive(slot2.goUnSelect, not slot3)

	slot4 = EliminateMapModel.instance:checkChapterIsUnlock(slot1.id)

	gohelper.setActive(slot2.goLock, not slot4)
	gohelper.setActive(slot2.goUnLock, true)

	slot2.goUnLockCanvasGroup.alpha = slot4 and 1 or 0.5
end

function slot0.onClickChapterItem(slot0, slot1)
	if slot0.chapterId == slot0.chapterCoList[slot1.index].id then
		return
	end

	if EliminateMapModel.instance:getChapterStatus(slot2.id) == EliminateMapEnum.ChapterStatus.notOpen then
		slot4, slot5 = OpenHelper.getToastIdAndParam(slot2.openId)

		GameFacade.showToastWithTableParam(slot4, slot5)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)

		return
	end

	if slot3 == EliminateMapEnum.ChapterStatus.Lock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
	slot0.viewContainer:changeChapterId(slot2.id)
end

function slot0.onSelectChapterChange(slot0)
	slot0:refreshUI()
end

function slot0.onUpdateEpisodeInfo(slot0)
	slot0:_updateTaskHandler()

	if EliminateMapModel.instance:getLastCanFightChapterId() == slot0.lastCanFightChapterId then
		slot0.nextChapterId = nil

		return
	end

	if not EliminateMapModel.instance:checkChapterIsUnlock(slot1) then
		slot0.nextChapterId = nil

		return
	end

	slot0.nextChapterId = slot1
	slot0.lastCanFightChapterId = slot1
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.EliminateLevelView and slot0.nextChapterId then
		UIBlockMgr.instance:startBlock(uv0.UnlockKey)
		TaskDispatcher.runDelay(slot0._delayUnlock, slot0, EliminateMapEnum.MapViewOpenAnimLength)
	end
end

function slot0._delayUnlock(slot0)
	slot0:playChapterUnlockAnimation(slot0.nextChapterId, slot0.unlockAnimationDoneNeedSwitchChapter)
end

function slot0.playChapterUnlockAnimation(slot0, slot1, slot2)
	if not slot1 then
		UIBlockMgr.instance:endBlock(uv0.UnlockKey)

		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		UIBlockMgr.instance:endBlock(uv0.UnlockKey)

		return
	end

	slot0.nextChapterId = nil

	gohelper.setActive(slot0.chapterNodeList[slot1].goLock, true)

	slot0.playingUnlockAnimationChapterId = slot1
	slot0._unlockChapterId = slot1

	if slot0.chapterAnimatorList[slot1] then
		UIBlockMgr.instance:startBlock(uv0.UnlockKey)

		slot0.unlockCallback = slot2

		TaskDispatcher.cancelTask(slot0._delayUnlockChapter, slot0)
		TaskDispatcher.runDelay(slot0._delayUnlockChapter, slot0, 1)
		TaskDispatcher.runDelay(slot0.unlockCallback, slot0, EliminateMapEnum.MapViewChapterUnlockDuration)
		gohelper.setActive(slot0._goexcessive, false)
		gohelper.setActive(slot0._goexcessive, true)
	elseif slot2 then
		slot2(slot0)
	end
end

function slot0._delayUnlockChapter(slot0)
	slot0._unlockChapterId = nil

	if slot0.chapterAnimatorList[slot0._unlockChapterId] then
		gohelper.setActive(slot1, true)
		slot1:Play(UIAnimationName.Unlock)
	end
end

function slot0.unlockAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.UnlockKey)
	slot0:recordPlayChapterUnlockAnimation(slot0.playingUnlockAnimationChapterId)

	slot0.playingUnlockAnimationChapterId = nil
	slot0.unlockCallback = nil
end

function slot0.unlockAnimationDoneNeedSwitchChapter(slot0)
	slot0:unlockAnimationDone()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.UnlockChapterAnimDone)
	slot0.viewContainer:changeChapterId(slot0.playingUnlockAnimationChapterId)
end

function slot0.initPlayedChapterUnlockAnimationList(slot0)
	if slot0.playedChapterIdList then
		return
	end

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateChapterUnlockAnimationKey))) then
		slot0.playedChapterIdList = {}
	end

	slot0.playedChapterIdList = string.splitToNumber(slot1, ";")
end

function slot0.isPlayedChapterUnlockAnimation(slot0, slot1)
	slot0:initPlayedChapterUnlockAnimationList()

	return true
end

function slot0.recordPlayChapterUnlockAnimation(slot0, slot1)
	if tabletool.indexOf(slot0.playedChapterIdList, slot1) then
		return
	end

	table.insert(slot0.playedChapterIdList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateChapterUnlockAnimationKey), table.concat(slot0.playedChapterIdList, ";"))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayUnlockChapter, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebottom:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._delayUnlock, slot0)

	if slot0.unlockCallback then
		TaskDispatcher.cancelTask(slot0.unlockCallback, slot0)
	end

	slot0.rewardClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.chapterNodeList) do
		slot5.click:RemoveClickListener()
	end
end

return slot0
