module("modules.logic.equip.view.EquipGetView", package.seeall)

local var_0_0 = class("EquipGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_bg")
	arg_1_0._simagecircle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_circle/circlewainew/circle")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "equip/#simage_equipicon")
	arg_1_0._simageblackbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "introduce/#simage_blackbg")
	arg_1_0._txtcharacterNameCn = gohelper.findChildText(arg_1_0.viewGO, "introduce/#txt_characterNameCn")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "introduce/#txt_characterNameCn/#image_career")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "introduce/#simage_icon")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "introduce/#go_starList")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	if arg_4_0._isSummonTen then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
		arg_4_0:closeThis()
	elseif not arg_4_0._animFinish then
		arg_4_0:_skipAnim()
	end
end

local var_0_1 = 6

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animSkip = true
	arg_5_0._goEquipRoot = gohelper.findChild(arg_5_0.viewGO, "equip")
	arg_5_0._goDetailRoot = gohelper.findChild(arg_5_0.viewGO, "introduce")

	arg_5_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/bg_characterget"))
	arg_5_0._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
	arg_5_0._simageblackbg:LoadImage(ResUrl.getCharacterGetIcon("heisedi"))
	arg_5_0._simageicon:LoadImage(ResUrl.getSignature("qm123"))

	for iter_5_0 = 1, var_0_1 do
		arg_5_0["_starGo" .. tostring(iter_5_0)] = gohelper.findChild(arg_5_0._gostarList, "star" .. tostring(iter_5_0))
	end

	arg_5_0._goeffectstarList = gohelper.findChild(arg_5_0.viewGO, "#go_bg/xingxing")

	for iter_5_1 = 1, var_0_1 do
		arg_5_0["_starEffectGo" .. tostring(iter_5_1)] = gohelper.findChild(arg_5_0._goeffectstarList, "star" .. iter_5_1)
	end

	arg_5_0._bgClick = gohelper.getClickWithAudio(arg_5_0._gobg)

	arg_5_0._bgClick:AddClickListener(arg_5_0._onBgClick, arg_5_0)

	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
	arg_5_0._animEventWrap = arg_5_0._animator:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_5_0._animEventWrap:AddEventListener("star", arg_5_0._playStarAudio, arg_5_0)
	arg_5_0._animEventWrap:AddEventListener("skip", arg_5_0._playSkip, arg_5_0)

	arg_5_0._videoGo = gohelper.findChild(arg_5_0.viewGO, "#go_bg/videoplayer")

	NavigateMgr.instance:addEscape(arg_5_0.viewName, arg_5_0._onBgClick, arg_5_0)
	arg_5_0:setEquipShowVisible(false)
end

function var_0_0._initVideoPlayer(arg_6_0)
	if arg_6_0._videoPlayer then
		return
	end

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#go_bg/videoplayer")

	arg_6_0._videoPlayer, arg_6_0._displauUGUI = AvProMgr.instance:getVideoPlayer(var_6_0)

	arg_6_0._videoPlayer:AddDisplayUGUI(arg_6_0._displauUGUI)
	arg_6_0._videoPlayer:SetEventListener(arg_6_0._videoStatusUpdate, arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	NavigateMgr.instance:removeEscape(arg_7_0.viewName, arg_7_0._onBgClick, arg_7_0)
	arg_7_0._bgClick:RemoveClickListener()
	arg_7_0._simagebg:UnLoadImage()
	arg_7_0._simagecircle:UnLoadImage()
	arg_7_0._simageblackbg:UnLoadImage()
	arg_7_0._simageicon:UnLoadImage()
	arg_7_0._simageequipicon:UnLoadImage()
	arg_7_0._animEventWrap:RemoveAllEventListener()

	if arg_7_0._animator then
		arg_7_0._animator.enabled = false
	end

	if arg_7_0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_7_0._videoPlayer:Stop()
		end

		arg_7_0._videoPlayer:Clear()

		arg_7_0._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_7_0._openAnimFinish, arg_7_0)
end

function var_0_0._onBgClick(arg_8_0)
	if arg_8_0._animFinish then
		arg_8_0:closeThis()
	elseif not arg_8_0._animSkip then
		arg_8_0:_skipAnim()
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:onOpen()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._animFinish = false
	arg_10_0._equipId = arg_10_0.viewParam.equipId
	arg_10_0._isSummonTen = arg_10_0.viewParam.isSummonTen
	arg_10_0._skipVideo = arg_10_0.viewParam.skipVideo

	if not arg_10_0._equipId then
		return
	end

	arg_10_0._equipCo = EquipConfig.instance:getEquipCo(arg_10_0._equipId)

	if arg_10_0._equipCo then
		arg_10_0._rare = arg_10_0._equipCo.rare

		arg_10_0:_refreshView()
	end

	if not arg_10_0._skipVideo then
		-- block empty
	end

	arg_10_0:_skipAnim()

	if false then
		arg_10_0:_playOpenAnimation()
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.setEquipShowVisible(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goEquipRoot, arg_12_1)
	gohelper.setActive(arg_12_0._goDetailRoot, arg_12_1)
end

function var_0_0._refreshView(arg_13_0)
	arg_13_0._playedStar = 0

	if arg_13_0._equipCo then
		arg_13_0._txtcharacterNameCn.text = arg_13_0._equipCo.name

		EquipHelper.loadEquipCareerNewIcon(arg_13_0._equipCo, arg_13_0._imagecareer)
		arg_13_0._simageequipicon:LoadImage(ResUrl.getEquipSuit(arg_13_0._equipCo.icon))
		arg_13_0:_applyStar()
	end

	gohelper.setActive(arg_13_0._btnskip.gameObject, not SummonController.instance:isInSummonGuide() and not SummonModel.instance:getSendEquipFreeSummon())
end

function var_0_0._applyStar(arg_14_0)
	local var_14_0 = 1 + arg_14_0._rare

	for iter_14_0 = 1, var_0_1 do
		gohelper.setActive(arg_14_0["_starGo" .. tostring(iter_14_0)], iter_14_0 <= var_14_0)
		gohelper.setActive(arg_14_0["_starEffectGo" .. tostring(iter_14_0)], iter_14_0 <= var_14_0)
	end
end

function var_0_0._skipAnim(arg_15_0)
	if not arg_15_0._isSummonTen then
		gohelper.setActive(arg_15_0._btnskip.gameObject, false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	arg_15_0._animSkip = true

	arg_15_0._animatorPlayer:Play("skip", arg_15_0._openAnimFinish, arg_15_0)
	arg_15_0:setEquipShowVisible(true)
	gohelper.setActive(arg_15_0._videoGo, false)
	arg_15_0:_resetVideo()
end

function var_0_0._videoStatusUpdate(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 == AvProEnum.PlayerStatus.Started then
		arg_16_0._animSkip = false

		arg_16_0._animatorPlayer:Play(UIAnimationName.Open, arg_16_0._openAnimFinish, arg_16_0)

		arg_16_0._animator.speed = 1

		arg_16_0._animator:Play(UIAnimationName.Idle, 1, 0)

		if arg_16_0._rare < 3 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Low_Hero)
		elseif arg_16_0._rare < 5 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Middle_Hero)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_High_Hero)
		end

		arg_16_0:setEquipShowVisible(true)
	elseif arg_16_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		if not arg_16_0._isSummonTen then
			gohelper.setActive(arg_16_0._btnskip.gameObject, false)
		end

		arg_16_0:setEquipShowVisible(true)
		arg_16_0:_resetVideo()
	end
end

function var_0_0._resetVideo(arg_17_0)
	gohelper.setActive(arg_17_0._videoGo, false)

	if not arg_17_0._videoPlayer then
		return
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		arg_17_0._videoPlayer:Stop()
	else
		arg_17_0._videoPlayer:Stop()
	end
end

function var_0_0._playOpenAnimation(arg_18_0)
	gohelper.setActive(arg_18_0._simageequipicon.gameObject, false)
	TaskDispatcher.cancelTask(arg_18_0._openAnimFinish, arg_18_0)

	if arg_18_0._animator then
		arg_18_0._animator.enabled = true

		arg_18_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_18_0._animator:Play(UIAnimationName.Idle, 1, 0)

		arg_18_0._animator.speed = 0

		arg_18_0._animator:Update(0)
	end

	arg_18_0._animatorPlayer:Play(UIAnimationName.Open, arg_18_0._openAnimFinish, arg_18_0)
	gohelper.setActive(arg_18_0._videoGo, true)
	arg_18_0:_initVideoPlayer()
	arg_18_0._videoPlayer:LoadMedia(langVideoUrl("character_get_start"))
	arg_18_0._videoPlayer:Play(arg_18_0._displauUGUI, false)
	TaskDispatcher.runDelay(arg_18_0._openAnimFinish, arg_18_0, 10)
end

function var_0_0._playStarAudio(arg_19_0)
	if 1 + arg_19_0._rare <= arg_19_0._playedStar then
		return
	end

	arg_19_0._playedStar = arg_19_0._playedStar + 1

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)
	gohelper.setActive(arg_19_0._simageequipicon.gameObject, true)
end

function var_0_0._openAnimFinish(arg_20_0)
	arg_20_0._animSkip = true

	TaskDispatcher.cancelTask(arg_20_0._openAnimFinish, arg_20_0)

	if arg_20_0._animator then
		arg_20_0._animator.enabled = true

		arg_20_0._animator:Play(UIAnimationName.Loop, 0, 0)
		arg_20_0._animator:Play(UIAnimationName.Voice, 1, 0)
	end

	arg_20_0._animFinish = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonEquipSingleFinish)
end

function var_0_0._playSkip(arg_21_0)
	arg_21_0._animSkip = true

	logNormal("draw in rare : " .. tostring(arg_21_0._rare))

	if arg_21_0._rare < 3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_General_Last)
	elseif arg_21_0._rare < 5 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Medium_Last)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Special_Last)
	end
end

return var_0_0
