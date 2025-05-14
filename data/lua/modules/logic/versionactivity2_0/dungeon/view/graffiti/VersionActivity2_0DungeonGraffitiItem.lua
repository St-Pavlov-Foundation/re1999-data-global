module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiItem", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonGraffitiItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.canvasGroup = gohelper.findChild(arg_1_0.go, "icon"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0.picture = gohelper.findChildSingleImage(arg_1_0.go, "icon/simage_picture")
	arg_1_0.imagePicture = gohelper.findChildImage(arg_1_0.go, "icon/simage_picture")
	arg_1_0.lock = gohelper.findChild(arg_1_0.go, "icon/simage_picture/go_lock")
	arg_1_0.goLockTime = gohelper.findChild(arg_1_0.go, "icon/simage_picture/go_lockTime")
	arg_1_0.txtUnlockTime = gohelper.findChildText(arg_1_0.go, "icon/simage_picture/go_lockTime/txt_unlockTime")
	arg_1_0.toUnlock = gohelper.findChild(arg_1_0.go, "go_toUnlock")
	arg_1_0.goUnlockEffect = gohelper.findChild(arg_1_0.go, "go_unlockEffect")
	arg_1_0.goUnlockEffect1 = gohelper.findChild(arg_1_0.go, "unlock")
	arg_1_0.goFinishEffect = gohelper.findChild(arg_1_0.go, "finish")
	arg_1_0.simageEffect = gohelper.findChildSingleImage(arg_1_0.go, "go_unlockEffect/simage_effect")
	arg_1_0.gocompleted = gohelper.findChild(arg_1_0.go, "icon/simage_picture/go_completed")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click")
	arg_1_0.isRunTime = false
	arg_1_0.isNewUnlock = false
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0.onPictureClick, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.GraffitiCdRefresh, arg_2_0.refreshUnlockTime, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.ToUnlockGraffiti, arg_2_0.toUnlockGraffiti, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnClick:RemoveClickListener()
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.GraffitiCdRefresh, arg_3_0.refreshUnlockTime, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.ToUnlockGraffiti, arg_3_0.toUnlockGraffiti, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0, LuaEventSystem.Low)
end

function var_0_0.onPictureClick(arg_4_0)
	local var_4_0 = Activity161Model.instance.graffitiInfoMap[arg_4_0.elementId]

	if var_4_0.state == Activity161Enum.graffitiState.Normal or var_4_0.state == Activity161Enum.graffitiState.IsFinished then
		Activity161Controller.instance:openGraffitiDrawView({
			graffitiMO = var_4_0,
			normalMaterial = arg_4_0.normalMaterial
		})
		arg_4_0:resetPicture()
	elseif var_4_0.state == Activity161Enum.graffitiState.ToUnlock then
		Activity161Controller.instance:jumpToElement(var_4_0)
	elseif arg_4_0.showLockTime then
		GameFacade.showToast(ToastEnum.GraffitiLockWidthTime)
	else
		GameFacade.showToast(ToastEnum.GraffitiLock)
	end
end

function var_0_0.initData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.elementId = arg_5_2
	arg_5_0.actId = arg_5_1
	arg_5_0.config = Activity161Config.instance:getGraffitiCo(arg_5_0.actId, arg_5_0.elementId)

	local var_5_0 = string.format("%s_effect", arg_5_0.config.picture)

	arg_5_0.simageEffect:LoadImage(ResUrl.getGraffitiIcon(var_5_0), arg_5_0.setNativeSize, arg_5_0)

	arg_5_0.oldState = Activity161Model.instance.graffitiInfoMap[arg_5_0.elementId].state
	arg_5_0.lockMaterial = arg_5_3[1]
	arg_5_0.normalMaterial = arg_5_3[2]
end

function var_0_0.refreshItem(arg_6_0)
	arg_6_0.graffitiMO = Activity161Model.instance.graffitiInfoMap[arg_6_0.elementId]
	arg_6_0.isUnlock = Activity161Model.instance:isUnlockState(arg_6_0.graffitiMO) == Activity161Enum.unlockState

	local var_6_0 = Activity161Model.instance:getInCdGraffiti()

	arg_6_0:refreshUnlockTime(var_6_0)
	gohelper.setActive(arg_6_0.lock, arg_6_0.graffitiMO.state == Activity161Enum.graffitiState.Lock and not arg_6_0.showLockTime)
	gohelper.setActive(arg_6_0.toUnlock, arg_6_0.graffitiMO.state == Activity161Enum.graffitiState.ToUnlock)
	gohelper.setActive(arg_6_0.gocompleted, arg_6_0.graffitiMO.state == Activity161Enum.graffitiState.IsFinished)
end

function var_0_0.refreshUnlockTime(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if iter_7_1.id == arg_7_0.graffitiMO.id then
			var_7_0 = iter_7_1

			break
		end
	end

	arg_7_0.showLockTime = var_7_0 ~= nil

	gohelper.setActive(arg_7_0.goLockTime, arg_7_0.graffitiMO.state == Activity161Enum.graffitiState.Lock and arg_7_0.showLockTime)

	local var_7_1 = Mathf.Floor(arg_7_0.graffitiMO:getRemainUnlockTime())

	arg_7_0.txtUnlockTime.text = TimeUtil.getFormatTime1(var_7_1, true)

	arg_7_0:refreshPicture()
end

function var_0_0.refreshPicture(arg_8_0)
	local var_8_0
	local var_8_1 = 1

	if not arg_8_0.isNewUnlock then
		if arg_8_0.graffitiMO.state == Activity161Enum.graffitiState.Lock then
			var_8_0 = arg_8_0.lockMaterial
			var_8_1 = arg_8_0.showLockTime and 1 or 0.5
		elseif arg_8_0.graffitiMO.state == Activity161Enum.graffitiState.ToUnlock then
			var_8_0 = arg_8_0.lockMaterial
			var_8_1 = 1
		elseif arg_8_0.graffitiMO.state == Activity161Enum.graffitiState.Normal then
			var_8_0 = arg_8_0.normalMaterial
			var_8_1 = 1
		end
	else
		var_8_0 = (arg_8_0.graffitiMO.state ~= Activity161Enum.graffitiState.IsFinished or nil) and arg_8_0.normalMaterial
	end

	local var_8_2 = string.format("%s_manual", arg_8_0.config.picture)

	arg_8_0.picture:LoadImage(ResUrl.getGraffitiIcon(var_8_2), arg_8_0.setNativeSize, arg_8_0)

	arg_8_0.imagePicture.material = var_8_0

	ZProj.UGUIHelper.SetColorAlpha(arg_8_0.imagePicture, var_8_1)
end

function var_0_0.setNativeSize(arg_9_0)
	ZProj.UGUIHelper.SetImageSize(arg_9_0.picture.gameObject)
	ZProj.UGUIHelper.SetImageSize(arg_9_0.simageEffect.gameObject)
end

function var_0_0.refreshUnlockState(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 == Activity161Enum.unlockState

	if arg_10_0.isUnlock and arg_10_0.isUnlock ~= var_10_0 then
		gohelper.setActive(arg_10_0.goUnlockEffect, true)
		arg_10_0:playUnlockEffect()
	else
		gohelper.setActive(arg_10_0.goUnlockEffect, false)
		gohelper.setActive(arg_10_0.goUnlockEffect1, false)
	end
end

function var_0_0.toUnlockGraffiti(arg_11_0, arg_11_1)
	if arg_11_1.id == arg_11_0.elementId then
		gohelper.setActive(arg_11_0.goLockTime, false)
		arg_11_0:refreshItem()
	end
end

function var_0_0.playUnlockEffect(arg_12_0)
	arg_12_0.isNewUnlock = true

	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardView)
	arg_12_0:refreshPicture()
	gohelper.setActive(arg_12_0.goUnlockEffect1, true)
end

function var_0_0.resetPicture(arg_13_0)
	arg_13_0.isNewUnlock = false

	gohelper.setActive(arg_13_0.goUnlockEffect, false)
	gohelper.setActive(arg_13_0.goUnlockEffect1, false)
	arg_13_0:refreshPicture()
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.VersionActivity2_0DungeonGraffitiDrawView then
		if arg_14_0.graffitiMO.state == Activity161Enum.graffitiState.IsFinished and arg_14_0.oldState ~= arg_14_0.graffitiMO.state then
			gohelper.setActive(arg_14_0.goFinishEffect, true)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

			arg_14_0.oldState = arg_14_0.graffitiMO.state
		end
	else
		gohelper.setActive(arg_14_0.goFinishEffect, false)
	end
end

function var_0_0.destroy(arg_15_0)
	arg_15_0.picture:UnLoadImage()
	arg_15_0.simageEffect:UnLoadImage()
	TaskDispatcher.cancelTask(arg_15_0.freshUnlockTime, arg_15_0)
	arg_15_0:__onDispose()
end

return var_0_0
