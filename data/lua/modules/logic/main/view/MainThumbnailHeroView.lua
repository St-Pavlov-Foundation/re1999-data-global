module("modules.logic.main.view.MainThumbnailHeroView", package.seeall)

local var_0_0 = class("MainThumbnailHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_lightspinecontrol")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_block")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._goswitchreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_switch/switchreddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
end

local var_0_1 = ZProj.TweenHelper

function var_0_0._btnblockOnClick(arg_4_0)
	if arg_4_0._lightSpine then
		arg_4_0._lightSpine:stopVoice()
	end

	arg_4_0:_greetingFinish()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_5_0._onOpenFullView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_5_0._reOpenWhileOpen, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_5_0._onCloseFullView, arg_5_0)
	arg_5_0:addEventCb(MainController.instance, MainEvent.OnSceneClose, arg_5_0._onSceneClose, arg_5_0)
	arg_5_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0._onScreenResize, arg_5_0)
	NavigateMgr.instance:addEscape(ViewName.MainThumbnailView, arg_5_0._onEscBtnClick, arg_5_0)
	arg_5_0.viewContainer:getThumbnailNav():setCloseCheck(arg_5_0._navCloseCheck, arg_5_0)
	arg_5_0:_initGreeting()
	arg_5_0:_initCamera()
	arg_5_0:_initCapture()
	gohelper.setActive(arg_5_0._goswitchreddot, false)

	if arg_5_0:_checkShowRedDot() then
		gohelper.setActive(arg_5_0._goswitch, false)
	end

	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._viewPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)

	arg_5_0._viewPlayer:Play(arg_5_0._needPlayGreeting and "open1" or "open2", arg_5_0._onViewAnimDone, arg_5_0)

	arg_5_0._curHeroId, arg_5_0._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if arg_5_0._curHeroId and arg_5_0._curSkinId then
		arg_5_0:_updateHero(arg_5_0._curHeroId, arg_5_0._curSkinId)
	end

	arg_5_0:_startForceUpdateCameraPos()
	arg_5_0._cameraPlayer:Play(arg_5_0._needPlayGreeting and "ani01" or "ani03", arg_5_0._cameraInitAnimDone, arg_5_0)

	if not PlayerModel.instance:getMainThumbnail() then
		PlayerRpc.instance:sendMarkMainThumbnailRequest()
	end
end

function var_0_0._onScreenResize(arg_6_0)
	var_0_0.setSpineScale(arg_6_0._gospinescale)
end

function var_0_0._cameraInitAnimDone(arg_7_0)
	arg_7_0:_removeForceUpdateCameraPos()

	if arg_7_0._needPlayGreeting then
		arg_7_0._needPlayGreeting = false

		arg_7_0:_playGreetingVoices()
	else
		arg_7_0:_showRedDot()
	end
end

function var_0_0._initGreeting(arg_8_0)
	arg_8_0._needPlayGreeting = arg_8_0.viewParam and arg_8_0.viewParam.needPlayGreeting

	gohelper.setActive(arg_8_0._btnblock.gameObject, arg_8_0._needPlayGreeting)

	if arg_8_0._needPlayGreeting then
		gohelper.setActive(arg_8_0._goswitch, false)
		TaskDispatcher.runDelay(arg_8_0._greetingFinish, arg_8_0, 20)
	end
end

function var_0_0._initCamera(arg_9_0)
	if arg_9_0._cameraPlayer then
		return
	end

	local var_9_0 = CameraMgr.instance:getCameraRootAnimator()
	local var_9_1 = arg_9_0.viewContainer:getSetting().otherRes[3]

	var_9_0.runtimeAnimatorController = arg_9_0.viewContainer._abLoader:getAssetItem(var_9_1):GetResource()
	arg_9_0._cameraRootTrans = CameraMgr.instance:getCameraRootGO().transform
	arg_9_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_9_0._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
end

function var_0_0._onViewAnimDone(arg_10_0)
	return
end

function var_0_0._onCameraAnimDone(arg_11_0)
	arg_11_0:_removeForceUpdateCameraPos()

	if VirtualSummonScene.instance:isOpen() then
		return
	end

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
end

function var_0_0._initCapture(arg_12_0)
	if not arg_12_0._needPlayGreeting then
		return
	end

	local var_12_0 = PostProcessingMgr.instance:getCaptureView()
	local var_12_1 = gohelper.onceAddComponent(var_12_0, typeof(UnityEngine.Animator))
	local var_12_2 = arg_12_0.viewContainer:getSetting().otherRes[4]

	var_12_1.runtimeAnimatorController = arg_12_0.viewContainer._abLoader:getAssetItem(var_12_2):GetResource()

	SLFramework.AnimatorPlayer.Get(var_12_0):Play("captureview", arg_12_0._onCaptureAnimDone, arg_12_0)
end

function var_0_0._onCaptureAnimDone(arg_13_0)
	return
end

function var_0_0._checkClose(arg_14_0)
	if arg_14_0._btnblock.gameObject.activeInHierarchy then
		return
	end

	if arg_14_0._animator.enabled or arg_14_0._cameraAnimator.enabled then
		return
	end

	return true
end

function var_0_0._navCloseCheck(arg_15_0)
	return arg_15_0:_checkClose()
end

function var_0_0._onEscBtnClick(arg_16_0)
	if not arg_16_0:_checkClose() then
		return
	end

	arg_16_0:closeThis()
end

function var_0_0._onSceneClose(arg_17_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_17_0._onCloseFullView, arg_17_0)
end

local var_0_2 = WeatherController.instance

function var_0_0._editableInitView(arg_18_0)
	arg_18_0:_enableKeyword()

	local var_18_0 = gohelper.findChild(arg_18_0._gospinescale, "lightspine")

	arg_18_0._spineInitPosX = recthelper.getAnchorX(var_18_0.transform)
	arg_18_0._offsetXWithMainView = arg_18_0._spineInitPosX - 42
	arg_18_0._click = SLFramework.UGUI.UIClickListener.Get(arg_18_0._golightspinecontrol)

	arg_18_0._click:AddClickDownListener(arg_18_0._clickDown, arg_18_0)

	arg_18_0._showInScene = true

	var_0_0.setSpineScale(arg_18_0._gospinescale)
end

function var_0_0.setSpineScale(arg_19_0)
	local var_19_0 = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(arg_19_0.transform, var_19_0, var_19_0, var_19_0)
end

function var_0_0._updateHero(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._anchorMinPos = nil
	arg_20_0._anchorMaxPos = nil
	arg_20_0._closeEffectList = nil
	arg_20_0._tvOff = false
	arg_20_0._heroId = arg_20_1
	arg_20_0._skinId = arg_20_2

	local var_20_0 = HeroModel.instance:getByHeroId(arg_20_0._heroId)

	if not var_20_0 then
		logError("_updateHero no hero:" .. tostring(arg_20_1))

		return
	end

	local var_20_1 = SkinConfig.instance:getSkinCo(arg_20_0._skinId or var_20_0 and var_20_0.skin)

	if not var_20_1 then
		return
	end

	arg_20_0._heroPhotoFrameBg = var_20_0.config.photoFrameBg
	arg_20_0._heroSkinConfig = var_20_1
	arg_20_0._heroSkinTriggerArea = {}

	if not arg_20_0._lightSpine then
		local var_20_2 = UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine")

		if not gohelper.isNil(var_20_2) then
			gohelper.addChildPosStay(arg_20_0._golightspine.transform.parent.gameObject, var_20_2)
			gohelper.destroy(arg_20_0._golightspine)

			arg_20_0._golightspine = var_20_2
		end

		arg_20_0._lightSpine = LightModelAgent.Create(arg_20_0._golightspine, true)
	end

	arg_20_0:setSpineAnchorTween()

	if not string.nilorempty(var_20_1.defaultStencilValue) then
		arg_20_0._defaultStencilValue = string.splitToNumber(var_20_1.defaultStencilValue, "#")
	else
		arg_20_0._defaultStencilValue = nil
	end

	arg_20_0._lightSpine:setResPath(var_20_1, arg_20_0._onLightSpineLoaded, arg_20_0)
	arg_20_0._lightSpine:setInMainView()
end

function var_0_0.setSpineAnchorTween(arg_21_0)
	if arg_21_0.tweenId then
		var_0_1.KillById(arg_21_0.tweenId)
	end

	local var_21_0 = arg_21_0._heroSkinConfig.mainThumbnailViewOffset

	if string.nilorempty(var_21_0) then
		return
	end

	local var_21_1 = SkinConfig.instance:getSkinOffset(var_21_0)

	arg_21_0.tweenId = var_0_1.DOAnchorPos(arg_21_0._golightspine.transform, var_21_1[1], var_21_1[2], 0.4)
end

function var_0_0.resetSpineAnchorTween(arg_22_0, arg_22_1)
	if arg_22_0.tweenId then
		var_0_1.KillById(arg_22_0.tweenId)
	end

	if gohelper.isNil(arg_22_0._golightspine) then
		return
	end

	local var_22_0, var_22_1 = CharacterSwitchListModel.instance:getMainHero()
	local var_22_2 = SkinConfig.instance:getSkinCo(var_22_1)

	if not var_22_2 then
		return
	end

	local var_22_3 = SkinConfig.instance:getSkinOffset(var_22_2.mainViewOffset)

	if arg_22_1 then
		recthelper.setAnchor(arg_22_0._golightspine.transform, var_22_3[1], var_22_3[2])

		local var_22_4 = tonumber(var_22_3[3])

		transformhelper.setLocalScale(arg_22_0._golightspine.transform, var_22_4, var_22_4, var_22_4)

		return
	end

	arg_22_0.tweenId = var_0_1.DOAnchorPos(arg_22_0._golightspine.transform, var_22_3[1], var_22_3[2], 0.4)
end

function var_0_0._onLightSpineLoaded(arg_23_0)
	if gohelper.isNil(arg_23_0.viewGO) then
		return
	end

	arg_23_0._spineGo = arg_23_0._lightSpine:getSpineGo()
	arg_23_0._spineTransform = arg_23_0._spineGo.transform

	local var_23_0 = arg_23_0._lightSpine:getRenderer().sharedMaterial

	if arg_23_0._defaultStencilValue then
		arg_23_0._lightSpine:setStencilValues(arg_23_0._defaultStencilValue[1], arg_23_0._defaultStencilValue[2], arg_23_0._defaultStencilValue[3])
	else
		arg_23_0._lightSpine:setStencilRef(0)
	end

	WeatherController.instance:setLightModel(arg_23_0._lightSpine)

	if not arg_23_0._firstLoadSpine then
		arg_23_0._firstLoadSpine = true

		var_0_2:initRoleGo(arg_23_0._spineGo, arg_23_0._heroId, var_23_0, false, arg_23_0._skinId)
	else
		local var_23_1 = {
			heroPlayWeatherVoice = true,
			roleGo = arg_23_0._lightSpine:getSpineGo(),
			heroId = arg_23_0._heroId,
			sharedMaterial = var_23_0,
			skinId = arg_23_0._skinId
		}

		var_0_2:changeRoleGo(var_23_1)
	end
end

function var_0_0._playGreetingVoices(arg_24_0)
	local var_24_0 = MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.GreetingInThumbnail, arg_24_0._heroId, arg_24_0._skinId) or MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, arg_24_0._heroId, arg_24_0._skinId)

	if not var_24_0 then
		local var_24_1 = HeroModel.instance:getVoiceConfig(arg_24_0._heroId, CharacterEnum.VoiceType.Greeting, nil, arg_24_0._skinId)

		if var_24_1 and #var_24_1 > 0 then
			var_24_0 = var_24_1[1]
		end
	end

	if not var_24_0 then
		logError("no greeting voice")

		return
	end

	if not arg_24_0._lightSpine then
		logError("playGreetingVoices no lightSpine")

		return
	end

	arg_24_0._lightSpine:playVoice(var_24_0, function()
		arg_24_0:_greetingFinish()
	end, arg_24_0._txtanacn, arg_24_0._txtanaen, arg_24_0._gocontentbg)
end

function var_0_0._greetingFinish(arg_26_0)
	if not arg_26_0._btnblock.gameObject.activeInHierarchy then
		return
	end

	gohelper.setActive(arg_26_0._btnblock.gameObject, false)
	TaskDispatcher.cancelTask(arg_26_0._greetingFinish, arg_26_0)
	MainController.instance:dispatchEvent(MainEvent.OnMainThumbnailGreetingFinish)
	arg_26_0:_showRedDot()
end

function var_0_0._showRedDot(arg_27_0)
	gohelper.setActive(arg_27_0._goswitch, true)

	if arg_27_0._isShowRedDot then
		return
	end

	arg_27_0._isShowRedDot = arg_27_0:_checkShowRedDot()

	gohelper.setActive(arg_27_0._goswitchreddot, arg_27_0._isShowRedDot)

	if arg_27_0._isShowRedDot then
		arg_27_0._goswitch:GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)

		arg_27_0._audioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_banniang_icon)
	end
end

function var_0_0._checkShowRedDot(arg_28_0)
	arg_28_0._characterShowRedDot = arg_28_0:_checkCharacterShowRedDot() or arg_28_0:_checkFightUiShowRedDot() or arg_28_0:_isShowSceneUIReddot()

	return arg_28_0._characterShowRedDot or RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0)
end

function var_0_0._checkCharacterShowRedDot(arg_29_0)
	local var_29_0 = HeroModel.instance:getList()
	local var_29_1 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainThumbnailViewSwitch)

	return #var_29_0 >= 2 and var_29_1 ~= "1"
end

function var_0_0._checkFightUiShowRedDot(arg_30_0)
	return FightUISwitchModel.instance:isNewUnlockStyle()
end

function var_0_0._isShowSceneUIReddot(arg_31_0)
	return ClickUISwitchModel.instance:hasReddot()
end

function var_0_0._hideRedDot(arg_32_0)
	if arg_32_0._characterShowRedDot then
		arg_32_0._characterShowRedDot = false

		local var_32_0 = PlayerEnum.SimpleProperty.MainThumbnailViewSwitch
		local var_32_1 = "1"

		PlayerModel.instance:forceSetSimpleProperty(var_32_0, var_32_1)
		PlayerRpc.instance:sendSetSimplePropertyRequest(var_32_0, var_32_1)
	end

	arg_32_0._isShowRedDot = arg_32_0:_checkShowRedDot()

	gohelper.setActive(arg_32_0._goswitchreddot, arg_32_0._isShowRedDot)
end

function var_0_0.isPlayingVoice(arg_33_0)
	return arg_33_0._lightSpine:isPlayingVoice() or arg_33_0._tvOff
end

function var_0_0.isShowInScene(arg_34_0)
	return arg_34_0._showInScene
end

function var_0_0._checkSpecialTouch(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = "triggerArea" .. arg_35_1.param
	local var_35_1 = arg_35_0._heroSkinTriggerArea[var_35_0]

	if not var_35_1 then
		var_35_1 = {}
		arg_35_0._heroSkinTriggerArea[var_35_0] = var_35_1

		local var_35_2 = arg_35_0._heroSkinConfig[var_35_0]
		local var_35_3 = string.split(var_35_2, "_")

		for iter_35_0, iter_35_1 in ipairs(var_35_3) do
			local var_35_4 = string.split(iter_35_1, "|")

			if #var_35_4 == 2 then
				local var_35_5 = string.split(var_35_4[1], "#")
				local var_35_6 = string.split(var_35_4[2], "#")
				local var_35_7 = tonumber(var_35_5[1])
				local var_35_8 = tonumber(var_35_5[2])
				local var_35_9 = tonumber(var_35_6[1])
				local var_35_10 = tonumber(var_35_6[2])
				local var_35_11 = {
					var_35_7,
					var_35_8,
					var_35_9,
					var_35_10
				}

				table.insert(var_35_1, var_35_11)
			end
		end
	end

	for iter_35_2, iter_35_3 in ipairs(var_35_1) do
		local var_35_12 = tonumber(iter_35_3[1])
		local var_35_13 = tonumber(iter_35_3[2])
		local var_35_14 = tonumber(iter_35_3[3])
		local var_35_15 = tonumber(iter_35_3[4])

		if var_35_12 <= arg_35_2.x and var_35_14 >= arg_35_2.x and var_35_13 >= arg_35_2.y and var_35_15 <= arg_35_2.y then
			return true
		end
	end

	return false
end

function var_0_0._clickDown(arg_36_0)
	return
end

function var_0_0._doClickDown(arg_37_0)
	if not arg_37_0._showInScene then
		return
	end

	if gohelper.isNil(arg_37_0._spineGo) then
		return
	end

	local var_37_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_37_0._golightspinecontrol.transform)

	var_37_0.x = var_37_0.x - arg_37_0._offsetXWithMainView

	if arg_37_0._skinId == 303301 or arg_37_0._skinId == 303302 then
		arg_37_0:_clickTTT(var_37_0)

		return
	end

	arg_37_0:_clickDefault(var_37_0)
end

function var_0_0._clickTTT(arg_38_0, arg_38_1)
	if not arg_38_0:_checkPosInBound(arg_38_1) then
		return
	end

	local var_38_0 = CommonConfig.instance:getConstNum(ConstEnum.TTTCloseTv) / 100

	if not arg_38_0._tvOff and var_38_0 > math.random() then
		local var_38_1 = arg_38_0._lightSpine:getSpineGo()

		arg_38_0._tvOff = true

		TaskDispatcher.cancelTask(arg_38_0._hideCloseEffects, arg_38_0)

		arg_38_0._closeEffectList = arg_38_0._closeEffectList or arg_38_0:getUserDataTb_()

		local var_38_2 = gohelper.findChild(var_38_1, "mountroot").transform
		local var_38_3 = var_38_2.childCount

		for iter_38_0 = 1, var_38_3 do
			local var_38_4 = var_38_2:GetChild(iter_38_0 - 1)

			for iter_38_1 = 1, var_38_4.childCount do
				local var_38_5 = var_38_4:GetChild(iter_38_1 - 1)

				if string.find(var_38_5.name, "close") then
					gohelper.setActive(var_38_5.gameObject, true)

					arg_38_0._closeEffectList[iter_38_0] = var_38_5.gameObject
				else
					gohelper.setActive(var_38_5.gameObject, false)
				end
			end
		end

		if arg_38_0._lightSpine then
			arg_38_0._lightSpine:stopVoice()
		end

		return
	end

	if arg_38_0:_openTv() then
		return
	end

	arg_38_0:_clickDefault(arg_38_1)
end

function var_0_0._openTv(arg_39_0)
	if arg_39_0._tvOff then
		arg_39_0._tvOff = false

		local var_39_0 = arg_39_0._lightSpine:getSpineGo()

		TaskDispatcher.cancelTask(arg_39_0._hideCloseEffects, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0._hideCloseEffects, arg_39_0, 0.2)

		local var_39_1 = gohelper.findChild(var_39_0, "mountroot").transform
		local var_39_2 = var_39_1.childCount

		for iter_39_0 = 1, var_39_2 do
			local var_39_3 = var_39_1:GetChild(iter_39_0 - 1)

			for iter_39_1 = 1, var_39_3.childCount do
				local var_39_4 = var_39_3:GetChild(iter_39_1 - 1)

				if not string.find(var_39_4.name, "close") then
					gohelper.setActive(var_39_4.gameObject, true)
				end
			end
		end

		return true
	end
end

function var_0_0._hideCloseEffects(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0._closeEffectList) do
		gohelper.setActive(iter_40_1, false)
	end
end

function var_0_0._clickDefault(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:_getSpecialTouch(arg_41_1)

	if var_41_0 and math.random() > 0.5 then
		arg_41_0:clickPlayVoice(var_41_0)

		return
	end

	local var_41_1 = arg_41_0:_getNormalTouch(arg_41_1)

	if var_41_1 then
		arg_41_0:clickPlayVoice(var_41_1)
	end
end

function var_0_0._getSpecialTouch(arg_42_0, arg_42_1)
	local var_42_0 = HeroModel.instance:getVoiceConfig(arg_42_0._heroId, CharacterEnum.VoiceType.MainViewSpecialTouch, function(arg_43_0)
		return arg_42_0._clickPlayConfig ~= arg_43_0 and arg_42_0:_checkSpecialTouch(arg_43_0, arg_42_1)
	end)

	if var_42_0 and #var_42_0 > 0 then
		return var_42_0[1]
	end
end

function var_0_0._getNormalTouch(arg_44_0, arg_44_1)
	if arg_44_0:_checkPosInBound(arg_44_1) then
		local var_44_0 = HeroModel.instance:getVoiceConfig(arg_44_0._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function(arg_45_0)
			return arg_44_0._clickPlayConfig ~= arg_45_0
		end)

		return arg_44_0:getHeightWeight(var_44_0)
	end
end

function var_0_0._checkPosInBound(arg_46_0, arg_46_1)
	if not arg_46_0._anchorMinPos or not arg_46_0._anchorMaxPos then
		local var_46_0, var_46_1 = arg_46_0._lightSpine:getBoundsMinMaxPos()

		arg_46_0._anchorMinPos = recthelper.worldPosToAnchorPos(Vector3(var_46_0.x, var_46_1.y, var_46_0.z), arg_46_0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
		arg_46_0._anchorMaxPos = recthelper.worldPosToAnchorPos(Vector3(var_46_1.x, var_46_0.y, var_46_1.z), arg_46_0._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
	end

	local var_46_2 = arg_46_0._anchorMinPos
	local var_46_3 = arg_46_0._anchorMaxPos

	if arg_46_1.x >= var_46_2.x and arg_46_1.x <= var_46_3.x and arg_46_1.y <= var_46_2.y and arg_46_1.y >= var_46_3.y then
		return true
	end
end

function var_0_0.getHeightWeight(arg_47_0, arg_47_1)
	if arg_47_1 and #arg_47_1 > 0 then
		local var_47_0 = 0

		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			var_47_0 = var_47_0 + iter_47_1.param
		end

		local var_47_1 = math.random()
		local var_47_2 = 0

		for iter_47_2, iter_47_3 in ipairs(arg_47_1) do
			var_47_2 = var_47_2 + iter_47_3.param

			if var_47_1 <= var_47_2 / var_47_0 then
				return iter_47_3
			end
		end
	end

	return nil
end

function var_0_0.clickPlayVoice(arg_48_0, arg_48_1)
	arg_48_0._clickPlayConfig = arg_48_1

	arg_48_0:playVoice(arg_48_1)
end

function var_0_0.playVoice(arg_49_0, arg_49_1)
	if not arg_49_0._lightSpine then
		return
	end

	arg_49_0._lightSpine:playVoice(arg_49_1, function()
		arg_49_0._interactionStartTime = Time.time
	end, arg_49_0._txtanacn, arg_49_0._txtanaen, arg_49_0._gocontentbg)
end

function var_0_0._enableKeyword(arg_51_0)
	return
end

function var_0_0._disableKeyword(arg_52_0)
	return
end

function var_0_0._onOpenFullView(arg_53_0, arg_53_1)
	if arg_53_1 ~= arg_53_0:_getSwitchViewName() then
		arg_53_0:_disableKeyword()
	end

	if arg_53_0._lightSpine then
		arg_53_0._lightSpine:stopVoice()
	end

	var_0_0.setCameraIdle()
end

function var_0_0.setCameraIdle()
	local var_54_0 = CameraMgr.instance:getCameraRootAnimator()

	if var_54_0 then
		var_54_0.enabled = false
	end

	local var_54_1 = CameraMgr.instance:getCameraRootGO()

	transformhelper.setLocalPos(var_54_1.transform, 0, 0, 0)

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false

	local var_54_2 = ViewMgr.instance:getUICanvas()

	var_54_2.enabled = false
	var_54_2.enabled = true
end

function var_0_0._hideLightSpineVisible(arg_55_0)
	return
end

function var_0_0._onCloseFullView(arg_56_0, arg_56_1)
	if not ViewMgr.instance:hasOpenFullView() then
		arg_56_0:_startForceUpdateCameraPos()

		if ViewMgr.instance:isOpen(arg_56_0:_getSwitchViewName()) then
			arg_56_0._cameraPlayer:Play("clip2", arg_56_0._onCameraAnimDone, arg_56_0)
		else
			arg_56_0._cameraPlayer:Play("clip", arg_56_0._onCameraAnimDone, arg_56_0)
		end

		arg_56_0:_enableKeyword()
		arg_56_0:_openTv()
	end
end

function var_0_0._reOpenWhileOpen(arg_57_0, arg_57_1)
	if ViewMgr.instance:isFull(arg_57_1) then
		arg_57_0:_onOpenFullView(arg_57_1)
	end
end

function var_0_0._setViewVisible(arg_58_0, arg_58_1)
	recthelper.setAnchorY(arg_58_0.viewGO.transform, arg_58_1 and 0 or 10000)
	arg_58_0.viewContainer:_setVisible(arg_58_1)
end

function var_0_0._onOpenView(arg_59_0, arg_59_1)
	if arg_59_1 == arg_59_0:_getSwitchViewName() then
		arg_59_0:_setViewVisible(false)
		arg_59_0:_startForceUpdateCameraPos()
		arg_59_0._cameraPlayer:Play("ani02", arg_59_0._onCameraAnimDone, arg_59_0)
		arg_59_0:resetSpineAnchorTween()

		if arg_59_0._lightSpine then
			arg_59_0._lightSpine:stopVoice()
		end
	elseif (arg_59_1 == ViewName.CharacterGetView or arg_59_1 == ViewName.CharacterSkinGetDetailView) and arg_59_0._lightSpine then
		gohelper.setActive(arg_59_0._lightSpine:getSpineGo(), false)
	end
end

function var_0_0._startForceUpdateCameraPos(arg_60_0)
	arg_60_0:_removeForceUpdateCameraPos()
	LateUpdateBeat:Add(arg_60_0._forceUpdateCameraPos, arg_60_0)
end

function var_0_0._removeForceUpdateCameraPos(arg_61_0)
	LateUpdateBeat:Remove(arg_61_0._forceUpdateCameraPos, arg_61_0)
end

function var_0_0._forceUpdateCameraPos(arg_62_0)
	local var_62_0 = CameraMgr.instance:getCameraTrace()

	var_62_0.EnableTrace = true
	var_62_0.EnableTrace = false
	var_62_0.enabled = false
end

function var_0_0._getSwitchViewName(arg_63_0)
	return ViewName.MainSwitchView
end

function var_0_0._onCloseViewFinish(arg_64_0, arg_64_1)
	if arg_64_0:_isLogout() then
		return
	end

	arg_64_0:_showRedDot()

	if arg_64_1 == arg_64_0:_getSwitchViewName() then
		arg_64_0:_hideRedDot()
		arg_64_0:_setViewVisible(true)
		arg_64_0._viewPlayer:Play("open3", arg_64_0._onViewAnimDone, arg_64_0)
		arg_64_0:_startForceUpdateCameraPos()
		arg_64_0._cameraPlayer:Play("ani03", arg_64_0._onCameraAnimDone, arg_64_0)
		arg_64_0:resetSpineAnchorTween(true)
		arg_64_0:setSpineAnchorTween()

		local var_64_0, var_64_1 = CharacterSwitchListModel.instance:getMainHero()

		if arg_64_0._curHeroId ~= var_64_0 and var_64_0 or arg_64_0._curSkinId ~= var_64_1 and var_64_1 or gohelper.isNil(arg_64_0._lightSpine:getSpineGo()) then
			arg_64_0._curHeroId = var_64_0
			arg_64_0._curSkinId = var_64_1

			arg_64_0:_updateHero(arg_64_0._curHeroId, arg_64_0._curSkinId)
		elseif arg_64_0._lightSpine then
			local var_64_2 = arg_64_0._lightSpine:getRenderer().sharedMaterial
			local var_64_3 = {
				heroPlayWeatherVoice = true,
				roleGo = arg_64_0._lightSpine:getSpineGo(),
				heroId = arg_64_0._heroId,
				sharedMaterial = var_64_2,
				skinId = var_64_1
			}

			var_0_2:changeRoleGo(var_64_3)
			WeatherController.instance:setLightModel(arg_64_0._lightSpine)
		end
	elseif (arg_64_1 == ViewName.CharacterGetView or arg_64_1 == ViewName.CharacterSkinGetDetailView) and arg_64_0._lightSpine then
		gohelper.setActive(arg_64_0._lightSpine:getSpineGo(), true)
	end
end

function var_0_0.onCloseFinish(arg_65_0)
	local var_65_0 = UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine")

	if gohelper.isNil(var_65_0) or gohelper.isNil(arg_65_0._golightspine) then
		return
	end

	if var_65_0.transform.childCount > 0 then
		return
	end

	gohelper.addChildPosStay(var_65_0, arg_65_0._golightspine)
end

function var_0_0.onClose(arg_66_0)
	if arg_66_0._lightSpine and not LimitedRoleController.instance:isPlayingAction() then
		arg_66_0._lightSpine:stopVoice()
	end

	arg_66_0._click:RemoveClickDownListener()

	if arg_66_0._touchEventMgr then
		arg_66_0._touchEventMgr:ClearAllCallback()

		arg_66_0._touchEventMgr = nil
	end

	TaskDispatcher.cancelTask(arg_66_0._hideCloseEffects, arg_66_0)
	TaskDispatcher.cancelTask(arg_66_0._greetingFinish, arg_66_0)
	arg_66_0:_removeForceUpdateCameraPos()
	arg_66_0:resetSpineAnchorTween()

	if arg_66_0:_isLogout() or ViewMgr.instance:isOpen(ViewName.SettingsView) then
		var_0_0.setCameraIdle()
	else
		GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayFullGC)
		arg_66_0._cameraPlayer:Play("ani02", arg_66_0._onCameraAnimDone, arg_66_0)
	end

	arg_66_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_66_0._onCloseFullView, arg_66_0)
	arg_66_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_66_0._onCloseViewFinish, arg_66_0)

	if arg_66_0._audioId then
		AudioMgr.instance:stopPlayingID(arg_66_0._audioId)

		arg_66_0._audioId = nil
	end
end

function var_0_0._isLogout(arg_67_0)
	local var_67_0 = GameGlobalMgr.instance:getLoadingState()

	return var_67_0 and var_67_0:getLoadingViewName()
end

function var_0_0.onDestroyView(arg_68_0)
	arg_68_0:_disableKeyword()
end

function var_0_0.getLightSpineGo(arg_69_0)
	return arg_69_0._golightspine
end

return var_0_0
