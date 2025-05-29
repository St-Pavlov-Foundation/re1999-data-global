module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelView", package.seeall)

local var_0_0 = class("XugoujiLevelView", BaseView)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task", AudioEnum.UI.play_ui_mission_open)
	arg_1_0._goTaskAni = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani")
	arg_1_0._btnChallenge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ChallengeBtn")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._scrollStory = gohelper.findChildScrollRect(arg_1_0._gostoryPath, "")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._goPath = gohelper.findChild(arg_1_0._goscrollcontent, "path/path_2")
	arg_1_0._animPath = arg_1_0._goPath:GetComponent(gohelper.Type_Animator)
	arg_1_0._pathAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goPath)
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._taskAnimator = arg_1_0._goTaskAni:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnChallenge:AddClickListener(arg_2_0._btnChallengeOnClick, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.EpisodeUpdate, arg_2_0._onEpisodeUpdate, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0._refreshTask, arg_2_0)
	RedDotController.instance:addRedDot(arg_2_0._gored, RedDotEnum.DotNode.V2a6XugoujiTask)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnChallenge:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._refreshTask, arg_3_0)
end

function var_0_0._btntaskOnClick(arg_4_0)
	XugoujiController.instance:openTaskView()
end

function var_0_0._btnChallengeOnClick(arg_5_0)
	XugoujiController.instance:enterEpisode(XugoujiEnum.ChallengeEpisodeId)
end

function var_0_0._onDragBegin(arg_6_0)
	arg_6_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_7_0)
	arg_7_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDown(arg_8_0)
	arg_8_0._audioScroll:onClickDown()
end

function var_0_0._editableInitView(arg_9_0)
	local var_9_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_9_0._offsetX = (var_9_0 - -300) / 2
	arg_9_0.minContentAnchorX = -6560 + var_9_0
	arg_9_0._bgWidth = recthelper.getWidth(arg_9_0._simageFullBG.transform)
	arg_9_0._minBgPositionX = BootNativeUtil.getDisplayResolution() - arg_9_0._bgWidth
	arg_9_0._maxBgPositionX = 0
	arg_9_0._bgPositonMaxOffsetX = math.abs(arg_9_0._maxBgPositionX - arg_9_0._minBgPositionX)
	arg_9_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_9_0._gostoryPath)
	arg_9_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_9_0._gostoryPath)

	arg_9_0._drag:AddDragBeginListener(arg_9_0._onDragBegin, arg_9_0)
	arg_9_0._drag:AddDragEndListener(arg_9_0._onDragEnd, arg_9_0)
	arg_9_0._touch:AddClickDownListener(arg_9_0._onClickDown, arg_9_0)

	arg_9_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_9_0._gostoryPath, DungeonMapEpisodeAudio, arg_9_0._scrollStory)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshTime()
	arg_10_0:_initStages()
	arg_10_0:refreshChallengeBtn()
	arg_10_0:_refreshTask()
	TaskDispatcher.runRepeat(arg_10_0.refreshTime, arg_10_0, 60)

	local var_10_0 = arg_10_0:getCurEpisodeIndex()
	local var_10_1 = Activity188Model.instance:getCurEpisodeId()

	arg_10_0:focusEpisodeItem(var_10_0 + 1, var_10_1, false, false)
end

function var_0_0._initStages(arg_11_0)
	if arg_11_0._stageItemList then
		return
	end

	local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes[1]

	arg_11_0._stageItemList = {}
	arg_11_0._curOpenEpisodeCount = Activity188Model.instance:getFinishedCount() + 1

	local var_11_1 = Activity188Model.instance:getFinishedCount()
	local var_11_2 = Activity188Config.instance:getEpisodeCfgList(var_0_1)
	local var_11_3 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. var_0_1, "1")
	local var_11_4

	var_11_4 = tonumber(var_11_3) or 1

	local var_11_5 = Mathf.Clamp(var_11_4, 1, #var_11_2)
	local var_11_6 = (var_11_2[var_11_5] and var_11_2[var_11_5] or var_11_2[1]).episodeId

	Activity188Model.instance:setCurEpisodeId(var_11_6)

	for iter_11_0 = 1, #var_11_2 do
		local var_11_7 = gohelper.findChild(arg_11_0._gostages, "stage" .. iter_11_0)
		local var_11_8 = arg_11_0:getResInst(var_11_0, var_11_7)
		local var_11_9 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_8, XugoujiLevelViewStageItem, arg_11_0)

		var_11_9:refreshItem(var_11_2[iter_11_0], iter_11_0)
		table.insert(arg_11_0._stageItemList, var_11_9)
	end

	if arg_11_0._curOpenEpisodeCount == 1 then
		gohelper.setActive(arg_11_0._goPath, false)
	elseif var_11_1 == #var_11_2 then
		gohelper.setActive(arg_11_0._goPath, true)
		arg_11_0._animPath:Play("go" .. var_11_1 - 2, 0, 1)
	else
		gohelper.setActive(arg_11_0._goPath, true)
		arg_11_0._animPath:Play("go" .. var_11_1, 0, 1)
	end
end

function var_0_0.getCurEpisodeIndex(arg_12_0)
	local var_12_0 = Activity188Model.instance:getCurEpisodeId()
	local var_12_1 = Activity188Config.instance:getEpisodeCfg(var_0_1, var_12_0)

	if not var_12_1 then
		return 1
	end

	local var_12_2 = var_12_1 and var_12_1.episodeId or 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._stageItemList) do
		if iter_12_1.episodeId == var_12_2 then
			return iter_12_0
		end
	end
end

function var_0_0.refreshTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActivityInfo()[var_0_1]

	if var_13_0 then
		local var_13_1 = var_13_0:getRealEndTimeStamp() - ServerTime.now()

		if var_13_1 > 0 then
			local var_13_2 = TimeUtil.SecondToActivityTimeFormat(var_13_1)

			arg_13_0._txtlimittime.text = var_13_2

			return
		end
	end
end

function var_0_0.refreshChallengeBtn(arg_14_0)
	local var_14_0 = Activity188Model.instance:isEpisodeUnlock(XugoujiEnum.ChallengeEpisodeId)

	gohelper.setActive(arg_14_0._btnChallenge, var_14_0)
end

function var_0_0.focusEpisodeItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_0._stageItemList[arg_15_1]

	if not var_15_0 then
		return
	end

	local var_15_1 = recthelper.getAnchorX(var_15_0.viewGO.transform.parent)
	local var_15_2 = arg_15_0._offsetX - var_15_1

	if var_15_2 > 0 then
		var_15_2 = 0
	elseif var_15_2 < arg_15_0.minContentAnchorX then
		var_15_2 = arg_15_0.minContentAnchorX
	end

	if arg_15_4 then
		if arg_15_5 then
			ZProj.TweenHelper.DOAnchorPosX(arg_15_0._gostoryScroll.transform, var_15_2, 0.26)
		else
			ZProj.TweenHelper.DOAnchorPosX(arg_15_0._gostoryScroll.transform, var_15_2, 0.26, arg_15_0.onFocusEnd, arg_15_0, {
				arg_15_2,
				arg_15_3
			})
		end
	else
		ZProj.TweenHelper.DOAnchorPosX(arg_15_0._gostoryScroll.transform, var_15_2, 0)
	end
end

function var_0_0.onFocusEnd(arg_16_0, arg_16_1)
	return
end

function var_0_0._onEpisodeFinish(arg_17_0, arg_17_1)
	XugoujiController.instance:getStatMo():sendDungeonFinishStatData()

	local var_17_0 = Activity188Model.instance:getFinishedCount()

	if var_17_0 < arg_17_0._curOpenEpisodeCount then
		return
	end

	arg_17_0._curOpenEpisodeCount = var_17_0 + 1

	gohelper.setActive(arg_17_0._goPath, true)
	arg_17_0._animPath:Play("go" .. var_17_0, 0, 0)
	arg_17_0._stageItemList[var_17_0]:onPlayFinish()

	if arg_17_0._stageItemList[var_17_0 + 1] then
		arg_17_0._stageItemList[var_17_0 + 1]:onPlayUnlock()
	end

	arg_17_0:_refreshTask()
end

function var_0_0._onEpisodeUpdate(arg_18_0)
	local var_18_0 = Activity188Model.instance:getFinishedCount()

	if var_18_0 < arg_18_0._curOpenEpisodeCount then
		return
	end

	arg_18_0._curOpenEpisodeCount = var_18_0 + 1
	arg_18_0._needFinishAni = true

	arg_18_0:refreshChallengeBtn()
end

function var_0_0.doEpisodeFinishedDisplay(arg_19_0)
	if not arg_19_0._needFinishAni then
		return
	end

	arg_19_0._needFinishAni = false

	local var_19_0 = Activity188Model.instance:getFinishedCount()

	arg_19_0._stageItemList[var_19_0]:playFinishAni()
	gohelper.setActive(arg_19_0._goPath, true)
	arg_19_0._animPath:Play("go" .. var_19_0, 0, 0)

	if arg_19_0._stageItemList[var_19_0 + 1] then
		TaskDispatcher.runDelay(arg_19_0.doNewEpisodeUnlockDisplay, arg_19_0, 0.5)
	end
end

function var_0_0.doNewEpisodeUnlockDisplay(arg_20_0)
	local var_20_0 = Activity188Model.instance:getFinishedCount()

	if arg_20_0._stageItemList[var_20_0 + 1] then
		arg_20_0._stageItemList[var_20_0 + 1]:playUnlockAni()

		local var_20_1 = Activity188Model.instance:getCurEpisodeId()

		arg_20_0:focusEpisodeItem(var_20_0 + 1, var_20_1, false, true)
	end
end

function var_0_0._refreshTask(arg_21_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a6XugoujiTask, 0) then
		arg_21_0._taskAnimator:Play(UIAnimationName.Loop, 0, 0)
	else
		arg_21_0._taskAnimator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function var_0_0.onDestroyView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.refreshTime, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.doNewEpisodeUnlockDisplay, arg_22_0)

	if arg_22_0._drag then
		arg_22_0._drag:RemoveDragBeginListener()
		arg_22_0._drag:RemoveDragEndListener()

		arg_22_0._drag = nil
	end

	if arg_22_0._touch then
		arg_22_0._touch:RemoveClickDownListener()

		arg_22_0._touch = nil
	end
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.refreshTime, arg_23_0)
end

return var_0_0
