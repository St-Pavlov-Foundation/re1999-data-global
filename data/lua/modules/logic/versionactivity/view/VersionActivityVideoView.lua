module("modules.logic.versionactivity.view.VersionActivityVideoView", package.seeall)

local var_0_0 = class("VersionActivityVideoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_block")
	arg_1_0._gorightbtn = gohelper.findChild(arg_1_0.viewGO, "#go_rightbtn")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rightbtn/#btn_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnblockOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gorightbtn, true)
	TaskDispatcher.cancelTask(arg_4_0.hideRightBtn, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.hideRightBtn, arg_4_0, 10)
end

function var_0_0._btnskipOnClick(arg_5_0)
	arg_5_0._videoPlayer:Pause()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		arg_5_0:closeThis()
	end, function()
		arg_5_0._videoPlayer:Play()
	end)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:hideRightBtn()

	arg_8_0._goVideoPlayer = gohelper.findChild(arg_8_0.viewGO, "VideoPlayer")
	arg_8_0._videoPlayer = arg_8_0._goVideoPlayer:GetComponent(typeof(ZProj.AvProUGUIPlayer))
	arg_8_0._displauUGUI = arg_8_0._goVideoPlayer:GetComponent(typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	arg_8_0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	if SettingsModel.instance:getVideoEnabled() == false then
		arg_8_0._videoPlayer = AvProUGUIPlayer_adjust.instance
	end

	arg_8_0._videoPlayer:AddDisplayUGUI(arg_8_0._displauUGUI)
	arg_8_0._videoPlayer:SetEventListener(arg_8_0._videoStatusUpdate, arg_8_0)
	NavigateMgr.instance:addEscape(ViewName.VersionActivityVideoView, arg_8_0._btnskipOnClick, arg_8_0)
end

function var_0_0._videoStatusUpdate(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_9_0:closeThis()
	end
end

function var_0_0.initViewParam(arg_10_0)
	arg_10_0.actId = arg_10_0.viewParam.actId
	arg_10_0.firstEnter = arg_10_0.viewParam.firstEnter
	arg_10_0.activityIdList = arg_10_0.viewParam.activityIdList
	arg_10_0.doneOpenViewName = arg_10_0.viewParam.doneOpenViewName
	arg_10_0.closeCallback = arg_10_0.viewParam.closeCallback
	arg_10_0.closeCallbackObj = arg_10_0.viewParam.closeCallbackObj
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:initViewParam()

	local var_12_0 = lua_activity105.configDict[arg_12_0.actId]

	if not var_12_0 or string.nilorempty(var_12_0.pv) then
		logError(string.format("not found actId ：%s config pv", arg_12_0.actId))
		arg_12_0:closeThis()
	end

	arg_12_0._videoPlayer:LoadMedia(langVideoUrl(var_12_0.pv))
	arg_12_0._videoPlayer:Play()
end

function var_0_0.hideRightBtn(arg_13_0)
	gohelper.setActive(arg_13_0._gorightbtn, false)
end

function var_0_0.closeThis(arg_14_0)
	if not arg_14_0.firstEnter then
		arg_14_0:_closeThis()

		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.activityIdList) do
		if ActivityHelper.getActivityStatus(iter_14_1) == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(iter_14_1)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivityEnum.EnterViewActIdList, arg_14_0.onReceiveReply, arg_14_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_14_0.onOpenViewFinish, arg_14_0)
	arg_14_0.closeCallback(arg_14_0.closeCallbackObj)
end

function var_0_0.onOpenViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.doneOpenViewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_15_0.onOpenViewFinish, arg_15_0)

		arg_15_0.openViewDone = true

		arg_15_0:_checkCanCloseThisView()
	end
end

function var_0_0.onReceiveReply(arg_16_0)
	arg_16_0.receiveMsgDone = true

	arg_16_0:_checkCanCloseThisView()
end

function var_0_0._checkCanCloseThisView(arg_17_0)
	if arg_17_0.openViewDone and arg_17_0.receiveMsgDone then
		arg_17_0:_closeThis()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
	end
end

function var_0_0._closeThis(arg_18_0)
	var_0_0.super.closeThis(arg_18_0)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_20_0._videoPlayer:Stop()
		end

		arg_20_0._videoPlayer:Clear()

		arg_20_0._videoPlayer = nil
	end
end

return var_0_0
