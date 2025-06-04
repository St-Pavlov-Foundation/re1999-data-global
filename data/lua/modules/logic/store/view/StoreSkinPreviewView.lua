module("modules.logic.store.view.StoreSkinPreviewView", package.seeall)

local var_0_0 = class("StoreSkinPreviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gozs = gohelper.findChild(arg_1_0.viewGO, "zs")
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	arg_1_0._gobigspine = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	arg_1_0._gospinecontainer = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	arg_1_0._gosmallspine = gohelper.findChild(arg_1_0.viewGO, "smalldynamiccontainer/#go_smallspine")
	arg_1_0._simagebgmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgmask")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signature")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_index")
	arg_1_0._txtcharacterName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_characterName")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc")
	arg_1_0._btnshowDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_switch")
	arg_1_0._btnvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_video")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "desc/#btn_switch/#txt_switch")
	arg_1_0._go2d = gohelper.findChild(arg_1_0.viewGO, "desc/#btn_switch/#go_2d")
	arg_1_0._gol2d = gohelper.findChild(arg_1_0.viewGO, "desc/#btn_switch/#go_l2d")
	arg_1_0._simageshowbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#simage_showbg")
	arg_1_0._scrollskinSwitch = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	arg_1_0._gopreEmpty = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	arg_1_0._goskinItem = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_buy")
	arg_1_0._gotxtbuy = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/dressState/#go_has")
	arg_1_0._gobtntopleft = gohelper.findChild(arg_1_0.viewGO, "#go_btntopleft")
	arg_1_0._goskinCard = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#go_skinCard")
	arg_1_0._btntag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_tag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowDetail:AddClickListener(arg_2_0._btnshowDetailOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnvideo:AddClickListener(arg_2_0._btnvideoOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btntag:AddClickListener(arg_2_0._btntagOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowDetail:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnvideo:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btntag:RemoveClickListener()
end

function var_0_0._btnswitchOnClick(arg_4_0)
	arg_4_0._showLive2d = arg_4_0._showLive2d == false

	gohelper.setActive(arg_4_0._go2d, arg_4_0._showLive2d)
	gohelper.setActive(arg_4_0._gol2d, arg_4_0._showLive2d == false)
	gohelper.setActive(arg_4_0._gozs, arg_4_0._showLive2d)

	arg_4_0._txtswitch.text = arg_4_0._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_4_0._animatorPlayer:Play("switch", arg_4_0._disableClipAlpha, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._refreshBigSkin, arg_4_0, 0.16)
	gohelper.setActive(arg_4_0._gozs, arg_4_0._showLive2d)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)
end

function var_0_0._btnvideoOnClick(arg_5_0)
	logNormal("播放视频,当前皮肤id:" .. arg_5_0.skinCo.id)

	local var_5_0 = WebViewController.instance:getVideoUrl(arg_5_0.skinCo.characterId)

	if UnityEngine.Application.version == "2.6.0" and GameChannelConfig.isLongCheng() and BootNativeUtil.isAndroid() then
		GameUtil.openURL(var_5_0)

		return
	end

	WebViewController.instance:openWebView(var_5_0, false, nil, nil, 0, nil, 0, 0, nil, true)
end

local var_0_1 = ZProj.TweenHelper

function var_0_0._btnshowDetailOnClick(arg_6_0)
	CharacterController.instance:openCharacterSkinFullScreenView(arg_6_0.skinCo)
end

function var_0_0._btntagOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = arg_7_0.skinCo
	})
end

function var_0_0._btnbuyOnClick(arg_8_0)
	local var_8_0 = StoreClothesGoodsItemListModel.instance:getList()
	local var_8_1 = arg_8_0._allSkinList[arg_8_0._currentSelectSkinIndex]

	if var_8_1 and StoreModel.instance:getGoodsMO(var_8_1.goodsId) then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			goodsMO = var_8_1
		})
	else
		GameFacade.showToast(ToastEnum.StoreSkinPreview)
	end
end

function var_0_0._btnnotgetOnClick(arg_9_0)
	return
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._showLive2d = true
	arg_10_0._goSpine = GuiSpine.Create(arg_10_0._gosmallspine, false)

	gohelper.setActive(arg_10_0._go2d, arg_10_0._showLive2d)
	gohelper.setActive(arg_10_0._gol2d, arg_10_0._showLive2d == false)

	arg_10_0._txtswitch.text = arg_10_0._showLive2d and "L2D" or luaLang("storeskinpreviewview_btnswitch")
	arg_10_0._itemObjects = {}

	local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "drag")

	arg_10_0._drag = SLFramework.UGUI.UIDragListener.Get(var_10_0)

	arg_10_0._drag:AddDragBeginListener(arg_10_0._onViewDragBegin, arg_10_0)
	arg_10_0._drag:AddDragListener(arg_10_0._onViewDrag, arg_10_0)
	arg_10_0._drag:AddDragEndListener(arg_10_0._onViewDragEnd, arg_10_0)

	arg_10_0._preDragAnchorPositionX = 0
	arg_10_0._itemWidth = recthelper.getWidth(arg_10_0._goskinItem.transform)
	arg_10_0._scrollOneItemTime = 0.5
	arg_10_0._scrollRate = arg_10_0._itemWidth / arg_10_0._scrollOneItemTime
	arg_10_0._tweeningId = 0
	arg_10_0._currentSelectSkinIndex = 0
	arg_10_0._preSelectSkinIndex = 0
	arg_10_0._minAnchorPositionX = 0
	arg_10_0._minChangeAnchorPositionX = 100

	arg_10_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	arg_10_0._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	arg_10_0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))

	arg_10_0.cardImage = gohelper.findChildSingleImage(arg_10_0._goskinCard, "skinmask/skinicon")
	arg_10_0._skincontainerCanvasGroup = gohelper.findChild(arg_10_0.viewGO, "characterSpine/#go_skincontainer"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_10_0._animator = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_10_0.viewGO)
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:refreshView()
end

function var_0_0.onOpen(arg_12_0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_12_0:refreshView()
end

function var_0_0.onOpenFinish(arg_13_0)
	arg_13_0:_disableClipAlpha()
end

function var_0_0.refreshView(arg_14_0)
	arg_14_0.goodsMO = arg_14_0.viewParam.goodsMO

	local var_14_0 = arg_14_0.goodsMO.config.product
	local var_14_1 = string.splitToNumber(var_14_0, "#")[2]

	arg_14_0.skinCo = SkinConfig.instance:getSkinCo(var_14_1)

	arg_14_0:_refreshSkinList()
	arg_14_0:_reallyRefreshView(arg_14_0.skinCo)
end

function var_0_0._reallyRefreshView(arg_15_0, arg_15_1)
	arg_15_0.skinCo = arg_15_1

	if arg_15_0._uiSpine then
		arg_15_0._uiSpine:onDestroy()

		arg_15_0._uiSpine = nil
	end

	arg_15_0._simageskin:UnLoadImage()
	arg_15_0._simagel2d:UnLoadImage()
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, arg_15_0.skinCo.id)
	gohelper.setActive(arg_15_0._btnswitch, arg_15_0.skinCo.showSwitchBtn == 1)

	arg_15_0._showLive2d = true

	gohelper.setActive(arg_15_0._go2d, arg_15_0._showLive2d)
	gohelper.setActive(arg_15_0._gol2d, arg_15_0._showLive2d == false)

	arg_15_0._txtswitch.text = arg_15_0._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	local var_15_0 = arg_15_1.live2dbg

	if not string.nilorempty(var_15_0) then
		gohelper.setActive(arg_15_0._simagel2d.gameObject, arg_15_0._showLive2d)
		gohelper.setActive(arg_15_0._gozs, arg_15_0._showLive2d)
		arg_15_0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(var_15_0))
	else
		gohelper.setActive(arg_15_0._simagel2d.gameObject, false)
		gohelper.setActive(arg_15_0._gozs, false)
	end

	local var_15_1 = not VersionValidator.instance:isInReviewing() and arg_15_1.isSkinVideo

	logNormal("当前皮肤id:" .. " 是否可以播放视频: " .. tostring(var_15_1))
	gohelper.setActive(arg_15_0._btnvideo, var_15_1)
	arg_15_0:_refreshBigSkin()
	arg_15_0:_refreshSkinInfo()
	arg_15_0:_refreshSpine()
	arg_15_0:_refreshStatus()
end

function var_0_0._refreshBigSkin(arg_16_0)
	gohelper.setActive(arg_16_0._gospinecontainer, arg_16_0._showLive2d)
	gohelper.setActive(arg_16_0._simageskin.gameObject, arg_16_0._showLive2d == false)

	if arg_16_0._showLive2d then
		if arg_16_0._uiSpine == nil then
			arg_16_0._uiSpine = GuiModelAgent.Create(arg_16_0._gobigspine, true)

			arg_16_0._uiSpine:setResPath(arg_16_0.skinCo, arg_16_0._onUISpineLoaded, arg_16_0)
		else
			arg_16_0:_onUISpineLoaded()
		end

		arg_16_0._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		arg_16_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_16_0.skinCo.id), arg_16_0._loadedImage, arg_16_0)

		arg_16_0._txtswitch.text = "L2D"
	end
end

function var_0_0._onViewDragBegin(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._startPos = arg_17_2.position.x

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_17_0._animatorPlayer:Play(UIAnimationName.SwitchClose, arg_17_0._onAnimDone, arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function var_0_0._onAnimDone(arg_18_0)
	return
end

function var_0_0._onViewDrag(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2.position.x
	local var_19_1 = 1
	local var_19_2 = recthelper.getAnchorX(arg_19_0._goskincontainer.transform) + arg_19_2.delta.x * var_19_1

	recthelper.setAnchorX(arg_19_0._goskincontainer.transform, var_19_2)

	local var_19_3 = 0.007

	arg_19_0._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(arg_19_0._startPos - var_19_0) * var_19_3
end

function var_0_0._onViewDragEnd(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.position.x
	local var_20_1
	local var_20_2 = true

	if var_20_0 > arg_20_0._startPos and var_20_0 - arg_20_0._startPos >= 100 then
		var_20_1 = arg_20_0._currentSelectSkinIndex - 1

		if var_20_1 == 0 then
			var_20_1 = #arg_20_0._allSkinList
		end
	elseif var_20_0 < arg_20_0._startPos and arg_20_0._startPos - var_20_0 >= 100 then
		var_20_1 = arg_20_0._currentSelectSkinIndex + 1

		if var_20_1 > #arg_20_0._allSkinList then
			var_20_1 = 1
		end

		var_20_2 = false
	end

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	arg_20_0._skincontainerCanvasGroup.alpha = 1

	if var_20_2 then
		arg_20_0._animatorPlayer:Play("switch_openleft", arg_20_0._disableClipAlpha, arg_20_0)
	else
		arg_20_0._animatorPlayer:Play("switch_openright", arg_20_0._disableClipAlpha, arg_20_0)
	end

	if var_20_1 then
		arg_20_0._currentSelectSkinIndex = var_20_1

		local var_20_3 = arg_20_0._allSkinList[arg_20_0._currentSelectSkinIndex].config.product
		local var_20_4 = string.splitToNumber(var_20_3, "#")[2]
		local var_20_5 = SkinConfig.instance:getSkinCo(var_20_4)

		arg_20_0:_reallyRefreshView(var_20_5)
	else
		arg_20_0:_loadedImage()
	end
end

function var_0_0._onDragBegin(arg_21_0)
	var_0_1.KillById(arg_21_0._tweeningId)

	arg_21_0._preDragAnchorPositionX = recthelper.getAnchorX(arg_21_0._goContent.transform)
end

function var_0_0._onDrag(arg_22_0)
	local var_22_0 = recthelper.getAnchorX(arg_22_0._goContent.transform)
	local var_22_1 = math.abs(var_22_0 - arg_22_0._preDragAnchorPositionX)
	local var_22_2 = arg_22_0._currentSelectSkinIndex

	if var_22_1 > arg_22_0._minChangeAnchorPositionX then
		if var_22_0 < arg_22_0._minAnchorPositionX then
			var_22_0 = arg_22_0._minAnchorPositionX
		end

		if var_22_0 > 0 then
			var_22_0 = 0
		end

		local var_22_3 = 0

		if var_22_0 < arg_22_0._preDragAnchorPositionX then
			local var_22_4 = 1

			var_22_2 = math.ceil(math.abs(var_22_0) / arg_22_0._itemWidth) + 1

			if var_22_2 > #arg_22_0._itemObjects then
				var_22_2 = #arg_22_0._itemObjects
			end
		elseif var_22_0 > arg_22_0._preDragAnchorPositionX then
			local var_22_5 = 2

			var_22_2 = math.ceil(math.abs(var_22_0) / arg_22_0._itemWidth)

			if var_22_2 < 1 then
				var_22_2 = 1
			end
		end
	end

	if var_22_2 then
		local var_22_6 = arg_22_0._itemObjects[var_22_2]

		for iter_22_0, iter_22_1 in ipairs(arg_22_0._itemObjects) do
			local var_22_7 = var_22_2 == iter_22_0 and 1 or 0.8

			transformhelper.setLocalScale(iter_22_1.transSkinmask, var_22_7, var_22_7, var_22_7)
		end
	end
end

function var_0_0._onDragEnd(arg_23_0)
	local var_23_0 = recthelper.getAnchorX(arg_23_0._goContent.transform)
	local var_23_1 = math.abs(var_23_0 - arg_23_0._preDragAnchorPositionX)

	if var_23_1 <= arg_23_0._minChangeAnchorPositionX then
		arg_23_0._tweeningId = var_0_1.DOAnchorPosX(arg_23_0._goContent.transform, arg_23_0._preDragAnchorPositionX, var_23_1 / arg_23_0._scrollRate, arg_23_0.onCompleteTween, arg_23_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rolesopen)

		if var_23_0 < arg_23_0._minAnchorPositionX then
			var_23_0 = arg_23_0._minAnchorPositionX
		end

		if var_23_0 > 0 then
			var_23_0 = 0
		end

		local var_23_2 = 0

		arg_23_0._preSelectSkinIndex = arg_23_0._currentSelectSkinIndex

		if var_23_0 < arg_23_0._preDragAnchorPositionX then
			arg_23_0._currentSelectSkinIndex = math.ceil(math.abs(var_23_0) / arg_23_0._itemWidth) + 1

			if arg_23_0._currentSelectSkinIndex > #arg_23_0._itemObjects then
				arg_23_0._currentSelectSkinIndex = #arg_23_0._itemObjects
			end

			var_23_2 = math.abs(var_23_0) % arg_23_0._itemWidth

			if var_23_2 == 0 then
				arg_23_0:onCompleteTween()

				local var_23_3 = arg_23_0._itemObjects[arg_23_0._currentSelectSkinIndex]

				arg_23_0:_reallyRefreshView(var_23_3.skinCo)

				return
			end

			var_23_2 = arg_23_0._itemWidth - var_23_2
		elseif var_23_0 > arg_23_0._preDragAnchorPositionX then
			arg_23_0._currentSelectSkinIndex = math.ceil(math.abs(var_23_0) / arg_23_0._itemWidth)

			if arg_23_0._currentSelectSkinIndex < 1 then
				arg_23_0._currentSelectSkinIndex = 1
			end

			var_23_2 = math.abs(var_23_0) % arg_23_0._itemWidth
		end

		local var_23_4 = arg_23_0._itemObjects[arg_23_0._currentSelectSkinIndex]

		arg_23_0:_reallyRefreshView(var_23_4.skinCo)

		arg_23_0._tweeningId = var_0_1.DOAnchorPosX(arg_23_0._goContent.transform, -(arg_23_0._currentSelectSkinIndex - 1) * arg_23_0._itemWidth, var_23_2 / arg_23_0._scrollRate, arg_23_0.onCompleteTween, arg_23_0)
	end

	if arg_23_0._currentSelectSkinIndex then
		local var_23_5 = arg_23_0._itemObjects[arg_23_0._currentSelectSkinIndex]

		for iter_23_0, iter_23_1 in ipairs(arg_23_0._itemObjects) do
			local var_23_6 = arg_23_0._currentSelectSkinIndex == iter_23_0 and 1 or 0.8

			transformhelper.setLocalScale(iter_23_1.transSkinmask, var_23_6, var_23_6, var_23_6)
		end
	end
end

function var_0_0.onCompleteTween(arg_24_0)
	arg_24_0._tweeningId = 0

	gohelper.setActive(arg_24_0._itemObjects[arg_24_0._preSelectSkinIndex].goSelectedBg, false)
	gohelper.setActive(arg_24_0._itemObjects[arg_24_0._preSelectSkinIndex].goNotSelectedBg, true)
	gohelper.setActive(arg_24_0._itemObjects[arg_24_0._currentSelectSkinIndex].goSelectedBg, true)
	gohelper.setActive(arg_24_0._itemObjects[arg_24_0._currentSelectSkinIndex].goNotSelectedBg, false)
end

function var_0_0._refreshSkinInfo(arg_25_0)
	local var_25_0 = HeroConfig.instance:getHeroCO(arg_25_0.skinCo.characterId)

	arg_25_0._simagesignature:LoadImage(ResUrl.getSignature(var_25_0.signature))

	arg_25_0._txtindex.text = ""
	arg_25_0._txtcharacterName.text = var_25_0.name

	gohelper.setActive(arg_25_0._txtskinName.gameObject, true)
	gohelper.setActive(arg_25_0._txtskinNameEn.gameObject, true)

	arg_25_0._txtskinName.text = arg_25_0.skinCo.characterSkin
	arg_25_0._txtskinNameEn.text = arg_25_0.skinCo.characterSkinNameEng
	arg_25_0._txtdesc.text = arg_25_0.skinCo.skinDescription

	arg_25_0.cardImage:LoadImage(ResUrl.getHeadSkinSmall(arg_25_0.skinCo.id))
	gohelper.setActive(arg_25_0._btntag.gameObject, string.nilorempty(arg_25_0.skinCo.storeTag) == false)
end

function var_0_0._onUISpineLoaded(arg_26_0)
	local var_26_0 = arg_26_0.skinCo.skinViewLive2dOffset

	if string.nilorempty(var_26_0) then
		var_26_0 = arg_26_0.skinCo.characterViewOffset
	end

	recthelper.setAnchor(arg_26_0._goskincontainer.transform, 0, 0)

	local var_26_1 = SkinConfig.instance:getSkinOffset(var_26_0)

	recthelper.setAnchor(arg_26_0._gobigspine.transform, tonumber(var_26_1[1]), tonumber(var_26_1[2]))
	transformhelper.setLocalScale(arg_26_0._gobigspine.transform, tonumber(var_26_1[3]), tonumber(var_26_1[3]), tonumber(var_26_1[3]))
end

function var_0_0._loadedImage(arg_27_0)
	ZProj.UGUIHelper.SetImageSize(arg_27_0._simageskin.gameObject)

	local var_27_0 = arg_27_0.skinCo.skinViewImgOffset

	recthelper.setAnchor(arg_27_0._goskincontainer.transform, 0, 0)

	if not string.nilorempty(var_27_0) then
		local var_27_1 = string.splitToNumber(var_27_0, "#")

		recthelper.setAnchor(arg_27_0._simageskin.transform, tonumber(var_27_1[1]), tonumber(var_27_1[2]))
		transformhelper.setLocalScale(arg_27_0._simageskin.transform, tonumber(var_27_1[3]), tonumber(var_27_1[3]), tonumber(var_27_1[3]))
	else
		recthelper.setAnchor(arg_27_0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(arg_27_0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function var_0_0._refreshSpine(arg_28_0)
	arg_28_0._goSpine:stopVoice()
	arg_28_0._goSpine:setResPath(ResUrl.getSpineUIPrefab(arg_28_0.skinCo.spine), arg_28_0._onSpineLoaded, arg_28_0, true)

	local var_28_0 = SkinConfig.instance:getSkinOffset(arg_28_0.skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_28_0._gosmallspine.transform, tonumber(var_28_0[1]), tonumber(var_28_0[2]))
	transformhelper.setLocalScale(arg_28_0._gosmallspine.transform, tonumber(var_28_0[3]), tonumber(var_28_0[3]), tonumber(var_28_0[3]))
end

function var_0_0._refreshStatus(arg_29_0)
	local var_29_0 = arg_29_0._allSkinList[arg_29_0._currentSelectSkinIndex]
	local var_29_1 = var_29_0:alreadyHas()

	gohelper.setActive(arg_29_0._btnbuy.gameObject, var_29_1 == false)
	gohelper.setActive(arg_29_0._gohas, var_29_1)

	if var_29_1 == false then
		local var_29_2 = string.splitToNumber(var_29_0.config.cost, "#")

		arg_29_0._costType = var_29_2[1]
		arg_29_0._costId = var_29_2[2]
		arg_29_0._costQuantity = var_29_2[3]
		arg_29_0._txtprice.text = arg_29_0._costQuantity

		local var_29_3, var_29_4 = ItemModel.instance:getItemConfigAndIcon(arg_29_0._costType, arg_29_0._costId)
		local var_29_5 = var_29_3.icon
		local var_29_6 = string.format("%s_1", var_29_5)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_29_0._imageicon, var_29_6)
	end
end

function var_0_0._refreshSkinList(arg_30_0)
	arg_30_0._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._allSkinList) do
		if arg_30_0.goodsMO.goodsId == iter_30_1.goodsId then
			arg_30_0._currentSelectSkinIndex = iter_30_0
		end
	end
end

function var_0_0._initSkinItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = {
		goodsMO = arg_31_3
	}
	local var_31_1 = arg_31_3.config.product
	local var_31_2 = string.splitToNumber(var_31_1, "#")[2]

	var_31_0.skinCo = SkinConfig.instance:getSkinCo(var_31_2)

	local var_31_3 = gohelper.findChildSingleImage(arg_31_1, "skinmask/skinicon")

	var_31_0.image = var_31_3
	gohelper.findChildText(arg_31_1, "skinIndex/txtSkinIndex").text = string.format("%02d", arg_31_2)

	var_31_3:LoadImage(ResUrl.getHeadSkinSmall(var_31_0.skinCo.id))

	var_31_0.goSelectedBg = gohelper.findChild(arg_31_1, "skinIndex/selectBg")
	var_31_0.transSkinmask = gohelper.findChild(arg_31_1, "skinmask").transform
	var_31_0.goNotSelectedBg = gohelper.findChild(arg_31_1, "skinIndex/notSelectBg")

	local var_31_4 = gohelper.getClick(var_31_3.gameObject)

	var_31_4:AddClickListener(arg_31_0._onItemClick, arg_31_0, arg_31_2)

	var_31_0.click = var_31_4

	gohelper.setActive(var_31_0.goSelectedBg, arg_31_0.goodsMO == arg_31_3)
	gohelper.setActive(var_31_0.goNotSelectedBg, arg_31_0.goodsMO == arg_31_3)

	local var_31_5 = 0.8

	if arg_31_0.goodsMO == arg_31_3 then
		var_31_5 = 1
		arg_31_0._currentSelectSkinIndex = arg_31_2
		arg_31_0._preSelectSkinIndex = arg_31_2
	end

	transformhelper.setLocalScale(var_31_0.transSkinmask, var_31_5, var_31_5, var_31_5)
	gohelper.setActive(arg_31_1, true)
	table.insert(arg_31_0._itemObjects, var_31_0)
end

function var_0_0._onItemClick(arg_32_0, arg_32_1)
	if arg_32_0._currentSelectSkinIndex == arg_32_1 then
		return
	end

	var_0_1.KillById(arg_32_0._tweeningId)

	arg_32_0._preSelectSkinIndex = arg_32_0._currentSelectSkinIndex
	arg_32_0._currentSelectSkinIndex = arg_32_1

	local var_32_0 = arg_32_0._itemObjects[arg_32_0._currentSelectSkinIndex]

	arg_32_0:_reallyRefreshView(var_32_0.skinCo)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._itemObjects) do
		local var_32_1 = arg_32_0._currentSelectSkinIndex == iter_32_0 and 1 or 0.8

		transformhelper.setLocalScale(iter_32_1.transSkinmask, var_32_1, var_32_1, var_32_1)
	end

	arg_32_0._tweeningId = var_0_1.DOAnchorPosX(arg_32_0._goContent.transform, -(arg_32_0._currentSelectSkinIndex - 1) * arg_32_0._itemWidth, 0.5, arg_32_0.onCompleteTween, arg_32_0)
end

function var_0_0._onSpineLoaded(arg_33_0)
	return
end

function var_0_0.onClose(arg_34_0)
	arg_34_0._simageskin:UnLoadImage()
	arg_34_0._simagesignature:UnLoadImage()
	arg_34_0._simagel2d:UnLoadImage()

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._itemObjects) do
		iter_34_1.image:UnLoadImage()
		iter_34_1.click:RemoveClickListener()
	end

	arg_34_0._drag:RemoveDragBeginListener()
	arg_34_0._drag:RemoveDragEndListener()
	arg_34_0._drag:RemoveDragListener()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	TaskDispatcher.cancelTask(arg_34_0._refreshBigSkin)
end

function var_0_0.onCloseFinish(arg_35_0)
	arg_35_0:_disableClipAlpha()
end

function var_0_0.onDestroyView(arg_36_0)
	if arg_36_0._goSpine then
		arg_36_0._goSpine:stopVoice()

		arg_36_0._goSpine = nil
	end

	if arg_36_0._uiSpine then
		arg_36_0._uiSpine:onDestroy()

		arg_36_0._uiSpine = nil
	end

	arg_36_0._simagebg:UnLoadImage()
	arg_36_0._simageshowbg:UnLoadImage()
	arg_36_0:_disableClipAlpha()
end

function var_0_0._disableClipAlpha(arg_37_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return var_0_0
