module("modules.logic.equip.view.EquipGetView", package.seeall)

slot0 = class("EquipGetView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_bg")
	slot0._simagecircle = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_circle/circlewainew/circle")
	slot0._simageequipicon = gohelper.findChildSingleImage(slot0.viewGO, "equip/#simage_equipicon")
	slot0._simageblackbg = gohelper.findChildSingleImage(slot0.viewGO, "introduce/#simage_blackbg")
	slot0._txtcharacterNameCn = gohelper.findChildText(slot0.viewGO, "introduce/#txt_characterNameCn")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "introduce/#txt_characterNameCn/#image_career")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "introduce/#simage_icon")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "introduce/#go_starList")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	if slot0._isSummonTen then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
		slot0:closeThis()
	elseif not slot0._animFinish then
		slot0:_skipAnim()
	end
end

slot1 = 6

function slot0._editableInitView(slot0)
	slot0._animSkip = true
	slot0._goEquipRoot = gohelper.findChild(slot0.viewGO, "equip")
	slot0._goDetailRoot = gohelper.findChild(slot0.viewGO, "introduce")

	slot0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/bg_characterget"))
	slot0._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
	slot0._simageblackbg:LoadImage(ResUrl.getCharacterGetIcon("heisedi"))

	slot4 = "qm123"

	slot0._simageicon:LoadImage(ResUrl.getSignature(slot4))

	for slot4 = 1, uv0 do
		slot0["_starGo" .. tostring(slot4)] = gohelper.findChild(slot0._gostarList, "star" .. tostring(slot4))
	end

	slot0._goeffectstarList = gohelper.findChild(slot0.viewGO, "#go_bg/xingxing")

	for slot4 = 1, uv0 do
		slot0["_starEffectGo" .. tostring(slot4)] = gohelper.findChild(slot0._goeffectstarList, "star" .. slot4)
	end

	slot0._bgClick = gohelper.getClickWithAudio(slot0._gobg)

	slot0._bgClick:AddClickListener(slot0._onBgClick, slot0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._animEventWrap = slot0._animator:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("star", slot0._playStarAudio, slot0)
	slot0._animEventWrap:AddEventListener("skip", slot0._playSkip, slot0)

	slot0._videoGo = gohelper.findChild(slot0.viewGO, "#go_bg/videoplayer")

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onBgClick, slot0)
	slot0:setEquipShowVisible(false)
end

function slot0._initVideoPlayer(slot0)
	if slot0._videoPlayer then
		return
	end

	slot0._videoPlayer, slot0._displauUGUI = AvProMgr.instance:getVideoPlayer(gohelper.findChild(slot0.viewGO, "#go_bg/videoplayer"))

	slot0._videoPlayer:AddDisplayUGUI(slot0._displauUGUI)
	slot0._videoPlayer:SetEventListener(slot0._videoStatusUpdate, slot0)
end

function slot0.onDestroyView(slot0)
	NavigateMgr.instance:removeEscape(slot0.viewName, slot0._onBgClick, slot0)
	slot0._bgClick:RemoveClickListener()
	slot0._simagebg:UnLoadImage()
	slot0._simagecircle:UnLoadImage()
	slot0._simageblackbg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
	slot0._simageequipicon:UnLoadImage()
	slot0._animEventWrap:RemoveAllEventListener()

	if slot0._animator then
		slot0._animator.enabled = false
	end

	if slot0._videoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._videoPlayer:Stop()
		end

		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)
end

function slot0._onBgClick(slot0)
	if slot0._animFinish then
		slot0:closeThis()
	elseif not slot0._animSkip then
		slot0:_skipAnim()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0._animFinish = false
	slot0._equipId = slot0.viewParam.equipId
	slot0._isSummonTen = slot0.viewParam.isSummonTen
	slot0._skipVideo = slot0.viewParam.skipVideo

	if not slot0._equipId then
		return
	end

	slot0._equipCo = EquipConfig.instance:getEquipCo(slot0._equipId)

	if slot0._equipCo then
		slot0._rare = slot0._equipCo.rare

		slot0:_refreshView()
	end

	if not slot0._skipVideo then
		-- Nothing
	end

	slot0:_skipAnim()

	if false then
		slot0:_playOpenAnimation()
	end
end

function slot0.onClose(slot0)
end

function slot0.setEquipShowVisible(slot0, slot1)
	gohelper.setActive(slot0._goEquipRoot, slot1)
	gohelper.setActive(slot0._goDetailRoot, slot1)
end

function slot0._refreshView(slot0)
	slot0._playedStar = 0

	if slot0._equipCo then
		slot0._txtcharacterNameCn.text = slot0._equipCo.name

		EquipHelper.loadEquipCareerNewIcon(slot0._equipCo, slot0._imagecareer)
		slot0._simageequipicon:LoadImage(ResUrl.getEquipSuit(slot0._equipCo.icon))
		slot0:_applyStar()
	end

	gohelper.setActive(slot0._btnskip.gameObject, not SummonController.instance:isInSummonGuide() and not SummonModel.instance:getSendEquipFreeSummon())
end

function slot0._applyStar(slot0)
	slot1 = 1 + slot0._rare

	for slot5 = 1, uv0 do
		gohelper.setActive(slot0["_starGo" .. tostring(slot5)], slot5 <= slot1)
		gohelper.setActive(slot0["_starEffectGo" .. tostring(slot5)], slot5 <= slot1)
	end
end

function slot0._skipAnim(slot0)
	if not slot0._isSummonTen then
		gohelper.setActive(slot0._btnskip.gameObject, false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	slot0._animSkip = true

	slot0._animatorPlayer:Play("skip", slot0._openAnimFinish, slot0)
	slot0:setEquipShowVisible(true)
	gohelper.setActive(slot0._videoGo, false)
	slot0:_resetVideo()
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.Started then
		slot0._animSkip = false

		slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._openAnimFinish, slot0)

		slot0._animator.speed = 1

		slot0._animator:Play(UIAnimationName.Idle, 1, 0)

		if slot0._rare < 3 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Low_Hero)
		elseif slot0._rare < 5 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Middle_Hero)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_High_Hero)
		end

		slot0:setEquipShowVisible(true)
	elseif slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		if not slot0._isSummonTen then
			gohelper.setActive(slot0._btnskip.gameObject, false)
		end

		slot0:setEquipShowVisible(true)
		slot0:_resetVideo()
	end
end

function slot0._resetVideo(slot0)
	gohelper.setActive(slot0._videoGo, false)

	if not slot0._videoPlayer then
		return
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		slot0._videoPlayer:Stop()
	else
		slot0._videoPlayer:Stop()
	end
end

function slot0._playOpenAnimation(slot0)
	gohelper.setActive(slot0._simageequipicon.gameObject, false)
	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)

	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(UIAnimationName.Open, 0, 0)
		slot0._animator:Play(UIAnimationName.Idle, 1, 0)

		slot0._animator.speed = 0

		slot0._animator:Update(0)
	end

	slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._openAnimFinish, slot0)
	gohelper.setActive(slot0._videoGo, true)
	slot0:_initVideoPlayer()
	slot0._videoPlayer:LoadMedia(langVideoUrl("character_get_start"))
	slot0._videoPlayer:Play(slot0._displauUGUI, false)
	TaskDispatcher.runDelay(slot0._openAnimFinish, slot0, 10)
end

function slot0._playStarAudio(slot0)
	if 1 + slot0._rare <= slot0._playedStar then
		return
	end

	slot0._playedStar = slot0._playedStar + 1

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)
	gohelper.setActive(slot0._simageequipicon.gameObject, true)
end

function slot0._openAnimFinish(slot0)
	slot0._animSkip = true

	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)

	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(UIAnimationName.Loop, 0, 0)
		slot0._animator:Play(UIAnimationName.Voice, 1, 0)
	end

	slot0._animFinish = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonEquipSingleFinish)
end

function slot0._playSkip(slot0)
	slot0._animSkip = true

	logNormal("draw in rare : " .. tostring(slot0._rare))

	if slot0._rare < 3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_General_Last)
	elseif slot0._rare < 5 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Medium_Last)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Special_Last)
	end
end

return slot0
