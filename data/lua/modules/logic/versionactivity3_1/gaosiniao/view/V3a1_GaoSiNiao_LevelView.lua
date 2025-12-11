local var_0_0 = SLFramework.AnimatorPlayer

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_LevelView", package.seeall)

local var_0_1 = class("V3a1_GaoSiNiao_LevelView", BaseView)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageStageBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_StageBG")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_title/#simage_title")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/image_LimitTimeBG/#txt_limittime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnEndless = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Endless")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnEndless:AddClickListener(arg_2_0._btnEndlessOnClick, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnEndless:RemoveClickListener()
end

function var_0_1.ctor(arg_4_0, ...)
	var_0_1.super.ctor(arg_4_0, ...)

	arg_4_0._itemObjList = {}
end

function var_0_1._actId(arg_5_0)
	return arg_5_0.viewContainer:actId()
end

function var_0_1._taskType(arg_6_0)
	return arg_6_0.viewContainer:taskType()
end

function var_0_1._enterGame(arg_7_0, arg_7_1)
	arg_7_0.viewContainer:enterGame(arg_7_1)
end

function var_0_1._btntaskOnClick(arg_8_0)
	local var_8_0 = {
		actId = arg_8_0:_actId(),
		taskType = arg_8_0:_taskType()
	}

	ViewMgr.instance:openView(ViewName.V3a1_GaoSiNiao_TaskView, var_8_0)
end

function var_0_1._btnEndlessOnClick(arg_9_0)
	local var_9_0 = arg_9_0:_spCO().episodeId

	arg_9_0:_enterGame(var_9_0)
end

function var_0_1._onReceiveAct210EpisodePush(arg_10_0)
	return
end

function var_0_1._onReceiveGetAct210InfoReply(arg_11_0)
	arg_11_0:onUpdateParam()
end

function var_0_1._onReceiveAct210FinishEpisodeReply(arg_12_0, arg_12_1)
	arg_12_0:onUpdateParam()
end

function var_0_1._editableInitView(arg_13_0)
	arg_13_0._btnEndlessGo = arg_13_0._btnEndless.gameObject
	arg_13_0._gotaskani = gohelper.findChild(arg_13_0.viewGO, "#btn_task/ani")
	arg_13_0._animTask = arg_13_0._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	local var_13_0 = "stage%s/Point/#go_StageItemContainer"

	arg_13_0._goStageItemContainerList = arg_13_0:getUserDataTb_()

	local var_13_1 = 0

	repeat
		var_13_1 = var_13_1 + 1

		local var_13_2 = gohelper.findChild(arg_13_0._gostages, string.format(var_13_0, var_13_1))
		local var_13_3 = gohelper.isNil(var_13_2)

		if not var_13_3 then
			table.insert(arg_13_0._goStageItemContainerList, var_13_2)
		end
	until var_13_3

	arg_13_0._animatorPlayerPath = var_0_0.Get(arg_13_0._gopath)
	arg_13_0._animatorPlayerEndless = var_0_0.Get(arg_13_0._btnEndlessGo)

	local var_13_4 = 0

	RedDotController.instance:addRedDot(arg_13_0._goreddotreward, RedDotEnum.DotNode.V3a1GaoSiNiaoTask, var_13_4)
	arg_13_0:setActive_btnEndlessGo(false)
end

function var_0_1._clearCacheListData(arg_14_0)
	arg_14_0._tmpSPCO = nil
	arg_14_0._tmpDataList = nil
end

function var_0_1.onUpdateParam(arg_15_0)
	arg_15_0:_clearCacheListData()
	arg_15_0:_refreshLeftTime()
	arg_15_0:_refresh()
	TaskDispatcher.cancelTask(arg_15_0._refreshLeftTime, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0._refreshLeftTime, arg_15_0, TimeUtil.OneMinuteSecond)
end

function var_0_1.onOpen(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_open)
	arg_16_0:onUpdateParam()
	arg_16_0:addEventCb(GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveAct210EpisodePush, arg_16_0._onReceiveAct210EpisodePush, arg_16_0)
	arg_16_0:addEventCb(GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveGetAct210InfoReply, arg_16_0._onReceiveGetAct210InfoReply, arg_16_0)
	arg_16_0:addEventCb(GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply, arg_16_0._onReceiveAct210FinishEpisodeReply, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_16_0._onCloseView, arg_16_0)
end

function var_0_1.onOpenFinish(arg_17_0)
	GameUtil.onDestroyViewMember(arg_17_0, "_onOpenFinishFlow")

	arg_17_0._onOpenFinishFlow = V3a1_GaoSiNiao_LevelView_OpenFinishFlow.New()

	arg_17_0._onOpenFinishFlow:start(arg_17_0)
end

function var_0_1.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._refreshLeftTime, arg_18_0)
	GameUtil.onDestroyViewMember(arg_18_0, "_onOpenFinishFlow")
end

function var_0_1.onDestroyView(arg_19_0)
	GameUtil.onDestroyViewMember(arg_19_0, "_onOpenFinishFlow")
	TaskDispatcher.cancelTask(arg_19_0._refreshLeftTime, arg_19_0)
	GameUtil.onDestroyViewMemberList(arg_19_0, "_itemObjList")
end

function var_0_1._refresh(arg_20_0)
	arg_20_0:_refreshItemList()
	arg_20_0:_refreshTask()
end

function var_0_1._refreshEndlessBtn(arg_21_0)
	local var_21_0 = arg_21_0.viewContainer:isSpEpisodeOpen()

	arg_21_0:setActive_btnEndlessGo(var_21_0)
end

function var_0_1.setActive_btnEndlessGo(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._btnEndlessGo, arg_22_1)
end

function var_0_1._refreshLeftTime(arg_23_0)
	arg_23_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_23_0:_actId())
end

function var_0_1.onStageItemClick(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:episodeId()

	if not arg_24_1:isEpisodeOpen() then
		GameFacade.showToast(ToastEnum.Act163LevelLocked)

		return
	end

	arg_24_0:_enterGame(var_24_0)
end

function var_0_1._spCO(arg_25_0)
	if not arg_25_0._tmpSPCO then
		arg_25_0:_getDataList()
	end

	return arg_25_0._tmpSPCO
end

function var_0_1._getDataList(arg_26_0)
	if not arg_26_0._tmpDataList then
		local var_26_0, var_26_1 = arg_26_0.viewContainer:getEpisodeCOList()

		arg_26_0._tmpDataList = var_26_0
		arg_26_0._tmpSPCO = var_26_1 and var_26_1[1] or nil
	end

	return arg_26_0._tmpDataList
end

function var_0_1._refreshItemList(arg_27_0)
	local var_27_0 = arg_27_0:_getDataList()
	local var_27_1 = #arg_27_0._goStageItemContainerList
	local var_27_2 = arg_27_0.viewContainer:currentEpisodeIdToPlay()

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_3

		if var_27_1 < iter_27_0 then
			break
		end

		local var_27_4 = arg_27_0._goStageItemContainerList[iter_27_0]

		if iter_27_0 > #arg_27_0._itemObjList then
			var_27_3 = arg_27_0:_create_V3a1_GaoSiNiao_LevelViewStageItem(var_27_4, iter_27_0)

			table.insert(arg_27_0._itemObjList, var_27_3)
		else
			var_27_3 = arg_27_0._itemObjList[iter_27_0]
		end

		var_27_3:onUpdateMO(iter_27_1)

		local var_27_5 = var_27_3:isEpisodeOpen()
		local var_27_6 = var_27_2 == var_27_3:episodeId()

		if var_27_5 and var_27_6 then
			var_27_5 = var_27_3:hasPlayedUnlockedAnimPath()
		end

		var_27_3:setActive(var_27_5)
		var_27_3:setActive_goCurrent(var_27_6)
	end

	local var_27_7 = math.min(var_27_1, #arg_27_0._itemObjList)

	for iter_27_2 = #var_27_0 + 1, var_27_7 do
		arg_27_0._itemObjList[iter_27_2]:setActive(false)
	end
end

function var_0_1._create_V3a1_GaoSiNiao_LevelViewStageItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.viewContainer:getSetting().otherRes.v3a1_gaosiniao_levelviewstageitem
	local var_28_1 = arg_28_0.viewContainer:getResInst(var_28_0, arg_28_1, V3a1_GaoSiNiao_LevelViewStageItem.__cname)
	local var_28_2 = V3a1_GaoSiNiao_LevelViewStageItem.New({
		parent = arg_28_0,
		baseViewContainer = arg_28_0.viewContainer
	})

	var_28_2:setIndex(arg_28_2)
	var_28_2:init(var_28_1)

	return var_28_2
end

local var_0_2 = "level"

local function var_0_3(arg_29_0)
	return var_0_2 .. tostring(arg_29_0)
end

function var_0_1._playAnim_Path(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0._animatorPlayerPath:Play(arg_30_1, arg_30_2 or function()
		return
	end, arg_30_3)
end

function var_0_1.playAnim_PathUnlock(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_level)

	local var_32_0 = var_0_3(arg_32_1)

	arg_32_0:_playAnim_Path(var_32_0, arg_32_2, arg_32_3)
end

function var_0_1.playAnim_PathIdle(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_1 < 0 then
		if arg_33_2 then
			arg_33_2(arg_33_3)
		end

		return
	end

	local var_33_0 = var_0_3(arg_33_1) .. "_idle"

	arg_33_0:_playAnim_Path(var_33_0, arg_33_2, arg_33_3)
end

function var_0_1._playAnim_Endless(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0._animatorPlayerEndless:Play(arg_34_1, arg_34_2 or function()
		return
	end, arg_34_3)
end

function var_0_1.playAnim_EndlessIdle(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:setActive_btnEndlessGo(true)
	arg_36_0:_playAnim_Endless(UIAnimationName.Idle, arg_36_1, arg_36_2)
end

function var_0_1.playAnim_EndlessUnlock(arg_37_0, arg_37_1, arg_37_2)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_fenghe)
	arg_37_0:setActive_btnEndlessGo(true)
	arg_37_0:_playAnim_Endless(UIAnimationName.Unlock, arg_37_1, arg_37_2)
end

function var_0_1._onCloseView(arg_38_0, arg_38_1)
	if arg_38_1 == ViewName.V3a1_GaoSiNiao_TaskView then
		arg_38_0:_onCloseTask()
	end
end

function var_0_1._refreshTask(arg_39_0)
	local var_39_0 = 0

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a1GaoSiNiaoTask, var_39_0) then
		arg_39_0._animTask:Play(UIAnimationName.Loop)
	else
		arg_39_0._animTask:Play(UIAnimationName.Idle, 0, 0)
	end
end

function var_0_1._onCloseTask(arg_40_0)
	arg_40_0:_refreshTask()
end

return var_0_1
