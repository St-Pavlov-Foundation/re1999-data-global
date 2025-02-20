module("modules.logic.season.view1_2.Season1_2MainScene", package.seeall)

slot0 = class("Season1_2MainScene", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._gotoptipsbg = gohelper.findChild(slot0.viewGO, "#go_main/#go_toptipsbg")
	slot0._focusSetting = {
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
	slot0._stageSetting = {
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
	slot0._listenerViews = {
		[ViewName.Season1_2MarketView] = 1,
		[ViewName.Season1_2SpecialMarketView] = 1
	}
	slot0.isFirst = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.SeasonCameraOrthographicSize = 3.85
slot0.SeasonCameraLocalPos = Vector2(-0.65, -0.28)
slot0.FocusCameraOrthographicSize = 2
slot0.FocusTime = 0.45
slot0.CancelFocusTime = 0.45

function slot0._editableInitView(slot0)
	slot0._camera = CameraMgr.instance:getMainCamera()

	slot0:_initSceneRootNode()
	slot0:_loadScene()
	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, slot0._onRefreshRetail, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.ChangeCameraSize, slot0._onChangeCamera, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.SelectRetail, slot0.focusRole, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, slot0._onRefreshRetail, slot0)
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.ChangeCameraSize, slot0._onChangeCamera, slot0)
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.SelectRetail, slot0.focusRole, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenViewFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0)
end

function slot0.initCamera(slot0, slot1)
	transformhelper.setLocalRotation(slot0._camera.transform, 0, 0, 0)

	if not slot0._tweenId then
		slot0._camera.orthographicSize = uv0.SeasonCameraOrthographicSize
		slot0._camera.orthographic = true

		transformhelper.setLocalPos(slot0._camera.transform, uv0.SeasonCameraLocalPos.x, uv0.SeasonCameraLocalPos.y, 0)
	end

	if slot1 == nil then
		slot1 = false
	end

	slot0:_showScenes(slot1)
end

function slot0.resetCamera(slot0)
	if not slot0._initCamaraParam then
		return
	end

	slot0._initCamaraParam = nil

	slot0:doAudio(false)
end

function slot0._onChangeCamera(slot0, slot1)
	slot0:initCamera(slot1)
end

function slot0._showScenes(slot0, slot1)
	if not slot0._sceneGo then
		return
	end

	if slot0._isShowRetail == slot1 then
		return
	end

	slot0._isShowRetail = slot1
	slot2, slot3 = nil

	if slot0.isFirst then
		slot2 = "open"
	end

	if slot0._isShowRetail then
		slot2 = "go1"

		if slot0.isFirst then
			slot3 = 1
		end

		slot0:_enterRetail()
	else
		if not slot0.isFirst then
			slot2 = "go2"
		end

		slot0:_enterMarket()
	end

	for slot7, slot8 in pairs(slot0._listenerViews) do
		if ViewMgr.instance:isOpen(slot7) then
			slot3 = 1

			break
		end
	end

	if slot0._sceneAnim and slot2 then
		if slot3 then
			slot0._sceneAnim:Play(slot2, 0, slot3)
		else
			slot0._sceneAnim:Play(slot2)
		end
	end

	slot0:doAudio(true)

	slot0.isFirst = false
end

function slot0._enterRetail(slot0)
	slot0:_refreshRoles()
end

function slot0._onRefreshRetail(slot0)
	slot0:_refreshRoles(true)
end

function slot0._refreshRoles(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._refreshRoles, slot0)

	if not slot0._isShowRetail then
		gohelper.setActive(slot0._goroles, false)

		return
	end

	gohelper.setActive(slot0._goroles, true)

	slot4 = Activity104Model.instance:getLastRetails()

	if (Activity104Model.instance:getAct104Retails() == nil or #slot2 == 0) and slot4 then
		slot0:_battleSuccessRefreshRoles(slot4)

		return
	end

	slot0:_normalRefreshRoles(slot2, slot3, slot1)
end

function slot0._battleSuccessRefreshRoles(slot0, slot1)
	for slot5 = 1, 6 do
		gohelper.setActive(slot0["_gorole" .. slot5], false)
	end

	for slot5, slot6 in pairs(slot1) do
		slot7 = slot6.position

		gohelper.setActive(slot0["_gorole" .. slot7], true)
		slot0["_aniRole" .. slot7]:Play(UIAnimationName.Idle)
	end

	slot0.delayRetails = slot1

	TaskDispatcher.runDelay(slot0._onDelayRefreshRoles, slot0, 1)
end

function slot0._onDelayRefreshRoles(slot0)
	for slot4, slot5 in pairs(slot0.delayRetails) do
		slot6 = slot5.position

		gohelper.setActive(slot0["_gorole" .. slot6], true)
		slot0["_aniRole" .. slot6]:Play(UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(slot0._refreshRoles, slot0, 0.33)
end

function slot0._normalRefreshRoles(slot0, slot1, slot2, slot3)
	slot4 = {
		[slot8] = false
	}

	for slot8 = 1, 6 do
	end

	for slot8, slot9 in pairs(slot1) do
		slot10 = slot9.position
		slot4[slot10] = nil

		gohelper.setActive(slot0["_gorole" .. slot10], true)

		if slot0["_aniRole" .. slot10] then
			if slot3 then
				slot12:Play(UIAnimationName.Open, 0, 0)
			else
				slot12:Play(UIAnimationName.Idle, 0, 0)
			end
		end
	end

	for slot8, slot9 in pairs(slot4) do
		if slot0["_gorole" .. slot8] then
			slot11 = slot0["_aniRole" .. slot8]

			if slot3 and slot10.activeInHierarchy then
				if slot11 then
					slot11:Play(UIAnimationName.Close, 0, 0)
				end
			else
				gohelper.setActive(slot10, false)
			end
		end
	end

	if slot2 then
		gohelper.setActive(slot0._gospotlight, true)

		if slot0._animspotlight then
			slot0._animspotlight:Play(UIAnimationName.Open, 0, 0)
		end

		return
	end

	if slot3 and slot0._gospotlight and slot0._gospotlight.activeInHierarchy then
		slot0._animspotlight:Play(UIAnimationName.Close, 0, 0)

		return
	end

	gohelper.setActive(slot0._gospotlight, false)
end

function slot0._enterMarket(slot0)
	gohelper.setActive(slot0._gospotlight, false)
	slot0:_refreshRoles()
end

function slot0._initSceneRootNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("Season1_2MainScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(slot0._camera.transform.parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0._loadScene(slot0)
	slot0._mapLoader = MultiAbLoader.New()
	slot0._scenePath = "scenes/m_s15_sj_yfyt_1_2/scene_prefab/m_s15_sj_yfyt_a.prefab"

	slot0._mapLoader:addPath(slot0._scenePath)
	slot0._mapLoader:startLoad(slot0._loadSceneFinish, slot0)
end

function slot0._loadSceneFinish(slot0)
	slot0._sceneGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot0._scenePath):GetResource(slot0._scenePath), slot0._sceneRoot)
	slot0._goroles = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/juese")
	slot0._gorole1 = gohelper.findChild(slot0._goroles, "jiexika_a_1")
	slot0._gorole2 = gohelper.findChild(slot0._goroles, "yaxian_a_2")
	slot0._gorole3 = gohelper.findChild(slot0._goroles, "kongbutong_3")
	slot0._gorole4 = gohelper.findChild(slot0._goroles, "jiexika_b_4")
	slot0._gorole5 = gohelper.findChild(slot0._goroles, "jinmier_5")
	slot5 = "yaxian_b_6"
	slot0._gorole6 = gohelper.findChild(slot0._goroles, slot5)

	for slot5 = 1, 6 do
		if slot0[string.format("_gorole%s", slot5)] then
			slot0[string.format("_aniRole%s", slot5)] = slot6:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	slot0._gosection1 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/section01")
	slot0._gosection2 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/section02")
	slot0._gosection3 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/section03")
	slot0._gosection3part1 = gohelper.findChild(slot0._gosection3, "m_s15_sj_yfyt_shu_a")
	slot0._gosection3part2 = gohelper.findChild(slot0._gosection3, "m_s15_sj_yfyt_lzhizhu_b")
	slot0._gosection4 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/section04")
	slot0._gosection5 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/section05")
	slot0._gosection6 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/section06")
	slot0._gospotlight = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/scanlight")

	if slot0._gospotlight then
		slot0._animspotlight = slot0._gospotlight:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._sceneAnim = slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._goMask = gohelper.findChild(slot0._sceneGo, "root/BackGround/#mask")

	if slot0._goMask then
		slot0._aniMask = slot0._goMask:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(slot0._goroles, false)
	gohelper.setActive(slot0._gospotlight, false)
	slot0:_refreshView()
	slot0:_initLevelupObjs()
	MainCameraMgr.instance:addView(ViewName.Season1_2MainView, slot0.autoInitMainViewCamera, slot0.resetCamera, slot0)
end

function slot0.autoInitMainViewCamera(slot0)
	slot0:initCamera(false)
end

function slot0._initLevelupObjs(slot0)
	slot0._levelupObjs = {}
	slot1 = {}

	for slot5 = 1, 6 do
		if slot0:_getGoSection(slot5) then
			if not slot0._levelupObjs[slot5] then
				slot0._levelupObjs[slot5] = {}
			end

			if gohelper.findChild(slot6, "leveup") then
				table.insert(slot7, slot8)
				gohelper.setActive(slot8, false)
			end
		end
	end

	if slot0._waitShowLevelStage then
		slot0:showLevelObjs(slot0._waitShowLevelStage)

		slot0._waitShowLevelStage = nil
	else
		slot0:_hideLevelObjs(true)
	end
end

function slot0.showLevelObjs(slot0, slot1)
	if not slot0._levelupObjs then
		slot0._waitShowLevelStage = slot1

		return
	end

	slot0._sceneAnim:Play(UIAnimationName.Open, 0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_map_upgrade)
	slot0:_hideLevelObjs(true)
	TaskDispatcher.runDelay(slot0._hideLevelObjs, slot0, 1.8)

	slot2 = slot0:_getStageSetting(slot1)
	slot4 = {}

	if slot0:_getStageSetting(slot1 - 1) then
		for slot8, slot9 in pairs(slot3) do
			slot4[slot9] = true
		end
	end

	if slot2 then
		for slot8, slot9 in pairs(slot2) do
			if not slot4[slot9] and slot0._levelupObjs[slot9] then
				for slot14, slot15 in pairs(slot10) do
					gohelper.setActive(slot15, true)
				end
			end
		end
	end

	if ViewMgr.instance:getContainer(ViewName.Season1_2MainView) then
		slot5:stopUI(false)
	end
end

function slot0._hideLevelObjs(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._hideLevelObjs, slot0)

	if slot0._levelupObjs then
		for slot5, slot6 in pairs(slot0._levelupObjs) do
			for slot10, slot11 in pairs(slot6) do
				gohelper.setActive(slot11, false)
			end
		end
	end

	if slot1 then
		return
	end

	if ViewMgr.instance:getContainer(ViewName.Season1_2MainView) then
		slot2:playUI(true)
	end
end

function slot0._showStage(slot0)
	slot1 = Activity104Model.instance:getAct104CurStage()
	slot2 = slot0:_getStageSetting(slot1)

	gohelper.setActive(slot0._gosection3part2, slot1 < 5)

	for slot6 = 1, 6 do
		slot0:_setGoSectionActive(slot6, false)
	end

	if slot2 then
		for slot6, slot7 in pairs(slot2) do
			slot0:_setGoSectionActive(slot7, true)
		end
	end
end

function slot0._getStageSetting(slot0, slot1)
	return slot0._stageSetting[slot1] or slot0._stageSetting[6]
end

function slot0._setGoSectionActive(slot0, slot1, slot2)
	gohelper.setActive(slot0:_getGoSection(slot1), slot2)
end

function slot0._getGoSection(slot0, slot1)
	return slot0["_gosection" .. slot1]
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshView()
end

function slot0.onOpen(slot0)
end

function slot0._refreshView(slot0)
	slot0:_showStage()
end

function slot0.focusRole(slot0, slot1)
	if not slot1 then
		slot0:cancelFocus()

		return
	end

	slot0:killFocusTween()

	if not slot0._focusSetting[slot1] then
		return
	end

	slot3 = uv0.FocusTime
	slot0._camera.orthographic = true
	slot0._tweenId = ZProj.TweenHelper.DOLocalMove(slot0._camera.transform, slot2.x, slot2.y, 0, slot3, slot0.onMoveCompleted, slot0, nil, EaseType.OutCubic)
	slot0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(uv0.SeasonCameraOrthographicSize, uv0.FocusCameraOrthographicSize, slot3, slot0._onSizeUpdate, nil, slot0, nil, EaseType.OutCubic)

	if slot0._aniMask then
		slot0._aniMask:Play(UIAnimationName.Close)
	end
end

function slot0.cancelFocus(slot0)
	slot0:killFocusTween()

	slot1 = uv0.CancelFocusTime
	slot0._camera.orthographic = true
	slot0._tweenId = ZProj.TweenHelper.DOLocalMove(slot0._camera.transform, uv0.SeasonCameraLocalPos.x, uv0.SeasonCameraLocalPos.y, 0, slot1, slot0._onMoveCompleted, slot0, nil, EaseType.OutCubic)
	slot0._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(uv0.FocusCameraOrthographicSize, uv0.SeasonCameraOrthographicSize, slot1, slot0._onSizeUpdate, nil, slot0, nil, EaseType.OutCubic)

	if slot0._aniMask then
		slot0._aniMask:Play(UIAnimationName.Open)
	end
end

function slot0._onMoveCompleted(slot0)
	slot0:killFocusTween()
end

function slot0._onSizeUpdate(slot0, slot1)
	slot0._camera.orthographicSize = slot1
end

function slot0._onOpenFullViewFinish(slot0, slot1)
	if not slot0._listenerFullViews then
		slot0._listenerFullViews = {
			[ViewName.Season1_2MainView] = 1,
			[ViewName.Season1_2RetailView] = 1
		}
	end

	if not slot0._listenerFullViews[slot1] then
		slot0:doAudio(false)
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if not slot0._listenerViews[slot1] then
		return
	end

	gohelper.setActive(slot0._goMask, false)

	if slot0._aniMask then
		slot0._aniMask:Play(UIAnimationName.Close)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if not slot0._listenerViews[slot1] then
		return
	end

	gohelper.setActive(slot0._goMask, true)

	if slot0._aniMask then
		slot0._aniMask:Play(UIAnimationName.Idle)
	end
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0.killFocusTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._tweenSizeId then
		ZProj.TweenHelper.KillById(slot0._tweenSizeId)

		slot0._tweenSizeId = nil
	end
end

function slot0.doAudio(slot0, slot1)
	if slot0.isAudioPlay == slot1 then
		return
	end

	slot0.isAudioPlay = slot1

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_activity_seasonmainamb_1_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function slot0.onDestroyView(slot0)
	slot0:killFocusTween()
	TaskDispatcher.cancelTask(slot0._refreshRoles, slot0)
	TaskDispatcher.cancelTask(slot0._hideLevelObjs, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayRefreshRoles, slot0)
	gohelper.destroy(slot0._sceneRoot)

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end
end

return slot0
