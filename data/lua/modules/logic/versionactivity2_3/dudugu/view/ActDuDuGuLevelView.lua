module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelView", package.seeall)

local var_0_0 = class("ActDuDuGuLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._golvpath = gohelper.findChild(arg_1_0.viewGO, "#go_lvpath")
	arg_1_0._golvScroll = gohelper.findChild(arg_1_0.viewGO, "#go_lvpath/#go_lvScroll")
	arg_1_0._golvstages = gohelper.findChild(arg_1_0.viewGO, "#go_lvpath/#go_lvScroll/#go_lvstages")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnPlayBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Title/#btn_PlayBtn")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._animEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_1_0._goPath = gohelper.findChild(arg_1_0._golvScroll, "path/path_2")
	arg_1_0._animPath = arg_1_0._goPath:GetComponent(gohelper.Type_Animator)
	arg_1_0._animTask = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0._scrolllv = gohelper.findChildScrollRect(arg_1_0._golvpath, "")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayBtn:AddClickListener(arg_2_0._btnPlayBtnOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._animEvent:AddEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd, arg_2_0._onStoryOpenEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlayBtn:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._animEvent:RemoveEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd)
end

function var_0_0._btnPlayBtnOnClick(arg_4_0)
	if arg_4_0.actConfig.storyId > 0 then
		StoryController.instance:playStory(arg_4_0.actConfig.storyId)
	end
end

function var_0_0._btnTaskOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.ActDuDuGuTaskView)
end

function var_0_0._addEvents(arg_6_0)
	arg_6_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, arg_6_0.OnLvItemClick, arg_6_0)
	arg_6_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_6_0.OnStoryFinish, arg_6_0)
	arg_6_0:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, arg_6_0.OnEndDungeonPush, arg_6_0)
	arg_6_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_6_0.OnDotChange, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = VersionActivity2_3Enum.ActivityId.DuDuGu
	arg_7_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_7_0._golvpath)

	arg_7_0._drag:AddDragBeginListener(arg_7_0._onDragBegin, arg_7_0)
	arg_7_0._drag:AddDragEndListener(arg_7_0._onDragEnd, arg_7_0)

	arg_7_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_7_0._golvpath)

	arg_7_0._touch:AddClickDownListener(arg_7_0._onClickDown, arg_7_0)

	arg_7_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_7_0._golvpath, DungeonMapEpisodeAudio, arg_7_0._scrolllv)
	arg_7_0.actConfig = ActivityConfig.instance:getActivityCo(arg_7_0.actId)

	ActDuDuGuModel.instance:initData(arg_7_0.actId)
	arg_7_0:_initStageItems()
	gohelper.setActive(arg_7_0._btnPlayBtn, arg_7_0.actConfig.storyId > 0)
	arg_7_0:_addEvents()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = gohelper.findChild(arg_8_0._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_8_0, RedDotEnum.DotNode.V1a6RoleActivityTask, arg_8_0.actId)
	arg_8_0:_initPathStatus()
	arg_8_0:OnDotChange()
	arg_8_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_8_0._showLeftTime, arg_8_0, 1)

	if arg_8_0:_checkFirstEnter() then
		arg_8_0:_lockScreen(true)
		arg_8_0._lvItems[1]:lockStatus()
		TaskDispatcher.runDelay(arg_8_0._playFirstUnlock, arg_8_0, 0.8)
	end
end

function var_0_0._playStoryFinishAnim(arg_9_0)
	local var_9_0 = ActDuDuGuModel.instance:getNewFinishStoryLvl()

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.storyItemList) do
			if iter_9_1.id == var_9_0 then
				arg_9_0:_lockScreen(true)

				arg_9_0.finishStoryIndex = iter_9_0

				iter_9_1:playFinish()
				iter_9_1:playStarAnim()
				TaskDispatcher.runDelay(arg_9_0._finishStoryEnd, arg_9_0, 1)

				break
			end
		end

		ActDuDuGuModel.instance:clearNewFinishStoryLvl()
	end
end

function var_0_0._checkFirstEnter(arg_10_0)
	if not arg_10_0._lvItems[2]:isUnlock() and PlayerPrefsHelper.getNumber("ActDuDuGuFirstEnter", 0) == 0 then
		PlayerPrefsHelper.setNumber("ActDuDuGuFirstEnter", 1)

		return true
	end

	return false
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showLeftTime, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playFirstUnlock, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delayOpenStory, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._unlockLvEnd, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._finishStoryEnd, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playPathAnim, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._unlockStory, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playStoryFinishAnim, arg_11_0)
	arg_11_0:_lockScreen(false)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._lvItems = nil

	if arg_12_0._drag then
		arg_12_0._drag:RemoveDragBeginListener()
		arg_12_0._drag:RemoveDragEndListener()

		arg_12_0._drag = nil
	end

	if arg_12_0._touch then
		arg_12_0._touch:RemoveClickDownListener()

		arg_12_0._touch = nil
	end
end

function var_0_0.OnLvItemClick(arg_13_0, arg_13_1)
	arg_13_0:_focusLvItem(arg_13_1, true)
end

function var_0_0.OnStoryFinish(arg_14_0)
	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
		arg_14_0._curLvIndex = arg_14_0._lvItems[arg_14_0._curLvIndex + 1] and arg_14_0._curLvIndex + 1 or arg_14_0._curLvIndex

		arg_14_0:_focusLvItem(arg_14_0._curLvIndex, false)
	end

	TaskDispatcher.runDelay(arg_14_0._delayOpenStory, arg_14_0, 0.4)
end

function var_0_0.OnEndDungeonPush(arg_15_0)
	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
		arg_15_0._curLvIndex = arg_15_0._lvItems[arg_15_0._curLvIndex + 1] and arg_15_0._curLvIndex + 1 or arg_15_0._curLvIndex

		arg_15_0:_focusLvItem(arg_15_0._curLvIndex, false)
	end

	ActDuDuGuModel.instance:updateData(arg_15_0.actId)
	TaskDispatcher.runDelay(arg_15_0._playStoryFinishAnim, arg_15_0, 0.73)
end

function var_0_0.OnDotChange(arg_16_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V1a6RoleActivityTask, arg_16_0.actId) then
		arg_16_0._animTask:Play("loop")
	else
		arg_16_0._animTask:Play("idle")
	end
end

function var_0_0._onStoryOpenEnd(arg_17_0)
	arg_17_0:_initPathStatus()

	if ActDuDuGuModel.instance:getNewFinishStoryLvl() then
		arg_17_0:_playStoryFinishAnim()
		ActDuDuGuModel.instance:updateData(arg_17_0.actId)
	end
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

	arg_21_0._lvItems = {}

	local var_21_3 = RoleActivityConfig.instance:getStoryLevelList(arg_21_0.actId)
	local var_21_4 = #var_21_3

	for iter_21_0 = 1, var_21_4 do
		local var_21_5 = gohelper.findChild(arg_21_0._golvstages, "stage" .. iter_21_0)
		local var_21_6 = arg_21_0:getResInst(var_21_2, var_21_5)
		local var_21_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_6, ActDuDuGuLevelItem, arg_21_0)

		arg_21_0._lvItems[iter_21_0] = var_21_7

		arg_21_0._lvItems[iter_21_0]:setParam(var_21_3[iter_21_0], iter_21_0, arg_21_0.actId)

		if arg_21_0._lvItems[iter_21_0]:isUnlock() then
			arg_21_0._curLvIndex = iter_21_0
		end
	end

	local var_21_8 = ActDuDuGuModel.instance:getCurLvIndex()

	arg_21_0._curLvIndex = var_21_8 > 0 and var_21_8 or arg_21_0._curLvIndex

	arg_21_0:_focusLvItem(arg_21_0._curLvIndex)
end

function var_0_0._playFirstUnlock(arg_22_0)
	arg_22_0.finishStoryIndex = 0

	arg_22_0._lvItems[1]:playUnlock()
	TaskDispatcher.runDelay(arg_22_0._unlockLvEnd, arg_22_0, 2)
end

function var_0_0._unlockLvEnd(arg_23_0)
	arg_23_0._lvItems[arg_23_0.finishStoryIndex + 1]:refreshStatus()

	arg_23_0.finishStoryIndex = nil

	arg_23_0:_lockScreen(false)
end

function var_0_0._finishStoryEnd(arg_24_0)
	if arg_24_0.finishStoryIndex == #arg_24_0._lvItems then
		arg_24_0._curLvIndex = arg_24_0.finishStoryIndex
		arg_24_0.finishStoryIndex = nil

		arg_24_0:_lockScreen(false)
	else
		arg_24_0._curLvIndex = arg_24_0.finishStoryIndex + 1

		arg_24_0:_playPathAnim()
	end
end

function var_0_0._playPathAnim(arg_25_0)
	local var_25_0 = "go" .. arg_25_0.finishStoryIndex

	arg_25_0._animPath.speed = 1

	arg_25_0._animPath:Play(var_25_0)
	TaskDispatcher.runDelay(arg_25_0._unlockStory, arg_25_0, 0.33)
end

function var_0_0._unlockStory(arg_26_0)
	arg_26_0._lvItems[arg_26_0.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_26_0._unlockLvEnd, arg_26_0, 2)
end

function var_0_0._delayOpenStory(arg_27_0)
	arg_27_0._anim:Play("openstory", 0, 0)
end

function var_0_0._showLeftTime(arg_28_0)
	arg_28_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_28_0.actId)
end

function var_0_0._initPathStatus(arg_29_0)
	if arg_29_0._curLvIndex > 1 then
		arg_29_0._animPath:Play("go" .. arg_29_0._curLvIndex - 1, 0, 1)
	else
		arg_29_0._animPath.speed = 0

		arg_29_0._animPath:Play("go1", 0, 0)
	end
end

function var_0_0._focusLvItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 < 3 and 540 or 540 + (arg_30_1 - 3) * 920 / 5

	if arg_30_2 then
		ZProj.TweenHelper.DOLocalMoveY(arg_30_0._golvScroll.transform, var_30_0, 0.26, arg_30_0._onFocusEnd, arg_30_0, arg_30_1)
	else
		ZProj.TweenHelper.DOLocalMoveY(arg_30_0._golvScroll.transform, var_30_0, 0.26)
	end

	ActDuDuGuModel.instance:setCurLvIndex(arg_30_1)
end

function var_0_0._onFocusEnd(arg_31_0, arg_31_1)
	return
end

function var_0_0._lockScreen(arg_32_0, arg_32_1)
	if arg_32_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DuDuGuLock")
	else
		UIBlockMgr.instance:endBlock("DuDuGuLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return var_0_0
