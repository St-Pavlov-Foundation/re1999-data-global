module("modules.logic.sp01.enter.view.VersionActivity2_9EnterViewAnimComp", package.seeall)

local var_0_0 = class("VersionActivity2_9EnterViewAnimComp", BaseView)
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = "VersionActivity2_9EnterViewAnimComp"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_switch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._onRefreshActivityState, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9EnterController.instance, VersionActivity2_9Event.UnlockNextHalf, arg_2_0._onUnlockNextHalf, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
end

function var_0_0._btnswitchOnClick(arg_4_0)
	if not ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.EnterView2) then
		return
	end

	AssassinHelper.lockScreen(var_0_3, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Enter.play_ui_switch)
	arg_4_0._animator:Play("click", 0, 0)
	arg_4_0:playCameraAnim()
	arg_4_0:playHeroTargetAnim("b_click")
	TaskDispatcher.runDelay(arg_4_0.onSwitchAnimDone, arg_4_0, VersionActivity2_9Enum.DelaySwitchBgTime)
	TaskDispatcher.runDelay(arg_4_0.playHeroAnim, arg_4_0, VersionActivity2_9Enum.DelaySwitchHero2Idle)
	VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.SwitchGroup)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:loadScene()
end

function var_0_0.loadScene(arg_6_0)
	local var_6_0 = CameraMgr.instance:getSceneRoot()

	arg_6_0._sceneRoot = gohelper.create3d(var_6_0, "VersionActivity2_9EnterView")

	transformhelper.setLocalPos(arg_6_0._sceneRoot.transform, 0, 0, 0)

	local var_6_1 = arg_6_0.viewContainer:getSetting().otherRes[1]

	arg_6_0._sceneGO = arg_6_0:getResInst(var_6_1, arg_6_0._sceneRoot, "scene")

	arg_6_0:loadSceneDone()
end

function var_0_0.loadSceneDone(arg_7_0)
	arg_7_0:initScene()
	arg_7_0:initCamera()
end

function var_0_0.initScene(arg_8_0)
	arg_8_0._gocanvas = gohelper.findChild(arg_8_0._sceneGO, "BackGround/#go_bgCanvas")
	arg_8_0._bgcanvas = arg_8_0._gocanvas:GetComponent("Canvas")
	arg_8_0._bgcanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_8_0._backgroundTab = arg_8_0:getUserDataTb_()
	arg_8_0._backgroundTab[1] = gohelper.findChild(arg_8_0._sceneGO, "BackGround/#go_bgCanvas/sp01_m_s17_kv_plant_a")
	arg_8_0._backgroundTab[2] = gohelper.findChild(arg_8_0._sceneGO, "BackGround/#go_bgCanvas/sp01_m_s17_kv_plant_b")
	arg_8_0._bgVideoTab = arg_8_0:getUserDataTb_()
	arg_8_0._bgVideoTab[1] = VersionActivityVideoComp.get(arg_8_0._backgroundTab[1], arg_8_0)
	arg_8_0._bgVideoTab[2] = VersionActivityVideoComp.get(arg_8_0._backgroundTab[2], arg_8_0)
	arg_8_0._animator = gohelper.onceAddComponent(arg_8_0._sceneGO, gohelper.Type_Animator)
	arg_8_0._godynamicspine = gohelper.findChild(arg_8_0._sceneGO, "BackGround/spine")
	arg_8_0._godynamicspineanim = gohelper.findChild(arg_8_0._sceneGO, "BackGround/spine/aim/spine")
	arg_8_0._spineAnim = gohelper.onceAddComponent(arg_8_0._godynamicspineanim, typeof(Spine.Unity.SkeletonAnimation))

	arg_8_0:refresh()

	arg_8_0.actId = arg_8_0.viewParam and arg_8_0.viewParam.actId
	arg_8_0.mainActIdList = arg_8_0.viewParam and arg_8_0.viewParam.mainActIdList or {}

	local var_8_0 = tabletool.indexOf(arg_8_0.mainActIdList, arg_8_0.actId) or 1

	arg_8_0:switchBackGround(var_8_0)
end

function var_0_0.initCamera(arg_9_0)
	if arg_9_0._cameraPlayer then
		return
	end

	arg_9_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_9_0._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
	arg_9_0._preRuntimeAnimatorController = arg_9_0._cameraAnimator.runtimeAnimatorController
end

function var_0_0.playCameraAnim(arg_10_0)
	arg_10_0:setCameraAnimator()
	arg_10_0._cameraPlayer:Play("click", arg_10_0._resetCameraAnimator, arg_10_0)
end

function var_0_0.setCameraAnimator(arg_11_0)
	local var_11_0 = gohelper.findChildComponent(arg_11_0._sceneGO, "#go_cameraAnim", gohelper.Type_Animator)

	arg_11_0._cameraAnimator.runtimeAnimatorController = var_11_0.runtimeAnimatorController
end

function var_0_0._resetCameraAnimator(arg_12_0)
	if arg_12_0._cameraAnimator then
		arg_12_0._cameraAnimator.runtimeAnimatorController = arg_12_0._preRuntimeAnimatorController
	end
end

function var_0_0.refresh(arg_13_0)
	arg_13_0:playHeroAnim()
	arg_13_0:playSceneAnim()
end

function var_0_0.playHeroAnim(arg_14_0)
	arg_14_0:playHeroTargetAnim(StoryAnimName.B_IDLE)
end

function var_0_0.playSceneAnim(arg_15_0)
	arg_15_0._animator:Play("open", 0, 0)
end

function var_0_0.playHeroTargetAnim(arg_16_0, arg_16_1)
	if not arg_16_0._spineAnim then
		return
	end

	if not arg_16_0._spineAnim:HasAnimation(arg_16_1) then
		return
	end

	arg_16_0._spineAnim:SetAnimation(BaseSpine.FaceTrackIndex, arg_16_1, true, 0)
end

function var_0_0._onRefreshActivityState(arg_17_0, arg_17_1)
	if arg_17_1 ~= VersionActivity2_9Enum.ActivityId.EnterView2 then
		return
	end

	arg_17_0:refresh()
end

function var_0_0.switchBackGround(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._backgroundTab) do
		local var_18_0 = arg_18_1 == iter_18_0

		gohelper.setActive(iter_18_1, var_18_0)

		if var_18_0 then
			local var_18_1 = arg_18_0:getVideoUrl(arg_18_1)

			arg_18_0._bgVideoTab[iter_18_0]:play(var_18_1, true)
		end
	end

	arg_18_0._curBgIndex = arg_18_1
end

function var_0_0.getVideoUrl(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.mainActIdList and arg_19_0.mainActIdList[arg_19_1]
	local var_19_1 = var_19_0 and VersionActivity2_9Enum.ActId2BgAudioName[var_19_0]

	return langVideoUrl(var_19_1)
end

function var_0_0.onSwitchAnimDone(arg_20_0)
	local var_20_0 = arg_20_0._curBgIndex == var_0_1 and var_0_2 or var_0_1

	arg_20_0:switchBackGround(var_20_0)
	AssassinHelper.lockScreen(var_0_3, false)
end

function var_0_0._onOpenViewFinish(arg_21_0)
	gohelper.setActive(arg_21_0._sceneRoot, not arg_21_0:_isAngViewCoverScene())
end

function var_0_0._onCloseView(arg_22_0, arg_22_1)
	if arg_22_1 == arg_22_0.viewName then
		return
	end

	if arg_22_1 == ViewName.VersionActivity2_9DungeonMapView then
		return
	end

	gohelper.setActive(arg_22_0._sceneRoot, not arg_22_0:_isAngViewCoverScene())
end

function var_0_0._onCloseViewFinish(arg_23_0, arg_23_1)
	if arg_23_1 ~= ViewName.VersionActivity2_9DungeonMapView then
		return
	end

	gohelper.setActive(arg_23_0._sceneRoot, not arg_23_0:_isAngViewCoverScene())
end

function var_0_0._isAngViewCoverScene(arg_24_0)
	local var_24_0 = false
	local var_24_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_24_0 = #var_24_1, 1, -1 do
		local var_24_2 = var_24_1[iter_24_0]

		if var_24_2 == arg_24_0.viewName then
			break
		end

		if ViewMgr.instance:isFull(var_24_2) then
			var_24_0 = true

			break
		end
	end

	return var_24_0
end

function var_0_0._onUnlockNextHalf(arg_25_0)
	arg_25_0._animator:Play("guid", 0, 0)
end

function var_0_0.distroyAudios(arg_26_0)
	if arg_26_0._bgVideoTab then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._bgVideoTab) do
			if iter_26_1 then
				iter_26_1:destroy()
			end
		end
	end
end

function var_0_0.onClose(arg_27_0)
	AssassinHelper.lockScreen(var_0_3, false)
	TaskDispatcher.cancelTask(arg_27_0.playHeroAnim, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0.onSwitchAnimDone, arg_27_0)
	arg_27_0:_resetCameraAnimator()
end

function var_0_0.onDestroyView(arg_28_0)
	if arg_28_0._sceneRoot then
		gohelper.destroy(arg_28_0._sceneRoot)

		arg_28_0._sceneRoot = nil
	end
end

return var_0_0
