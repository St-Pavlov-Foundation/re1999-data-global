module("modules.logic.season.view3_0.Season3_0MainScene", package.seeall)

local var_0_0 = class("Season3_0MainScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")
	arg_1_0._listenerViews = {
		[ViewName.Season3_0MarketView] = 1,
		[ViewName.Season3_0SpecialMarketView] = 1
	}
	arg_1_0.isFirst = true
	arg_1_0.seasonCameraLocalPos = Vector3(0, 0, -3.9)
	arg_1_0.seasonCameraOrthographicSize = 5
	arg_1_0.focusCameraOrthographicSize = 2
	arg_1_0.focusTime = 0.45
	arg_1_0.cancelFocusTime = 0.45
	arg_1_0.sectionCount = 5
	arg_1_0._stageSetting = {}

	for iter_1_0 = 1, arg_1_0.sectionCount do
		arg_1_0._stageSetting[iter_1_0] = {
			iter_1_0
		}
	end

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
	arg_4_0._camera = CameraMgr.instance:getMainCamera()

	arg_4_0:_initSceneRootNode()
	arg_4_0:_addEvents()
end

function var_0_0._addEvents(arg_5_0)
	arg_5_0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_5_0._onRefreshRetail, arg_5_0)
	arg_5_0:addEventCb(Activity104Controller.instance, Activity104Event.ChangeCameraSize, arg_5_0._onChangeCamera, arg_5_0)
	arg_5_0:addEventCb(Activity104Controller.instance, Activity104Event.SelectRetail, arg_5_0.focusRole, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenViewFinish, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseViewFinish, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_5_0._onOpenFullViewFinish, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_6_0._onRefreshRetail, arg_6_0)
	arg_6_0:removeEventCb(Activity104Controller.instance, Activity104Event.ChangeCameraSize, arg_6_0._onChangeCamera, arg_6_0)
	arg_6_0:removeEventCb(Activity104Controller.instance, Activity104Event.SelectRetail, arg_6_0.focusRole, arg_6_0)
	arg_6_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0._onOpenViewFinish, arg_6_0)
	arg_6_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseViewFinish, arg_6_0)
	arg_6_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_6_0._onOpenFullViewFinish, arg_6_0)
end

function var_0_0.initCamera(arg_7_0, arg_7_1)
	transformhelper.setLocalRotation(arg_7_0._camera.transform, 0, 0, 0)

	if not arg_7_0._tweenId then
		arg_7_0._camera.orthographicSize = arg_7_0.seasonCameraOrthographicSize
		arg_7_0._camera.orthographic = true

		transformhelper.setLocalPos(arg_7_0._camera.transform, arg_7_0.seasonCameraLocalPos.x, arg_7_0.seasonCameraLocalPos.y, arg_7_0.seasonCameraLocalPos.z)
	end

	if arg_7_1 == nil then
		arg_7_1 = false
	end

	arg_7_0:_showScenes(arg_7_1)
end

function var_0_0.resetCamera(arg_8_0)
	arg_8_0:doAudio(false)
end

function var_0_0._onChangeCamera(arg_9_0, arg_9_1)
	arg_9_0:initCamera(arg_9_1)
end

function var_0_0._showScenes(arg_10_0, arg_10_1)
	if not arg_10_0._sceneGo then
		return
	end

	if arg_10_0._isShowRetail == arg_10_1 then
		return
	end

	arg_10_0._isShowRetail = arg_10_1

	local var_10_0
	local var_10_1

	if arg_10_0.isFirst then
		var_10_0 = "open"
	end

	if arg_10_0._isShowRetail then
		var_10_0 = "go1"

		if arg_10_0.isFirst then
			var_10_1 = 1
		end

		arg_10_0:_enterRetail()
	else
		if not arg_10_0.isFirst then
			var_10_0 = "go2"
		end

		arg_10_0:_enterMarket()
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0._listenerViews) do
		if ViewMgr.instance:isOpen(iter_10_0) then
			var_10_1 = 1

			break
		end
	end

	if arg_10_0._sceneAnim and var_10_0 then
		if var_10_1 then
			arg_10_0._sceneAnim:Play(var_10_0, 0, var_10_1)
		else
			arg_10_0._sceneAnim:Play(var_10_0)
		end
	end

	arg_10_0:doAudio(true)

	arg_10_0.isFirst = false
end

function var_0_0.showSceneAnim(arg_11_0)
	local var_11_0
	local var_11_1

	if arg_11_0.isFirst then
		var_11_0 = "open"
	end

	if arg_11_0._isShowRetail then
		var_11_0 = "go1"

		if arg_11_0.isFirst then
			var_11_1 = 1
		end
	elseif not arg_11_0.isFirst then
		var_11_0 = "go2"
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0._listenerViews) do
		if ViewMgr.instance:isOpen(iter_11_0) then
			var_11_1 = 1

			break
		end
	end

	if arg_11_0._sceneAnim and var_11_0 then
		if var_11_1 then
			arg_11_0._sceneAnim:Play(var_11_0, 0, var_11_1)
		else
			arg_11_0._sceneAnim:Play(var_11_0)
		end
	end

	arg_11_0.isFirst = false
end

function var_0_0._enterRetail(arg_12_0)
	arg_12_0:_refreshRoles()
end

function var_0_0._onRefreshRetail(arg_13_0)
	arg_13_0:_refreshRoles(true)
end

function var_0_0._refreshRoles(arg_14_0, arg_14_1)
	TaskDispatcher.cancelTask(arg_14_0._refreshRoles, arg_14_0)

	if not arg_14_0._isShowRetail then
		gohelper.setActive(arg_14_0._goroles, false)

		return
	end

	gohelper.setActive(arg_14_0._goroles, true)

	local var_14_0 = Activity104Model.instance:getAct104Retails()
	local var_14_1 = var_14_0 == nil or #var_14_0 == 0
	local var_14_2 = Activity104Model.instance:getLastRetails()

	if var_14_1 and var_14_2 then
		arg_14_0:_battleSuccessRefreshRoles(var_14_2)

		return
	end

	arg_14_0:_normalRefreshRoles(var_14_0, var_14_1, arg_14_1)
end

function var_0_0._battleSuccessRefreshRoles(arg_15_0, arg_15_1)
	for iter_15_0 = 1, 6 do
		gohelper.setActive(arg_15_0["_gorole" .. iter_15_0], false)
	end

	for iter_15_1, iter_15_2 in pairs(arg_15_1) do
		local var_15_0 = iter_15_2.position

		gohelper.setActive(arg_15_0["_gorole" .. var_15_0], true)
		arg_15_0:_playRoleAni(var_15_0, UIAnimationName.Idle)
	end

	arg_15_0.delayRetails = arg_15_1

	TaskDispatcher.runDelay(arg_15_0._onDelayRefreshRoles, arg_15_0, 1)
end

function var_0_0._onDelayRefreshRoles(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.delayRetails) do
		local var_16_0 = iter_16_1.position

		gohelper.setActive(arg_16_0["_gorole" .. var_16_0], true)
		arg_16_0:_playRoleAni(var_16_0, UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(arg_16_0._refreshRoles, arg_16_0, 0.33)
end

function var_0_0._normalRefreshRoles(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {}

	for iter_17_0 = 1, 6 do
		var_17_0[iter_17_0] = false
	end

	for iter_17_1, iter_17_2 in pairs(arg_17_1) do
		local var_17_1 = iter_17_2.position
		local var_17_2 = arg_17_0["_gorole" .. var_17_1]

		var_17_0[var_17_1] = nil

		gohelper.setActive(var_17_2, true)

		if arg_17_3 then
			arg_17_0:_playRoleAni(var_17_1, UIAnimationName.Open, 0, 0)
		else
			arg_17_0:_playRoleAni(var_17_1, UIAnimationName.Idle, 0, 0)
		end
	end

	for iter_17_3, iter_17_4 in pairs(var_17_0) do
		local var_17_3 = arg_17_0["_gorole" .. iter_17_3]

		if var_17_3 then
			if arg_17_3 and var_17_3.activeInHierarchy then
				arg_17_0:_playRoleAni(iter_17_3, UIAnimationName.Close, 0, 0)
			else
				gohelper.setActive(var_17_3, false)
			end
		end
	end

	if arg_17_2 then
		gohelper.setActive(arg_17_0._gospotlight, true)

		if arg_17_0._animspotlight then
			arg_17_0._animspotlight:Play(UIAnimationName.Open, 0, 0)
		end

		return
	end

	if arg_17_3 and arg_17_0._gospotlight and arg_17_0._gospotlight.activeInHierarchy then
		arg_17_0._animspotlight:Play(UIAnimationName.Close, 0, 0)

		return
	end

	gohelper.setActive(arg_17_0._gospotlight, false)
end

function var_0_0._enterMarket(arg_18_0)
	gohelper.setActive(arg_18_0._gospotlight, false)
	arg_18_0:_refreshRoles()
end

function var_0_0._initSceneRootNode(arg_19_0)
	local var_19_0 = arg_19_0._camera.transform.parent
	local var_19_1 = CameraMgr.instance:getSceneRoot()

	arg_19_0._sceneRoot = UnityEngine.GameObject.New("Season3_0MainScene")

	local var_19_2, var_19_3, var_19_4 = transformhelper.getLocalPos(var_19_0)

	transformhelper.setLocalPos(arg_19_0._sceneRoot.transform, 0, var_19_3, 0)
	gohelper.addChild(var_19_1, arg_19_0._sceneRoot)
end

function var_0_0._loadScene(arg_20_0)
	if arg_20_0._sceneGo then
		return
	end

	local var_20_0 = arg_20_0.viewContainer:getSetting()
	local var_20_1 = var_20_0.otherRes.scene

	arg_20_0._sceneGo = arg_20_0.viewContainer:getResInst(var_20_1, arg_20_0._sceneRoot)
	arg_20_0._diffuseGO = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse")
	arg_20_0._goroles = UnityEngine.GameObject.New("juese")

	gohelper.addChild(arg_20_0._diffuseGO, arg_20_0._goroles)
	transformhelper.setLocalPos(arg_20_0._goroles.transform, 0, 0, 0)

	for iter_20_0 = 1, 6 do
		local var_20_2 = var_20_0.otherRes[string.format("role%s", iter_20_0)]

		if var_20_2 then
			local var_20_3 = string.format("_gorole%s", iter_20_0)

			arg_20_0[var_20_3] = arg_20_0.viewContainer:getResInst(var_20_2, arg_20_0._goroles)

			if arg_20_0[var_20_3] then
				arg_20_0[string.format("_aniRole%s", iter_20_0)] = arg_20_0[var_20_3]:GetComponent(typeof(UnityEngine.Animator))
			end
		end
	end

	for iter_20_1 = 1, arg_20_0.sectionCount do
		local var_20_4 = var_20_0.otherRes[string.format("section%s", iter_20_1)]

		if var_20_4 then
			arg_20_0[string.format("_gosection%s", iter_20_1)] = arg_20_0.viewContainer:getResInst(var_20_4, arg_20_0._diffuseGO)
		end
	end

	arg_20_0:_loadSceneFinish()
end

function var_0_0._loadSceneFinish(arg_21_0)
	arg_21_0._gospotlight = gohelper.findChild(arg_21_0._sceneGo, "Obj-Plant/all/diffuse/scanlight")

	if arg_21_0._gospotlight then
		arg_21_0._animspotlight = arg_21_0._gospotlight:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_21_0._sceneAnim = arg_21_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	arg_21_0._goMask = gohelper.findChild(arg_21_0._sceneGo, "root/BackGround/#mask")

	if arg_21_0._goMask then
		arg_21_0._aniMask = arg_21_0._goMask:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(arg_21_0._goroles, false)
	gohelper.setActive(arg_21_0._gospotlight, false)
	arg_21_0:_refreshView()
	arg_21_0:_initLevelupObjs()
	MainCameraMgr.instance:addView(ViewName.Season3_0MainView, arg_21_0.autoInitMainViewCamera, arg_21_0.resetCamera, arg_21_0)
end

function var_0_0.autoInitMainViewCamera(arg_22_0)
	arg_22_0:initCamera(false)
end

function var_0_0._initLevelupObjs(arg_23_0)
	arg_23_0._levelupObjs = {}

	local var_23_0 = {}

	for iter_23_0 = 1, arg_23_0.sectionCount do
		local var_23_1 = arg_23_0:_getGoSection(iter_23_0)

		if var_23_1 then
			local var_23_2 = arg_23_0._levelupObjs[iter_23_0]

			if not var_23_2 then
				var_23_2 = {}
				arg_23_0._levelupObjs[iter_23_0] = var_23_2
			end

			local var_23_3 = gohelper.findChild(var_23_1, "leveup")

			if var_23_3 then
				table.insert(var_23_2, var_23_3)
				gohelper.setActive(var_23_3, false)
			end
		end
	end

	if arg_23_0._waitShowLevelStage then
		arg_23_0:showLevelObjs(arg_23_0._waitShowLevelStage)

		arg_23_0._waitShowLevelStage = nil
	else
		arg_23_0:_hideLevelObjs(true)
	end
end

function var_0_0.showLevelObjs(arg_24_0, arg_24_1)
	if not arg_24_0._levelupObjs then
		arg_24_0._waitShowLevelStage = arg_24_1

		return
	end

	if arg_24_1 > arg_24_0.sectionCount then
		arg_24_0.viewContainer:playUI()

		return
	end

	arg_24_0._sceneAnim:Play(UIAnimationName.Open, 0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_map_upgrade)
	arg_24_0:_hideLevelObjs(true)
	TaskDispatcher.runDelay(arg_24_0._hideLevelObjs, arg_24_0, 1.8)

	local var_24_0 = arg_24_0:_getStageSetting(arg_24_1)
	local var_24_1 = arg_24_0:_getStageSetting(arg_24_1 - 1)
	local var_24_2 = {}

	if var_24_1 then
		for iter_24_0, iter_24_1 in pairs(var_24_1) do
			var_24_2[iter_24_1] = true
		end
	end

	if var_24_0 then
		for iter_24_2, iter_24_3 in pairs(var_24_0) do
			if not var_24_2[iter_24_3] then
				local var_24_3 = arg_24_0._levelupObjs[iter_24_3]

				if var_24_3 then
					for iter_24_4, iter_24_5 in pairs(var_24_3) do
						gohelper.setActive(iter_24_5, true)
					end
				end
			end
		end
	end

	arg_24_0.viewContainer:stopUI()
end

function var_0_0._hideLevelObjs(arg_25_0, arg_25_1)
	TaskDispatcher.cancelTask(arg_25_0._hideLevelObjs, arg_25_0)

	if arg_25_0._levelupObjs then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._levelupObjs) do
			for iter_25_2, iter_25_3 in pairs(iter_25_1) do
				gohelper.setActive(iter_25_3, false)
			end
		end
	end

	if arg_25_1 then
		return
	end

	arg_25_0.viewContainer:playUI()
end

function var_0_0._showStage(arg_26_0)
	local var_26_0 = Activity104Model.instance:getAct104CurStage()
	local var_26_1 = arg_26_0:_getStageSetting(var_26_0)

	gohelper.setActive(arg_26_0._gosection3part2, var_26_0 < arg_26_0.sectionCount - 1)

	for iter_26_0 = 1, arg_26_0.sectionCount do
		arg_26_0:_setGoSectionActive(iter_26_0, false)
	end

	if var_26_1 then
		for iter_26_1, iter_26_2 in pairs(var_26_1) do
			arg_26_0:_setGoSectionActive(iter_26_2, true)
		end
	end
end

function var_0_0._getStageSetting(arg_27_0, arg_27_1)
	return arg_27_0._stageSetting[arg_27_1] or arg_27_0._stageSetting[#arg_27_0._stageSetting]
end

function var_0_0._setGoSectionActive(arg_28_0, arg_28_1, arg_28_2)
	gohelper.setActive(arg_28_0:_getGoSection(arg_28_1), arg_28_2)
end

function var_0_0._getGoSection(arg_29_0, arg_29_1)
	return arg_29_0["_gosection" .. arg_29_1]
end

function var_0_0.onUpdateParam(arg_30_0)
	arg_30_0:_refreshView()
end

function var_0_0.onOpen(arg_31_0)
	arg_31_0:_loadScene()
end

function var_0_0._refreshView(arg_32_0)
	arg_32_0:_showStage()
end

function var_0_0.focusRole(arg_33_0, arg_33_1)
	if not arg_33_1 then
		arg_33_0:cancelFocus()

		return
	end

	arg_33_0:killFocusTween()

	local var_33_0 = string.format("_gorole%s", arg_33_1)
	local var_33_1 = gohelper.findChild(arg_33_0[var_33_0], "vx") or arg_33_0[var_33_0].transform:GetChild(0).gameObject

	if not var_33_1 then
		return
	end

	local var_33_2, var_33_3, var_33_4 = transformhelper.getPos(var_33_1.transform)
	local var_33_5 = arg_33_0.focusTime

	arg_33_0._camera.orthographic = true
	arg_33_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_33_0._camera.transform, var_33_2, var_33_3 - 5.8, 0, var_33_5, arg_33_0.onMoveCompleted, arg_33_0, nil, EaseType.OutCubic)
	arg_33_0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(arg_33_0.seasonCameraOrthographicSize, arg_33_0.focusCameraOrthographicSize, var_33_5, arg_33_0._onSizeUpdate, nil, arg_33_0, nil, EaseType.OutCubic)

	if arg_33_0._aniMask then
		arg_33_0._aniMask:Play(UIAnimationName.Close)
	end
end

function var_0_0.cancelFocus(arg_34_0)
	arg_34_0:killFocusTween()

	local var_34_0 = arg_34_0.cancelFocusTime

	arg_34_0._camera.orthographic = true
	arg_34_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_34_0._camera.transform, arg_34_0.seasonCameraLocalPos.x, arg_34_0.seasonCameraLocalPos.y, arg_34_0.seasonCameraLocalPos.z, var_34_0, arg_34_0._onMoveCompleted, arg_34_0, nil, EaseType.OutCubic)
	arg_34_0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(arg_34_0.focusCameraOrthographicSize, arg_34_0.seasonCameraOrthographicSize, var_34_0, arg_34_0._onSizeUpdate, nil, arg_34_0, nil, EaseType.OutCubic)

	if arg_34_0._aniMask then
		arg_34_0._aniMask:Play(UIAnimationName.Open)
	end
end

function var_0_0._onMoveCompleted(arg_35_0)
	arg_35_0:killFocusTween()
end

function var_0_0._onSizeUpdate(arg_36_0, arg_36_1)
	arg_36_0._camera.orthographicSize = arg_36_1
end

function var_0_0._onOpenFullViewFinish(arg_37_0, arg_37_1)
	if not string.find(arg_37_1, "Season") then
		arg_37_0:doAudio(false)
	end
end

function var_0_0._onOpenViewFinish(arg_38_0, arg_38_1)
	if not arg_38_0._listenerViews[arg_38_1] then
		return
	end

	gohelper.setActive(arg_38_0._goMask, false)

	if arg_38_0._aniMask then
		arg_38_0._aniMask:Play(UIAnimationName.Close)
	end

	arg_38_0:showSceneAnim()
end

function var_0_0._onCloseViewFinish(arg_39_0, arg_39_1)
	if not arg_39_0._listenerViews[arg_39_1] then
		return
	end

	gohelper.setActive(arg_39_0._goMask, true)

	if arg_39_0._aniMask then
		arg_39_0._aniMask:Play(UIAnimationName.Idle)
	end
end

function var_0_0.onClose(arg_40_0)
	arg_40_0:_removeEvents()
end

function var_0_0.killFocusTween(arg_41_0)
	if arg_41_0._tweenId then
		ZProj.TweenHelper.KillById(arg_41_0._tweenId)

		arg_41_0._tweenId = nil
	end

	if arg_41_0._tweenSizeId then
		ZProj.TweenHelper.KillById(arg_41_0._tweenSizeId)

		arg_41_0._tweenSizeId = nil
	end
end

function var_0_0.doAudio(arg_42_0, arg_42_1)
	if arg_42_0.isAudioPlay == arg_42_1 then
		return
	end

	arg_42_0.isAudioPlay = arg_42_1

	if arg_42_1 then
		-- block empty
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
	end
end

function var_0_0._playRoleAni(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = arg_43_0["_aniRole" .. arg_43_1]

	if not var_43_0 then
		return
	end

	if arg_43_3 and arg_43_4 then
		var_43_0:Play(arg_43_2, arg_43_3, arg_43_4)
	else
		var_43_0:Play(arg_43_2)
	end
end

function var_0_0.onDestroyView(arg_44_0)
	arg_44_0:killFocusTween()
	TaskDispatcher.cancelTask(arg_44_0._refreshRoles, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._hideLevelObjs, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._onDelayRefreshRoles, arg_44_0)
	gohelper.destroy(arg_44_0._sceneRoot)

	if arg_44_0._mapLoader then
		arg_44_0._mapLoader:dispose()

		arg_44_0._mapLoader = nil
	end
end

return var_0_0
