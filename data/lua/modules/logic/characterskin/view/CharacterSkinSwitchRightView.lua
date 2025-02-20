module("modules.logic.characterskin.view.CharacterSkinSwitchRightView", package.seeall)

slot0 = class("CharacterSkinSwitchRightView", BaseView)

function slot0.onInitView(slot0)
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer")
	slot0._simageskinSwitchBg = gohelper.findChildSingleImage(slot0.viewGO, "container/#simage_skinSwitchBg")
	slot0._scrollskinSwitch = gohelper.findChildScrollRect(slot0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	slot0._gopreEmpty = gohelper.findChild(slot0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	slot0._goskinItem = gohelper.findChild(slot0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	slot0._btndress = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/normal/skinSwitch/dressState/#btn_dress")
	slot0._btnnotget = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/normal/skinSwitch/dressState/#btn_notget")
	slot0._btnrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/normal/skinSwitch/dressState/#btn_rank")
	slot0._btnskinstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/normal/skinSwitch/dressState/#btn_skinstore")
	slot0._btngotogetskin = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/normal/skinSwitch/dressState/#btn_GO")
	slot0._godressing = gohelper.findChild(slot0.viewGO, "container/normal/skinSwitch/dressState/#go_dressing")
	slot0._goactivityget = gohelper.findChild(slot0.viewGO, "container/normal/skinSwitch/dressState/#go_activityget")
	slot0._txtapproach = gohelper.findChildText(slot0.viewGO, "container/normal/skinSwitch/dressState/#go_activityget/txt")
	slot0._txtapproachEN = gohelper.findChildText(slot0.viewGO, "container/normal/skinSwitch/dressState/#go_activityget/txt/txtEn")
	slot0._gobtntopleft = gohelper.findChild(slot0.viewGO, "#go_btntopleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndress:AddClickListener(slot0._btndressOnClick, slot0)
	slot0._btnnotget:AddClickListener(slot0._btnnotgetOnClick, slot0)
	slot0._btnrank:AddClickListener(slot0._btnrankOnClick, slot0)
	slot0._btnskinstore:AddClickListener(slot0._btnskinstoreOnClick, slot0)
	slot0._btngotogetskin:AddClickListener(slot0._btngotoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndress:RemoveClickListener()
	slot0._btnnotget:RemoveClickListener()
	slot0._btnrank:RemoveClickListener()
	slot0._btnskinstore:RemoveClickListener()
	slot0._btngotogetskin:RemoveClickListener()
end

slot1 = ZProj.TweenHelper
slot0.SkinStoreId = 500
slot0.RealSkinStoreId = 510
slot0.TweenTime = 0.2
slot0.NormalAnimationTimeDuration = 0.33

function slot0._btndressOnClick(slot0)
	HeroRpc.instance:sendUseSkinRequest(slot0.heroMo.heroId, slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo.id)
end

function slot0._btnnotgetOnClick(slot0)
	if slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo and slot1.jump and slot1.jump > 0 then
		GameFacade.jump(slot1.jump)
	end
end

function slot0._btnrankOnClick(slot0)
	CharacterController.instance:openCharacterRankUpView(slot0.heroMo)
end

function slot0._btnskinstoreOnClick(slot0)
	if not StoreModel.instance:isTabOpen(uv0.SkinStoreId) then
		return
	end

	StoreController.instance:openStoreView(uv0.SkinStoreId)
end

function slot0._btngotoOnClick(slot0)
	if slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo.gainApproach == CharacterEnum.SkinGainApproach.BPReward then
		if slot2.id == BpConfig.instance:getCurSkinId(BpModel.instance.id) then
			JumpController.instance:jump(48)
		end
	elseif ActivityModel.instance:getActMO(slot3) then
		slot4 = slot3

		if slot2 and slot2.jump and slot2.jump > 0 then
			GameFacade.jump(slot2.jump)
		end
	elseif slot3 == CharacterEnum.SkinGainApproach.Permanent and slot2 and slot2.jump and slot2.jump > 0 then
		GameFacade.jump(slot2.jump)
	end
end

function slot0.refreshRightContainer(slot0)
	slot0.goSkinNormalContainer = gohelper.findChild(slot0.viewGO, "container/normal")
	slot0.goSkinTipContainer = gohelper.findChild(slot0.viewGO, "container/skinTip")
	slot0.goSkinStoreContainer = gohelper.findChild(slot0.viewGO, "container/skinStore")

	gohelper.setActive(slot0.goSkinNormalContainer, true)
	gohelper.setActive(slot0.goSkinTipContainer, false)
	gohelper.setActive(slot0.goSkinStoreContainer, false)
end

function slot0._editableInitView(slot0)
	slot0:refreshRightContainer()
	gohelper.setActive(slot0._goskinItem, false)

	slot0.goDesc = gohelper.findChild(slot0.viewGO, "desc")
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
	slot0._hadSkinDict = {}
	slot0._minAnchorPositionX = 0
	slot0._minChangeAnchorPositionX = 100

	slot0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	slot0._skincontainerCanvasGroup = slot0._goskincontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.halfAnimationTime = uv0.TweenTime / 2
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0.animationEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0.animationEventWrap:AddEventListener("refreshUI", slot0.refreshUI, slot0)
	slot0:_clearBtnStatus()
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._successDressUpSkin, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0.onOpen, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.GainSkin, slot0.onGainSkin, slot0)
end

function slot0.initViewParam(slot0)
	slot0.heroMo = slot0.viewParam
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, slot0.viewName)
	slot0:initViewParam()
	slot0:refreshHadSkinDict()
	slot0:initSkinItem()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:_refreshDressBtnStatus()
	slot0:refreshLeftUI()
end

function slot0.refreshHadSkinDict(slot0)
	slot0._hadSkinDict = {}

	for slot5, slot6 in ipairs(SkinConfig.instance:getCharacterSkinCoList(slot0.viewParam.heroId)) do
		slot0._hadSkinDict[slot6.id] = HeroModel.instance:checkHasSkin(slot6.id)
	end
end

function slot0.initSkinItem(slot0)
	if SkinConfig.instance:getCharacterSkinCoList(slot0.heroMo.heroId) == nil or #slot1 == 0 then
		logError("get skin config list failed,, heroid is : " .. tostring(slot0.heroMo.heroId))
	end

	slot0.skinCount = #slot1
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		slot2 = slot0._itemObjects[slot7] or slot0:createSkinItem()

		slot2.image:LoadImage(ResUrl.getHeadSkinSmall(slot8.id))

		slot2.index = slot7
		slot2.skinCo = slot8

		if slot0.heroMo.skin == slot8.id then
			slot3 = 1
			slot0._currentSelectSkinIndex = slot7
		else
			slot3 = 0.9
		end

		transformhelper.setLocalScale(slot2.transSkinmask, slot3, slot3, slot3)
	end

	slot0._minAnchorPositionX = -((slot0.skinCount - 1) * slot0._itemWidth)

	gohelper.cloneInPlace(slot0._gopreEmpty, "suffixEmpty")

	if slot0._currentSelectSkinIndex == 0 then
		logError("init view error, not selected skin")

		slot0._currentSelectSkinIndex = 1
	end

	slot0.selectSkinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo

	slot0:_refreshDressedSkin(slot0.heroMo.skin)
	recthelper.setAnchorX(slot0._goContent.transform, -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth)
end

function slot0._refreshDressedSkin(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._itemObjects) do
		gohelper.setActive(slot6.goNewSelect, slot6.skinCo.id == slot1)
	end
end

function slot0.refreshLeftUI(slot0)
	slot0:_refreshSkinInfo()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, slot0.selectSkinCo, slot0.viewName)
end

function slot0._refreshSkinInfo(slot0)
	if slot0.selectSkinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not slot0._hadSkinDict[slot0.selectSkinCo.id] then
		gohelper.setActive(slot0.goDesc, false)

		return
	end

	gohelper.setActive(slot0.goDesc, true)
end

function slot0._onDragBegin(slot0)
	uv0.KillById(slot0._tweeningId)

	slot0._preDragAnchorPositionX = recthelper.getAnchorX(slot0._goContent.transform)
	slot0.playAnimation = false
	slot0.dragging = true

	slot0:setShaderKeyWord()
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
		slot0:playAnim("skinclose")
	end
end

function slot0._onDragEnd(slot0)
	if slot0.playAnimation then
		slot0:playAnim("skinopen")
	end

	slot0._skincontainerCanvasGroup.alpha = 1

	if math.abs(recthelper.getAnchorX(slot0._goContent.transform) - slot0._preDragAnchorPositionX) <= slot0._minChangeAnchorPositionX then
		slot0:killTween()

		slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, slot0._preDragAnchorPositionX, slot2 / slot0._scrollRate, slot0.onCompleteTween, slot0)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, slot0.viewName)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

		if slot1 < slot0._minAnchorPositionX then
			slot1 = slot0._minAnchorPositionX
		end

		if slot1 > 0 then
			slot1 = 0
		end

		slot2 = 0

		if slot1 < slot0._preDragAnchorPositionX then
			slot0._currentSelectSkinIndex = math.ceil(math.abs(slot1) / slot0._itemWidth) + 1

			if slot0._currentSelectSkinIndex > #slot0._itemObjects then
				slot0._currentSelectSkinIndex = #slot0._itemObjects
			end

			if math.abs(slot1) % slot0._itemWidth == 0 then
				slot0:onCompleteTween()

				slot0.selectSkinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo

				slot0:refreshUI()

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

		slot0.selectSkinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo

		slot0:refreshUI()
		slot0:killTween()

		slot0._tweeningId = uv0.DOAnchorPosX(slot0._goContent.transform, -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth, slot2 / slot0._scrollRate, slot0.onCompleteTween, slot0)
	end

	if slot0._currentSelectSkinIndex then
		for slot6, slot7 in ipairs(slot0._itemObjects) do
			slot8 = slot0._currentSelectSkinIndex == slot6 and 1 or 0.9

			transformhelper.setLocalScale(slot7.transSkinmask, slot8, slot8, slot8)
		end
	end

	slot0.dragging = false

	slot0:setShaderKeyWord()
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

	slot0._currentSelectSkinIndex = slot2
	slot0.selectSkinCo = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo
	slot7 = AudioEnum.UI.play_ui_character_skin_switch

	AudioMgr.instance:trigger(slot7)

	for slot7, slot8 in ipairs(slot0._itemObjects) do
		slot9 = slot0._currentSelectSkinIndex == slot7 and 1 or 0.9

		transformhelper.setLocalScale(slot8.transSkinmask, slot9, slot9, slot9)
	end

	slot0.startAnchorPositionX = slot0._goContent.transform.anchoredPosition.x
	slot0.endAnchorPositionX = -(slot0._currentSelectSkinIndex - 1) * slot0._itemWidth

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, slot0.viewName)
	slot0:killTween()

	slot0._tweeningId = uv0.DOTweenFloat(0, 1, uv1.TweenTime, slot0.tweenFrameCallback, slot0.onCompleteTween, slot0)

	slot0:playAnim(UIAnimationName.Switch)
end

function slot0.tweenFrameCallback(slot0, slot1)
	recthelper.setAnchorX(slot0._goContent.transform, Mathf.Lerp(slot0.startAnchorPositionX, slot0.endAnchorPositionX, slot1))
end

function slot0.onCompleteTween(slot0)
	slot0._tweeningId = 0
end

function slot0._refreshDressBtnStatus(slot0)
	slot0:_clearBtnStatus()

	slot2 = slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo
	slot3 = slot2.gainApproach

	if slot2.id == slot0.heroMo.skin then
		gohelper.setActive(slot0._godressing, true)
	elseif slot0._hadSkinDict[slot2.id] then
		gohelper.setActive(slot0._btndress.gameObject, true)
	elseif slot3 == CharacterEnum.SkinGainApproach.Rank then
		gohelper.setActive(slot0._btnrank.gameObject, true)
	elseif slot3 == CharacterEnum.SkinGainApproach.Activity then
		gohelper.setActive(slot0._goactivityget, true)

		slot0._txtapproach.text = luaLang("skin_gain_approach_activity_zh")
		slot0._txtapproachEN.text = luaLang("skin_gain_approach_activity_en")
	elseif slot3 == CharacterEnum.SkinGainApproach.Store then
		if StoreModel.instance:isStoreSkinChargePackageValid(slot2.id) then
			gohelper.setActive(slot0._btnskinstore.gameObject, true)
		else
			gohelper.setActive(slot0._goactivityget, true)

			slot0._txtapproach.text = luaLang("skin_gain_approach_store_zh")
			slot0._txtapproachEN.text = luaLang("skin_gain_approach_store_en")
		end
	elseif slot3 == CharacterEnum.SkinGainApproach.BPReward then
		if BpConfig.instance:getBpSkinBonusId(BpModel.instance.id) and slot2.id == slot5 then
			gohelper.setActive(slot0._btngotogetskin.gameObject, true)
		else
			gohelper.setActive(slot0._goactivityget, true)

			slot0._txtapproach.text = luaLang("skin_gain_approach_bp_zh")
			slot0._txtapproachEN.text = luaLang("skin_gain_approach_bp_en")
		end
	elseif slot3 == CharacterEnum.SkinGainApproach.Permanent then
		gohelper.setActive(slot0._btngotogetskin.gameObject, true)
	elseif ActivityModel.instance:getActMO(slot3) then
		if ActivityHelper.getActivityStatus(slot3) == ActivityEnum.ActivityStatus.Normal then
			gohelper.setActive(slot0._btngotogetskin.gameObject, true)
		else
			gohelper.setActive(slot0._goactivityget, true)

			slot0._txtapproach.text = luaLang("skin_gain_approach_activity_zh")
			slot0._txtapproachEN.text = luaLang("skin_gain_approach_activity_en")
		end
	else
		gohelper.setActive(slot0._btnnotget.gameObject, true)
	end
end

function slot0.skinHasOnLine(slot0, slot1)
	if not slot1 then
		return false
	end

	if not StoreModel.instance:getStoreMO(uv0.RealSkinStoreId) then
		return
	end

	slot7 = slot2

	for slot6, slot7 in ipairs(slot2.getGoodsList(slot7)) do
		if string.splitToNumber(slot7.config.product, "#")[1] == MaterialEnum.MaterialType.HeroSkin and slot9[2] == slot1 then
			return true
		end
	end

	return false
end

function slot0._clearBtnStatus(slot0)
	gohelper.setActive(slot0._btndress.gameObject, false)
	gohelper.setActive(slot0._btnnotget.gameObject, false)
	gohelper.setActive(slot0._btnrank.gameObject, false)
	gohelper.setActive(slot0._btnskinstore.gameObject, false)
	gohelper.setActive(slot0._btngotogetskin.gameObject, false)
	gohelper.setActive(slot0._godressing, false)
	gohelper.setActive(slot0._goactivityget, false)
end

function slot0.killTween(slot0)
	if slot0._tweeningId and slot0._tweeningId ~= 0 then
		uv0.KillById(slot0._tweeningId)
	end
end

function slot0.onGainSkin(slot0, slot1)
	if slot1 ~= slot0._itemObjects[slot0._currentSelectSkinIndex].skinCo.id then
		return
	end

	slot0:refreshHadSkinDict()
	slot0:_refreshSkinInfo()
	slot0:_refreshDressBtnStatus()
end

function slot0._successDressUpSkin(slot0, slot1)
	if slot1.heroId ~= slot0.heroMo.heroId then
		return
	end

	slot0:_refreshDressBtnStatus()
	slot0:_refreshDressedSkin(slot1.skinId)
end

function slot0.playAnim(slot0, slot1)
	slot0._isAnim = true

	slot0:setShaderKeyWord()
	slot0._animatorPlayer:Play(slot1, slot0.onAnimDone, slot0)
end

function slot0.onAnimDone(slot0)
	slot0._isAnim = false

	slot0:setShaderKeyWord()
end

function slot0.setShaderKeyWord(slot0)
	if slot0.dragging or slot0._isAnim then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._itemObjects) do
		slot5.image:UnLoadImage()
		slot5.click:RemoveClickListener()
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()
end

function slot0.onDestroyView(slot0)
	slot0:killTween()
	slot0.animationEventWrap:RemoveAllEventListener()
	slot0._simageskinSwitchBg:UnLoadImage()
end

return slot0
