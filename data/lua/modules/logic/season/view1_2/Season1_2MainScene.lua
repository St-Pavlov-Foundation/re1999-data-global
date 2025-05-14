module("modules.logic.season.view1_2.Season1_2MainScene", package.seeall)

local var_0_0 = class("Season1_2MainScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")
	arg_1_0._focusSetting = {
		{
			x = -4.56,
			y = -1.32
		},
		{
			x = 0.95,
			y = 0.98
		},
		{
			x = 0.61,
			y = -1.46
		},
		{
			x = 3.4,
			y = -0.78
		},
		{
			x = -2.05,
			y = -2.6
		},
		{
			x = 1.09,
			y = -2.48
		}
	}
	arg_1_0._stageSetting = {
		{
			1
		},
		{
			1,
			2
		},
		{
			2,
			3
		},
		{
			2,
			3,
			4
		},
		{
			2,
			3,
			4,
			5
		},
		{
			2,
			3,
			4,
			5,
			6
		}
	}
	arg_1_0._listenerViews = {
		[ViewName.Season1_2MarketView] = 1,
		[ViewName.Season1_2SpecialMarketView] = 1
	}
	arg_1_0.isFirst = true

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

var_0_0.SeasonCameraOrthographicSize = 3.85
var_0_0.SeasonCameraLocalPos = Vector2(-0.65, -0.28)
var_0_0.FocusCameraOrthographicSize = 2
var_0_0.FocusTime = 0.45
var_0_0.CancelFocusTime = 0.45

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._camera = CameraMgr.instance:getMainCamera()

	arg_4_0:_initSceneRootNode()
	arg_4_0:_loadScene()
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
		arg_7_0._camera.orthographicSize = var_0_0.SeasonCameraOrthographicSize
		arg_7_0._camera.orthographic = true

		transformhelper.setLocalPos(arg_7_0._camera.transform, var_0_0.SeasonCameraLocalPos.x, var_0_0.SeasonCameraLocalPos.y, 0)
	end

	if arg_7_1 == nil then
		arg_7_1 = false
	end

	arg_7_0:_showScenes(arg_7_1)
end

function var_0_0.resetCamera(arg_8_0)
	if not arg_8_0._initCamaraParam then
		return
	end

	arg_8_0._initCamaraParam = nil

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

function var_0_0._enterRetail(arg_11_0)
	arg_11_0:_refreshRoles()
end

function var_0_0._onRefreshRetail(arg_12_0)
	arg_12_0:_refreshRoles(true)
end

function var_0_0._refreshRoles(arg_13_0, arg_13_1)
	TaskDispatcher.cancelTask(arg_13_0._refreshRoles, arg_13_0)

	if not arg_13_0._isShowRetail then
		gohelper.setActive(arg_13_0._goroles, false)

		return
	end

	gohelper.setActive(arg_13_0._goroles, true)

	local var_13_0 = Activity104Model.instance:getAct104Retails()
	local var_13_1 = var_13_0 == nil or #var_13_0 == 0
	local var_13_2 = Activity104Model.instance:getLastRetails()

	if var_13_1 and var_13_2 then
		arg_13_0:_battleSuccessRefreshRoles(var_13_2)

		return
	end

	arg_13_0:_normalRefreshRoles(var_13_0, var_13_1, arg_13_1)
end

function var_0_0._battleSuccessRefreshRoles(arg_14_0, arg_14_1)
	for iter_14_0 = 1, 6 do
		gohelper.setActive(arg_14_0["_gorole" .. iter_14_0], false)
	end

	for iter_14_1, iter_14_2 in pairs(arg_14_1) do
		local var_14_0 = iter_14_2.position

		gohelper.setActive(arg_14_0["_gorole" .. var_14_0], true)
		arg_14_0["_aniRole" .. var_14_0]:Play(UIAnimationName.Idle)
	end

	arg_14_0.delayRetails = arg_14_1

	TaskDispatcher.runDelay(arg_14_0._onDelayRefreshRoles, arg_14_0, 1)
end

function var_0_0._onDelayRefreshRoles(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.delayRetails) do
		local var_15_0 = iter_15_1.position

		gohelper.setActive(arg_15_0["_gorole" .. var_15_0], true)
		arg_15_0["_aniRole" .. var_15_0]:Play(UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(arg_15_0._refreshRoles, arg_15_0, 0.33)
end

function var_0_0._normalRefreshRoles(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {}

	for iter_16_0 = 1, 6 do
		var_16_0[iter_16_0] = false
	end

	for iter_16_1, iter_16_2 in pairs(arg_16_1) do
		local var_16_1 = iter_16_2.position
		local var_16_2 = arg_16_0["_gorole" .. var_16_1]
		local var_16_3 = arg_16_0["_aniRole" .. var_16_1]

		var_16_0[var_16_1] = nil

		gohelper.setActive(var_16_2, true)

		if var_16_3 then
			if arg_16_3 then
				var_16_3:Play(UIAnimationName.Open, 0, 0)
			else
				var_16_3:Play(UIAnimationName.Idle, 0, 0)
			end
		end
	end

	for iter_16_3, iter_16_4 in pairs(var_16_0) do
		local var_16_4 = arg_16_0["_gorole" .. iter_16_3]

		if var_16_4 then
			local var_16_5 = arg_16_0["_aniRole" .. iter_16_3]

			if arg_16_3 and var_16_4.activeInHierarchy then
				if var_16_5 then
					var_16_5:Play(UIAnimationName.Close, 0, 0)
				end
			else
				gohelper.setActive(var_16_4, false)
			end
		end
	end

	if arg_16_2 then
		gohelper.setActive(arg_16_0._gospotlight, true)

		if arg_16_0._animspotlight then
			arg_16_0._animspotlight:Play(UIAnimationName.Open, 0, 0)
		end

		return
	end

	if arg_16_3 and arg_16_0._gospotlight and arg_16_0._gospotlight.activeInHierarchy then
		arg_16_0._animspotlight:Play(UIAnimationName.Close, 0, 0)

		return
	end

	gohelper.setActive(arg_16_0._gospotlight, false)
end

function var_0_0._enterMarket(arg_17_0)
	gohelper.setActive(arg_17_0._gospotlight, false)
	arg_17_0:_refreshRoles()
end

function var_0_0._initSceneRootNode(arg_18_0)
	local var_18_0 = arg_18_0._camera.transform.parent
	local var_18_1 = CameraMgr.instance:getSceneRoot()

	arg_18_0._sceneRoot = UnityEngine.GameObject.New("Season1_2MainScene")

	local var_18_2, var_18_3, var_18_4 = transformhelper.getLocalPos(var_18_0)

	transformhelper.setLocalPos(arg_18_0._sceneRoot.transform, 0, var_18_3, 0)
	gohelper.addChild(var_18_1, arg_18_0._sceneRoot)
end

function var_0_0._loadScene(arg_19_0)
	arg_19_0._mapLoader = MultiAbLoader.New()
	arg_19_0._scenePath = "scenes/m_s15_sj_yfyt_1_2/scene_prefab/m_s15_sj_yfyt_a.prefab"

	arg_19_0._mapLoader:addPath(arg_19_0._scenePath)
	arg_19_0._mapLoader:startLoad(arg_19_0._loadSceneFinish, arg_19_0)
end

function var_0_0._loadSceneFinish(arg_20_0)
	local var_20_0 = arg_20_0._mapLoader:getAssetItem(arg_20_0._scenePath):GetResource(arg_20_0._scenePath)

	arg_20_0._sceneGo = gohelper.clone(var_20_0, arg_20_0._sceneRoot)
	arg_20_0._goroles = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/juese")
	arg_20_0._gorole1 = gohelper.findChild(arg_20_0._goroles, "jiexika_a_1")
	arg_20_0._gorole2 = gohelper.findChild(arg_20_0._goroles, "yaxian_a_2")
	arg_20_0._gorole3 = gohelper.findChild(arg_20_0._goroles, "kongbutong_3")
	arg_20_0._gorole4 = gohelper.findChild(arg_20_0._goroles, "jiexika_b_4")
	arg_20_0._gorole5 = gohelper.findChild(arg_20_0._goroles, "jinmier_5")
	arg_20_0._gorole6 = gohelper.findChild(arg_20_0._goroles, "yaxian_b_6")

	for iter_20_0 = 1, 6 do
		local var_20_1 = arg_20_0[string.format("_gorole%s", iter_20_0)]

		if var_20_1 then
			arg_20_0[string.format("_aniRole%s", iter_20_0)] = var_20_1:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	arg_20_0._gosection1 = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/section01")
	arg_20_0._gosection2 = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/section02")
	arg_20_0._gosection3 = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/section03")
	arg_20_0._gosection3part1 = gohelper.findChild(arg_20_0._gosection3, "m_s15_sj_yfyt_shu_a")
	arg_20_0._gosection3part2 = gohelper.findChild(arg_20_0._gosection3, "m_s15_sj_yfyt_lzhizhu_b")
	arg_20_0._gosection4 = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/section04")
	arg_20_0._gosection5 = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/section05")
	arg_20_0._gosection6 = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/section06")
	arg_20_0._gospotlight = gohelper.findChild(arg_20_0._sceneGo, "Obj-Plant/all/diffuse/scanlight")

	if arg_20_0._gospotlight then
		arg_20_0._animspotlight = arg_20_0._gospotlight:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_20_0._sceneAnim = arg_20_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	arg_20_0._goMask = gohelper.findChild(arg_20_0._sceneGo, "root/BackGround/#mask")

	if arg_20_0._goMask then
		arg_20_0._aniMask = arg_20_0._goMask:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(arg_20_0._goroles, false)
	gohelper.setActive(arg_20_0._gospotlight, false)
	arg_20_0:_refreshView()
	arg_20_0:_initLevelupObjs()
	MainCameraMgr.instance:addView(ViewName.Season1_2MainView, arg_20_0.autoInitMainViewCamera, arg_20_0.resetCamera, arg_20_0)
end

function var_0_0.autoInitMainViewCamera(arg_21_0)
	arg_21_0:initCamera(false)
end

function var_0_0._initLevelupObjs(arg_22_0)
	arg_22_0._levelupObjs = {}

	local var_22_0 = {}

	for iter_22_0 = 1, 6 do
		local var_22_1 = arg_22_0:_getGoSection(iter_22_0)

		if var_22_1 then
			local var_22_2 = arg_22_0._levelupObjs[iter_22_0]

			if not var_22_2 then
				var_22_2 = {}
				arg_22_0._levelupObjs[iter_22_0] = var_22_2
			end

			local var_22_3 = gohelper.findChild(var_22_1, "leveup")

			if var_22_3 then
				table.insert(var_22_2, var_22_3)
				gohelper.setActive(var_22_3, false)
			end
		end
	end

	if arg_22_0._waitShowLevelStage then
		arg_22_0:showLevelObjs(arg_22_0._waitShowLevelStage)

		arg_22_0._waitShowLevelStage = nil
	else
		arg_22_0:_hideLevelObjs(true)
	end
end

function var_0_0.showLevelObjs(arg_23_0, arg_23_1)
	if not arg_23_0._levelupObjs then
		arg_23_0._waitShowLevelStage = arg_23_1

		return
	end

	arg_23_0._sceneAnim:Play(UIAnimationName.Open, 0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_map_upgrade)
	arg_23_0:_hideLevelObjs(true)
	TaskDispatcher.runDelay(arg_23_0._hideLevelObjs, arg_23_0, 1.8)

	local var_23_0 = arg_23_0:_getStageSetting(arg_23_1)
	local var_23_1 = arg_23_0:_getStageSetting(arg_23_1 - 1)
	local var_23_2 = {}

	if var_23_1 then
		for iter_23_0, iter_23_1 in pairs(var_23_1) do
			var_23_2[iter_23_1] = true
		end
	end

	if var_23_0 then
		for iter_23_2, iter_23_3 in pairs(var_23_0) do
			if not var_23_2[iter_23_3] then
				local var_23_3 = arg_23_0._levelupObjs[iter_23_3]

				if var_23_3 then
					for iter_23_4, iter_23_5 in pairs(var_23_3) do
						gohelper.setActive(iter_23_5, true)
					end
				end
			end
		end
	end

	local var_23_4 = ViewMgr.instance:getContainer(ViewName.Season1_2MainView)

	if var_23_4 then
		var_23_4:stopUI(false)
	end
end

function var_0_0._hideLevelObjs(arg_24_0, arg_24_1)
	TaskDispatcher.cancelTask(arg_24_0._hideLevelObjs, arg_24_0)

	if arg_24_0._levelupObjs then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._levelupObjs) do
			for iter_24_2, iter_24_3 in pairs(iter_24_1) do
				gohelper.setActive(iter_24_3, false)
			end
		end
	end

	if arg_24_1 then
		return
	end

	local var_24_0 = ViewMgr.instance:getContainer(ViewName.Season1_2MainView)

	if var_24_0 then
		var_24_0:playUI(true)
	end
end

function var_0_0._showStage(arg_25_0)
	local var_25_0 = Activity104Model.instance:getAct104CurStage()
	local var_25_1 = arg_25_0:_getStageSetting(var_25_0)

	gohelper.setActive(arg_25_0._gosection3part2, var_25_0 < 5)

	for iter_25_0 = 1, 6 do
		arg_25_0:_setGoSectionActive(iter_25_0, false)
	end

	if var_25_1 then
		for iter_25_1, iter_25_2 in pairs(var_25_1) do
			arg_25_0:_setGoSectionActive(iter_25_2, true)
		end
	end
end

function var_0_0._getStageSetting(arg_26_0, arg_26_1)
	return arg_26_0._stageSetting[arg_26_1] or arg_26_0._stageSetting[6]
end

function var_0_0._setGoSectionActive(arg_27_0, arg_27_1, arg_27_2)
	gohelper.setActive(arg_27_0:_getGoSection(arg_27_1), arg_27_2)
end

function var_0_0._getGoSection(arg_28_0, arg_28_1)
	return arg_28_0["_gosection" .. arg_28_1]
end

function var_0_0.onUpdateParam(arg_29_0)
	arg_29_0:_refreshView()
end

function var_0_0.onOpen(arg_30_0)
	return
end

function var_0_0._refreshView(arg_31_0)
	arg_31_0:_showStage()
end

function var_0_0.focusRole(arg_32_0, arg_32_1)
	if not arg_32_1 then
		arg_32_0:cancelFocus()

		return
	end

	arg_32_0:killFocusTween()

	local var_32_0 = arg_32_0._focusSetting[arg_32_1]

	if not var_32_0 then
		return
	end

	local var_32_1 = var_0_0.FocusTime

	arg_32_0._camera.orthographic = true
	arg_32_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_32_0._camera.transform, var_32_0.x, var_32_0.y, 0, var_32_1, arg_32_0.onMoveCompleted, arg_32_0, nil, EaseType.OutCubic)
	arg_32_0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(var_0_0.SeasonCameraOrthographicSize, var_0_0.FocusCameraOrthographicSize, var_32_1, arg_32_0._onSizeUpdate, nil, arg_32_0, nil, EaseType.OutCubic)

	if arg_32_0._aniMask then
		arg_32_0._aniMask:Play(UIAnimationName.Close)
	end
end

function var_0_0.cancelFocus(arg_33_0)
	arg_33_0:killFocusTween()

	local var_33_0 = var_0_0.CancelFocusTime

	arg_33_0._camera.orthographic = true
	arg_33_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_33_0._camera.transform, var_0_0.SeasonCameraLocalPos.x, var_0_0.SeasonCameraLocalPos.y, 0, var_33_0, arg_33_0._onMoveCompleted, arg_33_0, nil, EaseType.OutCubic)
	arg_33_0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(var_0_0.FocusCameraOrthographicSize, var_0_0.SeasonCameraOrthographicSize, var_33_0, arg_33_0._onSizeUpdate, nil, arg_33_0, nil, EaseType.OutCubic)

	if arg_33_0._aniMask then
		arg_33_0._aniMask:Play(UIAnimationName.Open)
	end
end

function var_0_0._onMoveCompleted(arg_34_0)
	arg_34_0:killFocusTween()
end

function var_0_0._onSizeUpdate(arg_35_0, arg_35_1)
	arg_35_0._camera.orthographicSize = arg_35_1
end

function var_0_0._onOpenFullViewFinish(arg_36_0, arg_36_1)
	if not arg_36_0._listenerFullViews then
		arg_36_0._listenerFullViews = {
			[ViewName.Season1_2MainView] = 1,
			[ViewName.Season1_2RetailView] = 1
		}
	end

	if not arg_36_0._listenerFullViews[arg_36_1] then
		arg_36_0:doAudio(false)
	end
end

function var_0_0._onOpenViewFinish(arg_37_0, arg_37_1)
	if not arg_37_0._listenerViews[arg_37_1] then
		return
	end

	gohelper.setActive(arg_37_0._goMask, false)

	if arg_37_0._aniMask then
		arg_37_0._aniMask:Play(UIAnimationName.Close)
	end
end

function var_0_0._onCloseViewFinish(arg_38_0, arg_38_1)
	if not arg_38_0._listenerViews[arg_38_1] then
		return
	end

	gohelper.setActive(arg_38_0._goMask, true)

	if arg_38_0._aniMask then
		arg_38_0._aniMask:Play(UIAnimationName.Idle)
	end
end

function var_0_0.onClose(arg_39_0)
	arg_39_0:_removeEvents()
end

function var_0_0.killFocusTween(arg_40_0)
	if arg_40_0._tweenId then
		ZProj.TweenHelper.KillById(arg_40_0._tweenId)

		arg_40_0._tweenId = nil
	end

	if arg_40_0._tweenSizeId then
		ZProj.TweenHelper.KillById(arg_40_0._tweenSizeId)

		arg_40_0._tweenSizeId = nil
	end
end

function var_0_0.doAudio(arg_41_0, arg_41_1)
	if arg_41_0.isAudioPlay == arg_41_1 then
		return
	end

	arg_41_0.isAudioPlay = arg_41_1

	if arg_41_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_activity_seasonmainamb_1_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0:killFocusTween()
	TaskDispatcher.cancelTask(arg_42_0._refreshRoles, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._hideLevelObjs, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._onDelayRefreshRoles, arg_42_0)
	gohelper.destroy(arg_42_0._sceneRoot)

	if arg_42_0._mapLoader then
		arg_42_0._mapLoader:dispose()

		arg_42_0._mapLoader = nil
	end
end

return var_0_0
