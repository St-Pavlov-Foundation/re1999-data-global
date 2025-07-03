module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelView", package.seeall)

local var_0_0 = class("LengZhou6LevelView", BaseView)
local var_0_1 = -300
local var_0_2 = 0.15

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gostoryStages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._gostage1 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage1")
	arg_1_0._gostage2 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage2")
	arg_1_0._gostage3 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage3")
	arg_1_0._gostage4 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage4")
	arg_1_0._gostage5 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage5")
	arg_1_0._gostage6 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage6")
	arg_1_0._gostage7 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage7")
	arg_1_0._gostage8 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage8")
	arg_1_0._gostage9 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage9")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._touch:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._touch:RemoveClickDownListener()
end

function var_0_0._btnTaskOnClick(arg_4_0)
	LengZhou6Controller.instance:openTaskView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._taskAnimator = gohelper.findChild(arg_5_0.viewGO, "#btn_Task/ani"):GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_5_0._goreddot, RedDotEnum.DotNode.V2a7LengZhou6Task, nil, arg_5_0._refreshRedDot, arg_5_0)

	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._gostoryPath)
	arg_5_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_5_0._gostoryPath)
	arg_5_0._scrollStory = arg_5_0._gostoryPath:GetComponent(gohelper.Type_ScrollRect)
	arg_5_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_5_0._gostoryPath, DungeonMapEpisodeAudio, arg_5_0._scrollStory)
	arg_5_0._transstoryScroll = arg_5_0._gostoryScroll.transform
	arg_5_0._ani = arg_5_0.viewGO:GetComponent(gohelper.Type_Animator)

	local var_5_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_5_0._offsetX = (var_5_0 - var_0_1) / 2
	arg_5_0.minContentAnchorX = -recthelper.getWidth(arg_5_0._transstoryScroll) + var_5_0
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = LengZhou6Model.instance:getAct190Id()

	arg_6_0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnClickEpisode, arg_6_0._onClickEpisode, arg_6_0)
	arg_6_0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnReceiveEpisodeInfo, arg_6_0._refreshEpisode, arg_6_0)
	arg_6_0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnFinishEpisode, arg_6_0._onFinishEpisode, arg_6_0)
	arg_6_0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnClickCloseGameView, arg_6_0._onClickCloseGameView, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0.showLeftTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:showLeftTime()
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_open)
	TaskDispatcher.runDelay(arg_6_0.updateStage, arg_6_0, 0.5)
	arg_6_0:initStage()
end

function var_0_0.initStage(arg_7_0)
	arg_7_0._allEpisodeItemList = arg_7_0:getUserDataTb_()

	local var_7_0 = LengZhou6Model.instance:getAllEpisodeIds()
	local var_7_1 = arg_7_0.viewContainer:getSetting().otherRes[1]

	for iter_7_0 = 1, #var_7_0 do
		local var_7_2 = var_7_0[iter_7_0]
		local var_7_3 = arg_7_0["_gostage" .. iter_7_0]
		local var_7_4 = arg_7_0:getResInst(var_7_1, var_7_3, var_7_2)
		local var_7_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_4, LengZhou6LevelItem)

		var_7_5:initEpisodeId(iter_7_0, var_7_2)
		table.insert(arg_7_0._allEpisodeItemList, var_7_5)
		gohelper.setActive(var_7_4, false)
	end
end

function var_0_0._refreshEpisode(arg_8_0)
	return
end

function var_0_0.updateStage(arg_9_0)
	arg_9_0:focusNewestLevelItem()
	TaskDispatcher.cancelTask(arg_9_0.updateStage, arg_9_0)

	if arg_9_0._allEpisodeItemList ~= nil then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._allEpisodeItemList) do
			iter_9_1:updateInfo(false)
		end
	end
end

function var_0_0.showLeftTime(arg_10_0)
	arg_10_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(LengZhou6Model.instance:getCurActId())
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.showLeftTime, arg_11_0)
end

function var_0_0._refreshRedDot(arg_12_0, arg_12_1)
	arg_12_1:defaultRefreshDot()

	local var_12_0 = arg_12_1.show

	arg_12_0._taskAnimator:Play(var_12_0 and "loop" or "idle")
end

function var_0_0._onDragBegin(arg_13_0)
	arg_13_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_14_0)
	arg_14_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDown(arg_15_0)
	arg_15_0._audioScroll:onClickDown()
end

function var_0_0._onClickEpisode(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.actId ~= arg_16_1 then
		return
	end

	arg_16_0:onFocusEnd(arg_16_2)
end

function var_0_0._onClickCloseGameView(arg_17_0)
	arg_17_0:playOpen1Ani()
end

function var_0_0.playOpen1Ani(arg_18_0)
	if arg_18_0._ani then
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_open)
		arg_18_0._ani:Play("open1", 0, 0)
	end
end

function var_0_0._onFinishEpisode(arg_19_0, arg_19_1)
	if arg_19_1 == nil then
		return
	end

	arg_19_0._waitFinishAnimEpisode = arg_19_1

	arg_19_0:playOpen1Ani()
	TaskDispatcher.runDelay(arg_19_0._onFinishEpisode2, arg_19_0, 1)
end

function var_0_0._onFinishEpisode2(arg_20_0)
	arg_20_0:focusNewestLevelItem()
	arg_20_0:playEpisodeFinishAnim()
	UIBlockHelper.instance:endBlock(LengZhou6Enum.BlockKey.OneClickResetLevel)
end

function var_0_0.getNewestLevelItem(arg_21_0)
	local var_21_0 = arg_21_0._allEpisodeItemList[1]
	local var_21_1 = LengZhou6Model.instance:getNewestEpisodeId(arg_21_0.actId)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._allEpisodeItemList) do
		if iter_21_1._episodeId == var_21_1 then
			var_21_0 = iter_21_1

			break
		end
	end

	return var_21_0
end

function var_0_0.focusNewestLevelItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getNewestLevelItem()

	if not var_22_0 then
		return
	end

	local var_22_1 = recthelper.getAnchorX(var_22_0.viewGO.transform.parent)
	local var_22_2 = arg_22_0._offsetX - var_22_1

	if var_22_2 > 0 then
		var_22_2 = 0
	elseif var_22_2 < arg_22_0.minContentAnchorX then
		var_22_2 = arg_22_0.minContentAnchorX
	end

	ZProj.TweenHelper.DOAnchorPosX(arg_22_0._transstoryScroll, var_22_2, arg_22_1 or 0, arg_22_0.onFocusEnd, arg_22_0)
end

function var_0_0.playEpisodeFinishAnim(arg_23_0)
	if not arg_23_0._waitFinishAnimEpisode then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._allEpisodeItemList) do
		if iter_23_1._episodeId == arg_23_0._waitFinishAnimEpisode then
			arg_23_0._finishEpisodeIndex = iter_23_0

			if not iter_23_1:finishStateEnd() then
				iter_23_1:updateInfo(true)
				TaskDispatcher.runDelay(arg_23_0._playEpisodeUnlockAnim, arg_23_0, var_0_2)
			else
				iter_23_1:updateInfo(false)

				arg_23_0._finishEpisodeIndex = nil
			end
		end
	end

	arg_23_0._waitFinishAnimEpisode = nil
end

function var_0_0._playEpisodeUnlockAnim(arg_24_0)
	if not arg_24_0._finishEpisodeIndex then
		return
	end

	local var_24_0 = arg_24_0._allEpisodeItemList[arg_24_0._finishEpisodeIndex + 1]

	if var_24_0 then
		var_24_0:updateInfo(true)
	end

	arg_24_0._finishEpisodeIndex = nil
end

function var_0_0.onFocusEnd(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	LengZhou6Controller.instance:enterEpisode(arg_25_1)
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.updateStage, arg_26_0)
end

return var_0_0
