module("modules.logic.main.view.MainHeroView", package.seeall)

slot0 = class("MainHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._golightspinecontrol = gohelper.findChild(slot0.viewGO, "#go_lightspinecontrol")
	slot0._gospinescale = gohelper.findChild(slot0.viewGO, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_en")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom/#go_contentbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = WeatherController.instance

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._reOpenWhileOpen, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(WeatherController.instance, WeatherEvent.PlayVoice, slot0._onWeatherPlayVoice, slot0)
	slot0:addEventCb(WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, slot0._onWeatherLoadPhotoFrameBg, slot0)
	slot0:addEventCb(WeatherController.instance, WeatherEvent.OnRoleBlend, slot0._onWeatherOnRoleBlend, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnReceiveAddFaithEvent, slot0._onSuccessTouchHead, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnClickSwitchRole, slot0._onClickSwitchRole, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnSceneClose, slot0._onSceneClose, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, slot0._setViewVisible, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.ChangeMainHeroSkin, slot0._changeMainHeroSkin, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnShowMainThumbnailView, slot0._onShowMainThumbnailView, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.SetMainViewRootVisible, slot0._setViewRootVisible, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.ForceStopVoice, slot0._forceStopVoice, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, slot0._onStartSwitchScene, slot0, LuaEventSystem.High)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, slot0._onSwitchSceneFinish, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Start, slot0._onStart, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0._onFinish, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0._onDelayCloseLoading, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onLoadingCloseView, slot0, LuaEventSystem.High)
	slot0:addEventCb(LoginController.instance, LoginEvent.OnBeginLogout, slot0._onBeginLogout, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshMainHeroSkin, slot0._onRefreshMainHeroSkin, slot0)
end

function slot0._onScreenResize(slot0)
	slot0:_repeatSetSpineScale()
end

function slot0._onStart(slot0, slot1)
	if slot0._lightSpine then
		slot0._isSpineCleared = true

		slot0:_onStopVoice()
		slot0._lightSpine:clear()

		slot0._spineGo = nil
		slot0._spineTransform = nil
		slot0._spineMaterial = nil

		WeatherController.instance:clearMat()
	end
end

function slot0._onFinish(slot0, slot1)
	if not slot0._isSpineCleared then
		return
	end

	slot0._isSpineCleared = false
	slot0._storyFinish = true
	slot0._curHeroId, slot0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if slot0._curHeroId and slot0._curSkinId then
		slot0:_updateHero(slot0._curHeroId, slot0._curSkinId)
	end
end

function slot0._onBeginLogout(slot0)
	slot0:_clearEvents()
end

function slot0._onLoadingCloseView(slot0, slot1)
	if slot1 == ViewName.LoadingView then
		if slot0._canvasGroup then
			slot0._canvasGroup.alpha = 1
			slot0._canvasGroup = nil

			slot0._animator:Play("mainview_in", 0, 0)
		end

		slot0:_checkPlayGreetingVoices()
	end
end

function slot0._onDelayCloseLoading(slot0)
	slot1 = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	slot1.alpha = 0
	slot0._canvasGroup = slot1
end

function slot0._onShowMainThumbnailView(slot0)
	gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup)).alpha = 0
end

function slot0._changeMainHeroSkin(slot0, slot1, slot2, slot3)
	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and not ViewMgr.instance:isOpen(ViewName.GMToolView) then
		return
	end

	slot0._changeShowInScene = slot2

	if slot0._lightSpine then
		slot0:_onStopVoice()
	end

	slot0:_updateHero(slot1.characterId, slot1.id, slot3)
end

function slot0._onRefreshMainHeroSkin(slot0)
	slot0._curHeroId, slot0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if slot0._curHeroId and slot0._curSkinId then
		slot0:_updateHero(slot0._curHeroId, slot0._curSkinId)
	end
end

function slot0._onSpineLoaded(slot0)
	if slot0._storyFinish then
		slot0._storyFinish = nil

		slot0:_setShowInScene(true)
	end

	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	slot0:_setShowInScene(slot0._changeShowInScene)
end

function slot0._setViewVisible(slot0, slot1)
	slot0._mainViewVisible = slot1
	slot0._changeTime = Time.realtimeSinceStartup
end

function slot0._onSceneClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
end

function slot0._onClickSwitchRole(slot0)
	slot0:checkSwitchShowInScene()
end

function slot0.checkSwitchShowInScene(slot0)
	if not slot0._showInScene then
		slot0:_setShowInScene(true)

		if slot0._lightSpine then
			slot0._lightSpine:fadeIn()
		end
	end
end

function slot0._onWeatherPlayVoice(slot0, slot1)
	if not PlayerModel.instance:getMainThumbnail() then
		return
	end

	if slot0:isPlayingVoice() or not slot0:isShowInScene() then
		return
	end

	slot1[2] = true

	slot0:playVoice(slot1[1])
end

function slot0._onWeatherLoadPhotoFrameBg(slot0)
	slot0:loadPhotoFrameBg()
end

function slot0._onWeatherOnRoleBlend(slot0, slot1)
	slot0:onRoleBlend(slot1[1], slot1[2])
	slot0:_updateMainColor()
end

function slot0._setViewRootVisible(slot0, slot1)
	if not slot1 and slot0._lightSpine then
		slot0:_onStopVoice()
	end
end

function slot0._updateMainColor(slot0)
	if not slot0._lightSpine then
		return
	end

	if slot0._showInScene then
		slot0._lightSpine:setMainColor(WeatherController.instance:getMainColor())
		slot0._lightSpine:setLumFactor(WeatherEnum.HeroInSceneLumFactor)
	else
		if not WeatherController.instance:getCurLightMode() then
			return
		end

		slot0._lightSpine:setMainColor(WeatherEnum.HeroInFrameColor[slot1])
		slot0._lightSpine:setLumFactor(WeatherEnum.HeroInFrameLumFactor[slot1])
	end
end

function slot0._onStartSwitchScene(slot0)
	if not slot0._showInScene then
		slot0:_setShowInScene(true)
	end
end

function slot0._onSwitchSceneFinish(slot0)
	slot0:_initFrame()
end

function slot0._initFrame(slot0)
	slot0._frameBg = nil
	slot0._frameSpineNode = nil
	slot0._frameBg = uv0:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not slot0._frameBg then
		logError("_initFrame no frameBg")
	end

	if uv0:getSceneNode("s01_obj_a/Anim/Drawing/spine") then
		slot0._frameSpineNode = slot1.transform
	else
		logError("_initFrame no spineMountPoint")
	end

	gohelper.setActive(slot0._frameBg, false)

	slot0._frameBgMaterial = slot0._frameBg:GetComponent(typeof(UnityEngine.Renderer)).sharedMaterial
	slot0._frameSpineNodeX = 3.11
	slot0._frameSpineNodeY = 0.51
	slot0._frameSpineNodeZ = 3.09
	slot0._frameSpineNodeScale = 0.39
end

function slot0._editableInitView(slot0)
	slot0:_clearTrackMainHeroInteractionData()
	slot0:_enableKeyword()

	slot0._skinInteraction = nil
	slot0._curHeroId, slot0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if slot0._curHeroId and slot0._curSkinId then
		slot0:_updateHero(slot0._curHeroId, slot0._curSkinId)
	end

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._golightspinecontrol)

	slot0._click:AddClickDownListener(slot0._clickDown, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._golightspinecontrol)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)

	slot0._showInScene = true

	slot0:_initFrame()

	slot0._TintColorId = UnityEngine.Shader.PropertyToID("_TintColor")

	slot0:_repeatSetSpineScale()
end

function slot0._setSpineScale(slot0)
	uv0.setSpineScale(slot0._gospinescale)
end

function slot0._repeatSetSpineScale(slot0)
	slot0:_setSpineScale()
	TaskDispatcher.cancelTask(slot0._setSpineScale, slot0)
	TaskDispatcher.runRepeat(slot0._setSpineScale, slot0, 0.1, 5)
end

function slot0.setSpineScale(slot0)
	slot1 = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(slot0.transform, slot1, slot1, slot1)
end

function slot0.showInScene(slot0)
	if not slot0._spineMaterial then
		return
	end

	slot0._lightSpine:setEffectFrameVisible(true)
	slot0:_setStencil(true)

	slot0._spineTransform.parent = slot0._golightspine.transform

	transformhelper.setLocalScale(slot0._spineTransform, 1, 1, 1)
	transformhelper.setLocalPos(slot0._spineTransform, 0, 0, 0)
	transformhelper.setLocalRotation(slot0._spineGo.transform, 0, 0, 0)
	gohelper.setLayer(slot0._spineGo, UnityLayer.Unit, true)
	gohelper.setActive(slot0._frameBg, false)
	uv0:setRoleMaskEnabled(true)
	uv0:setStateByString("Photo_album", "no")
	slot0:_updateMainColor()
end

function slot0.showInFrame(slot0)
	if not slot0._spineMaterial then
		return
	end

	slot0._lightSpine:setEffectFrameVisible(false)
	slot0:_setStencil(false)
	transformhelper.setLocalScale(slot0._frameSpineNode, 1, 1, 1)
	transformhelper.setLocalPos(slot0._frameSpineNode, 0, 0, 0)

	slot0._spineTransform.parent = slot0._frameSpineNode
	slot1 = transformhelper.getLocalScale(slot0._spineTransform)

	transformhelper.setLocalScale(slot0._spineTransform, slot1, slot1, slot1)
	transformhelper.setLocalRotation(slot0._spineTransform, 0, 0, 0)

	slot2 = slot0._frameSpineNodeX
	slot3 = slot0._frameSpineNodeY
	slot4 = slot0._frameSpineNodeScale

	if not string.nilorempty(slot0._heroSkinConfig.mainViewFrameOffset) then
		slot5 = SkinConfig.instance:getSkinOffset(slot0._heroSkinConfig.mainViewFrameOffset)
		slot4 = slot5[3]

		if MainSceneSwitchModel.instance:getCurSceneId() and lua_scene_settings.configDict[slot6] then
			slot2 = slot5[1] + slot7.spineOffset[1]
			slot3 = slot5[2] + slot7.spineOffset[2]
		end
	end

	transformhelper.setLocalScale(slot0._frameSpineNode, slot4, slot4, slot4)
	transformhelper.setLocalPos(slot0._frameSpineNode, slot2, slot3, slot0._frameSpineNodeZ)
	gohelper.setLayer(slot0._spineGo, UnityLayer.Scene, true)

	if not slot0:loadPhotoFrameBg() then
		gohelper.setActive(slot0._frameBg, true)
	end

	uv0:setRoleMaskEnabled(false)
	uv0:setStateByString("Photo_album", "yes")
	slot0:_updateMainColor()
end

function slot0.loadPhotoFrameBg(slot0)
	if slot0._showInScene then
		return false
	end

	if slot0._curLightMode then
		return false
	end

	if not uv0:getCurLightMode() or slot0._curLightMode == slot1 then
		return false
	end

	slot0._curLightMode = slot1

	if slot0._photoFrameBgLoader then
		slot0._photoFrameBgLoader:dispose()

		slot0._photoFrameBgLoader = nil
	end

	slot2 = MultiAbLoader.New()
	slot0._photoFrameBgLoader = slot2

	slot2:addPath(string.format("scenes/dynamic/m_s01_zjm_a/lightmaps/m_s01_back_a_%s.tga", 0))
	slot2:startLoad(function ()
		uv2._frameBgMaterial:SetTexture("_MainTex", uv0:getAssetItem(uv1):GetResource(uv1))
		gohelper.setActive(uv2._frameBg, true)
	end)

	return true
end

function slot0.onRoleBlend(slot0, slot1, slot2)
	if not slot0._targetFrameTintColor then
		slot3 = uv0:getCurLightMode()
		slot4 = uv0:getPrevLightMode() or slot3

		if not slot3 then
			return
		end

		slot5 = WeatherEnum.FrameTintColor[slot3]
		slot0._targetFrameTintColor = Color.New(slot5[1], slot5[2], slot5[3], slot5[4])
		slot6 = WeatherEnum.FrameTintColor[slot4]
		slot0._srcFrameTintColor = Color.New(slot6[1], slot6[2], slot6[3], slot6[4])

		slot0._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	slot0._frameBgMaterial:SetColor(slot0._TintColorId, uv0:lerpColorRGBA(slot0._srcFrameTintColor, slot0._targetFrameTintColor, slot1))

	if slot2 then
		slot0._targetFrameTintColor = nil

		if uv0:getCurLightMode() == 1 then
			slot0._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function slot0._updateHero(slot0, slot1, slot2, slot3)
	slot0._anchorMinPos = nil
	slot0._anchorMaxPos = nil
	slot0._heroId = slot1
	slot0._skinId = slot2
	slot4 = HeroConfig.instance:getHeroCO(slot0._heroId)

	if not SkinConfig.instance:getSkinCo(slot0._skinId or slot4 and slot4.skin) then
		slot0:_updateTrackInfoSkinId(nil)

		return
	end

	slot0._heroPhotoFrameBg = slot4.photoFrameBg
	slot0._heroSkinConfig = slot5
	slot0._heroSkinTriggerArea = {}

	slot0:_updateTrackInfoSkinId(slot5.id)

	if not slot3 then
		slot6 = SkinConfig.instance:getSkinOffset(slot5.mainViewOffset)
		slot7 = slot0._golightspine.transform

		recthelper.setAnchor(slot7, tonumber(slot6[1]), tonumber(slot6[2]))

		slot7.localScale = Vector3.one * tonumber(slot6[3])
	end

	if not slot0._lightSpine then
		slot0._lightSpine = LightModelAgent.Create(slot0._golightspine, true)
	end

	if not string.nilorempty(slot5.defaultStencilValue) then
		slot0._defaultStencilValue = string.splitToNumber(slot5.defaultStencilValue, "#")
	else
		slot0._defaultStencilValue = nil
	end

	if not string.nilorempty(slot5.frameStencilValue) then
		slot0._frameStencilValue = string.splitToNumber(slot5.frameStencilValue, "#")
	else
		slot0._frameStencilValue = nil
	end

	slot0._lightSpine:setResPath(slot5, slot0._onLightSpineLoaded, slot0)
	slot0._lightSpine:setInMainView()
end

function slot0._setStencil(slot0, slot1)
	if slot1 then
		if slot0._defaultStencilValue then
			slot0._lightSpine:setStencilValues(slot0._defaultStencilValue[1], slot0._defaultStencilValue[2], slot0._defaultStencilValue[3])
		else
			slot0._lightSpine:setStencilRef(0)
		end
	elseif slot0._frameStencilValue then
		slot0._lightSpine:setStencilValues(slot0._frameStencilValue[1], slot0._frameStencilValue[2], slot0._frameStencilValue[3])
	else
		slot0._lightSpine:setStencilRef(1)
	end
end

function slot0._checkPlayGreetingVoices(slot0)
	if LimitedRoleController.instance:isPlaying() then
		return
	end

	if slot0._needPlayGreeting and not ViewMgr.instance:isOpen(ViewName.LoadingView) then
		slot0:_playGreetingVoices()
	end
end

function slot0._playGreetingVoices(slot0)
	if HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.Greeting, nil, slot0._skinId) and #slot1 > 0 then
		slot0:_onWeatherPlayVoice({
			slot1[1]
		})
	end
end

function slot0._onLightSpineLoaded(slot0)
	TaskDispatcher.cancelTask(slot0._delayInitLightSpine, slot0)
	TaskDispatcher.runDelay(slot0._delayInitLightSpine, slot0, 0.1)
end

function slot0._delayInitLightSpine(slot0)
	slot0._spineGo = slot0._lightSpine:getSpineGo()

	if gohelper.isNil(slot0._spineGo) then
		return
	end

	slot0._spineTransform = slot0._spineGo.transform
	slot0._spineMaterial = slot0._lightSpine:getRenderer().sharedMaterial

	slot0:_setStencil(true)
	WeatherController.instance:setLightModel(slot0._lightSpine)

	if not slot0._firstLoadSpine then
		slot0._firstLoadSpine = true

		if PlayerModel.instance:getMainThumbnail() then
			-- Nothing
		end

		slot3 = not ViewMgr.instance:hasOpenFullView()

		if MainController.instance.firstEnterMainScene then
			MainController.instance.firstEnterMainScene = false
			slot3 = false

			if not slot2 then
				slot0._needPlayGreeting = true

				slot0:_checkPlayGreetingVoices()
			end
		end

		uv0:initRoleGo(slot0._spineGo, slot0._heroId, slot0._spineMaterial, slot3, slot0._skinId)
	else
		uv0:changeRoleGo({
			heroPlayWeatherVoice = true,
			roleGo = slot0._lightSpine:getSpineGo(),
			heroId = slot0._heroId,
			sharedMaterial = slot0._spineMaterial,
			skinId = slot0._skinId
		})
	end

	slot0.viewContainer:getNoInteractiveComp():init()
	slot0:_onSpineLoaded()
end

function slot0.isPlayingVoice(slot0)
	if not slot0._lightSpine then
		return false
	end

	if slot0._skinInteraction and slot0._skinInteraction:isPlayingVoice() then
		return true
	end

	return slot0._lightSpine:isPlayingVoice()
end

function slot0.getLightSpine(slot0)
	return slot0._lightSpine
end

function slot0.isShowInScene(slot0)
	return slot0._showInScene
end

function slot0._checkSpecialTouch(slot0, slot1, slot2)
	if not slot0._heroSkinTriggerArea["triggerArea" .. slot1.param] then
		slot0._heroSkinTriggerArea[slot3] = {}

		for slot10, slot11 in ipairs(string.split(slot0._heroSkinConfig[slot3], "_")) do
			if #string.split(slot11, "|") == 2 then
				slot13 = string.split(slot12[1], "#")
				slot14 = string.split(slot12[2], "#")

				table.insert(slot4, {
					tonumber(slot13[1]),
					tonumber(slot13[2]),
					tonumber(slot14[1]),
					tonumber(slot14[2])
				})
			end
		end
	end

	for slot8, slot9 in ipairs(slot4) do
		if slot2 and tonumber(slot9[1]) <= slot2.x and slot2.x <= tonumber(slot9[3]) and slot2.y <= tonumber(slot9[2]) and tonumber(slot9[4]) <= slot2.y then
			slot0:_updateTrackInfoAreaId(tonumber(slot1.param))

			return true
		end
	end

	return false
end

function slot0._onTouch(slot0)
	if not LimitedRoleController.instance:isPlaying() and slot0._mainViewVisible == false and Time.realtimeSinceStartup - slot0._changeTime > 0.5 then
		TaskDispatcher.runDelay(slot0._delayCheckShowMain, slot0, 0.01)
	end
end

function slot0._delayCheckShowMain(slot0)
	if not LimitedRoleController.instance:isPlaying() and slot0._mainViewVisible == false and Time.realtimeSinceStartup - slot0._changeTime > 0.5 then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_display)
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0._skinInteraction and slot0._skinInteraction:needRespond() then
		slot0._dragSpecialRespond = slot0:_getDragSpecialRespond(CharacterEnum.VoiceType.MainViewDragSpecialRespond)

		if not slot0._dragSpecialRespond then
			return
		end

		slot0:_checkSpecialTouch(slot0._dragSpecialRespond)

		slot0._dragArea = slot0._heroSkinTriggerArea["triggerArea" .. slot0._dragSpecialRespond.param][1]
		slot6 = string.split(slot0._dragSpecialRespond.param2, "#")
		slot0._dragParamName = slot6[1]
		slot0._dragParamMinValue = tonumber(slot6[2])
		slot0._dragParamMaxValue = tonumber(slot6[3])
		slot0._dragParamLength = slot0._dragParamMaxValue - slot0._dragParamMinValue
		slot0._dragParamIndex = slot0._lightSpine:addParameter(slot0._dragParamName, 0, slot0._dragParamMinValue)

		slot0._skinInteraction:beginDrag()
		AudioMgr.instance:trigger(AudioEnum.UI.hero3100_mainsfx_mic_drag)
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._dragSpecialRespond then
		return
	end

	slot4 = slot0._dragArea[1]
	slot6 = slot0._dragArea[3]

	if recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._golightspinecontrol.transform) and slot4 <= slot3.x and slot3.x <= slot6 and slot3.y <= slot0._dragArea[2] and slot0._dragArea[4] <= slot3.y then
		slot10 = slot0._dragParamMinValue + (slot3.x - slot4) / (slot6 - slot4) * slot0._dragParamLength

		slot0._lightSpine:updateParameter(slot0._dragParamIndex, slot10)

		if slot10 >= slot0._dragParamMaxValue - 5 then
			slot0:_onDragEnd(slot1, slot2)
			slot0:clickPlayVoice(slot0._dragSpecialRespond)
		end
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._dragParamName then
		slot0._lightSpine:removeParameter(slot0._dragParamName)

		slot0._dragParamName = nil
	end

	if slot0._dragSpecialRespond and slot0._skinInteraction then
		slot0._skinInteraction:endDrag()
	end

	slot0._dragSpecialRespond = nil
end

function slot0._clickDown(slot0)
	if slot0._mainViewVisible == false then
		return
	end

	MainController.instance:dispatchEvent(MainEvent.ClickDown)

	if not slot0._showInScene then
		return
	end

	if gohelper.isNil(slot0._spineGo) then
		return
	end

	slot0:_initSkinInteraction()
	slot0._skinInteraction:onClick(recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._golightspinecontrol.transform))
end

function slot0._initSkinInteraction(slot0)
	if slot0._skinInteraction and slot1:getSkinId() ~= slot0._skinId then
		slot1:onDestroy()

		slot0._skinInteraction = nil
	end

	if not slot0._skinInteraction then
		slot0._skinInteraction = slot0:getSkinInteraction(slot0._skinId)

		slot0._skinInteraction:init(slot0, slot0._skinId)
	end
end

function slot0.getSkinInteraction(slot0, slot1)
	if slot1 == 303301 or slot1 == 303302 then
		return TTTSkinInteraction.New()
	end

	return CommonSkinInteraction.New()
end

function slot0._clickDefault(slot0, slot1)
	slot0:_updateTrackInfoAreaId(nil)

	if slot0:_getSpecialInteraction() and slot0:_checkPosInBound(slot1) and slot0._skinInteraction:canPlay(slot2) and math.random() * 100 < string.splitToNumber(slot2.param, "#")[1] then
		CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Click)
		slot0:clickPlayVoice(slot2)

		return
	end

	if slot0._skinInteraction:needRespond() then
		if slot0:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialRespond, slot1) then
			slot0:clickPlayVoice(slot3)
		end

		return
	end

	if slot0:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialTouch, slot1) and math.random() > 0.5 and slot0._skinInteraction:canPlay(slot3) then
		slot0:clickPlayVoice(slot3)

		return
	end

	if slot0:_getNormalTouch(slot1) and slot0._skinInteraction:canPlay(slot4) then
		slot0:clickPlayVoice(slot4)
		slot0:addFaith()
	end
end

function slot0._getSpecialInteraction(slot0, slot1)
	if HeroModel.instance:getVoiceConfig(slot0._heroId, slot1 or CharacterEnum.VoiceType.MainViewSpecialInteraction, function (slot0)
		return uv0._clickPlayConfig ~= slot0
	end, slot0._skinId) and #slot2 > 0 then
		return slot2[1]
	end
end

function slot0._getDragSpecialRespond(slot0, slot1)
	if HeroModel.instance:getVoiceConfig(slot0._heroId, slot1 or CharacterEnum.VoiceType.MainViewSpecialInteraction, function (slot0)
		return uv0._clickPlayConfig ~= slot0 and not string.nilorempty(slot0.param2)
	end, slot0._skinId) and #slot2 > 0 then
		return slot2[1]
	end
end

function slot0._getSpecialTouch(slot0, slot1, slot2)
	if HeroModel.instance:getVoiceConfig(slot0._heroId, slot1, function (slot0)
		return uv0._clickPlayConfig ~= slot0 and uv0:_checkSpecialTouch(slot0, uv1)
	end, slot0._skinId) and #slot3 > 0 then
		return slot3[1]
	end
end

function slot0._getNormalTouch(slot0, slot1)
	if slot0:_checkPosInBound(slot1) then
		return uv0.getHeightWeight(HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function (slot0)
			return uv0._clickPlayConfig ~= slot0
		end, slot0._skinId))
	end
end

function slot0._checkPosInBound(slot0, slot1)
	if not slot0._anchorMinPos or not slot0._anchorMaxPos then
		slot2, slot3 = slot0._lightSpine:getBoundsMinMaxPos()
		slot0._anchorMinPos = recthelper.worldPosToAnchorPos(Vector3(slot2.x, slot3.y, slot2.z), slot0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
		slot0._anchorMaxPos = recthelper.worldPosToAnchorPos(Vector3(slot3.x, slot2.y, slot3.z), slot0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
	end

	slot3 = slot0._anchorMaxPos

	if slot0._anchorMinPos.x <= slot1.x and slot1.x <= slot3.x and slot1.y <= slot2.y and slot3.y <= slot1.y then
		return true
	end
end

function slot0.addFaith(slot0)
	if HeroModel.instance:getTouchHeadNumber() <= 0 then
		return
	end

	HeroRpc.instance:sendTouchHeadRequest(slot0._heroId)
end

function slot0._onSuccessTouchHead(slot0, slot1)
	if slot1 then
		GameFacade.showToast(ToastEnum.MainHeroAddSuccess)
	else
		GameFacade.showToast(ToastEnum.MainHeroAddFail)
	end
end

function slot0.getHeightWeight(slot0)
	if slot0 and #slot0 > 0 then
		for slot5, slot6 in ipairs(slot0) do
			slot1 = 0 + slot6.param
		end

		for slot7, slot8 in ipairs(slot0) do
			if math.random() <= (0 + slot8.param) / slot1 then
				return slot8
			end
		end
	end

	return nil
end

function slot0.clickPlayVoice(slot0, slot1)
	slot0._clickPlayConfig = slot1

	slot0:playVoice(slot1)
end

function slot0._onStopVoice(slot0)
	slot0._lightSpine:stopVoice()

	if slot0._skinInteraction then
		slot0._skinInteraction:onStopVoice()
	end
end

function slot0.playVoice(slot0, slot1)
	if not slot0._lightSpine then
		return
	end

	if slot0._skinInteraction then
		slot0._skinInteraction:beforePlayVoice(slot1)
	end

	slot0:_onStopVoice()

	if slot0._skinInteraction then
		slot0._skinInteraction:onPlayVoice(slot1)
	end

	slot0._lightSpine:playVoice(slot1, function ()
		if uv0._skinInteraction then
			uv0._skinInteraction:playVoiceFinish(uv1)
		end

		uv0._interactionStartTime = Time.time
		uv0._specialIdleStartTime = Time.time
	end, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)

	if slot0._skinInteraction then
		slot0._skinInteraction:afterPlayVoice(slot1)
	end

	slot0:_trackMainHeroInteraction(slot1 and slot1.audio)
end

function slot0.onlyPlayVoice(slot0, slot1)
	slot0:_onStopVoice()
	slot0._lightSpine:playVoice(slot1, function ()
		uv0._interactionStartTime = Time.time
		uv0._specialIdleStartTime = Time.time
	end, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0._enableKeyword(slot0)
	UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = true
end

function slot0._disableKeyword(slot0)
	UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = false
end

function slot0._onOpenFullView(slot0, slot1)
	if slot1 == ViewName.CharacterSkinTipView then
		slot0:_disableKeyword()
	end
end

function slot0._getSwitchViewName(slot0)
	return ViewName.MainSwitchView
end

function slot0._onOpenFullViewFinish(slot0, slot1)
	if slot1 ~= slot0:_getSwitchViewName() then
		slot0:_disableKeyword()
	end

	slot0:_hideModelEffect()
	uv0:setStateByString("Photo_album", "no")
end

function slot0._checkLightSpineVisible(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._hideLightSpineVisible, slot0)

	if ViewMgr.instance:hasOpenFullView() then
		if slot0._golightspine.activeSelf then
			TaskDispatcher.runDelay(slot0._hideLightSpineVisible, slot0, slot1 or 1)
		end
	else
		gohelper.setActive(slot0._golightspine, true)
	end
end

function slot0._hideLightSpineVisible(slot0)
	gohelper.setActive(slot0._golightspine, false)
end

function slot0._isViewGOActive(slot0)
	return slot0.viewGO.activeSelf and slot0.viewGO.activeInHierarchy
end

function slot0._hasOpenFullView(slot0)
	for slot4, slot5 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if ViewMgr.instance:getSetting(slot5) and (slot6.viewType == ViewType.Full or slot6.bgBlur) then
			return true
		end
	end
end

function slot0._activationSettings(slot0)
	slot0:_enableKeyword()
end

function slot0._hideModelEffect(slot0)
	TaskDispatcher.cancelTask(slot0._showModelEffect, slot0)

	if slot0._lightSpine then
		slot0._lightSpine:setEffectVisible(false)
	end
end

function slot0._showModelEffect(slot0)
	if slot0._lightSpine and slot0._showInScene then
		slot0._lightSpine:setEffectVisible(true)
	end
end

function slot0._delayShowModelEffect(slot0)
	slot0:_hideModelEffect()
	TaskDispatcher.runDelay(slot0._showModelEffect, slot0, 0.1)
end

function slot0._onCloseFullView(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		if not ViewMgr.instance:hasOpenFullView() then
			slot0:_delayShowModelEffect()
		end

		return
	end

	if not slot0:_isViewGOActive() then
		return
	end

	if MainSceneSwitchController.instance:isSwitching() then
		return
	end

	if not slot0:_hasOpenFullView() then
		slot0:_activationSettings()

		if slot0._lightSpine then
			slot0._lightSpine:processModelEffect()
		end

		slot0:_delayShowModelEffect()

		if slot0._showInScene then
			if math.random() < 0.1 then
				slot2 = not slot2
			end
		elseif math.random() < 0.7 then
			slot2 = not slot2
		end

		if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
			slot2 = true
		end

		if not slot2 and slot0._cameraAnimator.runtimeAnimatorController and slot3.enabled then
			slot2 = true
		end

		if GuideModel.instance:getDoingGuideId() and not GuideController.instance:isForbidGuides() then
			slot2 = true
		end

		if slot0._skinInteraction then
			slot0._skinInteraction:onCloseFullView()
		end

		if slot2 then
			slot0:_playWelcomeVoice()
			uv0:resetWeatherChangeVoiceFlag()
		end

		if slot2 == slot0._showInScene then
			uv0:setStateByString("Photo_album", slot2 and "no" or "yes")

			return
		end

		slot0:_setShowInScene(slot2)
	end
end

function slot0._setShowInScene(slot0, slot1)
	slot0._showInScene = slot1

	if slot0._showInScene then
		slot0:showInScene()
	else
		slot0:showInFrame()
	end

	MainController.instance:dispatchEvent(MainEvent.HeroShowInScene, slot0._showInScene)
end

function slot0.debugShowMode(slot0, slot1)
	slot0:_setShowInScene(slot1)
end

function slot0._reOpenWhileOpen(slot0, slot1)
	if ViewMgr.instance:isFull(slot1) then
		slot0:_onOpenFullViewFinish(slot1)
	end
end

function slot0._playWelcomeVoice(slot0, slot1)
	if slot0:_hasOpenFullView() then
		return
	end

	if not slot1 and math.random() > 0.3 then
		return false
	end

	if slot0:_getSpecialInteraction() and (string.splitToNumber(slot2.param, "#")[2] or 0) > math.random() * 100 then
		CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Auto)
		slot0:_initSkinInteraction()
		slot0:clickPlayVoice(slot2)

		return true
	end

	if uv0.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, slot0._heroId, slot0._skinId) then
		slot0:playVoice(slot3)

		return true
	end

	return false
end

function slot0.getWelcomeLikeVoice(slot0, slot1, slot2)
	slot3 = WeatherModel.instance:getNowDate()
	slot3.hour = 0
	slot3.min = 0
	slot3.sec = 0
	slot4 = os.time(slot3)
	slot5 = os.time()

	return uv0.getHeightWeight(HeroModel.instance:getVoiceConfig(slot1, slot0, function (slot0)
		slot5 = "#"

		for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.time, false, "|", slot5)) do
			if uv0._checkTime(slot6, uv1, uv2) then
				return true
			end
		end

		return false
	end, slot2))
end

function slot0._checkTime(slot0, slot1, slot2)
	slot3 = string.split(slot0[1], ":")
	slot5 = tonumber(slot3[2])
	slot6 = tonumber(slot0[2])

	if not tonumber(slot3[1]) or not slot5 or not slot6 then
		return false
	end

	slot7 = slot1 + (slot4 * 60 + slot5) * 60

	return slot7 <= slot2 and slot2 <= slot7 + slot6 * 3600
end

function slot0._onOpenView(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and slot1 == ViewName.CharacterSwitchView then
		slot0.viewContainer:_setVisible(false)

		return
	end

	if ViewMgr.instance:getSetting(slot1) and (slot2.viewType == ViewType.Full or slot2.bgBlur) and slot0._lightSpine then
		slot0:_tryStopVoice()
	end

	if slot1 == ViewName.MainThumbnailView then
		slot0._animator:Play("mainview_out", 0, 0)
		TaskDispatcher.runDelay(slot0._hide, slot0, 0.4)

		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)

			slot0._tweenId = nil
		end

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0._setFactor, nil, slot0, nil, EaseType.Linear)

		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		slot0:_tryStopVoice()
	elseif slot1 == ViewName.CharacterGetView or slot1 == ViewName.CharacterSkinGetDetailView then
		if slot0._lightSpine then
			gohelper.setActive(slot0._lightSpine:getSpineGo(), false)
		end
	elseif slot1 == ViewName.SummonView then
		slot0:_hideModelEffect()
	end
end

function slot0._tryStopVoice(slot0)
	if slot0._lightSpine then
		if not LimitedRoleController.instance:isPlayingAction() then
			slot0:_onStopVoice()
		end
	end
end

function slot0._forceStopVoice(slot0)
	if slot0._lightSpine then
		slot0:_onStopVoice()
	end
end

function slot0._hide(slot0)
	slot0.viewContainer:_setVisible(false)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.SettingsView and ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		uv0.setPostProcessBlur()

		return
	end

	if slot1 == ViewName.SummonView then
		slot0:_delayShowModelEffect()
	elseif slot1 == ViewName.CharacterView and slot0._lightSpine and slot0._showInScene then
		slot0._lightSpine:setLayer(UnityLayer.Water)
	end

	if slot1 == ViewName.StoryView then
		slot0:_onFinish()
	end

	if not slot0:_hasOpenFullView() then
		slot0:_activationSettings()
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot0:_isLogout() then
		return
	end

	slot0:_setSpineScale()

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and slot1 == ViewName.CharacterSwitchView then
		slot0.viewContainer:_setVisible(true)

		return
	end

	if slot1 == ViewName.MainThumbnailView then
		TaskDispatcher.cancelTask(slot0._hide, slot0)
		slot0.viewContainer:_setVisible(true)
		slot0._animator:Play("mainview_in", 0, 0)

		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)

			slot0._tweenId = nil
		end

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, slot0._setFactor, slot0._resetPostProcessValue, slot0, nil, EaseType.Linear)
		slot2, slot3 = CharacterSwitchListModel.instance:getMainHero()

		if slot0._curHeroId ~= slot2 and slot2 or slot0._curSkinId ~= slot3 and slot3 or gohelper.isNil(slot0._spineGo) then
			slot0._curHeroId = slot2
			slot0._curSkinId = slot3

			slot0:_updateHero(slot0._curHeroId, slot0._curSkinId)
		elseif slot0._lightSpine then
			uv0:changeRoleGo({
				heroPlayWeatherVoice = true,
				roleGo = slot0._lightSpine:getSpineGo(),
				heroId = slot0._heroId,
				sharedMaterial = slot0._spineMaterial,
				skinId = slot3
			})
			WeatherController.instance:setLightModel(slot0._lightSpine)
		end
	elseif slot1 == ViewName.CharacterGetView or slot1 == ViewName.CharacterSkinGetDetailView then
		if slot0._lightSpine then
			gohelper.setActive(slot0._lightSpine:getSpineGo(), true)
		end
	elseif slot1 == ViewName.CharacterView and slot0._lightSpine and slot0._showInScene then
		slot0._lightSpine:setLayer(UnityLayer.Unit)
	end
end

function slot0._setFactor(slot0, slot1)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", slot1)
end

function slot0.setPostProcessBlur()
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", 1)
	PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
	PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
end

function slot0.resetPostProcessBlur()
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4(7.18, 0.77, 3.26, 1))
	PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 3)
end

function slot0._resetPostProcessValue(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	uv0.resetPostProcessBlur()
end

function slot0._isLogout(slot0)
	return ViewMgr.instance:isOpen(ViewName.LoadingView)
end

function slot0.onClose(slot0)
	if slot0._lightSpine then
		slot0._lightSpine:doDestroy()

		slot0._lightSpine = nil
	end

	slot0._click:RemoveClickDownListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()

	if slot0._photoFrameBgLoader then
		slot0._photoFrameBgLoader:dispose()

		slot0._photoFrameBgLoader = nil
	end

	uv0:setStateByString("Photo_album", "no")

	if slot0._skinInteraction then
		slot0._skinInteraction:onDestroy()
	end

	TaskDispatcher.cancelTask(slot0._hide, slot0)
	TaskDispatcher.cancelTask(slot0._showModelEffect, slot0)
	TaskDispatcher.cancelTask(slot0._hideLightSpineVisible, slot0)
	TaskDispatcher.cancelTask(slot0._setSpineScale, slot0)
	TaskDispatcher.cancelTask(slot0._delayInitLightSpine, slot0)
	slot0:_resetPostProcessValue()
	slot0:_clearEvents()
end

function slot0._clearEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._reOpenWhileOpen, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Start, slot0._onStart, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Finish, slot0._onFinish, slot0)
	slot0:removeEventCb(WeatherController.instance, WeatherEvent.PlayVoice, slot0._onWeatherPlayVoice, slot0)
	slot0:removeEventCb(WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, slot0._onWeatherLoadPhotoFrameBg, slot0)
	slot0:removeEventCb(WeatherController.instance, WeatherEvent.OnRoleBlend, slot0._onWeatherOnRoleBlend, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onLoadingCloseView, slot0)
	slot0:removeEventCb(MainController.instance, MainEvent.ForceStopVoice, slot0._forceStopVoice, slot0)
	TaskDispatcher.cancelTask(slot0._delayCheckShowMain, slot0)
end

function slot0.onCloseFinish(slot0)
	gohelper.destroy(slot0._golightspine)
end

function slot0.getMaxTouchHeadNumber(slot0)
	return tonumber(lua_const.configList[32].value)
end

function slot0.onDestroyView(slot0)
	slot0:_disableKeyword()
end

function slot0._clearTrackMainHeroInteractionData(slot0)
	slot0._track_main_hero_interaction_info = {
		main_hero_interaction_skin_id = false,
		main_hero_interaction_voice_id = false,
		main_hero_interaction_area_id = false
	}
end

function slot0._updateTrackInfoSkinId(slot0, slot1)
	slot0._track_main_hero_interaction_info.main_hero_interaction_skin_id = slot1
end

function slot0._updateTrackInfoAreaId(slot0, slot1)
	slot0._track_main_hero_interaction_info.main_hero_interaction_area_id = slot1
end

function slot0._trackMainHeroInteraction(slot0, slot1)
	if not slot0._track_main_hero_interaction_info.main_hero_interaction_area_id or not slot2.main_hero_interaction_skin_id then
		return
	end

	slot2.main_hero_interaction_voice_id = tostring(slot1)

	SDKDataTrackMgr.instance:trackMainHeroInteraction(slot2)
	slot0:_updateTrackInfoAreaId(nil)
end

return slot0
