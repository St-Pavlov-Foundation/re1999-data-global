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
	arg_4_0:addEventCb(CharacterController.instance, CharacterEvent.MainHeroGmPlayVoice, arg_4_0._onMainHeroGmPlayVoice, arg_4_0)
end

function var_0_0._onMainHeroGmPlayVoice(arg_5_0, arg_5_1)
	local var_5_0 = lua_character_voice.configDict[arg_5_0._curHeroId][arg_5_1]

	if not var_5_0 then
		logError(string.format("MainHeroView:_onMainHeroGmPlayVoice heroId:%s voiceId:%s not config", arg_5_0._curHeroId, arg_5_1))

		return
	end

	if not string.find(var_5_0.skins, arg_5_0._curSkinId) then
		logError(string.format("MainHeroView:_onMainHeroGmPlayVoice heroId:%s voiceId:%s skinId:%s 皮肤不匹配", arg_5_0._curHeroId, arg_5_1, arg_5_0._curSkinId))

		return
	end

	arg_5_0:clickPlayVoice(var_5_0)
end

function var_0_0._onScreenResize(arg_6_0)
	arg_6_0:_repeatSetSpineScale()
end

function var_0_0._onStart(arg_7_0, arg_7_1)
	if arg_7_0._lightSpine then
		arg_7_0._isSpineCleared = true

		arg_7_0:_onStopVoice()
		arg_7_0._lightSpine:clear()

		arg_7_0._spineGo = nil
		arg_7_0._spineTransform = nil
		arg_7_0._spineMaterial = nil

		WeatherController.instance:clearMat()
	end
end

function var_0_0._onFinish(arg_8_0, arg_8_1)
	if not arg_8_0._isSpineCleared then
		return
	end

	arg_8_0._isSpineCleared = false
	arg_8_0._storyFinish = true
	arg_8_0._curHeroId, arg_8_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_8_0._curHeroId and arg_8_0._curSkinId then
		arg_8_0:_updateHero(arg_8_0._curHeroId, arg_8_0._curSkinId)
	end
end

function var_0_0._onBeginLogout(arg_9_0)
	arg_9_0:_clearEvents()
end

function var_0_0._onLoadingCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.LoadingView then
		if arg_10_0._canvasGroup then
			arg_10_0._canvasGroup.alpha = 1
			arg_10_0._canvasGroup = nil

			arg_10_0._animator:Play("mainview_in", 0, 0)
		end

		arg_10_0:_checkPlayGreetingVoices()
	end
end

function var_0_0._onDelayCloseLoading(arg_11_0)
	local var_11_0 = gohelper.onceAddComponent(arg_11_0.viewGO, typeof(UnityEngine.CanvasGroup))

	var_11_0.alpha = 0
	arg_11_0._canvasGroup = var_11_0
end

function var_0_0._onShowMainThumbnailView(arg_12_0)
	gohelper.onceAddComponent(arg_12_0.viewGO, typeof(UnityEngine.CanvasGroup)).alpha = 0
end

function var_0_0._changeMainHeroSkin(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and not ViewMgr.instance:isOpen(ViewName.GMToolView) then
		return
	end

	arg_13_0._changeShowInScene = arg_13_2

	if arg_13_0._lightSpine then
		arg_13_0:_onStopVoice()
	end

	arg_13_0:_updateHero(arg_13_1.characterId, arg_13_1.id, arg_13_3)
end

function var_0_0._onRefreshMainHeroSkin(arg_14_0)
	arg_14_0._curHeroId, arg_14_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_14_0._curHeroId and arg_14_0._curSkinId then
		arg_14_0:_updateHero(arg_14_0._curHeroId, arg_14_0._curSkinId)
	end
end

function var_0_0._onSpineLoaded(arg_15_0)
	if arg_15_0._storyFinish then
		arg_15_0._storyFinish = nil

		arg_15_0:_setShowInScene(true)
	end

	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	arg_15_0:_setShowInScene(arg_15_0._changeShowInScene)
end

function var_0_0._setViewVisible(arg_16_0, arg_16_1)
	arg_16_0._mainViewVisible = arg_16_1
	arg_16_0._changeTime = Time.realtimeSinceStartup
end

function var_0_0._onSceneClose(arg_17_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_17_0._onCloseFullView, arg_17_0)
end

function var_0_0._onClickSwitchRole(arg_18_0)
	arg_18_0:checkSwitchShowInScene()
end

function var_0_0.checkSwitchShowInScene(arg_19_0)
	if not arg_19_0._showInScene then
		arg_19_0:_setShowInScene(true)

		if arg_19_0._lightSpine then
			arg_19_0._lightSpine:fadeIn()
		end
	end
end

function var_0_0._onWeatherPlayVoice(arg_20_0, arg_20_1)
	if not PlayerModel.instance:getMainThumbnail() then
		return
	end

	if arg_20_0:isPlayingVoice() or not arg_20_0:isShowInScene() then
		return
	end

	arg_20_1[2] = true

	arg_20_0:playVoice(arg_20_1[1])
end

function var_0_0._onWeatherLoadPhotoFrameBg(arg_21_0)
	arg_21_0:loadPhotoFrameBg()
end

function var_0_0._onWeatherOnRoleBlend(arg_22_0, arg_22_1)
	arg_22_0:onRoleBlend(arg_22_1[1], arg_22_1[2])
	arg_22_0:_updateMainColor()
end

function var_0_0._setViewRootVisible(arg_23_0, arg_23_1)
	if not arg_23_1 and arg_23_0._lightSpine then
		arg_23_0:_onStopVoice()
	end
end

function var_0_0._updateMainColor(arg_24_0)
	if not arg_24_0._lightSpine then
		return
	end

	if arg_24_0._showInScene then
		local var_24_0 = WeatherController.instance:getMainColor()

		arg_24_0._lightSpine:setMainColor(var_24_0)
		arg_24_0._lightSpine:setLumFactor(WeatherEnum.HeroInSceneLumFactor)
	else
		local var_24_1 = WeatherController.instance:getCurLightMode()

		if not var_24_1 then
			return
		end

		local var_24_2 = WeatherEnum.HeroInFrameColor[var_24_1]

		arg_24_0._lightSpine:setMainColor(var_24_2)
		arg_24_0._lightSpine:setLumFactor(WeatherEnum.HeroInFrameLumFactor[var_24_1])
	end
end

function var_0_0._onStartSwitchScene(arg_25_0)
	if not arg_25_0._showInScene then
		arg_25_0:_setShowInScene(true)
	end
end

function var_0_0._onSwitchSceneFinish(arg_26_0)
	arg_26_0:_initFrame()
end

function var_0_0._initFrame(arg_27_0)
	arg_27_0._frameBg = nil
	arg_27_0._frameSpineNode = nil
	arg_27_0._frameBg = var_0_1:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not arg_27_0._frameBg then
		logError("_initFrame no frameBg")
	end

	local var_27_0 = var_0_1:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if var_27_0 then
		arg_27_0._frameSpineNode = var_27_0.transform
	else
		logError("_initFrame no spineMountPoint")
	end

	gohelper.setActive(arg_27_0._frameBg, false)

	arg_27_0._frameSpineNodeX = 3.11
	arg_27_0._frameSpineNodeY = 0.51
	arg_27_0._frameSpineNodeZ = 3.09
	arg_27_0._frameSpineNodeScale = 0.39

	local var_27_1 = arg_27_0._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	arg_27_0._frameBgMaterial = UnityEngine.Material.Instantiate(var_27_1.sharedMaterial)
	var_27_1.material = arg_27_0._frameBgMaterial
end

function var_0_0._editableInitView(arg_28_0)
	arg_28_0:_clearTrackMainHeroInteractionData()
	arg_28_0:_enableKeyword()

	arg_28_0._skinInteraction = nil
	arg_28_0._curHeroId, arg_28_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_28_0._curHeroId and arg_28_0._curSkinId then
		arg_28_0:_updateHero(arg_28_0._curHeroId, arg_28_0._curSkinId)
	end

	arg_28_0._animator = arg_28_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_28_0._click = SLFramework.UGUI.UIClickListener.Get(arg_28_0._golightspinecontrol)

	arg_28_0._click:AddClickDownListener(arg_28_0._clickDown, arg_28_0)

	arg_28_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_28_0._golightspinecontrol)

	arg_28_0._drag:AddDragBeginListener(arg_28_0._onDragBegin, arg_28_0)
	arg_28_0._drag:AddDragListener(arg_28_0._onDrag, arg_28_0)
	arg_28_0._drag:AddDragEndListener(arg_28_0._onDragEnd, arg_28_0)
	arg_28_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_28_0._onTouch, arg_28_0)

	arg_28_0._showInScene = true

	arg_28_0:_initFrame()

	arg_28_0._TintColorId = UnityEngine.Shader.PropertyToID("_TintColor")

	arg_28_0:_repeatSetSpineScale()
end

function var_0_0._setSpineScale(arg_29_0)
	var_0_0.setSpineScale(arg_29_0._gospinescale)
end

function var_0_0._repeatSetSpineScale(arg_30_0)
	arg_30_0:_setSpineScale()
	TaskDispatcher.cancelTask(arg_30_0._setSpineScale, arg_30_0)
	TaskDispatcher.runRepeat(arg_30_0._setSpineScale, arg_30_0, 0.1, 5)
end

function var_0_0.setSpineScale(arg_31_0)
	local var_31_0 = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(arg_31_0.transform, var_31_0, var_31_0, var_31_0)
end

function var_0_0.showInScene(arg_32_0)
	if not arg_32_0._spineMaterial then
		return
	end

	arg_32_0._lightSpine:setEffectFrameVisible(true)
	arg_32_0:_setStencil(true)

	arg_32_0._spineTransform.parent = arg_32_0._golightspine.transform

	transformhelper.setLocalScale(arg_32_0._spineTransform, 1, 1, 1)
	transformhelper.setLocalPos(arg_32_0._spineTransform, 0, 0, 0)
	transformhelper.setLocalRotation(arg_32_0._spineGo.transform, 0, 0, 0)
	gohelper.setLayer(arg_32_0._spineGo, UnityLayer.Unit, true)
	gohelper.setActive(arg_32_0._frameBg, false)
	var_0_1:setRoleMaskEnabled(true)
	var_0_1:setStateByString("Photo_album", "no")
	arg_32_0:_updateMainColor()
end

function var_0_0.showInFrame(arg_33_0)
	if not arg_33_0._spineMaterial then
		return
	end

	arg_33_0._lightSpine:setEffectFrameVisible(false)
	arg_33_0:_setStencil(false)
	transformhelper.setLocalScale(arg_33_0._frameSpineNode, 1, 1, 1)
	transformhelper.setLocalPos(arg_33_0._frameSpineNode, 0, 0, 0)

	arg_33_0._spineTransform.parent = arg_33_0._frameSpineNode

	local var_33_0 = transformhelper.getLocalScale(arg_33_0._spineTransform)

	transformhelper.setLocalScale(arg_33_0._spineTransform, var_33_0, var_33_0, var_33_0)
	transformhelper.setLocalRotation(arg_33_0._spineTransform, 0, 0, 0)

	local var_33_1 = arg_33_0._frameSpineNodeX
	local var_33_2 = arg_33_0._frameSpineNodeY
	local var_33_3 = arg_33_0._frameSpineNodeScale

	if not string.nilorempty(arg_33_0._heroSkinConfig.mainViewFrameOffset) then
		local var_33_4 = SkinConfig.instance:getSkinOffset(arg_33_0._heroSkinConfig.mainViewFrameOffset)

		var_33_1 = var_33_4[1]
		var_33_2 = var_33_4[2]
		var_33_3 = var_33_4[3]

		local var_33_5 = MainSceneSwitchModel.instance:getCurSceneId()
		local var_33_6 = var_33_5 and lua_scene_settings.configDict[var_33_5]

		if var_33_6 then
			var_33_1 = var_33_1 + var_33_6.spineOffset[1]
			var_33_2 = var_33_2 + var_33_6.spineOffset[2]
		end
	end

	transformhelper.setLocalScale(arg_33_0._frameSpineNode, var_33_3, var_33_3, var_33_3)
	transformhelper.setLocalPos(arg_33_0._frameSpineNode, var_33_1, var_33_2, arg_33_0._frameSpineNodeZ)
	gohelper.setLayer(arg_33_0._spineGo, UnityLayer.Scene, true)

	if not arg_33_0:loadPhotoFrameBg() then
		gohelper.setActive(arg_33_0._frameBg, true)
	end

	var_0_1:setRoleMaskEnabled(false)
	var_0_1:setStateByString("Photo_album", "yes")
	arg_33_0:_updateMainColor()
end

function var_0_0.loadPhotoFrameBg(arg_34_0)
	if arg_34_0._showInScene then
		return false
	end

	if arg_34_0._curLightMode then
		return false
	end

	local var_34_0 = var_0_1:getCurLightMode()

	if not var_34_0 or arg_34_0._curLightMode == var_34_0 then
		return false
	end

	arg_34_0._curLightMode = var_34_0

	if arg_34_0._photoFrameBgLoader then
		arg_34_0._photoFrameBgLoader:dispose()

		arg_34_0._photoFrameBgLoader = nil
	end

	local var_34_1 = MultiAbLoader.New()

	arg_34_0._photoFrameBgLoader = var_34_1

	local var_34_2 = MainSceneSwitchModel.instance:getCurSceneId()
	local var_34_3 = WeatherFrameComp.getFramePath(var_34_2)

	var_34_1:addPath(var_34_3)
	var_34_1:startLoad(function()
		local var_35_0 = var_34_1:getAssetItem(var_34_3):GetResource(var_34_3)

		arg_34_0._frameBgMaterial:SetTexture("_MainTex", var_35_0)
		gohelper.setActive(arg_34_0._frameBg, true)
	end)

	return true
end

function var_0_0.onRoleBlend(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0._targetFrameTintColor then
		local var_36_0 = var_0_1:getCurLightMode()
		local var_36_1 = var_0_1:getPrevLightMode() or var_36_0

		if not var_36_0 then
			return
		end

		local var_36_2 = MainSceneSwitchModel.instance:getCurSceneId()

		arg_36_0._targetFrameTintColor = WeatherFrameComp.getFrameColor(var_36_2, var_36_0)
		arg_36_0._srcFrameTintColor = WeatherFrameComp.getFrameColor(var_36_2, var_36_1)

		arg_36_0._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	arg_36_0._frameBgMaterial:SetColor(arg_36_0._TintColorId, var_0_1:lerpColorRGBA(arg_36_0._srcFrameTintColor, arg_36_0._targetFrameTintColor, arg_36_1))

	if arg_36_2 then
		arg_36_0._targetFrameTintColor = nil

		if var_0_1:getCurLightMode() == 1 then
			arg_36_0._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function var_0_0._updateHero(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0._anchorMinPos = nil
	arg_37_0._anchorMaxPos = nil
	arg_37_0._heroId = arg_37_1
	arg_37_0._skinId = arg_37_2

	local var_37_0 = HeroConfig.instance:getHeroCO(arg_37_0._heroId)
	local var_37_1 = SkinConfig.instance:getSkinCo(arg_37_0._skinId or var_37_0 and var_37_0.skin)

	if not var_37_1 then
		arg_37_0:_updateTrackInfoSkinId(nil)

		return
	end

	arg_37_0._heroPhotoFrameBg = var_37_0.photoFrameBg
	arg_37_0._heroSkinConfig = var_37_1
	arg_37_0._heroSkinTriggerArea = {}

	arg_37_0:_updateTrackInfoSkinId(var_37_1.id)

	if not arg_37_3 then
		local var_37_2 = SkinConfig.instance:getSkinOffset(var_37_1.mainViewOffset)
		local var_37_3 = arg_37_0._golightspine.transform

		recthelper.setAnchor(var_37_3, tonumber(var_37_2[1]), tonumber(var_37_2[2]))

		local var_37_4 = tonumber(var_37_2[3])

		var_37_3.localScale = Vector3.one * var_37_4
	end

	if not arg_37_0._lightSpine then
		arg_37_0._lightSpine = LightModelAgent.Create(arg_37_0._golightspine, true)
	end

	if not string.nilorempty(var_37_1.defaultStencilValue) then
		arg_37_0._defaultStencilValue = string.splitToNumber(var_37_1.defaultStencilValue, "#")
	else
		arg_37_0._defaultStencilValue = nil
	end

	if not string.nilorempty(var_37_1.frameStencilValue) then
		arg_37_0._frameStencilValue = string.splitToNumber(var_37_1.frameStencilValue, "#")
	else
		arg_37_0._frameStencilValue = nil
	end

	arg_37_0._lightSpine:setResPath(var_37_1, arg_37_0._onLightSpineLoaded, arg_37_0)
	arg_37_0._lightSpine:setInMainView()
end

function var_0_0._setStencil(arg_38_0, arg_38_1)
	if arg_38_1 then
		if arg_38_0._defaultStencilValue then
			arg_38_0._lightSpine:setStencilValues(arg_38_0._defaultStencilValue[1], arg_38_0._defaultStencilValue[2], arg_38_0._defaultStencilValue[3])
		else
			arg_38_0._lightSpine:setStencilRef(0)
		end
	elseif arg_38_0._frameStencilValue then
		arg_38_0._lightSpine:setStencilValues(arg_38_0._frameStencilValue[1], arg_38_0._frameStencilValue[2], arg_38_0._frameStencilValue[3])
	else
		arg_38_0._lightSpine:setStencilRef(1)
	end
end

function var_0_0._checkPlayGreetingVoices(arg_39_0)
	if LimitedRoleController.instance:isPlaying() then
		return
	end

	if arg_39_0._needPlayGreeting and not ViewMgr.instance:isOpen(ViewName.LoadingView) then
		arg_39_0:_playGreetingVoices()
	end
end

function var_0_0._playGreetingVoices(arg_40_0)
	local var_40_0 = HeroModel.instance:getVoiceConfig(arg_40_0._heroId, CharacterEnum.VoiceType.Greeting, nil, arg_40_0._skinId)

	if var_40_0 and #var_40_0 > 0 then
		arg_40_0:_onWeatherPlayVoice({
			var_40_0[1]
		})
	end
end

function var_0_0._onLightSpineLoaded(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._delayInitLightSpine, arg_41_0)
	TaskDispatcher.runDelay(arg_41_0._delayInitLightSpine, arg_41_0, 0.1)
end

function var_0_0._delayInitLightSpine(arg_42_0)
	arg_42_0._spineGo = arg_42_0._lightSpine:getSpineGo()

	if gohelper.isNil(arg_42_0._spineGo) then
		return
	end

	arg_42_0._spineTransform = arg_42_0._spineGo.transform
	arg_42_0._spineMaterial = arg_42_0._lightSpine:getRenderer().sharedMaterial

	arg_42_0:_setStencil(true)
	WeatherController.instance:setLightModel(arg_42_0._lightSpine)

	if not arg_42_0._firstLoadSpine then
		arg_42_0._firstLoadSpine = true

		if PlayerModel.instance:getMainThumbnail() then
			-- block empty
		end

		local var_42_0 = ViewMgr.instance:hasOpenFullView()
		local var_42_1 = not var_42_0

		if MainController.instance.firstEnterMainScene then
			MainController.instance.firstEnterMainScene = false
			var_42_1 = false

			if not var_42_0 then
				arg_42_0._needPlayGreeting = true

				arg_42_0:_checkPlayGreetingVoices()
			end
		end

		var_0_1:initRoleGo(arg_42_0._spineGo, arg_42_0._heroId, arg_42_0._spineMaterial, var_42_1, arg_42_0._skinId)
	else
		local var_42_2 = {
			heroPlayWeatherVoice = true,
			roleGo = arg_42_0._lightSpine:getSpineGo(),
			heroId = arg_42_0._heroId,
			sharedMaterial = arg_42_0._spineMaterial,
			skinId = arg_42_0._skinId
		}

		var_0_1:changeRoleGo(var_42_2)
	end

	arg_42_0.viewContainer:getNoInteractiveComp():init()
	arg_42_0:_onSpineLoaded()
end

function var_0_0.isPlayingVoice(arg_43_0)
	if not arg_43_0._lightSpine then
		return false
	end

	if arg_43_0._skinInteraction and arg_43_0._skinInteraction:isPlayingVoice() then
		return true
	end

	return arg_43_0._lightSpine:isPlayingVoice()
end

function var_0_0.getLightSpine(arg_44_0)
	return arg_44_0._lightSpine
end

function var_0_0.isShowInScene(arg_45_0)
	return arg_45_0._showInScene
end

function var_0_0._checkSpecialTouch(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = "triggerArea" .. arg_46_1.param
	local var_46_1 = arg_46_0._heroSkinTriggerArea[var_46_0]

	if not var_46_1 then
		var_46_1 = {}
		arg_46_0._heroSkinTriggerArea[var_46_0] = var_46_1

		local var_46_2 = arg_46_0._heroSkinConfig[var_46_0]
		local var_46_3 = string.split(var_46_2, "_")

		for iter_46_0, iter_46_1 in ipairs(var_46_3) do
			local var_46_4 = string.split(iter_46_1, "|")

			if #var_46_4 == 2 then
				local var_46_5 = string.split(var_46_4[1], "#")
				local var_46_6 = string.split(var_46_4[2], "#")
				local var_46_7 = tonumber(var_46_5[1])
				local var_46_8 = tonumber(var_46_5[2])
				local var_46_9 = tonumber(var_46_6[1])
				local var_46_10 = tonumber(var_46_6[2])
				local var_46_11 = {
					var_46_7,
					var_46_8,
					var_46_9,
					var_46_10
				}

				table.insert(var_46_1, var_46_11)
			end
		end
	end

	for iter_46_2, iter_46_3 in ipairs(var_46_1) do
		local var_46_12 = tonumber(iter_46_3[1])
		local var_46_13 = tonumber(iter_46_3[2])
		local var_46_14 = tonumber(iter_46_3[3])
		local var_46_15 = tonumber(iter_46_3[4])

		if arg_46_2 and var_46_12 <= arg_46_2.x and var_46_14 >= arg_46_2.x and var_46_13 >= arg_46_2.y and var_46_15 <= arg_46_2.y then
			arg_46_0:_updateTrackInfoAreaId(tonumber(arg_46_1.param))

			return true
		end
	end

	return false
end

function var_0_0._onTouch(arg_47_0)
	if not LimitedRoleController.instance:isPlaying() and arg_47_0._mainViewVisible == false and Time.realtimeSinceStartup - arg_47_0._changeTime > 0.5 then
		TaskDispatcher.runDelay(arg_47_0._delayCheckShowMain, arg_47_0, 0.01)
	end
end

function var_0_0._delayCheckShowMain(arg_48_0)
	if not LimitedRoleController.instance:isPlaying() and arg_48_0._mainViewVisible == false and Time.realtimeSinceStartup - arg_48_0._changeTime > 0.5 then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_display)
	end
end

function var_0_0._onDragBegin(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_0._skinInteraction and arg_49_0._skinInteraction:needRespond() then
		arg_49_0._dragSpecialRespond = arg_49_0:_getDragSpecialRespond(CharacterEnum.VoiceType.MainViewDragSpecialRespond)

		if not arg_49_0._dragSpecialRespond then
			return
		end

		arg_49_0:_checkSpecialTouch(arg_49_0._dragSpecialRespond)

		local var_49_0 = "triggerArea" .. arg_49_0._dragSpecialRespond.param

		arg_49_0._dragArea = arg_49_0._heroSkinTriggerArea[var_49_0][1]

		local var_49_1 = arg_49_0._dragSpecialRespond.param2
		local var_49_2 = string.split(var_49_1, "#")

		arg_49_0._dragParamName = var_49_2[1]
		arg_49_0._dragParamMinValue = tonumber(var_49_2[2])
		arg_49_0._dragParamMaxValue = tonumber(var_49_2[3])
		arg_49_0._dragParamLength = arg_49_0._dragParamMaxValue - arg_49_0._dragParamMinValue
		arg_49_0._dragParamIndex = arg_49_0._lightSpine:addParameter(arg_49_0._dragParamName, 0, arg_49_0._dragParamMinValue)

		arg_49_0._skinInteraction:beginDrag()
		AudioMgr.instance:trigger(AudioEnum.UI.hero3100_mainsfx_mic_drag)
	end
end

function var_0_0._onDrag(arg_50_0, arg_50_1, arg_50_2)
	if not arg_50_0._dragSpecialRespond then
		return
	end

	local var_50_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_50_0._golightspinecontrol.transform)
	local var_50_1 = arg_50_0._dragArea[1]
	local var_50_2 = arg_50_0._dragArea[2]
	local var_50_3 = arg_50_0._dragArea[3]
	local var_50_4 = arg_50_0._dragArea[4]

	if var_50_0 and var_50_1 <= var_50_0.x and var_50_3 >= var_50_0.x and var_50_2 >= var_50_0.y and var_50_4 <= var_50_0.y then
		local var_50_5 = (var_50_0.x - var_50_1) / (var_50_3 - var_50_1)
		local var_50_6 = arg_50_0._dragParamMinValue + var_50_5 * arg_50_0._dragParamLength

		arg_50_0._lightSpine:updateParameter(arg_50_0._dragParamIndex, var_50_6)

		if var_50_6 >= arg_50_0._dragParamMaxValue - 5 then
			local var_50_7 = arg_50_0._dragSpecialRespond

			arg_50_0:_onDragEnd(arg_50_1, arg_50_2)
			arg_50_0:_doClickPlayVoice(var_50_7)
		end
	end
end

function var_0_0._onDragEnd(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_0._dragParamName then
		arg_51_0._lightSpine:removeParameter(arg_51_0._dragParamName)

		arg_51_0._dragParamName = nil
	end

	if arg_51_0._dragSpecialRespond and arg_51_0._skinInteraction then
		arg_51_0._skinInteraction:endDrag()
	end

	arg_51_0._dragSpecialRespond = nil
end

function var_0_0._clickDown(arg_52_0)
	if arg_52_0._mainViewVisible == false then
		return
	end

	MainController.instance:dispatchEvent(MainEvent.ClickDown)

	if not arg_52_0._showInScene then
		return
	end

	if gohelper.isNil(arg_52_0._spineGo) then
		return
	end

	local var_52_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_52_0._golightspinecontrol.transform)

	arg_52_0:_initSkinInteraction()
	arg_52_0._skinInteraction:onClick(var_52_0)
end

function var_0_0._initSkinInteraction(arg_53_0)
	local var_53_0 = arg_53_0._skinInteraction

	if var_53_0 and var_53_0:getSkinId() ~= arg_53_0._skinId then
		var_53_0:onDestroy()

		arg_53_0._skinInteraction = nil
	end

	if not arg_53_0._skinInteraction then
		arg_53_0._skinInteraction = arg_53_0:getSkinInteraction(arg_53_0._skinId)

		arg_53_0._skinInteraction:init(arg_53_0, arg_53_0._skinId)
	end
end

function var_0_0.getSkinInteraction(arg_54_0, arg_54_1)
	if arg_54_1 == 303301 or arg_54_1 == 303302 then
		return TTTSkinInteraction.New()
	end

	return CommonSkinInteraction.New()
end

function var_0_0._clickDefault(arg_55_0, arg_55_1)
	arg_55_0:_updateTrackInfoAreaId(nil)

	local var_55_0 = arg_55_0:_getSpecialInteraction()

	if var_55_0 and arg_55_0:_checkPosInBound(arg_55_1) and arg_55_0._skinInteraction:canPlay(var_55_0) then
		local var_55_1 = string.splitToNumber(var_55_0.param, "#")

		if math.random() * 100 < var_55_1[1] then
			CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Click)
			arg_55_0:_doClickPlayVoice(var_55_0)

			return
		end
	end

	if arg_55_0._skinInteraction:needRespond() then
		local var_55_2 = arg_55_0:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialRespond, arg_55_1)

		if var_55_2 and arg_55_0._skinInteraction:canPlay(var_55_2) then
			arg_55_0:_doClickPlayVoice(var_55_2)
		end

		return
	end

	local var_55_3 = arg_55_0:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialTouch, arg_55_1)

	if var_55_3 and math.random() > 0.5 and arg_55_0._skinInteraction:canPlay(var_55_3) then
		local var_55_4 = var_0_0.getRandomMultiVoice(var_55_3, arg_55_0._heroId, arg_55_0._skinId)

		arg_55_0:_doClickPlayVoice(var_55_4, true)

		return
	end

	local var_55_5 = arg_55_0:_getNormalTouch(arg_55_1)

	if var_55_5 and arg_55_0._skinInteraction:canPlay(var_55_5) then
		arg_55_0:_doClickPlayVoice(var_55_5, true)
	end
end

function var_0_0._getSpecialInteraction(arg_56_0, arg_56_1)
	local var_56_0 = HeroModel.instance:getVoiceConfig(arg_56_0._heroId, arg_56_1 or CharacterEnum.VoiceType.MainViewSpecialInteraction, function(arg_57_0)
		return arg_56_0._clickPlayConfig ~= arg_57_0
	end, arg_56_0._skinId)

	if var_56_0 and #var_56_0 > 0 then
		return var_56_0[math.random(1, #var_56_0)] or var_56_0[1]
	end
end

function var_0_0._getDragSpecialRespond(arg_58_0, arg_58_1)
	local var_58_0 = HeroModel.instance:getVoiceConfig(arg_58_0._heroId, arg_58_1 or CharacterEnum.VoiceType.MainViewSpecialInteraction, function(arg_59_0)
		return arg_58_0._clickPlayConfig ~= arg_59_0 and not string.nilorempty(arg_59_0.param2)
	end, arg_58_0._skinId)

	if var_58_0 and #var_58_0 > 0 then
		return var_58_0[1]
	end
end

function var_0_0._getSpecialTouch(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = HeroModel.instance:getVoiceConfig(arg_60_0._heroId, arg_60_1, function(arg_61_0)
		return arg_60_0._clickPlayConfig ~= arg_61_0 and arg_60_0:_checkSpecialTouch(arg_61_0, arg_60_2)
	end, arg_60_0._skinId)

	if var_60_0 and #var_60_0 > 0 then
		return var_60_0[1]
	end
end

function var_0_0._getNormalTouch(arg_62_0, arg_62_1)
	if arg_62_0:_checkPosInBound(arg_62_1) then
		local var_62_0 = HeroModel.instance:getVoiceConfig(arg_62_0._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function(arg_63_0)
			return arg_62_0._clickPlayConfig ~= arg_63_0
		end, arg_62_0._skinId)
		local var_62_1 = var_0_0.getHeightWeight(var_62_0)

		return var_0_0.getRandomMultiVoice(var_62_1, arg_62_0._heroId, arg_62_0._skinId)
	end
end

function var_0_0.getRandomMultiVoice(arg_64_0, arg_64_1, arg_64_2)
	if not arg_64_0 then
		return
	end

	if math.random() <= 0.5 then
		local var_64_0 = CharacterDataConfig.instance:getCharacterTypeVoicesCO(arg_64_1, CharacterEnum.VoiceType.MultiVoice, arg_64_2)

		for iter_64_0, iter_64_1 in ipairs(var_64_0) do
			if tonumber(iter_64_1.param) == arg_64_0.audio then
				return iter_64_1
			end
		end
	end

	return arg_64_0
end

function var_0_0._checkPosInBound(arg_65_0, arg_65_1)
	if not arg_65_0._anchorMinPos or not arg_65_0._anchorMaxPos then
		local var_65_0, var_65_1 = arg_65_0._lightSpine:getBoundsMinMaxPos()

		arg_65_0._anchorMinPos = recthelper.worldPosToAnchorPos(Vector3(var_65_0.x, var_65_1.y, var_65_0.z), arg_65_0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
		arg_65_0._anchorMaxPos = recthelper.worldPosToAnchorPos(Vector3(var_65_1.x, var_65_0.y, var_65_1.z), arg_65_0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
	end

	local var_65_2 = arg_65_0._anchorMinPos
	local var_65_3 = arg_65_0._anchorMaxPos

	if arg_65_1.x >= var_65_2.x and arg_65_1.x <= var_65_3.x and arg_65_1.y <= var_65_2.y and arg_65_1.y >= var_65_3.y then
		return true
	end
end

function var_0_0.addFaith(arg_66_0)
	if HeroModel.instance:getTouchHeadNumber() <= 0 then
		return
	end

	HeroRpc.instance:sendTouchHeadRequest(arg_66_0._heroId)
end

function var_0_0._onSuccessTouchHead(arg_67_0, arg_67_1)
	if not arg_67_0._showFaithToast then
		return
	end

	arg_67_0._showFaithToast = false

	if arg_67_1 then
		GameFacade.showToast(ToastEnum.MainHeroAddSuccess)
	else
		GameFacade.showToast(ToastEnum.MainHeroAddFail)
	end
end

function var_0_0.getHeightWeight(arg_68_0)
	if arg_68_0 and #arg_68_0 > 0 then
		local var_68_0 = 0

		for iter_68_0, iter_68_1 in ipairs(arg_68_0) do
			var_68_0 = var_68_0 + iter_68_1.param
		end

		local var_68_1 = math.random()
		local var_68_2 = 0

		for iter_68_2, iter_68_3 in ipairs(arg_68_0) do
			var_68_2 = var_68_2 + iter_68_3.param

			if var_68_1 <= var_68_2 / var_68_0 then
				return iter_68_3
			end
		end
	end

	return nil
end

function var_0_0._doClickPlayVoice(arg_69_0, arg_69_1, arg_69_2)
	arg_69_0._showFaithToast = arg_69_2

	arg_69_0:addFaith()
	arg_69_0:clickPlayVoice(arg_69_1)
end

function var_0_0.clickPlayVoice(arg_70_0, arg_70_1)
	arg_70_0._clickPlayConfig = arg_70_1

	arg_70_0:playVoice(arg_70_1)
end

function var_0_0._onStopVoice(arg_71_0)
	arg_71_0._lightSpine:stopVoice()

	if arg_71_0._skinInteraction then
		arg_71_0._skinInteraction:onStopVoice()
	end
end

function var_0_0.playVoice(arg_72_0, arg_72_1)
	if not arg_72_0._lightSpine then
		return
	end

	if arg_72_0._skinInteraction then
		arg_72_0._skinInteraction:beforePlayVoice(arg_72_1)
	end

	arg_72_0:_onStopVoice()

	if arg_72_0._skinInteraction then
		arg_72_0._skinInteraction:onPlayVoice(arg_72_1)
	end

	arg_72_0._lightSpine:playVoice(arg_72_1, function()
		if arg_72_0._skinInteraction then
			arg_72_0._skinInteraction:playVoiceFinish(arg_72_1)
		end

		arg_72_0._interactionStartTime = Time.time
		arg_72_0._specialIdleStartTime = Time.time
	end, arg_72_0._txtanacn, arg_72_0._txtanaen, arg_72_0._gocontentbg)

	if arg_72_0._skinInteraction then
		arg_72_0._skinInteraction:afterPlayVoice(arg_72_1)
	end

	arg_72_0:_trackMainHeroInteraction(arg_72_1 and arg_72_1.audio)
end

function var_0_0.onlyPlayVoice(arg_74_0, arg_74_1)
	arg_74_0:_onStopVoice()
	arg_74_0._lightSpine:playVoice(arg_74_1, function()
		arg_74_0._interactionStartTime = Time.time
		arg_74_0._specialIdleStartTime = Time.time
	end, arg_74_0._txtanacn, arg_74_0._txtanaen, arg_74_0._gocontentbg)
end

function var_0_0._enableKeyword(arg_76_0)
	UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = true
end

function var_0_0._disableKeyword(arg_77_0)
	UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = false
end

function var_0_0._onOpenFullView(arg_78_0, arg_78_1)
	if arg_78_1 == ViewName.CharacterSkinTipView then
		arg_78_0:_disableKeyword()
	end
end

function var_0_0._getSwitchViewName(arg_79_0)
	return ViewName.MainSwitchView
end

function var_0_0._onOpenFullViewFinish(arg_80_0, arg_80_1)
	if arg_80_1 ~= arg_80_0:_getSwitchViewName() then
		arg_80_0:_disableKeyword()
	end

	arg_80_0:_hideModelEffect()
	var_0_1:setStateByString("Photo_album", "no")
end

function var_0_0._checkLightSpineVisible(arg_81_0, arg_81_1)
	local var_81_0 = ViewMgr.instance:hasOpenFullView()

	TaskDispatcher.cancelTask(arg_81_0._hideLightSpineVisible, arg_81_0)

	if var_81_0 then
		if arg_81_0._golightspine.activeSelf then
			TaskDispatcher.runDelay(arg_81_0._hideLightSpineVisible, arg_81_0, arg_81_1 or 1)
		end
	else
		gohelper.setActive(arg_81_0._golightspine, true)
	end
end

function var_0_0._hideLightSpineVisible(arg_82_0)
	gohelper.setActive(arg_82_0._golightspine, false)
end

function var_0_0._isViewGOActive(arg_83_0)
	return arg_83_0.viewGO.activeSelf and arg_83_0.viewGO.activeInHierarchy
end

function var_0_0._hasOpenFullView(arg_84_0)
	for iter_84_0, iter_84_1 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		local var_84_0 = ViewMgr.instance:getSetting(iter_84_1)

		if var_84_0 and (var_84_0.viewType == ViewType.Full or var_84_0.bgBlur) then
			return true
		end
	end
end

function var_0_0._activationSettings(arg_85_0)
	arg_85_0:_enableKeyword()
end

function var_0_0._hideModelEffect(arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._showModelEffect, arg_86_0)

	if arg_86_0._lightSpine then
		arg_86_0._lightSpine:setEffectVisible(false)
	end
end

function var_0_0._showModelEffect(arg_87_0)
	if arg_87_0._lightSpine and arg_87_0._showInScene then
		arg_87_0._lightSpine:setEffectVisible(true)
	end
end

function var_0_0._delayShowModelEffect(arg_88_0)
	arg_88_0:_hideModelEffect()
	TaskDispatcher.runDelay(arg_88_0._showModelEffect, arg_88_0, 0.1)
end

function var_0_0._onCloseFullView(arg_89_0, arg_89_1)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		if not ViewMgr.instance:hasOpenFullView() then
			arg_89_0:_delayShowModelEffect()
		end

		return
	end

	if not arg_89_0:_isViewGOActive() then
		return
	end

	if MainSceneSwitchController.instance:isSwitching() then
		return
	end

	if not arg_89_0:_hasOpenFullView() then
		arg_89_0:_activationSettings()

		if arg_89_0._lightSpine then
			arg_89_0._lightSpine:processModelEffect()
		end

		arg_89_0:_delayShowModelEffect()

		local var_89_0 = arg_89_0._showInScene

		if var_89_0 then
			if math.random() < 0.1 then
				var_89_0 = not var_89_0
			end
		elseif math.random() < 0.7 then
			var_89_0 = not var_89_0
		end

		if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
			var_89_0 = true
		end

		if not var_89_0 then
			local var_89_1 = arg_89_0._cameraAnimator

			if var_89_1.runtimeAnimatorController and var_89_1.enabled then
				var_89_0 = true
			end
		end

		if GuideModel.instance:getDoingGuideId() and not GuideController.instance:isForbidGuides() then
			var_89_0 = true
		end

		if arg_89_0._skinInteraction then
			arg_89_0._skinInteraction:onCloseFullView()
		end

		if var_89_0 then
			arg_89_0:_playWelcomeVoice()
			var_0_1:resetWeatherChangeVoiceFlag()
		end

		if var_89_0 == arg_89_0._showInScene then
			var_0_1:setStateByString("Photo_album", var_89_0 and "no" or "yes")

			return
		end

		arg_89_0:_setShowInScene(var_89_0)
	end
end

function var_0_0._setShowInScene(arg_90_0, arg_90_1)
	arg_90_0._showInScene = arg_90_1

	if arg_90_0._showInScene then
		arg_90_0:showInScene()
	else
		arg_90_0:showInFrame()
	end

	MainController.instance:dispatchEvent(MainEvent.HeroShowInScene, arg_90_0._showInScene)
end

function var_0_0.debugShowMode(arg_91_0, arg_91_1)
	arg_91_0:_setShowInScene(arg_91_1)
end

function var_0_0._reOpenWhileOpen(arg_92_0, arg_92_1)
	if ViewMgr.instance:isFull(arg_92_1) then
		arg_92_0:_onOpenFullViewFinish(arg_92_1)
	end
end

function var_0_0._playWelcomeVoice(arg_93_0, arg_93_1)
	if arg_93_0:_hasOpenFullView() then
		return
	end

	if not arg_93_1 and math.random() > 0.3 then
		return false
	end

	local var_93_0 = arg_93_0:_getSpecialInteraction()

	if var_93_0 and (string.splitToNumber(var_93_0.param, "#")[2] or 0) > math.random() * 100 then
		CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Auto)
		arg_93_0:_initSkinInteraction()
		arg_93_0:clickPlayVoice(var_93_0)

		return true
	end

	local var_93_1 = var_0_0.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, arg_93_0._heroId, arg_93_0._skinId)

	if var_93_1 then
		arg_93_0:playVoice(var_93_1)

		return true
	end

	return false
end

function var_0_0.getWelcomeLikeVoice(arg_94_0, arg_94_1, arg_94_2)
	local var_94_0 = WeatherModel.instance:getNowDate()

	var_94_0.hour = 0
	var_94_0.min = 0
	var_94_0.sec = 0

	local var_94_1 = os.time(var_94_0)
	local var_94_2 = os.time()
	local var_94_3 = HeroModel.instance:getVoiceConfig(arg_94_1, arg_94_0, function(arg_95_0)
		local var_95_0 = GameUtil.splitString2(arg_95_0.time, false, "|", "#")

		for iter_95_0, iter_95_1 in ipairs(var_95_0) do
			if var_0_0._checkTime(iter_95_1, var_94_1, var_94_2) then
				return true
			end
		end

		return false
	end, arg_94_2)

	return (var_0_0.getHeightWeight(var_94_3))
end

function var_0_0._checkTime(arg_96_0, arg_96_1, arg_96_2)
	local var_96_0 = string.split(arg_96_0[1], ":")
	local var_96_1 = tonumber(var_96_0[1])
	local var_96_2 = tonumber(var_96_0[2])
	local var_96_3 = tonumber(arg_96_0[2])

	if not var_96_1 or not var_96_2 or not var_96_3 then
		return false
	end

	local var_96_4 = arg_96_1 + (var_96_1 * 60 + var_96_2) * 60
	local var_96_5 = var_96_4 + var_96_3 * 3600

	return var_96_4 <= arg_96_2 and arg_96_2 <= var_96_5
end

function var_0_0._onOpenView(arg_97_0, arg_97_1)
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and arg_97_1 == ViewName.CharacterSwitchView then
		arg_97_0.viewContainer:_setVisible(false)

		return
	end

	local var_97_0 = ViewMgr.instance:getSetting(arg_97_1)

	if var_97_0 and (var_97_0.viewType == ViewType.Full or var_97_0.bgBlur) and arg_97_0._lightSpine then
		arg_97_0:_tryStopVoice()
	end

	if arg_97_1 == ViewName.MainThumbnailView then
		arg_97_0._animator:Play("mainview_out", 0, 0)
		TaskDispatcher.runDelay(arg_97_0._hide, arg_97_0, 0.4)

		if arg_97_0._tweenId then
			ZProj.TweenHelper.KillById(arg_97_0._tweenId)

			arg_97_0._tweenId = nil
		end

		arg_97_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_97_0._setFactor, nil, arg_97_0, nil, EaseType.Linear)

		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		arg_97_0:_tryStopVoice()
	elseif arg_97_1 == ViewName.CharacterGetView or arg_97_1 == ViewName.CharacterSkinGetDetailView then
		if arg_97_0._lightSpine then
			gohelper.setActive(arg_97_0._lightSpine:getSpineGo(), false)
		end
	elseif arg_97_1 == ViewName.SummonView then
		arg_97_0:_hideModelEffect()
	end
end

function var_0_0._tryStopVoice(arg_98_0)
	if not arg_98_0._lightSpine or LimitedRoleController.instance:isPlayingAction() then
		-- block empty
	else
		arg_98_0:_onStopVoice()
	end
end

function var_0_0._forceStopVoice(arg_99_0)
	if arg_99_0._lightSpine then
		arg_99_0:_onStopVoice()
	end
end

function var_0_0._hide(arg_100_0)
	arg_100_0.viewContainer:_setVisible(false)
end

function var_0_0._onCloseView(arg_101_0, arg_101_1)
	if arg_101_1 == ViewName.SettingsView and ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		var_0_0.setPostProcessBlur()

		return
	end

	if arg_101_1 == ViewName.SummonView then
		arg_101_0:_delayShowModelEffect()
	elseif arg_101_1 == ViewName.CharacterView and arg_101_0._lightSpine and arg_101_0._showInScene then
		arg_101_0._lightSpine:setLayer(UnityLayer.Water)
	end

	if arg_101_1 == ViewName.StoryView then
		arg_101_0:_onFinish()
	end

	if not arg_101_0:_hasOpenFullView() then
		arg_101_0:_activationSettings()
	end
end

function var_0_0._onCloseViewFinish(arg_102_0, arg_102_1)
	if arg_102_0:_isLogout() then
		return
	end

	arg_102_0:_setSpineScale()

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and arg_102_1 == ViewName.CharacterSwitchView then
		arg_102_0.viewContainer:_setVisible(true)

		return
	end

	if arg_102_1 == ViewName.MainThumbnailView then
		TaskDispatcher.cancelTask(arg_102_0._hide, arg_102_0)
		arg_102_0.viewContainer:_setVisible(true)
		arg_102_0._animator:Play("mainview_in", 0, 0)

		if arg_102_0._tweenId then
			ZProj.TweenHelper.KillById(arg_102_0._tweenId)

			arg_102_0._tweenId = nil
		end

		arg_102_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, arg_102_0._setFactor, arg_102_0._resetPostProcessValue, arg_102_0, nil, EaseType.Linear)

		local var_102_0, var_102_1 = CharacterSwitchListModel.instance:getMainHero()

		if arg_102_0._curHeroId ~= var_102_0 and var_102_0 or arg_102_0._curSkinId ~= var_102_1 and var_102_1 or gohelper.isNil(arg_102_0._spineGo) then
			arg_102_0._curHeroId = var_102_0
			arg_102_0._curSkinId = var_102_1

			arg_102_0:_updateHero(arg_102_0._curHeroId, arg_102_0._curSkinId)
		elseif arg_102_0._lightSpine then
			local var_102_2 = {
				heroPlayWeatherVoice = true,
				roleGo = arg_102_0._lightSpine:getSpineGo(),
				heroId = arg_102_0._heroId,
				sharedMaterial = arg_102_0._spineMaterial,
				skinId = var_102_1
			}

			var_0_1:changeRoleGo(var_102_2)
			WeatherController.instance:setLightModel(arg_102_0._lightSpine)
		end
	elseif arg_102_1 == ViewName.CharacterGetView or arg_102_1 == ViewName.CharacterSkinGetDetailView then
		if arg_102_0._lightSpine then
			gohelper.setActive(arg_102_0._lightSpine:getSpineGo(), true)
		end
	elseif arg_102_1 == ViewName.CharacterView and arg_102_0._lightSpine and arg_102_0._showInScene then
		arg_102_0._lightSpine:setLayer(UnityLayer.Unit)
	end
end

function var_0_0._setFactor(arg_103_0, arg_103_1)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_103_1)
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

function var_0_0._resetPostProcessValue(arg_106_0)
	if arg_106_0._tweenId then
		ZProj.TweenHelper.KillById(arg_106_0._tweenId)

		arg_106_0._tweenId = nil
	end

	var_0_0.resetPostProcessBlur()
end

function var_0_0._isLogout(arg_107_0)
	return ViewMgr.instance:isOpen(ViewName.LoadingView)
end

function var_0_0.onClose(arg_108_0)
	if arg_108_0._lightSpine then
		arg_108_0._lightSpine:doDestroy()

		arg_108_0._lightSpine = nil
	end

	arg_108_0._click:RemoveClickDownListener()
	arg_108_0._drag:RemoveDragBeginListener()
	arg_108_0._drag:RemoveDragListener()
	arg_108_0._drag:RemoveDragEndListener()

	if arg_108_0._photoFrameBgLoader then
		arg_108_0._photoFrameBgLoader:dispose()

		arg_108_0._photoFrameBgLoader = nil
	end

	var_0_1:setStateByString("Photo_album", "no")

	if arg_108_0._skinInteraction then
		arg_108_0._skinInteraction:onDestroy()
	end

	TaskDispatcher.cancelTask(arg_108_0._hide, arg_108_0)
	TaskDispatcher.cancelTask(arg_108_0._showModelEffect, arg_108_0)
	TaskDispatcher.cancelTask(arg_108_0._hideLightSpineVisible, arg_108_0)
	TaskDispatcher.cancelTask(arg_108_0._setSpineScale, arg_108_0)
	TaskDispatcher.cancelTask(arg_108_0._delayInitLightSpine, arg_108_0)
	arg_108_0:_resetPostProcessValue()
	arg_108_0:_clearEvents()
end

function var_0_0._clearEvents(arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_109_0._onOpenFullViewFinish, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_109_0._onOpenFullView, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_109_0._onCloseFullView, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_109_0._reOpenWhileOpen, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_109_0._onOpenView, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_109_0._onCloseViewFinish, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_109_0._onCloseView, arg_109_0)
	arg_109_0:removeEventCb(StoryController.instance, StoryEvent.Start, arg_109_0._onStart, arg_109_0)
	arg_109_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_109_0._onFinish, arg_109_0)
	arg_109_0:removeEventCb(WeatherController.instance, WeatherEvent.PlayVoice, arg_109_0._onWeatherPlayVoice, arg_109_0)
	arg_109_0:removeEventCb(WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, arg_109_0._onWeatherLoadPhotoFrameBg, arg_109_0)
	arg_109_0:removeEventCb(WeatherController.instance, WeatherEvent.OnRoleBlend, arg_109_0._onWeatherOnRoleBlend, arg_109_0)
	arg_109_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_109_0._onLoadingCloseView, arg_109_0)
	arg_109_0:removeEventCb(MainController.instance, MainEvent.ForceStopVoice, arg_109_0._forceStopVoice, arg_109_0)
	TaskDispatcher.cancelTask(arg_109_0._delayCheckShowMain, arg_109_0)
end

function var_0_0.onCloseFinish(arg_110_0)
	gohelper.destroy(arg_110_0._golightspine)
end

function var_0_0.getMaxTouchHeadNumber(arg_111_0)
	return tonumber(lua_const.configList[32].value)
end

function var_0_0.onDestroyView(arg_112_0)
	arg_112_0:_disableKeyword()
end

function var_0_0._clearTrackMainHeroInteractionData(arg_113_0)
	arg_113_0._track_main_hero_interaction_info = {
		main_hero_interaction_skin_id = false,
		main_hero_interaction_voice_id = false,
		main_hero_interaction_area_id = false
	}
end

function var_0_0._updateTrackInfoSkinId(arg_114_0, arg_114_1)
	arg_114_0._track_main_hero_interaction_info.main_hero_interaction_skin_id = arg_114_1
end

function var_0_0._updateTrackInfoAreaId(arg_115_0, arg_115_1)
	arg_115_0._track_main_hero_interaction_info.main_hero_interaction_area_id = arg_115_1
end

function var_0_0._trackMainHeroInteraction(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_0._track_main_hero_interaction_info

	if not var_116_0.main_hero_interaction_area_id or not var_116_0.main_hero_interaction_skin_id then
		return
	end

	var_116_0.main_hero_interaction_voice_id = tostring(arg_116_1)

	SDKDataTrackMgr.instance:trackMainHeroInteraction(var_116_0)
	arg_116_0:_updateTrackInfoAreaId(nil)
end

return var_0_0
