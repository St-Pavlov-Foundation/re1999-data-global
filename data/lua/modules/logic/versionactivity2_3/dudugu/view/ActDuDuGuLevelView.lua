module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelView", package.seeall)

slot0 = class("ActDuDuGuLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._golvpath = gohelper.findChild(slot0.viewGO, "#go_lvpath")
	slot0._golvScroll = gohelper.findChild(slot0.viewGO, "#go_lvpath/#go_lvScroll")
	slot0._golvstages = gohelper.findChild(slot0.viewGO, "#go_lvpath/#go_lvScroll/#go_lvstages")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnPlayBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Title/#btn_PlayBtn")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._goPath = gohelper.findChild(slot0._golvScroll, "path/path_2")
	slot0._animPath = slot0._goPath:GetComponent(gohelper.Type_Animator)
	slot0._animTask = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	slot0._scrolllv = gohelper.findChildScrollRect(slot0._golvpath, "")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlayBtn:AddClickListener(slot0._btnPlayBtnOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._animEvent:AddEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd, slot0._onStoryOpenEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlayBtn:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
	slot0._animEvent:RemoveEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd)
end

function slot0._btnPlayBtnOnClick(slot0)
	if slot0.actConfig.storyId > 0 then
		StoryController.instance:playStory(slot0.actConfig.storyId)
	end
end

function slot0._btnTaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ActDuDuGuTaskView)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, slot0.OnLvItemClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0.OnStoryFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, slot0.OnEndDungeonPush, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0.OnDotChange, slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity2_3Enum.ActivityId.DuDuGu
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._golvpath)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._golvpath)

	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._golvpath, DungeonMapEpisodeAudio, slot0._scrolllv)
	slot0.actConfig = ActivityConfig.instance:getActivityCo(slot0.actId)

	ActDuDuGuModel.instance:initData(slot0.actId)
	slot0:_initStageItems()
	gohelper.setActive(slot0._btnPlayBtn, slot0.actConfig.storyId > 0)
	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0._btnTask.gameObject, "#go_reddot"), RedDotEnum.DotNode.V1a6RoleActivityTask, slot0.actId)
	slot0:_initPathStatus()
	slot0:OnDotChange()
	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)

	if slot0:_checkFirstEnter() then
		slot0:_lockScreen(true)
		slot0._lvItems[1]:lockStatus()
		TaskDispatcher.runDelay(slot0._playFirstUnlock, slot0, 0.8)
	end
end

function slot0._playStoryFinishAnim(slot0)
	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
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

		ActDuDuGuModel.instance:clearNewFinishStoryLvl()
	end
end

function slot0._checkFirstEnter(slot0)
	if not slot0._lvItems[2]:isUnlock() and PlayerPrefsHelper.getNumber("ActDuDuGuFirstEnter", 0) == 0 then
		PlayerPrefsHelper.setNumber("ActDuDuGuFirstEnter", 1)

		return true
	end

	return false
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0._playFirstUnlock, slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenStory, slot0)
	TaskDispatcher.cancelTask(slot0._unlockLvEnd, slot0)
	TaskDispatcher.cancelTask(slot0._finishStoryEnd, slot0)
	TaskDispatcher.cancelTask(slot0._playPathAnim, slot0)
	TaskDispatcher.cancelTask(slot0._unlockStory, slot0)
	TaskDispatcher.cancelTask(slot0._playStoryFinishAnim, slot0)
	slot0:_lockScreen(false)
end

function slot0.onDestroyView(slot0)
	slot0._lvItems = nil

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

function slot0.OnLvItemClick(slot0, slot1)
	slot0:_focusLvItem(slot1, true)
end

function slot0.OnStoryFinish(slot0)
	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
		slot0._curLvIndex = slot0._lvItems[slot0._curLvIndex + 1] and slot0._curLvIndex + 1 or slot0._curLvIndex

		slot0:_focusLvItem(slot0._curLvIndex, false)
	end

	TaskDispatcher.runDelay(slot0._delayOpenStory, slot0, 0.4)
end

function slot0.OnEndDungeonPush(slot0)
	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
		slot0._curLvIndex = slot0._lvItems[slot0._curLvIndex + 1] and slot0._curLvIndex + 1 or slot0._curLvIndex

		slot0:_focusLvItem(slot0._curLvIndex, false)
	end

	ActDuDuGuModel.instance:updateData(slot0.actId)
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

	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
		slot0:_playStoryFinishAnim()
		ActDuDuGuModel.instance:updateData(slot0.actId)
	end
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
	slot0._lvItems = {}

	for slot7 = 1, #RoleActivityConfig.instance:getStoryLevelList(slot0.actId) do
		slot0._lvItems[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._golvstages, "stage" .. slot7)), ActDuDuGuLevelItem, slot0)

		slot0._lvItems[slot7]:setParam(slot3[slot7], slot7, slot0.actId)

		if slot0._lvItems[slot7]:isUnlock() then
			slot0._curLvIndex = slot7
		end
	end

	slot0._curLvIndex = ActDuDuGuModel.instance:getCurLvIndex() > 0 and slot4 or slot0._curLvIndex

	slot0:_focusLvItem(slot0._curLvIndex)
end

function slot0._playFirstUnlock(slot0)
	slot0.finishStoryIndex = 0

	slot0._lvItems[1]:playUnlock()
	TaskDispatcher.runDelay(slot0._unlockLvEnd, slot0, 2)
end

function slot0._unlockLvEnd(slot0)
	slot0._lvItems[slot0.finishStoryIndex + 1]:refreshStatus()

	slot0.finishStoryIndex = nil

	slot0:_lockScreen(false)
end

function slot0._finishStoryEnd(slot0)
	if slot0.finishStoryIndex == #slot0._lvItems then
		slot0._curLvIndex = slot0.finishStoryIndex
		slot0.finishStoryIndex = nil

		slot0:_lockScreen(false)
	else
		slot0._curLvIndex = slot0.finishStoryIndex + 1

		slot0:_playPathAnim()
	end
end

function slot0._playPathAnim(slot0)
	slot0._animPath.speed = 1

	slot0._animPath:Play("go" .. slot0.finishStoryIndex)
	TaskDispatcher.runDelay(slot0._unlockStory, slot0, 0.33)
end

function slot0._unlockStory(slot0)
	slot0._lvItems[slot0.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(slot0._unlockLvEnd, slot0, 2)
end

function slot0._delayOpenStory(slot0)
	slot0._anim:Play("openstory", 0, 0)
end

function slot0._showLeftTime(slot0)
	slot0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0._initPathStatus(slot0)
	if slot0._curLvIndex > 1 then
		slot0._animPath:Play("go" .. slot0._curLvIndex - 1, 0, 1)
	else
		slot0._animPath.speed = 0

		slot0._animPath:Play("go1", 0, 0)
	end
end

function slot0._focusLvItem(slot0, slot1, slot2)
	if slot2 then
		ZProj.TweenHelper.DOLocalMoveY(slot0._golvScroll.transform, slot1 < 3 and 540 or 540 + (slot1 - 3) * 920 / 5, 0.26, slot0._onFocusEnd, slot0, slot1)
	else
		ZProj.TweenHelper.DOLocalMoveY(slot0._golvScroll.transform, slot3, 0.26)
	end

	ActDuDuGuModel.instance:setCurLvIndex(slot1)
end

function slot0._onFocusEnd(slot0, slot1)
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DuDuGuLock")
	else
		UIBlockMgr.instance:endBlock("DuDuGuLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return slot0
