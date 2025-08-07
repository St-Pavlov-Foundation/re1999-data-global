module("modules.logic.main.view.MainHeroView", package.seeall)

local var_0_0 = class("MainHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_lightspinecontrol")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")

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

local var_0_1 = WeatherController.instance

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_4_0._onOpenFullViewFinish, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_4_0._onOpenFullView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_4_0._onCloseFullView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_4_0._reOpenWhileOpen, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(WeatherController.instance, WeatherEvent.PlayVoice, arg_4_0._onWeatherPlayVoice, arg_4_0)
	arg_4_0:addEventCb(WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, arg_4_0._onWeatherLoadPhotoFrameBg, arg_4_0)
	arg_4_0:addEventCb(WeatherController.instance, WeatherEvent.OnRoleBlend, arg_4_0._onWeatherOnRoleBlend, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.OnReceiveAddFaithEvent, arg_4_0._onSuccessTouchHead, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.OnClickSwitchRole, arg_4_0._onClickSwitchRole, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.OnSceneClose, arg_4_0._onSceneClose, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, arg_4_0._setViewVisible, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.ChangeMainHeroSkin, arg_4_0._changeMainHeroSkin, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.OnShowMainThumbnailView, arg_4_0._onShowMainThumbnailView, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.SetMainViewRootVisible, arg_4_0._setViewRootVisible, arg_4_0)
	arg_4_0:addEventCb(MainController.instance, MainEvent.ForceStopVoice, arg_4_0._forceStopVoice, arg_4_0)
	arg_4_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_4_0._onStartSwitchScene, arg_4_0, LuaEventSystem.High)
	arg_4_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, arg_4_0._onSwitchSceneFinish, arg_4_0)
	arg_4_0:addEventCb(StoryController.instance, StoryEvent.Start, arg_4_0._onStart, arg_4_0)
	arg_4_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_4_0._onFinish, arg_4_0)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
	arg_4_0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_4_0._onDelayCloseLoading, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onLoadingCloseView, arg_4_0, LuaEventSystem.High)
	arg_4_0:addEventCb(LoginController.instance, LoginEvent.OnBeginLogout, arg_4_0._onBeginLogout, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshMainHeroSkin, arg_4_0._onRefreshMainHeroSkin, arg_4_0)
end

function var_0_0._onScreenResize(arg_5_0)
	arg_5_0:_repeatSetSpineScale()
end

function var_0_0._onStart(arg_6_0, arg_6_1)
	if arg_6_0._lightSpine then
		arg_6_0._isSpineCleared = true

		arg_6_0:_onStopVoice()
		arg_6_0._lightSpine:clear()

		arg_6_0._spineGo = nil
		arg_6_0._spineTransform = nil
		arg_6_0._spineMaterial = nil

		WeatherController.instance:clearMat()
	end
end

function var_0_0._onFinish(arg_7_0, arg_7_1)
	if not arg_7_0._isSpineCleared then
		return
	end

	arg_7_0._isSpineCleared = false
	arg_7_0._storyFinish = true
	arg_7_0._curHeroId, arg_7_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_7_0._curHeroId and arg_7_0._curSkinId then
		arg_7_0:_updateHero(arg_7_0._curHeroId, arg_7_0._curSkinId)
	end
end

function var_0_0._onBeginLogout(arg_8_0)
	arg_8_0:_clearEvents()
end

function var_0_0._onLoadingCloseView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.LoadingView then
		if arg_9_0._canvasGroup then
			arg_9_0._canvasGroup.alpha = 1
			arg_9_0._canvasGroup = nil

			arg_9_0._animator:Play("mainview_in", 0, 0)
		end

		arg_9_0:_checkPlayGreetingVoices()
	end
end

function var_0_0._onDelayCloseLoading(arg_10_0)
	local var_10_0 = gohelper.onceAddComponent(arg_10_0.viewGO, typeof(UnityEngine.CanvasGroup))

	var_10_0.alpha = 0
	arg_10_0._canvasGroup = var_10_0
end

function var_0_0._onShowMainThumbnailView(arg_11_0)
	gohelper.onceAddComponent(arg_11_0.viewGO, typeof(UnityEngine.CanvasGroup)).alpha = 0
end

function var_0_0._changeMainHeroSkin(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and not ViewMgr.instance:isOpen(ViewName.GMToolView) then
		return
	end

	arg_12_0._changeShowInScene = arg_12_2

	if arg_12_0._lightSpine then
		arg_12_0:_onStopVoice()
	end

	arg_12_0:_updateHero(arg_12_1.characterId, arg_12_1.id, arg_12_3)
end

function var_0_0._onRefreshMainHeroSkin(arg_13_0)
	arg_13_0._curHeroId, arg_13_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_13_0._curHeroId and arg_13_0._curSkinId then
		arg_13_0:_updateHero(arg_13_0._curHeroId, arg_13_0._curSkinId)
	end
end

function var_0_0._onSpineLoaded(arg_14_0)
	if arg_14_0._storyFinish then
		arg_14_0._storyFinish = nil

		arg_14_0:_setShowInScene(true)
	end

	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	arg_14_0:_setShowInScene(arg_14_0._changeShowInScene)
end

function var_0_0._setViewVisible(arg_15_0, arg_15_1)
	arg_15_0._mainViewVisible = arg_15_1
	arg_15_0._changeTime = Time.realtimeSinceStartup
end

function var_0_0._onSceneClose(arg_16_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_16_0._onCloseFullView, arg_16_0)
end

function var_0_0._onClickSwitchRole(arg_17_0)
	arg_17_0:checkSwitchShowInScene()
end

function var_0_0.checkSwitchShowInScene(arg_18_0)
	if not arg_18_0._showInScene then
		arg_18_0:_setShowInScene(true)

		if arg_18_0._lightSpine then
			arg_18_0._lightSpine:fadeIn()
		end
	end
end

function var_0_0._onWeatherPlayVoice(arg_19_0, arg_19_1)
	if not PlayerModel.instance:getMainThumbnail() then
		return
	end

	if arg_19_0:isPlayingVoice() or not arg_19_0:isShowInScene() then
		return
	end

	arg_19_1[2] = true

	arg_19_0:playVoice(arg_19_1[1])
end

function var_0_0._onWeatherLoadPhotoFrameBg(arg_20_0)
	arg_20_0:loadPhotoFrameBg()
end

function var_0_0._onWeatherOnRoleBlend(arg_21_0, arg_21_1)
	arg_21_0:onRoleBlend(arg_21_1[1], arg_21_1[2])
	arg_21_0:_updateMainColor()
end

function var_0_0._setViewRootVisible(arg_22_0, arg_22_1)
	if not arg_22_1 and arg_22_0._lightSpine then
		arg_22_0:_onStopVoice()
	end
end

function var_0_0._updateMainColor(arg_23_0)
	if not arg_23_0._lightSpine then
		return
	end

	if arg_23_0._showInScene then
		local var_23_0 = WeatherController.instance:getMainColor()

		arg_23_0._lightSpine:setMainColor(var_23_0)
		arg_23_0._lightSpine:setLumFactor(WeatherEnum.HeroInSceneLumFactor)
	else
		local var_23_1 = WeatherController.instance:getCurLightMode()

		if not var_23_1 then
			return
		end

		local var_23_2 = WeatherEnum.HeroInFrameColor[var_23_1]

		arg_23_0._lightSpine:setMainColor(var_23_2)
		arg_23_0._lightSpine:setLumFactor(WeatherEnum.HeroInFrameLumFactor[var_23_1])
	end
end

function var_0_0._onStartSwitchScene(arg_24_0)
	if not arg_24_0._showInScene then
		arg_24_0:_setShowInScene(true)
	end
end

function var_0_0._onSwitchSceneFinish(arg_25_0)
	arg_25_0:_initFrame()
end

function var_0_0._initFrame(arg_26_0)
	arg_26_0._frameBg = nil
	arg_26_0._frameSpineNode = nil
	arg_26_0._frameBg = var_0_1:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not arg_26_0._frameBg then
		logError("_initFrame no frameBg")
	end

	local var_26_0 = var_0_1:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if var_26_0 then
		arg_26_0._frameSpineNode = var_26_0.transform
	else
		logError("_initFrame no spineMountPoint")
	end

	gohelper.setActive(arg_26_0._frameBg, false)

	arg_26_0._frameSpineNodeX = 3.11
	arg_26_0._frameSpineNodeY = 0.51
	arg_26_0._frameSpineNodeZ = 3.09
	arg_26_0._frameSpineNodeScale = 0.39

	local var_26_1 = arg_26_0._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	arg_26_0._frameBgMaterial = UnityEngine.Material.Instantiate(var_26_1.sharedMaterial)
	var_26_1.material = arg_26_0._frameBgMaterial
end

function var_0_0._editableInitView(arg_27_0)
	arg_27_0:_clearTrackMainHeroInteractionData()
	arg_27_0:_enableKeyword()

	arg_27_0._skinInteraction = nil
	arg_27_0._curHeroId, arg_27_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_27_0._curHeroId and arg_27_0._curSkinId then
		arg_27_0:_updateHero(arg_27_0._curHeroId, arg_27_0._curSkinId)
	end

	arg_27_0._animator = arg_27_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_27_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_27_0._click = SLFramework.UGUI.UIClickListener.Get(arg_27_0._golightspinecontrol)

	arg_27_0._click:AddClickDownListener(arg_27_0._clickDown, arg_27_0)

	arg_27_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_27_0._golightspinecontrol)

	arg_27_0._drag:AddDragBeginListener(arg_27_0._onDragBegin, arg_27_0)
	arg_27_0._drag:AddDragListener(arg_27_0._onDrag, arg_27_0)
	arg_27_0._drag:AddDragEndListener(arg_27_0._onDragEnd, arg_27_0)
	arg_27_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_27_0._onTouch, arg_27_0)

	arg_27_0._showInScene = true

	arg_27_0:_initFrame()

	arg_27_0._TintColorId = UnityEngine.Shader.PropertyToID("_TintColor")

	arg_27_0:_repeatSetSpineScale()
end

function var_0_0._setSpineScale(arg_28_0)
	var_0_0.setSpineScale(arg_28_0._gospinescale)
end

function var_0_0._repeatSetSpineScale(arg_29_0)
	arg_29_0:_setSpineScale()
	TaskDispatcher.cancelTask(arg_29_0._setSpineScale, arg_29_0)
	TaskDispatcher.runRepeat(arg_29_0._setSpineScale, arg_29_0, 0.1, 5)
end

function var_0_0.setSpineScale(arg_30_0)
	local var_30_0 = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(arg_30_0.transform, var_30_0, var_30_0, var_30_0)
end

function var_0_0.showInScene(arg_31_0)
	if not arg_31_0._spineMaterial then
		return
	end

	arg_31_0._lightSpine:setEffectFrameVisible(true)
	arg_31_0:_setStencil(true)

	arg_31_0._spineTransform.parent = arg_31_0._golightspine.transform

	transformhelper.setLocalScale(arg_31_0._spineTransform, 1, 1, 1)
	transformhelper.setLocalPos(arg_31_0._spineTransform, 0, 0, 0)
	transformhelper.setLocalRotation(arg_31_0._spineGo.transform, 0, 0, 0)
	gohelper.setLayer(arg_31_0._spineGo, UnityLayer.Unit, true)
	gohelper.setActive(arg_31_0._frameBg, false)
	var_0_1:setRoleMaskEnabled(true)
	var_0_1:setStateByString("Photo_album", "no")
	arg_31_0:_updateMainColor()
end

function var_0_0.showInFrame(arg_32_0)
	if not arg_32_0._spineMaterial then
		return
	end

	arg_32_0._lightSpine:setEffectFrameVisible(false)
	arg_32_0:_setStencil(false)
	transformhelper.setLocalScale(arg_32_0._frameSpineNode, 1, 1, 1)
	transformhelper.setLocalPos(arg_32_0._frameSpineNode, 0, 0, 0)

	arg_32_0._spineTransform.parent = arg_32_0._frameSpineNode

	local var_32_0 = transformhelper.getLocalScale(arg_32_0._spineTransform)

	transformhelper.setLocalScale(arg_32_0._spineTransform, var_32_0, var_32_0, var_32_0)
	transformhelper.setLocalRotation(arg_32_0._spineTransform, 0, 0, 0)

	local var_32_1 = arg_32_0._frameSpineNodeX
	local var_32_2 = arg_32_0._frameSpineNodeY
	local var_32_3 = arg_32_0._frameSpineNodeScale

	if not string.nilorempty(arg_32_0._heroSkinConfig.mainViewFrameOffset) then
		local var_32_4 = SkinConfig.instance:getSkinOffset(arg_32_0._heroSkinConfig.mainViewFrameOffset)

		var_32_1 = var_32_4[1]
		var_32_2 = var_32_4[2]
		var_32_3 = var_32_4[3]

		local var_32_5 = MainSceneSwitchModel.instance:getCurSceneId()
		local var_32_6 = var_32_5 and lua_scene_settings.configDict[var_32_5]

		if var_32_6 then
			var_32_1 = var_32_1 + var_32_6.spineOffset[1]
			var_32_2 = var_32_2 + var_32_6.spineOffset[2]
		end
	end

	transformhelper.setLocalScale(arg_32_0._frameSpineNode, var_32_3, var_32_3, var_32_3)
	transformhelper.setLocalPos(arg_32_0._frameSpineNode, var_32_1, var_32_2, arg_32_0._frameSpineNodeZ)
	gohelper.setLayer(arg_32_0._spineGo, UnityLayer.Scene, true)

	if not arg_32_0:loadPhotoFrameBg() then
		gohelper.setActive(arg_32_0._frameBg, true)
	end

	var_0_1:setRoleMaskEnabled(false)
	var_0_1:setStateByString("Photo_album", "yes")
	arg_32_0:_updateMainColor()
end

function var_0_0.loadPhotoFrameBg(arg_33_0)
	if arg_33_0._showInScene then
		return false
	end

	if arg_33_0._curLightMode then
		return false
	end

	local var_33_0 = var_0_1:getCurLightMode()

	if not var_33_0 or arg_33_0._curLightMode == var_33_0 then
		return false
	end

	arg_33_0._curLightMode = var_33_0

	if arg_33_0._photoFrameBgLoader then
		arg_33_0._photoFrameBgLoader:dispose()

		arg_33_0._photoFrameBgLoader = nil
	end

	local var_33_1 = MultiAbLoader.New()

	arg_33_0._photoFrameBgLoader = var_33_1

	local var_33_2 = MainSceneSwitchModel.instance:getCurSceneId()
	local var_33_3 = WeatherFrameComp.getFramePath(var_33_2)

	var_33_1:addPath(var_33_3)
	var_33_1:startLoad(function()
		local var_34_0 = var_33_1:getAssetItem(var_33_3):GetResource(var_33_3)

		arg_33_0._frameBgMaterial:SetTexture("_MainTex", var_34_0)
		gohelper.setActive(arg_33_0._frameBg, true)
	end)

	return true
end

function var_0_0.onRoleBlend(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0._targetFrameTintColor then
		local var_35_0 = var_0_1:getCurLightMode()
		local var_35_1 = var_0_1:getPrevLightMode() or var_35_0

		if not var_35_0 then
			return
		end

		local var_35_2 = MainSceneSwitchModel.instance:getCurSceneId()

		arg_35_0._targetFrameTintColor = WeatherFrameComp.getFrameColor(var_35_2, var_35_0)
		arg_35_0._srcFrameTintColor = WeatherFrameComp.getFrameColor(var_35_2, var_35_1)

		arg_35_0._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	arg_35_0._frameBgMaterial:SetColor(arg_35_0._TintColorId, var_0_1:lerpColorRGBA(arg_35_0._srcFrameTintColor, arg_35_0._targetFrameTintColor, arg_35_1))

	if arg_35_2 then
		arg_35_0._targetFrameTintColor = nil

		if var_0_1:getCurLightMode() == 1 then
			arg_35_0._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function var_0_0._updateHero(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0._anchorMinPos = nil
	arg_36_0._anchorMaxPos = nil
	arg_36_0._heroId = arg_36_1
	arg_36_0._skinId = arg_36_2

	local var_36_0 = HeroConfig.instance:getHeroCO(arg_36_0._heroId)
	local var_36_1 = SkinConfig.instance:getSkinCo(arg_36_0._skinId or var_36_0 and var_36_0.skin)

	if not var_36_1 then
		arg_36_0:_updateTrackInfoSkinId(nil)

		return
	end

	arg_36_0._heroPhotoFrameBg = var_36_0.photoFrameBg
	arg_36_0._heroSkinConfig = var_36_1
	arg_36_0._heroSkinTriggerArea = {}

	arg_36_0:_updateTrackInfoSkinId(var_36_1.id)

	if not arg_36_3 then
		local var_36_2 = SkinConfig.instance:getSkinOffset(var_36_1.mainViewOffset)
		local var_36_3 = arg_36_0._golightspine.transform

		recthelper.setAnchor(var_36_3, tonumber(var_36_2[1]), tonumber(var_36_2[2]))

		local var_36_4 = tonumber(var_36_2[3])

		var_36_3.localScale = Vector3.one * var_36_4
	end

	if not arg_36_0._lightSpine then
		arg_36_0._lightSpine = LightModelAgent.Create(arg_36_0._golightspine, true)
	end

	if not string.nilorempty(var_36_1.defaultStencilValue) then
		arg_36_0._defaultStencilValue = string.splitToNumber(var_36_1.defaultStencilValue, "#")
	else
		arg_36_0._defaultStencilValue = nil
	end

	if not string.nilorempty(var_36_1.frameStencilValue) then
		arg_36_0._frameStencilValue = string.splitToNumber(var_36_1.frameStencilValue, "#")
	else
		arg_36_0._frameStencilValue = nil
	end

	arg_36_0._lightSpine:setResPath(var_36_1, arg_36_0._onLightSpineLoaded, arg_36_0)
	arg_36_0._lightSpine:setInMainView()
end

function var_0_0._setStencil(arg_37_0, arg_37_1)
	if arg_37_1 then
		if arg_37_0._defaultStencilValue then
			arg_37_0._lightSpine:setStencilValues(arg_37_0._defaultStencilValue[1], arg_37_0._defaultStencilValue[2], arg_37_0._defaultStencilValue[3])
		else
			arg_37_0._lightSpine:setStencilRef(0)
		end
	elseif arg_37_0._frameStencilValue then
		arg_37_0._lightSpine:setStencilValues(arg_37_0._frameStencilValue[1], arg_37_0._frameStencilValue[2], arg_37_0._frameStencilValue[3])
	else
		arg_37_0._lightSpine:setStencilRef(1)
	end
end

function var_0_0._checkPlayGreetingVoices(arg_38_0)
	if LimitedRoleController.instance:isPlaying() then
		return
	end

	if arg_38_0._needPlayGreeting and not ViewMgr.instance:isOpen(ViewName.LoadingView) then
		arg_38_0:_playGreetingVoices()
	end
end

function var_0_0._playGreetingVoices(arg_39_0)
	local var_39_0 = HeroModel.instance:getVoiceConfig(arg_39_0._heroId, CharacterEnum.VoiceType.Greeting, nil, arg_39_0._skinId)

	if var_39_0 and #var_39_0 > 0 then
		arg_39_0:_onWeatherPlayVoice({
			var_39_0[1]
		})
	end
end

function var_0_0._onLightSpineLoaded(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0._delayInitLightSpine, arg_40_0)
	TaskDispatcher.runDelay(arg_40_0._delayInitLightSpine, arg_40_0, 0.1)
end

function var_0_0._delayInitLightSpine(arg_41_0)
	arg_41_0._spineGo = arg_41_0._lightSpine:getSpineGo()

	if gohelper.isNil(arg_41_0._spineGo) then
		return
	end

	arg_41_0._spineTransform = arg_41_0._spineGo.transform
	arg_41_0._spineMaterial = arg_41_0._lightSpine:getRenderer().sharedMaterial

	arg_41_0:_setStencil(true)
	WeatherController.instance:setLightModel(arg_41_0._lightSpine)

	if not arg_41_0._firstLoadSpine then
		arg_41_0._firstLoadSpine = true

		if PlayerModel.instance:getMainThumbnail() then
			-- block empty
		end

		local var_41_0 = ViewMgr.instance:hasOpenFullView()
		local var_41_1 = not var_41_0

		if MainController.instance.firstEnterMainScene then
			MainController.instance.firstEnterMainScene = false
			var_41_1 = false

			if not var_41_0 then
				arg_41_0._needPlayGreeting = true

				arg_41_0:_checkPlayGreetingVoices()
			end
		end

		var_0_1:initRoleGo(arg_41_0._spineGo, arg_41_0._heroId, arg_41_0._spineMaterial, var_41_1, arg_41_0._skinId)
	else
		local var_41_2 = {
			heroPlayWeatherVoice = true,
			roleGo = arg_41_0._lightSpine:getSpineGo(),
			heroId = arg_41_0._heroId,
			sharedMaterial = arg_41_0._spineMaterial,
			skinId = arg_41_0._skinId
		}

		var_0_1:changeRoleGo(var_41_2)
	end

	arg_41_0.viewContainer:getNoInteractiveComp():init()
	arg_41_0:_onSpineLoaded()
end

function var_0_0.isPlayingVoice(arg_42_0)
	if not arg_42_0._lightSpine then
		return false
	end

	if arg_42_0._skinInteraction and arg_42_0._skinInteraction:isPlayingVoice() then
		return true
	end

	return arg_42_0._lightSpine:isPlayingVoice()
end

function var_0_0.getLightSpine(arg_43_0)
	return arg_43_0._lightSpine
end

function var_0_0.isShowInScene(arg_44_0)
	return arg_44_0._showInScene
end

function var_0_0._checkSpecialTouch(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = "triggerArea" .. arg_45_1.param
	local var_45_1 = arg_45_0._heroSkinTriggerArea[var_45_0]

	if not var_45_1 then
		var_45_1 = {}
		arg_45_0._heroSkinTriggerArea[var_45_0] = var_45_1

		local var_45_2 = arg_45_0._heroSkinConfig[var_45_0]
		local var_45_3 = string.split(var_45_2, "_")

		for iter_45_0, iter_45_1 in ipairs(var_45_3) do
			local var_45_4 = string.split(iter_45_1, "|")

			if #var_45_4 == 2 then
				local var_45_5 = string.split(var_45_4[1], "#")
				local var_45_6 = string.split(var_45_4[2], "#")
				local var_45_7 = tonumber(var_45_5[1])
				local var_45_8 = tonumber(var_45_5[2])
				local var_45_9 = tonumber(var_45_6[1])
				local var_45_10 = tonumber(var_45_6[2])
				local var_45_11 = {
					var_45_7,
					var_45_8,
					var_45_9,
					var_45_10
				}

				table.insert(var_45_1, var_45_11)
			end
		end
	end

	for iter_45_2, iter_45_3 in ipairs(var_45_1) do
		local var_45_12 = tonumber(iter_45_3[1])
		local var_45_13 = tonumber(iter_45_3[2])
		local var_45_14 = tonumber(iter_45_3[3])
		local var_45_15 = tonumber(iter_45_3[4])

		if arg_45_2 and var_45_12 <= arg_45_2.x and var_45_14 >= arg_45_2.x and var_45_13 >= arg_45_2.y and var_45_15 <= arg_45_2.y then
			arg_45_0:_updateTrackInfoAreaId(tonumber(arg_45_1.param))

			return true
		end
	end

	return false
end

function var_0_0._onTouch(arg_46_0)
	if not LimitedRoleController.instance:isPlaying() and arg_46_0._mainViewVisible == false and Time.realtimeSinceStartup - arg_46_0._changeTime > 0.5 then
		TaskDispatcher.runDelay(arg_46_0._delayCheckShowMain, arg_46_0, 0.01)
	end
end

function var_0_0._delayCheckShowMain(arg_47_0)
	if not LimitedRoleController.instance:isPlaying() and arg_47_0._mainViewVisible == false and Time.realtimeSinceStartup - arg_47_0._changeTime > 0.5 then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_display)
	end
end

function var_0_0._onDragBegin(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_0._skinInteraction and arg_48_0._skinInteraction:needRespond() then
		arg_48_0._dragSpecialRespond = arg_48_0:_getDragSpecialRespond(CharacterEnum.VoiceType.MainViewDragSpecialRespond)

		if not arg_48_0._dragSpecialRespond then
			return
		end

		arg_48_0:_checkSpecialTouch(arg_48_0._dragSpecialRespond)

		local var_48_0 = "triggerArea" .. arg_48_0._dragSpecialRespond.param

		arg_48_0._dragArea = arg_48_0._heroSkinTriggerArea[var_48_0][1]

		local var_48_1 = arg_48_0._dragSpecialRespond.param2
		local var_48_2 = string.split(var_48_1, "#")

		arg_48_0._dragParamName = var_48_2[1]
		arg_48_0._dragParamMinValue = tonumber(var_48_2[2])
		arg_48_0._dragParamMaxValue = tonumber(var_48_2[3])
		arg_48_0._dragParamLength = arg_48_0._dragParamMaxValue - arg_48_0._dragParamMinValue
		arg_48_0._dragParamIndex = arg_48_0._lightSpine:addParameter(arg_48_0._dragParamName, 0, arg_48_0._dragParamMinValue)

		arg_48_0._skinInteraction:beginDrag()
		AudioMgr.instance:trigger(AudioEnum.UI.hero3100_mainsfx_mic_drag)
	end
end

function var_0_0._onDrag(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_0._dragSpecialRespond then
		return
	end

	local var_49_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_49_0._golightspinecontrol.transform)
	local var_49_1 = arg_49_0._dragArea[1]
	local var_49_2 = arg_49_0._dragArea[2]
	local var_49_3 = arg_49_0._dragArea[3]
	local var_49_4 = arg_49_0._dragArea[4]

	if var_49_0 and var_49_1 <= var_49_0.x and var_49_3 >= var_49_0.x and var_49_2 >= var_49_0.y and var_49_4 <= var_49_0.y then
		local var_49_5 = (var_49_0.x - var_49_1) / (var_49_3 - var_49_1)
		local var_49_6 = arg_49_0._dragParamMinValue + var_49_5 * arg_49_0._dragParamLength

		arg_49_0._lightSpine:updateParameter(arg_49_0._dragParamIndex, var_49_6)

		if var_49_6 >= arg_49_0._dragParamMaxValue - 5 then
			local var_49_7 = arg_49_0._dragSpecialRespond

			arg_49_0:_onDragEnd(arg_49_1, arg_49_2)
			arg_49_0:_doClickPlayVoice(var_49_7)
		end
	end
end

function var_0_0._onDragEnd(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_0._dragParamName then
		arg_50_0._lightSpine:removeParameter(arg_50_0._dragParamName)

		arg_50_0._dragParamName = nil
	end

	if arg_50_0._dragSpecialRespond and arg_50_0._skinInteraction then
		arg_50_0._skinInteraction:endDrag()
	end

	arg_50_0._dragSpecialRespond = nil
end

function var_0_0._clickDown(arg_51_0)
	if arg_51_0._mainViewVisible == false then
		return
	end

	MainController.instance:dispatchEvent(MainEvent.ClickDown)

	if not arg_51_0._showInScene then
		return
	end

	if gohelper.isNil(arg_51_0._spineGo) then
		return
	end

	local var_51_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_51_0._golightspinecontrol.transform)

	arg_51_0:_initSkinInteraction()
	arg_51_0._skinInteraction:onClick(var_51_0)
end

function var_0_0._initSkinInteraction(arg_52_0)
	local var_52_0 = arg_52_0._skinInteraction

	if var_52_0 and var_52_0:getSkinId() ~= arg_52_0._skinId then
		var_52_0:onDestroy()

		arg_52_0._skinInteraction = nil
	end

	if not arg_52_0._skinInteraction then
		arg_52_0._skinInteraction = arg_52_0:getSkinInteraction(arg_52_0._skinId)

		arg_52_0._skinInteraction:init(arg_52_0, arg_52_0._skinId)
	end
end

function var_0_0.getSkinInteraction(arg_53_0, arg_53_1)
	if arg_53_1 == 303301 or arg_53_1 == 303302 then
		return TTTSkinInteraction.New()
	end

	return CommonSkinInteraction.New()
end

function var_0_0._clickDefault(arg_54_0, arg_54_1)
	arg_54_0:_updateTrackInfoAreaId(nil)

	local var_54_0 = arg_54_0:_getSpecialInteraction()

	if var_54_0 and arg_54_0:_checkPosInBound(arg_54_1) and arg_54_0._skinInteraction:canPlay(var_54_0) then
		local var_54_1 = string.splitToNumber(var_54_0.param, "#")

		if math.random() * 100 < var_54_1[1] then
			CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Click)
			arg_54_0:_doClickPlayVoice(var_54_0)

			return
		end
	end

	if arg_54_0._skinInteraction:needRespond() then
		local var_54_2 = arg_54_0:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialRespond, arg_54_1)

		if var_54_2 and arg_54_0._skinInteraction:canPlay(var_54_2) then
			arg_54_0:_doClickPlayVoice(var_54_2)
		end

		return
	end

	local var_54_3 = arg_54_0:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialTouch, arg_54_1)

	if var_54_3 and math.random() > 0.5 and arg_54_0._skinInteraction:canPlay(var_54_3) then
		local var_54_4 = var_0_0.getRandomMultiVoice(var_54_3, arg_54_0._heroId, arg_54_0._skinId)

		arg_54_0:_doClickPlayVoice(var_54_4, true)

		return
	end

	local var_54_5 = arg_54_0:_getNormalTouch(arg_54_1)

	if var_54_5 and arg_54_0._skinInteraction:canPlay(var_54_5) then
		arg_54_0:_doClickPlayVoice(var_54_5, true)
	end
end

function var_0_0._getSpecialInteraction(arg_55_0, arg_55_1)
	local var_55_0 = HeroModel.instance:getVoiceConfig(arg_55_0._heroId, arg_55_1 or CharacterEnum.VoiceType.MainViewSpecialInteraction, function(arg_56_0)
		return arg_55_0._clickPlayConfig ~= arg_56_0
	end, arg_55_0._skinId)

	if var_55_0 and #var_55_0 > 0 then
		return var_55_0[1]
	end
end

function var_0_0._getDragSpecialRespond(arg_57_0, arg_57_1)
	local var_57_0 = HeroModel.instance:getVoiceConfig(arg_57_0._heroId, arg_57_1 or CharacterEnum.VoiceType.MainViewSpecialInteraction, function(arg_58_0)
		return arg_57_0._clickPlayConfig ~= arg_58_0 and not string.nilorempty(arg_58_0.param2)
	end, arg_57_0._skinId)

	if var_57_0 and #var_57_0 > 0 then
		return var_57_0[1]
	end
end

function var_0_0._getSpecialTouch(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = HeroModel.instance:getVoiceConfig(arg_59_0._heroId, arg_59_1, function(arg_60_0)
		return arg_59_0._clickPlayConfig ~= arg_60_0 and arg_59_0:_checkSpecialTouch(arg_60_0, arg_59_2)
	end, arg_59_0._skinId)

	if var_59_0 and #var_59_0 > 0 then
		return var_59_0[1]
	end
end

function var_0_0._getNormalTouch(arg_61_0, arg_61_1)
	if arg_61_0:_checkPosInBound(arg_61_1) then
		local var_61_0 = HeroModel.instance:getVoiceConfig(arg_61_0._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function(arg_62_0)
			return arg_61_0._clickPlayConfig ~= arg_62_0
		end, arg_61_0._skinId)
		local var_61_1 = var_0_0.getHeightWeight(var_61_0)

		return var_0_0.getRandomMultiVoice(var_61_1, arg_61_0._heroId, arg_61_0._skinId)
	end
end

function var_0_0.getRandomMultiVoice(arg_63_0, arg_63_1, arg_63_2)
	if not arg_63_0 then
		return
	end

	if math.random() <= 0.5 then
		local var_63_0 = CharacterDataConfig.instance:getCharacterTypeVoicesCO(arg_63_1, CharacterEnum.VoiceType.MultiVoice, arg_63_2)

		for iter_63_0, iter_63_1 in ipairs(var_63_0) do
			if tonumber(iter_63_1.param) == arg_63_0.audio then
				return iter_63_1
			end
		end
	end

	return arg_63_0
end

function var_0_0._checkPosInBound(arg_64_0, arg_64_1)
	if not arg_64_0._anchorMinPos or not arg_64_0._anchorMaxPos then
		local var_64_0, var_64_1 = arg_64_0._lightSpine:getBoundsMinMaxPos()

		arg_64_0._anchorMinPos = recthelper.worldPosToAnchorPos(Vector3(var_64_0.x, var_64_1.y, var_64_0.z), arg_64_0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
		arg_64_0._anchorMaxPos = recthelper.worldPosToAnchorPos(Vector3(var_64_1.x, var_64_0.y, var_64_1.z), arg_64_0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
	end

	local var_64_2 = arg_64_0._anchorMinPos
	local var_64_3 = arg_64_0._anchorMaxPos

	if arg_64_1.x >= var_64_2.x and arg_64_1.x <= var_64_3.x and arg_64_1.y <= var_64_2.y and arg_64_1.y >= var_64_3.y then
		return true
	end
end

function var_0_0.addFaith(arg_65_0)
	if HeroModel.instance:getTouchHeadNumber() <= 0 then
		return
	end

	HeroRpc.instance:sendTouchHeadRequest(arg_65_0._heroId)
end

function var_0_0._onSuccessTouchHead(arg_66_0, arg_66_1)
	if not arg_66_0._showFaithToast then
		return
	end

	arg_66_0._showFaithToast = false

	if arg_66_1 then
		GameFacade.showToast(ToastEnum.MainHeroAddSuccess)
	else
		GameFacade.showToast(ToastEnum.MainHeroAddFail)
	end
end

function var_0_0.getHeightWeight(arg_67_0)
	if arg_67_0 and #arg_67_0 > 0 then
		local var_67_0 = 0

		for iter_67_0, iter_67_1 in ipairs(arg_67_0) do
			var_67_0 = var_67_0 + iter_67_1.param
		end

		local var_67_1 = math.random()
		local var_67_2 = 0

		for iter_67_2, iter_67_3 in ipairs(arg_67_0) do
			var_67_2 = var_67_2 + iter_67_3.param

			if var_67_1 <= var_67_2 / var_67_0 then
				return iter_67_3
			end
		end
	end

	return nil
end

function var_0_0._doClickPlayVoice(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0._showFaithToast = arg_68_2

	arg_68_0:addFaith()
	arg_68_0:clickPlayVoice(arg_68_1)
end

function var_0_0.clickPlayVoice(arg_69_0, arg_69_1)
	arg_69_0._clickPlayConfig = arg_69_1

	arg_69_0:playVoice(arg_69_1)
end

function var_0_0._onStopVoice(arg_70_0)
	arg_70_0._lightSpine:stopVoice()

	if arg_70_0._skinInteraction then
		arg_70_0._skinInteraction:onStopVoice()
	end
end

function var_0_0.playVoice(arg_71_0, arg_71_1)
	if not arg_71_0._lightSpine then
		return
	end

	if arg_71_0._skinInteraction then
		arg_71_0._skinInteraction:beforePlayVoice(arg_71_1)
	end

	arg_71_0:_onStopVoice()

	if arg_71_0._skinInteraction then
		arg_71_0._skinInteraction:onPlayVoice(arg_71_1)
	end

	arg_71_0._lightSpine:playVoice(arg_71_1, function()
		if arg_71_0._skinInteraction then
			arg_71_0._skinInteraction:playVoiceFinish(arg_71_1)
		end

		arg_71_0._interactionStartTime = Time.time
		arg_71_0._specialIdleStartTime = Time.time
	end, arg_71_0._txtanacn, arg_71_0._txtanaen, arg_71_0._gocontentbg)

	if arg_71_0._skinInteraction then
		arg_71_0._skinInteraction:afterPlayVoice(arg_71_1)
	end

	arg_71_0:_trackMainHeroInteraction(arg_71_1 and arg_71_1.audio)
end

function var_0_0.onlyPlayVoice(arg_73_0, arg_73_1)
	arg_73_0:_onStopVoice()
	arg_73_0._lightSpine:playVoice(arg_73_1, function()
		arg_73_0._interactionStartTime = Time.time
		arg_73_0._specialIdleStartTime = Time.time
	end, arg_73_0._txtanacn, arg_73_0._txtanaen, arg_73_0._gocontentbg)
end

function var_0_0._enableKeyword(arg_75_0)
	UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = true
end

function var_0_0._disableKeyword(arg_76_0)
	UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = false
end

function var_0_0._onOpenFullView(arg_77_0, arg_77_1)
	if arg_77_1 == ViewName.CharacterSkinTipView then
		arg_77_0:_disableKeyword()
	end
end

function var_0_0._getSwitchViewName(arg_78_0)
	return ViewName.MainSwitchView
end

function var_0_0._onOpenFullViewFinish(arg_79_0, arg_79_1)
	if arg_79_1 ~= arg_79_0:_getSwitchViewName() then
		arg_79_0:_disableKeyword()
	end

	arg_79_0:_hideModelEffect()
	var_0_1:setStateByString("Photo_album", "no")
end

function var_0_0._checkLightSpineVisible(arg_80_0, arg_80_1)
	local var_80_0 = ViewMgr.instance:hasOpenFullView()

	TaskDispatcher.cancelTask(arg_80_0._hideLightSpineVisible, arg_80_0)

	if var_80_0 then
		if arg_80_0._golightspine.activeSelf then
			TaskDispatcher.runDelay(arg_80_0._hideLightSpineVisible, arg_80_0, arg_80_1 or 1)
		end
	else
		gohelper.setActive(arg_80_0._golightspine, true)
	end
end

function var_0_0._hideLightSpineVisible(arg_81_0)
	gohelper.setActive(arg_81_0._golightspine, false)
end

function var_0_0._isViewGOActive(arg_82_0)
	return arg_82_0.viewGO.activeSelf and arg_82_0.viewGO.activeInHierarchy
end

function var_0_0._hasOpenFullView(arg_83_0)
	for iter_83_0, iter_83_1 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		local var_83_0 = ViewMgr.instance:getSetting(iter_83_1)

		if var_83_0 and (var_83_0.viewType == ViewType.Full or var_83_0.bgBlur) then
			return true
		end
	end
end

function var_0_0._activationSettings(arg_84_0)
	arg_84_0:_enableKeyword()
end

function var_0_0._hideModelEffect(arg_85_0)
	TaskDispatcher.cancelTask(arg_85_0._showModelEffect, arg_85_0)

	if arg_85_0._lightSpine then
		arg_85_0._lightSpine:setEffectVisible(false)
	end
end

function var_0_0._showModelEffect(arg_86_0)
	if arg_86_0._lightSpine and arg_86_0._showInScene then
		arg_86_0._lightSpine:setEffectVisible(true)
	end
end

function var_0_0._delayShowModelEffect(arg_87_0)
	arg_87_0:_hideModelEffect()
	TaskDispatcher.runDelay(arg_87_0._showModelEffect, arg_87_0, 0.1)
end

function var_0_0._onCloseFullView(arg_88_0, arg_88_1)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		if not ViewMgr.instance:hasOpenFullView() then
			arg_88_0:_delayShowModelEffect()
		end

		return
	end

	if not arg_88_0:_isViewGOActive() then
		return
	end

	if MainSceneSwitchController.instance:isSwitching() then
		return
	end

	if not arg_88_0:_hasOpenFullView() then
		arg_88_0:_activationSettings()

		if arg_88_0._lightSpine then
			arg_88_0._lightSpine:processModelEffect()
		end

		arg_88_0:_delayShowModelEffect()

		local var_88_0 = arg_88_0._showInScene

		if var_88_0 then
			if math.random() < 0.1 then
				var_88_0 = not var_88_0
			end
		elseif math.random() < 0.7 then
			var_88_0 = not var_88_0
		end

		if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
			var_88_0 = true
		end

		if not var_88_0 then
			local var_88_1 = arg_88_0._cameraAnimator

			if var_88_1.runtimeAnimatorController and var_88_1.enabled then
				var_88_0 = true
			end
		end

		if GuideModel.instance:getDoingGuideId() and not GuideController.instance:isForbidGuides() then
			var_88_0 = true
		end

		if arg_88_0._skinInteraction then
			arg_88_0._skinInteraction:onCloseFullView()
		end

		if var_88_0 then
			arg_88_0:_playWelcomeVoice()
			var_0_1:resetWeatherChangeVoiceFlag()
		end

		if var_88_0 == arg_88_0._showInScene then
			var_0_1:setStateByString("Photo_album", var_88_0 and "no" or "yes")

			return
		end

		arg_88_0:_setShowInScene(var_88_0)
	end
end

function var_0_0._setShowInScene(arg_89_0, arg_89_1)
	arg_89_0._showInScene = arg_89_1

	if arg_89_0._showInScene then
		arg_89_0:showInScene()
	else
		arg_89_0:showInFrame()
	end

	MainController.instance:dispatchEvent(MainEvent.HeroShowInScene, arg_89_0._showInScene)
end

function var_0_0.debugShowMode(arg_90_0, arg_90_1)
	arg_90_0:_setShowInScene(arg_90_1)
end

function var_0_0._reOpenWhileOpen(arg_91_0, arg_91_1)
	if ViewMgr.instance:isFull(arg_91_1) then
		arg_91_0:_onOpenFullViewFinish(arg_91_1)
	end
end

function var_0_0._playWelcomeVoice(arg_92_0, arg_92_1)
	if arg_92_0:_hasOpenFullView() then
		return
	end

	if not arg_92_1 and math.random() > 0.3 then
		return false
	end

	local var_92_0 = arg_92_0:_getSpecialInteraction()

	if var_92_0 and (string.splitToNumber(var_92_0.param, "#")[2] or 0) > math.random() * 100 then
		CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Auto)
		arg_92_0:_initSkinInteraction()
		arg_92_0:clickPlayVoice(var_92_0)

		return true
	end

	local var_92_1 = var_0_0.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, arg_92_0._heroId, arg_92_0._skinId)

	if var_92_1 then
		arg_92_0:playVoice(var_92_1)

		return true
	end

	return false
end

function var_0_0.getWelcomeLikeVoice(arg_93_0, arg_93_1, arg_93_2)
	local var_93_0 = WeatherModel.instance:getNowDate()

	var_93_0.hour = 0
	var_93_0.min = 0
	var_93_0.sec = 0

	local var_93_1 = os.time(var_93_0)
	local var_93_2 = os.time()
	local var_93_3 = HeroModel.instance:getVoiceConfig(arg_93_1, arg_93_0, function(arg_94_0)
		local var_94_0 = GameUtil.splitString2(arg_94_0.time, false, "|", "#")

		for iter_94_0, iter_94_1 in ipairs(var_94_0) do
			if var_0_0._checkTime(iter_94_1, var_93_1, var_93_2) then
				return true
			end
		end

		return false
	end, arg_93_2)

	return (var_0_0.getHeightWeight(var_93_3))
end

function var_0_0._checkTime(arg_95_0, arg_95_1, arg_95_2)
	local var_95_0 = string.split(arg_95_0[1], ":")
	local var_95_1 = tonumber(var_95_0[1])
	local var_95_2 = tonumber(var_95_0[2])
	local var_95_3 = tonumber(arg_95_0[2])

	if not var_95_1 or not var_95_2 or not var_95_3 then
		return false
	end

	local var_95_4 = arg_95_1 + (var_95_1 * 60 + var_95_2) * 60
	local var_95_5 = var_95_4 + var_95_3 * 3600

	return var_95_4 <= arg_95_2 and arg_95_2 <= var_95_5
end

function var_0_0._onOpenView(arg_96_0, arg_96_1)
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and arg_96_1 == ViewName.CharacterSwitchView then
		arg_96_0.viewContainer:_setVisible(false)

		return
	end

	local var_96_0 = ViewMgr.instance:getSetting(arg_96_1)

	if var_96_0 and (var_96_0.viewType == ViewType.Full or var_96_0.bgBlur) and arg_96_0._lightSpine then
		arg_96_0:_tryStopVoice()
	end

	if arg_96_1 == ViewName.MainThumbnailView then
		arg_96_0._animator:Play("mainview_out", 0, 0)
		TaskDispatcher.runDelay(arg_96_0._hide, arg_96_0, 0.4)

		if arg_96_0._tweenId then
			ZProj.TweenHelper.KillById(arg_96_0._tweenId)

			arg_96_0._tweenId = nil
		end

		arg_96_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_96_0._setFactor, nil, arg_96_0, nil, EaseType.Linear)

		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		arg_96_0:_tryStopVoice()
	elseif arg_96_1 == ViewName.CharacterGetView or arg_96_1 == ViewName.CharacterSkinGetDetailView then
		if arg_96_0._lightSpine then
			gohelper.setActive(arg_96_0._lightSpine:getSpineGo(), false)
		end
	elseif arg_96_1 == ViewName.SummonView then
		arg_96_0:_hideModelEffect()
	end
end

function var_0_0._tryStopVoice(arg_97_0)
	if not arg_97_0._lightSpine or LimitedRoleController.instance:isPlayingAction() then
		-- block empty
	else
		arg_97_0:_onStopVoice()
	end
end

function var_0_0._forceStopVoice(arg_98_0)
	if arg_98_0._lightSpine then
		arg_98_0:_onStopVoice()
	end
end

function var_0_0._hide(arg_99_0)
	arg_99_0.viewContainer:_setVisible(false)
end

function var_0_0._onCloseView(arg_100_0, arg_100_1)
	if arg_100_1 == ViewName.SettingsView and ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		var_0_0.setPostProcessBlur()

		return
	end

	if arg_100_1 == ViewName.SummonView then
		arg_100_0:_delayShowModelEffect()
	elseif arg_100_1 == ViewName.CharacterView and arg_100_0._lightSpine and arg_100_0._showInScene then
		arg_100_0._lightSpine:setLayer(UnityLayer.Water)
	end

	if arg_100_1 == ViewName.StoryView then
		arg_100_0:_onFinish()
	end

	if not arg_100_0:_hasOpenFullView() then
		arg_100_0:_activationSettings()
	end
end

function var_0_0._onCloseViewFinish(arg_101_0, arg_101_1)
	if arg_101_0:_isLogout() then
		return
	end

	arg_101_0:_setSpineScale()

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and arg_101_1 == ViewName.CharacterSwitchView then
		arg_101_0.viewContainer:_setVisible(true)

		return
	end

	if arg_101_1 == ViewName.MainThumbnailView then
		TaskDispatcher.cancelTask(arg_101_0._hide, arg_101_0)
		arg_101_0.viewContainer:_setVisible(true)
		arg_101_0._animator:Play("mainview_in", 0, 0)

		if arg_101_0._tweenId then
			ZProj.TweenHelper.KillById(arg_101_0._tweenId)

			arg_101_0._tweenId = nil
		end

		arg_101_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, arg_101_0._setFactor, arg_101_0._resetPostProcessValue, arg_101_0, nil, EaseType.Linear)

		local var_101_0, var_101_1 = CharacterSwitchListModel.instance:getMainHero()

		if arg_101_0._curHeroId ~= var_101_0 and var_101_0 or arg_101_0._curSkinId ~= var_101_1 and var_101_1 or gohelper.isNil(arg_101_0._spineGo) then
			arg_101_0._curHeroId = var_101_0
			arg_101_0._curSkinId = var_101_1

			arg_101_0:_updateHero(arg_101_0._curHeroId, arg_101_0._curSkinId)
		elseif arg_101_0._lightSpine then
			local var_101_2 = {
				heroPlayWeatherVoice = true,
				roleGo = arg_101_0._lightSpine:getSpineGo(),
				heroId = arg_101_0._heroId,
				sharedMaterial = arg_101_0._spineMaterial,
				skinId = var_101_1
			}

			var_0_1:changeRoleGo(var_101_2)
			WeatherController.instance:setLightModel(arg_101_0._lightSpine)
		end
	elseif arg_101_1 == ViewName.CharacterGetView or arg_101_1 == ViewName.CharacterSkinGetDetailView then
		if arg_101_0._lightSpine then
			gohelper.setActive(arg_101_0._lightSpine:getSpineGo(), true)
		end
	elseif arg_101_1 == ViewName.CharacterView and arg_101_0._lightSpine and arg_101_0._showInScene then
		arg_101_0._lightSpine:setLayer(UnityLayer.Unit)
	end
end

function var_0_0._setFactor(arg_102_0, arg_102_1)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_102_1)
end

function var_0_0.setPostProcessBlur()
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", 1)
	PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
	PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
end

function var_0_0.resetPostProcessBlur()
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4(7.18, 0.77, 3.26, 1))
	PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 3)
end

function var_0_0._resetPostProcessValue(arg_105_0)
	if arg_105_0._tweenId then
		ZProj.TweenHelper.KillById(arg_105_0._tweenId)

		arg_105_0._tweenId = nil
	end

	var_0_0.resetPostProcessBlur()
end

function var_0_0._isLogout(arg_106_0)
	return ViewMgr.instance:isOpen(ViewName.LoadingView)
end

function var_0_0.onClose(arg_107_0)
	if arg_107_0._lightSpine then
		arg_107_0._lightSpine:doDestroy()

		arg_107_0._lightSpine = nil
	end

	arg_107_0._click:RemoveClickDownListener()
	arg_107_0._drag:RemoveDragBeginListener()
	arg_107_0._drag:RemoveDragListener()
	arg_107_0._drag:RemoveDragEndListener()

	if arg_107_0._photoFrameBgLoader then
		arg_107_0._photoFrameBgLoader:dispose()

		arg_107_0._photoFrameBgLoader = nil
	end

	var_0_1:setStateByString("Photo_album", "no")

	if arg_107_0._skinInteraction then
		arg_107_0._skinInteraction:onDestroy()
	end

	TaskDispatcher.cancelTask(arg_107_0._hide, arg_107_0)
	TaskDispatcher.cancelTask(arg_107_0._showModelEffect, arg_107_0)
	TaskDispatcher.cancelTask(arg_107_0._hideLightSpineVisible, arg_107_0)
	TaskDispatcher.cancelTask(arg_107_0._setSpineScale, arg_107_0)
	TaskDispatcher.cancelTask(arg_107_0._delayInitLightSpine, arg_107_0)
	arg_107_0:_resetPostProcessValue()
	arg_107_0:_clearEvents()
end

function var_0_0._clearEvents(arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_108_0._onOpenFullViewFinish, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_108_0._onOpenFullView, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_108_0._onCloseFullView, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_108_0._reOpenWhileOpen, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_108_0._onOpenView, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_108_0._onCloseViewFinish, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_108_0._onCloseView, arg_108_0)
	arg_108_0:removeEventCb(StoryController.instance, StoryEvent.Start, arg_108_0._onStart, arg_108_0)
	arg_108_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_108_0._onFinish, arg_108_0)
	arg_108_0:removeEventCb(WeatherController.instance, WeatherEvent.PlayVoice, arg_108_0._onWeatherPlayVoice, arg_108_0)
	arg_108_0:removeEventCb(WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, arg_108_0._onWeatherLoadPhotoFrameBg, arg_108_0)
	arg_108_0:removeEventCb(WeatherController.instance, WeatherEvent.OnRoleBlend, arg_108_0._onWeatherOnRoleBlend, arg_108_0)
	arg_108_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_108_0._onLoadingCloseView, arg_108_0)
	arg_108_0:removeEventCb(MainController.instance, MainEvent.ForceStopVoice, arg_108_0._forceStopVoice, arg_108_0)
	TaskDispatcher.cancelTask(arg_108_0._delayCheckShowMain, arg_108_0)
end

function var_0_0.onCloseFinish(arg_109_0)
	gohelper.destroy(arg_109_0._golightspine)
end

function var_0_0.getMaxTouchHeadNumber(arg_110_0)
	return tonumber(lua_const.configList[32].value)
end

function var_0_0.onDestroyView(arg_111_0)
	arg_111_0:_disableKeyword()
end

function var_0_0._clearTrackMainHeroInteractionData(arg_112_0)
	arg_112_0._track_main_hero_interaction_info = {
		main_hero_interaction_skin_id = false,
		main_hero_interaction_voice_id = false,
		main_hero_interaction_area_id = false
	}
end

function var_0_0._updateTrackInfoSkinId(arg_113_0, arg_113_1)
	arg_113_0._track_main_hero_interaction_info.main_hero_interaction_skin_id = arg_113_1
end

function var_0_0._updateTrackInfoAreaId(arg_114_0, arg_114_1)
	arg_114_0._track_main_hero_interaction_info.main_hero_interaction_area_id = arg_114_1
end

function var_0_0._trackMainHeroInteraction(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_0._track_main_hero_interaction_info

	if not var_115_0.main_hero_interaction_area_id or not var_115_0.main_hero_interaction_skin_id then
		return
	end

	var_115_0.main_hero_interaction_voice_id = tostring(arg_115_1)

	SDKDataTrackMgr.instance:trackMainHeroInteraction(var_115_0)
	arg_115_0:_updateTrackInfoAreaId(nil)
end

return var_0_0
