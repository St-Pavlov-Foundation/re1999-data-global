module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErLevelView", package.seeall)

slot0 = class("ZhiXinQuanErLevelView", BaseView)
slot1 = 0.5

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "bgs/#simage_FullBG")
	slot0._simageFullBG2 = gohelper.findChildSingleImage(slot0.viewGO, "bgs/#simage_FullBG/#simage_FullBG2")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryStages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._gofightPath = gohelper.findChild(slot0.viewGO, "#go_fightPath")
	slot0._gofightScroll = gohelper.findChild(slot0.viewGO, "#go_fightPath/#go_fightScroll")
	slot0._gofightStages = gohelper.findChild(slot0.viewGO, "#go_fightPath/#go_fightScroll/#go_fightStages")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	slot0._btnPlayBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Title/#btn_PlayBtn")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._animPath = gohelper.findChild(slot0._gostoryScroll, "path/path_2"):GetComponent(gohelper.Type_Animator)
	slot0._animTask = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._gostoryPath, "")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlayBtn:AddClickListener(slot0._btnPlayBtnOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlayBtn:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
end

function slot0._btnPlayBtnOnClick(slot0)
	if slot0.actConfig.storyId > 0 then
		StoryController.instance:playStory(slot0.actConfig.storyId)
	end
end

function slot0._btnTaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ZhiXinQuanErTaskView)
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._scrollStory:AddOnValueChanged(slot0._onScrollValueChanged, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)

	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
	slot0.actConfig = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot1 - -300) / 2
	slot0.minContentAnchorX = -4560 + slot1

	RoleActivityModel.instance:initData(slot0.actId)
	slot0:_initStageItems()
	gohelper.setActive(slot0._btnPlayBtn, slot0.actConfig.storyId > 0)

	slot0._bgWidth = recthelper.getWidth(slot0._simageFullBG.transform) + recthelper.getWidth(slot0._simageFullBG2.transform)
	slot0._minBgPositionX = BootNativeUtil.getDisplayResolution() - slot0._bgWidth
	slot0._maxBgPositionX = 0
	slot0._bgPositonMaxOffsetX = math.abs(slot0._maxBgPositionX - slot0._minBgPositionX)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, slot0.OnStoryItemClick, slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.FightItemClick, slot0.OnFightItemClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0.OnStoryFinish, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Start, slot0.OnStoryStart, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, slot0.OnEndDungeonPush, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0.OnDotChange, slot0)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0._btnTask.gameObject, "#go_reddot"), RedDotEnum.DotNode.V1a6RoleActivityTask, slot0.actId)
	slot0:OnDotChange()
	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)

	if slot0.viewParam and slot0.viewParam.needShowFight then
		if RoleActivityModel.instance:getEnterFightIndex(slot0.actId) then
			slot0.latestfightItem = slot2

			for slot6, slot7 in ipairs(slot0.fightItemList) do
				slot7:refreshSelect(slot2)
			end
		end

		slot0:_lockScreen(true)
		TaskDispatcher.runDelay(slot0._delayOpenFight, slot0, 0.3)
	elseif slot0:_checkFirstEnter() then
		slot0:_lockScreen(true)
		slot0.storyItemList[1]:lockStatus()
		TaskDispatcher.runDelay(slot0._playFirstUnlock, slot0, 0.8)
	end

	slot0:_initBgPosition()
	slot0:_initPathStatus()
end

function slot0._checkFirstEnter(slot0)
	if not slot0.storyItemList[2]:isUnlock() and PlayerPrefsHelper.getNumber("ActZhiXinQuanErFirstEnter", 0) == 0 then
		PlayerPrefsHelper.setNumber("ActZhiXinQuanErFirstEnter", 1)

		return true
	end

	return false
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenFight, slot0)
	TaskDispatcher.cancelTask(slot0._playFirstUnlock, slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenStory, slot0)
	TaskDispatcher.cancelTask(slot0._unlockStoryEnd, slot0)
	TaskDispatcher.cancelTask(slot0._finishStoryEnd, slot0)
	TaskDispatcher.cancelTask(slot0._playPathAnim, slot0)
	TaskDispatcher.cancelTask(slot0._unlockFightEnd, slot0)
	TaskDispatcher.cancelTask(slot0._unlockStory, slot0)
	TaskDispatcher.cancelTask(slot0._starShowEnd, slot0)
	TaskDispatcher.cancelTask(slot0._playStoryFinishAnim, slot0)
	slot0:_lockScreen(false)
end

function slot0.onDestroyView(slot0)
	slot0.storyItemList = nil
	slot0.fightItemList = nil

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end

	if slot0._scrollStory then
		slot0._scrollStory:RemoveOnValueChanged()
	end
end

function slot0.OnStoryItemClick(slot0, slot1)
	slot0:_focusStoryItem(slot1, true)
end

function slot0.OnFightItemClick(slot0, slot1)
	if slot0.latestfightItem == slot1 then
		return
	end

	slot0.latestfightItem = slot1
	slot5 = AudioEnum.RoleActivity.fight_switch

	AudioMgr.instance:trigger(slot5)

	for slot5, slot6 in ipairs(slot0.fightItemList) do
		slot6:refreshSelect(slot1)
	end
end

function slot0.OnStoryStart(slot0, slot1)
	if not slot0:getLatestStoryCo() or slot2.afterStory ~= slot1 then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(slot2.id) then
		return
	end

	slot0._newFinishStoryLvlId = slot2.id
end

function slot0.OnStoryFinish(slot0)
	RoleActivityModel.instance:updateData(slot0.actId)
	TaskDispatcher.runDelay(slot0._playStoryFinishAnim, slot0, 0.73)
end

function slot0.OnEndDungeonPush(slot0)
	RoleActivityModel.instance:updateData(slot0.actId)

	slot3 = Activity176Config.instance:hasElementCo(slot0.actId, slot0:getLatestStoryCo() and slot1.id)

	if slot1 and slot1.afterStory ~= 0 then
		return
	end

	TaskDispatcher.runDelay(slot0._playStoryFinishAnim, slot0, 0.73 + (slot3 and 1.5 or 0))
end

function slot0.getLatestStoryCo(slot0)
	return RoleActivityConfig.instance:getStoryLevelList(slot0.actId) and slot1[slot0.latestStoryItem]
end

function slot0.OnDotChange(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V1a6RoleActivityTask, slot0.actId) then
		slot0._animTask:Play("loop")
	else
		slot0._animTask:Play("idle")
	end
end

function slot0._onStoryOpenEnd(slot0)
	slot0:_initPathStatus()
end

function slot0._onFightOpenEnd(slot0)
	slot0:_playFightFinishAnim()
end

function slot0._onGoStoryEnd(slot0)
	slot0:_initPathStatus()
end

function slot0._onDragBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onScrollValueChanged(slot0)
	slot0:_initBgPosition()
end

function slot0._initBgPosition(slot0)
	recthelper.setAnchorX(slot0._simageFullBG.transform, Mathf.Clamp(-slot0._scrollStory.horizontalNormalizedPosition * slot0._bgPositonMaxOffsetX, slot0._minBgPositionX, slot0._maxBgPositionX))
end

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._initStageItems(slot0)
	slot1, slot2 = nil
	slot0.storyItemList = {}

	for slot7 = 1, #RoleActivityConfig.instance:getStoryLevelList(slot0.actId) do
		slot0.storyItemList[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostoryStages, "stage" .. slot7)), ZhiXinQuanErStoryItem, slot0)

		slot0.storyItemList[slot7]:setParam(slot3[slot7], slot7, slot0.actId)

		if slot0.storyItemList[slot7]:isUnlock() then
			slot0.latestStoryItem = slot7
		end
	end

	slot0:_focusStoryItem(slot0.latestStoryItem)

	slot0.fightItemList = {}

	for slot8 = 1, #RoleActivityConfig.instance:getBattleLevelList(slot0.actId) / 2 do
		slot0.fightItemList[slot8] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], gohelper.findChild(slot0._gofightStages, "stage" .. slot8)), RoleActFightItem, slot0)

		slot0.fightItemList[slot8]:setParam(slot4[2 * slot8 - 1], slot8, slot0.actId)

		if slot0.fightItemList[slot8]:isUnlock() then
			slot0.latestfightItem = slot8
		end
	end

	if slot0.fightItemList[slot0.latestfightItem] then
		slot5:refreshSelect()
	end
end

function slot0._updateStoryFocusFlag(slot0, slot1, slot2)
	if slot2 and (slot0.storyItemList[slot0._focusStoryIndex] ~= nil and slot0.storyItemList[slot1] ~= nil) then
		slot0:_lockScreen(true)

		slot8, slot9 = recthelper.rectToRelativeAnchorPos2(slot4:getFocusFlagTran().position, slot3.viewGO.transform)

		slot3:setFocusFlagDir(slot1 < slot0._focusStoryIndex)
		ZProj.TweenHelper.DOAnchorPos(slot3:getFocusFlagTran(), slot8, slot9, uv0, slot0._onMoveFocusFlagDone, slot0, slot1)
	else
		slot0:_onMoveFocusFlagDone(slot1)
	end
end

function slot0._onMoveFocusFlagDone(slot0, slot1)
	slot3 = slot0.storyItemList[slot1]

	if slot0.storyItemList[slot0._focusStoryIndex] then
		slot2:setFocusFlag(false)
		slot2:setFocusFlagDir(false)
	end

	if slot3 then
		slot3:setFocusFlag(true)
		slot3:setFocusFlagDir(slot0._focusStoryIndex and slot1 < slot0._focusStoryIndex)
	end

	slot0._focusStoryIndex = slot1

	slot0:_lockScreen(false)
end

function slot0._playFirstUnlock(slot0)
	slot0.finishStoryIndex = 0

	slot0.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(slot0._unlockStoryEnd, slot0, 1.33)
end

function slot0._playStoryFinishAnim(slot0)
	if RoleActivityModel.instance:getNewFinishStoryLvl() or slot0._newFinishStoryLvlId then
		for slot6, slot7 in ipairs(slot0.storyItemList) do
			if slot7.id == slot2 then
				slot0:_lockScreen(true)

				slot0.finishStoryIndex = slot6

				slot7:playFinish()
				slot7:playStarAnim()
				TaskDispatcher.runDelay(slot0._finishStoryEnd, slot0, 1)

				break
			end
		end

		slot0._newFinishStoryLvlId = nil

		RoleActivityModel.instance:clearNewFinishStoryLvl()
	end
end

function slot0._finishStoryEnd(slot0)
	if slot0.finishStoryIndex == #slot0.storyItemList then
		slot0.latestStoryItem = slot0.finishStoryIndex
		slot0.finishStoryIndex = nil

		slot0:_lockScreen(false)
	else
		slot0.latestStoryItem = slot0.finishStoryIndex + 1

		slot0:_playPathAnim()
	end
end

function slot0._playPathAnim(slot0)
	slot0._animPath.speed = 1

	slot0._animPath:Play("go" .. slot0.finishStoryIndex)
	TaskDispatcher.runDelay(slot0._unlockStory, slot0, 0.33)
end

function slot0._unlockStory(slot0)
	slot0.storyItemList[slot0.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(slot0._unlockStoryEnd, slot0, 1)
end

function slot0._unlockStoryEnd(slot0)
	slot0.storyItemList[slot0.finishStoryIndex + 1]:refreshStatus()

	slot0.finishStoryIndex = nil

	slot0:_lockScreen(false)
end

function slot0._playFightFinishAnim(slot0)
	if RoleActivityModel.instance:getNewFinishFightLvl() then
		slot5 = slot0.actId

		RoleActivityModel.instance:updateData(slot5)

		for slot5, slot6 in ipairs(slot0.fightItemList) do
			if slot6.id == slot1 then
				slot0.finishFightIndex = slot5

				slot6:refreshStar()
				slot6:playStarAnim(true)
				TaskDispatcher.runDelay(slot0._starShowEnd, slot0, 0.67)

				break
			elseif slot6.hardConfig.id == slot1 then
				slot6:refreshStar()
				slot6:playStarAnim()
				slot0:_lockScreen(false)

				break
			end
		end

		RoleActivityModel.instance:clearNewFinishFightLvl()

		return
	end

	slot0:_lockScreen(false)
end

function slot0._starShowEnd(slot0)
	slot0.fightItemList[slot0.finishFightIndex]:playHardUnlock()
	TaskDispatcher.runDelay(slot0._unlockFightEnd, slot0, 1.7)

	if slot0.fightItemList[slot0.finishFightIndex + 1] then
		slot0.fightItemList[slot0.finishFightIndex + 1]:playUnlock()
	end
end

function slot0._unlockFightEnd(slot0)
	slot0.fightItemList[slot0.finishFightIndex]:refreshStatus()

	if slot0.fightItemList[slot0.finishFightIndex + 1] then
		slot0.fightItemList[slot0.finishFightIndex + 1]:refreshStatus()
	end

	slot0.finishFightIndex = nil

	slot0:_lockScreen(false)
end

function slot0._delayOpenStory(slot0)
	slot0._anim:Play("openstory", 0, 0)
end

function slot0._delayOpenFight(slot0)
	slot0._anim:Play("openfight", 0, 0)
end

function slot0._showLeftTime(slot0)
	slot0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0._initPathStatus(slot0)
	if slot0.latestStoryItem > 1 then
		slot0._animPath:Play("go" .. slot0.latestStoryItem - 1, 0, 1)
	else
		slot0._animPath.speed = 0

		slot0._animPath:Play("go1", 0, 0)
	end
end

function slot0._focusStoryItem(slot0, slot1, slot2)
	if slot0._offsetX - recthelper.getAnchorX(slot0.storyItemList[slot1].transform.parent) > 0 then
		slot4 = 0
	elseif slot4 < slot0.minContentAnchorX then
		slot4 = slot0.minContentAnchorX
	end

	if slot2 then
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot4, uv0, slot0._onFocusEnd, slot0, slot1)
	else
		recthelper.setAnchorX(slot0._gostoryScroll.transform, slot4)
	end

	slot0:_updateStoryFocusFlag(slot1, slot2)
end

function slot0._onFocusEnd(slot0, slot1)
	slot0.storyItemList[slot1]:playStory()
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("ZhiXinQuanErLock")
	else
		UIBlockMgr.instance:endBlock("ZhiXinQuanErLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return slot0
