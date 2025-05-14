module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErLevelView", package.seeall)

local var_0_0 = class("ZhiXinQuanErLevelView", BaseView)
local var_0_1 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "bgs/#simage_FullBG")
	arg_1_0._simageFullBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bgs/#simage_FullBG/#simage_FullBG2")
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
	arg_1_0._btnPlayBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Title/#btn_PlayBtn")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._animPath = gohelper.findChild(arg_1_0._gostoryScroll, "path/path_2"):GetComponent(gohelper.Type_Animator)
	arg_1_0._animTask = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0._scrollStory = gohelper.findChildScrollRect(arg_1_0._gostoryPath, "")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayBtn:AddClickListener(arg_2_0._btnPlayBtnOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlayBtn:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
end

function var_0_0._btnPlayBtnOnClick(arg_4_0)
	if arg_4_0.actConfig.storyId > 0 then
		StoryController.instance:playStory(arg_4_0.actConfig.storyId)
	end
end

function var_0_0._btnTaskOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.ZhiXinQuanErTaskView)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gostoryPath)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	arg_6_0._scrollStory:AddOnValueChanged(arg_6_0._onScrollValueChanged, arg_6_0)

	arg_6_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_6_0._gostoryPath)

	arg_6_0._touch:AddClickDownListener(arg_6_0._onClickDown, arg_6_0)

	arg_6_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_6_0._gostoryPath, DungeonMapEpisodeAudio, arg_6_0._scrollStory)
	arg_6_0.actConfig = ActivityConfig.instance:getActivityCo(arg_6_0.actId)

	local var_6_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_6_0._offsetX = (var_6_0 - -300) / 2
	arg_6_0.minContentAnchorX = -4560 + var_6_0

	RoleActivityModel.instance:initData(arg_6_0.actId)
	arg_6_0:_initStageItems()
	gohelper.setActive(arg_6_0._btnPlayBtn, arg_6_0.actConfig.storyId > 0)

	arg_6_0._bgWidth = recthelper.getWidth(arg_6_0._simageFullBG.transform) + recthelper.getWidth(arg_6_0._simageFullBG2.transform)
	arg_6_0._minBgPositionX = BootNativeUtil.getDisplayResolution() - arg_6_0._bgWidth
	arg_6_0._maxBgPositionX = 0
	arg_6_0._bgPositonMaxOffsetX = math.abs(arg_6_0._maxBgPositionX - arg_6_0._minBgPositionX)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, arg_7_0.OnStoryItemClick, arg_7_0)
	arg_7_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.FightItemClick, arg_7_0.OnFightItemClick, arg_7_0)
	arg_7_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_7_0.OnStoryFinish, arg_7_0)
	arg_7_0:addEventCb(StoryController.instance, StoryEvent.Start, arg_7_0.OnStoryStart, arg_7_0)
	arg_7_0:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, arg_7_0.OnEndDungeonPush, arg_7_0)
	arg_7_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_7_0.OnDotChange, arg_7_0)

	local var_7_0 = gohelper.findChild(arg_7_0._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_7_0, RedDotEnum.DotNode.V1a6RoleActivityTask, arg_7_0.actId)
	arg_7_0:OnDotChange()
	arg_7_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_7_0._showLeftTime, arg_7_0, 1)

	if arg_7_0.viewParam and arg_7_0.viewParam.needShowFight then
		local var_7_1 = RoleActivityModel.instance:getEnterFightIndex(arg_7_0.actId)

		if var_7_1 then
			arg_7_0.latestfightItem = var_7_1

			for iter_7_0, iter_7_1 in ipairs(arg_7_0.fightItemList) do
				iter_7_1:refreshSelect(var_7_1)
			end
		end

		arg_7_0:_lockScreen(true)
		TaskDispatcher.runDelay(arg_7_0._delayOpenFight, arg_7_0, 0.3)
	elseif arg_7_0:_checkFirstEnter() then
		arg_7_0:_lockScreen(true)
		arg_7_0.storyItemList[1]:lockStatus()
		TaskDispatcher.runDelay(arg_7_0._playFirstUnlock, arg_7_0, 0.8)
	end

	arg_7_0:_initBgPosition()
	arg_7_0:_initPathStatus()
end

function var_0_0._checkFirstEnter(arg_8_0)
	if not arg_8_0.storyItemList[2]:isUnlock() and PlayerPrefsHelper.getNumber("ActZhiXinQuanErFirstEnter", 0) == 0 then
		PlayerPrefsHelper.setNumber("ActZhiXinQuanErFirstEnter", 1)

		return true
	end

	return false
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._showLeftTime, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayOpenFight, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._playFirstUnlock, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayOpenStory, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._unlockStoryEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._finishStoryEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._playPathAnim, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._unlockFightEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._unlockStory, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._starShowEnd, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._playStoryFinishAnim, arg_9_0)
	arg_9_0:_lockScreen(false)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.storyItemList = nil
	arg_10_0.fightItemList = nil

	if arg_10_0._drag then
		arg_10_0._drag:RemoveDragBeginListener()
		arg_10_0._drag:RemoveDragEndListener()

		arg_10_0._drag = nil
	end

	if arg_10_0._touch then
		arg_10_0._touch:RemoveClickDownListener()

		arg_10_0._touch = nil
	end

	if arg_10_0._scrollStory then
		arg_10_0._scrollStory:RemoveOnValueChanged()
	end
end

function var_0_0.OnStoryItemClick(arg_11_0, arg_11_1)
	arg_11_0:_focusStoryItem(arg_11_1, true)
end

function var_0_0.OnFightItemClick(arg_12_0, arg_12_1)
	if arg_12_0.latestfightItem == arg_12_1 then
		return
	end

	arg_12_0.latestfightItem = arg_12_1

	AudioMgr.instance:trigger(AudioEnum.RoleActivity.fight_switch)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.fightItemList) do
		iter_12_1:refreshSelect(arg_12_1)
	end
end

function var_0_0.OnStoryStart(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getLatestStoryCo()

	if not var_13_0 or var_13_0.afterStory ~= arg_13_1 then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(var_13_0.id) then
		return
	end

	arg_13_0._newFinishStoryLvlId = var_13_0.id
end

function var_0_0.OnStoryFinish(arg_14_0)
	RoleActivityModel.instance:updateData(arg_14_0.actId)
	TaskDispatcher.runDelay(arg_14_0._playStoryFinishAnim, arg_14_0, 0.73)
end

function var_0_0.OnEndDungeonPush(arg_15_0)
	RoleActivityModel.instance:updateData(arg_15_0.actId)

	local var_15_0 = arg_15_0:getLatestStoryCo()
	local var_15_1 = var_15_0 and var_15_0.id
	local var_15_2 = Activity176Config.instance:hasElementCo(arg_15_0.actId, var_15_1)

	if var_15_0 and var_15_0.afterStory ~= 0 then
		return
	end

	local var_15_3 = 0.73 + (var_15_2 and 1.5 or 0)

	TaskDispatcher.runDelay(arg_15_0._playStoryFinishAnim, arg_15_0, var_15_3)
end

function var_0_0.getLatestStoryCo(arg_16_0)
	local var_16_0 = RoleActivityConfig.instance:getStoryLevelList(arg_16_0.actId)

	return var_16_0 and var_16_0[arg_16_0.latestStoryItem]
end

function var_0_0.OnDotChange(arg_17_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V1a6RoleActivityTask, arg_17_0.actId) then
		arg_17_0._animTask:Play("loop")
	else
		arg_17_0._animTask:Play("idle")
	end
end

function var_0_0._onStoryOpenEnd(arg_18_0)
	arg_18_0:_initPathStatus()
end

function var_0_0._onFightOpenEnd(arg_19_0)
	arg_19_0:_playFightFinishAnim()
end

function var_0_0._onGoStoryEnd(arg_20_0)
	arg_20_0:_initPathStatus()
end

function var_0_0._onDragBegin(arg_21_0)
	arg_21_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_22_0)
	arg_22_0._audioScroll:onDragEnd()
end

function var_0_0._onScrollValueChanged(arg_23_0)
	arg_23_0:_initBgPosition()
end

function var_0_0._initBgPosition(arg_24_0)
	local var_24_0 = -arg_24_0._scrollStory.horizontalNormalizedPosition * arg_24_0._bgPositonMaxOffsetX
	local var_24_1 = Mathf.Clamp(var_24_0, arg_24_0._minBgPositionX, arg_24_0._maxBgPositionX)

	recthelper.setAnchorX(arg_24_0._simageFullBG.transform, var_24_1)
end

function var_0_0._onClickDown(arg_25_0)
	arg_25_0._audioScroll:onClickDown()
end

function var_0_0._initStageItems(arg_26_0)
	local var_26_0
	local var_26_1
	local var_26_2 = arg_26_0.viewContainer:getSetting().otherRes[1]

	arg_26_0.storyItemList = {}

	local var_26_3 = RoleActivityConfig.instance:getStoryLevelList(arg_26_0.actId)
	local var_26_4 = #var_26_3

	for iter_26_0 = 1, var_26_4 do
		local var_26_5 = gohelper.findChild(arg_26_0._gostoryStages, "stage" .. iter_26_0)
		local var_26_6 = arg_26_0:getResInst(var_26_2, var_26_5)
		local var_26_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_6, ZhiXinQuanErStoryItem, arg_26_0)

		arg_26_0.storyItemList[iter_26_0] = var_26_7

		arg_26_0.storyItemList[iter_26_0]:setParam(var_26_3[iter_26_0], iter_26_0, arg_26_0.actId)

		if arg_26_0.storyItemList[iter_26_0]:isUnlock() then
			arg_26_0.latestStoryItem = iter_26_0
		end
	end

	arg_26_0:_focusStoryItem(arg_26_0.latestStoryItem)

	local var_26_8 = arg_26_0.viewContainer:getSetting().otherRes[2]

	arg_26_0.fightItemList = {}

	local var_26_9 = RoleActivityConfig.instance:getBattleLevelList(arg_26_0.actId)
	local var_26_10 = #var_26_9 / 2

	for iter_26_1 = 1, var_26_10 do
		local var_26_11 = gohelper.findChild(arg_26_0._gofightStages, "stage" .. iter_26_1)
		local var_26_12 = arg_26_0:getResInst(var_26_8, var_26_11)
		local var_26_13 = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_12, RoleActFightItem, arg_26_0)

		arg_26_0.fightItemList[iter_26_1] = var_26_13

		arg_26_0.fightItemList[iter_26_1]:setParam(var_26_9[2 * iter_26_1 - 1], iter_26_1, arg_26_0.actId)

		if arg_26_0.fightItemList[iter_26_1]:isUnlock() then
			arg_26_0.latestfightItem = iter_26_1
		end
	end

	local var_26_14 = arg_26_0.fightItemList[arg_26_0.latestfightItem]

	if var_26_14 then
		var_26_14:refreshSelect()
	end
end

function var_0_0._updateStoryFocusFlag(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.storyItemList[arg_27_0._focusStoryIndex]
	local var_27_1 = arg_27_0.storyItemList[arg_27_1]
	local var_27_2 = var_27_0 ~= nil and var_27_1 ~= nil

	if arg_27_2 and var_27_2 then
		arg_27_0:_lockScreen(true)

		local var_27_3 = var_27_0:getFocusFlagTran()
		local var_27_4 = var_27_1:getFocusFlagTran()
		local var_27_5, var_27_6 = recthelper.rectToRelativeAnchorPos2(var_27_4.position, var_27_0.viewGO.transform)
		local var_27_7 = arg_27_1 < arg_27_0._focusStoryIndex

		var_27_0:setFocusFlagDir(var_27_7)
		ZProj.TweenHelper.DOAnchorPos(var_27_3, var_27_5, var_27_6, var_0_1, arg_27_0._onMoveFocusFlagDone, arg_27_0, arg_27_1)
	else
		arg_27_0:_onMoveFocusFlagDone(arg_27_1)
	end
end

function var_0_0._onMoveFocusFlagDone(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.storyItemList[arg_28_0._focusStoryIndex]
	local var_28_1 = arg_28_0.storyItemList[arg_28_1]

	if var_28_0 then
		var_28_0:setFocusFlag(false)
		var_28_0:setFocusFlagDir(false)
	end

	if var_28_1 then
		local var_28_2 = arg_28_0._focusStoryIndex and arg_28_1 < arg_28_0._focusStoryIndex

		var_28_1:setFocusFlag(true)
		var_28_1:setFocusFlagDir(var_28_2)
	end

	arg_28_0._focusStoryIndex = arg_28_1

	arg_28_0:_lockScreen(false)
end

function var_0_0._playFirstUnlock(arg_29_0)
	arg_29_0.finishStoryIndex = 0

	arg_29_0.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(arg_29_0._unlockStoryEnd, arg_29_0, 1.33)
end

function var_0_0._playStoryFinishAnim(arg_30_0)
	local var_30_0 = RoleActivityModel.instance:getNewFinishStoryLvl() or arg_30_0._newFinishStoryLvlId

	if var_30_0 then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0.storyItemList) do
			if iter_30_1.id == var_30_0 then
				arg_30_0:_lockScreen(true)

				arg_30_0.finishStoryIndex = iter_30_0

				iter_30_1:playFinish()
				iter_30_1:playStarAnim()
				TaskDispatcher.runDelay(arg_30_0._finishStoryEnd, arg_30_0, 1)

				break
			end
		end

		arg_30_0._newFinishStoryLvlId = nil

		RoleActivityModel.instance:clearNewFinishStoryLvl()
	end
end

function var_0_0._finishStoryEnd(arg_31_0)
	if arg_31_0.finishStoryIndex == #arg_31_0.storyItemList then
		arg_31_0.latestStoryItem = arg_31_0.finishStoryIndex
		arg_31_0.finishStoryIndex = nil

		arg_31_0:_lockScreen(false)
	else
		arg_31_0.latestStoryItem = arg_31_0.finishStoryIndex + 1

		arg_31_0:_playPathAnim()
	end
end

function var_0_0._playPathAnim(arg_32_0)
	local var_32_0 = "go" .. arg_32_0.finishStoryIndex

	arg_32_0._animPath.speed = 1

	arg_32_0._animPath:Play(var_32_0)
	TaskDispatcher.runDelay(arg_32_0._unlockStory, arg_32_0, 0.33)
end

function var_0_0._unlockStory(arg_33_0)
	arg_33_0.storyItemList[arg_33_0.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_33_0._unlockStoryEnd, arg_33_0, 1)
end

function var_0_0._unlockStoryEnd(arg_34_0)
	arg_34_0.storyItemList[arg_34_0.finishStoryIndex + 1]:refreshStatus()

	arg_34_0.finishStoryIndex = nil

	arg_34_0:_lockScreen(false)
end

function var_0_0._playFightFinishAnim(arg_35_0)
	local var_35_0 = RoleActivityModel.instance:getNewFinishFightLvl()

	if var_35_0 then
		RoleActivityModel.instance:updateData(arg_35_0.actId)

		for iter_35_0, iter_35_1 in ipairs(arg_35_0.fightItemList) do
			if iter_35_1.id == var_35_0 then
				arg_35_0.finishFightIndex = iter_35_0

				iter_35_1:refreshStar()
				iter_35_1:playStarAnim(true)
				TaskDispatcher.runDelay(arg_35_0._starShowEnd, arg_35_0, 0.67)

				break
			elseif iter_35_1.hardConfig.id == var_35_0 then
				iter_35_1:refreshStar()
				iter_35_1:playStarAnim()
				arg_35_0:_lockScreen(false)

				break
			end
		end

		RoleActivityModel.instance:clearNewFinishFightLvl()

		return
	end

	arg_35_0:_lockScreen(false)
end

function var_0_0._starShowEnd(arg_36_0)
	arg_36_0.fightItemList[arg_36_0.finishFightIndex]:playHardUnlock()
	TaskDispatcher.runDelay(arg_36_0._unlockFightEnd, arg_36_0, 1.7)

	if arg_36_0.fightItemList[arg_36_0.finishFightIndex + 1] then
		arg_36_0.fightItemList[arg_36_0.finishFightIndex + 1]:playUnlock()
	end
end

function var_0_0._unlockFightEnd(arg_37_0)
	arg_37_0.fightItemList[arg_37_0.finishFightIndex]:refreshStatus()

	if arg_37_0.fightItemList[arg_37_0.finishFightIndex + 1] then
		arg_37_0.fightItemList[arg_37_0.finishFightIndex + 1]:refreshStatus()
	end

	arg_37_0.finishFightIndex = nil

	arg_37_0:_lockScreen(false)
end

function var_0_0._delayOpenStory(arg_38_0)
	arg_38_0._anim:Play("openstory", 0, 0)
end

function var_0_0._delayOpenFight(arg_39_0)
	arg_39_0._anim:Play("openfight", 0, 0)
end

function var_0_0._showLeftTime(arg_40_0)
	arg_40_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_40_0.actId)
end

function var_0_0._initPathStatus(arg_41_0)
	if arg_41_0.latestStoryItem > 1 then
		arg_41_0._animPath:Play("go" .. arg_41_0.latestStoryItem - 1, 0, 1)
	else
		arg_41_0._animPath.speed = 0

		arg_41_0._animPath:Play("go1", 0, 0)
	end
end

function var_0_0._focusStoryItem(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = recthelper.getAnchorX(arg_42_0.storyItemList[arg_42_1].transform.parent)
	local var_42_1 = arg_42_0._offsetX - var_42_0

	if var_42_1 > 0 then
		var_42_1 = 0
	elseif var_42_1 < arg_42_0.minContentAnchorX then
		var_42_1 = arg_42_0.minContentAnchorX
	end

	if arg_42_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_42_0._gostoryScroll.transform, var_42_1, var_0_1, arg_42_0._onFocusEnd, arg_42_0, arg_42_1)
	else
		recthelper.setAnchorX(arg_42_0._gostoryScroll.transform, var_42_1)
	end

	arg_42_0:_updateStoryFocusFlag(arg_42_1, arg_42_2)
end

function var_0_0._onFocusEnd(arg_43_0, arg_43_1)
	arg_43_0.storyItemList[arg_43_1]:playStory()
end

function var_0_0._lockScreen(arg_44_0, arg_44_1)
	if arg_44_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("ZhiXinQuanErLock")
	else
		UIBlockMgr.instance:endBlock("ZhiXinQuanErLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return var_0_0
