module("modules.logic.versionactivity1_7.marcus.view.ActMarcusLevelView", package.seeall)

local var_0_0 = class("ActMarcusLevelView", BaseView)

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
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnPlayBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Title/#btn_PlayBtn")
	arg_1_0._btnStory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Story")
	arg_1_0._goStoryN = gohelper.findChild(arg_1_0._btnStory.gameObject, "go_UnSelected")
	arg_1_0._goStoryS = gohelper.findChild(arg_1_0._btnStory.gameObject, "go_Selected")
	arg_1_0._btnFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Fight")
	arg_1_0._goFightN = gohelper.findChild(arg_1_0._btnFight.gameObject, "go_UnSelected")
	arg_1_0._goFightS = gohelper.findChild(arg_1_0._btnFight.gameObject, "go_Selected")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._animEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_1_0._animPath = gohelper.findChild(arg_1_0._gostoryScroll, "path/path_2"):GetComponent(gohelper.Type_Animator)
	arg_1_0._animTask = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0._scrollStory = gohelper.findChildScrollRect(arg_1_0._gostoryPath, "")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayBtn:AddClickListener(arg_2_0._btnPlayBtnOnClick, arg_2_0)
	arg_2_0._btnStory:AddClickListener(arg_2_0._btnStoryOnClick, arg_2_0)
	arg_2_0._btnFight:AddClickListener(arg_2_0._btnFightOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._animEvent:AddEventListener(ActMarcusEnum.AnimEvt.OnStoryOpenEnd, arg_2_0._onStoryOpenEnd, arg_2_0)
	arg_2_0._animEvent:AddEventListener(ActMarcusEnum.AnimEvt.OnFightOpenEnd, arg_2_0._onFightOpenEnd, arg_2_0)
	arg_2_0._animEvent:AddEventListener(ActMarcusEnum.AnimEvt.OnGoStoryEnd, arg_2_0._onGoStoryEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlayBtn:RemoveClickListener()
	arg_3_0._btnStory:RemoveClickListener()
	arg_3_0._btnFight:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
end

function var_0_0._btnPlayBtnOnClick(arg_4_0)
	if arg_4_0.actConfig.storyId > 0 then
		StoryController.instance:playStory(arg_4_0.actConfig.storyId)
	end
end

function var_0_0._btnStoryOnClick(arg_5_0, arg_5_1)
	if arg_5_0._gostoryPath.activeInHierarchy then
		return
	end

	gohelper.setActive(arg_5_0._goStoryN, false)
	gohelper.setActive(arg_5_0._goStoryS, true)
	gohelper.setActive(arg_5_0._goFightN, true)
	gohelper.setActive(arg_5_0._goFightS, false)
	gohelper.setActive(arg_5_0._btnPlayBtn, arg_5_0.actConfig.storyId > 0)

	if arg_5_1 then
		arg_5_0._anim:Play("openstory", 0, 0)
	else
		arg_5_0._anim:Play("gostory", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_switch)
	end
end

function var_0_0._btnFightOnClick(arg_6_0, arg_6_1)
	if arg_6_0._gofightPath.activeInHierarchy then
		return
	end

	gohelper.setActive(arg_6_0._goStoryN, true)
	gohelper.setActive(arg_6_0._goStoryS, false)
	gohelper.setActive(arg_6_0._goFightN, false)
	gohelper.setActive(arg_6_0._goFightS, true)
	gohelper.setActive(arg_6_0._btnPlayBtn, false)

	if arg_6_1 then
		arg_6_0._anim:Play("openfight", 0, 0)
	else
		arg_6_0._anim:Play("gofight", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_switch)
	end
end

function var_0_0._btnTaskOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.ActMarcusTaskView)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.actId = VersionActivity1_7Enum.ActivityId.Marcus
	arg_8_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_8_0._gostoryPath)

	arg_8_0._drag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._drag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)

	arg_8_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_8_0._gostoryPath)

	arg_8_0._touch:AddClickDownListener(arg_8_0._onClickDown, arg_8_0)

	arg_8_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_8_0._gostoryPath, DungeonMapEpisodeAudio, arg_8_0._scrollStory)
	arg_8_0.actConfig = ActivityConfig.instance:getActivityCo(arg_8_0.actId)

	local var_8_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_8_0._offsetX = (var_8_0 - -300) / 2
	arg_8_0.minContentAnchorX = -4660 + var_8_0

	ActMarcusModel.instance:initData()
	arg_8_0:_initStageItems()
	gohelper.setActive(arg_8_0._btnPlayBtn, arg_8_0.actConfig.storyId > 0)
	gohelper.setActive(arg_8_0._gotime, false)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(ActMarcusController.instance, ActMarcusEvent.StoryItemClick, arg_9_0.OnStoryItemClick, arg_9_0)
	arg_9_0:addEventCb(ActMarcusController.instance, ActMarcusEvent.FightItemClick, arg_9_0.OnFightItemClick, arg_9_0)
	arg_9_0:addEventCb(ActMarcusController.instance, ActMarcusEvent.TabSwitch, arg_9_0.OnTabSwitch, arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_9_0.OnStoryFinish, arg_9_0)
	arg_9_0:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, arg_9_0.OnEndDungeonPush, arg_9_0)
	arg_9_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_9_0.OnDotChange, arg_9_0)

	local var_9_0 = gohelper.findChild(arg_9_0._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_9_0, RedDotEnum.DotNode.PermanentRoleActivityTask, arg_9_0.actId)
	arg_9_0:OnDotChange()
	arg_9_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_9_0._showLeftTime, arg_9_0, 1)

	if arg_9_0.viewParam and arg_9_0.viewParam.needShowFight then
		local var_9_1 = ActMarcusModel.instance:getEnterFightIndex()

		if var_9_1 then
			arg_9_0.latestfightItem = var_9_1

			for iter_9_0, iter_9_1 in ipairs(arg_9_0.fightItemList) do
				iter_9_1:refreshSelect(var_9_1)
			end
		end

		arg_9_0:_btnFightOnClick(true)
		arg_9_0:_lockScreen(true)
		TaskDispatcher.runDelay(arg_9_0._delayOpenFight, arg_9_0, 0.3)
	else
		arg_9_0:_btnStoryOnClick(true)

		if ActMarcusModel.instance:getFirstEnter() then
			ActMarcusModel.instance:clearFirstEnter()
			arg_9_0:_lockScreen(true)
			arg_9_0.storyItemList[1]:lockStatus()
			TaskDispatcher.runDelay(arg_9_0._playFirstUnlock, arg_9_0, 0.8)
		end
	end
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showLeftTime, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayOpenFight, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playFirstUnlock, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayOpenStory, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._unlockStoryEnd, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._finishStoryEnd, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playPathAnim, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._unlockFightEnd, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._unlockStory, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._starShowEnd, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playStoryFinishAnim, arg_10_0)
	arg_10_0:_lockScreen(false)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0.storyItemList = nil
	arg_11_0.fightItemList = nil

	if arg_11_0._drag then
		arg_11_0._drag:RemoveDragBeginListener()
		arg_11_0._drag:RemoveDragEndListener()

		arg_11_0._drag = nil
	end

	if arg_11_0._touch then
		arg_11_0._touch:RemoveClickDownListener()

		arg_11_0._touch = nil
	end
end

function var_0_0.OnStoryItemClick(arg_12_0, arg_12_1)
	arg_12_0:_focusStoryItem(arg_12_1, true)
end

function var_0_0.OnFightItemClick(arg_13_0, arg_13_1)
	if arg_13_0.latestfightItem == arg_13_1 then
		return
	end

	arg_13_0.latestfightItem = arg_13_1

	AudioMgr.instance:trigger(AudioEnum.RoleActivity.fight_switch)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.fightItemList) do
		iter_13_1:refreshSelect(arg_13_1)
	end
end

function var_0_0.OnTabSwitch(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0:_btnFightOnClick()
	else
		arg_14_0:_btnStoryOnClick()
	end
end

function var_0_0.OnStoryFinish(arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._delayOpenStory, arg_15_0, 0.4)
end

function var_0_0.OnEndDungeonPush(arg_16_0)
	ActMarcusModel.instance:updateData()
	TaskDispatcher.runDelay(arg_16_0._playStoryFinishAnim, arg_16_0, 0.73)
end

function var_0_0.OnDotChange(arg_17_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PermanentRoleActivityTask, arg_17_0.actId) then
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

function var_0_0._onClickDown(arg_23_0)
	arg_23_0._audioScroll:onClickDown()
end

function var_0_0._initStageItems(arg_24_0)
	local var_24_0
	local var_24_1
	local var_24_2 = arg_24_0.viewContainer:getSetting().otherRes[1]

	arg_24_0.storyItemList = {}

	local var_24_3 = RoleActivityConfig.instance:getStoryLevelList(arg_24_0.actId)
	local var_24_4 = #var_24_3

	for iter_24_0 = 1, var_24_4 do
		local var_24_5 = gohelper.findChild(arg_24_0._gostoryStages, "stage" .. iter_24_0)
		local var_24_6 = arg_24_0:getResInst(var_24_2, var_24_5)
		local var_24_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_6, MarcusStoryItem, arg_24_0)

		arg_24_0.storyItemList[iter_24_0] = var_24_7

		arg_24_0.storyItemList[iter_24_0]:setParam(var_24_3[iter_24_0], iter_24_0)

		if arg_24_0.storyItemList[iter_24_0]:isUnlock() then
			arg_24_0.latestStoryItem = iter_24_0
		end
	end

	arg_24_0:_focusStoryItem(arg_24_0.latestStoryItem)

	local var_24_8 = arg_24_0.viewContainer:getSetting().otherRes[2]

	arg_24_0.fightItemList = {}

	local var_24_9 = RoleActivityConfig.instance:getBattleLevelList(arg_24_0.actId)
	local var_24_10 = #var_24_9 / 2

	for iter_24_1 = 1, var_24_10 do
		local var_24_11 = gohelper.findChild(arg_24_0._gofightStages, "stage" .. iter_24_1)
		local var_24_12 = arg_24_0:getResInst(var_24_8, var_24_11)
		local var_24_13 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_12, MarcusFightItem, arg_24_0)

		arg_24_0.fightItemList[iter_24_1] = var_24_13

		arg_24_0.fightItemList[iter_24_1]:setParam(var_24_9[2 * iter_24_1 - 1], iter_24_1)

		if arg_24_0.fightItemList[iter_24_1]:isUnlock() then
			arg_24_0.latestfightItem = iter_24_1
		end
	end

	arg_24_0.fightItemList[arg_24_0.latestfightItem]:refreshSelect()
end

function var_0_0._playFirstUnlock(arg_25_0)
	arg_25_0.finishStoryIndex = 0

	arg_25_0.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(arg_25_0._unlockStoryEnd, arg_25_0, 0.83)
end

function var_0_0._playStoryFinishAnim(arg_26_0)
	local var_26_0 = ActMarcusModel.instance:getNewFinishStoryLvl()

	if var_26_0 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.storyItemList) do
			if iter_26_1.id == var_26_0 then
				arg_26_0:_lockScreen(true)

				arg_26_0.finishStoryIndex = iter_26_0

				iter_26_1:playFinish()
				TaskDispatcher.runDelay(arg_26_0._finishStoryEnd, arg_26_0, 1.5)

				break
			end
		end

		ActMarcusModel.instance:clearNewFinishStoryLvl()
	end
end

function var_0_0._finishStoryEnd(arg_27_0)
	arg_27_0.storyItemList[arg_27_0.finishStoryIndex]:refreshStatus()
	arg_27_0.storyItemList[arg_27_0.finishStoryIndex]:playStarAnim()

	if arg_27_0.finishStoryIndex == #arg_27_0.storyItemList then
		arg_27_0.latestStoryItem = arg_27_0.finishStoryIndex
		arg_27_0.finishStoryIndex = nil

		arg_27_0:_lockScreen(false)
	else
		arg_27_0.latestStoryItem = arg_27_0.finishStoryIndex + 1

		TaskDispatcher.runDelay(arg_27_0._playPathAnim, arg_27_0, 0.67)
	end
end

function var_0_0._playPathAnim(arg_28_0)
	local var_28_0 = "go" .. arg_28_0.finishStoryIndex

	arg_28_0._animPath.speed = 1

	arg_28_0._animPath:Play(var_28_0)
	TaskDispatcher.runDelay(arg_28_0._unlockStory, arg_28_0, 0.5)
end

function var_0_0._unlockStory(arg_29_0)
	arg_29_0.storyItemList[arg_29_0.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_29_0._unlockStoryEnd, arg_29_0, 1.7)
end

function var_0_0._unlockStoryEnd(arg_30_0)
	arg_30_0.storyItemList[arg_30_0.finishStoryIndex + 1]:refreshStatus()

	arg_30_0.finishStoryIndex = nil

	arg_30_0:_lockScreen(false)
end

function var_0_0._playFightFinishAnim(arg_31_0)
	ActMarcusModel.instance:updateData()

	local var_31_0 = ActMarcusModel.instance:getNewFinishFightLvl()

	if var_31_0 then
		for iter_31_0, iter_31_1 in ipairs(arg_31_0.fightItemList) do
			if iter_31_1.id == var_31_0 then
				arg_31_0.finishFightIndex = iter_31_0

				iter_31_1:refreshStar()
				iter_31_1:playStarAnim(true)
				TaskDispatcher.runDelay(arg_31_0._starShowEnd, arg_31_0, 0.67)

				break
			elseif iter_31_1.hardConfig.id == var_31_0 then
				iter_31_1:refreshStar()
				iter_31_1:playStarAnim()
				arg_31_0:_lockScreen(false)

				break
			end
		end

		ActMarcusModel.instance:clearNewFinishFightLvl()

		return
	end

	arg_31_0:_lockScreen(false)
end

function var_0_0._starShowEnd(arg_32_0)
	arg_32_0.fightItemList[arg_32_0.finishFightIndex]:playHardUnlock()
	TaskDispatcher.runDelay(arg_32_0._unlockFightEnd, arg_32_0, 1.7)

	if arg_32_0.fightItemList[arg_32_0.finishFightIndex + 1] then
		arg_32_0.fightItemList[arg_32_0.finishFightIndex + 1]:playUnlock()
	end
end

function var_0_0._unlockFightEnd(arg_33_0)
	arg_33_0.fightItemList[arg_33_0.finishFightIndex]:refreshStatus()

	if arg_33_0.fightItemList[arg_33_0.finishFightIndex + 1] then
		arg_33_0.fightItemList[arg_33_0.finishFightIndex + 1]:refreshStatus()
	end

	arg_33_0.finishFightIndex = nil

	arg_33_0:_lockScreen(false)
end

function var_0_0._delayOpenStory(arg_34_0)
	arg_34_0._anim:Play("openstory", 0, 0)
end

function var_0_0._delayOpenFight(arg_35_0)
	arg_35_0._anim:Play("openfight", 0, 0)
end

function var_0_0._showLeftTime(arg_36_0)
	arg_36_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_36_0.actId)
end

function var_0_0._initPathStatus(arg_37_0)
	if arg_37_0.latestStoryItem > 1 then
		arg_37_0._animPath:Play("go" .. arg_37_0.latestStoryItem - 1, 0, 1)
	else
		arg_37_0._animPath.speed = 0

		arg_37_0._animPath:Play("go1", 0, 0)
	end
end

function var_0_0._focusStoryItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = recthelper.getAnchorX(arg_38_0.storyItemList[arg_38_1].transform.parent)
	local var_38_1 = arg_38_0._offsetX - var_38_0

	if var_38_1 > 0 then
		var_38_1 = 0
	elseif var_38_1 < arg_38_0.minContentAnchorX then
		var_38_1 = arg_38_0.minContentAnchorX
	end

	if arg_38_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_38_0._gostoryScroll.transform, var_38_1, 0.26, arg_38_0._onFocusEnd, arg_38_0, arg_38_1)
	else
		ZProj.TweenHelper.DOAnchorPosX(arg_38_0._gostoryScroll.transform, var_38_1, 0.26)
	end
end

function var_0_0._onFocusEnd(arg_39_0, arg_39_1)
	arg_39_0.storyItemList[arg_39_1]:playStory()
end

function var_0_0._lockScreen(arg_40_0, arg_40_1)
	if arg_40_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MarcusLock")
	else
		UIBlockMgr.instance:endBlock("MarcusLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return var_0_0
