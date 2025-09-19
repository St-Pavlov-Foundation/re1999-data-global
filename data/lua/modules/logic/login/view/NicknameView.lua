module("modules.logic.login.view.NicknameView", package.seeall)

local var_0_0 = class("NicknameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_name")
	arg_1_0._inputname = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_name/#input_name")
	arg_1_0._goplaceholdertext = gohelper.findChildText(arg_1_0.viewGO, "#go_name/#input_name/PlaceholderText")
	arg_1_0._simageinputnamebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_name/#input_name/#simage_inputnamebg")
	arg_1_0._btnok = gohelper.findChildClick(arg_1_0.viewGO, "#go_name/#btn_ok")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_name/#btn_ok/#go_normal")
	arg_1_0._imagemask = gohelper.findChildImage(arg_1_0.viewGO, "#image_mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._inputname:AddOnEndEdit(arg_2_0._onInputNameEndEdit, arg_2_0)
	arg_2_0._inputname:AddOnValueChanged(arg_2_0._inputValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._inputname:RemoveOnEndEdit()
	arg_3_0._inputname:RemoveOnValueChanged()
end

function var_0_0._btnokOnClick(arg_4_0)
	arg_4_0:_checkLimit()

	local var_4_0 = arg_4_0._inputname:GetText()

	gohelper.setActive(arg_4_0._gonormal, false)

	if string.nilorempty(var_4_0) or arg_4_0._isChangePlayerName then
		return
	end

	arg_4_0._nickName = var_4_0

	local var_4_1 = {
		name = var_4_0,
		guideId = arg_4_0.guideId,
		stepId = arg_4_0.stepId
	}

	ViewMgr.instance:openView(ViewName.NicknameConfirmView, var_4_1)
end

function var_0_0._checkLimit(arg_5_0)
	local var_5_0 = arg_5_0._inputname:GetText()
	local var_5_1 = CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)
	local var_5_2 = GameUtil.utf8sub(var_5_0, 1, math.min(GameUtil.utf8len(var_5_0), var_5_1))

	arg_5_0._inputname:SetText(var_5_2)
end

function var_0_0._editableInitView(arg_6_0)
	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#videobg")
	local var_6_1 = arg_6_0:getResInst(AvProMgr.instance:getNicknameUrl(), var_6_0)

	if SettingsModel.instance:getVideoEnabled() == false then
		arg_6_0._uguiListPlayer = AvProUGUIListPlayer_adjust.New()
		arg_6_0._listPlayer = PlaylistMediaPlayer_adjust.New()
	else
		arg_6_0._videoBg = gohelper.findChildComponent(var_6_1, "#videobg", typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
		arg_6_0._videoBg.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
		arg_6_0._listPlayer = gohelper.findChildComponent(var_6_1, "#list_player", typeof(RenderHeads.Media.AVProVideo.PlaylistMediaPlayer))
		arg_6_0._uguiListPlayer = gohelper.findChildComponent(var_6_1, "#list_player", typeof(ZProj.AvProUGUIListPlayer))
	end

	arg_6_0._uguiListPlayer:SetEventListener(arg_6_0._onVideoPlayEvent, arg_6_0)
	arg_6_0._uguiListPlayer:SetMediaPath(langVideoUrl("make_name_start"), 0)
	arg_6_0._uguiListPlayer:SetMediaPath(langVideoUrl("make_name_loop"), 1)
	gohelper.setActive(arg_6_0._goname, false)
	gohelper.setActive(arg_6_0._gonormal, false)

	arg_6_0._isPressSureBtn = false
	arg_6_0._inputnameTMP = arg_6_0._inputname:GetComponent("TMP_InputField")
	arg_6_0._inputNameClickListener = SLFramework.UGUI.UIClickListener.Get(arg_6_0._inputname.gameObject)

	arg_6_0._inputNameClickListener:AddClickListener(arg_6_0._hidePlaceholderText, arg_6_0)
	arg_6_0._simageinputnamebg:LoadImage(ResUrl.getNickNameIcon("mingmingzi_001"))
	arg_6_0:_playStartVideo()
	gohelper.addUIClickAudio(arg_6_0._btnok.gameObject, AudioEnum.UI.Play_UI_Copies)
	arg_6_0:_checkIsGamepad()
end

function var_0_0._checkIsGamepad(arg_7_0)
	if SDKNativeUtil.isGamePad() then
		arg_7_0._inputname:SetText(luaLang("mainrolename"))

		arg_7_0._inputname.inputField.enabled = false

		gohelper.setActive(arg_7_0._gonormal, true)
	end
end

function var_0_0._hidePlaceholderText(arg_8_0)
	gohelper.setAsFirstSibling(arg_8_0._simageinputnamebg.gameObject)
	ZProj.UGUIHelper.SetColorAlpha(arg_8_0._goplaceholdertext, 0.5)
end

function var_0_0._onInputNameEndEdit(arg_9_0)
	ZProj.UGUIHelper.SetColorAlpha(arg_9_0._goplaceholdertext, 1)
	arg_9_0:_checkLimit()
end

function var_0_0._playStartVideo(arg_10_0)
	arg_10_0._listPlayer:Play()
	TaskDispatcher.runDelay(arg_10_0._showInputUI, arg_10_0, 2.1)
	AudioMgr.instance:trigger(AudioEnum.CriWare.Play_Name_Start)
	TaskDispatcher.runDelay(arg_10_0._delayShowNameUI, arg_10_0, 5)

	if SettingsModel.instance:getVideoCompatible() and BootNativeUtil.isWindows() then
		TaskDispatcher.runDelay(arg_10_0._onJumpNext, arg_10_0, 2.4)
	end
end

function var_0_0._onJumpNext(arg_11_0)
	arg_11_0._listPlayer:JumpToItem(1)
end

function var_0_0._showInputUI(arg_12_0)
	gohelper.setActive(arg_12_0._goname, true)
	arg_12_0._uguiListPlayer:SetMediaPath(langVideoUrl("make_name_end"), 0)
end

function var_0_0._delayShowNameUI(arg_13_0)
	logError("播放起名字start视频超时了!")
	gohelper.setActive(arg_13_0._goname, true)
end

function var_0_0._playEndVideo(arg_14_0)
	logNormal("NicknameView:_playEndVideo() ---------------------1")
	arg_14_0._listPlayer:JumpToItem(0)
	AudioMgr.instance:trigger(AudioEnum.CriWare.Play_Name_Complete)
	TaskDispatcher.runDelay(arg_14_0._delayCloseView, arg_14_0, 8)
end

function var_0_0._onVideoPlayEvent(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = string.split(arg_15_1, "/")
	local var_15_1 = var_15_0[#var_15_0]

	logNormal("NicknameView:_onVideoPlayEvent, videoName = " .. var_15_1 .. " status = " .. AvProEnum.getPlayerStatusEnumName(arg_15_2) .. " errorCode = " .. AvProEnum.getErrorCodeEnumName(arg_15_3))

	if var_15_1 == "make_name_start.mp4" and arg_15_2 == AvProEnum.PlayerStatus.Started then
		TaskDispatcher.cancelTask(arg_15_0._delayShowNameUI, arg_15_0)
	end

	if var_15_1 == "make_name_end.mp4" then
		if arg_15_3 ~= AvProEnum.ErrorCode.None then
			arg_15_0._listPlayer:Stop()
			TaskDispatcher.cancelTask(arg_15_0._delayCloseView, arg_15_0)
			gohelper.setActive(arg_15_0._goname, false)
			arg_15_0:closeThis()
		end

		if arg_15_2 == AvProEnum.PlayerStatus.FinishedPlaying then
			TaskDispatcher.cancelTask(arg_15_0._delayCloseView, arg_15_0)
			gohelper.setActive(arg_15_0._goname, false)
			arg_15_0:closeThis()
		end
	end
end

function var_0_0._delayCloseView(arg_16_0)
	logError("播放起名字end视频超时了")
	arg_16_0._listPlayer:Stop()
	gohelper.setActive(arg_16_0._goname, false)
	arg_16_0:closeThis()
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	if arg_18_0.viewParam then
		arg_18_0.guideId = arg_18_0.viewParam.guideId
		arg_18_0.stepId = arg_18_0.viewParam.stepId
		arg_18_0.fadeTime = arg_18_0.viewParam.viewParam
	end

	arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, arg_18_0._onChangePlayerName, arg_18_0)
	arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.NickNameConfirmNo, arg_18_0._onConfirmNo, arg_18_0)
	arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.NickNameConfirmYes, arg_18_0._onConfirmYes, arg_18_0)
	arg_18_0._btnok:AddClickListener(arg_18_0._btnokOnClick, arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.Bgm.play_ui_nameitsfx_music)
end

function var_0_0._onConfirmNo(arg_19_0)
	gohelper.setActive(arg_19_0._gonormal, true)
	gohelper.setActive(arg_19_0._goname, true)

	arg_19_0._inputnameTMP.interactable = true
end

function var_0_0._onConfirmYes(arg_20_0)
	arg_20_0._inputnameTMP.interactable = false

	gohelper.setActive(arg_20_0._goname, false)
end

function var_0_0._inputValueChanged(arg_21_0)
	local var_21_0 = arg_21_0._inputname:GetText()
	local var_21_1 = string.nilorempty(var_21_0)

	gohelper.setActive(arg_21_0._gonormal, not var_21_1)

	if not var_21_1 then
		arg_21_0:_checkLimit()
	end
end

function var_0_0._onChangePlayerName(arg_22_0)
	arg_22_0._isChangePlayerName = true

	TaskDispatcher.runDelay(arg_22_0._playStory, arg_22_0, 0.333)
end

function var_0_0._playStory(arg_23_0)
	local var_23_0
	local var_23_1 = arg_23_0:_specialName(string.lower(arg_23_0._nickName)) and 100012 or 100011

	StoryModel.instance.skipFade = true
	module_views.StoryBackgroundView.viewType = ViewType.Normal

	local var_23_2 = {}

	var_23_2.hideBtn = true

	StoryController.instance:playStory(var_23_1, var_23_2, arg_23_0._playStoryEnd, arg_23_0)

	local var_23_3 = StatModel.instance:generateRoleInfo()

	SDKMgr.instance:updateRole(var_23_3)
	SDKMgr.instance:enterGame(var_23_3)
	SDKChannelEventModel.instance:nickName()
end

function var_0_0._specialName(arg_24_0, arg_24_1)
	local var_24_0 = CommonConfig.instance:getConstStr(ConstEnum.NickName)
	local var_24_1 = string.split(var_24_0, "#")

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if arg_24_1 == iter_24_1 then
			return true
		end
	end
end

function var_0_0._playStoryEnd(arg_25_0)
	StoryModel.instance.skipFade = false
	module_views.StoryBackgroundView.viewType = ViewType.Full

	arg_25_0:_playEndVideo()
end

function var_0_0._fade(arg_26_0)
	gohelper.setActive(arg_26_0._imagemask.gameObject, true)

	local var_26_0 = arg_26_0.fadeTime or 2

	ZProj.TweenHelper.DoFade(arg_26_0._imagemask, 0, 1, var_26_0, function()
		arg_26_0:closeThis()
	end)
end

function var_0_0.onClose(arg_28_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)
	arg_28_0._inputname:RemoveOnValueChanged()
	arg_28_0._btnok:RemoveClickListener()

	if arg_28_0._inputNameClickListener then
		arg_28_0._inputNameClickListener:RemoveClickListener()

		arg_28_0._inputNameClickListener = nil
	end

	TaskDispatcher.cancelTask(arg_28_0._delayShowNameUI, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._delayCloseView, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._playStory, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._showInputUI, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._onJumpNext, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0._simageinputnamebg:UnLoadImage()
	arg_29_0._uguiListPlayer:Clear()

	arg_29_0._uguiListPlayer = nil
	arg_29_0._listPlayer = nil
end

return var_0_0
