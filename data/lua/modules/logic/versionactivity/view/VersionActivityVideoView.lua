module("modules.logic.versionactivity.view.VersionActivityVideoView", package.seeall)

slot0 = class("VersionActivityVideoView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_block")
	slot0._gorightbtn = gohelper.findChild(slot0.viewGO, "#go_rightbtn")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rightbtn/#btn_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnblockOnClick(slot0)
	gohelper.setActive(slot0._gorightbtn, true)
	TaskDispatcher.cancelTask(slot0.hideRightBtn, slot0)
	TaskDispatcher.runDelay(slot0.hideRightBtn, slot0, 10)
end

function slot0._btnskipOnClick(slot0)
	slot0._videoPlayer:Pause()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:closeThis()
	end, function ()
		uv0._videoPlayer:Play()
	end)
end

function slot0._editableInitView(slot0)
	slot0:hideRightBtn()

	slot0._goVideoPlayer = gohelper.findChild(slot0.viewGO, "VideoPlayer")
	slot0._videoPlayer = slot0._goVideoPlayer:GetComponent(typeof(ZProj.AvProUGUIPlayer))
	slot0._displauUGUI = slot0._goVideoPlayer:GetComponent(typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	slot0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	if SettingsModel.instance:getVideoEnabled() == false then
		slot0._videoPlayer = AvProUGUIPlayer_adjust.instance
	end

	slot0._videoPlayer:AddDisplayUGUI(slot0._displauUGUI)
	slot0._videoPlayer:SetEventListener(slot0._videoStatusUpdate, slot0)
	NavigateMgr.instance:addEscape(ViewName.VersionActivityVideoView, slot0._btnskipOnClick, slot0)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:closeThis()
	end
end

function slot0.initViewParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.firstEnter = slot0.viewParam.firstEnter
	slot0.activityIdList = slot0.viewParam.activityIdList
	slot0.doneOpenViewName = slot0.viewParam.doneOpenViewName
	slot0.closeCallback = slot0.viewParam.closeCallback
	slot0.closeCallbackObj = slot0.viewParam.closeCallbackObj
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initViewParam()

	if not lua_activity105.configDict[slot0.actId] or string.nilorempty(slot1.pv) then
		logError(string.format("not found actId ：%s config pv", slot0.actId))
		slot0:closeThis()
	end

	slot0._videoPlayer:LoadMedia(langVideoUrl(slot1.pv))
	slot0._videoPlayer:Play()
end

function slot0.hideRightBtn(slot0)
	gohelper.setActive(slot0._gorightbtn, false)
end

function slot0.closeThis(slot0)
	if not slot0.firstEnter then
		slot0:_closeThis()

		return
	end

	for slot4, slot5 in ipairs(slot0.activityIdList) do
		if ActivityHelper.getActivityStatus(slot5) == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(slot5)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivityEnum.EnterViewActIdList, slot0.onReceiveReply, slot0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	slot0.closeCallback(slot0.closeCallbackObj)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == slot0.doneOpenViewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

		slot0.openViewDone = true

		slot0:_checkCanCloseThisView()
	end
end

function slot0.onReceiveReply(slot0)
	slot0.receiveMsgDone = true

	slot0:_checkCanCloseThisView()
end

function slot0._checkCanCloseThisView(slot0)
	if slot0.openViewDone and slot0.receiveMsgDone then
		slot0:_closeThis()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
	end
end

function slot0._closeThis(slot0)
	uv0.super.closeThis(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._videoPlayer:Stop()
		end

		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
