module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapWindowView", package.seeall)

slot0 = class("YaXianMapWindowView", BaseView)

function slot0.onInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "window/bottom/#go_node/node1/#go_select")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "window/bottom/#go_node/node1/info/#txt_nodename/#txt_index")
	slot0._txtnodenameen = gohelper.findChildText(slot0.viewGO, "window/bottom/#go_node/node1/info/#txt_nodename/#txt_nodename_en")
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

slot0.UnlockKey = "YaXianMapWindowViewUnlockKey"

function slot0.onRewardClick(slot0)
	ViewMgr.instance:openView(ViewName.YaXianRewardView)
end

function slot0.onCollectClick(slot0)
	ViewMgr.instance:openView(ViewName.YaXianCollectView)
end

function slot0._editableInitView(slot0)
	slot0._simagebottom:LoadImage(ResUrl.getYaXianImage("img_quyu_bg"))

	slot0.txtReward = gohelper.findChildText(slot0.viewGO, "window/righttop/reward/#txt_reward")
	slot0.txtCollect = gohelper.findChildText(slot0.viewGO, "window/righttop/collect/#txt_collect")
	slot0.collectClick = gohelper.findChildClick(slot0.viewGO, "window/righttop/collect/clickArea")

	slot0.collectClick:AddClickListener(slot0.onCollectClick, slot0)

	slot0.rewardClick = gohelper.findChildClick(slot0.viewGO, "window/righttop/reward/clickArea")

	slot0.rewardClick:AddClickListener(slot0.onRewardClick, slot0)

	slot0.goRedDot = gohelper.findChild(slot0.viewGO, "window/righttop/reward/reddot")
	slot4 = RedDotEnum.DotNode.YaXianReward

	RedDotController.instance:addRedDot(slot0.goRedDot, slot4)

	slot0.chapterNodeList = {}
	slot0.chapterAnimatorList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.index = slot4
		slot5.go = gohelper.findChild(slot0.viewGO, "window/bottom/#go_node/node" .. slot4)
		slot5.goSelect = gohelper.findChild(slot5.go, "#go_select")
		slot5.goLock = gohelper.findChild(slot5.go, "#go_lock")
		slot5.txtChapterName = gohelper.findChildText(slot5.go, "info/#txt_nodename")
		slot5.txtChapterNameEn = gohelper.findChildText(slot5.go, "info/#txt_nodename/#txt_nodename_en")
		slot5.txtChapterIndex = gohelper.findChildText(slot5.go, "info/#txt_nodename/#txt_index")
		slot5.click = gohelper.findChildClick(slot5.go, "clickarea")

		slot5.click:AddClickListener(slot0.onClickChapterItem, slot0, slot5)
		table.insert(slot0.chapterAnimatorList, slot5.go:GetComponent(typeof(UnityEngine.Animator)))
		table.insert(slot0.chapterNodeList, slot5)
	end

	slot0:addEventCb(YaXianController.instance, YaXianEvent.OnSelectChapterChange, slot0.onSelectChapterChange, slot0)
	slot0:addEventCb(YaXianController.instance, YaXianEvent.OnUpdateEpisodeInfo, slot0.onUpdateEpisodeInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.lastCanFightChapterId = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId
	slot0.chapterCoList = YaXianConfig.instance:getChapterConfigList()

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId

	slot0:refreshTxt()
	slot0:refreshChapterUI()
end

function slot0.refreshTxt(slot0)
	slot0.txtReward.text = YaXianModel.instance:getScore() .. "/" .. YaXianConfig.instance:getMaxBonusScore()
	slot0.txtCollect.text = YaXianModel.instance:getHadToothCount() - 1 .. "/" .. #lua_activity115_tooth.configList - 1
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

function slot0.refreshTime(slot0)
	slot2, slot3 = ActivityModel.instance:getActivityInfo()[YaXianEnum.ActivityId]:getRemainTime()

	if LangSettings.instance:isEn() then
		slot0._txttime.text = string.format(luaLang("remain"), string.format("%s%s", slot2, slot3))
	else
		slot0._txttime.text = string.format(luaLang("remain"), string.format("<nbsp>%s<nbsp>%s", slot2, slot3))
	end
end

function slot0.refreshChapterItem(slot0, slot1, slot2)
	gohelper.setActive(slot2.goSelect, slot0.chapterId == slot1.id)
	gohelper.setActive(slot2.goLock, not YaXianController.instance:checkChapterIsUnlock(slot1.id))

	slot2.txtChapterName.text = slot1.name
	slot2.txtChapterNameEn.text = slot1.name_En
	slot2.txtChapterIndex.text = slot1.id
end

function slot0.onClickChapterItem(slot0, slot1)
	if slot0.chapterId == slot0.chapterCoList[slot1.index].id then
		return
	end

	if YaXianController.instance:getChapterStatus(slot2.id) == YaXianEnum.ChapterStatus.notOpen then
		slot4, slot5 = OpenHelper.getToastIdAndParam(slot2.openId)

		GameFacade.showToastWithTableParam(slot4, slot5)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)

		return
	end

	if slot3 == YaXianEnum.ChapterStatus.Lock then
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
	slot0:refreshTxt()

	if YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId == slot0.lastCanFightChapterId then
		slot0.nextChapterId = nil

		return
	end

	if not YaXianController.instance:checkChapterIsUnlock(slot1) then
		slot0.nextChapterId = nil

		return
	end

	slot0.nextChapterId = slot1
end

function slot0._onCloseViewFinish(slot0)
	if slot0.nextChapterId then
		slot0:playChapterUnlockAnimation(slot0.nextChapterId, slot0.unlockAnimationDoneNeedSwitchChapter)
	end
end

function slot0.playChapterUnlockAnimation(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	slot0.nextChapterId = nil

	gohelper.setActive(slot0.chapterNodeList[slot1].goLock, true)

	slot0.playingUnlockAnimationChapterId = slot1

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

	if slot0.chapterAnimatorList[slot1] then
		UIBlockMgr.instance:startBlock(uv0.UnlockKey)
		slot4:Play(UIAnimationName.Unlock)

		slot0.unlockCallback = slot2

		TaskDispatcher.runDelay(slot0.unlockCallback, slot0, YaXianEnum.MapViewChapterUnlockDuration)
	elseif slot2 then
		slot2(slot0)
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
	slot0.viewContainer:changeChapterId(slot0.playingUnlockAnimationChapterId)
end

function slot0.initPlayedChapterUnlockAnimationList(slot0)
	if slot0.playedChapterIdList then
		return
	end

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianChapterUnlockAnimationKey))) then
		slot0.playedChapterIdList = {}
	end

	slot0.playedChapterIdList = string.splitToNumber(slot1, ";")
end

function slot0.isPlayedChapterUnlockAnimation(slot0, slot1)
	slot0:initPlayedChapterUnlockAnimationList()

	return tabletool.indexOf(slot0.playedChapterIdList, slot1)
end

function slot0.recordPlayChapterUnlockAnimation(slot0, slot1)
	if tabletool.indexOf(slot0.playedChapterIdList, slot1) then
		return
	end

	table.insert(slot0.playedChapterIdList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianChapterUnlockAnimationKey), table.concat(slot0.playedChapterIdList, ";"))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebottom:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)

	if slot0.unlockCallback then
		TaskDispatcher.cancelTask(slot0.unlockCallback, slot0)
	end

	slot0.collectClick:RemoveClickListener()
	slot0.rewardClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.chapterNodeList) do
		slot5.click:RemoveClickListener()
	end
end

return slot0
