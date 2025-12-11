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
	arg_1_0._gobliteff = gohelper.findChild(arg_1_0.viewGO, "#go_blitbg")
	arg_1_0._gobliteffsecond = gohelper.findChild(arg_1_0.viewGO, "#go_blitbgsecond")

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
	arg_4_0._blitEff = arg_4_0._gobliteff:GetComponent(typeof(UrpCustom.UIBlitEffect))
	arg_4_0._blitEffSecond = arg_4_0._gobliteffsecond:GetComponent(typeof(UrpCustom.UIBlitEffect))

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

	arg_5_0._handleBgTransFuncDict = {
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
		[StoryEnum.BgTransType.MovieChangeSwitch] = arg_5_0._movieChangeSwitchTrans,
		[StoryEnum.BgTransType.TurnPage3] = arg_5_0._turnPageTrans,
		[StoryEnum.BgTransType.Bloom1] = arg_5_0._bloom1Trans,
		[StoryEnum.BgTransType.Bloom2] = arg_5_0._bloom2Trans,
		[StoryEnum.BgTransType.ShakeCamera] = arg_5_0._shakeCameraTrans
	}
	arg_5_0._handleBgEffsFuncDict = {
		[StoryEnum.BgEffectType.BgBlur] = arg_5_0._actBgEffBlur,
		[StoryEnum.BgEffectType.FishEye] = arg_5_0._actBgEffFishEye,
		[StoryEnum.BgEffectType.Shake] = arg_5_0._actBgEffShake,
		[StoryEnum.BgEffectType.FullBlur] = arg_5_0._actBgEffFullBlur,
		[StoryEnum.BgEffectType.BgGray] = arg_5_0._actBgEffGray,
		[StoryEnum.BgEffectType.FullGray] = arg_5_0._actBgEffFullGray,
		[StoryEnum.BgEffectType.Interfere] = arg_5_0._actBgEffInterfere,
		[StoryEnum.BgEffectType.Sketch] = arg_5_0._actBgEffSketch,
		[StoryEnum.BgEffectType.BlindFilter] = arg_5_0._actBgEffBlindFilter,
		[StoryEnum.BgEffectType.Opposition] = arg_5_0._actBgEffOpposition,
		[StoryEnum.BgEffectType.RgbSplit] = arg_5_0._actBgEffRgbSplit,
		[StoryEnum.BgEffectType.EagleEye] = arg_5_0._actBgEffEagleEye,
		[StoryEnum.BgEffectType.Filter] = arg_5_0._actBgEffFilter,
		[StoryEnum.BgEffectType.Distress] = arg_5_0._actBgEffDistress
	}
	arg_5_0._handleResetBgEffs = {
		[StoryEnum.BgEffectType.BgBlur] = arg_5_0._resetBgEffBlur,
		[StoryEnum.BgEffectType.FishEye] = arg_5_0._resetBgEffFishEye,
		[StoryEnum.BgEffectType.Shake] = arg_5_0._resetBgEffShake,
		[StoryEnum.BgEffectType.FullBlur] = arg_5_0._resetBgEffFullBlur,
		[StoryEnum.BgEffectType.BgGray] = arg_5_0._resetBgEffGray,
		[StoryEnum.BgEffectType.FullGray] = arg_5_0._resetBgEffFullGray,
		[StoryEnum.BgEffectType.Interfere] = arg_5_0._resetBgEffInterfere,
		[StoryEnum.BgEffectType.Sketch] = arg_5_0._resetBgEffSketch,
		[StoryEnum.BgEffectType.BlindFilter] = arg_5_0._resetBgEffBlindFilter,
		[StoryEnum.BgEffectType.Opposition] = arg_5_0._resetBgEffOpposition,
		[StoryEnum.BgEffectType.RgbSplit] = arg_5_0._resetBgEffRgbSplit,
		[StoryEnum.BgEffectType.EagleEye] = arg_5_0._resetBgEffEagleEye,
		[StoryEnum.BgEffectType.Filter] = arg_5_0._resetBgEffFilter,
		[StoryEnum.BgEffectType.Distress] = arg_5_0._resetBgEffDistress
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

	arg_13_0:_actBgEffBlurFade()
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

	if not arg_14_0:_ignoreClearMat() then
		arg_14_0._imagebg.material = nil
	end

	arg_14_0._imagebgtop.material = nil
	arg_14_0._imagebgold.material = nil
	arg_14_0._imagebgoldtop.material = nil

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

function var_0_0._ignoreClearMat(arg_15_0)
	if arg_15_0._imagebg.material == arg_15_0._blurMat and arg_15_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		return true
	end

	if (arg_15_0._lastBgCo.transType == StoryEnum.BgTransType.MeltOut15 or arg_15_0._lastBgCo.transType == StoryEnum.BgTransType.MeltOut25) and (arg_15_0._bgCo.transType == StoryEnum.BgTransType.MeltIn15 or arg_15_0._bgCo.transType == StoryEnum.BgTransType.MeltIn25 or arg_15_0._bgCo.transType == StoryEnum.BgTransType.Hard) then
		return true
	end

	return false
end

function var_0_0._enterChange(arg_16_0)
	arg_16_0._rootAni = nil

	if arg_16_0._loader then
		arg_16_0._loader:dispose()

		arg_16_0._loader = nil
	end

	if arg_16_0._bgSubGo then
		gohelper.destroy(arg_16_0._bgSubGo)

		arg_16_0._bgSubGo = nil
	end

	arg_16_0._matPath = nil
	arg_16_0._prefabPath = nil

	if arg_16_0._handleBgTransFuncDict[arg_16_0._bgCo.transType] then
		arg_16_0._handleBgTransFuncDict[arg_16_0._bgCo.transType](arg_16_0)
	else
		arg_16_0:_commonTrans(arg_16_0._bgCo.transType)
	end

	arg_16_0:_checkBgEffStack()
end

function var_0_0._checkBgEffStack(arg_17_0)
	local var_17_0 = StoryModel.instance:getCurStepId()
	local var_17_1 = StoryModel.instance:getPreSteps(var_17_0)

	if not var_17_1 or #var_17_1 < 1 then
		return
	end

	local var_17_2 = StoryStepModel.instance:getStepListById(var_17_1[1])

	if not var_17_2 then
		return
	end

	if var_17_2.conversation.type == StoryEnum.ConversationType.BgEffStack then
		local var_17_3 = var_17_2.bg.effType

		if arg_17_0._handleBgEffsFuncDict[var_17_3] then
			arg_17_0._handleBgEffsFuncDict[var_17_3](arg_17_0, var_17_2.bg)
		end
	end
end

function var_0_0._colorFadeBgRefresh(arg_18_0)
	if StoryBgZoneModel.instance:getBgZoneByPath(arg_18_0._bgCo.bgImg) then
		arg_18_0._cimagebgimg.enabled = true

		gohelper.setActive(arg_18_0._simagebgimgtop.gameObject, true)
	end

	arg_18_0:_hardTrans()
end

function var_0_0._hardTrans(arg_19_0)
	arg_19_0:_refreshBg()
	arg_19_0:_resetBgState()
end

function var_0_0._refreshBg(arg_20_0)
	if arg_20_0._lastCaptureTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_20_0._lastCaptureTexture)

		arg_20_0._lastCaptureTexture = nil
	end

	if not arg_20_0._simagebgimg then
		return
	end

	if arg_20_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_20_0._lastCaptureTexture = UnityEngine.RenderTexture.GetTemporary(arg_20_0._blitEff.capturedTexture.width, arg_20_0._blitEff.capturedTexture.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

		UnityEngine.Graphics.CopyTexture(arg_20_0._blitEff.capturedTexture, arg_20_0._lastCaptureTexture)

		if arg_20_0._bgCo.bgImg == "" then
			arg_20_0:_showBgTop(false)
			arg_20_0:_showBgBottom(false)

			return
		end

		arg_20_0:_showBgTop(true)
		gohelper.setActive(arg_20_0._upbgspine, false)
		arg_20_0:_loadTopBg()

		if arg_20_0._bgScaleId then
			ZProj.TweenHelper.KillById(arg_20_0._bgScaleId)

			arg_20_0._bgScaleId = nil
		end

		if arg_20_0._bgPosId then
			ZProj.TweenHelper.KillById(arg_20_0._bgPosId)

			arg_20_0._bgPosId = nil
		end

		if arg_20_0._bgRotateId then
			ZProj.TweenHelper.KillById(arg_20_0._bgRotateId)

			arg_20_0._bgRotateId = nil
		end

		if arg_20_0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not arg_20_0._lastBgCo.bgImg or arg_20_0._lastBgCo.bgImg == "" then
				arg_20_0:_showBgBottom(false)

				return
			end

			arg_20_0:_loadBottomBg()
		else
			gohelper.setActive(arg_20_0._bottombgSpine, true)
			arg_20_0:_showBgBottom(false)
			arg_20_0:_onOldBgEffectLoaded()
		end
	else
		arg_20_0:_showBgTop(false)

		if arg_20_0._bgCo.bgImg == "" or string.split(arg_20_0._bgCo.bgImg, ".")[1] == "" then
			gohelper.setActive(arg_20_0._upbgspine, false)

			return
		end

		gohelper.setActive(arg_20_0._upbgspine, true)

		arg_20_0._effectLoader = PrefabInstantiate.Create(arg_20_0._upbgspine)

		arg_20_0._effectLoader:startLoad(arg_20_0._bgCo.bgImg, arg_20_0._onNewBgEffectLoaded, arg_20_0)

		if arg_20_0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not arg_20_0._lastBgCo.bgImg or arg_20_0._lastBgCo.bgImg == "" then
				arg_20_0:_showBgBottom(false)

				return
			end

			arg_20_0:_loadBottomBg()
		else
			arg_20_0:_showBgBottom(false)
			gohelper.setActive(arg_20_0._bottombgSpine, true)
			arg_20_0:_onOldBgEffectLoaded()
		end
	end
end

function var_0_0._onNewBgImgLoaded(arg_21_0)
	if arg_21_0._bgCo.transType == StoryEnum.BgTransType.Hard and arg_21_0._bgCo.effType == StoryEnum.BgEffectType.None then
		arg_21_0._imagebg.material = nil
	end

	if not arg_21_0._imagebg or not arg_21_0._imagebg.sprite then
		return
	end

	gohelper.setActive(arg_21_0.viewGO, true)

	local var_21_0, var_21_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_21_0._imagebg, 0, 0)

	arg_21_0._imgFitHeight.enabled = var_21_1 < 1080

	if var_21_1 >= 1080 then
		transformhelper.setLocalScale(arg_21_0._simagebgimg.transform, 1.05, 1.05, 1.05)
	end

	arg_21_0._imagebg:SetNativeSize()
	arg_21_0:_checkPlayEffect()
end

function var_0_0._showBgBottom(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._simagebgold.gameObject, arg_22_1)

	if not arg_22_1 then
		arg_22_0._simagebgold:UnLoadImage()
	end
end

function var_0_0._showBgTop(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._simagebgimg.gameObject, arg_23_1)

	if not arg_23_1 then
		arg_23_0._simagebgimg:UnLoadImage()
	end
end

function var_0_0._loadBottomBg(arg_24_0)
	gohelper.setActive(arg_24_0._simagebgold.gameObject, true)
	gohelper.setActive(arg_24_0._bottombgSpine, false)
	arg_24_0._simagebgold:UnLoadImage()
	arg_24_0._simagebgoldtop:UnLoadImage()

	local var_24_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_24_0._lastBgCo.bgImg)

	gohelper.setActive(arg_24_0._simagebgoldtop.gameObject, var_24_0)

	if var_24_0 then
		arg_24_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_24_0.path), arg_24_0._onOldBgImgTopLoaded, arg_24_0)
		transformhelper.setLocalPosXY(arg_24_0._simagebgoldtop.gameObject.transform, var_24_0.offsetX, var_24_0.offsetY)
		arg_24_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_24_0.sourcePath), arg_24_0._onOldBgImgLoaded, arg_24_0)

		arg_24_0._cimagebgold.vecInSide = Vector4.zero
	else
		arg_24_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_24_0._lastBgCo.bgImg), arg_24_0._onOldBgImgLoaded, arg_24_0)

		arg_24_0._cimagebgold.vecInSide = Vector4.zero
	end
end

function var_0_0._loadTopBg(arg_25_0)
	local var_25_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_25_0._bgCo.bgImg)

	gohelper.setActive(arg_25_0._simagebgimgtop.gameObject, false)

	arg_25_0._cimagebgimg.enabled = true

	if var_25_0 then
		if arg_25_0._simagebgimgtop.curImageUrl == ResUrl.getStoryRes(var_25_0.path) then
			arg_25_0:_onNewBgImgTopLoaded()
		else
			arg_25_0._simagebgimgtop:UnLoadImage()
			gohelper.setActive(arg_25_0._simagebgimgtop.gameObject, true)
			arg_25_0._simagebgimgtop:LoadImage(ResUrl.getStoryRes(var_25_0.path), arg_25_0._onNewBgImgTopLoaded, arg_25_0)
			transformhelper.setLocalPosXY(arg_25_0._simagebgimgtop.gameObject.transform, var_25_0.offsetX, var_25_0.offsetY)
		end
	else
		if arg_25_0._simagebgimg.curImageUrl == ResUrl.getStoryRes(arg_25_0._bgCo.bgImg) then
			arg_25_0:_onNewBgImgLoaded()
		else
			arg_25_0._simagebgimg:UnLoadImage()
			arg_25_0._simagebgimg:LoadImage(ResUrl.getStoryRes(arg_25_0._bgCo.bgImg), arg_25_0._onNewBgImgLoaded, arg_25_0)
		end

		arg_25_0._cimagebgimg.vecInSide = Vector4.zero
	end
end

function var_0_0._onNewBgImgTopLoaded(arg_26_0)
	local var_26_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_26_0._bgCo.bgImg)

	if not var_26_0 then
		return
	end

	arg_26_0._imagebgtop:SetNativeSize()
	arg_26_0:_setZoneMat()

	if arg_26_0._simagebgimg.curImageUrl == ResUrl.getStoryRes(var_26_0.sourcePath) then
		arg_26_0:_onNewZoneBgImgLoaded()
	else
		arg_26_0._simagebgimg:UnLoadImage()
		arg_26_0._simagebgimg:LoadImage(ResUrl.getStoryRes(var_26_0.sourcePath), arg_26_0._onNewZoneBgImgLoaded, arg_26_0)
	end
end

function var_0_0._onNewZoneBgImgLoaded(arg_27_0)
	gohelper.setActive(arg_27_0._simagebgimgtop.gameObject, true)
	arg_27_0:_onNewBgImgLoaded()
	arg_27_0:_setZoneMat()
end

function var_0_0._setZoneMat(arg_28_0)
	if not arg_28_0._imagebg or not arg_28_0._imagebg.material or not arg_28_0._imagebgtop or not arg_28_0._imagebgtop.sprite then
		return
	end

	local var_28_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_28_0._bgCo.bgImg)

	if not var_28_0 then
		return
	end

	local var_28_1 = Vector4(recthelper.getWidth(arg_28_0._imagebgtop.transform), recthelper.getHeight(arg_28_0._imagebgtop.transform), var_28_0.offsetX, var_28_0.offsetY)

	arg_28_0._cimagebgimg.vecInSide = var_28_1

	if arg_28_0._bgBlur.enabled then
		arg_28_0._bgBlur.zoneImage = arg_28_0._imagebgtop
	end
end

function var_0_0._onOldBgImgTopLoaded(arg_29_0)
	arg_29_0._imagebgoldtop:SetNativeSize()
end

function var_0_0._onOldBgImgLoaded(arg_30_0)
	local var_30_0, var_30_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_30_0._imagebgold, 0, 0)

	transformhelper.setLocalPosXY(arg_30_0._simagebgold.gameObject.transform, arg_30_0._lastBgCo.offset[1], arg_30_0._lastBgCo.offset[2])
	transformhelper.setLocalRotation(arg_30_0._simagebgold.gameObject.transform, 0, 0, arg_30_0._lastBgCo.angle)
	transformhelper.setLocalScale(arg_30_0._gobottom.transform, arg_30_0._lastBgCo.scale, arg_30_0._lastBgCo.scale, 1)

	arg_30_0._imgOldFitHeight.enabled = var_30_1 < 1080

	if var_30_1 >= 1080 then
		transformhelper.setLocalScale(arg_30_0._simagebgold.transform, 1.05, 1.05, 1.05)
	end

	arg_30_0._imagebgold:SetNativeSize()
end

function var_0_0._onNewBgEffectLoaded(arg_31_0)
	if arg_31_0._bgEffectGo then
		gohelper.destroy(arg_31_0._bgEffectGo)

		arg_31_0._bgEffectGo = nil
	end

	arg_31_0._bgEffectGo = arg_31_0._effectLoader:getInstGO()

	arg_31_0:_checkPlayEffect()
end

function var_0_0._onOldBgEffectLoaded(arg_32_0)
	if arg_32_0._bgEffectOldGo then
		gohelper.destroy(arg_32_0._bgEffectOldGo)

		arg_32_0._bgEffectOldGo = nil
	end

	if arg_32_0._bgEffectGo then
		arg_32_0._bgEffectOldGo = gohelper.clone(arg_32_0._bgEffectGo, arg_32_0._bottombgSpine, "effectold")

		gohelper.destroy(arg_32_0._bgEffectGo)

		arg_32_0._bgEffectGo = nil
	end
end

function var_0_0._advanceLoadBgOld(arg_33_0)
	arg_33_0._simagebgold:UnLoadImage()
	arg_33_0._simagebgoldtop:UnLoadImage()

	local var_33_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_33_0._bgCo.bgImg)

	gohelper.setActive(arg_33_0._simagebgoldtop.gameObject, var_33_0)

	if var_33_0 then
		arg_33_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_33_0.path), arg_33_0._onOldBgImgTopLoaded, arg_33_0)
		transformhelper.setLocalPosXY(arg_33_0._simagebgoldtop.gameObject.transform, var_33_0.offsetX, var_33_0.offsetY)
		arg_33_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_33_0.sourcePath), function()
			arg_33_0._imagebgold.color = Color.white

			arg_33_0._imagebgold:SetNativeSize()
			arg_33_0:_onNewBgImgLoaded()
		end)
	else
		arg_33_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_33_0._bgCo.bgImg), function()
			arg_33_0._imagebgold.color = Color.white

			arg_33_0._imagebgold:SetNativeSize()
			arg_33_0:_onNewBgImgLoaded()
		end)
	end
end

function var_0_0._checkPlayEffect(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0._handleResetBgEffs) do
		if arg_36_0._bgCo.effType ~= iter_36_0 then
			iter_36_1(arg_36_0)
		end
	end

	if arg_36_0._handleBgEffsFuncDict[arg_36_0._bgCo.effType] then
		arg_36_0._handleBgEffsFuncDict[arg_36_0._bgCo.effType](arg_36_0)
	end
end

function var_0_0._resetBgEffBlur(arg_37_0)
	if arg_37_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		return
	end

	arg_37_0._bgBlur.blurWeight = 0

	gohelper.setActive(arg_37_0._goblur, false)

	arg_37_0._bgBlur.enabled = false
	arg_37_0._cimagebgimg.vecInSide = Vector4.zero
	arg_37_0._bgBlur.zoneImage = nil
end

function var_0_0._resetBgEffFishEye(arg_38_0)
	if arg_38_0._bgCo.effType == StoryEnum.BgEffectType.FishEye then
		return
	end
end

function var_0_0._resetBgEffShake(arg_39_0)
	if arg_39_0._bgCo.effType == StoryEnum.BgEffectType.Shake then
		return
	end

	local var_39_0 = StoryModel.instance:getCurStepId()
	local var_39_1 = StoryModel.instance:getPreSteps(var_39_0)

	if not var_39_1 or #var_39_1 < 1 then
		arg_39_0:_shakeStop()

		return
	end

	local var_39_2 = StoryStepModel.instance:getStepListById(var_39_1[1])

	if not var_39_2 then
		arg_39_0:_shakeStop()

		return
	end

	if var_39_2.conversation.type ~= StoryEnum.ConversationType.BgEffStack then
		arg_39_0:_shakeStop()
	end
end

function var_0_0._resetBgEffFullBlur(arg_40_0)
	if arg_40_0._bgCo.effType == StoryEnum.BgEffectType.FullBlur then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, 0)
end

function var_0_0._resetBgEffGray(arg_41_0)
	if arg_41_0._bgCo.effType == StoryEnum.BgEffectType.BgGray then
		return
	end

	if arg_41_0._lastBgSubGo and arg_41_0._lastBgCo.effType ~= StoryEnum.BgEffectType.BgGray then
		gohelper.destroy(arg_41_0._lastBgSubGo)

		arg_41_0._lastBgSubGo = nil
	end

	arg_41_0:_actBgEffGrayUpdate(0)
end

function var_0_0._resetBgEffFullGray(arg_42_0)
	if arg_42_0._bgCo.effType == StoryEnum.BgEffectType.FullGray then
		return
	end

	arg_42_0:_actBgEffFullGrayUpdate(0.5)
end

function var_0_0._resetBgEffEagleEye(arg_43_0)
	if arg_43_0._bgCo.effType == StoryEnum.BgEffectType.EagleEye then
		return
	end

	arg_43_0:_onEagleEyeFinished()
end

function var_0_0._resetBgEffFilter(arg_44_0)
	if arg_44_0._bgCo.effType == StoryEnum.BgEffectType.Filter then
		return
	end

	arg_44_0:_onBgFliterEffFinished()
end

function var_0_0._resetBgEffDistress(arg_45_0)
	if arg_45_0._bgCo.effType == StoryEnum.BgEffectType.Distress then
		return
	end

	if arg_45_0._bgDistressCls then
		arg_45_0._bgDistressCls:destroy()

		arg_45_0._bgDistressCls = nil
	end
end

function var_0_0._resetBgState(arg_46_0)
	if not arg_46_0._simagebgimg or not arg_46_0._simagebgimg.gameObject then
		return
	end

	local var_46_0 = arg_46_0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_46_0 < 0.05 then
		transformhelper.setLocalPosXY(arg_46_0._simagebgimg.gameObject.transform, arg_46_0._bgCo.offset[1], arg_46_0._bgCo.offset[2])
		transformhelper.setLocalRotation(arg_46_0._simagebgimg.gameObject.transform, 0, 0, arg_46_0._bgCo.angle)
		transformhelper.setLocalScale(arg_46_0._gofront.transform, arg_46_0._bgCo.scale, arg_46_0._bgCo.scale, 1)
	else
		local var_46_1 = arg_46_0._bgCo.effType == StoryEnum.BgEffectType.MoveCurve and arg_46_0._bgCo.effDegree or EaseType.InCubic

		arg_46_0._bgPosId = ZProj.TweenHelper.DOAnchorPos(arg_46_0._simagebgimg.gameObject.transform, arg_46_0._bgCo.offset[1], arg_46_0._bgCo.offset[2], var_46_0, nil, nil, nil, var_46_1)
		arg_46_0._bgRotateId = ZProj.TweenHelper.DOLocalRotate(arg_46_0._simagebgimg.gameObject.transform, 0, 0, arg_46_0._bgCo.angle, var_46_0, nil, nil, nil, EaseType.InSine)
		arg_46_0._bgScaleId = ZProj.TweenHelper.DOScale(arg_46_0._gofront.gameObject.transform, arg_46_0._bgCo.scale, arg_46_0._bgCo.scale, 1, var_46_0, nil, nil, nil, EaseType.InQuad)
	end
end

function var_0_0._hideBg(arg_47_0)
	arg_47_0:_showBgBottom(false)
end

function var_0_0._fadeTrans(arg_48_0)
	if arg_48_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_48_0._imagebg.color.a = 0
		arg_48_0._imagebg.color = Color.white

		arg_48_0:_showBgTop(true)
		arg_48_0:_resetBgState()

		if arg_48_0._bgFadeId then
			ZProj.TweenHelper.KillById(arg_48_0._bgFadeId)
		end

		arg_48_0._bgFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_48_0._imagebg.gameObject, 0, 1, arg_48_0._bgCo.fadeTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_48_0._hideBg, arg_48_0, nil, EaseType.Linear)

		arg_48_0:_showBgBottom(true)
		arg_48_0:_loadTopBg()

		if not arg_48_0._lastBgCo or not next(arg_48_0._lastBgCo) or arg_48_0._lastBgCo.bgImg == "" then
			return
		end

		arg_48_0._simagebgold:UnLoadImage()
		arg_48_0._simagebgoldtop:UnLoadImage()

		local var_48_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_48_0._lastBgCo.bgImg)

		gohelper.setActive(arg_48_0._simagebgoldtop.gameObject, var_48_0)

		if var_48_0 then
			arg_48_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_48_0.path), arg_48_0._onOldBgImgTopLoaded, arg_48_0)
			transformhelper.setLocalPosXY(arg_48_0._simagebgoldtop.gameObject.transform, var_48_0.offsetX, var_48_0.offsetY)
			arg_48_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_48_0.sourcePath), function()
				arg_48_0._imagebgold.color = Color.white

				arg_48_0:_onOldBgImgLoaded()
				arg_48_0:_refreshBg()
			end)
		else
			arg_48_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_48_0._lastBgCo.bgImg), function()
				arg_48_0._imagebgold.color = Color.white

				arg_48_0:_onOldBgImgLoaded()
				arg_48_0:_refreshBg()
			end)
		end
	end
end

function var_0_0._darkFadeTrans(arg_51_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFade)
end

function var_0_0._whiteFadeTrans(arg_52_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayWhiteFade)
end

function var_0_0._darkUpTrans(arg_53_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFadeUp)
	arg_53_0:_refreshBg()
	arg_53_0:_resetBgState()
end

function var_0_0._commonTrans(arg_54_0, arg_54_1)
	arg_54_0._curTransType = arg_54_1

	local var_54_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_54_1)
	local var_54_1 = {}

	if var_54_0.prefab and var_54_0.prefab ~= "" then
		arg_54_0._prefabPath = ResUrl.getStoryBgEffect(var_54_0.prefab)

		table.insert(var_54_1, arg_54_0._prefabPath)
	end

	arg_54_0:loadRes(var_54_1, arg_54_0._onBgResLoaded, arg_54_0)
end

function var_0_0._onBgResLoaded(arg_55_0)
	if arg_55_0._prefabPath then
		local var_55_0 = arg_55_0._loader:getAssetItem(arg_55_0._prefabPath)

		arg_55_0._bgSubGo = gohelper.clone(var_55_0:GetResource(), arg_55_0._imagebg.gameObject)

		local var_55_1 = typeof(ZProj.MaterialPropsCtrl)
		local var_55_2 = arg_55_0._bgSubGo:GetComponent(var_55_1)

		if var_55_2 and var_55_2.mas ~= nil and var_55_2.mas[0] ~= nil then
			arg_55_0._imagebg.material = var_55_2.mas[0]
			arg_55_0._imagebgtop.material = var_55_2.mas[0]

			StoryTool.enablePostProcess(true)
		end

		if arg_55_0._curTransType == StoryEnum.BgTransType.Distort then
			StoryTool.enablePostProcess(true)

			arg_55_0._rootAni = gohelper.findChild(arg_55_0._bgSubGo, "root"):GetComponent(typeof(UnityEngine.Animator))

			TaskDispatcher.runDelay(arg_55_0._distortEnd, arg_55_0, arg_55_0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	end

	arg_55_0:_showBgBottom(true)

	if arg_55_0._bgCo.bgImg ~= "" then
		arg_55_0:_advanceLoadBgOld()
	end

	local var_55_3 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_55_0._curTransType).transTime

	TaskDispatcher.runDelay(arg_55_0._commonTransFinished, arg_55_0, var_55_3)
end

function var_0_0._commonTransFinished(arg_56_0)
	arg_56_0:_refreshBg()
	arg_56_0:_resetBgState()

	if StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_56_0._curTransType).transTime > 0 then
		arg_56_0._imagebg.material = nil
		arg_56_0._imagebgtop.material = nil
	end
end

function var_0_0._distortEnd(arg_57_0)
	if arg_57_0._rootAni then
		arg_57_0._rootAni:SetBool("change", true)
	end
end

function var_0_0._rightDarkTrans(arg_58_0)
	if not arg_58_0._goRightFade then
		local var_58_0 = arg_58_0.viewContainer:getSetting().otherRes[1]

		arg_58_0._goRightFade = arg_58_0.viewContainer:getResInst(var_58_0, arg_58_0._gosideways)
		arg_58_0._rightAnim = arg_58_0._goRightFade:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(arg_58_0._goRightFade, true)
	arg_58_0._rightAnim:Play()
	TaskDispatcher.runDelay(arg_58_0._changeRightDark, arg_58_0, 0.2)
end

function var_0_0._changeRightDark(arg_59_0)
	arg_59_0:_refreshBg()
	arg_59_0:_resetBgState()

	if arg_59_0._goLeftFade then
		gohelper.setActive(arg_59_0._goLeftFade, false)
	end
end

function var_0_0._leftDarkTrans(arg_60_0)
	if not arg_60_0._goLeftFade then
		local var_60_0 = arg_60_0.viewContainer:getSetting().otherRes[2]

		arg_60_0._goLeftFade = arg_60_0.viewContainer:getResInst(var_60_0, arg_60_0._gosideways)
		arg_60_0._leftAnim = arg_60_0._goLeftFade:GetComponent(typeof(UnityEngine.Animation))
	else
		gohelper.setActive(arg_60_0._goLeftFade, true)
	end

	if arg_60_0._goRightFade then
		gohelper.setActive(arg_60_0._goRightFade, false)
	end

	arg_60_0._leftAnim:Play()
	TaskDispatcher.runDelay(arg_60_0._leftDarkTransFinished, arg_60_0, 1.5)
end

function var_0_0._leftDarkTransFinished(arg_61_0)
	arg_61_0:_refreshBg()
	arg_61_0:_resetBgState()
end

function var_0_0._fragmentTrans(arg_62_0)
	return
end

function var_0_0._movieChangeStartTrans(arg_63_0)
	arg_63_0._curTransType = StoryEnum.BgTransType.MovieChangeStart

	local var_63_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_63_0._curTransType)
	local var_63_1 = {}

	if not arg_63_0._bgMovieGo then
		arg_63_0._moviePrefabPath = ResUrl.getStoryBgEffect(var_63_0.prefab)

		table.insert(var_63_1, arg_63_0._moviePrefabPath)
	end

	if not arg_63_0._cameraMovieAnimator then
		arg_63_0._cameraAnimPath = "ui/animations/dynamic/custommaterialpass.controller"

		table.insert(var_63_1, arg_63_0._cameraAnimPath)
	end

	arg_63_0:loadRes(var_63_1, arg_63_0._onMoveChangeBgResLoaded, arg_63_0)
end

function var_0_0._onMoveChangeBgResLoaded(arg_64_0)
	if not arg_64_0._bgMovieGo and arg_64_0._moviePrefabPath then
		local var_64_0 = arg_64_0._loader:getAssetItem(arg_64_0._moviePrefabPath)

		arg_64_0._bgMovieGo = gohelper.clone(var_64_0:GetResource(), arg_64_0._imagebg.gameObject)
		arg_64_0._simageMovieCurBg = gohelper.findChildSingleImage(arg_64_0._bgMovieGo, "#now/#simage_dec")
		arg_64_0._simageMovieNewBg = gohelper.findChildSingleImage(arg_64_0._bgMovieGo, "#next/#simage_dec")
	end

	gohelper.setActive(arg_64_0._bgMovieGo, true)

	arg_64_0._movieAnim = arg_64_0._bgMovieGo:GetComponent(gohelper.Type_Animator)

	if not arg_64_0._cameraMovieAnimator then
		arg_64_0._cameraMovieAnimator = arg_64_0._loader:getAssetItem(arg_64_0._cameraAnimPath):GetResource()
	end

	arg_64_0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_64_0._moveCameraAnimator.enabled = true
	arg_64_0._moveCameraAnimator.runtimeAnimatorController = arg_64_0._cameraMovieAnimator

	arg_64_0:_setMovieNowBg()
	arg_64_0._movieAnim:Play("idle", 0, 0)
end

function var_0_0._movieChangeSwitchTrans(arg_65_0)
	arg_65_0._curTransType = StoryEnum.BgTransType.MovieChangeSwitch

	if not arg_65_0._bgMovieGo then
		return
	end

	arg_65_0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_65_0._moveCameraAnimator.enabled = true
	arg_65_0._moveCameraAnimator.runtimeAnimatorController = arg_65_0._cameraMovieAnimator

	arg_65_0._simageMovieNewBg:LoadImage(ResUrl.getStoryRes(arg_65_0._bgCo.bgImg))

	if arg_65_0._movieAnim then
		arg_65_0._movieAnim:Play("switch", 0, 0)
		arg_65_0._moveCameraAnimator:Play("dynamicblur", 0, 0)
		TaskDispatcher.runDelay(arg_65_0._setMovieNowBg, arg_65_0, 0.3)
	end
end

function var_0_0._setMovieNowBg(arg_66_0)
	arg_66_0._simageMovieCurBg:LoadImage(ResUrl.getStoryRes(arg_66_0._bgCo.bgImg))
end

function var_0_0._turnPageTrans(arg_67_0)
	arg_67_0._curTransType = StoryEnum.BgTransType.TurnPage3

	local var_67_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_67_0._curTransType)
	local var_67_1 = {}

	if not arg_67_0._turnPageGo then
		arg_67_0._turnPagePrefabPath = ResUrl.getStoryBgEffect(var_67_0.prefab)

		table.insert(var_67_1, arg_67_0._turnPagePrefabPath)
	end

	arg_67_0:loadRes(var_67_1, arg_67_0._onTurnPageBgResLoaded, arg_67_0)
end

function var_0_0._onTurnPageBgResLoaded(arg_68_0)
	if not arg_68_0._turnPageGo and arg_68_0._turnPagePrefabPath then
		local var_68_0 = arg_68_0._loader:getAssetItem(arg_68_0._turnPagePrefabPath)

		arg_68_0._turnPageGo = gohelper.clone(var_68_0:GetResource(), arg_68_0._imagebg.gameObject)
		arg_68_0._turnPageAnim = arg_68_0._turnPageGo:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(arg_68_0._turnPageGo, true)
	StoryTool.enablePostProcess(true)

	local var_68_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	arg_68_0._imgAnim = gohelper.findChild(var_68_1, "#go_middle/#go_img2"):GetComponent(typeof(UnityEngine.Animation))

	arg_68_0._imgAnim:Play()
	arg_68_0._turnPageAnim:Play()
	TaskDispatcher.runDelay(arg_68_0._onTurnPageFinished, arg_68_0, 0.67)
end

function var_0_0._onTurnPageFinished(arg_69_0)
	if arg_69_0._turnPageGo then
		gohelper.destroy(arg_69_0._turnPageGo)

		arg_69_0._turnPageGo = nil
	end

	arg_69_0._imgAnim:GetComponent(gohelper.Type_RectMask2D).padding = Vector4(0, 0, 0, 0)
end

function var_0_0._shakeCameraTrans(arg_70_0)
	arg_70_0._curTransType = StoryEnum.BgTransType.ShakeCamera
	arg_70_0._bgTrans = StoryBgTransCameraShake.New()

	arg_70_0._bgTrans:init()
	arg_70_0._bgTrans:start(arg_70_0._onShakeCameraFinished, arg_70_0)
end

function var_0_0._onShakeCameraFinished(arg_71_0)
	if arg_71_0._bgTrans then
		arg_71_0._bgTrans:destroy()

		arg_71_0._bgTrans = nil
	end
end

function var_0_0._dissolveTrans(arg_72_0)
	if arg_72_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_72_0:_showBgBottom(true)
		gohelper.setActive(arg_72_0._bottombgSpine, false)

		if arg_72_0._bgCo.bgImg ~= "" then
			arg_72_0:_advanceLoadBgOld()
		end
	else
		arg_72_0:_showBgBottom(false)
		gohelper.setActive(arg_72_0._bottombgSpine, true)

		if string.split(arg_72_0._bgCo.bgImg, ".")[1] ~= "" then
			arg_72_0._effectLoader = PrefabInstantiate.Create(arg_72_0._bottombgSpine)

			arg_72_0._effectLoader:startLoad(arg_72_0._bgCo.bgImg)
		end
	end

	arg_72_0._imagebg:SetNativeSize()

	arg_72_0._imagebg.material = arg_72_0._dissolveMat
	arg_72_0._imagebgtop.material = arg_72_0._dissolveMat

	arg_72_0:_dissolveChange(0)

	arg_72_0._dissolveId = ZProj.TweenHelper.DOTweenFloat(0, -1.2, 2, arg_72_0._dissolveChange, arg_72_0._dissolveFinished, arg_72_0, nil, EaseType.Linear)
end

function var_0_0._dissolveChange(arg_73_0, arg_73_1)
	arg_73_0._imagebg.material:SetFloat(ShaderPropertyId.DissolveFactor, arg_73_1)
	arg_73_0._imagebgtop.material:SetFloat(ShaderPropertyId.DissolveFactor, arg_73_1)
end

function var_0_0._dissolveFinished(arg_74_0)
	arg_74_0:_refreshBg()
	arg_74_0:_resetBgState()

	arg_74_0._imagebg.material = nil
	arg_74_0._imagebgtop.material = nil
end

function var_0_0._bloom1Trans(arg_75_0)
	arg_75_0:_bloomTrans(StoryEnum.BgTransType.Bloom1)
end

function var_0_0._bloom2Trans(arg_76_0)
	arg_76_0:_bloomTrans(StoryEnum.BgTransType.Bloom2)
end

function var_0_0._bloomTrans(arg_77_0, arg_77_1)
	arg_77_0._curTransType = arg_77_1

	if arg_77_0._bgTrans then
		arg_77_0._bgTrans:destroy()

		arg_77_0._bgTrans = nil
	end

	arg_77_0._bgTrans = StoryBgTransBloom.New()

	arg_77_0._bgTrans:init()
	arg_77_0._bgTrans:setBgTransType(arg_77_1)
	arg_77_0._bgTrans:start(arg_77_0._bloomFinished, arg_77_0)
end

function var_0_0._bloomFinished(arg_78_0)
	if arg_78_0._bgTrans then
		arg_78_0._bgTrans:destroy()

		arg_78_0._bgTrans = nil
	end
end

function var_0_0._actBgEffBlur(arg_79_0)
	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	arg_79_0._imagebg.material = arg_79_0._blurMat
	arg_79_0._imagebgtop.material = arg_79_0._blurZoneMat
	arg_79_0._bgBlur.enabled = true

	local var_79_0 = {
		0,
		0.8,
		0.9,
		1
	}

	arg_79_0._bgBlur.blurFactor = 0

	local var_79_1 = arg_79_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_79_1 > 0.1 then
		arg_79_0._blurId = ZProj.TweenHelper.DOTweenFloat(arg_79_0._bgBlur.blurWeight, var_79_0[arg_79_0._bgCo.effDegree + 1], var_79_1, arg_79_0._blurChange, arg_79_0._blurFinished, arg_79_0, nil, EaseType.Linear)
	else
		arg_79_0:_blurChange(var_79_0[arg_79_0._bgCo.effDegree + 1])
	end
end

function var_0_0._blurChange(arg_80_0, arg_80_1)
	if not arg_80_0._bgBlur then
		arg_80_0:_blurFinished()

		return
	end

	arg_80_0._bgBlur.blurWeight = arg_80_1
end

function var_0_0._blurFinished(arg_81_0)
	if arg_81_0._blurId then
		ZProj.TweenHelper.KillById(arg_81_0._blurId)

		arg_81_0._blurId = nil
	end
end

function var_0_0._actBgEffBlurFade(arg_82_0)
	local var_82_0 = arg_82_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if arg_82_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur and var_82_0 > 0.1 then
		return
	end

	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	local var_82_1 = arg_82_0._bgBlur.blurWeight

	arg_82_0._blurId = ZProj.TweenHelper.DOTweenFloat(var_82_1, 0, 1.5, arg_82_0._blurChange, arg_82_0._blurFinished, arg_82_0, nil, EaseType.Linear)
end

function var_0_0._actBgEffFishEye(arg_83_0)
	arg_83_0._imagebg.material = arg_83_0._fisheyeMat
	arg_83_0._imagebgtop.material = arg_83_0._fisheyeMat
end

function var_0_0._actBgEffShake(arg_84_0, arg_84_1)
	arg_84_0._stackBgCo = arg_84_1
	arg_84_1 = arg_84_1 or arg_84_0._bgCo

	TaskDispatcher.cancelTask(arg_84_0._startShake, arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._shakeStop, arg_84_0)

	if arg_84_1.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_84_1.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_84_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_84_0._startShake, arg_84_0, arg_84_1.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_85_0)
	local var_85_0 = arg_85_0._stackBgCo or arg_85_0._bgCo

	arg_85_0._bgAnimator.enabled = true

	arg_85_0._bgAnimator:SetBool("stoploop", false)

	local var_85_1 = {
		"idle",
		"low",
		"middle",
		"high"
	}

	arg_85_0._bgAnimator:Play(var_85_1[var_85_0.effDegree + 1])

	arg_85_0._bgAnimator.speed = var_85_0.effRate

	TaskDispatcher.runDelay(arg_85_0._shakeStop, arg_85_0, var_85_0.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._startShake, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._shakeStop, arg_86_0)

	if arg_86_0._bgAnimator then
		arg_86_0._bgAnimator:SetBool("stoploop", true)
	end
end

function var_0_0._actBgEffFullBlur(arg_87_0)
	if arg_87_0._bgCo.effDegree == StoryEnum.EffDegree.None then
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, arg_87_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, arg_87_0._bgCo.effDegree, arg_87_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._actBgEffGray(arg_88_0)
	if arg_88_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_88_0._bgGrayId)

		arg_88_0._bgGrayId = nil
	end

	arg_88_0:_actBgEffFullGrayUpdate(0.5)

	if arg_88_0._bgCo.effDegree == 0 then
		arg_88_0._prefabPath = ResUrl.getStoryBgEffect("v1a9_saturation")

		arg_88_0:loadRes({
			arg_88_0._prefabPath
		}, arg_88_0._actBgEffGrayLoaded, arg_88_0)
	else
		if not arg_88_0._prefabPath or not arg_88_0._bgSubGo then
			return
		end

		local var_88_0 = arg_88_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if not var_88_0 then
			return
		end

		StoryTool.enablePostProcess(true)

		if arg_88_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_88_0:_actBgEffGrayUpdate(0)
		else
			local var_88_1 = var_88_0.float_01

			arg_88_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(var_88_1, 0, arg_88_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_88_0._actBgEffGrayUpdate, arg_88_0._actBgEffGrayFinished, arg_88_0)
		end
	end
end

function var_0_0._actBgEffGrayLoaded(arg_89_0)
	if arg_89_0._bgSubGo and arg_89_0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
		if not arg_89_0._lastBgSubGo then
			arg_89_0._lastBgSubGo = gohelper.clone(arg_89_0._bgSubGo, arg_89_0._imagebgold.gameObject)
		end

		local var_89_0 = arg_89_0._lastBgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		arg_89_0._imagebgold.material = var_89_0.mas[0]
		arg_89_0._imagebgoldtop.material = var_89_0.mas[0]
	end

	if arg_89_0._prefabPath then
		if arg_89_0._bgSubGo and arg_89_0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
			gohelper.destroy(arg_89_0._bgSubGo)
		end

		local var_89_1 = arg_89_0._loader:getAssetItem(arg_89_0._prefabPath)

		arg_89_0._bgSubGo = gohelper.clone(var_89_1:GetResource(), arg_89_0._imagebg.gameObject)

		local var_89_2 = arg_89_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		arg_89_0._imagebg.material = var_89_2.mas[0]
		arg_89_0._imagebgtop.material = var_89_2.mas[0]

		StoryTool.enablePostProcess(true)

		if arg_89_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_89_0:_actBgEffGrayUpdate(1)
		else
			arg_89_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_89_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_89_0._actBgEffGrayUpdate, arg_89_0._actGrayFinished, arg_89_0)
		end
	end
end

function var_0_0._actBgEffGrayUpdate(arg_90_0, arg_90_1)
	if not arg_90_0._bgSubGo then
		return
	end

	local var_90_0 = arg_90_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not var_90_0 then
		return
	end

	var_90_0.float_01 = arg_90_1
end

function var_0_0._actGrayFinished(arg_91_0)
	if arg_91_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_91_0._bgGrayId)

		arg_91_0._bgGrayId = nil
	end
end

function var_0_0._actBgEffFullGray(arg_92_0)
	arg_92_0:_actBgEffGrayUpdate(0)

	if arg_92_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_92_0._bgGrayId)

		arg_92_0._bgGrayId = nil
	end

	if arg_92_0._bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		if arg_92_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_92_0:_actBgEffFullGrayUpdate(1)
		else
			arg_92_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0.5, 1, arg_92_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_92_0._actBgEffFullGrayUpdate, arg_92_0._actGrayFinished, arg_92_0)
		end
	elseif arg_92_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_92_0:_actBgEffFullGrayUpdate(0.5)
	else
		local var_92_0 = PostProcessingMgr.instance:getUIPPValue("Saturation")

		arg_92_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(var_92_0, 0.5, arg_92_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_92_0._actBgEffFullGrayUpdate, arg_92_0._actGrayFinished, arg_92_0)
	end
end

function var_0_0._actBgEffFullGrayUpdate(arg_93_0, arg_93_1)
	PostProcessingMgr.instance:setUIPPValue("saturation", arg_93_1)
	PostProcessingMgr.instance:setUIPPValue("Saturation", arg_93_1)
end

function var_0_0._resetBgEffInterfere(arg_94_0)
	if arg_94_0._bgCo.effType == StoryEnum.BgEffectType.Interfere then
		return
	end

	if arg_94_0._interfereGo then
		gohelper.destroy(arg_94_0._interfereGo)

		arg_94_0._interfereGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	gohelper.setLayer(arg_94_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._actBgEffInterfere(arg_95_0)
	if arg_95_0._interfereGo then
		arg_95_0:_setInterfere()
	else
		arg_95_0._interfereEffPrefPath = ResUrl.getStoryBgEffect("glitch_common")

		local var_95_0 = {}

		table.insert(var_95_0, arg_95_0._interfereEffPrefPath)
		arg_95_0:loadRes(var_95_0, arg_95_0._onInterfereResLoaded, arg_95_0)
	end
end

function var_0_0._onInterfereResLoaded(arg_96_0)
	if arg_96_0._interfereEffPrefPath then
		local var_96_0 = arg_96_0._loader:getAssetItem(arg_96_0._interfereEffPrefPath)
		local var_96_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_96_0._interfereGo = gohelper.clone(var_96_0:GetResource(), var_96_1)

		arg_96_0:_setInterfere()
	end
end

function var_0_0._setInterfere(arg_97_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_97_0._interfereGo)
	arg_97_0._interfereGo:GetComponent(typeof(UnityEngine.UI.Image)).material:SetTexture("_MainTex", arg_97_0._blitEff.capturedTexture)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	gohelper.setLayer(arg_97_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._resetBgEffSketch(arg_98_0)
	if arg_98_0._bgCo.effType == StoryEnum.BgEffectType.Sketch then
		return
	end

	if arg_98_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_98_0._bgSketchId)

		arg_98_0._bgSketchId = nil
	end

	if arg_98_0._sketchGo then
		gohelper.destroy(arg_98_0._sketchGo)

		arg_98_0._sketchGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	gohelper.setLayer(arg_98_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._actBgEffSketch(arg_99_0)
	if arg_99_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_99_0._bgSketchId)

		arg_99_0._bgSketchId = nil
	end

	if arg_99_0._bgCo.effDegree == 0 and not arg_99_0._sketchGo then
		return
	end

	if arg_99_0._sketchGo then
		arg_99_0:_setSketch()
	else
		arg_99_0._sketchEffPrefPath = ResUrl.getStoryBgEffect("storybg_sketch")

		local var_99_0 = {}

		table.insert(var_99_0, arg_99_0._sketchEffPrefPath)
		arg_99_0:loadRes(var_99_0, arg_99_0._onSketchResLoaded, arg_99_0)
	end
end

local var_0_1 = {
	1,
	0.4,
	0.2,
	0
}

function var_0_0._onSketchResLoaded(arg_100_0)
	if arg_100_0._sketchEffPrefPath then
		local var_100_0 = arg_100_0._loader:getAssetItem(arg_100_0._sketchEffPrefPath)
		local var_100_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_100_0._sketchGo = gohelper.clone(var_100_0:GetResource(), var_100_1)

		arg_100_0:_setSketch()
	end
end

function var_0_0._setSketch(arg_101_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_101_0._sketchGo)

	arg_101_0._imgSketch = arg_101_0._sketchGo:GetComponent(typeof(UnityEngine.UI.Image))

	arg_101_0._imgSketch.material:SetTexture("_MainTex", arg_101_0._blitEff.capturedTexture)

	if arg_101_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_101_0:_sketchUpdate(var_0_1[arg_101_0._bgCo.effDegree + 1])
	else
		local var_101_0 = arg_101_0._bgCo.effDegree > 0 and 1 or arg_101_0._imgSketch.material:GetFloat("_SourceColLerp")

		arg_101_0._bgSketchId = ZProj.TweenHelper.DOTweenFloat(var_101_0, var_0_1[arg_101_0._bgCo.effDegree + 1], arg_101_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_101_0._sketchUpdate, arg_101_0._sketchFinished, arg_101_0)
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	gohelper.setLayer(arg_101_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._sketchUpdate(arg_102_0, arg_102_1)
	arg_102_0._imgSketch.material:SetFloat("_SourceColLerp", arg_102_1)
end

function var_0_0._sketchFinished(arg_103_0)
	if arg_103_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_103_0._bgSketchId)

		arg_103_0._bgSketchId = nil
	end
end

function var_0_0._resetBgEffBlindFilter(arg_104_0)
	if arg_104_0._bgCo.effType == StoryEnum.BgEffectType.BlindFilter then
		return
	end

	if arg_104_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_104_0._bgFilterId)

		arg_104_0._bgFilterId = nil
	end

	if arg_104_0._filterGo then
		gohelper.destroy(arg_104_0._filterGo)

		arg_104_0._filterGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	gohelper.setLayer(arg_104_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._actBgEffBlindFilter(arg_105_0)
	if arg_105_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_105_0._bgFilterId)

		arg_105_0._bgFilterId = nil
	end

	if arg_105_0._bgCo.effDegree == 0 and not arg_105_0._filterGo then
		return
	end

	if arg_105_0._filterGo then
		arg_105_0:_setBlindFilter()
	else
		arg_105_0._filterEffPrefPath = ResUrl.getStoryBgEffect("storybg_blinder")

		local var_105_0 = {}

		table.insert(var_105_0, arg_105_0._filterEffPrefPath)
		arg_105_0:loadRes(var_105_0, arg_105_0._onFilterResLoaded, arg_105_0)
	end
end

function var_0_0._onFilterResLoaded(arg_106_0)
	if arg_106_0._filterEffPrefPath then
		local var_106_0 = arg_106_0._loader:getAssetItem(arg_106_0._filterEffPrefPath)
		local var_106_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_106_0._filterGo = gohelper.clone(var_106_0:GetResource(), var_106_1)

		arg_106_0:_setBlindFilter()
	end
end

local var_0_2 = {
	1,
	0.4,
	0.2,
	0
}

function var_0_0._setBlindFilter(arg_107_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_107_0._filterGo)

	arg_107_0._imgFilter = arg_107_0._filterGo:GetComponent(typeof(UnityEngine.UI.Image))

	arg_107_0._imgFilter.material:SetTexture("_MainTex", arg_107_0._blitEff.capturedTexture)

	if arg_107_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_107_0:_filterUpdate(var_0_2[arg_107_0._bgCo.effDegree + 1])
	else
		local var_107_0 = arg_107_0._bgCo.effDegree > 0 and 1 or arg_107_0._imgFilter.material:GetFloat("_SourceColLerp")

		arg_107_0._bgFilterId = ZProj.TweenHelper.DOTweenFloat(var_107_0, var_0_2[arg_107_0._bgCo.effDegree + 1], arg_107_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_107_0._filterUpdate, arg_107_0._filterFinished, arg_107_0)
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	gohelper.setLayer(arg_107_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._filterUpdate(arg_108_0, arg_108_1)
	arg_108_0._imgFilter.material:SetFloat("_SourceColLerp", arg_108_1)
end

function var_0_0._filterFinished(arg_109_0)
	if arg_109_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_109_0._bgFilterId)

		arg_109_0._bgFilterId = nil
	end
end

function var_0_0._actBgEffEagleEye(arg_110_0)
	arg_110_0._bgEffEagleEye = StoryBgEffsEagleEye.New()

	arg_110_0._bgEffEagleEye:init(arg_110_0._bgCo)
	arg_110_0._bgEffEagleEye:start(arg_110_0._onEagleEyeFinished, arg_110_0)
end

function var_0_0._onEagleEyeFinished(arg_111_0)
	if arg_111_0._bgEffEagleEye then
		arg_111_0._bgEffEagleEye:destroy()

		arg_111_0._bgEffEagleEye = nil
	end
end

function var_0_0._actBgEffFilter(arg_112_0)
	if not arg_112_0._bgFilterCls then
		arg_112_0._bgFilterCls = StoryBgEffsFilter.New()

		arg_112_0._bgFilterCls:init(arg_112_0._bgCo)
		arg_112_0._bgFilterCls:start(arg_112_0._onBgFliterEffFinished, arg_112_0)
	else
		arg_112_0._bgFilterCls:reset(arg_112_0._bgCo)
	end
end

function var_0_0._onBgFliterEffFinished(arg_113_0)
	if arg_113_0._bgFilterCls then
		arg_113_0._bgFilterCls:destroy()

		arg_113_0._bgFilterCls = nil
	end
end

function var_0_0._actBgEffDistress(arg_114_0)
	if not arg_114_0._bgDistressCls then
		arg_114_0._bgDistressCls = StoryBgEffsDistress.New()

		arg_114_0._bgDistressCls:init(arg_114_0._bgCo)
		arg_114_0._bgDistressCls:start()
	else
		arg_114_0._bgDistressCls:reset(arg_114_0._bgCo)
	end
end

function var_0_0._resetBgEffOpposition(arg_115_0)
	if arg_115_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_115_0._bgOppositionId)

		arg_115_0._bgOppositionId = nil
	end

	if arg_115_0._oppositionGo then
		gohelper.destroy(arg_115_0._oppositionGo)

		arg_115_0._oppositionGo = nil
	end

	local var_115_0 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_115_0, UnityLayer.UISecond, true)

	local var_115_1 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_115_2 = gohelper.findChild(var_115_1, "#go_spineroot")

	gohelper.setLayer(var_115_2, UnityLayer.UIThird, true)
	gohelper.setLayer(arg_115_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._actBgEffOpposition(arg_116_0)
	if arg_116_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_116_0._bgOppositionId)

		arg_116_0._bgOppositionId = nil
	end

	if arg_116_0._bgCo.effDegree == 0 and not arg_116_0._oppositionGo then
		return
	end

	if arg_116_0._oppositionGo then
		arg_116_0:_setOpposition()
	else
		arg_116_0._oppositonPrefPath = ResUrl.getStoryBgEffect("storybg_colorinverse")

		local var_116_0 = {}

		table.insert(var_116_0, arg_116_0._oppositonPrefPath)
		arg_116_0:loadRes(var_116_0, arg_116_0._onOppositionResLoaded, arg_116_0)
	end
end

function var_0_0._onOppositionResLoaded(arg_117_0)
	if arg_117_0._oppositonPrefPath then
		local var_117_0 = arg_117_0._loader:getAssetItem(arg_117_0._oppositonPrefPath)
		local var_117_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_117_0._oppositionGo = gohelper.clone(var_117_0:GetResource(), var_117_1)

		arg_117_0:_setOpposition()
	end
end

local var_0_3 = {
	1,
	0.4,
	0.2,
	0
}

function var_0_0._setOpposition(arg_118_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_118_0._oppositionGo)

	arg_118_0._imgOpposition = arg_118_0._oppositionGo:GetComponent(typeof(UnityEngine.UI.Image))

	arg_118_0._imgOpposition.material:SetTexture("_MainTex", arg_118_0._blitEff.capturedTexture)

	if arg_118_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_118_0:_oppositionUpdate(var_0_3[arg_118_0._bgCo.effDegree + 1])
	else
		local var_118_0 = arg_118_0._bgCo.effDegree > 0 and 1 or arg_118_0._imgOpposition.material:GetFloat("_ColorInverseFactor")

		arg_118_0._bgOppositionId = ZProj.TweenHelper.DOTweenFloat(var_118_0, var_0_3[arg_118_0._bgCo.effDegree + 1], arg_118_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_118_0._oppositionUpdate, arg_118_0._oppositionFinished, arg_118_0)
	end

	local var_118_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_118_1, UnityLayer.UITop, true)

	local var_118_2 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_118_3 = gohelper.findChild(var_118_2, "#go_spineroot")

	gohelper.setLayer(var_118_3, UnityLayer.UITop, true)
	gohelper.setLayer(arg_118_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._oppositionUpdate(arg_119_0, arg_119_1)
	arg_119_0._imgOpposition.material:SetFloat("_ColorInverseFactor", arg_119_1)
end

function var_0_0._oppositionFinished(arg_120_0)
	if arg_120_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_120_0._bgOppositionId)

		arg_120_0._bgOppositionId = nil
	end
end

function var_0_0._resetBgEffRgbSplit(arg_121_0)
	if arg_121_0._rbgSplitGo then
		gohelper.destroy(arg_121_0._rbgSplitGo)

		arg_121_0._rbgSplitGo = nil
	end

	gohelper.setLayer(arg_121_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._actBgEffRgbSplit(arg_122_0)
	if arg_122_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		arg_122_0:_showTransRgbSplit()
	elseif arg_122_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.Once then
		arg_122_0:_showOnceRgbSplit()
	elseif arg_122_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopWeak then
		arg_122_0:_showLoopWeakRgbSplit()
	elseif arg_122_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopStrong then
		arg_122_0:_showLoopStrongRgbSplit()
	end
end

function var_0_0._showTransRgbSplit(arg_123_0)
	if arg_123_0._rbgSplitGo then
		gohelper.destroy(arg_123_0._rbgSplitGo)

		arg_123_0._rbgSplitGo = nil
	end

	arg_123_0._transRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_changebg_doublerole")

	local var_123_0 = {}

	table.insert(var_123_0, arg_123_0._transRgbSplitPrefPath)
	arg_123_0:loadRes(var_123_0, arg_123_0._onTransRgbSplitResLoaded, arg_123_0)
end

function var_0_0._onTransRgbSplitResLoaded(arg_124_0)
	if arg_124_0._transRgbSplitPrefPath then
		local var_124_0 = arg_124_0._loader:getAssetItem(arg_124_0._transRgbSplitPrefPath)
		local var_124_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_124_0._rbgSplitGo = gohelper.clone(var_124_0:GetResource(), var_124_1)

		arg_124_0:_setTransRgbSplit()
	end
end

function var_0_0._setTransRgbSplit(arg_125_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_125_0._rbgSplitGo)

	arg_125_0._imgOld = gohelper.findChildImage(arg_125_0._rbgSplitGo, "image_old")
	arg_125_0._imgNew = gohelper.findChildImage(arg_125_0._rbgSplitGo, "image_new")
	arg_125_0._goAnim = gohelper.findChild(arg_125_0._rbgSplitGo, "anim")

	gohelper.setActive(arg_125_0._imgOld.gameObject, true)
	gohelper.setActive(arg_125_0._imgNew.gameObject, true)
	gohelper.setActive(arg_125_0._goAnim, true)
	gohelper.setLayer(arg_125_0._gobliteff, UnityLayer.UISecond, true)
	arg_125_0._imgOld.material:SetTexture("_MainTex", arg_125_0._lastCaptureTexture)
	arg_125_0._imgNew.material:SetTexture("_MainTex", arg_125_0._blitEffSecond.capturedTexture)
	TaskDispatcher.runDelay(arg_125_0._resetBgEffRgbSplit, arg_125_0, 1.2)
end

function var_0_0._showOnceRgbSplit(arg_126_0)
	if arg_126_0._rbgSplitGo then
		gohelper.destroy(arg_126_0._rbgSplitGo)

		arg_126_0._rbgSplitGo = nil
	end

	arg_126_0._onceRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_once")

	local var_126_0 = {}

	table.insert(var_126_0, arg_126_0._onceRgbSplitPrefPath)
	arg_126_0:loadRes(var_126_0, arg_126_0._onOnceRgbSplitResLoaded, arg_126_0)
end

function var_0_0._onOnceRgbSplitResLoaded(arg_127_0)
	if arg_127_0._onceRgbSplitPrefPath then
		local var_127_0 = arg_127_0._loader:getAssetItem(arg_127_0._onceRgbSplitPrefPath)
		local var_127_1 = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		arg_127_0._rbgSplitGo = gohelper.clone(var_127_0:GetResource(), var_127_1)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(arg_127_0._rbgSplitGo)

		arg_127_0._img = arg_127_0._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(arg_127_0._img.gameObject, true)
		arg_127_0._img.material:SetTexture("_MainTex", arg_127_0._blitEff.capturedTexture)
		TaskDispatcher.runDelay(arg_127_0._resetBgEffRgbSplit, arg_127_0, 0.267)
	end
end

function var_0_0._showLoopWeakRgbSplit(arg_128_0)
	if arg_128_0._rbgSplitGo then
		gohelper.destroy(arg_128_0._rbgSplitGo)

		arg_128_0._rbgSplitGo = nil
	end

	arg_128_0._loopWeakRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop")

	local var_128_0 = {}

	table.insert(var_128_0, arg_128_0._loopWeakRgbSplitPrefPath)
	arg_128_0:loadRes(var_128_0, arg_128_0._onLoopWeakRgbSplitResLoaded, arg_128_0)
end

function var_0_0._onLoopWeakRgbSplitResLoaded(arg_129_0)
	if arg_129_0._loopWeakRgbSplitPrefPath then
		local var_129_0 = arg_129_0._loader:getAssetItem(arg_129_0._loopWeakRgbSplitPrefPath)
		local var_129_1 = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		arg_129_0._rbgSplitGo = gohelper.clone(var_129_0:GetResource(), var_129_1)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(arg_129_0._rbgSplitGo)

		arg_129_0._img = arg_129_0._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(arg_129_0._img.gameObject, true)
		arg_129_0._img.material:SetTexture("_MainTex", arg_129_0._blitEff.capturedTexture)
	end
end

function var_0_0._showLoopStrongRgbSplit(arg_130_0)
	if arg_130_0._rbgSplitGo then
		gohelper.destroy(arg_130_0._rbgSplitGo)

		arg_130_0._rbgSplitGo = nil
	end

	arg_130_0._loopStrongRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop_strong")

	local var_130_0 = {}

	table.insert(var_130_0, arg_130_0._loopStrongRgbSplitPrefPath)
	arg_130_0:loadRes(var_130_0, arg_130_0._onLoopStrongRgbSplitResLoaded, arg_130_0)
end

function var_0_0._onLoopStrongRgbSplitResLoaded(arg_131_0)
	if arg_131_0._loopStrongRgbSplitPrefPath then
		local var_131_0 = arg_131_0._loader:getAssetItem(arg_131_0._loopStrongRgbSplitPrefPath)
		local var_131_1 = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		arg_131_0._rbgSplitGo = gohelper.clone(var_131_0:GetResource(), var_131_1)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(arg_131_0._rbgSplitGo)

		arg_131_0._img = arg_131_0._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(arg_131_0._img.gameObject, true)
		arg_131_0._img.material:SetTexture("_MainTex", arg_131_0._blitEff.capturedTexture)
	end
end

function var_0_0.loadRes(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	if arg_132_0._loader then
		arg_132_0._loader:dispose()

		arg_132_0._loader = nil
	end

	if arg_132_1 and #arg_132_1 > 0 then
		arg_132_0._loader = MultiAbLoader.New()

		arg_132_0._loader:setPathList(arg_132_1)
		arg_132_0._loader:startLoad(arg_132_2, arg_132_3)
	elseif arg_132_2 then
		arg_132_2(arg_132_3)
	end
end

function var_0_0.onClose(arg_133_0)
	arg_133_0:_clearBg()

	if arg_133_0._bgFadeId then
		ZProj.TweenHelper.KillById(arg_133_0._bgFadeId)
	end

	gohelper.setActive(arg_133_0.viewGO, false)
	ViewMgr.instance:closeView(ViewName.StoryHeroView)
	arg_133_0:_removeEvents()
end

function var_0_0._clearBg(arg_134_0)
	if arg_134_0._blurId then
		ZProj.TweenHelper.KillById(arg_134_0._blurId)

		arg_134_0._blurId = nil
	end

	if arg_134_0._bgScaleId then
		ZProj.TweenHelper.KillById(arg_134_0._bgScaleId)

		arg_134_0._bgScaleId = nil
	end

	if arg_134_0._bgPosId then
		ZProj.TweenHelper.KillById(arg_134_0._bgPosId)

		arg_134_0._bgPosId = nil
	end

	if arg_134_0._bgRotateId then
		ZProj.TweenHelper.KillById(arg_134_0._bgRotateId)

		arg_134_0._bgRotateId = nil
	end

	if arg_134_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_134_0._bgGrayId)

		arg_134_0._bgGrayId = nil
	end

	if arg_134_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_134_0._bgSketchId)

		arg_134_0._bgSketchId = nil
	end

	if arg_134_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_134_0._bgFilterId)

		arg_134_0._bgFilterId = nil
	end

	if arg_134_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_134_0._bgOppositionId)

		arg_134_0._bgOppositionId = nil
	end

	TaskDispatcher.cancelTask(arg_134_0._resetBgEffRgbSplit, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._onTurnPageFinished, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._changeRightDark, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._enterChange, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._startShake, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._shakeStop, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._distortEnd, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._leftDarkTransFinished, arg_134_0)
	TaskDispatcher.cancelTask(arg_134_0._commonTransFinished, arg_134_0)
	arg_134_0:_onEagleEyeFinished()

	if arg_134_0._bgTrans then
		arg_134_0._bgTrans:destroy()

		arg_134_0._bgTrans = nil
	end

	if arg_134_0._simagebgimg then
		arg_134_0._simagebgimg:UnLoadImage()

		arg_134_0._simagebgimg = nil
	end

	if arg_134_0._simagebgimgtop then
		arg_134_0._simagebgimgtop:UnLoadImage()

		arg_134_0._simagebgimgtop = nil
	end

	if arg_134_0._simagebgold then
		arg_134_0._simagebgold:UnLoadImage()

		arg_134_0._simagebgold = nil
	end

	if arg_134_0._simagebgoldtop then
		arg_134_0._simagebgoldtop:UnLoadImage()

		arg_134_0._simagebgoldtop = nil
	end
end

function var_0_0._removeEvents(arg_135_0)
	arg_135_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_135_0._onUpdateUI, arg_135_0)
	arg_135_0:removeEventCb(StoryController.instance, StoryEvent.RefreshBackground, arg_135_0._colorFadeBgRefresh, arg_135_0)
	arg_135_0:removeEventCb(StoryController.instance, StoryEvent.ShowBackground, arg_135_0._showBg, arg_135_0)
end

function var_0_0.onDestroyView(arg_136_0)
	if arg_136_0._lastCaptureTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_136_0._lastCaptureTexture)

		arg_136_0._lastCaptureTexture = nil
	end

	arg_136_0:_clearBg()
	arg_136_0:_actBgEffFullGrayUpdate(0.5)

	if arg_136_0._borderFadeId then
		ZProj.TweenHelper.KillById(arg_136_0._borderFadeId)
	end

	if arg_136_0._loader then
		arg_136_0._loader:dispose()

		arg_136_0._loader = nil
	end

	if arg_136_0._matLoader then
		arg_136_0._matLoader:dispose()

		arg_136_0._matLoader = nil
	end
end

return var_0_0
