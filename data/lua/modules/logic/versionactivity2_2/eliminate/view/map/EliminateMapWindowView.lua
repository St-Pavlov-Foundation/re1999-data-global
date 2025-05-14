module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapWindowView", package.seeall)

local var_0_0 = class("EliminateMapWindowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "window/bottom/node1/#go_select")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_index")
	arg_1_0._txtnodenameen = gohelper.findChildText(arg_1_0.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_nodename_en")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/title/#simage_title")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "window/title/#txt_time")

	gohelper.setActive(arg_1_0._txttime, false)

	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bottom/#simage_bottom")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.UnlockKey = "EliminateMapWindowViewUnlockKey"

function var_0_0.onRewardClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.EliminateTaskView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goexcessive = gohelper.findChild(arg_5_0.viewGO, "excessive")
	arg_5_0._rewardAnimator = gohelper.findChild(arg_5_0.viewGO, "window/righttop/reward/ani"):GetComponent("Animator")
	arg_5_0.rewardClick = gohelper.findChildClick(arg_5_0.viewGO, "window/righttop/reward/clickArea")

	arg_5_0.rewardClick:AddClickListener(arg_5_0.onRewardClick, arg_5_0)
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()

	arg_5_0.goRedDot = gohelper.findChild(arg_5_0.viewGO, "window/righttop/reward/reddot")
	arg_5_0._redDotComp = RedDotController.instance:addNotEventRedDot(arg_5_0.goRedDot, arg_5_0._isShowRedDot, arg_5_0)
	arg_5_0.chapterNodeList = {}
	arg_5_0.chapterAnimatorList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, EliminateMapModel.getChapterNum() do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.index = iter_5_0
		var_5_0.go = gohelper.findChild(arg_5_0.viewGO, "window/bottom/node" .. iter_5_0)
		var_5_0.goSelect = gohelper.findChild(var_5_0.go, "#go_unlock/#go_select")
		var_5_0.goUnSelect = gohelper.findChild(var_5_0.go, "#go_unlock/#go_unselect")
		var_5_0.goLock = gohelper.findChild(var_5_0.go, "#go_lock")
		var_5_0.goUnLock = gohelper.findChild(var_5_0.go, "#go_unlock")
		var_5_0.goUnLockCanvasGroup = var_5_0.goUnLock:GetComponent(typeof(UnityEngine.CanvasGroup))
		var_5_0.click = gohelper.findChildClick(var_5_0.go, "clickarea")

		var_5_0.click:AddClickListener(arg_5_0.onClickChapterItem, arg_5_0, var_5_0)
		table.insert(arg_5_0.chapterAnimatorList, var_5_0.goLock:GetComponent(typeof(UnityEngine.Animator)))
		table.insert(arg_5_0.chapterNodeList, var_5_0)
	end

	arg_5_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, arg_5_0.onSelectChapterChange, arg_5_0)
	arg_5_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnUpdateEpisodeInfo, arg_5_0.onUpdateEpisodeInfo, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0, LuaEventSystem.Low)
	arg_5_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.UpdateTask, arg_5_0._updateTaskHandler, arg_5_0, LuaEventSystem.Low)
end

function var_0_0._isShowRedDot(arg_6_0)
	return EliminateTaskListModel.instance:getFinishTaskCount() > 0
end

function var_0_0._updateTaskHandler(arg_7_0)
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()

	local var_7_0 = EliminateTaskListModel.instance:getFinishTaskCount() > 0

	arg_7_0._rewardAnimator:Play(var_7_0 and "loop" or "idle")
	arg_7_0._redDotComp:refreshRedDot()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.lastCanFightChapterId = EliminateMapModel.instance:getLastCanFightChapterId()
	arg_9_0.chapterCoList = EliminateMapModel.getChapterConfigList()

	arg_9_0:refreshUI()
	arg_9_0:_updateTaskHandler()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0.chapterId = arg_10_0.viewContainer.chapterId

	arg_10_0:refreshChapterUI()
end

function var_0_0.refreshChapterUI(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.chapterCoList) do
		arg_11_0:refreshChapterItem(iter_11_1, arg_11_0.chapterNodeList[iter_11_0])
	end

	if arg_11_0:isPlayedChapterUnlockAnimation(arg_11_0.chapterId) then
		return
	end

	arg_11_0:playChapterUnlockAnimation(arg_11_0.chapterId, arg_11_0.unlockAnimationDone)
end

function var_0_0.refreshChapterItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.chapterId == arg_12_1.id

	gohelper.setActive(arg_12_2.goSelect, var_12_0)
	gohelper.setActive(arg_12_2.goUnSelect, not var_12_0)

	local var_12_1 = EliminateMapModel.instance:checkChapterIsUnlock(arg_12_1.id)

	gohelper.setActive(arg_12_2.goLock, not var_12_1)
	gohelper.setActive(arg_12_2.goUnLock, true)

	arg_12_2.goUnLockCanvasGroup.alpha = var_12_1 and 1 or 0.5
end

function var_0_0.onClickChapterItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.chapterCoList[arg_13_1.index]

	if arg_13_0.chapterId == var_13_0.id then
		return
	end

	local var_13_1 = EliminateMapModel.instance:getChapterStatus(var_13_0.id)

	if var_13_1 == EliminateMapEnum.ChapterStatus.notOpen then
		local var_13_2, var_13_3 = OpenHelper.getToastIdAndParam(var_13_0.openId)

		GameFacade.showToastWithTableParam(var_13_2, var_13_3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)

		return
	end

	if var_13_1 == EliminateMapEnum.ChapterStatus.Lock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
	arg_13_0.viewContainer:changeChapterId(var_13_0.id)
end

function var_0_0.onSelectChapterChange(arg_14_0)
	arg_14_0:refreshUI()
end

function var_0_0.onUpdateEpisodeInfo(arg_15_0)
	arg_15_0:_updateTaskHandler()

	local var_15_0 = EliminateMapModel.instance:getLastCanFightChapterId()

	if var_15_0 == arg_15_0.lastCanFightChapterId then
		arg_15_0.nextChapterId = nil

		return
	end

	if not EliminateMapModel.instance:checkChapterIsUnlock(var_15_0) then
		arg_15_0.nextChapterId = nil

		return
	end

	arg_15_0.nextChapterId = var_15_0
	arg_15_0.lastCanFightChapterId = var_15_0
end

function var_0_0._onCloseViewFinish(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.EliminateLevelView and arg_16_0.nextChapterId then
		UIBlockMgr.instance:startBlock(var_0_0.UnlockKey)
		TaskDispatcher.runDelay(arg_16_0._delayUnlock, arg_16_0, EliminateMapEnum.MapViewOpenAnimLength)
	end
end

function var_0_0._delayUnlock(arg_17_0)
	arg_17_0:playChapterUnlockAnimation(arg_17_0.nextChapterId, arg_17_0.unlockAnimationDoneNeedSwitchChapter)
end

function var_0_0.playChapterUnlockAnimation(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		UIBlockMgr.instance:endBlock(var_0_0.UnlockKey)

		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_18_0.viewName) then
		UIBlockMgr.instance:endBlock(var_0_0.UnlockKey)

		return
	end

	arg_18_0.nextChapterId = nil

	local var_18_0 = arg_18_0.chapterNodeList[arg_18_1]

	gohelper.setActive(var_18_0.goLock, true)

	arg_18_0.playingUnlockAnimationChapterId = arg_18_1
	arg_18_0._unlockChapterId = arg_18_1

	if arg_18_0.chapterAnimatorList[arg_18_1] then
		UIBlockMgr.instance:startBlock(var_0_0.UnlockKey)

		arg_18_0.unlockCallback = arg_18_2

		TaskDispatcher.cancelTask(arg_18_0._delayUnlockChapter, arg_18_0)
		TaskDispatcher.runDelay(arg_18_0._delayUnlockChapter, arg_18_0, 1)
		TaskDispatcher.runDelay(arg_18_0.unlockCallback, arg_18_0, EliminateMapEnum.MapViewChapterUnlockDuration)
		gohelper.setActive(arg_18_0._goexcessive, false)
		gohelper.setActive(arg_18_0._goexcessive, true)
	elseif arg_18_2 then
		arg_18_2(arg_18_0)
	end
end

function var_0_0._delayUnlockChapter(arg_19_0)
	local var_19_0 = arg_19_0.chapterAnimatorList[arg_19_0._unlockChapterId]

	arg_19_0._unlockChapterId = nil

	if var_19_0 then
		gohelper.setActive(var_19_0, true)
		var_19_0:Play(UIAnimationName.Unlock)
	end
end

function var_0_0.unlockAnimationDone(arg_20_0)
	UIBlockMgr.instance:endBlock(var_0_0.UnlockKey)
	arg_20_0:recordPlayChapterUnlockAnimation(arg_20_0.playingUnlockAnimationChapterId)

	arg_20_0.playingUnlockAnimationChapterId = nil
	arg_20_0.unlockCallback = nil
end

function var_0_0.unlockAnimationDoneNeedSwitchChapter(arg_21_0)
	local var_21_0 = arg_21_0.playingUnlockAnimationChapterId

	arg_21_0:unlockAnimationDone()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.UnlockChapterAnimDone)
	arg_21_0.viewContainer:changeChapterId(var_21_0)
end

function var_0_0.initPlayedChapterUnlockAnimationList(arg_22_0)
	if arg_22_0.playedChapterIdList then
		return
	end

	local var_22_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateChapterUnlockAnimationKey))

	if string.nilorempty(var_22_0) then
		arg_22_0.playedChapterIdList = {}
	end

	arg_22_0.playedChapterIdList = string.splitToNumber(var_22_0, ";")
end

function var_0_0.isPlayedChapterUnlockAnimation(arg_23_0, arg_23_1)
	arg_23_0:initPlayedChapterUnlockAnimationList()

	return true
end

function var_0_0.recordPlayChapterUnlockAnimation(arg_24_0, arg_24_1)
	if tabletool.indexOf(arg_24_0.playedChapterIdList, arg_24_1) then
		return
	end

	table.insert(arg_24_0.playedChapterIdList, arg_24_1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateChapterUnlockAnimationKey), table.concat(arg_24_0.playedChapterIdList, ";"))
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._delayUnlockChapter, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._simagebottom:UnLoadImage()
	TaskDispatcher.cancelTask(arg_26_0._delayUnlock, arg_26_0)

	if arg_26_0.unlockCallback then
		TaskDispatcher.cancelTask(arg_26_0.unlockCallback, arg_26_0)
	end

	arg_26_0.rewardClick:RemoveClickListener()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.chapterNodeList) do
		iter_26_1.click:RemoveClickListener()
	end
end

return var_0_0
