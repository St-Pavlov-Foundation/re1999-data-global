module("modules.logic.versionactivity3_0.karong.view.KaRongLevelView", package.seeall)

local var_0_0 = class("KaRongLevelView", BaseView)
local var_0_1 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gostoryStages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._gofightPath = gohelper.findChild(arg_1_0.viewGO, "#go_fightPath")
	arg_1_0._gofightScroll = gohelper.findChild(arg_1_0.viewGO, "#go_fightPath/#go_fightScroll")
	arg_1_0._gofightStages = gohelper.findChild(arg_1_0.viewGO, "#go_fightPath/#go_fightScroll/#go_fightStages")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTask:RemoveClickListener()
end

function var_0_0._btnTaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.KaRongTaskView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._anim = arg_5_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_5_0.lineAnimList = {}

	for iter_5_0 = 1, 7 do
		local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "#go_storyPath/#go_storyScroll/path/path2/Line" .. iter_5_0)

		arg_5_0.lineAnimList[iter_5_0] = var_5_0:GetComponent(gohelper.Type_Animator)
	end

	arg_5_0._animTask = gohelper.findChild(arg_5_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_5_0._scrollStory = gohelper.findChildScrollRect(arg_5_0._gostoryPath, "")
	arg_5_0.actId = VersionActivity3_0Enum.ActivityId.KaRong
	arg_5_0.actConfig = ActivityConfig.instance:getActivityCo(arg_5_0.actId)

	RoleActivityModel.instance:initData(arg_5_0.actId)

	arg_5_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_5_0._gostoryPath, DungeonMapEpisodeAudio, arg_5_0._scrollStory)
	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._gostoryPath)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEnd, arg_5_0)

	arg_5_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_5_0._gostoryPath)

	arg_5_0._touch:AddClickDownListener(arg_5_0._onClickDown, arg_5_0)

	local var_5_1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_5_0._offsetX = (var_5_1 - -300) / 2
	arg_5_0.minContentAnchorX = -4560 + var_5_1

	arg_5_0:_initStageItems()
	gohelper.setActive(arg_5_0._btnPlayBtn, arg_5_0.actConfig.storyId > 0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, arg_6_0.OnStoryItemClick, arg_6_0)
	arg_6_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_6_0.OnStoryFinish, arg_6_0)
	arg_6_0:addEventCb(StoryController.instance, StoryEvent.Start, arg_6_0.OnStoryStart, arg_6_0)
	arg_6_0:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, arg_6_0.OnEndDungeonPush, arg_6_0)
	arg_6_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_6_0.OnDotChange, arg_6_0)

	local var_6_0 = gohelper.findChild(arg_6_0._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_6_0, RedDotEnum.DotNode.V1a6RoleActivityTask, arg_6_0.actId)
	arg_6_0:OnDotChange()
	arg_6_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_6_0._showLeftTime, arg_6_0, 1)

	if arg_6_0:_checkFirstEnter() then
		arg_6_0:_lockScreen(true)
		arg_6_0.storyItemList[1]:lockStatus()
		TaskDispatcher.runDelay(arg_6_0._playFirstUnlock, arg_6_0, 0.8)
	end

	arg_6_0:_initPathStatus()
end

function var_0_0._checkFirstEnter(arg_7_0)
	if not arg_7_0.storyItemList[2]:isUnlock() and PlayerPrefsHelper.getNumber("ActKaRongFirstEnter", 0) == 0 then
		PlayerPrefsHelper.setNumber("ActKaRongFirstEnter", 1)

		return true
	end

	return false
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showLeftTime, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playFirstUnlock, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayOpenStory, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._unlockStoryEnd, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._finishStoryEnd, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playPathAnim, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._unlockStory, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playStoryFinishAnim, arg_8_0)
	arg_8_0:_lockScreen(false)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0.storyItemList = nil

	if arg_9_0._drag then
		arg_9_0._drag:RemoveDragBeginListener()
		arg_9_0._drag:RemoveDragEndListener()

		arg_9_0._drag = nil
	end

	if arg_9_0._touch then
		arg_9_0._touch:RemoveClickDownListener()

		arg_9_0._touch = nil
	end

	if arg_9_0._scrollStory then
		arg_9_0._scrollStory:RemoveOnValueChanged()
	end
end

function var_0_0.OnStoryItemClick(arg_10_0, arg_10_1)
	arg_10_0:_focusStoryItem(arg_10_1, true)
end

function var_0_0.OnStoryStart(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getLatestStoryCo()

	if not var_11_0 or var_11_0.afterStory ~= arg_11_1 then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(var_11_0.id) then
		return
	end

	arg_11_0._newFinishStoryLvlId = var_11_0.id
end

function var_0_0.OnStoryFinish(arg_12_0)
	RoleActivityModel.instance:updateData(arg_12_0.actId)
	TaskDispatcher.runDelay(arg_12_0._playStoryFinishAnim, arg_12_0, 0.73)
	TaskDispatcher.runDelay(arg_12_0._delayOpenStory, arg_12_0, 0.4)
end

function var_0_0.OnEndDungeonPush(arg_13_0)
	RoleActivityModel.instance:updateData(arg_13_0.actId)

	local var_13_0 = arg_13_0:getLatestStoryCo()
	local var_13_1 = var_13_0 and var_13_0.id
	local var_13_2 = Activity176Config.instance:hasElementCo(arg_13_0.actId, var_13_1)

	if var_13_0 and var_13_0.afterStory ~= 0 then
		return
	end

	local var_13_3 = 0.73 + (var_13_2 and 1.5 or 0)

	TaskDispatcher.runDelay(arg_13_0._playStoryFinishAnim, arg_13_0, var_13_3)
end

function var_0_0.getLatestStoryCo(arg_14_0)
	local var_14_0 = RoleActivityConfig.instance:getStoryLevelList(arg_14_0.actId)

	return var_14_0 and var_14_0[arg_14_0.latestStoryItem]
end

function var_0_0.OnDotChange(arg_15_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V1a6RoleActivityTask, arg_15_0.actId) then
		arg_15_0._animTask:Play("loop")
	else
		arg_15_0._animTask:Play("idle")
	end
end

function var_0_0._onStoryOpenEnd(arg_16_0)
	arg_16_0:_initPathStatus()
end

function var_0_0._onGoStoryEnd(arg_17_0)
	arg_17_0:_initPathStatus()
end

function var_0_0._onDragBegin(arg_18_0)
	arg_18_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_19_0)
	arg_19_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDown(arg_20_0)
	arg_20_0._audioScroll:onClickDown()
end

function var_0_0._initStageItems(arg_21_0)
	local var_21_0
	local var_21_1
	local var_21_2 = arg_21_0.viewContainer:getSetting().otherRes[1]

	arg_21_0.storyItemList = {}

	local var_21_3 = RoleActivityConfig.instance:getStoryLevelList(arg_21_0.actId)
	local var_21_4 = #var_21_3

	for iter_21_0 = 1, var_21_4 do
		local var_21_5 = gohelper.findChild(arg_21_0._gostoryStages, "stage" .. iter_21_0)
		local var_21_6 = arg_21_0:getResInst(var_21_2, var_21_5)
		local var_21_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_6, KaRongStoryItem, arg_21_0)

		arg_21_0.storyItemList[iter_21_0] = var_21_7

		arg_21_0.storyItemList[iter_21_0]:setParam(var_21_3[iter_21_0], iter_21_0, arg_21_0.actId)

		if arg_21_0.storyItemList[iter_21_0]:isUnlock() then
			arg_21_0.latestStoryItem = iter_21_0
		end
	end

	arg_21_0:_focusStoryItem(arg_21_0.latestStoryItem)
end

function var_0_0._playFirstUnlock(arg_22_0)
	arg_22_0.finishStoryIndex = 0

	arg_22_0.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(arg_22_0._unlockStoryEnd, arg_22_0, 1.33)
end

function var_0_0._playStoryFinishAnim(arg_23_0)
	local var_23_0 = RoleActivityModel.instance:getNewFinishStoryLvl() or arg_23_0._newFinishStoryLvlId

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.storyItemList) do
			if iter_23_1.id == var_23_0 then
				arg_23_0:_lockScreen(true)

				arg_23_0.finishStoryIndex = iter_23_0

				iter_23_1:playFinish()
				iter_23_1:playStarAnim()
				TaskDispatcher.runDelay(arg_23_0._finishStoryEnd, arg_23_0, 1)

				break
			end
		end

		arg_23_0._newFinishStoryLvlId = nil

		RoleActivityModel.instance:clearNewFinishStoryLvl()
	end
end

function var_0_0._finishStoryEnd(arg_24_0)
	if arg_24_0.finishStoryIndex == #arg_24_0.storyItemList then
		arg_24_0.latestStoryItem = arg_24_0.finishStoryIndex
		arg_24_0.finishStoryIndex = nil

		arg_24_0:_lockScreen(false)
	else
		arg_24_0.latestStoryItem = arg_24_0.finishStoryIndex + 1

		arg_24_0:_playPathAnim()
	end
end

function var_0_0._playPathAnim(arg_25_0)
	arg_25_0.lineAnimList[arg_25_0.finishStoryIndex]:Play("open", 0, 0)
	TaskDispatcher.runDelay(arg_25_0._unlockStory, arg_25_0, 0.33)
end

function var_0_0._unlockStory(arg_26_0)
	arg_26_0.storyItemList[arg_26_0.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_26_0._unlockStoryEnd, arg_26_0, 1)
end

function var_0_0._unlockStoryEnd(arg_27_0)
	arg_27_0.storyItemList[arg_27_0.finishStoryIndex + 1]:refreshStatus()

	arg_27_0.finishStoryIndex = nil

	arg_27_0:_lockScreen(false)
end

function var_0_0._delayOpenStory(arg_28_0)
	arg_28_0._anim:Play("openstory", 0, 0)
end

function var_0_0._showLeftTime(arg_29_0)
	arg_29_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_29_0.actId)
end

function var_0_0._initPathStatus(arg_30_0)
	for iter_30_0 = 1, 7 do
		if iter_30_0 <= arg_30_0.latestStoryItem - 1 then
			arg_30_0.lineAnimList[iter_30_0]:Play("open", 0, 1)
		end
	end
end

function var_0_0._focusStoryItem(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = recthelper.getAnchorX(arg_31_0.storyItemList[arg_31_1].transform.parent)
	local var_31_1 = arg_31_0._offsetX - var_31_0

	if var_31_1 > 0 then
		var_31_1 = 0
	elseif var_31_1 < arg_31_0.minContentAnchorX then
		var_31_1 = arg_31_0.minContentAnchorX
	end

	if arg_31_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_31_0._gostoryScroll.transform, var_31_1, var_0_1, arg_31_0._onFocusEnd, arg_31_0, arg_31_1)
	else
		recthelper.setAnchorX(arg_31_0._gostoryScroll.transform, var_31_1)
	end

	arg_31_0:_setFocusFlag(arg_31_1)
end

function var_0_0._onFocusEnd(arg_32_0, arg_32_1)
	arg_32_0.storyItemList[arg_32_1]:playStory()
end

function var_0_0._setFocusFlag(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.storyItemList[arg_33_0._focusStoryIndex]
	local var_33_1 = arg_33_0.storyItemList[arg_33_1]

	if var_33_0 then
		var_33_0:setFocusFlag(false)
	end

	if var_33_1 then
		var_33_1:setFocusFlag(true)
	end

	arg_33_0._focusStoryIndex = arg_33_1

	arg_33_0:_lockScreen(false)
end

function var_0_0._lockScreen(arg_34_0, arg_34_1)
	if arg_34_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("KaRongLock")
	else
		UIBlockMgr.instance:endBlock("KaRongLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return var_0_0
