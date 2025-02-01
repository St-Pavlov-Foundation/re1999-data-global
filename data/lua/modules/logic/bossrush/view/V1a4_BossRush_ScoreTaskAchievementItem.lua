module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievementItem", package.seeall)

slot0 = class("V1a4_BossRush_ScoreTaskAchievementItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageAssessIcon = gohelper.findChildSingleImage(slot0.viewGO, "Root/#image_AssessIcon")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/#txt_Descr")
	slot0._scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_Rewards")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Root/#scroll_Rewards/Viewport/#go_rewards")
	slot0._btnNotFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_NotFinish")
	slot0._btnFinished = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Finished", AudioEnum.ui_task.play_ui_task_slide)
	slot0._goAllFinished = gohelper.findChild(slot0.viewGO, "Root/#go_AllFinished")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnNotFinish:AddClickListener(slot0._btnNotFinishOnClick, slot0)
	slot0._btnFinished:AddClickListener(slot0._btnFinishedOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnNotFinish:RemoveClickListener()
	slot0._btnFinished:RemoveClickListener()
end

slot1 = BossRushEnum.AnimEvtAchievementItem

function slot0._btnNotFinishOnClick(slot0)
end

function slot0._btnFinishedOnClick(slot0)
	slot0:_playFinish()
end

function slot0._editableInitView(slot0)
	slot0._goRootGo = gohelper.findChild(slot0.viewGO, "Root")
	slot0._anim = slot0._goRootGo:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0._goRootGo:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._imageAssessIconGo = slot0._imageAssessIcon.gameObject
	slot0._btnNotFinishGo = slot0._btnNotFinish.gameObject
	slot0._btnFinishedGo = slot0._btnFinished.gameObject
	slot0._scrollrewardLimitScollRect = slot0._scrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
	slot0._txtDescr.text = ""
end

function slot0._editableAddEvents(slot0)
	slot0._animEvent:AddEventListener(uv0.onEndBlock, slot0._onEndBlock, slot0)
	slot0._animEvent:AddEventListener(uv0.onFinishEnd, slot0._onFinishEnd, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._animEvent:RemoveEventListener(uv0.onEndBlock)
	slot0._animEvent:RemoveEventListener(uv0.onFinishEnd)
	TaskDispatcher.cancelTask(slot0._playOpenInner, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:_initScollParentGameObject()

	slot0._mo = slot1

	slot0:_setActiveBlock(true, true)
	slot0:_playOpen()
	slot0:_refresh()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playOpenInner, slot0)
	slot0._imageAssessIcon:UnLoadImage()
end

function slot0._refresh(slot0)
	slot1 = slot0._mo
	slot2 = slot1.config
	slot3 = slot2.stage
	slot6 = slot2.maxProgress
	slot7 = slot2.maxFinishCount <= slot1.finishCount
	slot9 = not slot7 and not (not slot7 and slot1.hasFinished)
	slot11 = ItemModel.instance:getItemDataListByConfigStr(slot2.bonus)

	if not (slot2.achievementRes == "") then
		slot0._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(slot5))
	end

	gohelper.setActive(slot0._imageAssessIconGo, not slot10)
	gohelper.setActive(slot0._btnNotFinishGo, slot9)
	gohelper.setActive(slot0._btnFinishedGo, slot8)
	gohelper.setActive(slot0._goAllFinished, slot7)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onRewardItemShow, slot11, slot0._gorewards)

	slot0._txtDescr.text = BossRushConfig.instance:getScoreStr(slot6)
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setCountFontSize(48)
end

function slot0._playOpenInner(slot0)
	slot0:_setActive(true)
	slot0:_playAnim(UIAnimationName.Open)
end

function slot0._playOpen(slot0)
	if V1a4_BossRush_ScoreTaskAchievementListModel.instance:getStaticData() then
		slot0:_playIdle()

		return
	end

	slot0:_setActive(false)
	TaskDispatcher.runDelay(slot0._playOpenInner, slot0, slot0._index * 0.06)
end

function slot0._playFinish(slot0)
	slot0:_setActiveBlock(true)
	slot0:_playAnim(UIAnimationName.Finish)
end

function slot0._playIdle(slot0)
	slot0:_playAnim(UIAnimationName.Idle, 0, 1)
end

function slot0._playAnim(slot0, slot1, ...)
	slot0._anim:Play(slot1, ...)
end

function slot0._setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0._onEndBlock(slot0)
	slot0:_setActiveBlock(false, true)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setStaticData(true)
end

function slot0._setActiveBlock(slot0, slot1, slot2)
	if not ViewMgr.instance:getContainer(ViewName.V1a4_BossRush_ScoreTaskAchievement) then
		return
	end

	slot3:setActiveBlock(slot1, slot2)
end

function slot0._onFinishEnd(slot0)
	slot0._view.viewContainer.taskAnimRemoveItem:removeByIndex(slot0._index, slot0._onFinishTweenEnd, slot0)
end

function slot0._onFinishTweenEnd(slot0)
	slot0:_playIdle()
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:claimRewardByIndex(slot0._index)
	slot0:_setActiveBlock(false)
end

function slot0._initScollParentGameObject(slot0)
	if not slot0._isSetParent then
		slot0._scrollrewardLimitScollRect.parentGameObject = slot0._view:getCsListScroll().gameObject
		slot0._isSetParent = true
	end
end

return slot0
