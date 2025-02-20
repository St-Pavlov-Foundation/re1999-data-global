module("modules.logic.versionactivity1_9.lucy.view.ActLucyLevelView", package.seeall)

slot0 = class("ActLucyLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryStages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._gofightPath = gohelper.findChild(slot0.viewGO, "#go_fightPath")
	slot0._gofightScroll = gohelper.findChild(slot0.viewGO, "#go_fightPath/#go_fightScroll")
	slot0._gofightStages = gohelper.findChild(slot0.viewGO, "#go_fightPath/#go_fightScroll/#go_fightStages")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnPlayBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Title/#btn_PlayBtn")
	slot0._btnStory = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_Story")
	slot0._goStoryN = gohelper.findChild(slot0._btnStory.gameObject, "go_UnSelected")
	slot0._goStoryS = gohelper.findChild(slot0._btnStory.gameObject, "go_Selected")
	slot0._btnFight = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_Fight")
	slot0._goFightN = gohelper.findChild(slot0._btnFight.gameObject, "go_UnSelected")
	slot0._goFightS = gohelper.findChild(slot0._btnFight.gameObject, "go_Selected")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._animPath = gohelper.findChild(slot0._gostoryScroll, "path/path_2"):GetComponent(gohelper.Type_Animator)
	slot0._animTask = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._gostoryPath, "")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlayBtn:AddClickListener(slot0._btnPlayBtnOnClick, slot0)
	slot0._btnStory:AddClickListener(slot0._btnStoryOnClick, slot0)
	slot0._btnFight:AddClickListener(slot0._btnFightOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._animEvent:AddEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd, slot0._onStoryOpenEnd, slot0)
	slot0._animEvent:AddEventListener(RoleActivityEnum.AnimEvt.OnFightOpenEnd, slot0._onFightOpenEnd, slot0)
	slot0._animEvent:AddEventListener(RoleActivityEnum.AnimEvt.OnGoStoryEnd, slot0._onGoStoryEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlayBtn:RemoveClickListener()
	slot0._btnStory:RemoveClickListener()
	slot0._btnFight:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
end

function slot0._btnPlayBtnOnClick(slot0)
	if slot0.actConfig.storyId > 0 then
		StoryController.instance:playStory(slot0.actConfig.storyId)
	end
end

function slot0._btnStoryOnClick(slot0, slot1)
	if slot0._gostoryPath.activeInHierarchy then
		return
	end

	gohelper.setActive(slot0._goStoryN, false)
	gohelper.setActive(slot0._goStoryS, true)
	gohelper.setActive(slot0._goFightN, true)
	gohelper.setActive(slot0._goFightS, false)
	gohelper.setActive(slot0._btnPlayBtn, slot0.actConfig.storyId > 0)

	if slot1 then
		slot0._anim:Play("openstory", 0, 0)
	else
		slot0._anim:Play("gostory", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_switch)
	end
end

function slot0._btnFightOnClick(slot0, slot1)
	if slot0._gofightPath.activeInHierarchy then
		return
	end

	gohelper.setActive(slot0._goStoryN, true)
	gohelper.setActive(slot0._goStoryS, false)
	gohelper.setActive(slot0._goFightN, false)
	gohelper.setActive(slot0._goFightS, true)
	gohelper.setActive(slot0._btnPlayBtn, false)

	if slot1 then
		slot0._anim:Play("openfight", 0, 0)
	else
		slot0._anim:Play("gofight", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_switch)
	end
end

function slot0._btnTaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ActLucyTaskView)
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity1_9Enum.ActivityId.Lucy
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)

	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
	slot0.actConfig = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot1 - -300) / 2
	slot0.minContentAnchorX = -4660 + slot1

	RoleActivityModel.instance:initData(slot0.actId)
	slot0:_initStageItems()
	gohelper.setActive(slot0._btnPlayBtn, slot0.actConfig.storyId > 0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, slot0.OnStoryItemClick, slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.FightItemClick, slot0.OnFightItemClick, slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.TabSwitch, slot0.OnTabSwitch, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0.OnStoryFinish, slot0)
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

		slot0:_btnFightOnClick(true)
		slot0:_lockScreen(true)
		TaskDispatcher.runDelay(slot0._delayOpenFight, slot0, 0.3)
	else
		slot0:_btnStoryOnClick(true)

		if slot0:_checkFirstEnter() then
			slot0:_lockScreen(true)
			slot0.storyItemList[1]:lockStatus()
			TaskDispatcher.runDelay(slot0._playFirstUnlock, slot0, 0.8)
		end
	end
end

function slot0._checkFirstEnter(slot0)
	if not slot0.storyItemList[2]:isUnlock() and PlayerPrefsHelper.getNumber("ActLucyFirstEnter", 0) == 0 then
		PlayerPrefsHelper.setNumber("ActLucyFirstEnter", 1)

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

function slot0.OnTabSwitch(slot0, slot1)
	if slot1 then
		slot0:_btnFightOnClick()
	else
		slot0:_btnStoryOnClick()
	end
end

function slot0.OnStoryFinish(slot0)
	TaskDispatcher.runDelay(slot0._delayOpenStory, slot0, 0.4)
end

function slot0.OnEndDungeonPush(slot0)
	RoleActivityModel.instance:updateData(slot0.actId)
	TaskDispatcher.runDelay(slot0._playStoryFinishAnim, slot0, 0.73)
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

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._initStageItems(slot0)
	slot1, slot2 = nil
	slot0.storyItemList = {}

	for slot7 = 1, #RoleActivityConfig.instance:getStoryLevelList(slot0.actId) do
		slot0.storyItemList[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostoryStages, "stage" .. slot7)), LucyStoryItem, slot0)

		slot0.storyItemList[slot7]:setParam(slot3[slot7], slot7, slot0.actId)

		if slot0.storyItemList[slot7]:isUnlock() then
			slot0.latestStoryItem = slot7
		end
	end

	slot0:_focusStoryItem(slot0.latestStoryItem)

	slot0.fightItemList = {}

	for slot8 = 1, #RoleActivityConfig.instance:getBattleLevelList(slot0.actId) / 2 do
		slot0.fightItemList[slot8] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], gohelper.findChild(slot0._gofightStages, "stage" .. slot8)), LucyFightItem, slot0)

		slot0.fightItemList[slot8]:setParam(slot4[2 * slot8 - 1], slot8, slot0.actId)

		if slot0.fightItemList[slot8]:isUnlock() then
			slot0.latestfightItem = slot8
		end
	end

	slot0.fightItemList[slot0.latestfightItem]:refreshSelect()
end

function slot0._playFirstUnlock(slot0)
	slot0.finishStoryIndex = 0

	slot0.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(slot0._unlockStoryEnd, slot0, 1.33)
end

function slot0._playStoryFinishAnim(slot0)
	if RoleActivityModel.instance:getNewFinishStoryLvl() then
		for slot5, slot6 in ipairs(slot0.storyItemList) do
			if slot6.id == slot1 then
				slot0:_lockScreen(true)

				slot0.finishStoryIndex = slot5

				slot6:playFinish()
				slot6:playStarAnim()
				TaskDispatcher.runDelay(slot0._finishStoryEnd, slot0, 1)

				break
			end
		end

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
	TaskDispatcher.runDelay(slot0._unlockStoryEnd, slot0, 1.33)
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
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot4, 0.26, slot0._onFocusEnd, slot0, slot1)
	else
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot4, 0.26)
	end
end

function slot0._onFocusEnd(slot0, slot1)
	slot0.storyItemList[slot1]:playStory()
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LucyLock")
	else
		UIBlockMgr.instance:endBlock("LucyLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return slot0
