module("modules.logic.character.view.CharacterSkinSwitchView", package.seeall)

local var_0_0 = class("CharacterSkinSwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gozs = gohelper.findChild(arg_1_0.viewGO, "#go_zs")
	arg_1_0._gosmallspine = gohelper.findChild(arg_1_0.viewGO, "smalldynamiccontainer/#go_smallspine")
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	arg_1_0._gobigspine = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	arg_1_0._gospinecontainer = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	arg_1_0._simagebgmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgmask")
	arg_1_0._gogetIcno = gohelper.findChild(arg_1_0.viewGO, "desc/#go_getIcno")
	arg_1_0._gonotgetIcno = gohelper.findChild(arg_1_0.viewGO, "desc/#go_notgetIcno")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signature")
	arg_1_0._simagesignatureicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signatureicon")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_index")
	arg_1_0._txtcharacterName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_characterName")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc")
	arg_1_0._btnshowDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	arg_1_0._simageskinSwitchBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#simage_skinSwitchBg")
	arg_1_0._scrollskinSwitch = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	arg_1_0._gopreEmpty = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	arg_1_0._goskinItem = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	arg_1_0._btndress = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_dress")
	arg_1_0._btnnotget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_notget")
	arg_1_0._btnrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_rank")
	arg_1_0._btnskinstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/skinSwitch/dressState/#btn_skinstore")
	arg_1_0._godressing = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/dressState/#go_dressing")
	arg_1_0._goactivityget = gohelper.findChild(arg_1_0.viewGO, "container/skinSwitch/dressState/#go_activityget")
	arg_1_0._gobtntopleft = gohelper.findChild(arg_1_0.viewGO, "#go_btntopleft")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btntag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_tag")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#btn_switch")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "desc/#btn_switch/#txt_switch")
	arg_1_0._go2d = gohelper.findChild(arg_1_0.viewGO, "desc/#btn_switch/#go_2d")
	arg_1_0._gol2d = gohelper.findChild(arg_1_0.viewGO, "desc/#btn_switch/#go_l2d")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowDetail:AddClickListener(arg_2_0._btnshowDetailOnClick, arg_2_0)
	arg_2_0._btndress:AddClickListener(arg_2_0._btndressOnClick, arg_2_0)
	arg_2_0._btnnotget:AddClickListener(arg_2_0._btnnotgetOnClick, arg_2_0)
	arg_2_0._btnrank:AddClickListener(arg_2_0._btnrankOnClick, arg_2_0)
	arg_2_0._btnskinstore:AddClickListener(arg_2_0._btnskinstoreOnClick, arg_2_0)
	arg_2_0._btntag:AddClickListener(arg_2_0._btntagOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowDetail:RemoveClickListener()
	arg_3_0._btndress:RemoveClickListener()
	arg_3_0._btnnotget:RemoveClickListener()
	arg_3_0._btnrank:RemoveClickListener()
	arg_3_0._btnskinstore:RemoveClickListener()
	arg_3_0._btntag:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
end

local var_0_1 = ZProj.TweenHelper

var_0_0.SkinStoreId = 500
var_0_0.TweenTime = 0.2
var_0_0.NormalAnimationTimeDuration = 0.33

function var_0_0._btnswitchOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	arg_4_0._showLive2d = arg_4_0._showLive2d == false

	gohelper.setActive(arg_4_0._go2d, arg_4_0._showLive2d)
	gohelper.setActive(arg_4_0._gol2d, arg_4_0._showLive2d == false)

	arg_4_0._txtswitch.text = arg_4_0._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	arg_4_0._viewAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(arg_4_0._refreshStaticVertical, arg_4_0, 0.16)
end

function var_0_0._btnshowDetailOnClick(arg_5_0)
	CharacterController.instance:openCharacterSkinFullScreenView(arg_5_0.skinCo, false, arg_5_0._showLive2d and CharacterEnum.ShowSkinEnum.Dynamic or CharacterEnum.ShowSkinEnum.Static)
end

function var_0_0._btndressOnClick(arg_6_0)
	HeroRpc.instance:sendUseSkinRequest(arg_6_0.viewParam.heroId, arg_6_0._itemObjects[arg_6_0._currentSelectSkinIndex].skinCo.id)
end

function var_0_0._btnnotgetOnClick(arg_7_0)
	local var_7_0 = arg_7_0._itemObjects[arg_7_0._currentSelectSkinIndex].skinCo

	if var_7_0 and var_7_0.jump and var_7_0.jump > 0 then
		GameFacade.jump(var_7_0.jump)
	end
end

function var_0_0._btnrankOnClick(arg_8_0)
	local var_8_0 = HeroModel.instance:getByHeroId(arg_8_0.skinCo.characterId)

	CharacterController.instance:openCharacterRankUpView(var_8_0)
end

function var_0_0._btntagOnClick(arg_9_0)
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = arg_9_0.skinCo
	})
end

function var_0_0._btnskinstoreOnClick(arg_10_0)
	if not StoreModel.instance:isTabOpen(var_0_0.SkinStoreId) then
		return
	end

	StoreController.instance:openStoreView(var_0_0.SkinStoreId)
end

function var_0_0._onOpenView(arg_11_0, arg_11_1)
	if arg_11_0._showLive2d and arg_11_1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(arg_11_0._gospinecontainer, false)
	end
end

function var_0_0._onCloseView(arg_12_0, arg_12_1)
	if arg_12_0._showLive2d and arg_12_1 == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(arg_12_0._gospinecontainer, true)
	end
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._showLive2d = true

	gohelper.setActive(arg_13_0._go2d, arg_13_0._showLive2d)
	gohelper.setActive(arg_13_0._gol2d, arg_13_0._showLive2d == false)

	arg_13_0._txtswitch.text = arg_13_0._showLive2d and "L2D" or luaLang("storeskinpreviewview_btnswitch")
	arg_13_0.goDesc = gohelper.findChild(arg_13_0.viewGO, "desc")
	arg_13_0.goDynamicContainer = gohelper.findChild(arg_13_0.viewGO, "smalldynamiccontainer")
	arg_13_0._goSpine = GuiSpine.Create(arg_13_0._gosmallspine, false)
	arg_13_0._itemObjects = {}
	arg_13_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_13_0._scrollskinSwitch.gameObject)

	arg_13_0._drag:AddDragBeginListener(arg_13_0._onDragBegin, arg_13_0)
	arg_13_0._drag:AddDragEndListener(arg_13_0._onDragEnd, arg_13_0)
	arg_13_0._drag:AddDragListener(arg_13_0._onDrag, arg_13_0)

	arg_13_0._preDragAnchorPositionX = 0
	arg_13_0._itemWidth = recthelper.getWidth(arg_13_0._goskinItem.transform)
	arg_13_0._scrollOneItemTime = 0.5
	arg_13_0._scrollRate = arg_13_0._itemWidth / arg_13_0._scrollOneItemTime
	arg_13_0._tweeningId = 0
	arg_13_0._currentSelectSkinIndex = 0
	arg_13_0._preSelectSkinIndex = 0
	arg_13_0._hadSkinDict = {}
	arg_13_0._minAnchorPositionX = 0
	arg_13_0._minChangeAnchorPositionX = 100

	arg_13_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	arg_13_0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	arg_13_0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	arg_13_0._skincontainerCanvasGroup = arg_13_0._goskincontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0.halfAnimationTime = var_0_0.TweenTime / 2

	arg_13_0:_clearBtnStatus()
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_13_0._onOpenView, arg_13_0)
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0._hadSkinDict = {}

	arg_14_0:refreshView()
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._simagesignature:LoadImage(ResUrl.getSignature(arg_15_0.viewParam.config.signature, "characterget"))
	arg_15_0:refreshView()
	arg_15_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_15_0._successDressUpSkin, arg_15_0)
	arg_15_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_15_0.refreshView, arg_15_0)
end

function var_0_0.onOpenFinish(arg_16_0)
	arg_16_0._viewAnim.enabled = true
end

function var_0_0.refreshView(arg_17_0)
	arg_17_0.skinCo = SkinConfig.instance:getSkinCo(arg_17_0.viewParam.skin)
	arg_17_0._hadSkinDict[arg_17_0.viewParam.config.skinId] = true

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.viewParam.skinInfoList) do
		arg_17_0._hadSkinDict[iter_17_1.skin] = true
	end

	arg_17_0._simagesignature:LoadImage(ResUrl.getSignature(arg_17_0.viewParam.config.signature, "characterget"))
	arg_17_0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	gohelper.setActive(arg_17_0._simagesignatureicon.gameObject, arg_17_0.viewParam.config.signature == "3011")
	arg_17_0:_refreshSkinList()
	arg_17_0:_reallyRefreshView()
end

function var_0_0._reallyRefreshView(arg_18_0)
	arg_18_0:_resetRes()
	arg_18_0:_refreshStaticVertical()
	arg_18_0:_refreshSkinInfo()
	arg_18_0:_refreshSpine()
	arg_18_0:_refreshDressBtnStatus()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSkinSwitchSpine, arg_18_0.skinCo.id)
end

function var_0_0._resetRes(arg_19_0)
	gohelper.setActive(arg_19_0._btnswitch, arg_19_0.skinCo.showSwitchBtn == 1)

	arg_19_0._showLive2d = false

	gohelper.setActive(arg_19_0._go2d, arg_19_0._showLive2d)
	gohelper.setActive(arg_19_0._gol2d, arg_19_0._showLive2d == false)

	if arg_19_0._uiSpine then
		arg_19_0._uiSpine:onDestroy()

		arg_19_0._uiSpine = nil
	end

	arg_19_0._simageskin:UnLoadImage()
	arg_19_0._simagel2d:UnLoadImage()
end

function var_0_0._refreshStaticVertical(arg_20_0)
	gohelper.setActive(arg_20_0._gospinecontainer, arg_20_0._showLive2d)
	gohelper.setActive(arg_20_0._simageskin.gameObject, arg_20_0._showLive2d == false)

	if arg_20_0._showLive2d then
		if arg_20_0._uiSpine == nil then
			arg_20_0._uiSpine = GuiModelAgent.Create(arg_20_0._gobigspine, true)

			arg_20_0._uiSpine:setResPath(arg_20_0.skinCo, arg_20_0._onUISpineLoaded, arg_20_0)
		else
			arg_20_0:_onUISpineLoaded()
		end

		arg_20_0._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		arg_20_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_20_0.skinCo.id), arg_20_0._loadedImage, arg_20_0)

		arg_20_0._txtswitch.text = "L2D"
	end

	local var_20_0 = arg_20_0.skinCo.live2dbg

	if not string.nilorempty(var_20_0) then
		gohelper.setActive(arg_20_0._simagel2d.gameObject, arg_20_0._showLive2d)
		arg_20_0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(var_20_0))
		gohelper.setActive(arg_20_0._gozs, arg_20_0._showLive2d)
	else
		gohelper.setActive(arg_20_0._simagel2d.gameObject, false)
		gohelper.setActive(arg_20_0._gozs, false)
	end
end

function var_0_0._refreshSelectSkin(arg_21_0)
	local var_21_0 = arg_21_0._itemObjects[arg_21_0._preSelectSkinIndex]
	local var_21_1 = arg_21_0._itemObjects[arg_21_0._currentSelectSkinIndex]

	gohelper.setActive(var_21_0.goNewSelect, false)
	gohelper.setActive(var_21_1.goNewSelect, true)
end

function var_0_0._successDressUpSkin(arg_22_0)
	arg_22_0:_refreshDressBtnStatus()
	arg_22_0:_refreshSelectSkin()
end

function var_0_0._onDragBegin(arg_23_0)
	var_0_1.KillById(arg_23_0._tweeningId)

	arg_23_0._preDragAnchorPositionX = recthelper.getAnchorX(arg_23_0._goContent.transform)
	arg_23_0.playAnimation = false
end

function var_0_0._onDrag(arg_24_0)
	local var_24_0 = arg_24_0._preDragAnchorPositionX - recthelper.getAnchorX(arg_24_0._goContent.transform)
	local var_24_1 = Mathf.Abs(var_24_0)
	local var_24_2 = 0.005

	arg_24_0._skincontainerCanvasGroup.alpha = 1 - var_24_1 * var_24_2

	if arg_24_0.playAnimation then
		return
	end

	if arg_24_0._currentSelectSkinIndex == 1 then
		if var_24_0 <= 0 then
			arg_24_0.playAnimation = false
		else
			arg_24_0.playAnimation = true
		end
	elseif arg_24_0._currentSelectSkinIndex == arg_24_0.skinCount then
		if var_24_0 >= 0 then
			arg_24_0.playAnimation = false
		else
			arg_24_0.playAnimation = true
		end
	else
		arg_24_0.playAnimation = true
	end

	if arg_24_0.playAnimation then
		arg_24_0._viewAnim:Play(UIAnimationName.SwitchClose, 0, 0)
	end
end

function var_0_0._onDragEnd(arg_25_0)
	if arg_25_0.playAnimation then
		arg_25_0._viewAnim:Play(UIAnimationName.SwitchOpen, 0, 0)
	end

	arg_25_0._skincontainerCanvasGroup.alpha = 1

	local var_25_0 = recthelper.getAnchorX(arg_25_0._goContent.transform)
	local var_25_1 = math.abs(var_25_0 - arg_25_0._preDragAnchorPositionX)

	if var_25_1 <= arg_25_0._minChangeAnchorPositionX then
		arg_25_0:killTween()

		arg_25_0._tweeningId = var_0_1.DOAnchorPosX(arg_25_0._goContent.transform, arg_25_0._preDragAnchorPositionX, var_25_1 / arg_25_0._scrollRate, arg_25_0.onCompleteTween, arg_25_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

		if var_25_0 < arg_25_0._minAnchorPositionX then
			var_25_0 = arg_25_0._minAnchorPositionX
		end

		if var_25_0 > 0 then
			var_25_0 = 0
		end

		local var_25_2 = 0

		arg_25_0._preSelectSkinIndex = arg_25_0._currentSelectSkinIndex

		if var_25_0 < arg_25_0._preDragAnchorPositionX then
			arg_25_0._currentSelectSkinIndex = math.ceil(math.abs(var_25_0) / arg_25_0._itemWidth) + 1

			if arg_25_0._currentSelectSkinIndex > #arg_25_0._itemObjects then
				arg_25_0._currentSelectSkinIndex = #arg_25_0._itemObjects
			end

			var_25_2 = math.abs(var_25_0) % arg_25_0._itemWidth

			if var_25_2 == 0 then
				arg_25_0:onCompleteTween()

				arg_25_0.skinCo = arg_25_0._itemObjects[arg_25_0._currentSelectSkinIndex].skinCo

				arg_25_0:_reallyRefreshView()

				return
			end

			var_25_2 = arg_25_0._itemWidth - var_25_2
		elseif var_25_0 > arg_25_0._preDragAnchorPositionX then
			arg_25_0._currentSelectSkinIndex = math.ceil(math.abs(var_25_0) / arg_25_0._itemWidth)

			if arg_25_0._currentSelectSkinIndex < 1 then
				arg_25_0._currentSelectSkinIndex = 1
			end

			var_25_2 = math.abs(var_25_0) % arg_25_0._itemWidth
		end

		arg_25_0.skinCo = arg_25_0._itemObjects[arg_25_0._currentSelectSkinIndex].skinCo

		arg_25_0:_reallyRefreshView()
		arg_25_0:killTween()

		arg_25_0._tweeningId = var_0_1.DOAnchorPosX(arg_25_0._goContent.transform, -(arg_25_0._currentSelectSkinIndex - 1) * arg_25_0._itemWidth, var_25_2 / arg_25_0._scrollRate, arg_25_0.onCompleteTween, arg_25_0)
	end

	if arg_25_0._currentSelectSkinIndex then
		local var_25_3 = arg_25_0._itemObjects[arg_25_0._currentSelectSkinIndex]

		for iter_25_0, iter_25_1 in ipairs(arg_25_0._itemObjects) do
			local var_25_4 = arg_25_0._currentSelectSkinIndex == iter_25_0 and 1 or 0.9

			transformhelper.setLocalScale(iter_25_1.transSkinmask, var_25_4, var_25_4, var_25_4)
		end
	end
end

function var_0_0.getSkinIndex(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._itemObjects) do
		if iter_26_1.skinCo.id == arg_26_0.skinCo.id then
			return iter_26_0
		end
	end

	return 0
end

function var_0_0._refreshSkinInfo(arg_27_0)
	if arg_27_0.skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not arg_27_0._hadSkinDict[arg_27_0.skinCo.id] then
		gohelper.setActive(arg_27_0.goDesc, false)

		return
	end

	gohelper.setActive(arg_27_0.goDesc, true)

	local var_27_0 = arg_27_0:getSkinIndex()

	arg_27_0._txtindex.text = string.format("%02d", var_27_0)
	arg_27_0._txtcharacterName.text = arg_27_0.viewParam.config.name

	if var_27_0 == 1 then
		gohelper.setActive(arg_27_0._txtskinName.gameObject, false)
		gohelper.setActive(arg_27_0._txtskinNameEn.gameObject, false)
	else
		arg_27_0._txtskinName.text = arg_27_0.skinCo.characterSkin
		arg_27_0._txtskinNameEn.text = arg_27_0.skinCo.characterSkinNameEng

		gohelper.setActive(arg_27_0._txtskinName.gameObject, true)
		gohelper.setActive(arg_27_0._txtskinNameEn.gameObject, GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN)
	end

	arg_27_0._txtdesc.text = arg_27_0.skinCo.skinDescription

	gohelper.setActive(arg_27_0._btntag.gameObject, string.nilorempty(arg_27_0.skinCo.storeTag) == false)
end

function var_0_0._onUISpineLoaded(arg_28_0)
	arg_28_0._skincontainerCanvasGroup.alpha = 1

	local var_28_0 = arg_28_0.skinCo.skinViewLive2dOffset

	if string.nilorempty(var_28_0) then
		var_28_0 = arg_28_0.skinCo.characterViewOffset
	end

	local var_28_1 = SkinConfig.instance:getSkinOffset(var_28_0)

	recthelper.setAnchor(arg_28_0._gobigspine.transform, tonumber(var_28_1[1]), tonumber(var_28_1[2]))
	transformhelper.setLocalScale(arg_28_0._gobigspine.transform, tonumber(var_28_1[3]), tonumber(var_28_1[3]), tonumber(var_28_1[3]))
end

function var_0_0._loadedImage(arg_29_0)
	ZProj.UGUIHelper.SetImageSize(arg_29_0._simageskin.gameObject)

	arg_29_0._skincontainerCanvasGroup.alpha = 1

	local var_29_0 = arg_29_0.skinCo.skinViewImgOffset

	if not string.nilorempty(var_29_0) then
		local var_29_1 = string.splitToNumber(var_29_0, "#")

		recthelper.setAnchor(arg_29_0._simageskin.transform, tonumber(var_29_1[1]), tonumber(var_29_1[2]))
		transformhelper.setLocalScale(arg_29_0._simageskin.transform, tonumber(var_29_1[3]), tonumber(var_29_1[3]), tonumber(var_29_1[3]))
	else
		recthelper.setAnchor(arg_29_0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(arg_29_0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function var_0_0._refreshSpine(arg_30_0)
	if arg_30_0.skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not arg_30_0._hadSkinDict[arg_30_0.skinCo.id] then
		gohelper.setActive(arg_30_0.goDynamicContainer, false)

		return
	end

	gohelper.setActive(arg_30_0.goDynamicContainer, true)
	arg_30_0._goSpine:stopVoice()
	arg_30_0._goSpine:setResPath(ResUrl.getSpineUIPrefab(arg_30_0.skinCo.spine), arg_30_0._onSpineLoaded, arg_30_0, true)

	local var_30_0 = SkinConfig.instance:getSkinOffset(arg_30_0.skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_30_0._gosmallspine.transform, tonumber(var_30_0[1]), tonumber(var_30_0[2]))
	transformhelper.setLocalScale(arg_30_0._gosmallspine.transform, tonumber(var_30_0[3]), tonumber(var_30_0[3]), tonumber(var_30_0[3]))
end

function var_0_0._refreshSkinList(arg_31_0)
	local var_31_0 = SkinConfig.instance:getCharacterSkinCoList(arg_31_0.viewParam.heroId)

	if var_31_0 == nil or #var_31_0 == 0 then
		logError("get skin config list failed,, heroid is : " .. tostring(arg_31_0.viewParam.heroId))
	end

	arg_31_0.skinCount = #var_31_0

	gohelper.setActive(arg_31_0._goskinItem, false)

	local var_31_1
	local var_31_2

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		local var_31_3 = arg_31_0._itemObjects[iter_31_0] or arg_31_0:createSkinItem()

		var_31_3.image:LoadImage(ResUrl.getHeadSkinSmall(iter_31_1.id))

		var_31_3.index = iter_31_0
		var_31_3.skinCo = iter_31_1

		if arg_31_0.viewParam.skin == iter_31_1.id then
			var_31_2 = 1
			arg_31_0._currentSelectSkinIndex = iter_31_0
			arg_31_0._preSelectSkinIndex = iter_31_0
		else
			var_31_2 = 0.9
		end

		transformhelper.setLocalScale(var_31_3.transSkinmask, var_31_2, var_31_2, var_31_2)
	end

	arg_31_0._minAnchorPositionX = -((#var_31_0 - 1) * arg_31_0._itemWidth)

	gohelper.cloneInPlace(arg_31_0._gopreEmpty, "suffixEmpty")

	if arg_31_0._currentSelectSkinIndex == 0 then
		logError("init view error, not selected skin")

		arg_31_0._currentSelectSkinIndex = 1
	end

	arg_31_0:_refreshSelectSkin()
	recthelper.setAnchorX(arg_31_0._goContent.transform, -(arg_31_0._currentSelectSkinIndex - 1) * arg_31_0._itemWidth)
end

function var_0_0.createSkinItem(arg_32_0)
	local var_32_0 = arg_32_0:getUserDataTb_()
	local var_32_1 = gohelper.cloneInPlace(arg_32_0._goskinItem, "skinItem")

	var_32_0.image = gohelper.findChildSingleImage(var_32_1, "skinmask/skinicon")
	var_32_0.transSkinmask = gohelper.findChild(var_32_1, "skinmask").transform
	var_32_0.goNewSelect = gohelper.findChild(var_32_1, "skinmask/#go_select")

	gohelper.setActive(var_32_0.goNewSelect, false)

	local var_32_2 = gohelper.getClick(var_32_0.image.gameObject)

	var_32_2:AddClickListener(arg_32_0._onItemClick, arg_32_0, var_32_0)

	var_32_0.click = var_32_2

	gohelper.setActive(var_32_1, true)
	table.insert(arg_32_0._itemObjects, var_32_0)

	return var_32_0
end

function var_0_0._onItemClick(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.index

	if arg_33_0._currentSelectSkinIndex == var_33_0 then
		return
	end

	arg_33_0._preSelectSkinIndex = arg_33_0._currentSelectSkinIndex
	arg_33_0._currentSelectSkinIndex = var_33_0
	arg_33_0.skinCo = arg_33_0._itemObjects[arg_33_0._currentSelectSkinIndex].skinCo

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._itemObjects) do
		local var_33_1 = arg_33_0._currentSelectSkinIndex == iter_33_0 and 1 or 0.9

		transformhelper.setLocalScale(iter_33_1.transSkinmask, var_33_1, var_33_1, var_33_1)
	end

	arg_33_0.startAnchorPositionX = arg_33_0._goContent.transform.anchoredPosition.x
	arg_33_0.endAnchorPositionX = -(arg_33_0._currentSelectSkinIndex - 1) * arg_33_0._itemWidth

	arg_33_0:killTween()

	arg_33_0._tweeningId = var_0_1.DOTweenFloat(0, 1, var_0_0.TweenTime, arg_33_0.tweenFrameCallback, arg_33_0.onCompleteTween, arg_33_0)

	arg_33_0:destroyFlow()

	arg_33_0.workFlow = FlowSequence.New()

	arg_33_0.workFlow:addWork(DelayFuncWork.New(arg_33_0.beforeFlow, arg_33_0, 0))
	arg_33_0.workFlow:addWork(DelayFuncWork.New(arg_33_0.playCloseAnimation, arg_33_0, 0.16))
	arg_33_0.workFlow:addWork(DelayFuncWork.New(arg_33_0._reallyRefreshView, arg_33_0, 0))
	arg_33_0.workFlow:addWork(DelayFuncWork.New(arg_33_0.playOpenAnimation, arg_33_0, 0.33))
	arg_33_0.workFlow:registerDoneListener(arg_33_0.onFlowDone, arg_33_0)
	arg_33_0.workFlow:start()
end

function var_0_0.beforeFlow(arg_34_0)
	arg_34_0._viewAnim.speed = var_0_0.NormalAnimationTimeDuration / arg_34_0.halfAnimationTime
end

function var_0_0.playCloseAnimation(arg_35_0)
	arg_35_0._viewAnim:Play("clickclose", 0, 0)
end

function var_0_0.playOpenAnimation(arg_36_0)
	arg_36_0._viewAnim:Play(UIAnimationName.SwitchOpen, 0, 0)
end

function var_0_0.onFlowDone(arg_37_0)
	arg_37_0._viewAnim.speed = 1
end

function var_0_0.tweenFrameCallback(arg_38_0, arg_38_1)
	recthelper.setAnchorX(arg_38_0._goContent.transform, Mathf.Lerp(arg_38_0.startAnchorPositionX, arg_38_0.endAnchorPositionX, arg_38_1))
end

function var_0_0.onCompleteTween(arg_39_0)
	arg_39_0._tweeningId = 0
end

function var_0_0._refreshDressBtnStatus(arg_40_0)
	arg_40_0:_clearBtnStatus()

	local var_40_0 = arg_40_0._itemObjects[arg_40_0._currentSelectSkinIndex].skinCo

	if var_40_0.id == arg_40_0.viewParam.skin then
		gohelper.setActive(arg_40_0._godressing, true)
	elseif arg_40_0._hadSkinDict[var_40_0.id] then
		gohelper.setActive(arg_40_0._btndress.gameObject, true)
	elseif var_40_0.gainApproach == CharacterEnum.SkinGainApproach.Rank then
		gohelper.setActive(arg_40_0._btnrank.gameObject, true)
	elseif var_40_0.gainApproach == CharacterEnum.SkinGainApproach.Activity then
		gohelper.setActive(arg_40_0._goactivityget, true)
	elseif var_40_0.gainApproach == CharacterEnum.SkinGainApproach.Store then
		if not StoreModel.instance:isTabOpen(var_0_0.SkinStoreId) then
			gohelper.setActive(arg_40_0._goactivityget, true)
		else
			gohelper.setActive(arg_40_0._btnskinstore.gameObject, true)
		end
	else
		gohelper.setActive(arg_40_0._btnnotget.gameObject, true)
	end
end

function var_0_0._clearBtnStatus(arg_41_0)
	gohelper.setActive(arg_41_0._btndress.gameObject, false)
	gohelper.setActive(arg_41_0._btnnotget.gameObject, false)
	gohelper.setActive(arg_41_0._btnrank.gameObject, false)
	gohelper.setActive(arg_41_0._btnskinstore.gameObject, false)
	gohelper.setActive(arg_41_0._godressing, false)
	gohelper.setActive(arg_41_0._goactivityget, false)
end

function var_0_0._onSpineLoaded(arg_42_0)
	return
end

function var_0_0.killTween(arg_43_0)
	if arg_43_0._tweeningId and arg_43_0._tweeningId ~= 0 then
		var_0_1.KillById(arg_43_0._tweeningId)
	end
end

function var_0_0.destroyFlow(arg_44_0)
	if arg_44_0.workFlow then
		arg_44_0.workFlow:destroy()

		arg_44_0.workFlow = nil
	end
end

function var_0_0.onClose(arg_45_0)
	arg_45_0:killTween()
	arg_45_0._simageskin:UnLoadImage()
	arg_45_0._simagesignature:UnLoadImage()
	arg_45_0._simagesignatureicon:UnLoadImage()
	arg_45_0._simagel2d:UnLoadImage()

	for iter_45_0, iter_45_1 in ipairs(arg_45_0._itemObjects) do
		iter_45_1.image:UnLoadImage()
		iter_45_1.click:RemoveClickListener()
	end

	if arg_45_0._uiSpine then
		arg_45_0._uiSpine:setModelVisible(false)
	end

	arg_45_0._drag:RemoveDragBeginListener()
	arg_45_0._drag:RemoveDragEndListener()
	arg_45_0._drag:RemoveDragListener()
end

function var_0_0.onDestroyView(arg_46_0)
	arg_46_0:destroyFlow()

	if arg_46_0._goSpine then
		arg_46_0._goSpine:stopVoice()

		arg_46_0._goSpine = nil
	end

	if arg_46_0._uiSpine then
		arg_46_0._uiSpine:onDestroy()

		arg_46_0._uiSpine = nil
	end

	arg_46_0._simagebg:UnLoadImage()
	arg_46_0._simagebgmask:UnLoadImage()
	arg_46_0._simageskinSwitchBg:UnLoadImage()
end

return var_0_0
