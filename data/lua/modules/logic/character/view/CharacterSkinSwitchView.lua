module("modules.logic.character.view.CharacterSkinSwitchView", package.seeall)

slot0 = class("CharacterSkinSwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gozs = gohelper.findChild(slot0.viewGO, "#go_zs")
	slot0._gosmallspine = gohelper.findChild(slot0.viewGO, "smalldynamiccontainer/#go_smallspine")
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer")
	slot0._simageskin = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	slot0._simagel2d = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	slot0._gobigspine = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	slot0._gospinecontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	slot0._simagebgmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgmask")
	slot0._gogetIcno = gohelper.findChild(slot0.viewGO, "desc/#go_getIcno")
	slot0._gonotgetIcno = gohelper.findChild(slot0.viewGO, "desc/#go_notgetIcno")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signature")
	slot0._simagesignatureicon = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signatureicon")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "desc/#txt_index")
	slot0._txtcharacterName = gohelper.findChildText(slot0.viewGO, "desc/#txt_characterName")
	slot0._txtskinName = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName")
	slot0._txtskinNameEn = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "desc/#txt_desc")
	slot0._btnshowDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	slot0._simageskinSwitchBg = gohelper.findChildSingleImage(slot0.viewGO, "container/#simage_skinSwitchBg")
	slot0._scrollskinSwitch = gohelper.findChildScrollRect(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	slot0._gopreEmpty = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	slot0._goskinItem = gohelper.findChild(slot0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	slot0._btndress = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/skinSwitch/dressState/#btn_dress")
	slot0._btnnotget = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/skinSwitch/dressState/#btn_notget")
	slot0._btnrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/skinSwitch/dressState/#btn_rank")
	slot0._btnskinstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/skinSwitch/dressState/#btn_skinstore")
	slot0._godressing = gohelper.findChild(slot0.viewGO, "container/skinSwitch/dressState/#go_dressing")
	slot0._goactivityget = gohelper.findChild(slot0.viewGO, "container/skinSwitch/dressState/#go_activityget")
	slot0._gobtntopleft = gohelper.findChild(slot0.viewGO, "#go_btntopleft")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._btntag = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_tag")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#btn_switch")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "desc/#btn_switch/#txt_switch")
	slot0._go2d = gohelper.findChild(slot0.viewGO, "desc/#btn_switch/#go_2d")
	slot0._gol2d = gohelper.findChild(slot0.viewGO, "desc/#btn_switch/#go_l2d")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowDetail:AddClickListener(slot0._btnshowDetailOnClick, slot0)
	slot0._btndress:AddClickListener(slot0._btndressOnClick, slot0)
	slot0._btnnotget:AddClickListener(slot0._btnnotgetOnClick, slot0)
	slot0._btnrank:AddClickListener(slot0._btnrankOnClick, slot0)
	slot0._btnskinstore:AddClickListener(slot0._btnskinstoreOnClick, slot0)
	slot0._btntag:AddClickListener(slot0._btntagOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowDetail:RemoveClickListener()
	slot0._btndress:RemoveClickListener()
	slot0._btnnotget:RemoveClickListener()
	slot0._btnrank:RemoveClickListener()
	slot0._btnskinstore:RemoveClickListener()
	slot0._btntag:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
end

slot1 = ZProj.TweenHelper
slot0.SkinStoreId = 500
slot0.TweenTime = 0.2
slot0.NormalAnimationTimeDuration = 0.33

function slot0._btnswitchOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	slot0._showLive2d = slot0._showLive2d == false

	gohelper.setActive(slot0._go2d, slot0._showLive2d)
	gohelper.setActive(slot0._gol2d, slot0._showLive2d == false)

	slot0._txtswitch.text = slot0._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	slot0._viewAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(slot0._refreshStaticVertical, slot0, 0.16)
end

function slot0._btnshowDetailOnClick(slot0)
	CharacterController.instance:openCharacterSkinFullScreenView(slot0.skinCo, false, slot0._showLive2d and CharacterEnum.ShowSkinEnum.Dynamic or CharacterEnum.ShowSkinEnum.Static)
end

function slot0._btndressOnClick(slot0)
	HeroRpc.instance:sendUseSkinRequest(slot0.viewParam.heroId, slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo.id)
end

function slot0._btnnotgetOnClick(slot0)
	if slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo and slot1.jump and slot1.jump > 0 then
		GameFacade.jump(slot1.jump)
	end
end

function slot0._btnrankOnClick(slot0)
	CharacterController.instance:openCharacterRankUpView(HeroModel.instance:getByHeroId(slot0.skinCo.characterId))
end

function slot0._btntagOnClick(slot0)
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = slot0.skinCo
	})
end

function slot0._btnskinstoreOnClick(slot0)
	if not StoreModel.instance:isTabOpen(uv0.SkinStoreId) then
		return
	end

	StoreController.instance:openStoreView(uv0.SkinStoreId)
end

function slot0._onOpenView(slot0, slot1)
	if slot0._showLive2d and slot1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(slot0._gospinecontainer, false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot0._showLive2d and slot1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(slot0._gospinecontainer, true)
	end
end

function slot0._editableInitView(slot0)
	slot0._showLive2d = true

	gohelper.setActive(slot0._go2d, slot0._showLive2d)
	gohelper.setActive(slot0._gol2d, slot0._showLive2d == false)

	slot0._txtswitch.text = slot0._showLive2d and "L2D" or luaLang("storeskinpreviewview_btnswitch")
	slot0.goDesc = gohelper.findChild(slot0.viewGO, "desc")
	slot0.goDynamicContainer = gohelper.findChild(slot0.viewGO, "smalldynamiccontainer")
	slot0._goSpine = GuiSpine.Create(slot0._gosmallspine, false)
	slot0._itemObjects = {}
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollskinSwitch.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)

	slot0._preDragAnchorPositionX = 0
	slot0._itemWidth = recthelper.getWidth(slot0._goskinItem.transform)
	slot0._scrollOneItemTime = 0.5
	slot0._scrollRate = slot0._itemWidth / slot0._scrollOneItemTime
	slot0._tweeningId = 0
	slot0._currentSelectSkinIndex = 0
	slot0._preSelectSkinIndex = 0
	slot0._hadSkinDict = {}
	slot0._minAnchorPositionX = 0
	slot0._minChangeAnchorPositionX = 100

	slot0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	slot0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	slot0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	slot0._skincontainerCanvasGroup = slot0._goskincontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.halfAnimationTime = uv0.TweenTime / 2

	slot0:_clearBtnStatus()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._hadSkinDict = {}

	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0.viewParam.config.signature, "characterget"))
	slot0:refreshView()
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._successDressUpSkin, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0.refreshView, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.refreshView(slot0)
	slot4 = slot0.viewParam.skin
	slot0.skinCo = SkinConfig.instance:getSkinCo(slot4)
	slot0._hadSkinDict[slot0.viewParam.config.skinId] = true

	for slot4, slot5 in ipairs(slot0.viewParam.skinInfoList) do
		slot0._hadSkinDict[slot5.skin] = true
	end

	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0.viewParam.config.signature, "characterget"))
	slot0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	gohelper.setActive(slot0._simagesignatureicon.gameObject, slot0.viewParam.config.signature == "3011")
	slot0:_refreshSkinList()
	slot0:_reallyRefreshView()
end

function slot0._reallyRefreshView(slot0)
	slot0:_resetRes()
	slot0:_refreshStaticVertical()
	slot0:_refreshSkinInfo()
	slot0:_refreshSpine()
	slot0:_refreshDressBtnStatus()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSkinSwitchSpine, slot0.skinCo.id)
end

function slot0._resetRes(slot0)
	gohelper.setActive(slot0._btnswitch, slot0.skinCo.showSwitchBtn == 1)

	slot0._showLive2d = false

	gohelper.setActive(slot0._go2d, slot0._showLive2d)
	gohelper.setActive(slot0._gol2d, slot0._showLive2d == false)

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0._simageskin:UnLoadImage()
	slot0._simagel2d:UnLoadImage()
end

function slot0._refreshStaticVertical(slot0)
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

	if not string.nilorempty(slot0.skinCo.live2dbg) then
		gohelper.setActive(slot0._simagel2d.gameObject, slot0._showLive2d)
		slot0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(slot1))
		gohelper.setActive(slot0._gozs, slot0._showLive2d)
	else
		gohelper.setActive(slot0._simagel2d.gameObject, false)
		gohelper.setActive(slot0._gozs, false)
	end
end

function slot0._refreshSelectSkin(slot0)
	gohelper.setActive(slot0._itemObjects[slot0._preSelectSkinIndex].goNewSelect, false)
	gohelper.setActive(slot0._itemObjects[slot0._currentSelectSkinIndex].goNewSelect, true)
end

function slot0._successDressUpSkin(slot0)
	slot0:_refreshDressBtnStatus()
	slot0:_refreshSelectSkin()
end

function slot0._onDragBegin(slot0)
	uv0.KillById(slot0._tweeningId)

	slot0._preDragAnchorPositionX = recthelper.getAnchorX(slot0._goContent.transform)
	slot0.playAnimation = false
end

function slot0._onDrag(slot0)
	slot0._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(slot0._preDragAnchorPositionX - recthelper.getAnchorX(slot0._goContent.transform)) * 0.005

	if slot0.playAnimation then
		return
	end

	if slot0._currentSelectSkinIndex == 1 then
		if slot1 <= 0 then
			slot0.playAnimation = false
		else
			slot0.playAnimation = true
		end
	elseif slot0._currentSelectSkinIndex == slot0.skinCount then
		if slot1 >= 0 then
			slot0.playAnimation = false
		else
			slot0.playAnimation = true
		end
	else
		slot0.playAnimation = true
	end

	if slot0.playAnimation then
		slot0._viewAnim:Play(UIAnimationName.SwitchClose, 0, 0)
	end
end

function slot0._onDragEnd(slot0)
	if slot0.playAnimation then
		slot0._viewAnim:Play(UIAnimationName.SwitchOpen, 0, 0)
	end

	slot0._skincontainerCanvasGroup.alpha = 1

	if math.abs(recthelper.getAnchorX(slot0._goContent.transform) - slot0._preDragAnchorPositionX) <= slot0._minChangeAnchorPositionX then
		slot0:killTween()

		slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, slot0._preDragAnchorPositionX, slot2 / slot0._scrollRate, slot0.onCompleteTween, slot0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

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

				slot0.skinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo

				slot0:_reallyRefreshView()

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

		slot0.skinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo

		slot0:_reallyRefreshView()
		slot0:killTween()

		slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth, slot2 / slot0._scrollRate, slot0.onCompleteTween, slot0)
	end

	if slot0._currentSelectSkinIndex then
		slot3 = slot0._itemObjects[slot0._currentSelectSkinIndex]

		for slot7, slot8 in ipairs(slot0._itemObjects) do
			slot9 = slot0._currentSelectSkinIndex == slot7 and 1 or 0.9

			transformhelper.setLocalScale(slot8.transSkinmask, slot9, slot9, slot9)
		end
	end
end

function slot0.getSkinIndex(slot0)
	for slot4, slot5 in ipairs(slot0._itemObjects) do
		if slot5.skinCo.id == slot0.skinCo.id then
			return slot4
		end
	end

	return 0
end

function slot0._refreshSkinInfo(slot0)
	if slot0.skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not slot0._hadSkinDict[slot0.skinCo.id] then
		gohelper.setActive(slot0.goDesc, false)

		return
	end

	gohelper.setActive(slot0.goDesc, true)

	slot1 = slot0:getSkinIndex()
	slot0._txtindex.text = string.format("%02d", slot1)
	slot0._txtcharacterName.text = slot0.viewParam.config.name

	if slot1 == 1 then
		gohelper.setActive(slot0._txtskinName.gameObject, false)
		gohelper.setActive(slot0._txtskinNameEn.gameObject, false)
	else
		slot0._txtskinName.text = slot0.skinCo.characterSkin
		slot0._txtskinNameEn.text = slot0.skinCo.characterSkinNameEng

		gohelper.setActive(slot0._txtskinName.gameObject, true)
		gohelper.setActive(slot0._txtskinNameEn.gameObject, GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN)
	end

	slot0._txtdesc.text = slot0.skinCo.skinDescription

	gohelper.setActive(slot0._btntag.gameObject, string.nilorempty(slot0.skinCo.storeTag) == false)
end

function slot0._onUISpineLoaded(slot0)
	slot0._skincontainerCanvasGroup.alpha = 1

	if string.nilorempty(slot0.skinCo.skinViewLive2dOffset) then
		slot1 = slot0.skinCo.characterViewOffset
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0._gobigspine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._gobigspine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageskin.gameObject)

	slot0._skincontainerCanvasGroup.alpha = 1

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
	if slot0.skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not slot0._hadSkinDict[slot0.skinCo.id] then
		gohelper.setActive(slot0.goDynamicContainer, false)

		return
	end

	gohelper.setActive(slot0.goDynamicContainer, true)
	slot0._goSpine:stopVoice()
	slot0._goSpine:setResPath(ResUrl.getSpineUIPrefab(slot0.skinCo.spine), slot0._onSpineLoaded, slot0, true)

	slot1 = SkinConfig.instance:getSkinOffset(slot0.skinCo.skinSpineOffset)

	recthelper.setAnchor(slot0._gosmallspine.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._gosmallspine.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
end

function slot0._refreshSkinList(slot0)
	if SkinConfig.instance:getCharacterSkinCoList(slot0.viewParam.heroId) == nil or #slot1 == 0 then
		logError("get skin config list failed,, heroid is : " .. tostring(slot0.viewParam.heroId))
	end

	slot0.skinCount = #slot1

	gohelper.setActive(slot0._goskinItem, false)

	slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		slot2 = slot0._itemObjects[slot7] or slot0:createSkinItem()

		slot2.image:LoadImage(ResUrl.getHeadSkinSmall(slot8.id))

		slot2.index = slot7
		slot2.skinCo = slot8

		if slot0.viewParam.skin == slot8.id then
			slot3 = 1
			slot0._currentSelectSkinIndex = slot7
			slot0._preSelectSkinIndex = slot7
		else
			slot3 = 0.9
		end

		transformhelper.setLocalScale(slot2.transSkinmask, slot3, slot3, slot3)
	end

	slot0._minAnchorPositionX = -((#slot1 - 1) * slot0._itemWidth)

	gohelper.cloneInPlace(slot0._gopreEmpty, "suffixEmpty")

	if slot0._currentSelectSkinIndex == 0 then
		logError("init view error, not selected skin")

		slot0._currentSelectSkinIndex = 1
	end

	slot0:_refreshSelectSkin()
	recthelper.setAnchorX(slot0._goContent.transform, -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth)
end

function slot0.createSkinItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot2 = gohelper.cloneInPlace(slot0._goskinItem, "skinItem")
	slot1.image = gohelper.findChildSingleImage(slot2, "skinmask/skinicon")
	slot1.transSkinmask = gohelper.findChild(slot2, "skinmask").transform
	slot1.goNewSelect = gohelper.findChild(slot2, "skinmask/#go_select")

	gohelper.setActive(slot1.goNewSelect, false)

	slot3 = gohelper.getClick(slot1.image.gameObject)

	slot3:AddClickListener(slot0._onItemClick, slot0, slot1)

	slot1.click = slot3

	gohelper.setActive(slot2, true)
	table.insert(slot0._itemObjects, slot1)

	return slot1
end

function slot0._onItemClick(slot0, slot1)
	if slot0._currentSelectSkinIndex == slot1.index then
		return
	end

	slot0._preSelectSkinIndex = slot0._currentSelectSkinIndex
	slot0._currentSelectSkinIndex = slot2
	slot0.skinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo
	slot7 = AudioEnum.UI.play_ui_character_skin_switch

	AudioMgr.instance:trigger(slot7)

	for slot7, slot8 in ipairs(slot0._itemObjects) do
		slot9 = slot0._currentSelectSkinIndex == slot7 and 1 or 0.9

		transformhelper.setLocalScale(slot8.transSkinmask, slot9, slot9, slot9)
	end

	slot0.startAnchorPositionX = slot0._goContent.transform.anchoredPosition.x
	slot0.endAnchorPositionX = -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth

	slot0:killTween()

	slot0._tweeningId = uv0.DOTweenFloat(0, 1, uv1.TweenTime, slot0.tweenFrameCallback, slot0.onCompleteTween, slot0)

	slot0:destroyFlow()

	slot0.workFlow = FlowSequence.New()

	slot0.workFlow:addWork(DelayFuncWork.New(slot0.beforeFlow, slot0, 0))
	slot0.workFlow:addWork(DelayFuncWork.New(slot0.playCloseAnimation, slot0, 0.16))
	slot0.workFlow:addWork(DelayFuncWork.New(slot0._reallyRefreshView, slot0, 0))
	slot0.workFlow:addWork(DelayFuncWork.New(slot0.playOpenAnimation, slot0, 0.33))
	slot0.workFlow:registerDoneListener(slot0.onFlowDone, slot0)
	slot0.workFlow:start()
end

function slot0.beforeFlow(slot0)
	slot0._viewAnim.speed = uv0.NormalAnimationTimeDuration / slot0.halfAnimationTime
end

function slot0.playCloseAnimation(slot0)
	slot0._viewAnim:Play("clickclose", 0, 0)
end

function slot0.playOpenAnimation(slot0)
	slot0._viewAnim:Play(UIAnimationName.SwitchOpen, 0, 0)
end

function slot0.onFlowDone(slot0)
	slot0._viewAnim.speed = 1
end

function slot0.tweenFrameCallback(slot0, slot1)
	recthelper.setAnchorX(slot0._goContent.transform, Mathf.Lerp(slot0.startAnchorPositionX, slot0.endAnchorPositionX, slot1))
end

function slot0.onCompleteTween(slot0)
	slot0._tweeningId = 0
end

function slot0._refreshDressBtnStatus(slot0)
	slot0:_clearBtnStatus()

	if slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo.id == slot0.viewParam.skin then
		gohelper.setActive(slot0._godressing, true)
	elseif slot0._hadSkinDict[slot2.id] then
		gohelper.setActive(slot0._btndress.gameObject, true)
	elseif slot2.gainApproach == CharacterEnum.SkinGainApproach.Rank then
		gohelper.setActive(slot0._btnrank.gameObject, true)
	elseif slot2.gainApproach == CharacterEnum.SkinGainApproach.Activity then
		gohelper.setActive(slot0._goactivityget, true)
	elseif slot2.gainApproach == CharacterEnum.SkinGainApproach.Store then
		if not StoreModel.instance:isTabOpen(uv0.SkinStoreId) then
			gohelper.setActive(slot0._goactivityget, true)
		else
			gohelper.setActive(slot0._btnskinstore.gameObject, true)
		end
	else
		gohelper.setActive(slot0._btnnotget.gameObject, true)
	end
end

function slot0._clearBtnStatus(slot0)
	gohelper.setActive(slot0._btndress.gameObject, false)
	gohelper.setActive(slot0._btnnotget.gameObject, false)
	gohelper.setActive(slot0._btnrank.gameObject, false)
	gohelper.setActive(slot0._btnskinstore.gameObject, false)
	gohelper.setActive(slot0._godressing, false)
	gohelper.setActive(slot0._goactivityget, false)
end

function slot0._onSpineLoaded(slot0)
end

function slot0.killTween(slot0)
	if slot0._tweeningId and slot0._tweeningId ~= 0 then
		uv0.KillById(slot0._tweeningId)
	end
end

function slot0.destroyFlow(slot0)
	if slot0.workFlow then
		slot0.workFlow:destroy()

		slot0.workFlow = nil
	end
end

function slot0.onClose(slot0)
	slot0:killTween()
	slot0._simageskin:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignatureicon:UnLoadImage()
	slot0._simagel2d:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._itemObjects) do
		slot5.image:UnLoadImage()
		slot5.click:RemoveClickListener()
	end

	if slot0._uiSpine then
		slot0._uiSpine:setModelVisible(false)
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()
end

function slot0.onDestroyView(slot0)
	slot0:destroyFlow()

	if slot0._goSpine then
		slot0._goSpine:stopVoice()

		slot0._goSpine = nil
	end

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagebgmask:UnLoadImage()
	slot0._simageskinSwitchBg:UnLoadImage()
end

return slot0
