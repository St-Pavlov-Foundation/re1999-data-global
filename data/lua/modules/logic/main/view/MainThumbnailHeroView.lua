module("modules.logic.main.view.MainThumbnailHeroView", package.seeall)

slot0 = class("MainThumbnailHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._golightspinecontrol = gohelper.findChild(slot0.viewGO, "#go_lightspinecontrol")
	slot0._gospinescale = gohelper.findChild(slot0.viewGO, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_en")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom/#go_contentbg")
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_block")
	slot0._goswitch = gohelper.findChild(slot0.viewGO, "#btn_switch")
	slot0._goswitchreddot = gohelper.findChild(slot0.viewGO, "#btn_switch/switchreddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
end

slot1 = ZProj.TweenHelper

function slot0._btnblockOnClick(slot0)
	if slot0._lightSpine then
		slot0._lightSpine:stopVoice()
	end

	slot0:_greetingFinish()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._reOpenWhileOpen, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnSceneClose, slot0._onSceneClose, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	NavigateMgr.instance:addEscape(ViewName.MainThumbnailView, slot0._onEscBtnClick, slot0)
	slot0.viewContainer:getThumbnailNav():setCloseCheck(slot0._navCloseCheck, slot0)
	slot0:_initGreeting()
	slot0:_initCamera()
	slot0:_initCapture()
	gohelper.setActive(slot0._goswitchreddot, false)

	if slot0:_checkShowRedDot() then
		gohelper.setActive(slot0._goswitch, false)
	end

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._viewPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0._viewPlayer:Play(slot0._needPlayGreeting and "open1" or "open2", slot0._onViewAnimDone, slot0)

	slot0._curHeroId, slot0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if slot0._curHeroId and slot0._curSkinId then
		slot0:_updateHero(slot0._curHeroId, slot0._curSkinId)
	end

	slot0:_startForceUpdateCameraPos()
	slot0._cameraPlayer:Play(slot0._needPlayGreeting and "ani01" or "ani03", slot0._cameraInitAnimDone, slot0)

	if not PlayerModel.instance:getMainThumbnail() then
		PlayerRpc.instance:sendMarkMainThumbnailRequest()
	end
end

function slot0._onScreenResize(slot0)
	uv0.setSpineScale(slot0._gospinescale)
end

function slot0._cameraInitAnimDone(slot0)
	slot0:_removeForceUpdateCameraPos()

	if slot0._needPlayGreeting then
		slot0._needPlayGreeting = false

		slot0:_playGreetingVoices()
	else
		slot0:_showRedDot()
	end
end

function slot0._initGreeting(slot0)
	slot0._needPlayGreeting = slot0.viewParam and slot0.viewParam.needPlayGreeting

	gohelper.setActive(slot0._btnblock.gameObject, slot0._needPlayGreeting)

	if slot0._needPlayGreeting then
		gohelper.setActive(slot0._goswitch, false)
		TaskDispatcher.runDelay(slot0._greetingFinish, slot0, 20)
	end
end

function slot0._initCamera(slot0)
	if slot0._cameraPlayer then
		return
	end

	CameraMgr.instance:getCameraRootAnimator().runtimeAnimatorController = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[3]):GetResource()
	slot0._cameraRootTrans = CameraMgr.instance:getCameraRootGO().transform
	slot0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
end

function slot0._onViewAnimDone(slot0)
end

function slot0._onCameraAnimDone(slot0)
	slot0:_removeForceUpdateCameraPos()

	if VirtualSummonScene.instance:isOpen() then
		return
	end

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
end

function slot0._initCapture(slot0)
	if not slot0._needPlayGreeting then
		return
	end

	slot1 = PostProcessingMgr.instance:getCaptureView()
	gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)).runtimeAnimatorController = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[4]):GetResource()

	SLFramework.AnimatorPlayer.Get(slot1):Play("captureview", slot0._onCaptureAnimDone, slot0)
end

function slot0._onCaptureAnimDone(slot0)
end

function slot0._checkClose(slot0)
	if slot0._btnblock.gameObject.activeInHierarchy then
		return
	end

	if slot0._animator.enabled or slot0._cameraAnimator.enabled then
		return
	end

	return true
end

function slot0._navCloseCheck(slot0)
	return slot0:_checkClose()
end

function slot0._onEscBtnClick(slot0)
	if not slot0:_checkClose() then
		return
	end

	slot0:closeThis()
end

function slot0._onSceneClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
end

slot2 = WeatherController.instance

function slot0._editableInitView(slot0)
	slot0:_enableKeyword()

	slot0._spineInitPosX = recthelper.getAnchorX(gohelper.findChild(slot0._gospinescale, "lightspine").transform)
	slot0._offsetXWithMainView = slot0._spineInitPosX - 42
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._golightspinecontrol)

	slot0._click:AddClickDownListener(slot0._clickDown, slot0)

	slot0._showInScene = true

	uv0.setSpineScale(slot0._gospinescale)
end

function slot0.setSpineScale(slot0)
	slot1 = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(slot0.transform, slot1, slot1, slot1)
end

function slot0._updateHero(slot0, slot1, slot2)
	slot0._anchorMinPos = nil
	slot0._anchorMaxPos = nil
	slot0._closeEffectList = nil
	slot0._tvOff = false
	slot0._heroId = slot1
	slot0._skinId = slot2

	if not HeroModel.instance:getByHeroId(slot0._heroId) then
		logError("_updateHero no hero:" .. tostring(slot1))

		return
	end

	if not SkinConfig.instance:getSkinCo(slot0._skinId or slot3 and slot3.skin) then
		return
	end

	slot0._heroPhotoFrameBg = slot3.config.photoFrameBg
	slot0._heroSkinConfig = slot4
	slot0._heroSkinTriggerArea = {}

	if not slot0._lightSpine then
		if not gohelper.isNil(UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine")) then
			gohelper.addChildPosStay(slot0._golightspine.transform.parent.gameObject, slot5)
			gohelper.destroy(slot0._golightspine)

			slot0._golightspine = slot5
		end

		slot0._lightSpine = LightModelAgent.Create(slot0._golightspine, true)
	end

	slot0:setSpineAnchorTween()

	if not string.nilorempty(slot4.defaultStencilValue) then
		slot0._defaultStencilValue = string.splitToNumber(slot4.defaultStencilValue, "#")
	else
		slot0._defaultStencilValue = nil
	end

	slot0._lightSpine:setResPath(slot4, slot0._onLightSpineLoaded, slot0)
	slot0._lightSpine:setInMainView()
end

function slot0.setSpineAnchorTween(slot0)
	if slot0.tweenId then
		uv0.KillById(slot0.tweenId)
	end

	if string.nilorempty(slot0._heroSkinConfig.mainThumbnailViewOffset) then
		return
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)
	slot0.tweenId = uv0.DOAnchorPos(slot0._golightspine.transform, slot2[1], slot2[2], 0.4)
end

function slot0.resetSpineAnchorTween(slot0, slot1)
	if slot0.tweenId then
		uv0.KillById(slot0.tweenId)
	end

	if gohelper.isNil(slot0._golightspine) then
		return
	end

	slot2, slot3 = CharacterSwitchListModel.instance:getMainHero()

	if not SkinConfig.instance:getSkinCo(slot3) then
		return
	end

	slot5 = SkinConfig.instance:getSkinOffset(slot4.mainViewOffset)

	if slot1 then
		recthelper.setAnchor(slot0._golightspine.transform, slot5[1], slot5[2])

		return
	end

	slot0.tweenId = uv0.DOAnchorPos(slot0._golightspine.transform, slot5[1], slot5[2], 0.4)
end

function slot0._onLightSpineLoaded(slot0)
	if gohelper.isNil(slot0.viewGO) then
		return
	end

	slot0._spineGo = slot0._lightSpine:getSpineGo()
	slot0._spineTransform = slot0._spineGo.transform
	slot2 = slot0._lightSpine:getRenderer().sharedMaterial

	if slot0._defaultStencilValue then
		slot0._lightSpine:setStencilValues(slot0._defaultStencilValue[1], slot0._defaultStencilValue[2], slot0._defaultStencilValue[3])
	else
		slot0._lightSpine:setStencilRef(0)
	end

	WeatherController.instance:setLightModel(slot0._lightSpine)

	if not slot0._firstLoadSpine then
		slot0._firstLoadSpine = true

		uv0:initRoleGo(slot0._spineGo, slot0._heroId, slot2, false, slot0._skinId)
	else
		uv0:changeRoleGo({
			heroPlayWeatherVoice = true,
			roleGo = slot0._lightSpine:getSpineGo(),
			heroId = slot0._heroId,
			sharedMaterial = slot2,
			skinId = slot0._skinId
		})
	end
end

function slot0._playGreetingVoices(slot0)
	if not (MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.GreetingInThumbnail, slot0._heroId, slot0._skinId) or MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, slot0._heroId, slot0._skinId)) and HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.Greeting, nil, slot0._skinId) and #slot2 > 0 then
		slot1 = slot2[1]
	end

	if not slot1 then
		logError("no greeting voice")

		return
	end

	if not slot0._lightSpine then
		logError("playGreetingVoices no lightSpine")

		return
	end

	slot0._lightSpine:playVoice(slot1, function ()
		uv0:_greetingFinish()
	end, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0._greetingFinish(slot0)
	if not slot0._btnblock.gameObject.activeInHierarchy then
		return
	end

	gohelper.setActive(slot0._btnblock.gameObject, false)
	TaskDispatcher.cancelTask(slot0._greetingFinish, slot0)
	MainController.instance:dispatchEvent(MainEvent.OnMainThumbnailGreetingFinish)
	slot0:_showRedDot()
end

function slot0._showRedDot(slot0)
	gohelper.setActive(slot0._goswitch, true)

	if slot0._isShowRedDot then
		return
	end

	slot0._isShowRedDot = slot0:_checkShowRedDot()

	gohelper.setActive(slot0._goswitchreddot, slot0._isShowRedDot)

	if slot0._isShowRedDot then
		slot0._goswitch:GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)

		slot0._audioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_banniang_icon)
	end
end

function slot0._checkShowRedDot(slot0)
	slot0._characterShowRedDot = slot0:_checkCharacterShowRedDot()

	return slot0._characterShowRedDot or RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0)
end

function slot0._checkCharacterShowRedDot(slot0)
	return #HeroModel.instance:getList() >= 2 and PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainThumbnailViewSwitch) ~= "1"
end

function slot0._hideRedDot(slot0)
	if slot0._characterShowRedDot then
		slot0._characterShowRedDot = false
		slot1 = PlayerEnum.SimpleProperty.MainThumbnailViewSwitch
		slot2 = "1"

		PlayerModel.instance:forceSetSimpleProperty(slot1, slot2)
		PlayerRpc.instance:sendSetSimplePropertyRequest(slot1, slot2)
	end

	slot0._isShowRedDot = slot0:_checkShowRedDot()

	gohelper.setActive(slot0._goswitchreddot, slot0._isShowRedDot)
end

function slot0.isPlayingVoice(slot0)
	return slot0._lightSpine:isPlayingVoice() or slot0._tvOff
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
		if tonumber(slot9[1]) <= slot2.x and slot2.x <= tonumber(slot9[3]) and slot2.y <= tonumber(slot9[2]) and tonumber(slot9[4]) <= slot2.y then
			return true
		end
	end

	return false
end

function slot0._clickDown(slot0)
end

function slot0._doClickDown(slot0)
	if not slot0._showInScene then
		return
	end

	if gohelper.isNil(slot0._spineGo) then
		return
	end

	slot1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._golightspinecontrol.transform)
	slot1.x = slot1.x - slot0._offsetXWithMainView

	if slot0._skinId == 303301 or slot0._skinId == 303302 then
		slot0:_clickTTT(slot1)

		return
	end

	slot0:_clickDefault(slot1)
end

function slot0._clickTTT(slot0, slot1)
	if not slot0:_checkPosInBound(slot1) then
		return
	end

	if not slot0._tvOff and math.random() < CommonConfig.instance:getConstNum(ConstEnum.TTTCloseTv) / 100 then
		slot0._tvOff = true

		TaskDispatcher.cancelTask(slot0._hideCloseEffects, slot0)

		slot0._closeEffectList = slot0._closeEffectList or slot0:getUserDataTb_()

		for slot10 = 1, gohelper.findChild(slot0._lightSpine:getSpineGo(), "mountroot").transform.childCount do
			for slot15 = 1, slot5:GetChild(slot10 - 1).childCount do
				if string.find(slot11:GetChild(slot15 - 1).name, "close") then
					gohelper.setActive(slot16.gameObject, true)

					slot0._closeEffectList[slot10] = slot16.gameObject
				else
					gohelper.setActive(slot16.gameObject, false)
				end
			end
		end

		if slot0._lightSpine then
			slot0._lightSpine:stopVoice()
		end

		return
	end

	if slot0:_openTv() then
		return
	end

	slot0:_clickDefault(slot1)
end

function slot0._openTv(slot0)
	if slot0._tvOff then
		slot0._tvOff = false

		TaskDispatcher.cancelTask(slot0._hideCloseEffects, slot0)
		TaskDispatcher.runDelay(slot0._hideCloseEffects, slot0, 0.2)

		for slot8 = 1, gohelper.findChild(slot0._lightSpine:getSpineGo(), "mountroot").transform.childCount do
			for slot13 = 1, slot3:GetChild(slot8 - 1).childCount do
				if not string.find(slot9:GetChild(slot13 - 1).name, "close") then
					gohelper.setActive(slot14.gameObject, true)
				end
			end
		end

		return true
	end
end

function slot0._hideCloseEffects(slot0)
	for slot4, slot5 in pairs(slot0._closeEffectList) do
		gohelper.setActive(slot5, false)
	end
end

function slot0._clickDefault(slot0, slot1)
	if slot0:_getSpecialTouch(slot1) and math.random() > 0.5 then
		slot0:clickPlayVoice(slot2)

		return
	end

	if slot0:_getNormalTouch(slot1) then
		slot0:clickPlayVoice(slot3)
	end
end

function slot0._getSpecialTouch(slot0, slot1)
	if HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.MainViewSpecialTouch, function (slot0)
		return uv0._clickPlayConfig ~= slot0 and uv0:_checkSpecialTouch(slot0, uv1)
	end) and #slot2 > 0 then
		return slot2[1]
	end
end

function slot0._getNormalTouch(slot0, slot1)
	if slot0:_checkPosInBound(slot1) then
		return slot0:getHeightWeight(HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function (slot0)
			return uv0._clickPlayConfig ~= slot0
		end))
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

function slot0.getHeightWeight(slot0, slot1)
	if slot1 and #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			slot2 = 0 + slot7.param
		end

		for slot8, slot9 in ipairs(slot1) do
			if math.random() <= (0 + slot9.param) / slot2 then
				return slot9
			end
		end
	end

	return nil
end

function slot0.clickPlayVoice(slot0, slot1)
	slot0._clickPlayConfig = slot1

	slot0:playVoice(slot1)
end

function slot0.playVoice(slot0, slot1)
	if not slot0._lightSpine then
		return
	end

	slot0._lightSpine:playVoice(slot1, function ()
		uv0._interactionStartTime = Time.time
	end, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0._enableKeyword(slot0)
end

function slot0._disableKeyword(slot0)
end

function slot0._onOpenFullView(slot0, slot1)
	if slot1 ~= slot0:_getSwitchViewName() then
		slot0:_disableKeyword()
	end

	if slot0._lightSpine then
		slot0._lightSpine:stopVoice()
	end

	uv0.setCameraIdle()
end

function slot0.setCameraIdle()
	if CameraMgr.instance:getCameraRootAnimator() then
		slot0.enabled = false
	end

	transformhelper.setLocalPos(CameraMgr.instance:getCameraRootGO().transform, 0, 0, 0)

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
	slot2 = ViewMgr.instance:getUICanvas()
	slot2.enabled = false
	slot2.enabled = true
end

function slot0._hideLightSpineVisible(slot0)
end

function slot0._onCloseFullView(slot0, slot1)
	if not ViewMgr.instance:hasOpenFullView() then
		slot0:_startForceUpdateCameraPos()

		if ViewMgr.instance:isOpen(slot0:_getSwitchViewName()) then
			slot0._cameraPlayer:Play("clip2", slot0._onCameraAnimDone, slot0)
		else
			slot0._cameraPlayer:Play("clip", slot0._onCameraAnimDone, slot0)
		end

		slot0:_enableKeyword()
		slot0:_openTv()
	end
end

function slot0._reOpenWhileOpen(slot0, slot1)
	if ViewMgr.instance:isFull(slot1) then
		slot0:_onOpenFullView(slot1)
	end
end

function slot0._setViewVisible(slot0, slot1)
	recthelper.setAnchorY(slot0.viewGO.transform, slot1 and 0 or 10000)
	slot0.viewContainer:_setVisible(slot1)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == slot0:_getSwitchViewName() then
		slot0:_setViewVisible(false)
		slot0:_startForceUpdateCameraPos()
		slot0._cameraPlayer:Play("ani02", slot0._onCameraAnimDone, slot0)
		slot0:resetSpineAnchorTween()

		if slot0._lightSpine then
			slot0._lightSpine:stopVoice()
		end
	elseif (slot1 == ViewName.CharacterGetView or slot1 == ViewName.CharacterSkinGetDetailView) and slot0._lightSpine then
		gohelper.setActive(slot0._lightSpine:getSpineGo(), false)
	end
end

function slot0._startForceUpdateCameraPos(slot0)
	slot0:_removeForceUpdateCameraPos()
	LateUpdateBeat:Add(slot0._forceUpdateCameraPos, slot0)
end

function slot0._removeForceUpdateCameraPos(slot0)
	LateUpdateBeat:Remove(slot0._forceUpdateCameraPos, slot0)
end

function slot0._forceUpdateCameraPos(slot0)
	slot1 = CameraMgr.instance:getCameraTrace()
	slot1.EnableTrace = true
	slot1.EnableTrace = false
	slot1.enabled = false
end

function slot0._getSwitchViewName(slot0)
	return ViewName.MainSwitchView
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot0:_isLogout() then
		return
	end

	slot0:_showRedDot()

	if slot1 == slot0:_getSwitchViewName() then
		slot0:_hideRedDot()
		slot0:_setViewVisible(true)
		slot0._viewPlayer:Play("open3", slot0._onViewAnimDone, slot0)
		slot0:_startForceUpdateCameraPos()
		slot0._cameraPlayer:Play("ani03", slot0._onCameraAnimDone, slot0)
		slot0:resetSpineAnchorTween(true)
		slot0:setSpineAnchorTween()

		slot2, slot3 = CharacterSwitchListModel.instance:getMainHero()

		if slot0._curHeroId ~= slot2 and slot2 or slot0._curSkinId ~= slot3 and slot3 or gohelper.isNil(slot0._lightSpine:getSpineGo()) then
			slot0._curHeroId = slot2
			slot0._curSkinId = slot3

			slot0:_updateHero(slot0._curHeroId, slot0._curSkinId)
		elseif slot0._lightSpine then
			uv0:changeRoleGo({
				heroPlayWeatherVoice = true,
				roleGo = slot0._lightSpine:getSpineGo(),
				heroId = slot0._heroId,
				sharedMaterial = slot0._lightSpine:getRenderer().sharedMaterial,
				skinId = slot3
			})
			WeatherController.instance:setLightModel(slot0._lightSpine)
		end
	elseif (slot1 == ViewName.CharacterGetView or slot1 == ViewName.CharacterSkinGetDetailView) and slot0._lightSpine then
		gohelper.setActive(slot0._lightSpine:getSpineGo(), true)
	end
end

function slot0.onCloseFinish(slot0)
	if gohelper.isNil(UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine")) or gohelper.isNil(slot0._golightspine) then
		return
	end

	if slot1.transform.childCount > 0 then
		return
	end

	gohelper.addChildPosStay(slot1, slot0._golightspine)
end

function slot0.onClose(slot0)
	if slot0._lightSpine and not LimitedRoleController.instance:isPlayingAction() then
		slot0._lightSpine:stopVoice()
	end

	slot0._click:RemoveClickDownListener()

	if slot0._touchEventMgr then
		slot0._touchEventMgr:ClearAllCallback()

		slot0._touchEventMgr = nil
	end

	TaskDispatcher.cancelTask(slot0._hideCloseEffects, slot0)
	TaskDispatcher.cancelTask(slot0._greetingFinish, slot0)
	slot0:_removeForceUpdateCameraPos()
	slot0:resetSpineAnchorTween()

	if slot0:_isLogout() or ViewMgr.instance:isOpen(ViewName.SettingsView) then
		uv0.setCameraIdle()
	else
		GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayFullGC)
		slot0._cameraPlayer:Play("ani02", slot0._onCameraAnimDone, slot0)
	end

	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	if slot0._audioId then
		AudioMgr.instance:stopPlayingID(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0._isLogout(slot0)
	return GameGlobalMgr.instance:getLoadingState() and slot1:getLoadingViewName()
end

function slot0.onDestroyView(slot0)
	slot0:_disableKeyword()
end

return slot0
