module("modules.logic.season.view.SeasonMainScene", package.seeall)

local var_0_0 = class("SeasonMainScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")
	arg_1_0._focusSetting = {
		{
			x = -3.02,
			y = 0.05
		},
		{
			x = -0.26,
			y = -0.61
		},
		{
			x = 2.17,
			y = -0.38
		},
		{
			x = -2.14,
			y = -0.82
		},
		{
			x = -3.28,
			y = -1.33
		},
		{
			x = 1.58,
			y = -1.33
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
		[ViewName.SeasonMarketView] = 1
	}

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
var_0_0.BlockKey = "SeasonMainScene"

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
end

function var_0_0.initCamera(arg_6_0)
	local var_6_0 = false

	if not arg_6_0._initCamaraParam then
		arg_6_0._initCamaraParam = {}
		arg_6_0._initCamaraParam.orthographic = arg_6_0._camera.orthographic
		arg_6_0._initCamaraParam.orthographicSize = arg_6_0._camera.orthographicSize

		local var_6_1 = {}

		var_6_1.x, var_6_1.y, var_6_1.z = transformhelper.getLocalPos(arg_6_0._camera.transform)
		arg_6_0._initCamaraParam.pos = var_6_1
		var_6_0 = true
	end

	transformhelper.setLocalRotation(arg_6_0._camera.transform, 0, 0, 0)
	arg_6_0:_showScenes(var_6_0)
end

function var_0_0.resetCamera(arg_7_0)
	if not arg_7_0._initCamaraParam then
		return
	end

	arg_7_0._camera.orthographicSize = arg_7_0._initCamaraParam.orthographicSize
	arg_7_0._camera.orthographic = arg_7_0._initCamaraParam.orthographic

	transformhelper.setLocalPos(arg_7_0._camera.transform, arg_7_0._initCamaraParam.pos.x, arg_7_0._initCamaraParam.pos.y, arg_7_0._initCamaraParam.pos.z)
end

function var_0_0._onChangeCamera(arg_8_0, arg_8_1)
	arg_8_0._isShowRetail = arg_8_1

	arg_8_0:initCamera()
end

function var_0_0._showScenes(arg_9_0, arg_9_1)
	if not arg_9_0._sceneGo then
		return
	end

	TaskDispatcher.cancelTask(arg_9_0._showScenes, arg_9_0)

	if arg_9_0._isShowRetail then
		if not arg_9_1 then
			arg_9_0._sceneAnim:Play("go1")
		end

		arg_9_0:_enterRetail()
	else
		if not arg_9_1 then
			arg_9_0._sceneAnim:Play("go2")
		end

		arg_9_0:_enterMarket()
	end
end

function var_0_0._enterRetail(arg_10_0)
	arg_10_0._camera.orthographicSize = var_0_0.SeasonCameraOrthographicSize
	arg_10_0._camera.orthographic = true

	transformhelper.setLocalPos(arg_10_0._camera.transform, var_0_0.SeasonCameraLocalPos.x, var_0_0.SeasonCameraLocalPos.y, 0)
	arg_10_0:_refreshRoles()
end

function var_0_0._onRefreshRetail(arg_11_0)
	arg_11_0:_refreshRoles(true)
end

function var_0_0._refreshRoles(arg_12_0, arg_12_1)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	TaskDispatcher.cancelTask(arg_12_0._refreshRoles, arg_12_0)

	if not arg_12_0._isShowRetail then
		gohelper.setActive(arg_12_0._goroles, false)

		return
	end

	gohelper.setActive(arg_12_0._goroles, true)

	local var_12_0 = Activity104Model.instance:getAct104Retails()
	local var_12_1 = var_12_0 == nil or #var_12_0 == 0
	local var_12_2 = Activity104Model.instance:getLastRetails()

	if var_12_1 and var_12_2 then
		arg_12_0:_battleSuccessRefreshRoles(var_12_2)

		return
	end

	arg_12_0:_normalRefreshRoles(var_12_0, var_12_1, arg_12_1)
end

function var_0_0._battleSuccessRefreshRoles(arg_13_0, arg_13_1)
	for iter_13_0 = 1, 6 do
		gohelper.setActive(arg_13_0["_gorole" .. iter_13_0], false)
	end

	for iter_13_1, iter_13_2 in pairs(arg_13_1) do
		local var_13_0 = iter_13_2.position

		gohelper.setActive(arg_13_0["_gorole" .. var_13_0], true)
		arg_13_0["_aniRole" .. var_13_0]:Play(UIAnimationName.Idle)
	end

	arg_13_0.delayRetails = arg_13_1

	TaskDispatcher.runDelay(arg_13_0._onDelayRefreshRoles, arg_13_0, 1)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
end

function var_0_0._onDelayRefreshRoles(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.delayRetails) do
		local var_14_0 = iter_14_1.position

		gohelper.setActive(arg_14_0["_gorole" .. var_14_0], true)
		arg_14_0["_aniRole" .. var_14_0]:Play(UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(arg_14_0._refreshRoles, arg_14_0, 0.33)
end

function var_0_0._normalRefreshRoles(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = {}

	for iter_15_0 = 1, 6 do
		var_15_0[iter_15_0] = false
	end

	for iter_15_1, iter_15_2 in pairs(arg_15_1) do
		local var_15_1 = iter_15_2.position

		var_15_0[var_15_1] = nil

		gohelper.setActive(arg_15_0["_gorole" .. var_15_1], true)

		if arg_15_3 then
			arg_15_0["_aniRole" .. var_15_1]:Play(UIAnimationName.Open, 0, 0)
		else
			arg_15_0["_aniRole" .. var_15_1]:Play(UIAnimationName.Idle, 0, 0)
		end
	end

	for iter_15_3, iter_15_4 in pairs(var_15_0) do
		if arg_15_3 and arg_15_0["_gorole" .. iter_15_3].activeInHierarchy then
			arg_15_0["_aniRole" .. iter_15_3]:Play(UIAnimationName.Close, 0, 0)
		else
			gohelper.setActive(arg_15_0["_gorole" .. iter_15_3], false)
		end
	end

	if arg_15_2 then
		gohelper.setActive(arg_15_0._gospotlight, true)
		arg_15_0._animspotlight:Play(UIAnimationName.Open, 0, 0)

		return
	end

	if arg_15_3 and arg_15_0._gospotlight.activeInHierarchy then
		arg_15_0._animspotlight:Play(UIAnimationName.Close, 0, 0)

		return
	end

	gohelper.setActive(arg_15_0._gospotlight, false)
end

function var_0_0._enterMarket(arg_16_0)
	gohelper.setActive(arg_16_0._gospotlight, false)
	arg_16_0:_refreshRoles()

	arg_16_0._camera.orthographicSize = var_0_0.SeasonCameraOrthographicSize
	arg_16_0._camera.orthographic = true

	transformhelper.setLocalPos(arg_16_0._camera.transform, var_0_0.SeasonCameraLocalPos.x, var_0_0.SeasonCameraLocalPos.y, 0)
end

function var_0_0._initSceneRootNode(arg_17_0)
	local var_17_0 = arg_17_0._camera.transform.parent
	local var_17_1 = CameraMgr.instance:getSceneRoot()

	arg_17_0._sceneRoot = UnityEngine.GameObject.New("SeasonMainScene")

	local var_17_2, var_17_3, var_17_4 = transformhelper.getLocalPos(var_17_0)

	transformhelper.setLocalPos(arg_17_0._sceneRoot.transform, 0, var_17_3, 0)
	gohelper.addChild(var_17_1, arg_17_0._sceneRoot)
end

function var_0_0._loadScene(arg_18_0)
	arg_18_0._mapLoader = MultiAbLoader.New()
	arg_18_0._scenePath = "scenes/m_s15_sjwf_1_1/scene_prefab/m_s15_sjwf_1_1_p.prefab"

	arg_18_0._mapLoader:addPath(arg_18_0._scenePath)
	arg_18_0._mapLoader:startLoad(arg_18_0._loadSceneFinish, arg_18_0)
end

function var_0_0._loadSceneFinish(arg_19_0)
	local var_19_0 = arg_19_0._mapLoader:getAssetItem(arg_19_0._scenePath):GetResource(arg_19_0._scenePath)

	arg_19_0._sceneGo = gohelper.clone(var_19_0, arg_19_0._sceneRoot)
	arg_19_0._goroles = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/juese")
	arg_19_0._gorole1 = gohelper.findChild(arg_19_0._goroles, "m_sjwf_xiaogou_L")
	arg_19_0._gorole2 = gohelper.findChild(arg_19_0._goroles, "m_sjwf_meilanni_R")
	arg_19_0._gorole3 = gohelper.findChild(arg_19_0._goroles, "m_sjwf_xingti_R")
	arg_19_0._gorole4 = gohelper.findChild(arg_19_0._goroles, "m_sjwf_meilanni_L")
	arg_19_0._gorole5 = gohelper.findChild(arg_19_0._goroles, "m_sjwf_xingti_L")
	arg_19_0._gorole6 = gohelper.findChild(arg_19_0._goroles, "m_sjwf_xiaogou_R")

	for iter_19_0 = 1, 6 do
		arg_19_0[string.format("_aniRole%s", iter_19_0)] = arg_19_0[string.format("_gorole%s", iter_19_0)]:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_19_0._gosection1 = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/section01")
	arg_19_0._gosection2 = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/section02")
	arg_19_0._gosection3 = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/section03")
	arg_19_0._gosection3part1 = gohelper.findChild(arg_19_0._gosection3, "m_s15_sjwf_shu_b")

	gohelper.setActive(arg_19_0._gosection3part1, true)

	arg_19_0._gosection3part2 = gohelper.findChild(arg_19_0._gosection3, "m_s15_sjwf_zz_l_l")
	arg_19_0._gosection4 = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/section04")
	arg_19_0._gosection5 = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/section05")
	arg_19_0._gosection6 = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/section06")
	arg_19_0._gospotlight = gohelper.findChild(arg_19_0._sceneGo, "Obj-Plant/all/diffuse/spotlight")
	arg_19_0._animspotlight = arg_19_0._gospotlight:GetComponent(typeof(UnityEngine.Animator))
	arg_19_0._sceneAnim = arg_19_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	arg_19_0._goMask = gohelper.findChild(arg_19_0._sceneGo, "root/BackGround/#mask")
	arg_19_0._aniMask = arg_19_0._goMask:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_19_0._goroles, false)
	gohelper.setActive(arg_19_0._gospotlight, false)
	arg_19_0:_refreshView()
	arg_19_0:_initLevelupObjs()
	arg_19_0:initCamera()
end

function var_0_0._initLevelupObjs(arg_20_0)
	arg_20_0._levelupObjs = {}

	local var_20_0 = {
		"#yunduo",
		"#caihong",
		"m_s15_sjwf_shu_b",
		"#diaozi",
		"#hudie",
		"#jiaoshui",
		"m_s15_sjwf_zz_l_b"
	}

	for iter_20_0 = 1, 6 do
		local var_20_1 = arg_20_0:_getGoSection(iter_20_0)

		if var_20_1 then
			local var_20_2 = arg_20_0._levelupObjs[iter_20_0]

			if not var_20_2 then
				var_20_2 = {}
				arg_20_0._levelupObjs[iter_20_0] = var_20_2
			end

			local var_20_3 = gohelper.findChild(var_20_1, "leveup")

			if var_20_3 then
				table.insert(var_20_2, var_20_3)
			end

			for iter_20_1, iter_20_2 in pairs(var_20_0) do
				local var_20_4 = gohelper.findChild(var_20_1, string.format("%s/leveup", iter_20_2))

				if var_20_4 then
					table.insert(var_20_2, var_20_4)
				end
			end
		end
	end

	if arg_20_0._waitShowLevelStage then
		arg_20_0:showLevelObjs(arg_20_0._waitShowLevelStage)

		arg_20_0._waitShowLevelStage = nil
	else
		arg_20_0:_hideLevelObjs(true)
	end
end

function var_0_0.showLevelObjs(arg_21_0, arg_21_1)
	if not arg_21_0._levelupObjs then
		arg_21_0._waitShowLevelStage = arg_21_1

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_map_upgrade)
	arg_21_0:_hideLevelObjs(true)
	TaskDispatcher.runDelay(arg_21_0._hideLevelObjs, arg_21_0, 1.8)

	local var_21_0 = arg_21_0:_getStageSetting(arg_21_1)
	local var_21_1 = arg_21_0:_getStageSetting(arg_21_1 - 1)
	local var_21_2 = {}

	if var_21_1 then
		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			var_21_2[iter_21_1] = true
		end
	end

	if var_21_0 then
		for iter_21_2, iter_21_3 in pairs(var_21_0) do
			if not var_21_2[iter_21_3] then
				local var_21_3 = arg_21_0._levelupObjs[iter_21_3]

				if var_21_3 then
					for iter_21_4, iter_21_5 in pairs(var_21_3) do
						gohelper.setActive(iter_21_5, true)
					end
				end
			end
		end
	end

	local var_21_4 = ViewMgr.instance:getContainer(ViewName.SeasonMainView)

	if var_21_4 then
		var_21_4:stopUI(false)
	end
end

function var_0_0._hideLevelObjs(arg_22_0, arg_22_1)
	TaskDispatcher.cancelTask(arg_22_0._hideLevelObjs, arg_22_0)

	if arg_22_0._levelupObjs then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._levelupObjs) do
			for iter_22_2, iter_22_3 in pairs(iter_22_1) do
				gohelper.setActive(iter_22_3, false)
			end
		end
	end

	if arg_22_1 then
		return
	end

	local var_22_0 = ViewMgr.instance:getContainer(ViewName.SeasonMainView)

	if var_22_0 then
		var_22_0:playUI(true)
	end
end

function var_0_0._showStage(arg_23_0)
	local var_23_0 = Activity104Model.instance:getAct104CurStage()
	local var_23_1 = arg_23_0:_getStageSetting(var_23_0)

	if var_23_0 == 3 or var_23_0 == 4 then
		gohelper.setActive(arg_23_0._gosection3part2, true)
	else
		gohelper.setActive(arg_23_0._gosection3part2, false)
	end

	for iter_23_0 = 1, 6 do
		arg_23_0:_setGoSectionActive(iter_23_0, false)
	end

	if var_23_1 then
		for iter_23_1, iter_23_2 in pairs(var_23_1) do
			arg_23_0:_setGoSectionActive(iter_23_2, true)
		end
	end
end

function var_0_0._getStageSetting(arg_24_0, arg_24_1)
	return arg_24_0._stageSetting[arg_24_1] or arg_24_0._stageSetting[6]
end

function var_0_0._setGoSectionActive(arg_25_0, arg_25_1, arg_25_2)
	gohelper.setActive(arg_25_0:_getGoSection(arg_25_1), arg_25_2)
end

function var_0_0._getGoSection(arg_26_0, arg_26_1)
	return arg_26_0["_gosection" .. arg_26_1]
end

function var_0_0.onUpdateParam(arg_27_0)
	arg_27_0:_refreshView()
end

function var_0_0.onOpen(arg_28_0)
	return
end

function var_0_0._refreshView(arg_29_0)
	arg_29_0:_showStage()
end

function var_0_0.focusRole(arg_30_0, arg_30_1)
	if not arg_30_1 then
		arg_30_0:cancelFocus()

		return
	end

	arg_30_0:killFocusTween()

	local var_30_0 = arg_30_0._focusSetting[arg_30_1]

	if not var_30_0 then
		return
	end

	local var_30_1 = var_0_0.FocusTime

	arg_30_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_30_0._camera.transform, var_30_0.x, var_30_0.y, 0, var_30_1, arg_30_0._onMoveCompleted, arg_30_0, nil, EaseType.OutCubic)
	arg_30_0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(var_0_0.SeasonCameraOrthographicSize, var_0_0.FocusCameraOrthographicSize, var_30_1, arg_30_0._onSizeUpdate, nil, arg_30_0, nil, EaseType.OutCubic)

	arg_30_0._aniMask:Play(UIAnimationName.Close)
end

function var_0_0.cancelFocus(arg_31_0)
	arg_31_0:killFocusTween()

	local var_31_0 = var_0_0.CancelFocusTime

	arg_31_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_31_0._camera.transform, var_0_0.SeasonCameraLocalPos.x, var_0_0.SeasonCameraLocalPos.y, 0, var_31_0, arg_31_0._onMoveCompleted, arg_31_0, nil, EaseType.OutCubic)
	arg_31_0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(var_0_0.FocusCameraOrthographicSize, var_0_0.SeasonCameraOrthographicSize, var_31_0, arg_31_0._onSizeUpdate, nil, arg_31_0, nil, EaseType.OutCubic)

	arg_31_0._aniMask:Play(UIAnimationName.Open)
end

function var_0_0._onMoveCompleted(arg_32_0)
	return
end

function var_0_0._onSizeUpdate(arg_33_0, arg_33_1)
	arg_33_0._camera.orthographicSize = arg_33_1
end

function var_0_0._onOpenViewFinish(arg_34_0, arg_34_1)
	if not arg_34_0._listenerViews[arg_34_1] then
		return
	end

	gohelper.setActive(arg_34_0._goMask, false)

	if arg_34_0._aniMask then
		arg_34_0._aniMask:Play(UIAnimationName.Close)
	end
end

function var_0_0._onCloseViewFinish(arg_35_0, arg_35_1)
	if not arg_35_0._listenerViews[arg_35_1] then
		return
	end

	gohelper.setActive(arg_35_0._goMask, true)

	if arg_35_0._aniMask then
		arg_35_0._aniMask:Play(UIAnimationName.Idle)
	end
end

function var_0_0.onClose(arg_36_0)
	arg_36_0:resetCamera()
	arg_36_0:_removeEvents()
end

function var_0_0._removeEvents(arg_37_0)
	arg_37_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_37_0._onRefreshRetail, arg_37_0)
	arg_37_0:removeEventCb(Activity104Controller.instance, Activity104Event.ChangeCameraSize, arg_37_0._onChangeCamera, arg_37_0)
	arg_37_0:removeEventCb(Activity104Controller.instance, Activity104Event.SelectRetail, arg_37_0.focusRole, arg_37_0)
	arg_37_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_37_0._onOpenViewFinish, arg_37_0)
	arg_37_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_37_0._onCloseViewFinish, arg_37_0)
end

function var_0_0.killFocusTween(arg_38_0)
	if arg_38_0._tweenId then
		ZProj.TweenHelper.KillById(arg_38_0._tweenId)

		arg_38_0._tweenId = nil
	end

	if arg_38_0._tweenSizeId then
		ZProj.TweenHelper.KillById(arg_38_0._tweenSizeId)

		arg_38_0._tweenSizeId = nil
	end
end

function var_0_0.onDestroyView(arg_39_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	arg_39_0:killFocusTween()
	TaskDispatcher.cancelTask(arg_39_0._refreshRoles, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._hideLevelObjs, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._onDelayRefreshRoles, arg_39_0)
	gohelper.destroy(arg_39_0._sceneRoot)

	if arg_39_0._mapLoader then
		arg_39_0._mapLoader:dispose()

		arg_39_0._mapLoader = nil
	end
end

return var_0_0
