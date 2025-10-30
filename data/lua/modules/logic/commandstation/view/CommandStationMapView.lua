module("modules.logic.commandstation.view.CommandStationMapView", package.seeall)

local var_0_0 = class("CommandStationMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_FullBG")
	arg_1_0._goevents = gohelper.findChild(arg_1_0.viewGO, "#go_bg/#go_events")
	arg_1_0._goVersion = gohelper.findChild(arg_1_0.viewGO, "#go_Version")
	arg_1_0._btnEvent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Event/#btn_Event")
	arg_1_0._txtEvent = gohelper.findChildText(arg_1_0.viewGO, "Event/#txt_Event")
	arg_1_0._goTimeAxis = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis")
	arg_1_0._scrolltimeline = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline")
	arg_1_0._goViewport = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport")
	arg_1_0._gotimeGroup = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup")
	arg_1_0._gotimeItem = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup/#go_timeItem")
	arg_1_0._goScale = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup/#go_Scale")
	arg_1_0._btnLocation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup/#go_Scale/#btn_Location")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#go_mask")
	arg_1_0._goleftViewport = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport")
	arg_1_0._goleftContent = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent")
	arg_1_0._goversionItem = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent/#go_versionItem")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_spine")
	arg_1_0._goani = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_spine/#go_ani")
	arg_1_0._btnSort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#btn_Sort")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#btn_Sort/#go_Selected")
	arg_1_0._goSelectedBG = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#btn_Sort/#go_Selected/#go_SelectedBG")
	arg_1_0._goversionname = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname")
	arg_1_0._btnblockversion = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#btn_blockversion")
	arg_1_0._gonameViewport = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport")
	arg_1_0._gonameContent = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent")
	arg_1_0._gonameItem = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent/#go_nameItem")
	arg_1_0._goarrowcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_arrowcontainer")
	arg_1_0._btnLeftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_arrowcontainer/#btn_LeftArrow")
	arg_1_0._btnRightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_arrowcontainer/#btn_RightArrow")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._goscene = gohelper.findChild(arg_1_0.viewGO, "#go_scene")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEvent:AddClickListener(arg_2_0._btnEventOnClick, arg_2_0)
	arg_2_0._btnLocation:AddClickListener(arg_2_0._btnLocationOnClick, arg_2_0)
	arg_2_0._btnSort:AddClickListener(arg_2_0._btnSortOnClick, arg_2_0)
	arg_2_0._btnblockversion:AddClickListener(arg_2_0._btnblockversionOnClick, arg_2_0)
	arg_2_0._btnLeftArrow:AddClickListener(arg_2_0._btnLeftArrowOnClick, arg_2_0)
	arg_2_0._btnRightArrow:AddClickListener(arg_2_0._btnRightArrowOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEvent:RemoveClickListener()
	arg_3_0._btnLocation:RemoveClickListener()
	arg_3_0._btnSort:RemoveClickListener()
	arg_3_0._btnblockversion:RemoveClickListener()
	arg_3_0._btnLeftArrow:RemoveClickListener()
	arg_3_0._btnRightArrow:RemoveClickListener()
end

function var_0_0._btnLeftArrowOnClick(arg_4_0)
	arg_4_0.viewContainer:getMapEventView():FocuseLeftEvent()
end

function var_0_0._btnRightArrowOnClick(arg_5_0)
	arg_5_0.viewContainer:getMapEventView():FocuseRightEvent()
end

function var_0_0._btnblockversionOnClick(arg_6_0)
	arg_6_0._sortAnimator:Play("unselect", arg_6_0._hideVersionDone, arg_6_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.HideVersionSelectView)
	arg_6_0:_openTimelineAnim()
	arg_6_0:_selectedTimePoint(arg_6_0._timeId, CommandStationEnum.TimelineOpenTime)

	if arg_6_0._uiSpine then
		arg_6_0._uiSpine:play("gear_pop")
	end
end

function var_0_0._hideVersionDone(arg_7_0)
	gohelper.setActive(arg_7_0._goSelected, false)
	gohelper.setActive(arg_7_0._goversionname, false)
end

function var_0_0._btnSortOnClick(arg_8_0)
	CommandStationController.StatCommandStationButtonClick(arg_8_0.viewName, string.format("btnSortOnClick_"))

	if CommandStationMapModel.instance:isTimelineCharacterMode() then
		return
	end

	if arg_8_0._uiSpine then
		arg_8_0._uiSpine:play("axle_press")
	end

	gohelper.setActive(arg_8_0._goSelected, true)
	gohelper.setActive(arg_8_0._goversionname, true)
	arg_8_0._sortAnimator:Play("select", arg_8_0._showVersionDone, arg_8_0)
	arg_8_0:_tweenMove(nil, CommandStationEnum.BuoyMoveTime, 0, arg_8_0._moveToInit)
end

function var_0_0._showVersionDone(arg_9_0)
	return
end

function var_0_0._moveToInit(arg_10_0)
	arg_10_0:_closeTimelineAnim()
end

function var_0_0._btnEventOnClick(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_switch)

	local var_11_0 = CommandStationMapModel.instance:getEventCategory()

	if var_11_0 == CommandStationEnum.EventCategory.Normal then
		CommandStationMapModel.instance:setEventCategory(CommandStationEnum.EventCategory.Character)
	else
		CommandStationMapModel.instance:setEventCategory(CommandStationEnum.EventCategory.Normal)
	end

	CommandStationController.StatCommandStationButtonClick(arg_11_0.viewName, "btnEventOnClick_" .. CommandStationMapModel.instance:getEventCategory(), var_11_0)
	arg_11_0:_updateEventCategory()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.ChangeEventCategory)
	arg_11_0._eventAnimator:Play("light", 0, 0)
end

function var_0_0._btnLocationOnClick(arg_12_0)
	local var_12_0 = CommandStationMapModel.instance:getTimeId()

	CommandStationController.instance:openCommandStationDetailView({
		timeId = var_12_0
	})

	if CommandStationMapModel.instance:isTimelineCharacterMode() then
		local var_12_1 = CommandStationMapModel.instance:getCharacterId()

		CommandStationController.StatCommandStationButtonClick(arg_12_0.viewName, string.format("btnLocationOnClick_%s_%s", var_12_1, var_12_0))
	else
		local var_12_2 = CommandStationMapModel.instance:getVersionId()

		CommandStationController.StatCommandStationButtonClick(arg_12_0.viewName, string.format("btnLocationOnClick_%s_%s", var_12_2, var_12_0))
	end
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._viewOpenTime = Time.realtimeSinceStartup
	arg_13_0._goversion = gohelper.findChild(arg_13_0.viewGO, "Version")
	arg_13_0._goevent = gohelper.findChild(arg_13_0.viewGO, "Event")
	arg_13_0._gosort = gohelper.findChild(arg_13_0.viewGO, "#go_TimeAxis/go/timeline/Sort")
	arg_13_0._sortAnimator = SLFramework.AnimatorPlayer.Get(arg_13_0._gosort)
	arg_13_0._versionAnimator = SLFramework.AnimatorPlayer.Get(arg_13_0._goversion)

	gohelper.setActive(arg_13_0._goSelected, false)
	gohelper.setActive(arg_13_0._goversionname, false)
	gohelper.setActive(arg_13_0._btnLeftArrow, false)
	gohelper.setActive(arg_13_0._btnRightArrow, false)

	arg_13_0._animator = arg_13_0.viewGO:GetComponent("Animator")
	arg_13_0._eventAnimator = arg_13_0._goevent:GetComponent("Animator")

	CommandStationMapModel.instance:setEventCategory(CommandStationEnum.EventCategory.Normal)
	arg_13_0:_updateEventCategory()
	arg_13_0:_initShowRT()
end

function var_0_0._initShowRT(arg_14_0)
	arg_14_0._rtGo = gohelper.findChild(arg_14_0.viewGO, "rt")

	gohelper.setActive(arg_14_0._rtGo, true)
end

function var_0_0._initSceneRoot(arg_15_0)
	local var_15_0 = CommandStationMapModel.instance:getCurTimeIdScene()

	if not var_15_0 then
		return
	end

	arg_15_0._sceneConfig = var_15_0

	local var_15_1 = var_15_0.scene_ui

	PrefabInstantiate.Create(arg_15_0._goscene):startLoad(var_15_1, arg_15_0._loadSceneUIFinished, arg_15_0)
end

function var_0_0._loadSceneUIFinished(arg_16_0, arg_16_1)
	arg_16_0._sceneInstanceGo = arg_16_1:getInstGO()
	arg_16_0._sceneRoot = gohelper.findChild(arg_16_0._sceneInstanceGo, "root")

	local var_16_0 = CommandStationMapSceneView.getFov(CommandStationEnum.CameraFov)

	gohelper.findChild(arg_16_0._sceneRoot, "ground_01"):GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial:SetFloat("_Fov", var_16_0)
	gohelper.findChild(arg_16_0._sceneRoot, "ground_02"):GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial:SetFloat("_Fov", var_16_0)
	TaskDispatcher.cancelTask(arg_16_0._updateScene, arg_16_0)
	TaskDispatcher.runRepeat(arg_16_0._updateScene, arg_16_0, 0)
end

function var_0_0._updateScene(arg_17_0)
	local var_17_0 = arg_17_0.viewContainer:getSceneGo()

	if not var_17_0 then
		return
	end

	local var_17_1 = gohelper.findChild(var_17_0, arg_17_0._sceneConfig.scene_node)

	if not var_17_1 then
		return
	end

	local var_17_2 = CameraMgr.instance:getMainCameraTrs():InverseTransformPoint(var_17_1.transform.position)

	arg_17_0._sceneRoot.transform.localPosition = var_17_2

	transformhelper.setLocalRotation(arg_17_0._sceneRoot.transform, CommandStationEnum.CameraRotaionMax - CommandStationEnum.CameraRotation, 0, 0)
end

function var_0_0._hideSceneRoot(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._updateScene, arg_18_0)
	gohelper.setActive(arg_18_0._sceneInstanceGo, false)
end

function var_0_0._updateEventCategory(arg_19_0)
	if CommandStationMapModel.instance:getEventCategory() == CommandStationEnum.EventCategory.Normal then
		arg_19_0._txtEvent.text = luaLang("commandstation_map_event")
	else
		arg_19_0._txtEvent.text = luaLang("commandstation_map_character")
	end
end

function var_0_0._onSpineLoaded(arg_20_0)
	if arg_20_0._uiSpine then
		arg_20_0._uiSpine:play("gear_pop")

		local var_20_0 = arg_20_0._uiSpine._spineGo

		recthelper.setAnchor(var_20_0.transform, 2, -220)
		transformhelper.setLocalScale(var_20_0.transform, 0.51, 0.51, 1)

		arg_20_0._uiSpine:getSkeletonGraphic().timeScale = 6
	end
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._uiSpine = GuiSpine.Create(arg_21_0._goani, true)

	local var_21_0 = "command_post"
	local var_21_1 = ResUrl.getRolesCgStory(var_21_0, "v3a0_command_post")

	arg_21_0._uiSpine:setResPath(var_21_1, arg_21_0._onSpineLoaded, arg_21_0)
	arg_21_0:_initTimeline()
	gohelper.setActive(arg_21_0._gotimeGroup, false)
	arg_21_0:_setDungeonMapViewVisible(false)

	arg_21_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_21_0._scrolltimeline.gameObject)

	arg_21_0._drag:AddDragBeginListener(arg_21_0._onDragBeginHandler, arg_21_0)
	arg_21_0._drag:AddDragEndListener(arg_21_0._onDragEndHandler, arg_21_0)
	arg_21_0:_onScreenResize()
	arg_21_0:addEventCb(CommandStationController.instance, CommandStationEvent.ChangeVersionId, arg_21_0._onChangeVersionId, arg_21_0)
	arg_21_0:addEventCb(CommandStationController.instance, CommandStationEvent.MoveTimeline, arg_21_0._onMoveTimeline, arg_21_0)
	arg_21_0:addEventCb(CommandStationController.instance, CommandStationEvent.TimelineAnimDone, arg_21_0._onTimelineAnimDone, arg_21_0)
	arg_21_0:addEventCb(CommandStationController.instance, CommandStationEvent.MoveScene, arg_21_0._onMoveScene, arg_21_0)
	arg_21_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_21_0._onOpenView, arg_21_0)
	arg_21_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_21_0._onCloseView, arg_21_0)
	arg_21_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_21_0._OnCloseViewFinish, arg_21_0)
	arg_21_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_21_0._OnCloseFullView, arg_21_0, LuaEventSystem.Low)
	arg_21_0:addEventCb(PostProcessingMgr.instance, PostProcessingEvent.onRefreshPopUpBlurNotBlur, arg_21_0._OnRefreshPopUpBlurNotBlur, arg_21_0, LuaEventSystem.Low)
	arg_21_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_21_0._onScreenResize, arg_21_0)
end

function var_0_0._onScreenResize(arg_22_0)
	local var_22_0 = recthelper.getWidth(arg_22_0._goarrowcontainer.transform)
	local var_22_1 = recthelper.getHeight(arg_22_0._goarrowcontainer.transform)
	local var_22_2 = recthelper.getWidth(arg_22_0._btnRightArrow.transform)

	arg_22_0._minX = -var_22_0 / 2 + var_22_2 / 2 + 100
	arg_22_0._maxX = var_22_0 / 2 - var_22_2 / 2
	arg_22_0._minY = -var_22_1 / 2 + 440
	arg_22_0._maxY = var_22_1 / 2 + 440
end

function var_0_0._onMoveScene(arg_23_0, arg_23_1)
	TaskDispatcher.cancelTask(arg_23_0._checkShowArrow, arg_23_0)

	if arg_23_1 then
		TaskDispatcher.runRepeat(arg_23_0._checkShowArrow, arg_23_0, 0, 20)

		return
	end

	arg_23_0:_checkShowArrow()
end

function var_0_0._checkShowArrow(arg_24_0)
	if arg_24_0._hideAllArrow then
		gohelper.setActive(arg_24_0._btnLeftArrow, false)
		gohelper.setActive(arg_24_0._btnRightArrow, false)

		return
	end

	local var_24_0, var_24_1 = arg_24_0.viewContainer:getMapEventView():checkEventsDir()

	gohelper.setActive(arg_24_0._btnLeftArrow, var_24_0 ~= nil)
	gohelper.setActive(arg_24_0._btnRightArrow, var_24_1 ~= nil)

	if var_24_0 then
		arg_24_0:_faceToEvent(arg_24_0._btnLeftArrow, var_24_0)
	end

	if var_24_1 then
		arg_24_0:_faceToEvent(arg_24_0._btnRightArrow, var_24_1)
	end
end

function var_0_0._faceToEvent(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = recthelper.getAnchor(arg_25_2.viewGO.transform)
	local var_25_2, var_25_3 = recthelper.getAnchor(arg_25_1.transform)
	local var_25_4 = var_25_2 - var_25_0
	local var_25_5 = var_25_3 - var_25_1
	local var_25_6 = Mathf.Atan2(var_25_5, var_25_4) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(arg_25_1.transform, 0, 0, var_25_6)

	local var_25_7 = var_25_0
	local var_25_8 = var_25_1
	local var_25_9 = Mathf.Clamp(var_25_7, arg_25_0._minX, arg_25_0._maxX)
	local var_25_10 = Mathf.Clamp(var_25_8, arg_25_0._minY, arg_25_0._maxY)

	recthelper.setAnchor(arg_25_1.transform, var_25_9, var_25_10)
end

function var_0_0._setArrowVisible(arg_26_0, arg_26_1)
	arg_26_0._hideAllArrow = not arg_26_1

	arg_26_0:_checkShowArrow()
end

function var_0_0._OnRefreshPopUpBlurNotBlur(arg_27_0)
	local var_27_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if var_27_0 and not gohelper.isNil(var_27_0.viewGO) then
		gohelper.setAsLastSibling(arg_27_0.viewGO)

		return
	end

	arg_27_0:removeEventCb(PostProcessingMgr.instance, PostProcessingEvent.onRefreshPopUpBlurNotBlur, arg_27_0._OnRefreshPopUpBlurNotBlur, arg_27_0)
end

function var_0_0._OnCloseViewFinish(arg_28_0, arg_28_1)
	if arg_28_1 == arg_28_0.viewName then
		arg_28_0:_setDungeonMapViewVisible(true)
	end
end

function var_0_0._OnCloseFullView(arg_29_0, arg_29_1)
	if arg_29_1 == arg_29_0.viewName then
		arg_29_0:_setDungeonMapViewVisible(false)
	end
end

function var_0_0._setDungeonMapViewVisible(arg_30_0, arg_30_1)
	local var_30_0 = ViewMgr.instance:getContainer(ViewName.DungeonMapView)

	if var_30_0 then
		var_30_0:setVisibleInternal(arg_30_1)
	end
end

function var_0_0._onDragBeginHandler(arg_31_0)
	if arg_31_0._uiSpine then
		arg_31_0._uiSpine:play("gear_loop", true)
	end
end

function var_0_0._onDragEndHandler(arg_32_0)
	if arg_32_0._uiSpine then
		arg_32_0._uiSpine:play("gear_stop")
	end
end

function var_0_0._onTimelineAnimDone(arg_33_0, arg_33_1)
	if arg_33_1 then
		arg_33_0:_setItemGapWidth(1, 0)
	end
end

function var_0_0.onOpenFinish(arg_34_0)
	arg_34_0._isOpenFinished = true

	arg_34_0:_selectedTimePoint(CommandStationMapModel.instance:getTimeId(), CommandStationEnum.TimelineOpenTime)
	arg_34_0:_openTimelineAnim()
	arg_34_0:_hideSceneRoot()
	TaskDispatcher.cancelTask(arg_34_0._hideRT, arg_34_0)
	TaskDispatcher.runDelay(arg_34_0._hideRT, arg_34_0, 0.5)
end

function var_0_0._hideRT(arg_35_0)
	gohelper.setActive(arg_35_0._rtGo, false)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.RTGoHide)
end

function var_0_0.onUpdateParam(arg_36_0)
	arg_36_0._timeId = CommandStationMapModel.instance:getTimeId()

	arg_36_0:_changeTimeline()
end

function var_0_0._onMoveTimeline(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1 and arg_37_1.node

	if gohelper.isNil(var_37_0) then
		gohelper.addChild(arg_37_0.viewGO, arg_37_0._goTimeAxis)
		gohelper.setSiblingAfter(arg_37_0._golefttop, arg_37_0._goTimeAxis)

		arg_37_0._animator.enabled = true

		arg_37_0._animator:Play("timelinein")
		gohelper.setActive(arg_37_0._btnSort, true)
	else
		gohelper.addChild(var_37_0, arg_37_0._goTimeAxis)
		gohelper.setSiblingAfter(arg_37_1.leftopNode, arg_37_0._goTimeAxis)

		arg_37_0._animator.enabled = true

		arg_37_0._animator:Play("timelinein")
		gohelper.setActive(arg_37_0._btnSort, false)
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)
	end

	arg_37_0:_changeTimeline()
	arg_37_0:_selectedTimePoint(CommandStationMapModel.instance:getTimeId())
end

function var_0_0._changeTimelinePosView(arg_38_0, arg_38_1)
	return arg_38_1 == ViewName.CommandStationTimelineEventView
end

function var_0_0._onChildViewOpen(arg_39_0, arg_39_1)
	arg_39_0._animator.enabled = true

	arg_39_0._animator:Play(arg_39_1)
	arg_39_0:_setArrowVisible(false)
	arg_39_0.viewContainer:showHelp(false)
end

function var_0_0._onOpenView(arg_40_0, arg_40_1)
	if arg_40_0:_changeTimelinePosView(arg_40_1) then
		arg_40_0:_onChildViewOpen("eventin")

		return
	end

	if arg_40_1 == ViewName.CommandStationDialogueEventView then
		arg_40_0:_onChildViewOpen("uiout")

		return
	end

	if arg_40_1 == ViewName.CommandStationDispatchEventMainView then
		arg_40_0:_onChildViewOpen("dispatchin")

		return
	end

	if arg_40_1 == ViewName.CommandStationCharacterEventView then
		arg_40_0:_onChildViewOpen("timelineout")

		return
	end
end

function var_0_0._onChildViewClose(arg_41_0, arg_41_1)
	arg_41_0._animator.enabled = true

	arg_41_0._animator:Play(arg_41_1)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.CancelSelectedEvent)
	arg_41_0:_setArrowVisible(true)
	arg_41_0.viewContainer:showHelp(true)
end

function var_0_0._onCloseView(arg_42_0, arg_42_1)
	if arg_42_0:_changeTimelinePosView(arg_42_1) then
		arg_42_0:_onChildViewClose("eventout")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end

	if arg_42_1 == ViewName.CommandStationDialogueEventView then
		arg_42_0:_onChildViewClose("uiin")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end

	if arg_42_1 == ViewName.CommandStationDispatchEventMainView then
		arg_42_0:_onChildViewClose("dispatchout")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end

	if arg_42_1 == ViewName.CommandStationCharacterEventView then
		arg_42_0:_onChildViewClose("timelinein")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end
end

function var_0_0._openTimelineAnim(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:_getTimePointPos(arg_43_0._timeId, true)
	local var_43_1 = recthelper.getWidth(arg_43_0._goViewport.transform)
	local var_43_2 = arg_43_0._timeGroupWidth - var_43_0
	local var_43_3 = math.min(0, var_43_1 - arg_43_0._timeGroupWidth + var_43_2)

	arg_43_0:_setItemGapWidth(1, CommandStationEnum.TimeItemWidth * 2)
	arg_43_0.viewContainer:getTimelineAnimView():openTimelineAnim(arg_43_0._itemPosMap, var_43_3, arg_43_0._timeGroupWidth, arg_43_1)
end

function var_0_0._closeTimelineAnim(arg_44_0)
	arg_44_0.viewContainer:getTimelineAnimView():closeTimelineAnim(arg_44_0._itemPosMap, arg_44_0._timeGroupWidth)
end

function var_0_0._onChangeVersionId(arg_45_0, arg_45_1)
	arg_45_0._timeId = CommandStationMapModel.instance:getTimeId()

	arg_45_0:_changeTimeline()
	arg_45_0._sortAnimator:Play("unselect", arg_45_0._hideVersionDone, arg_45_0)

	if arg_45_0._uiSpine then
		arg_45_0._uiSpine:play("gear_pop")
	end
end

function var_0_0._changeTimeline(arg_46_0)
	arg_46_0:_initTimeline()
	arg_46_0:_openTimelineAnim()
	arg_46_0:_selectedTimePoint(arg_46_0._timeId, CommandStationEnum.TimelineOpenTime)
end

function var_0_0._initTimeline(arg_47_0)
	if not arg_47_0._clickImageParam then
		arg_47_0._clickImageParam = arg_47_0:getUserDataTb_()
	end

	gohelper.addChild(nil, arg_47_0._goScale)
	arg_47_0:_initTimelineData()

	arg_47_0._itemPosX = 0
	arg_47_0._itemPosMap = arg_47_0._itemPosMap or {}

	arg_47_0:_clearItemPosMap()
	gohelper.CreateObjList(arg_47_0, arg_47_0._onTimeItemShow, arg_47_0._timeline, arg_47_0._gotimeGroup, arg_47_0._gotimeItem)

	arg_47_0._timeGroupWidth = arg_47_0._itemPosX

	recthelper.setWidth(arg_47_0._gotimeGroup.transform, arg_47_0._timeGroupWidth)
	gohelper.addChild(arg_47_0._gotimeGroup, arg_47_0._goScale)

	for iter_47_0, iter_47_1 in ipairs(arg_47_0._itemPosMap) do
		gohelper.setAsFirstSibling(iter_47_1.go)
	end
end

function var_0_0._clearItemPosMap(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0._itemPosMap) do
		if iter_48_1.tweenId then
			ZProj.TweenHelper.KillById(iter_48_1.tweenId)
		end

		arg_48_0._itemPosMap[iter_48_0] = nil
	end
end

function var_0_0._initTimelineData(arg_49_0)
	if CommandStationMapModel.instance:getCharacterId() then
		local var_49_0 = CommandStationConfig.instance:getTimeGroupByCharacterId(CommandStationMapModel.instance:getCharacterId())

		arg_49_0._timeline = CommandStationMapModel.instance:checkTimeline(var_49_0)

		return
	end

	local var_49_1 = CommandStationMapModel.instance:getVersionId()

	arg_49_0._timeline = CommandStationMapModel.instance:getVersionTimeline(var_49_1)

	CommandStationController.StatCommandStationButtonClick(arg_49_0.viewName, string.format("getVersionTimeLine_%s", var_49_1))
end

function var_0_0._onTimeItemShow(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = gohelper.findChild(arg_50_1, "image")
	local var_50_1 = gohelper.findChild(arg_50_1, "gap")
	local var_50_2 = true

	gohelper.setActive(var_50_1, var_50_2)

	local var_50_3 = gohelper.findChildText(arg_50_1, "image/txt_Date")

	if var_50_3 then
		var_50_3.text = CommandStationConfig.instance:getTimePointName(arg_50_2.id)
	end

	local var_50_4 = CommandStationEnum.TimeItemWidth * (#arg_50_2.timeId + 1)

	recthelper.setWidth(var_50_0.transform, var_50_4)

	arg_50_0._itemPosMap[arg_50_3] = {
		posX = arg_50_0._itemPosX,
		go = arg_50_1,
		gap = var_50_1
	}

	recthelper.setAnchorX(arg_50_1.transform, arg_50_0._itemPosX)

	if var_50_2 then
		local var_50_5 = arg_50_3 == 1 and CommandStationEnum.TimeItemWidth * 20 or math.min(arg_50_0._itemPosX, CommandStationEnum.TimeItemWidth * 8)

		recthelper.setWidth(var_50_1.transform, var_50_5)
	end

	arg_50_0._itemPosX = arg_50_0._itemPosX + var_50_4 + CommandStationEnum.TimeItemSpace

	arg_50_0:_addImageClick(var_50_0, arg_50_2, arg_50_3)
end

function var_0_0._setItemGapWidth(arg_51_0, arg_51_1, arg_51_2)
	return
end

function var_0_0._addImageClick(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = arg_52_0._clickImageParam[arg_52_1]

	if not var_52_0 then
		local var_52_1 = SLFramework.UGUI.UIClickListener.Get(arg_52_1)

		var_52_0 = {
			clickListener = var_52_1
		}
		arg_52_0._clickImageParam[arg_52_1] = var_52_0

		var_52_1:AddClickListener(arg_52_0._onClickImage, arg_52_0, arg_52_1)
	end

	var_52_0.data = arg_52_2
	var_52_0.index = arg_52_3
end

function var_0_0._onClickImage(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	local var_53_0 = arg_53_0._clickImageParam[arg_53_1]
	local var_53_1 = recthelper.screenPosToAnchorPos(arg_53_2, arg_53_1.transform).x
	local var_53_2

	for iter_53_0 = 1, #var_53_0.data.timeId do
		local var_53_3 = CommandStationEnum.TimeItemWidth * iter_53_0

		if var_53_1 >= var_53_3 - CommandStationEnum.ClickOffset and var_53_1 <= var_53_3 + CommandStationEnum.ClickOffset then
			var_53_2 = iter_53_0

			break
		end
	end

	if not var_53_2 then
		return
	end

	local var_53_4 = var_53_0.data.timeId[var_53_2]

	arg_53_0:_selectedTimePoint(var_53_4)

	if CommandStationMapModel.instance:isTimelineCharacterMode() then
		local var_53_5 = CommandStationMapModel.instance:getCharacterId()

		CommandStationController.StatCommandStationButtonClick(arg_53_0.viewName, string.format("selectedTimePoint_%s_%s", var_53_5, var_53_4))
	else
		local var_53_6 = CommandStationMapModel.instance:getVersionId()

		CommandStationController.StatCommandStationButtonClick(arg_53_0.viewName, string.format("selectedTimePoint_%s_%s", var_53_6, var_53_4))
	end
end

function var_0_0._selectedTimePoint(arg_54_0, arg_54_1, arg_54_2)
	if not arg_54_1 then
		logError("timeId is nil")

		return
	end

	arg_54_0._timeId = arg_54_1

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_zhizhen1)

	local var_54_0 = arg_54_0:_getTimePointPos(arg_54_1)

	arg_54_0:_tweenMove(arg_54_1, arg_54_2 or CommandStationEnum.BuoyMoveTime, var_54_0, arg_54_0._moveDone)
end

function var_0_0._moveDone(arg_55_0, arg_55_1)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectTimePoint, arg_55_1)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.stop_ui_lushang_zhihuibu_zhizhen2)
end

function var_0_0._tweenMove(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	UIBlockHelper.instance:startBlock("CommandStationMapView:_tweenMove", arg_56_2)
	arg_56_0:_killTween()

	arg_56_0._moveTweenId = CommandStationController.CustomOutBack(arg_56_0._goScale.transform, arg_56_2, arg_56_3, CommandStationEnum.TimeItemWidth / 2, arg_56_4, arg_56_0, arg_56_1)
end

function var_0_0._killTween(arg_57_0)
	if arg_57_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_57_0._moveTweenId)

		arg_57_0._moveTweenId = nil
	end
end

function var_0_0._getTimePointPos(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in ipairs(arg_58_0._timeline) do
		local var_58_1 = tabletool.indexOf(iter_58_1.timeId, arg_58_1)
		local var_58_2 = CommandStationEnum.TimeItemWidth * (#iter_58_1.timeId + 1) + CommandStationEnum.TimeItemSpace

		if not var_58_1 then
			var_58_0 = var_58_0 + var_58_2
		else
			if arg_58_2 then
				var_58_0 = var_58_0 + var_58_2

				break
			end

			var_58_0 = var_58_0 + CommandStationEnum.TimeItemWidth * var_58_1

			break
		end
	end

	return var_58_0
end

function var_0_0.onClose(arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._updateScene, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._checkShowArrow, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._hideRT, arg_59_0)

	if arg_59_0._clickImageParam then
		for iter_59_0, iter_59_1 in pairs(arg_59_0._clickImageParam) do
			iter_59_1.clickListener:RemoveClickListener()
		end
	end

	if arg_59_0._drag then
		arg_59_0._drag:RemoveDragBeginListener()
		arg_59_0._drag:RemoveDragEndListener()
	end

	arg_59_0:_killTween()
	arg_59_0:_clearItemPosMap()
	CommandStationController.StatCommandStationViewClose(arg_59_0.viewName, Time.realtimeSinceStartup - arg_59_0._viewOpenTime)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_fanhui)
end

function var_0_0.onDestroyView(arg_60_0)
	return
end

return var_0_0
