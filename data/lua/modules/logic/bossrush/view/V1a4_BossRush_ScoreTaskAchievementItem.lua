module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievementItem", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScoreTaskAchievementItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageAssessIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#image_AssessIcon")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_Rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Rewards/Viewport/#go_rewards")
	arg_1_0._btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_NotFinish")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Finished", AudioEnum.ui_task.play_ui_task_slide)
	arg_1_0._goAllFinished = gohelper.findChild(arg_1_0.viewGO, "Root/#go_AllFinished")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNotFinish:RemoveClickListener()
	arg_3_0._btnFinished:RemoveClickListener()
end

local var_0_1 = BossRushEnum.AnimEvtAchievementItem

function var_0_0._btnNotFinishOnClick(arg_4_0)
	return
end

function var_0_0._btnFinishedOnClick(arg_5_0)
	arg_5_0:_playFinish()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goRootGo = gohelper.findChild(arg_6_0.viewGO, "Root")
	arg_6_0._anim = arg_6_0._goRootGo:GetComponent(gohelper.Type_Animator)
	arg_6_0._animEvent = arg_6_0._goRootGo:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_6_0._imageAssessIconGo = arg_6_0._imageAssessIcon.gameObject
	arg_6_0._btnNotFinishGo = arg_6_0._btnNotFinish.gameObject
	arg_6_0._btnFinishedGo = arg_6_0._btnFinished.gameObject
	arg_6_0._scrollrewardLimitScollRect = arg_6_0._scrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_6_0._txtDescr.text = ""
end

function var_0_0._editableAddEvents(arg_7_0)
	arg_7_0._animEvent:AddEventListener(var_0_1.onEndBlock, arg_7_0._onEndBlock, arg_7_0)
	arg_7_0._animEvent:AddEventListener(var_0_1.onFinishEnd, arg_7_0._onFinishEnd, arg_7_0)
end

function var_0_0._editableRemoveEvents(arg_8_0)
	arg_8_0._animEvent:RemoveEventListener(var_0_1.onEndBlock)
	arg_8_0._animEvent:RemoveEventListener(var_0_1.onFinishEnd)
	TaskDispatcher.cancelTask(arg_8_0._playOpenInner, arg_8_0)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0:_initScollParentGameObject()

	arg_9_0._mo = arg_9_1

	arg_9_0:_setActiveBlock(true, true)
	arg_9_0:_playOpen()
	arg_9_0:_refresh()
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playOpenInner, arg_10_0)
	arg_10_0._imageAssessIcon:UnLoadImage()
end

function var_0_0._refresh(arg_11_0)
	local var_11_0 = arg_11_0._mo
	local var_11_1 = var_11_0.config
	local var_11_2 = var_11_1.stage
	local var_11_3 = var_11_1.bonus
	local var_11_4 = var_11_1.achievementRes
	local var_11_5 = var_11_1.maxProgress
	local var_11_6 = var_11_0.finishCount >= var_11_1.maxFinishCount
	local var_11_7 = not var_11_6 and var_11_0.hasFinished
	local var_11_8 = not var_11_6 and not var_11_7
	local var_11_9 = var_11_4 == ""
	local var_11_10 = ItemModel.instance:getItemDataListByConfigStr(var_11_3)

	if not var_11_9 then
		arg_11_0._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(var_11_4))
	end

	gohelper.setActive(arg_11_0._imageAssessIconGo, not var_11_9)
	gohelper.setActive(arg_11_0._btnNotFinishGo, var_11_8)
	gohelper.setActive(arg_11_0._btnFinishedGo, var_11_7)
	gohelper.setActive(arg_11_0._goAllFinished, var_11_6)
	IconMgr.instance:getCommonPropItemIconList(arg_11_0, arg_11_0._onRewardItemShow, var_11_10, arg_11_0._gorewards)

	arg_11_0._txtDescr.text = BossRushConfig.instance:getScoreStr(var_11_5)
end

function var_0_0._onRewardItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:onUpdateMO(arg_12_2)
	arg_12_1:setConsume(true)
	arg_12_1:showStackableNum2()
	arg_12_1:isShowEffect(true)
	arg_12_1:setCountFontSize(48)
end

function var_0_0._playOpenInner(arg_13_0)
	arg_13_0:_setActive(true)
	arg_13_0:_playAnim(UIAnimationName.Open)
end

function var_0_0._playOpen(arg_14_0)
	if V1a4_BossRush_ScoreTaskAchievementListModel.instance:getStaticData() then
		arg_14_0:_playIdle()

		return
	end

	arg_14_0:_setActive(false)
	TaskDispatcher.runDelay(arg_14_0._playOpenInner, arg_14_0, arg_14_0._index * 0.06)
end

function var_0_0._playFinish(arg_15_0)
	arg_15_0:_setActiveBlock(true)
	arg_15_0:_playAnim(UIAnimationName.Finish)
end

function var_0_0._playIdle(arg_16_0)
	arg_16_0:_playAnim(UIAnimationName.Idle, 0, 1)
end

function var_0_0._playAnim(arg_17_0, arg_17_1, ...)
	arg_17_0._anim:Play(arg_17_1, ...)
end

function var_0_0._setActive(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0.viewGO, arg_18_1)
end

function var_0_0._onEndBlock(arg_19_0)
	arg_19_0:_setActiveBlock(false, true)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setStaticData(true)
end

function var_0_0._setActiveBlock(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = ViewMgr.instance:getContainer(ViewName.V1a4_BossRush_ScoreTaskAchievement)

	if not var_20_0 then
		return
	end

	var_20_0:setActiveBlock(arg_20_1, arg_20_2)
end

function var_0_0._onFinishEnd(arg_21_0)
	arg_21_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_21_0._index, arg_21_0._onFinishTweenEnd, arg_21_0)
end

function var_0_0._onFinishTweenEnd(arg_22_0)
	arg_22_0:_playIdle()
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:claimRewardByIndex(arg_22_0._index)
	arg_22_0:_setActiveBlock(false)
end

function var_0_0._initScollParentGameObject(arg_23_0)
	if not arg_23_0._isSetParent then
		arg_23_0._scrollrewardLimitScollRect.parentGameObject = arg_23_0._view:getCsListScroll().gameObject
		arg_23_0._isSetParent = true
	end
end

return var_0_0
