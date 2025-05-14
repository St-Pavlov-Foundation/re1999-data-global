module("modules.logic.characterskin.view.CharacterSkinLeftView", package.seeall)

local var_0_0 = class("CharacterSkinLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gozs = gohelper.findChild(arg_1_0.viewGO, "zs")
	arg_1_0._simagebgmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgmask")
	arg_1_0._gosmallspine = gohelper.findChild(arg_1_0.viewGO, "smalldynamiccontainer/#go_smallspine")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#simage_l2d")
	arg_1_0._gobigspine = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signature")
	arg_1_0._simagesignatureicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signatureicon")
	arg_1_0._txtcharacterName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_characterName")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc")
	arg_1_0._btnshowDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	arg_1_0._btntag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_tag")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_switch")
	arg_1_0._btnvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_video")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "desc/#btn_switch/#txt_switch")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowDetail:AddClickListener(arg_2_0._btnshowDetailOnClick, arg_2_0)
	arg_2_0._btntag:AddClickListener(arg_2_0._btntagOnClick, arg_2_0)
	arg_2_0._btnvideo:AddClickListener(arg_2_0._btnvideoOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowDetail:RemoveClickListener()
	arg_3_0._btntag:RemoveClickListener()
	arg_3_0._btnvideo:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
end

function var_0_0.onSwitchAnimDone(arg_4_0)
	arg_4_0:setShaderKeyWord(false)
end

function var_0_0._btnswitchOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	arg_5_0.showDynamicVertical = not arg_5_0.showDynamicVertical

	arg_5_0._animator:Play("switch", 0, 0)
	arg_5_0:setShaderKeyWord(true)
	arg_5_0:refreshTxtSwitch()
	TaskDispatcher.runDelay(arg_5_0.refreshBigVertical, arg_5_0, 0.16)
	TaskDispatcher.runDelay(arg_5_0.onSwitchAnimDone, arg_5_0, 0.6)

	local var_5_0 = arg_5_0.heroCo and arg_5_0.heroCo.id
	local var_5_1 = arg_5_0.skinCo and arg_5_0.skinCo.id

	CharacterController.instance:trackInteractiveSkinDetails(var_5_0, var_5_1, StatEnum.ClickType.Switch)
end

function var_0_0._btnvideoOnClick(arg_6_0)
	if not arg_6_0.skinCo then
		return
	end

	local var_6_0 = arg_6_0.skinCo.characterId
	local var_6_1 = arg_6_0.skinCo.id
	local var_6_2 = HeroConfig.instance:getHeroCO(var_6_0)

	if not var_6_2 then
		return
	end

	local var_6_3 = WebViewController.instance:getVideoUrl(var_6_0, var_6_1)

	logNormal("播放视频,当前英雄id:" .. var_6_0 .. " 皮肤id: " .. var_6_1 .. " url: " .. var_6_3)

	if UnityEngine.Application.version == "2.2.0" and GameChannelConfig.isLongCheng() and BootNativeUtil.isAndroid() then
		GameUtil.openURL(var_6_3)
	else
		WebViewController.instance:openWebView(var_6_3, false, arg_6_0.OnWebViewBack, arg_6_0)
	end

	CharacterController.instance:statCharacterSkinVideoData(var_6_0, var_6_2.name, var_6_1, arg_6_0.skinCo.name)
end

function var_0_0.OnWebViewBack(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == WebViewEnum.WebViewCBType.Cb and arg_7_2 == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end

	logNormal("URL Jump Callback msg" .. arg_7_2)
end

function var_0_0._btntagOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._btnvideo, false)
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = arg_8_0.skinCo
	})

	local var_8_0 = arg_8_0.heroCo and arg_8_0.heroCo.id
	local var_8_1 = arg_8_0.skinCo and arg_8_0.skinCo.id

	CharacterController.instance:trackInteractiveSkinDetails(var_8_0, var_8_1, StatEnum.ClickType.Tag)
end

function var_0_0._btnshowDetailOnClick(arg_9_0)
	CharacterController.instance:openCharacterSkinFullScreenView(arg_9_0.skinCo, false, arg_9_0.showDynamicVertical and CharacterEnum.ShowSkinEnum.Dynamic or CharacterEnum.ShowSkinEnum.Static)

	local var_9_0 = arg_9_0.heroCo and arg_9_0.heroCo.id
	local var_9_1 = arg_9_0.skinCo and arg_9_0.skinCo.id

	CharacterController.instance:trackInteractiveSkinDetails(var_9_0, var_9_1, StatEnum.ClickType.Detail)
end

function var_0_0._onOpenView(arg_10_0, arg_10_1)
	if arg_10_0.showDynamicVertical and arg_10_1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(arg_10_0.goBigDynamicContainer, false)
	end
end

function var_0_0._onCloseViewFinish(arg_11_0, arg_11_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_11_0.viewName) then
		arg_11_0:setShaderKeyWord(false)
	end
end

function var_0_0._onCloseView(arg_12_0, arg_12_1)
	if arg_12_0.showDynamicVertical and arg_12_1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(arg_12_0.goBigDynamicContainer, true)
	end

	if arg_12_1 == ViewName.CharacterSkinTagView then
		arg_12_0:_refreshVideoBtnState(false)
	end
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.showDynamicVertical = PlayerModel.instance:getMyUserId() % 2 == 0 and true or false
	arg_13_0.smallSpine = GuiSpine.Create(arg_13_0._gosmallspine, false)
	arg_13_0.goBigDynamicContainer = gohelper.findChild(arg_13_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	arg_13_0.goBigStaticContainer = arg_13_0._simageskin.gameObject

	arg_13_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	arg_13_0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	arg_13_0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSkin, arg_13_0.switchSkin, arg_13_0)
	arg_13_0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSkinVertical, arg_13_0.switchSkinVertical, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_13_0._onCloseViewFinish, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_13_0._onOpenView, arg_13_0)
end

function var_0_0.refreshTxtSwitch(arg_14_0)
	arg_14_0._txtswitch.text = arg_14_0.showDynamicVertical and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function var_0_0.switchSkinVertical(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.viewName == arg_15_2 then
		arg_15_0.showDynamicVertical = arg_15_1
	end
end

function var_0_0.switchSkin(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.viewName == arg_16_2 then
		arg_16_0.skinCo = arg_16_1
		arg_16_0.heroCo = HeroConfig.instance:getHeroCO(arg_16_0.skinCo.characterId)

		arg_16_0:refreshSkin()
	end
end

function var_0_0.refreshSignature(arg_17_0)
	arg_17_0._simagesignature:LoadImage(ResUrl.getSignature(arg_17_0.heroCo.signature, "characterget"))

	if arg_17_0.skinCo.signature == "3011" then
		arg_17_0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
		gohelper.setActive(arg_17_0._simagesignatureicon.gameObject, true)
	else
		gohelper.setActive(arg_17_0._simagesignatureicon.gameObject, false)
	end
end

function var_0_0.refreshSkin(arg_18_0)
	arg_18_0:resetRes()
	arg_18_0:refreshSignature()
	arg_18_0:refreshBigVertical()
	arg_18_0:refreshSmallVertical()
	arg_18_0:_refreshSkinInfo()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSkinSwitchSpine, arg_18_0.skinCo.id)
end

function var_0_0.resetRes(arg_19_0)
	if arg_19_0.bigSpine then
		arg_19_0.bigSpine:onDestroy()
	end

	arg_19_0._simageskin:UnLoadImage()
	arg_19_0._simagel2d:UnLoadImage()
end

function var_0_0.refreshBigVertical(arg_20_0)
	gohelper.setActive(arg_20_0.goBigDynamicContainer, arg_20_0.showDynamicVertical)
	gohelper.setActive(arg_20_0._simageskin.gameObject, not arg_20_0.showDynamicVertical)

	if arg_20_0.showDynamicVertical then
		if arg_20_0.bigSpine == nil then
			arg_20_0.bigSpine = GuiModelAgent.Create(arg_20_0._gobigspine, true)
		end

		arg_20_0.bigSpine:setResPath(arg_20_0.skinCo, arg_20_0.onBigSpineLoaded, arg_20_0)
	else
		arg_20_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_20_0.skinCo.id), arg_20_0._loadedImage, arg_20_0)
	end

	local var_20_0 = arg_20_0.skinCo.live2dbg

	if not string.nilorempty(var_20_0) then
		gohelper.setActive(arg_20_0._simagel2d.gameObject, arg_20_0.showDynamicVertical)
		gohelper.setActive(arg_20_0._gozs, arg_20_0.showDynamicVertical)
		arg_20_0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(var_20_0))
	else
		gohelper.setActive(arg_20_0._simagel2d.gameObject, false)
		gohelper.setActive(arg_20_0._gozs, false)
	end
end

function var_0_0._refreshSkinInfo(arg_21_0)
	gohelper.setActive(arg_21_0._btnswitch, arg_21_0.skinCo.showSwitchBtn == 1)

	local var_21_0 = HeroConfig.instance:getHeroCO(arg_21_0.skinCo.characterId)

	arg_21_0._txtcharacterName.text = var_21_0.name
	arg_21_0._txtdesc.text = arg_21_0.skinCo.skinDescription

	arg_21_0:_refreshVideoBtnState(true)

	if string.nilorempty(arg_21_0.skinCo.characterSkin) then
		gohelper.setActive(arg_21_0._txtskinName.gameObject, false)

		arg_21_0._txtskinNameEn.text = ""
	else
		gohelper.setActive(arg_21_0._txtskinName.gameObject, true)

		arg_21_0._txtskinName.text = arg_21_0.skinCo.characterSkin
		arg_21_0._txtskinNameEn.text = arg_21_0.skinCo.characterSkinNameEng
	end

	gohelper.setActive(arg_21_0._btntag.gameObject, not string.nilorempty(arg_21_0.skinCo.storeTag))
	arg_21_0:refreshTxtSwitch()
end

function var_0_0._refreshVideoBtnState(arg_22_0, arg_22_1)
	local var_22_0 = not VersionValidator.instance:isInReviewing() and arg_22_0.skinCo.isSkinVideo

	gohelper.setActive(arg_22_0._btnvideo, var_22_0)

	if var_22_0 and arg_22_1 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onVideoBtnDisplay, arg_22_0.viewContainer.viewName)
	end
end

function var_0_0.onBigSpineLoaded(arg_23_0)
	arg_23_0.bigSpine:setAllLayer(UnityLayer.SceneEffect)

	local var_23_0 = arg_23_0.skinCo.skinViewLive2dOffset

	if string.nilorempty(var_23_0) then
		var_23_0 = arg_23_0.skinCo.characterViewOffset
	end

	local var_23_1 = SkinConfig.instance:getSkinOffset(var_23_0)

	recthelper.setAnchor(arg_23_0._gobigspine.transform, tonumber(var_23_1[1]), tonumber(var_23_1[2]))
	transformhelper.setLocalScale(arg_23_0._gobigspine.transform, tonumber(var_23_1[3]), tonumber(var_23_1[3]), tonumber(var_23_1[3]))
end

function var_0_0._loadedImage(arg_24_0)
	ZProj.UGUIHelper.SetImageSize(arg_24_0._simageskin.gameObject)

	local var_24_0 = arg_24_0.skinCo.skinViewImgOffset

	if not string.nilorempty(var_24_0) then
		local var_24_1 = string.splitToNumber(var_24_0, "#")

		recthelper.setAnchor(arg_24_0._simageskin.transform, tonumber(var_24_1[1]), tonumber(var_24_1[2]))
		transformhelper.setLocalScale(arg_24_0._simageskin.transform, tonumber(var_24_1[3]), tonumber(var_24_1[3]), tonumber(var_24_1[3]))
	else
		recthelper.setAnchor(arg_24_0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(arg_24_0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function var_0_0.refreshSmallVertical(arg_25_0)
	arg_25_0.smallSpine:stopVoice()
	arg_25_0.smallSpine:setResPath(ResUrl.getSpineUIPrefab(arg_25_0.skinCo.spine), arg_25_0.onSmallSpineLoaded, arg_25_0, true)
end

function var_0_0.onSmallSpineLoaded(arg_26_0)
	local var_26_0 = SkinConfig.instance:getSkinOffset(arg_26_0.skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_26_0._gosmallspine.transform, tonumber(var_26_0[1]), tonumber(var_26_0[2]))
	transformhelper.setLocalScale(arg_26_0._gosmallspine.transform, tonumber(var_26_0[3]), tonumber(var_26_0[3]), tonumber(var_26_0[3]))
end

function var_0_0.onClose(arg_27_0)
	arg_27_0._simageskin:UnLoadImage()
	arg_27_0._simagesignature:UnLoadImage()
	arg_27_0._simagesignatureicon:UnLoadImage()
	arg_27_0._simagel2d:UnLoadImage()

	if arg_27_0.bigSpine then
		arg_27_0.bigSpine:setModelVisible(false)
	end
end

function var_0_0.setShaderKeyWord(arg_28_0, arg_28_1)
	if arg_28_1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onDestroyView(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.onSwitchAnimDone, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.refreshBigVertical, arg_29_0)

	if arg_29_0.smallSpine then
		arg_29_0.smallSpine:stopVoice()

		arg_29_0.smallSpine = nil
	end

	if arg_29_0.bigSpine then
		arg_29_0.bigSpine:onDestroy()

		arg_29_0.bigSpine = nil
	end

	arg_29_0._simagebg:UnLoadImage()
	arg_29_0._simagebgmask:UnLoadImage()
end

return var_0_0
