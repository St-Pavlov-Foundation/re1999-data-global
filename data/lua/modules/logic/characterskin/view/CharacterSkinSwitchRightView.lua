module("modules.logic.characterskin.view.CharacterSkinSwitchRightView", package.seeall)

local var_0_0 = class("CharacterSkinSwitchRightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer")
	arg_1_0._simageskinSwitchBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#simage_skinSwitchBg")
	arg_1_0._scrollskinSwitch = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	arg_1_0._gopreEmpty = gohelper.findChild(arg_1_0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	arg_1_0._goskinItem = gohelper.findChild(arg_1_0.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	arg_1_0._btndress = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#btn_dress")
	arg_1_0._btnnotget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#btn_notget")
	arg_1_0._btnrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#btn_rank")
	arg_1_0._btnskinstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#btn_skinstore")
	arg_1_0._btngotogetskin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#btn_GO")
	arg_1_0._godressing = gohelper.findChild(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#go_dressing")
	arg_1_0._goactivityget = gohelper.findChild(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#go_activityget")
	arg_1_0._txtapproach = gohelper.findChildText(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#go_activityget/txt")
	arg_1_0._txtapproachEN = gohelper.findChildText(arg_1_0.viewGO, "container/normal/skinSwitch/dressState/#go_activityget/txt/txtEn")
	arg_1_0._gobtntopleft = gohelper.findChild(arg_1_0.viewGO, "#go_btntopleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndress:AddClickListener(arg_2_0._btndressOnClick, arg_2_0)
	arg_2_0._btnnotget:AddClickListener(arg_2_0._btnnotgetOnClick, arg_2_0)
	arg_2_0._btnrank:AddClickListener(arg_2_0._btnrankOnClick, arg_2_0)
	arg_2_0._btnskinstore:AddClickListener(arg_2_0._btnskinstoreOnClick, arg_2_0)
	arg_2_0._btngotogetskin:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndress:RemoveClickListener()
	arg_3_0._btnnotget:RemoveClickListener()
	arg_3_0._btnrank:RemoveClickListener()
	arg_3_0._btnskinstore:RemoveClickListener()
	arg_3_0._btngotogetskin:RemoveClickListener()
end

local var_0_1 = ZProj.TweenHelper

var_0_0.SkinStoreId = 500
var_0_0.RealSkinStoreId = 510
var_0_0.TweenTime = 0.2
var_0_0.NormalAnimationTimeDuration = 0.33

function var_0_0._btndressOnClick(arg_4_0)
	HeroRpc.instance:sendUseSkinRequest(arg_4_0.heroMo.heroId, arg_4_0._itemObjects[arg_4_0._currentSelectSkinIndex].skinCo.id)
end

function var_0_0._btnnotgetOnClick(arg_5_0)
	local var_5_0 = arg_5_0._itemObjects[arg_5_0._currentSelectSkinIndex].skinCo

	if var_5_0 and var_5_0.jump and var_5_0.jump > 0 then
		GameFacade.jump(var_5_0.jump)
	end
end

function var_0_0._btnrankOnClick(arg_6_0)
	CharacterController.instance:openCharacterRankUpView(arg_6_0.heroMo)
end

function var_0_0._btnskinstoreOnClick(arg_7_0)
	if not StoreModel.instance:isTabOpen(var_0_0.SkinStoreId) then
		return
	end

	StoreController.instance:openStoreView(var_0_0.SkinStoreId)
end

function var_0_0._btngotoOnClick(arg_8_0)
	local var_8_0 = arg_8_0._itemObjects[arg_8_0._currentSelectSkinIndex].skinCo
	local var_8_1 = var_8_0.gainApproach

	if var_8_1 == CharacterEnum.SkinGainApproach.BPReward then
		local var_8_2 = BpModel.instance.id
		local var_8_3 = BpConfig.instance:getCurSkinId(var_8_2)

		if var_8_0.id == var_8_3 then
			JumpController.instance:jump(48)
		end
	elseif ActivityModel.instance:getActMO(var_8_1) then
		local var_8_4 = var_8_1

		if var_8_0 and var_8_0.jump and var_8_0.jump > 0 then
			GameFacade.jump(var_8_0.jump)
		end
	elseif var_8_1 == CharacterEnum.SkinGainApproach.Permanent and var_8_0 and var_8_0.jump and var_8_0.jump > 0 then
		GameFacade.jump(var_8_0.jump)
	end
end

function var_0_0.refreshRightContainer(arg_9_0)
	arg_9_0.goSkinNormalContainer = gohelper.findChild(arg_9_0.viewGO, "container/normal")
	arg_9_0.goSkinTipContainer = gohelper.findChild(arg_9_0.viewGO, "container/skinTip")
	arg_9_0.goSkinStoreContainer = gohelper.findChild(arg_9_0.viewGO, "container/skinStore")

	gohelper.setActive(arg_9_0.goSkinNormalContainer, true)
	gohelper.setActive(arg_9_0.goSkinTipContainer, false)
	gohelper.setActive(arg_9_0.goSkinStoreContainer, false)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:refreshRightContainer()
	gohelper.setActive(arg_10_0._goskinItem, false)

	arg_10_0.goDesc = gohelper.findChild(arg_10_0.viewGO, "desc")
	arg_10_0._itemObjects = {}
	arg_10_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_10_0._scrollskinSwitch.gameObject)

	arg_10_0._drag:AddDragBeginListener(arg_10_0._onDragBegin, arg_10_0)
	arg_10_0._drag:AddDragEndListener(arg_10_0._onDragEnd, arg_10_0)
	arg_10_0._drag:AddDragListener(arg_10_0._onDrag, arg_10_0)

	arg_10_0._preDragAnchorPositionX = 0
	arg_10_0._itemWidth = recthelper.getWidth(arg_10_0._goskinItem.transform)
	arg_10_0._scrollOneItemTime = 0.5
	arg_10_0._scrollRate = arg_10_0._itemWidth / arg_10_0._scrollOneItemTime
	arg_10_0._tweeningId = 0
	arg_10_0._currentSelectSkinIndex = 0
	arg_10_0._hadSkinDict = {}
	arg_10_0._minAnchorPositionX = 0
	arg_10_0._minChangeAnchorPositionX = 100
	arg_10_0._skincontainerCanvasGroup = arg_10_0._goskincontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_10_0.halfAnimationTime = var_0_0.TweenTime / 2
	arg_10_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_10_0.viewGO)
	arg_10_0.animationEventWrap = arg_10_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_10_0.animationEventWrap:AddEventListener("refreshUI", arg_10_0.refreshUI, arg_10_0)
	arg_10_0:_clearBtnStatus()
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_10_0._successDressUpSkin, arg_10_0)
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_10_0.onOpen, arg_10_0)
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.GainSkin, arg_10_0.onGainSkin, arg_10_0)
end

function var_0_0.initViewParam(arg_11_0)
	arg_11_0.heroMo = arg_11_0.viewParam
	arg_11_0._isFromHandbook = arg_11_0.viewParam and arg_11_0.viewParam.handbook
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, arg_13_0.viewName)
	arg_13_0:initViewParam()
	arg_13_0:refreshHadSkinDict()
	arg_13_0:initSkinItem()
	arg_13_0:refreshUI()
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:_refreshDressBtnStatus()
	arg_14_0:refreshLeftUI()
	arg_14_0:_refreshSkinRightBg()
end

function var_0_0.refreshHadSkinDict(arg_15_0)
	arg_15_0._hadSkinDict = {}

	local var_15_0 = SkinConfig.instance:getCharacterSkinCoList(arg_15_0.viewParam.heroId)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		arg_15_0._hadSkinDict[iter_15_1.id] = HeroModel.instance:checkHasSkin(iter_15_1.id)
	end
end

function var_0_0.initSkinItem(arg_16_0)
	local var_16_0 = SkinConfig.instance:getCharacterSkinCoList(arg_16_0.heroMo.heroId)

	if var_16_0 == nil or #var_16_0 == 0 then
		logError("get skin config list failed,, heroid is : " .. tostring(arg_16_0.heroMo.heroId))
	end

	arg_16_0.skinCount = #var_16_0

	local var_16_1
	local var_16_2

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_3 = arg_16_0._itemObjects[iter_16_0] or arg_16_0:createSkinItem()

		var_16_3.image:LoadImage(ResUrl.getHeadSkinSmall(iter_16_1.id))

		var_16_3.index = iter_16_0
		var_16_3.skinCo = iter_16_1

		if arg_16_0.heroMo.skin == iter_16_1.id then
			var_16_2 = 1
			arg_16_0._currentSelectSkinIndex = iter_16_0
		else
			var_16_2 = 0.9
		end

		transformhelper.setLocalScale(var_16_3.transSkinmask, var_16_2, var_16_2, var_16_2)
	end

	arg_16_0._minAnchorPositionX = -((arg_16_0.skinCount - 1) * arg_16_0._itemWidth)

	gohelper.cloneInPlace(arg_16_0._gopreEmpty, "suffixEmpty")

	if arg_16_0._currentSelectSkinIndex == 0 then
		logError("init view error, not selected skin")

		arg_16_0._currentSelectSkinIndex = 1
	end

	arg_16_0.selectSkinCo = arg_16_0._itemObjects[arg_16_0._currentSelectSkinIndex].skinCo

	if not arg_16_0._isFromHandbook then
		arg_16_0:_refreshDressedSkin(arg_16_0.heroMo.skin)
	end

	recthelper.setAnchorX(arg_16_0._goContent.transform, -(arg_16_0._currentSelectSkinIndex - 1) * arg_16_0._itemWidth)
end

function var_0_0._refreshDressedSkin(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._itemObjects) do
		gohelper.setActive(iter_17_1.goNewSelect, iter_17_1.skinCo.id == arg_17_1)
	end
end

function var_0_0.refreshLeftUI(arg_18_0)
	arg_18_0:_refreshSkinInfo()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, arg_18_0.selectSkinCo, arg_18_0.viewName)
end

function var_0_0._refreshSkinInfo(arg_19_0)
	if arg_19_0.selectSkinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not arg_19_0._hadSkinDict[arg_19_0.selectSkinCo.id] then
		gohelper.setActive(arg_19_0.goDesc, false)

		return
	end

	gohelper.setActive(arg_19_0.goDesc, true)
end

function var_0_0._onDragBegin(arg_20_0)
	var_0_1.KillById(arg_20_0._tweeningId)

	arg_20_0._preDragAnchorPositionX = recthelper.getAnchorX(arg_20_0._goContent.transform)
	arg_20_0.playAnimation = false
	arg_20_0.dragging = true

	arg_20_0:setShaderKeyWord()
end

function var_0_0._onDrag(arg_21_0)
	local var_21_0 = arg_21_0._preDragAnchorPositionX - recthelper.getAnchorX(arg_21_0._goContent.transform)
	local var_21_1 = Mathf.Abs(var_21_0)
	local var_21_2 = 0.005

	arg_21_0._skincontainerCanvasGroup.alpha = 1 - var_21_1 * var_21_2

	if arg_21_0.playAnimation then
		return
	end

	if arg_21_0._currentSelectSkinIndex == 1 then
		if var_21_0 <= 0 then
			arg_21_0.playAnimation = false
		else
			arg_21_0.playAnimation = true
		end
	elseif arg_21_0._currentSelectSkinIndex == arg_21_0.skinCount then
		if var_21_0 >= 0 then
			arg_21_0.playAnimation = false
		else
			arg_21_0.playAnimation = true
		end
	else
		arg_21_0.playAnimation = true
	end

	if arg_21_0.playAnimation then
		arg_21_0:playAnim("skinclose")
	end
end

function var_0_0._onDragEnd(arg_22_0)
	if arg_22_0.playAnimation then
		arg_22_0:playAnim("skinopen")
	end

	arg_22_0._skincontainerCanvasGroup.alpha = 1

	local var_22_0 = recthelper.getAnchorX(arg_22_0._goContent.transform)
	local var_22_1 = math.abs(var_22_0 - arg_22_0._preDragAnchorPositionX)

	if var_22_1 <= arg_22_0._minChangeAnchorPositionX then
		arg_22_0:killTween()

		arg_22_0._tweeningId = var_0_1.DOAnchorPosX(arg_22_0._goContent.transform, arg_22_0._preDragAnchorPositionX, var_22_1 / arg_22_0._scrollRate, arg_22_0.onCompleteTween, arg_22_0)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, arg_22_0.viewName)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

		if var_22_0 < arg_22_0._minAnchorPositionX then
			var_22_0 = arg_22_0._minAnchorPositionX
		end

		if var_22_0 > 0 then
			var_22_0 = 0
		end

		local var_22_2 = 0

		if var_22_0 < arg_22_0._preDragAnchorPositionX then
			arg_22_0._currentSelectSkinIndex = math.ceil(math.abs(var_22_0) / arg_22_0._itemWidth) + 1

			if arg_22_0._currentSelectSkinIndex > #arg_22_0._itemObjects then
				arg_22_0._currentSelectSkinIndex = #arg_22_0._itemObjects
			end

			var_22_2 = math.abs(var_22_0) % arg_22_0._itemWidth

			if var_22_2 == 0 then
				arg_22_0:onCompleteTween()

				arg_22_0.selectSkinCo = arg_22_0._itemObjects[arg_22_0._currentSelectSkinIndex].skinCo

				arg_22_0:refreshUI()

				return
			end

			var_22_2 = arg_22_0._itemWidth - var_22_2
		elseif var_22_0 > arg_22_0._preDragAnchorPositionX then
			arg_22_0._currentSelectSkinIndex = math.ceil(math.abs(var_22_0) / arg_22_0._itemWidth)

			if arg_22_0._currentSelectSkinIndex < 1 then
				arg_22_0._currentSelectSkinIndex = 1
			end

			var_22_2 = math.abs(var_22_0) % arg_22_0._itemWidth
		end

		arg_22_0.selectSkinCo = arg_22_0._itemObjects[arg_22_0._currentSelectSkinIndex].skinCo

		arg_22_0:refreshUI()
		arg_22_0:killTween()

		arg_22_0._tweeningId = var_0_1.DOAnchorPosX(arg_22_0._goContent.transform, -(arg_22_0._currentSelectSkinIndex - 1) * arg_22_0._itemWidth, var_22_2 / arg_22_0._scrollRate, arg_22_0.onCompleteTween, arg_22_0)
	end

	if arg_22_0._currentSelectSkinIndex then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._itemObjects) do
			local var_22_3 = arg_22_0._currentSelectSkinIndex == iter_22_0 and 1 or 0.9

			transformhelper.setLocalScale(iter_22_1.transSkinmask, var_22_3, var_22_3, var_22_3)
		end
	end

	arg_22_0.dragging = false

	arg_22_0:setShaderKeyWord()
end

function var_0_0.createSkinItem(arg_23_0)
	local var_23_0 = arg_23_0:getUserDataTb_()
	local var_23_1 = gohelper.cloneInPlace(arg_23_0._goskinItem, "skinItem")

	var_23_0.image = gohelper.findChildSingleImage(var_23_1, "skinmask/skinicon")
	var_23_0.transSkinmask = gohelper.findChild(var_23_1, "skinmask").transform
	var_23_0.goNewSelect = gohelper.findChild(var_23_1, "skinmask/#go_select")

	gohelper.setActive(var_23_0.goNewSelect, false)

	local var_23_2 = gohelper.getClick(var_23_0.image.gameObject)

	var_23_2:AddClickListener(arg_23_0._onItemClick, arg_23_0, var_23_0)

	var_23_0.click = var_23_2

	gohelper.setActive(var_23_1, true)
	table.insert(arg_23_0._itemObjects, var_23_0)

	return var_23_0
end

function var_0_0._onItemClick(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.index

	if arg_24_0._currentSelectSkinIndex == var_24_0 then
		return
	end

	arg_24_0._currentSelectSkinIndex = var_24_0
	arg_24_0.selectSkinCo = arg_24_0._itemObjects[arg_24_0._currentSelectSkinIndex].skinCo

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._itemObjects) do
		local var_24_1 = arg_24_0._currentSelectSkinIndex == iter_24_0 and 1 or 0.9

		transformhelper.setLocalScale(iter_24_1.transSkinmask, var_24_1, var_24_1, var_24_1)
	end

	arg_24_0.startAnchorPositionX = arg_24_0._goContent.transform.anchoredPosition.x
	arg_24_0.endAnchorPositionX = -(arg_24_0._currentSelectSkinIndex - 1) * arg_24_0._itemWidth

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, arg_24_0.viewName)
	arg_24_0:killTween()

	arg_24_0._tweeningId = var_0_1.DOTweenFloat(0, 1, var_0_0.TweenTime, arg_24_0.tweenFrameCallback, arg_24_0.onCompleteTween, arg_24_0)

	arg_24_0:playAnim(UIAnimationName.Switch)
end

function var_0_0.tweenFrameCallback(arg_25_0, arg_25_1)
	recthelper.setAnchorX(arg_25_0._goContent.transform, Mathf.Lerp(arg_25_0.startAnchorPositionX, arg_25_0.endAnchorPositionX, arg_25_1))
end

function var_0_0.onCompleteTween(arg_26_0)
	arg_26_0._tweeningId = 0
end

function var_0_0._refreshDressBtnStatus(arg_27_0)
	arg_27_0:_clearBtnStatus()

	local var_27_0 = arg_27_0._itemObjects[arg_27_0._currentSelectSkinIndex].skinCo
	local var_27_1 = var_27_0.gainApproach

	if var_27_0.id == arg_27_0.heroMo.skin and not arg_27_0._isFromHandbook then
		gohelper.setActive(arg_27_0._godressing, true)
	elseif arg_27_0._hadSkinDict[var_27_0.id] then
		gohelper.setActive(arg_27_0._btndress.gameObject, true)
	elseif var_27_1 == CharacterEnum.SkinGainApproach.Rank then
		gohelper.setActive(arg_27_0._btnrank.gameObject, true)
	elseif var_27_1 == CharacterEnum.SkinGainApproach.Activity then
		gohelper.setActive(arg_27_0._goactivityget, true)

		arg_27_0._txtapproach.text = luaLang("skin_gain_approach_activity_zh")
		arg_27_0._txtapproachEN.text = luaLang("skin_gain_approach_activity_en")
	elseif var_27_1 == CharacterEnum.SkinGainApproach.Store then
		if StoreModel.instance:isStoreSkinChargePackageValid(var_27_0.id) then
			gohelper.setActive(arg_27_0._btnskinstore.gameObject, true)
		else
			gohelper.setActive(arg_27_0._goactivityget, true)

			arg_27_0._txtapproach.text = luaLang("skin_gain_approach_store_zh")
			arg_27_0._txtapproachEN.text = luaLang("skin_gain_approach_store_en")
		end
	elseif var_27_1 == CharacterEnum.SkinGainApproach.BPReward then
		local var_27_2 = BpModel.instance.id
		local var_27_3 = BpConfig.instance:getBpSkinBonusId(var_27_2)

		if var_27_3 and var_27_0.id == var_27_3 then
			gohelper.setActive(arg_27_0._btngotogetskin.gameObject, true)
		else
			gohelper.setActive(arg_27_0._goactivityget, true)

			arg_27_0._txtapproach.text = luaLang("skin_gain_approach_bp_zh")
			arg_27_0._txtapproachEN.text = luaLang("skin_gain_approach_bp_en")
		end
	elseif var_27_1 == CharacterEnum.SkinGainApproach.Permanent then
		gohelper.setActive(arg_27_0._btngotogetskin.gameObject, true)
	elseif ActivityModel.instance:getActMO(var_27_1) then
		local var_27_4 = var_27_1

		if ActivityHelper.getActivityStatus(var_27_4) == ActivityEnum.ActivityStatus.Normal then
			gohelper.setActive(arg_27_0._btngotogetskin.gameObject, true)
		else
			gohelper.setActive(arg_27_0._goactivityget, true)

			arg_27_0._txtapproach.text = luaLang("skin_gain_approach_activity_zh")
			arg_27_0._txtapproachEN.text = luaLang("skin_gain_approach_activity_en")
		end
	else
		gohelper.setActive(arg_27_0._btnnotget.gameObject, true)
	end
end

function var_0_0._refreshSkinRightBg(arg_28_0)
	local var_28_0 = arg_28_0._itemObjects[arg_28_0._currentSelectSkinIndex].skinCo.id
	local var_28_1 = HandbookConfig.instance:getSkinSuitIdBySkinId(var_28_0)

	if var_28_1 then
		arg_28_0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinSwitchBg(var_28_1))
	else
		arg_28_0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	end
end

function var_0_0.skinHasOnLine(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return false
	end

	local var_29_0 = StoreModel.instance:getStoreMO(var_0_0.RealSkinStoreId)

	if not var_29_0 then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(var_29_0:getGoodsList()) do
		local var_29_1 = iter_29_1.config
		local var_29_2 = string.splitToNumber(var_29_1.product, "#")

		if var_29_2[1] == MaterialEnum.MaterialType.HeroSkin and var_29_2[2] == arg_29_1 then
			return true
		end
	end

	return false
end

function var_0_0._clearBtnStatus(arg_30_0)
	gohelper.setActive(arg_30_0._btndress.gameObject, false)
	gohelper.setActive(arg_30_0._btnnotget.gameObject, false)
	gohelper.setActive(arg_30_0._btnrank.gameObject, false)
	gohelper.setActive(arg_30_0._btnskinstore.gameObject, false)
	gohelper.setActive(arg_30_0._btngotogetskin.gameObject, false)
	gohelper.setActive(arg_30_0._godressing, false)
	gohelper.setActive(arg_30_0._goactivityget, false)
end

function var_0_0.killTween(arg_31_0)
	if arg_31_0._tweeningId and arg_31_0._tweeningId ~= 0 then
		var_0_1.KillById(arg_31_0._tweeningId)
	end
end

function var_0_0.onGainSkin(arg_32_0, arg_32_1)
	if arg_32_1 ~= arg_32_0._itemObjects[arg_32_0._currentSelectSkinIndex].skinCo.id then
		return
	end

	arg_32_0:refreshHadSkinDict()
	arg_32_0:_refreshSkinInfo()
	arg_32_0:_refreshDressBtnStatus()
	arg_32_0:_refreshSkinRightBg()
end

function var_0_0._successDressUpSkin(arg_33_0, arg_33_1)
	if arg_33_1.heroId ~= arg_33_0.heroMo.heroId then
		return
	end

	arg_33_0:_refreshSkinRightBg()
	arg_33_0:_refreshDressBtnStatus()
	arg_33_0:_refreshDressedSkin(arg_33_1.skinId)
end

function var_0_0.playAnim(arg_34_0, arg_34_1)
	arg_34_0._isAnim = true

	arg_34_0:setShaderKeyWord()
	arg_34_0._animatorPlayer:Play(arg_34_1, arg_34_0.onAnimDone, arg_34_0)
end

function var_0_0.onAnimDone(arg_35_0)
	arg_35_0._isAnim = false

	arg_35_0:setShaderKeyWord()
end

function var_0_0.setShaderKeyWord(arg_36_0)
	if arg_36_0.dragging or arg_36_0._isAnim then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onClose(arg_37_0)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0._itemObjects) do
		iter_37_1.image:UnLoadImage()
		iter_37_1.click:RemoveClickListener()
	end

	arg_37_0._drag:RemoveDragBeginListener()
	arg_37_0._drag:RemoveDragEndListener()
	arg_37_0._drag:RemoveDragListener()
end

function var_0_0.onDestroyView(arg_38_0)
	arg_38_0:killTween()
	arg_38_0.animationEventWrap:RemoveAllEventListener()
	arg_38_0._simageskinSwitchBg:UnLoadImage()
end

return var_0_0
