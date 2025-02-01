module("modules.logic.login.view.NicknameView", package.seeall)

slot0 = class("NicknameView", BaseView)

function slot0.onInitView(slot0)
	slot0._goname = gohelper.findChild(slot0.viewGO, "#go_name")
	slot0._inputname = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_name/#input_name")
	slot0._goplaceholdertext = gohelper.findChildText(slot0.viewGO, "#go_name/#input_name/PlaceholderText")
	slot0._simageinputnamebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_name/#input_name/#simage_inputnamebg")
	slot0._btnok = gohelper.findChildClick(slot0.viewGO, "#go_name/#btn_ok")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_name/#btn_ok/#go_normal")
	slot0._imagemask = gohelper.findChildImage(slot0.viewGO, "#image_mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._inputname:AddOnEndEdit(slot0._onInputNameEndEdit, slot0)
	slot0._inputname:AddOnValueChanged(slot0._inputValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._inputname:RemoveOnEndEdit()
	slot0._inputname:RemoveOnValueChanged()
end

function slot0._btnokOnClick(slot0)
	slot0:_checkLimit()
	gohelper.setActive(slot0._gonormal, false)

	if string.nilorempty(slot0._inputname:GetText()) or slot0._isChangePlayerName then
		return
	end

	slot0._nickName = slot1

	ViewMgr.instance:openView(ViewName.NicknameConfirmView, {
		name = slot1,
		guideId = slot0.guideId,
		stepId = slot0.stepId
	})
end

function slot0._checkLimit(slot0)
	slot1 = slot0._inputname:GetText()

	slot0._inputname:SetText(GameUtil.utf8sub(slot1, 1, math.min(GameUtil.utf8len(slot1), CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit))))
end

function slot0._editableInitView(slot0)
	slot2 = slot0:getResInst(AvProMgr.instance:getNicknameUrl(), gohelper.findChild(slot0.viewGO, "#videobg"))

	if SettingsModel.instance:getVideoEnabled() == false then
		slot0._uguiListPlayer = AvProUGUIListPlayer_adjust.New()
		slot0._listPlayer = PlaylistMediaPlayer_adjust.New()
	else
		slot0._videoBg = gohelper.findChildComponent(slot2, "#videobg", typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
		slot0._videoBg.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
		slot0._listPlayer = gohelper.findChildComponent(slot2, "#list_player", typeof(RenderHeads.Media.AVProVideo.PlaylistMediaPlayer))
		slot0._uguiListPlayer = gohelper.findChildComponent(slot2, "#list_player", typeof(ZProj.AvProUGUIListPlayer))
	end

	slot0._uguiListPlayer:SetEventListener(slot0._onVideoPlayEvent, slot0)
	slot0._uguiListPlayer:SetMediaPath(SLFramework.FrameworkSettings.GetAssetFullPathForWWW(langVideoUrl("make_name_start")), 0)
	slot0._uguiListPlayer:SetMediaPath(SLFramework.FrameworkSettings.GetAssetFullPathForWWW(langVideoUrl("make_name_loop")), 1)
	gohelper.setActive(slot0._goname, false)
	gohelper.setActive(slot0._gonormal, false)

	slot0._isPressSureBtn = false
	slot0._inputnameTMP = slot0._inputname:GetComponent("TMP_InputField")
	slot0._inputNameClickListener = SLFramework.UGUI.UIClickListener.Get(slot0._inputname.gameObject)

	slot0._inputNameClickListener:AddClickListener(slot0._hidePlaceholderText, slot0)
	slot0._simageinputnamebg:LoadImage(ResUrl.getNickNameIcon("mingmingzi_001"))
	slot0:_playStartVideo()
	gohelper.addUIClickAudio(slot0._btnok.gameObject, AudioEnum.UI.Play_UI_Copies)
	slot0:_checkIsGamepad()
end

function slot0._checkIsGamepad(slot0)
	if SDKNativeUtil.isGamePad() then
		slot0._inputname:SetText(luaLang("mainrolename"))

		slot0._inputname.inputField.enabled = false

		gohelper.setActive(slot0._gonormal, true)
	end
end

function slot0._hidePlaceholderText(slot0)
	gohelper.setAsFirstSibling(slot0._simageinputnamebg.gameObject)
	ZProj.UGUIHelper.SetColorAlpha(slot0._goplaceholdertext, 0.5)
end

function slot0._onInputNameEndEdit(slot0)
	ZProj.UGUIHelper.SetColorAlpha(slot0._goplaceholdertext, 1)
	slot0:_checkLimit()
end

function slot0._playStartVideo(slot0)
	slot0._listPlayer:Play()
	TaskDispatcher.runDelay(slot0._showInputUI, slot0, 2.1)
	AudioMgr.instance:trigger(AudioEnum.CriWare.Play_Name_Start)
	TaskDispatcher.runDelay(slot0._delayShowNameUI, slot0, 5)

	if SettingsModel.instance:getVideoCompatible() and BootNativeUtil.isWindows() then
		TaskDispatcher.runDelay(slot0._onJumpNext, slot0, 2.4)
	end
end

function slot0._onJumpNext(slot0)
	slot0._listPlayer:JumpToItem(1)
end

function slot0._showInputUI(slot0)
	gohelper.setActive(slot0._goname, true)
	slot0._uguiListPlayer:SetMediaPath(SLFramework.FrameworkSettings.GetAssetFullPathForWWW(langVideoUrl("make_name_end")), 0)
end

function slot0._delayShowNameUI(slot0)
	logError("播放起名字start视频超时了!")
	gohelper.setActive(slot0._goname, true)
end

function slot0._playEndVideo(slot0)
	logNormal("NicknameView:_playEndVideo() ---------------------1")
	slot0._listPlayer:JumpToItem(0)
	AudioMgr.instance:trigger(AudioEnum.CriWare.Play_Name_Complete)
	TaskDispatcher.runDelay(slot0._delayCloseView, slot0, 8)
end

function slot0._onVideoPlayEvent(slot0, slot1, slot2, slot3)
	slot4 = string.split(slot1, "/")
	slot5 = slot4[#slot4]

	logNormal("NicknameView:_onVideoPlayEvent, videoName = " .. slot5 .. " status = " .. AvProEnum.getPlayerStatusEnumName(slot2) .. " errorCode = " .. AvProEnum.getErrorCodeEnumName(slot3))

	if slot5 == "make_name_start.mp4" and slot2 == AvProEnum.PlayerStatus.Started then
		TaskDispatcher.cancelTask(slot0._delayShowNameUI, slot0)
	end

	if slot5 == "make_name_end.mp4" then
		if slot3 ~= AvProEnum.ErrorCode.None then
			slot0._listPlayer:Stop()
			TaskDispatcher.cancelTask(slot0._delayCloseView, slot0)
			gohelper.setActive(slot0._goname, false)
			slot0:closeThis()
		end

		if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
			TaskDispatcher.cancelTask(slot0._delayCloseView, slot0)
			gohelper.setActive(slot0._goname, false)
			slot0:closeThis()
		end
	end
end

function slot0._delayCloseView(slot0)
	logError("播放起名字end视频超时了")
	slot0._listPlayer:Stop()
	gohelper.setActive(slot0._goname, false)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		slot0.guideId = slot0.viewParam.guideId
		slot0.stepId = slot0.viewParam.stepId
		slot0.fadeTime = slot0.viewParam.viewParam
	end

	slot0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, slot0._onChangePlayerName, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.NickNameConfirmNo, slot0._onConfirmNo, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.NickNameConfirmYes, slot0._onConfirmYes, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	AudioMgr.instance:trigger(AudioEnum.Bgm.play_ui_nameitsfx_music)
end

function slot0._onConfirmNo(slot0)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._goname, true)

	slot0._inputnameTMP.interactable = true
end

function slot0._onConfirmYes(slot0)
	slot0._inputnameTMP.interactable = false

	gohelper.setActive(slot0._goname, false)
end

function slot0._inputValueChanged(slot0)
	slot2 = string.nilorempty(slot0._inputname:GetText())

	gohelper.setActive(slot0._gonormal, not slot2)

	if not slot2 then
		slot0:_checkLimit()
	end
end

function slot0._onChangePlayerName(slot0)
	slot0._isChangePlayerName = true

	TaskDispatcher.runDelay(slot0._playStory, slot0, 0.333)
end

function slot0._playStory(slot0)
	slot1 = nil
	StoryModel.instance.skipFade = true
	module_views.StoryBackgroundView.viewType = ViewType.Normal

	StoryController.instance:playStory(slot0:_specialName(string.lower(slot0._nickName)) and 100012 or 100011, {
		hideBtn = true
	}, slot0._playStoryEnd, slot0)

	slot3 = StatModel.instance:generateRoleInfo()

	SDKMgr.instance:updateRole(slot3)
	SDKMgr.instance:enterGame(slot3)
	SDKChannelEventModel.instance:nickName()
end

function slot0._specialName(slot0, slot1)
	for slot7, slot8 in ipairs(string.split(CommonConfig.instance:getConstStr(ConstEnum.NickName), "#")) do
		if slot1 == slot8 then
			return true
		end
	end
end

function slot0._playStoryEnd(slot0)
	StoryModel.instance.skipFade = false
	module_views.StoryBackgroundView.viewType = ViewType.Full

	slot0:_playEndVideo()
end

function slot0._fade(slot0)
	gohelper.setActive(slot0._imagemask.gameObject, true)
	ZProj.TweenHelper.DoFade(slot0._imagemask, 0, 1, slot0.fadeTime or 2, function ()
		uv0:closeThis()
	end)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)
	slot0._inputname:RemoveOnValueChanged()
	slot0._btnok:RemoveClickListener()

	if slot0._inputNameClickListener then
		slot0._inputNameClickListener:RemoveClickListener()

		slot0._inputNameClickListener = nil
	end

	TaskDispatcher.cancelTask(slot0._delayShowNameUI, slot0)
	TaskDispatcher.cancelTask(slot0._delayCloseView, slot0)
	TaskDispatcher.cancelTask(slot0._playStory, slot0)
	TaskDispatcher.cancelTask(slot0._showInputUI, slot0)
	TaskDispatcher.cancelTask(slot0._onJumpNext, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageinputnamebg:UnLoadImage()
	slot0._uguiListPlayer:Clear()

	slot0._uguiListPlayer = nil
	slot0._listPlayer = nil
end

return slot0
