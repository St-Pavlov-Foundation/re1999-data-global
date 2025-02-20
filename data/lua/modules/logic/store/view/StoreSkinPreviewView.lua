module("modules.logic.store.view.StoreSkinPreviewView", package.seeall)

slot0 = class("StoreSkinPreviewView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gozs = gohelper.findChild(slot0.viewGO, "zs")
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer")
	slot0._simageskin = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	slot0._simagel2d = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	slot0._gobigspine = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	slot0._gospinecontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	slot0._gosmallspine = gohelper.findChild(slot0.viewGO, "smalldynamiccontainer/#go_smallspine")
	slot0._simagebgmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgmask")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signature")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "desc/#txt_index")
	slot0._txtcharacterName = gohelper.findChildText(slot0.viewGO, "desc/#txt_characterName")
	slot0._txtskinName = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName")
	slot0._txtskinNameEn = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "desc/#txt_desc")
	slot0._btnshowDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_switch")
	slot0._btnvideo = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_video")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "desc/#btn_switch/#txt_switch")
	slot0._go2d = gohelper.findChild(slot0.viewGO, "desc/#btn_switch/#go_2d")
	slot0._gol2d = gohelper.findChild(slot0.viewGO, "desc/#btn_switch/#go_l2d")
	slot0._simageshowbg = gohelper.findChildSingleImage(slot0.viewGO, "container/#simage_showbg")
	slot0._scrollskinSwitch = gohelper.findChildScrollRect(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	slot0._gopreEmpty = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	slot0._goskinItem = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/skinSwitch/dressState/#btn_buy")
	slot0._gotxtbuy = gohelper.findChild(slot0.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	slot0._txtprice = gohelper.findChildText(slot0.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	slot0._gohas = gohelper.findChild(slot0.viewGO, "container/skinSwitch/dressState/#go_has")
	slot0._gobtntopleft = gohelper.findChild(slot0.viewGO, "#go_btntopleft")
	slot0._goskinCard = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#go_skinCard")
	slot0._btntag = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_tag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowDetail:AddClickListener(slot0._btnshowDetailOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btnvideo:AddClickListener(slot0._btnvideoOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btntag:AddClickListener(slot0._btntagOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowDetail:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	slot0._btnvideo:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._btntag:RemoveClickListener()
end

function slot0._btnswitchOnClick(slot0)
	slot0._showLive2d = slot0._showLive2d == false

	gohelper.setActive(slot0._go2d, slot0._showLive2d)
	gohelper.setActive(slot0._gol2d, slot0._showLive2d == false)
	gohelper.setActive(slot0._gozs, slot0._showLive2d)

	slot0._txtswitch.text = slot0._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	slot0._animatorPlayer:Play("switch", slot0._disableClipAlpha, slot0)
	TaskDispatcher.runDelay(slot0._refreshBigSkin, slot0, 0.16)
	gohelper.setActive(slot0._gozs, slot0._showLive2d)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)
end

function slot0._btnvideoOnClick(slot0)
	logNormal("播放视频,当前皮肤id:" .. slot0.skinCo.id)

	slot1 = WebViewController.instance:getVideoUrl(slot0.skinCo.characterId)

	if UnityEngine.Application.version == "2.2.0" and GameChannelConfig.isLongCheng() and BootNativeUtil.isAndroid() then
		UnityEngine.Application.OpenURL(slot1)

		return
	end

	WebViewController.instance:openWebView(slot1, false, nil, , 0, nil, 0, 0, nil, true)
end

slot1 = ZProj.TweenHelper

function slot0._btnshowDetailOnClick(slot0)
	CharacterController.instance:openCharacterSkinFullScreenView(slot0.skinCo)
end

function slot0._btntagOnClick(slot0)
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = slot0.skinCo
	})
end

function slot0._btnbuyOnClick(slot0)
	slot1 = StoreClothesGoodsItemListModel.instance:getList()

	if slot0._allSkinList[slot0._currentSelectSkinIndex] and StoreModel.instance:getGoodsMO(slot2.goodsId) then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			goodsMO = slot2
		})
	else
		GameFacade.showToast(ToastEnum.StoreSkinPreview)
	end
end

function slot0._btnnotgetOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._showLive2d = true
	slot0._goSpine = GuiSpine.Create(slot0._gosmallspine, false)

	gohelper.setActive(slot0._go2d, slot0._showLive2d)
	gohelper.setActive(slot0._gol2d, slot0._showLive2d == false)

	slot0._txtswitch.text = slot0._showLive2d and "L2D" or luaLang("storeskinpreviewview_btnswitch")
	slot0._itemObjects = {}
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(gohelper.findChild(slot0.viewGO, "drag"))

	slot0._drag:AddDragBeginListener(slot0._onViewDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onViewDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onViewDragEnd, slot0)

	slot0._preDragAnchorPositionX = 0
	slot0._itemWidth = recthelper.getWidth(slot0._goskinItem.transform)
	slot0._scrollOneItemTime = 0.5
	slot0._scrollRate = slot0._itemWidth / slot0._scrollOneItemTime
	slot0._tweeningId = 0
	slot0._currentSelectSkinIndex = 0
	slot0._preSelectSkinIndex = 0
	slot0._minAnchorPositionX = 0
	slot0._minChangeAnchorPositionX = 100

	slot0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	slot0._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	slot0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))

	slot0.cardImage = gohelper.findChildSingleImage(slot0._goskinCard, "skinmask/skinicon")
	slot0._skincontainerCanvasGroup = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	slot0:refreshView()
end

function slot0.onOpenFinish(slot0)
	slot0:_disableClipAlpha()
end

function slot0.refreshView(slot0)
	slot0.goodsMO = slot0.viewParam.goodsMO
	slot0.skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot0.goodsMO.config.product, "#")[2])

	slot0:_refreshSkinList()
	slot0:_reallyRefreshView(slot0.skinCo)
end

function slot0._reallyRefreshView(slot0, slot1)
	slot0.skinCo = slot1

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0._simageskin:UnLoadImage()
	slot0._simagel2d:UnLoadImage()
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, slot0.skinCo.id)
	gohelper.setActive(slot0._btnswitch, slot0.skinCo.showSwitchBtn == 1)

	slot0._showLive2d = true

	gohelper.setActive(slot0._go2d, slot0._showLive2d)
	gohelper.setActive(slot0._gol2d, slot0._showLive2d == false)

	slot0._txtswitch.text = slot0._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	if not string.nilorempty(slot1.live2dbg) then
		gohelper.setActive(slot0._simagel2d.gameObject, slot0._showLive2d)
		gohelper.setActive(slot0._gozs, slot0._showLive2d)
		slot0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(slot2))
	else
		gohelper.setActive(slot0._simagel2d.gameObject, false)
		gohelper.setActive(slot0._gozs, false)
	end

	slot4 = not VersionValidator.instance:isInReviewing() and slot1.isSkinVideo

	logNormal("当前皮肤id:" .. " 是否可以播放视频: " .. tostring(slot4))
	gohelper.setActive(slot0._btnvideo, slot4)
	slot0:_refreshBigSkin()
	slot0:_refreshSkinInfo()
	slot0:_refreshSpine()
	slot0:_refreshStatus()
end

function slot0._refreshBigSkin(slot0)
	gohelper.setActive(slot0._gospinecontainer, slot0._showLive2d)
	gohelper.setActive(slot0._simageskin.gameObject, slot0._showLive2d == false)

	if slot0._showLive2d then
		if slot0._uiSpine == nil then
			slot0._uiSpine = GuiModelAgent.Create(slot0._gobigspine, true)

			slot0._uiSpine:setResPath(slot0.skinCo, slot0._onUISpineLoaded, slot0)
		else
			slot0:_onUISpineLoaded()
		end

		slot0._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		slot0._simageskin:LoadImage(ResUrl.getHeadIconImg(slot0.skinCo.id), slot0._loadedImage, slot0)

		slot0._txtswitch.text = "L2D"
	end
end

function slot0._onViewDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	slot0._animatorPlayer:Play(UIAnimationName.SwitchClose, slot0._onAnimDone, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function slot0._onAnimDone(slot0)
end

function slot0._onViewDrag(slot0, slot1, slot2)
	recthelper.setAnchorX(slot0._goskincontainer.transform, recthelper.getAnchorX(slot0._goskincontainer.transform) + slot2.delta.x * 1)

	slot0._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(slot0._startPos - slot2.position.x) * 0.007
end

function slot0._onViewDragEnd(slot0, slot1, slot2)
	slot4 = nil
	slot5 = true

	if slot0._startPos < slot2.position.x and slot3 - slot0._startPos >= 100 then
		if slot0._currentSelectSkinIndex - 1 == 0 then
			slot4 = #slot0._allSkinList
		end
	elseif slot3 < slot0._startPos and slot0._startPos - slot3 >= 100 then
		if slot0._currentSelectSkinIndex + 1 > #slot0._allSkinList then
			slot4 = 1
		end

		slot5 = false
	end

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	slot0._skincontainerCanvasGroup.alpha = 1

	if slot5 then
		slot0._animatorPlayer:Play("switch_openleft", slot0._disableClipAlpha, slot0)
	else
		slot0._animatorPlayer:Play("switch_openright", slot0._disableClipAlpha, slot0)
	end

	if slot4 then
		slot0._currentSelectSkinIndex = slot4

		slot0:_reallyRefreshView(SkinConfig.instance:getSkinCo(string.splitToNumber(slot0._allSkinList[slot0._currentSelectSkinIndex].config.product, "#")[2]))
	else
		slot0:_loadedImage()
	end
end

function slot0._onDragBegin(slot0)
	uv0.KillById(slot0._tweeningId)

	slot0._preDragAnchorPositionX = recthelper.getAnchorX(slot0._goContent.transform)
end

function slot0._onDrag(slot0)
	slot3 = slot0._currentSelectSkinIndex

	if slot0._minChangeAnchorPositionX < math.abs(recthelper.getAnchorX(slot0._goContent.transform) - slot0._preDragAnchorPositionX) then
		if slot1 < slot0._minAnchorPositionX then
			slot1 = slot0._minAnchorPositionX
		end

		if slot1 > 0 then
			slot1 = 0
		end

		slot4 = 0

		if slot1 < slot0._preDragAnchorPositionX then
			slot4 = 1

			if math.ceil(math.abs(slot1) / slot0._itemWidth) + 1 > #slot0._itemObjects then
				slot3 = #slot0._itemObjects
			end
		elseif slot0._preDragAnchorPositionX < slot1 then
			slot4 = 2

			if math.ceil(math.abs(slot1) / slot0._itemWidth) < 1 then
				slot3 = 1
			end
		end
	end

	if slot3 then
		slot4 = slot0._itemObjects[slot3]

		for slot8, slot9 in ipairs(slot0._itemObjects) do
			slot10 = slot3 == slot8 and 1 or 0.8

			transformhelper.setLocalScale(slot9.transSkinmask, slot10, slot10, slot10)
		end
	end
end

function slot0._onDragEnd(slot0)
	if math.abs(recthelper.getAnchorX(slot0._goContent.transform) - slot0._preDragAnchorPositionX) <= slot0._minChangeAnchorPositionX then
		slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, slot0._preDragAnchorPositionX, slot2 / slot0._scrollRate, slot0.onCompleteTween, slot0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rolesopen)

		if slot1 < slot0._minAnchorPositionX then
			slot1 = slot0._minAnchorPositionX
		end

		if slot1 > 0 then
			slot1 = 0
		end

		slot2 = 0
		slot0._preSelectSkinIndex = slot0._currentSelectSkinIndex

		if slot1 < slot0._preDragAnchorPositionX then
			slot0._currentSelectSkinIndex = math.ceil(math.abs(slot1) / slot0._itemWidth) + 1

			if slot0._currentSelectSkinIndex > #slot0._itemObjects then
				slot0._currentSelectSkinIndex = #slot0._itemObjects
			end

			if math.abs(slot1) % slot0._itemWidth == 0 then
				slot0:onCompleteTween()
				slot0:_reallyRefreshView(slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo)

				return
			end

			slot2 = slot0._itemWidth - slot2
		elseif slot0._preDragAnchorPositionX < slot1 then
			slot0._currentSelectSkinIndex = math.ceil(math.abs(slot1) / slot0._itemWidth)

			if slot0._currentSelectSkinIndex < 1 then
				slot0._currentSelectSkinIndex = 1
			end

			slot2 = math.abs(slot1) % slot0._itemWidth
		end

		slot0:_reallyRefreshView(slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo)

		slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth, slot2 / slot0._scrollRate, slot0.onCompleteTween, slot0)
	end

	if slot0._currentSelectSkinIndex then
		slot3 = slot0._itemObjects[slot0._currentSelectSkinIndex]

		for slot7, slot8 in ipairs(slot0._itemObjects) do
			slot9 = slot0._currentSelectSkinIndex == slot7 and 1 or 0.8

			transformhelper.setLocalScale(slot8.transSkinmask, slot9, slot9, slot9)
		end
	end
end

function slot0.onCompleteTween(slot0)
	slot0._tweeningId = 0

	gohelper.setActive(slot0._itemObjects[slot0._preSelectSkinIndex].goSelectedBg, false)
	gohelper.setActive(slot0._itemObjects[slot0._preSelectSkinIndex].goNotSelectedBg, true)
	gohelper.setActive(slot0._itemObjects[slot0._currentSelectSkinIndex].goSelectedBg, true)
	gohelper.setActive(slot0._itemObjects[slot0._currentSelectSkinIndex].goNotSelectedBg, false)
end

function slot0._refreshSkinInfo(slot0)
	slot1 = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId)

	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot1.signature))

	slot0._txtindex.text = ""
	slot0._txtcharacterName.text = slot1.name

	gohelper.setActive(slot0._txtskinName.gameObject, true)
	gohelper.setActive(slot0._txtskinNameEn.gameObject, true)

	slot0._txtskinName.text = slot0.skinCo.characterSkin
	slot0._txtskinNameEn.text = slot0.skinCo.characterSkinNameEng
	slot0._txtdesc.text = slot0.skinCo.skinDescription

	slot0.cardImage:LoadImage(ResUrl.getHeadSkinSmall(slot0.skinCo.id))
	gohelper.setActive(slot0._btntag.gameObject, string.nilorempty(slot0.skinCo.storeTag) == false)
end

function slot0._onUISpineLoaded(slot0)
	if string.nilorempty(slot0.skinCo.skinViewLive2dOffset) then
		slot1 = slot0.skinCo.characterViewOffset
	end

	recthelper.setAnchor(slot0._goskincontainer.transform, 0, 0)

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0._gobigspine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._gobigspine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageskin.gameObject)
	recthelper.setAnchor(slot0._goskincontainer.transform, 0, 0)

	if not string.nilorempty(slot0.skinCo.skinViewImgOffset) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._simageskin.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._simageskin.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	else
		recthelper.setAnchor(slot0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(slot0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function slot0._refreshSpine(slot0)
	slot0._goSpine:stopVoice()
	slot0._goSpine:setResPath(ResUrl.getSpineUIPrefab(slot0.skinCo.spine), slot0._onSpineLoaded, slot0, true)

	slot1 = SkinConfig.instance:getSkinOffset(slot0.skinCo.skinSpineOffset)

	recthelper.setAnchor(slot0._gosmallspine.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._gosmallspine.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
end

function slot0._refreshStatus(slot0)
	gohelper.setActive(slot0._btnbuy.gameObject, slot0._allSkinList[slot0._currentSelectSkinIndex]:alreadyHas() == false)
	gohelper.setActive(slot0._gohas, slot2)

	if slot2 == false then
		slot3 = string.splitToNumber(slot1.config.cost, "#")
		slot0._costType = slot3[1]
		slot0._costId = slot3[2]
		slot0._costQuantity = slot3[3]
		slot0._txtprice.text = slot0._costQuantity
		slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageicon, string.format("%s_1", slot4.icon))
	end
end

function slot0._refreshSkinList(slot0)
	slot0._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	for slot4, slot5 in ipairs(slot0._allSkinList) do
		if slot0.goodsMO.goodsId == slot5.goodsId then
			slot0._currentSelectSkinIndex = slot4
		end
	end
end

function slot0._initSkinItem(slot0, slot1, slot2, slot3)
	slot4 = {
		goodsMO = slot3,
		skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot3.config.product, "#")[2]),
		image = slot8
	}
	slot8 = gohelper.findChildSingleImage(slot1, "skinmask/skinicon")
	gohelper.findChildText(slot1, "skinIndex/txtSkinIndex").text = string.format("%02d", slot2)

	slot8:LoadImage(ResUrl.getHeadSkinSmall(slot4.skinCo.id))

	slot4.goSelectedBg = gohelper.findChild(slot1, "skinIndex/selectBg")
	slot4.transSkinmask = gohelper.findChild(slot1, "skinmask").transform
	slot4.goNotSelectedBg = gohelper.findChild(slot1, "skinIndex/notSelectBg")
	slot9 = gohelper.getClick(slot8.gameObject)

	slot9:AddClickListener(slot0._onItemClick, slot0, slot2)

	slot4.click = slot9

	gohelper.setActive(slot4.goSelectedBg, slot0.goodsMO == slot3)
	gohelper.setActive(slot4.goNotSelectedBg, slot0.goodsMO == slot3)

	slot10 = 0.8

	if slot0.goodsMO == slot3 then
		slot10 = 1
		slot0._currentSelectSkinIndex = slot2
		slot0._preSelectSkinIndex = slot2
	end

	transformhelper.setLocalScale(slot4.transSkinmask, slot10, slot10, slot10)
	gohelper.setActive(slot1, true)
	table.insert(slot0._itemObjects, slot4)
end

function slot0._onItemClick(slot0, slot1)
	if slot0._currentSelectSkinIndex == slot1 then
		return
	end

	uv0.KillById(slot0._tweeningId)

	slot0._preSelectSkinIndex = slot0._currentSelectSkinIndex
	slot0._currentSelectSkinIndex = slot1

	slot0:_reallyRefreshView(slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo)

	slot6 = AudioEnum.UI.play_ui_character_skin_switch

	AudioMgr.instance:trigger(slot6)

	for slot6, slot7 in ipairs(slot0._itemObjects) do
		slot8 = slot0._currentSelectSkinIndex == slot6 and 1 or 0.8

		transformhelper.setLocalScale(slot7.transSkinmask, slot8, slot8, slot8)
	end

	slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth, 0.5, slot0.onCompleteTween, slot0)
end

function slot0._onSpineLoaded(slot0)
end

function slot0.onClose(slot0)
	slot0._simageskin:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagel2d:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._itemObjects) do
		slot5.image:UnLoadImage()
		slot5.click:RemoveClickListener()
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	TaskDispatcher.cancelTask(slot0._refreshBigSkin)
end

function slot0.onCloseFinish(slot0)
	slot0:_disableClipAlpha()
end

function slot0.onDestroyView(slot0)
	if slot0._goSpine then
		slot0._goSpine:stopVoice()

		slot0._goSpine = nil
	end

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageshowbg:UnLoadImage()
	slot0:_disableClipAlpha()
end

function slot0._disableClipAlpha(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return slot0
