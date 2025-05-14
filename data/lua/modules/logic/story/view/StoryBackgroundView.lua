module("modules.logic.story.view.StoryBackgroundView", package.seeall)

local var_0_0 = class("StoryBackgroundView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottombg")
	arg_1_0._simagebgold = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bottombg/#simage_bgold")
	arg_1_0._simagebgoldtop = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	arg_1_0._bottombgSpine = gohelper.findChild(arg_1_0.viewGO, "#go_bottombg/#go_bottombgspine")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "#go_upbg")
	arg_1_0._goblack = gohelper.findChild(arg_1_0.viewGO, "#go_blackbg")
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_upbg/#simage_bgimg")
	arg_1_0._simagebgimgtop = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	arg_1_0._upbgspine = gohelper.findChild(arg_1_0.viewGO, "#go_upbg/#go_upbgspine")
	arg_1_0._gosideways = gohelper.findChild(arg_1_0.viewGO, "#go_sideways")
	arg_1_0._goblur = gohelper.findChild(arg_1_0.viewGO, "#go_upbg/#simage_bgimg/#go_blur")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._cimagebgold = arg_4_0._simagebgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_4_0._cimagebgimg = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_4_0._imagebgold = gohelper.findChildImage(arg_4_0.viewGO, "#go_bottombg/#simage_bgold")
	arg_4_0._imagebgoldtop = gohelper.findChildImage(arg_4_0.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	arg_4_0._imagebg = gohelper.findChildImage(arg_4_0.viewGO, "#go_upbg/#simage_bgimg")
	arg_4_0._imagebgtop = gohelper.findChildImage(arg_4_0.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	arg_4_0._imgFitHeight = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	arg_4_0._imgOldFitHeight = arg_4_0._imagebgold.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	arg_4_0._bgAnimator = arg_4_0._gofront.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._bgBlur = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	arg_4_0._borderCanvas = arg_4_0._goblack:GetComponent(typeof(UnityEngine.CanvasGroup))

	arg_4_0:_loadRes()
	arg_4_0:_initData()
end

function var_0_0._loadRes(arg_5_0)
	local var_5_0 = "ui/materials/dynamic/story_fisheye.mat"
	local var_5_1 = "ui/materials/dynamic/uibackgoundblur.mat"
	local var_5_2 = "ui/materials/dynamic/uibackgoundblur_zone.mat"
	local var_5_3 = "ui/materials/dynamic/story_dissolve.mat"

	arg_5_0._matLoader = MultiAbLoader.New()

	arg_5_0._matLoader:addPath(var_5_0)
	arg_5_0._matLoader:addPath(var_5_1)
	arg_5_0._matLoader:addPath(var_5_2)
	arg_5_0._matLoader:addPath(var_5_3)
	arg_5_0._matLoader:startLoad(function()
		local var_6_0 = arg_5_0._matLoader:getAssetItem(var_5_0)

		if var_6_0 then
			arg_5_0._fisheyeMat = var_6_0:GetResource(var_5_0)
		else
			logError("Resource is not found at path : " .. var_5_0)
		end

		local var_6_1 = arg_5_0._matLoader:getAssetItem(var_5_1)

		if var_6_1 then
			arg_5_0._blurMat = var_6_1:GetResource(var_5_1)
		else
			logError("Resource is not found at path : " .. var_5_1)
		end

		local var_6_2 = arg_5_0._matLoader:getAssetItem(var_5_2)

		if var_6_2 then
			arg_5_0._blurZoneMat = var_6_2:GetResource(var_5_2)
		else
			logError("Resource is not found at path : " .. var_5_2)
		end

		local var_6_3 = arg_5_0._matLoader:getAssetItem(var_5_3)

		if var_6_3 then
			arg_5_0._dissolveMat = var_6_3:GetResource(var_5_3)
		else
			logError("Resource is not found at path : " .. var_5_3)
		end
	end, arg_5_0)

	arg_5_0.handleBgEffectFuncDict = {
		[StoryEnum.BgTransType.Hard] = arg_5_0._hardTrans,
		[StoryEnum.BgTransType.TransparencyFade] = arg_5_0._fadeTrans,
		[StoryEnum.BgTransType.DarkFade] = arg_5_0._darkFadeTrans,
		[StoryEnum.BgTransType.WhiteFade] = arg_5_0._whiteFadeTrans,
		[StoryEnum.BgTransType.UpDarkFade] = arg_5_0._darkUpTrans,
		[StoryEnum.BgTransType.RightDarkFade] = arg_5_0._rightDarkTrans,
		[StoryEnum.BgTransType.Fragmentate] = arg_5_0._fragmentTrans,
		[StoryEnum.BgTransType.Dissolve] = arg_5_0._dissolveTrans,
		[StoryEnum.BgTransType.LeftDarkFade] = arg_5_0._leftDarkTrans,
		[StoryEnum.BgTransType.MovieChangeStart] = arg_5_0._movieChangeStartTrans,
		[StoryEnum.BgTransType.MovieChangeSwitch] = arg_5_0._movieChangeSwitchTrans
	}
end

function var_0_0._initData(arg_7_0)
	arg_7_0._borderCanvas.alpha = 0
	arg_7_0._bgSpine = nil
	arg_7_0._bgCo = {}
	arg_7_0._lastBgCo = {}

	gohelper.setActive(arg_7_0._gobottom, false)
	gohelper.setActive(arg_7_0._gofront, false)
	arg_7_0:_showBgBottom(false)
	arg_7_0:_showBgTop(false)

	if StoryModel.instance.skipFade then
		gohelper.setActive(arg_7_0._goblack, false)
	end
end

function var_0_0.onOpen(arg_8_0)
	ViewMgr.instance:openView(ViewName.StoryHeroView, nil, false)
	ViewMgr.instance:openView(ViewName.StoryLeadRoleSpineView, nil, true)
	ViewMgr.instance:openView(ViewName.StoryView, nil, true)
	arg_8_0:_addEvents()
end

function var_0_0._addEvents(arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_9_0._onUpdateUI, arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.RefreshBackground, arg_9_0._colorFadeBgRefresh, arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.ShowBackground, arg_9_0._showBg, arg_9_0)
end

function var_0_0._showBg(arg_10_0)
	gohelper.setActive(arg_10_0._gobottom, true)
	gohelper.setActive(arg_10_0._gofront, true)
end

function var_0_0._onUpdateUI(arg_11_0, arg_11_1)
	arg_11_0:_checkPlayBorderFade(arg_11_1)

	if #arg_11_1.branches > 0 then
		return
	end

	arg_11_0._bgParam = arg_11_1

	arg_11_0:_checkPlayBgBlurFade()
	TaskDispatcher.cancelTask(arg_11_0._startShake, arg_11_0)

	local var_11_0 = StoryStepModel.instance:getStepListById(arg_11_0._bgParam.stepId).bg

	if var_11_0.transType == StoryEnum.BgTransType.Keep then
		return
	end

	arg_11_0._lastBgCo = LuaUtil.deepCopy(arg_11_0._bgCo)
	arg_11_0._bgCo = var_11_0

	arg_11_0:_resetData()
	TaskDispatcher.cancelTask(arg_11_0._enterChange, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._enterChange, arg_11_0, arg_11_0._bgCo.waitTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._checkPlayBorderFade(arg_12_0, arg_12_1)
	local var_12_0 = StoryStepModel.instance:getStepListById(arg_12_1.stepId).mourningBorder

	if arg_12_0._fadeType and arg_12_0._fadeType == var_12_0.borderType then
		return
	end

	arg_12_0._fadeType = var_12_0.borderType

	if arg_12_0._fadeType == StoryEnum.BorderType.Keep then
		return
	end

	if arg_12_0._borderFadeId then
		ZProj.TweenHelper.KillById(arg_12_0._borderFadeId)
	end

	if var_12_0.borderType == StoryEnum.BorderType.None then
		arg_12_0._borderCanvas.alpha = 1
	elseif var_12_0.borderType == StoryEnum.BorderType.FadeOut then
		arg_12_0._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_12_0._goblack, 1, 0, var_12_0.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	elseif var_12_0.borderType == StoryEnum.BorderType.FadeIn then
		arg_12_0._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_12_0._goblack, 0, 1, var_12_0.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._checkPlayBgBlurFade(arg_13_0)
	local var_13_0 = StoryStepModel.instance:getStepListById(arg_13_0._bgParam.stepId).bg

	if var_13_0.bgType ~= StoryEnum.BgType.Picture then
		return
	end

	if var_13_0.transType == StoryEnum.BgTransType.Keep then
		return
	end

	if var_13_0.bgImg ~= arg_13_0._bgCo.bgImg then
		return
	end

	if arg_13_0._bgCo.effType ~= StoryEnum.BgEffectType.BgBlur then
		return
	end

	arg_13_0:_actBgBlurFade()
end

function var_0_0._resetData(arg_14_0)
	if arg_14_0._goRightFade then
		gohelper.setActive(arg_14_0._goRightFade, false)
	end

	if arg_14_0._bgCo.transType ~= StoryEnum.BgTransType.RightDarkFade and arg_14_0._goLeftFade then
		gohelper.setActive(arg_14_0._goLeftFade, false)
	end

	if arg_14_0._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeStart and arg_14_0._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeSwitch then
		if arg_14_0._bgMovieGo then
			gohelper.setActive(arg_14_0._bgMovieGo, false)
		end

		if arg_14_0._moveCameraAnimator and arg_14_0._moveCameraAnimator.runtimeAnimatorController == arg_14_0._cameraMovieAnimator then
			arg_14_0._moveCameraAnimator.runtimeAnimatorController = nil
		end
	end

	gohelper.setActive(arg_14_0._goblur, false)

	arg_14_0._imgFitHeight.enabled = false
	arg_14_0._imgOldFitHeight.enabled = false
	arg_14_0._bgBlur.enabled = arg_14_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur
	arg_14_0._cimagebgimg.vecInSide = Vector4.zero
	arg_14_0._cimagebgold.vecInSide = Vector4.zero
	arg_14_0._bgBlur.zoneImage = nil

	if arg_14_0._imagebg.material ~= arg_14_0._blurMat or arg_14_0._bgCo.effType ~= StoryEnum.BgEffectType.BgBlur then
		arg_14_0._imagebg.material = nil
	end

	arg_14_0._imagebgtop.material = nil
	arg_14_0._imagebgold.material = nil
	arg_14_0._imagebgoldtop.material = nil

	arg_14_0:_shakeStop()
	TaskDispatcher.cancelTask(arg_14_0._shakeStop, arg_14_0)

	if arg_14_0._simagebgimg and arg_14_0._simagebgimg.gameObject then
		ZProj.TweenHelper.KillByObj(arg_14_0._simagebgimg.gameObject.transform)
	end

	if arg_14_0._dissolveId then
		ZProj.TweenHelper.KillById(arg_14_0._dissolveId)

		arg_14_0._dissolveId = nil
	end

	if arg_14_0._blurId then
		ZProj.TweenHelper.KillById(arg_14_0._blurId)

		arg_14_0._blurId = nil
	end
end

function var_0_0._enterChange(arg_15_0)
	arg_15_0._rootAni = nil

	if arg_15_0._loader then
		arg_15_0._loader:dispose()

		arg_15_0._loader = nil
	end

	if arg_15_0._bgSubGo then
		gohelper.destroy(arg_15_0._bgSubGo)

		arg_15_0._bgSubGo = nil
	end

	arg_15_0._matPath = nil
	arg_15_0._prefabPath = nil

	if arg_15_0.handleBgEffectFuncDict[arg_15_0._bgCo.transType] then
		arg_15_0.handleBgEffectFuncDict[arg_15_0._bgCo.transType](arg_15_0)
	else
		arg_15_0:_commonTrans(arg_15_0._bgCo.transType)
	end
end

function var_0_0._colorFadeBgRefresh(arg_16_0)
	if StoryBgZoneModel.instance:getBgZoneByPath(arg_16_0._bgCo.bgImg) then
		arg_16_0._cimagebgimg.enabled = true

		gohelper.setActive(arg_16_0._simagebgimgtop.gameObject, true)
	end

	arg_16_0:_hardTrans()
end

function var_0_0._hardTrans(arg_17_0)
	arg_17_0:_refreshBg()
	arg_17_0:_resetBgState()
end

function var_0_0._refreshBg(arg_18_0)
	if not arg_18_0._simagebgimg then
		return
	end

	if arg_18_0._bgCo.bgType == StoryEnum.BgType.Picture then
		if arg_18_0._bgCo.bgImg == "" then
			arg_18_0:_showBgTop(false)
			arg_18_0:_showBgBottom(false)

			return
		end

		arg_18_0:_showBgTop(true)
		gohelper.setActive(arg_18_0._upbgspine, false)
		arg_18_0:_loadTopBg()

		if arg_18_0._bgScaleId then
			ZProj.TweenHelper.KillById(arg_18_0._bgScaleId)

			arg_18_0._bgScaleId = nil
		end

		if arg_18_0._bgPosId then
			ZProj.TweenHelper.KillById(arg_18_0._bgPosId)

			arg_18_0._bgPosId = nil
		end

		if arg_18_0._bgRotateId then
			ZProj.TweenHelper.KillById(arg_18_0._bgRotateId)

			arg_18_0._bgRotateId = nil
		end

		if arg_18_0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not arg_18_0._lastBgCo.bgImg or arg_18_0._lastBgCo.bgImg == "" then
				arg_18_0:_showBgBottom(false)

				return
			end

			arg_18_0:_loadBottomBg()
		else
			gohelper.setActive(arg_18_0._bottombgSpine, true)
			arg_18_0:_showBgBottom(false)
			arg_18_0:_onOldBgEffectLoaded()
		end
	else
		arg_18_0:_showBgTop(false)

		if arg_18_0._bgCo.bgImg == "" or string.split(arg_18_0._bgCo.bgImg, ".")[1] == "" then
			gohelper.setActive(arg_18_0._upbgspine, false)

			return
		end

		gohelper.setActive(arg_18_0._upbgspine, true)

		arg_18_0._effectLoader = PrefabInstantiate.Create(arg_18_0._upbgspine)

		arg_18_0._effectLoader:startLoad(arg_18_0._bgCo.bgImg, arg_18_0._onNewBgEffectLoaded, arg_18_0)

		if arg_18_0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not arg_18_0._lastBgCo.bgImg or arg_18_0._lastBgCo.bgImg == "" then
				arg_18_0:_showBgBottom(false)

				return
			end

			arg_18_0:_loadBottomBg()
		else
			arg_18_0:_showBgBottom(false)
			gohelper.setActive(arg_18_0._bottombgSpine, true)
			arg_18_0:_onOldBgEffectLoaded()
		end
	end
end

function var_0_0._onNewBgImgLoaded(arg_19_0)
	if not arg_19_0._imagebg or not arg_19_0._imagebg.sprite then
		return
	end

	gohelper.setActive(arg_19_0.viewGO, true)

	local var_19_0, var_19_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_19_0._imagebg, 0, 0)

	arg_19_0._imgFitHeight.enabled = var_19_1 < 1080

	if var_19_1 >= 1080 then
		transformhelper.setLocalScale(arg_19_0._simagebgimg.transform, 1.05, 1.05, 1.05)
	end

	arg_19_0._imagebg:SetNativeSize()
	arg_19_0:_checkPlayEffect()
end

function var_0_0._showBgBottom(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._simagebgold.gameObject, arg_20_1)

	if not arg_20_1 then
		arg_20_0._simagebgold:UnLoadImage()
	end
end

function var_0_0._showBgTop(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._simagebgimg.gameObject, arg_21_1)

	if not arg_21_1 then
		arg_21_0._simagebgimg:UnLoadImage()
	end
end

function var_0_0._loadBottomBg(arg_22_0)
	gohelper.setActive(arg_22_0._simagebgold.gameObject, true)
	gohelper.setActive(arg_22_0._bottombgSpine, false)
	arg_22_0._simagebgold:UnLoadImage()
	arg_22_0._simagebgoldtop:UnLoadImage()

	local var_22_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_22_0._lastBgCo.bgImg)

	gohelper.setActive(arg_22_0._simagebgoldtop.gameObject, var_22_0)

	if var_22_0 then
		arg_22_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_22_0.path), arg_22_0._onOldBgImgTopLoaded, arg_22_0)
		transformhelper.setLocalPosXY(arg_22_0._simagebgoldtop.gameObject.transform, var_22_0.offsetX, var_22_0.offsetY)
		arg_22_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_22_0.sourcePath), arg_22_0._onOldBgImgLoaded, arg_22_0)

		arg_22_0._cimagebgold.vecInSide = Vector4.zero
	else
		arg_22_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_22_0._lastBgCo.bgImg), arg_22_0._onOldBgImgLoaded, arg_22_0)

		arg_22_0._cimagebgold.vecInSide = Vector4.zero
	end
end

function var_0_0._loadTopBg(arg_23_0)
	local var_23_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_23_0._bgCo.bgImg)

	gohelper.setActive(arg_23_0._simagebgimgtop.gameObject, false)

	if var_23_0 then
		if arg_23_0._simagebgimgtop.curImageUrl == ResUrl.getStoryRes(var_23_0.path) then
			arg_23_0:_onNewBgImgTopLoaded()
		else
			arg_23_0._simagebgimgtop:UnLoadImage()
			gohelper.setActive(arg_23_0._simagebgimgtop.gameObject, true)
			arg_23_0._simagebgimgtop:LoadImage(ResUrl.getStoryRes(var_23_0.path), arg_23_0._onNewBgImgTopLoaded, arg_23_0)
			transformhelper.setLocalPosXY(arg_23_0._simagebgimgtop.gameObject.transform, var_23_0.offsetX, var_23_0.offsetY)
		end
	else
		if arg_23_0._simagebgimg.curImageUrl == ResUrl.getStoryRes(arg_23_0._bgCo.bgImg) then
			arg_23_0:_onNewBgImgLoaded()
		else
			arg_23_0._simagebgimg:UnLoadImage()
			arg_23_0._simagebgimg:LoadImage(ResUrl.getStoryRes(arg_23_0._bgCo.bgImg), arg_23_0._onNewBgImgLoaded, arg_23_0)
		end

		arg_23_0._cimagebgimg.vecInSide = Vector4.zero
	end
end

function var_0_0._onNewBgImgTopLoaded(arg_24_0)
	local var_24_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_24_0._bgCo.bgImg)

	arg_24_0._imagebgtop:SetNativeSize()
	arg_24_0:_setZoneMat()

	if arg_24_0._simagebgimg.curImageUrl == ResUrl.getStoryRes(var_24_0.sourcePath) then
		arg_24_0:_onNewZoneBgImgLoaded()
	else
		arg_24_0._simagebgimg:UnLoadImage()
		arg_24_0._simagebgimg:LoadImage(ResUrl.getStoryRes(var_24_0.sourcePath), arg_24_0._onNewZoneBgImgLoaded, arg_24_0)
	end
end

function var_0_0._onNewZoneBgImgLoaded(arg_25_0)
	gohelper.setActive(arg_25_0._simagebgimgtop.gameObject, true)
	arg_25_0:_onNewBgImgLoaded()
	arg_25_0:_setZoneMat()
end

function var_0_0._setZoneMat(arg_26_0)
	if not arg_26_0._imagebg or not arg_26_0._imagebg.material or not arg_26_0._imagebgtop or not arg_26_0._imagebgtop.sprite then
		return
	end

	local var_26_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_26_0._bgCo.bgImg)
	local var_26_1 = Vector4(recthelper.getWidth(arg_26_0._imagebgtop.transform), recthelper.getHeight(arg_26_0._imagebgtop.transform), var_26_0.offsetX, var_26_0.offsetY)

	arg_26_0._cimagebgimg.vecInSide = var_26_1

	if arg_26_0._bgBlur.enabled then
		arg_26_0._bgBlur.zoneImage = arg_26_0._imagebgtop
	end
end

function var_0_0._onOldBgImgTopLoaded(arg_27_0)
	arg_27_0._imagebgoldtop:SetNativeSize()
end

function var_0_0._onOldBgImgLoaded(arg_28_0)
	local var_28_0, var_28_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_28_0._imagebgold, 0, 0)

	transformhelper.setLocalPosXY(arg_28_0._simagebgold.gameObject.transform, arg_28_0._lastBgCo.offset[1], arg_28_0._lastBgCo.offset[2])
	transformhelper.setLocalRotation(arg_28_0._simagebgold.gameObject.transform, 0, 0, arg_28_0._lastBgCo.angle)
	transformhelper.setLocalScale(arg_28_0._gobottom.transform, arg_28_0._lastBgCo.scale, arg_28_0._lastBgCo.scale, 1)

	arg_28_0._imgOldFitHeight.enabled = var_28_1 < 1080

	if var_28_1 >= 1080 then
		transformhelper.setLocalScale(arg_28_0._simagebgold.transform, 1.05, 1.05, 1.05)
	end

	arg_28_0._imagebgold:SetNativeSize()
end

function var_0_0._onNewBgEffectLoaded(arg_29_0)
	if arg_29_0._bgEffectGo then
		gohelper.destroy(arg_29_0._bgEffectGo)

		arg_29_0._bgEffectGo = nil
	end

	arg_29_0._bgEffectGo = arg_29_0._effectLoader:getInstGO()

	arg_29_0:_checkPlayEffect()
end

function var_0_0._onOldBgEffectLoaded(arg_30_0)
	if arg_30_0._bgEffectOldGo then
		gohelper.destroy(arg_30_0._bgEffectOldGo)

		arg_30_0._bgEffectOldGo = nil
	end

	if arg_30_0._bgEffectGo then
		arg_30_0._bgEffectOldGo = gohelper.clone(arg_30_0._bgEffectGo, arg_30_0._bottombgSpine, "effectold")

		gohelper.destroy(arg_30_0._bgEffectGo)

		arg_30_0._bgEffectGo = nil
	end
end

function var_0_0._advanceLoadBgOld(arg_31_0)
	arg_31_0._simagebgold:UnLoadImage()
	arg_31_0._simagebgoldtop:UnLoadImage()

	local var_31_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_31_0._bgCo.bgImg)

	gohelper.setActive(arg_31_0._simagebgoldtop.gameObject, var_31_0)

	if var_31_0 then
		arg_31_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_31_0.path), arg_31_0._onOldBgImgTopLoaded, arg_31_0)
		transformhelper.setLocalPosXY(arg_31_0._simagebgoldtop.gameObject.transform, var_31_0.offsetX, var_31_0.offsetY)
		arg_31_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_31_0.sourcePath), function()
			arg_31_0._imagebgold.color = Color.white

			arg_31_0._imagebgold:SetNativeSize()
			arg_31_0:_onNewBgImgLoaded()
		end)
	else
		arg_31_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_31_0._bgCo.bgImg), function()
			arg_31_0._imagebgold.color = Color.white

			arg_31_0._imagebgold:SetNativeSize()
			arg_31_0:_onNewBgImgLoaded()
		end)
	end
end

function var_0_0._checkPlayEffect(arg_34_0)
	if arg_34_0._lastBgSubGo and arg_34_0._lastBgCo.effType ~= StoryEnum.BgEffectType.BgGray then
		gohelper.destroy(arg_34_0._lastBgSubGo)

		arg_34_0._lastBgSubGo = nil
	end

	arg_34_0:_actFullGrayUpdate(0.5)
	arg_34_0:_actBgGrayUpdate(0)

	if arg_34_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		arg_34_0:_actBgBlur()

		return
	elseif arg_34_0._bgCo.effType == StoryEnum.BgEffectType.FishEye then
		arg_34_0:_actFishEye()
	elseif arg_34_0._bgCo.effType == StoryEnum.BgEffectType.Shake then
		arg_34_0:_actShake()
	elseif arg_34_0._bgCo.effType == StoryEnum.BgEffectType.FullBlur then
		arg_34_0:_actFullBlur()
	elseif arg_34_0._bgCo.effType == StoryEnum.BgEffectType.BgGray then
		arg_34_0:_actBgGray()
	elseif arg_34_0._bgCo.effType == StoryEnum.BgEffectType.FullGray then
		arg_34_0:_actFullGray()
	end

	arg_34_0._bgBlur.blurWeight = 0

	gohelper.setActive(arg_34_0._goblur, false)

	arg_34_0._bgBlur.enabled = false
	arg_34_0._cimagebgimg.vecInSide = Vector4.zero
	arg_34_0._bgBlur.zoneImage = nil
end

function var_0_0._resetBgState(arg_35_0)
	if not arg_35_0._simagebgimg or not arg_35_0._simagebgimg.gameObject then
		return
	end

	local var_35_0 = arg_35_0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_35_0 < 0.05 then
		transformhelper.setLocalPosXY(arg_35_0._simagebgimg.gameObject.transform, arg_35_0._bgCo.offset[1], arg_35_0._bgCo.offset[2])
		transformhelper.setLocalRotation(arg_35_0._simagebgimg.gameObject.transform, 0, 0, arg_35_0._bgCo.angle)
		transformhelper.setLocalScale(arg_35_0._gofront.transform, arg_35_0._bgCo.scale, arg_35_0._bgCo.scale, 1)
	else
		local var_35_1 = arg_35_0._bgCo.effType == StoryEnum.BgEffectType.MoveCurve and arg_35_0._bgCo.effDegree or EaseType.InCubic

		arg_35_0._bgPosId = ZProj.TweenHelper.DOAnchorPos(arg_35_0._simagebgimg.gameObject.transform, arg_35_0._bgCo.offset[1], arg_35_0._bgCo.offset[2], var_35_0, nil, nil, nil, var_35_1)
		arg_35_0._bgRotateId = ZProj.TweenHelper.DOLocalRotate(arg_35_0._simagebgimg.gameObject.transform, 0, 0, arg_35_0._bgCo.angle, var_35_0, nil, nil, nil, EaseType.InSine)
		arg_35_0._bgScaleId = ZProj.TweenHelper.DOScale(arg_35_0._gofront.gameObject.transform, arg_35_0._bgCo.scale, arg_35_0._bgCo.scale, 1, var_35_0, nil, nil, nil, EaseType.InQuad)
	end
end

function var_0_0._hideBg(arg_36_0)
	arg_36_0:_showBgBottom(false)
end

function var_0_0._fadeTrans(arg_37_0)
	if arg_37_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_37_0._imagebg.color.a = 0
		arg_37_0._imagebg.color = Color.white

		arg_37_0:_showBgTop(true)
		arg_37_0:_resetBgState()

		if arg_37_0._bgFadeId then
			ZProj.TweenHelper.KillById(arg_37_0._bgFadeId)
		end

		arg_37_0._bgFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_37_0._imagebg.gameObject, 0, 1, arg_37_0._bgCo.fadeTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_37_0._hideBg, arg_37_0, nil, EaseType.Linear)

		arg_37_0:_showBgBottom(true)
		arg_37_0:_loadTopBg()

		if not arg_37_0._lastBgCo or not next(arg_37_0._lastBgCo) or arg_37_0._lastBgCo.bgImg == "" then
			return
		end

		arg_37_0._simagebgold:UnLoadImage()
		arg_37_0._simagebgoldtop:UnLoadImage()

		local var_37_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_37_0._lastBgCo.bgImg)

		gohelper.setActive(arg_37_0._simagebgoldtop.gameObject, var_37_0)

		if var_37_0 then
			arg_37_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_37_0.path), arg_37_0._onOldBgImgTopLoaded, arg_37_0)
			transformhelper.setLocalPosXY(arg_37_0._simagebgoldtop.gameObject.transform, var_37_0.offsetX, var_37_0.offsetY)
			arg_37_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_37_0.sourcePath), function()
				arg_37_0._imagebgold.color = Color.white

				arg_37_0:_onOldBgImgLoaded()
				arg_37_0:_refreshBg()
			end)
		else
			arg_37_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_37_0._lastBgCo.bgImg), function()
				arg_37_0._imagebgold.color = Color.white

				arg_37_0:_onOldBgImgLoaded()
				arg_37_0:_refreshBg()
			end)
		end
	end
end

function var_0_0._darkFadeTrans(arg_40_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFade)
end

function var_0_0._whiteFadeTrans(arg_41_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayWhiteFade)
end

function var_0_0._darkUpTrans(arg_42_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFadeUp)
	arg_42_0:_refreshBg()
	arg_42_0:_resetBgState()
end

function var_0_0._commonTrans(arg_43_0, arg_43_1)
	arg_43_0._curTransType = arg_43_1

	local var_43_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_43_1)
	local var_43_1 = {}

	if var_43_0.prefab and var_43_0.prefab ~= "" then
		arg_43_0._prefabPath = ResUrl.getStoryBgEffect(var_43_0.prefab)

		table.insert(var_43_1, arg_43_0._prefabPath)
	end

	arg_43_0:loadRes(var_43_1, arg_43_0._onBgResLoaded, arg_43_0)
end

function var_0_0._onBgResLoaded(arg_44_0)
	if arg_44_0._prefabPath then
		local var_44_0 = arg_44_0._loader:getAssetItem(arg_44_0._prefabPath)

		arg_44_0._bgSubGo = gohelper.clone(var_44_0:GetResource(), arg_44_0._imagebg.gameObject)

		local var_44_1 = typeof(ZProj.MaterialPropsCtrl)
		local var_44_2 = arg_44_0._bgSubGo:GetComponent(var_44_1)

		if var_44_2 and var_44_2.mas ~= nil and var_44_2.mas[0] ~= nil then
			arg_44_0._imagebg.material = var_44_2.mas[0]
			arg_44_0._imagebgtop.material = var_44_2.mas[0]

			StoryTool.enablePostProcess(true)
		end

		if arg_44_0._curTransType == StoryEnum.BgTransType.Distort then
			StoryTool.enablePostProcess(true)

			arg_44_0._rootAni = gohelper.findChild(arg_44_0._bgSubGo, "root"):GetComponent(typeof(UnityEngine.Animator))

			TaskDispatcher.runDelay(arg_44_0._distortEnd, arg_44_0, arg_44_0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	end

	arg_44_0:_showBgBottom(true)

	if arg_44_0._bgCo.bgImg ~= "" then
		arg_44_0:_advanceLoadBgOld()
	end

	local var_44_3 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_44_0._curTransType).transTime

	TaskDispatcher.runDelay(arg_44_0._commonTransFinished, arg_44_0, var_44_3)
end

function var_0_0._commonTransFinished(arg_45_0)
	arg_45_0:_refreshBg()
	arg_45_0:_resetBgState()

	if StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_45_0._curTransType).transTime > 0 then
		arg_45_0._imagebg.material = nil
		arg_45_0._imagebgtop.material = nil
	end
end

function var_0_0._distortEnd(arg_46_0)
	if arg_46_0._rootAni then
		arg_46_0._rootAni:SetBool("change", true)
	end
end

function var_0_0._rightDarkTrans(arg_47_0)
	if not arg_47_0._goRightFade then
		local var_47_0 = arg_47_0.viewContainer:getSetting().otherRes[1]

		arg_47_0._goRightFade = arg_47_0.viewContainer:getResInst(var_47_0, arg_47_0._gosideways)
		arg_47_0._rightAnim = arg_47_0._goRightFade:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(arg_47_0._goRightFade, true)
	arg_47_0._rightAnim:Play()
	TaskDispatcher.runDelay(arg_47_0._changeRightDark, arg_47_0, 0.2)
end

function var_0_0._changeRightDark(arg_48_0)
	arg_48_0:_refreshBg()
	arg_48_0:_resetBgState()

	if arg_48_0._goLeftFade then
		gohelper.setActive(arg_48_0._goLeftFade, false)
	end
end

function var_0_0._leftDarkTrans(arg_49_0)
	if not arg_49_0._goLeftFade then
		local var_49_0 = arg_49_0.viewContainer:getSetting().otherRes[2]

		arg_49_0._goLeftFade = arg_49_0.viewContainer:getResInst(var_49_0, arg_49_0._gosideways)
		arg_49_0._leftAnim = arg_49_0._goLeftFade:GetComponent(typeof(UnityEngine.Animation))
	else
		gohelper.setActive(arg_49_0._goLeftFade, true)
	end

	if arg_49_0._goRightFade then
		gohelper.setActive(arg_49_0._goRightFade, false)
	end

	arg_49_0._leftAnim:Play()
	TaskDispatcher.runDelay(arg_49_0._leftDarkTransFinished, arg_49_0, 1.5)
end

function var_0_0._leftDarkTransFinished(arg_50_0)
	arg_50_0:_refreshBg()
	arg_50_0:_resetBgState()
end

function var_0_0._fragmentTrans(arg_51_0)
	return
end

function var_0_0._movieChangeStartTrans(arg_52_0)
	arg_52_0._curTransType = StoryEnum.BgTransType.MovieChangeStart

	local var_52_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_52_0._curTransType)
	local var_52_1 = {}

	if not arg_52_0._bgMovieGo then
		arg_52_0._moviePrefabPath = ResUrl.getStoryBgEffect(var_52_0.prefab)

		table.insert(var_52_1, arg_52_0._moviePrefabPath)
	end

	if not arg_52_0._cameraMovieAnimator then
		arg_52_0._cameraAnimPath = "ui/animations/dynamic/custommaterialpass.controller"

		table.insert(var_52_1, arg_52_0._cameraAnimPath)
	end

	arg_52_0:loadRes(var_52_1, arg_52_0._onMoveChangeBgResLoaded, arg_52_0)
end

function var_0_0._onMoveChangeBgResLoaded(arg_53_0)
	if not arg_53_0._bgMovieGo and arg_53_0._moviePrefabPath then
		local var_53_0 = arg_53_0._loader:getAssetItem(arg_53_0._moviePrefabPath)

		arg_53_0._bgMovieGo = gohelper.clone(var_53_0:GetResource(), arg_53_0._imagebg.gameObject)
		arg_53_0._simageMovieCurBg = gohelper.findChildSingleImage(arg_53_0._bgMovieGo, "#now/#simage_dec")
		arg_53_0._simageMovieNewBg = gohelper.findChildSingleImage(arg_53_0._bgMovieGo, "#next/#simage_dec")
	end

	gohelper.setActive(arg_53_0._bgMovieGo, true)

	arg_53_0._movieAnim = arg_53_0._bgMovieGo:GetComponent(gohelper.Type_Animator)

	if not arg_53_0._cameraMovieAnimator then
		arg_53_0._cameraMovieAnimator = arg_53_0._loader:getAssetItem(arg_53_0._cameraAnimPath):GetResource()
	end

	arg_53_0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_53_0._moveCameraAnimator.enabled = true
	arg_53_0._moveCameraAnimator.runtimeAnimatorController = arg_53_0._cameraMovieAnimator

	arg_53_0:_setMovieNowBg()
	arg_53_0._movieAnim:Play("idle", 0, 0)
end

function var_0_0._movieChangeSwitchTrans(arg_54_0)
	arg_54_0._curTransType = StoryEnum.BgTransType.MovieChangeSwitch

	if not arg_54_0._bgMovieGo then
		return
	end

	arg_54_0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_54_0._moveCameraAnimator.enabled = true
	arg_54_0._moveCameraAnimator.runtimeAnimatorController = arg_54_0._cameraMovieAnimator

	arg_54_0._simageMovieNewBg:LoadImage(ResUrl.getStoryRes(arg_54_0._bgCo.bgImg))

	if arg_54_0._movieAnim then
		arg_54_0._movieAnim:Play("switch", 0, 0)
		arg_54_0._moveCameraAnimator:Play("dynamicblur", 0, 0)
		TaskDispatcher.runDelay(arg_54_0._setMovieNowBg, arg_54_0, 0.3)
	end
end

function var_0_0._setMovieNowBg(arg_55_0)
	arg_55_0._simageMovieCurBg:LoadImage(ResUrl.getStoryRes(arg_55_0._bgCo.bgImg))
end

function var_0_0._dissolveTrans(arg_56_0)
	if arg_56_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_56_0:_showBgBottom(true)
		gohelper.setActive(arg_56_0._bottombgSpine, false)

		if arg_56_0._bgCo.bgImg ~= "" then
			arg_56_0:_advanceLoadBgOld()
		end
	else
		arg_56_0:_showBgBottom(false)
		gohelper.setActive(arg_56_0._bottombgSpine, true)

		if string.split(arg_56_0._bgCo.bgImg, ".")[1] ~= "" then
			arg_56_0._effectLoader = PrefabInstantiate.Create(arg_56_0._bottombgSpine)

			arg_56_0._effectLoader:startLoad(arg_56_0._bgCo.bgImg)
		end
	end

	arg_56_0._imagebg:SetNativeSize()

	arg_56_0._imagebg.material = arg_56_0._dissolveMat
	arg_56_0._imagebgtop.material = arg_56_0._dissolveMat

	arg_56_0:_dissolveChange(0)

	arg_56_0._dissolveId = ZProj.TweenHelper.DOTweenFloat(0, -1.2, 2, arg_56_0._dissolveChange, arg_56_0._dissolveFinished, arg_56_0, nil, EaseType.Linear)
end

function var_0_0._dissolveChange(arg_57_0, arg_57_1)
	arg_57_0._imagebg.material:SetFloat(ShaderPropertyId.DissolveFactor, arg_57_1)
	arg_57_0._imagebgtop.material:SetFloat(ShaderPropertyId.DissolveFactor, arg_57_1)
end

function var_0_0._dissolveFinished(arg_58_0)
	arg_58_0:_refreshBg()
	arg_58_0:_resetBgState()

	arg_58_0._imagebg.material = nil
	arg_58_0._imagebgtop.material = nil
end

function var_0_0._actBgBlur(arg_59_0)
	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	arg_59_0._imagebg.material = arg_59_0._blurMat
	arg_59_0._imagebgtop.material = arg_59_0._blurZoneMat
	arg_59_0._bgBlur.enabled = true

	local var_59_0 = {
		0,
		0.8,
		0.9,
		1
	}

	arg_59_0._bgBlur.blurFactor = 0

	local var_59_1 = arg_59_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_59_1 > 0.1 then
		arg_59_0._blurId = ZProj.TweenHelper.DOTweenFloat(arg_59_0._bgBlur.blurWeight, var_59_0[arg_59_0._bgCo.effDegree + 1], var_59_1, arg_59_0._blurChange, arg_59_0._blurFinished, arg_59_0, nil, EaseType.Linear)
	else
		arg_59_0:_blurChange(var_59_0[arg_59_0._bgCo.effDegree + 1])
	end
end

function var_0_0._blurChange(arg_60_0, arg_60_1)
	arg_60_0._bgBlur.blurWeight = arg_60_1
end

function var_0_0._blurFinished(arg_61_0)
	if arg_61_0._blurId then
		ZProj.TweenHelper.KillById(arg_61_0._blurId)

		arg_61_0._blurId = nil
	end
end

function var_0_0._actBgBlurFade(arg_62_0)
	local var_62_0 = arg_62_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if arg_62_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur and var_62_0 > 0.1 then
		return
	end

	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	local var_62_1 = arg_62_0._bgBlur.blurWeight

	arg_62_0._blurId = ZProj.TweenHelper.DOTweenFloat(var_62_1, 0, 1.5, arg_62_0._blurChange, arg_62_0._blurFinished, arg_62_0, nil, EaseType.Linear)
end

function var_0_0._actFishEye(arg_63_0)
	arg_63_0._imagebg.material = arg_63_0._fisheyeMat
	arg_63_0._imagebgtop.material = arg_63_0._fisheyeMat
end

function var_0_0._actShake(arg_64_0)
	if arg_64_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_64_0._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_64_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_64_0._startShake, arg_64_0, arg_64_0._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_65_0)
	arg_65_0._bgAnimator.enabled = true

	arg_65_0._bgAnimator:SetBool("stoploop", false)

	local var_65_0 = {
		"idle",
		"low",
		"middle",
		"high"
	}

	arg_65_0._bgAnimator:Play(var_65_0[arg_65_0._bgCo.effDegree + 1])

	arg_65_0._bgAnimator.speed = arg_65_0._bgCo.effRate

	TaskDispatcher.runDelay(arg_65_0._shakeStop, arg_65_0, arg_65_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_66_0)
	if arg_66_0._bgAnimator then
		arg_66_0._bgAnimator:SetBool("stoploop", true)
	end
end

function var_0_0._actFullBlur(arg_67_0)
	PostProcessingMgr.instance:setUIBlurActive(3)
	PostProcessingMgr.instance:setFreezeVisble(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, arg_67_0._bgCo.effDegree, arg_67_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._actBgGray(arg_68_0)
	if arg_68_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_68_0._bgGrayId)

		arg_68_0._bgGrayId = nil
	end

	arg_68_0:_actFullGrayUpdate(0.5)

	if arg_68_0._bgCo.effDegree == 0 then
		arg_68_0._prefabPath = ResUrl.getStoryBgEffect("v1a9_saturation")

		arg_68_0:loadRes({
			arg_68_0._prefabPath
		}, arg_68_0._actBgGrayLoaded, arg_68_0)
	else
		if not arg_68_0._prefabPath or not arg_68_0._bgSubGo then
			return
		end

		local var_68_0 = arg_68_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if not var_68_0 then
			return
		end

		StoryTool.enablePostProcess(true)

		if arg_68_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_68_0:_actBgGrayUpdate(0)
		else
			local var_68_1 = var_68_0.float_01

			arg_68_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(var_68_1, 0, arg_68_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_68_0._actBgGrayUpdate, arg_68_0._actBgGrayFinished, arg_68_0)
		end
	end
end

function var_0_0._actBgGrayLoaded(arg_69_0)
	if arg_69_0._bgSubGo and arg_69_0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
		if not arg_69_0._lastBgSubGo then
			arg_69_0._lastBgSubGo = gohelper.clone(arg_69_0._bgSubGo, arg_69_0._imagebgold.gameObject)
		end

		local var_69_0 = arg_69_0._lastBgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		arg_69_0._imagebgold.material = var_69_0.mas[0]
		arg_69_0._imagebgoldtop.material = var_69_0.mas[0]
	end

	if arg_69_0._prefabPath then
		if arg_69_0._bgSubGo and arg_69_0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
			gohelper.destroy(arg_69_0._bgSubGo)
		end

		local var_69_1 = arg_69_0._loader:getAssetItem(arg_69_0._prefabPath)

		arg_69_0._bgSubGo = gohelper.clone(var_69_1:GetResource(), arg_69_0._imagebg.gameObject)

		local var_69_2 = arg_69_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		arg_69_0._imagebg.material = var_69_2.mas[0]
		arg_69_0._imagebgtop.material = var_69_2.mas[0]

		StoryTool.enablePostProcess(true)

		if arg_69_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_69_0:_actBgGrayUpdate(1)
		else
			arg_69_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_69_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_69_0._actBgGrayUpdate, arg_69_0._actGrayFinished, arg_69_0)
		end
	end
end

function var_0_0._actBgGrayUpdate(arg_70_0, arg_70_1)
	if not arg_70_0._bgSubGo then
		return
	end

	local var_70_0 = arg_70_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not var_70_0 then
		return
	end

	var_70_0.float_01 = arg_70_1
end

function var_0_0._actGrayFinished(arg_71_0)
	if arg_71_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_71_0._bgGrayId)

		arg_71_0._bgGrayId = nil
	end
end

function var_0_0._actFullGray(arg_72_0)
	arg_72_0:_actBgGrayUpdate(0)

	if arg_72_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_72_0._bgGrayId)

		arg_72_0._bgGrayId = nil
	end

	if arg_72_0._bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		if arg_72_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_72_0:_actFullGrayUpdate(1)
		else
			arg_72_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0.5, 1, arg_72_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_72_0._actFullGrayUpdate, arg_72_0._actGrayFinished, arg_72_0)
		end
	elseif arg_72_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_72_0:_actFullGrayUpdate(0.5)
	else
		local var_72_0 = PostProcessingMgr.instance:getUIPPValue("Saturation")

		arg_72_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(var_72_0, 0.5, arg_72_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_72_0._actFullGrayUpdate, arg_72_0._actGrayFinished, arg_72_0)
	end
end

function var_0_0._actFullGrayUpdate(arg_73_0, arg_73_1)
	PostProcessingMgr.instance:setUIPPValue("saturation", arg_73_1)
	PostProcessingMgr.instance:setUIPPValue("Saturation", arg_73_1)
end

function var_0_0.loadRes(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	if arg_74_0._loader then
		arg_74_0._loader:dispose()

		arg_74_0._loader = nil
	end

	if arg_74_1 and #arg_74_1 > 0 then
		arg_74_0._loader = MultiAbLoader.New()

		arg_74_0._loader:setPathList(arg_74_1)
		arg_74_0._loader:startLoad(arg_74_2, arg_74_3)
	elseif arg_74_2 then
		arg_74_2(arg_74_3)
	end
end

function var_0_0.onClose(arg_75_0)
	arg_75_0:_clearBg()

	if arg_75_0._bgFadeId then
		ZProj.TweenHelper.KillById(arg_75_0._bgFadeId)
	end

	gohelper.setActive(arg_75_0.viewGO, false)
	ViewMgr.instance:closeView(ViewName.StoryHeroView)
	arg_75_0:_removeEvents()
end

function var_0_0._clearBg(arg_76_0)
	if arg_76_0._blurId then
		ZProj.TweenHelper.KillById(arg_76_0._blurId)

		arg_76_0._blurId = nil
	end

	if arg_76_0._bgScaleId then
		ZProj.TweenHelper.KillById(arg_76_0._bgScaleId)

		arg_76_0._bgScaleId = nil
	end

	if arg_76_0._bgPosId then
		ZProj.TweenHelper.KillById(arg_76_0._bgPosId)

		arg_76_0._bgPosId = nil
	end

	if arg_76_0._bgRotateId then
		ZProj.TweenHelper.KillById(arg_76_0._bgRotateId)

		arg_76_0._bgRotateId = nil
	end

	if arg_76_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_76_0._bgGrayId)

		arg_76_0._bgGrayId = nil
	end

	TaskDispatcher.cancelTask(arg_76_0._changeRightDark, arg_76_0)
	TaskDispatcher.cancelTask(arg_76_0._enterChange, arg_76_0)
	TaskDispatcher.cancelTask(arg_76_0._startShake, arg_76_0)
	TaskDispatcher.cancelTask(arg_76_0._shakeStop, arg_76_0)
	TaskDispatcher.cancelTask(arg_76_0._distortEnd, arg_76_0)
	TaskDispatcher.cancelTask(arg_76_0._leftDarkTransFinished, arg_76_0)
	TaskDispatcher.cancelTask(arg_76_0._commonTransFinished, arg_76_0)

	if arg_76_0._simagebgimg then
		arg_76_0._simagebgimg:UnLoadImage()

		arg_76_0._simagebgimg = nil
	end

	if arg_76_0._simagebgimgtop then
		arg_76_0._simagebgimgtop:UnLoadImage()

		arg_76_0._simagebgimgtop = nil
	end

	if arg_76_0._simagebgold then
		arg_76_0._simagebgold:UnLoadImage()

		arg_76_0._simagebgold = nil
	end

	if arg_76_0._simagebgoldtop then
		arg_76_0._simagebgoldtop:UnLoadImage()

		arg_76_0._simagebgoldtop = nil
	end
end

function var_0_0._removeEvents(arg_77_0)
	arg_77_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_77_0._onUpdateUI, arg_77_0)
	arg_77_0:removeEventCb(StoryController.instance, StoryEvent.RefreshBackground, arg_77_0._colorFadeBgRefresh, arg_77_0)
	arg_77_0:removeEventCb(StoryController.instance, StoryEvent.ShowBackground, arg_77_0._showBg, arg_77_0)
end

function var_0_0.onDestroyView(arg_78_0)
	arg_78_0:_clearBg()
	arg_78_0:_actFullGrayUpdate(0.5)

	if arg_78_0._borderFadeId then
		ZProj.TweenHelper.KillById(arg_78_0._borderFadeId)
	end

	if arg_78_0._loader then
		arg_78_0._loader:dispose()

		arg_78_0._loader = nil
	end

	if arg_78_0._matLoader then
		arg_78_0._matLoader:dispose()

		arg_78_0._matLoader = nil
	end
end

return var_0_0
