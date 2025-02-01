module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiItem", package.seeall)

slot0 = class("VersionActivity2_0DungeonGraffitiItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.canvasGroup = gohelper.findChild(slot0.go, "icon"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.picture = gohelper.findChildSingleImage(slot0.go, "icon/simage_picture")
	slot0.imagePicture = gohelper.findChildImage(slot0.go, "icon/simage_picture")
	slot0.lock = gohelper.findChild(slot0.go, "icon/simage_picture/go_lock")
	slot0.goLockTime = gohelper.findChild(slot0.go, "icon/simage_picture/go_lockTime")
	slot0.txtUnlockTime = gohelper.findChildText(slot0.go, "icon/simage_picture/go_lockTime/txt_unlockTime")
	slot0.toUnlock = gohelper.findChild(slot0.go, "go_toUnlock")
	slot0.goUnlockEffect = gohelper.findChild(slot0.go, "go_unlockEffect")
	slot0.goUnlockEffect1 = gohelper.findChild(slot0.go, "unlock")
	slot0.goFinishEffect = gohelper.findChild(slot0.go, "finish")
	slot0.simageEffect = gohelper.findChildSingleImage(slot0.go, "go_unlockEffect/simage_effect")
	slot0.gocompleted = gohelper.findChild(slot0.go, "icon/simage_picture/go_completed")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
	slot0.isRunTime = false
	slot0.isNewUnlock = false
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.onPictureClick, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.GraffitiCdRefresh, slot0.refreshUnlockTime, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.ToUnlockGraffiti, slot0.toUnlockGraffiti, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.GraffitiCdRefresh, slot0.refreshUnlockTime, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.ToUnlockGraffiti, slot0.toUnlockGraffiti, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.onPictureClick(slot0)
	if Activity161Model.instance.graffitiInfoMap[slot0.elementId].state == Activity161Enum.graffitiState.Normal or slot1.state == Activity161Enum.graffitiState.IsFinished then
		Activity161Controller.instance:openGraffitiDrawView({
			graffitiMO = slot1,
			normalMaterial = slot0.normalMaterial
		})
		slot0:resetPicture()
	elseif slot1.state == Activity161Enum.graffitiState.ToUnlock then
		Activity161Controller.instance:jumpToElement(slot1)
	elseif slot0.showLockTime then
		GameFacade.showToast(ToastEnum.GraffitiLockWidthTime)
	else
		GameFacade.showToast(ToastEnum.GraffitiLock)
	end
end

function slot0.initData(slot0, slot1, slot2, slot3)
	slot0.elementId = slot2
	slot0.actId = slot1
	slot0.config = Activity161Config.instance:getGraffitiCo(slot0.actId, slot0.elementId)

	slot0.simageEffect:LoadImage(ResUrl.getGraffitiIcon(string.format("%s_effect", slot0.config.picture)), slot0.setNativeSize, slot0)

	slot0.oldState = Activity161Model.instance.graffitiInfoMap[slot0.elementId].state
	slot0.lockMaterial = slot3[1]
	slot0.normalMaterial = slot3[2]
end

function slot0.refreshItem(slot0)
	slot0.graffitiMO = Activity161Model.instance.graffitiInfoMap[slot0.elementId]
	slot0.isUnlock = Activity161Model.instance:isUnlockState(slot0.graffitiMO) == Activity161Enum.unlockState

	slot0:refreshUnlockTime(Activity161Model.instance:getInCdGraffiti())
	gohelper.setActive(slot0.lock, slot0.graffitiMO.state == Activity161Enum.graffitiState.Lock and not slot0.showLockTime)
	gohelper.setActive(slot0.toUnlock, slot0.graffitiMO.state == Activity161Enum.graffitiState.ToUnlock)
	gohelper.setActive(slot0.gocompleted, slot0.graffitiMO.state == Activity161Enum.graffitiState.IsFinished)
end

function slot0.refreshUnlockTime(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(slot1) do
		if slot7.id == slot0.graffitiMO.id then
			slot2 = slot7

			break
		end
	end

	slot0.showLockTime = slot2 ~= nil

	gohelper.setActive(slot0.goLockTime, slot0.graffitiMO.state == Activity161Enum.graffitiState.Lock and slot0.showLockTime)

	slot0.txtUnlockTime.text = TimeUtil.getFormatTime1(Mathf.Floor(slot0.graffitiMO:getRemainUnlockTime()), true)

	slot0:refreshPicture()
end

function slot0.refreshPicture(slot0)
	slot1 = nil
	slot2 = 1

	if not slot0.isNewUnlock then
		if slot0.graffitiMO.state == Activity161Enum.graffitiState.Lock then
			slot1 = slot0.lockMaterial
			slot2 = slot0.showLockTime and 1 or 0.5
		elseif slot0.graffitiMO.state == Activity161Enum.graffitiState.ToUnlock then
			slot1 = slot0.lockMaterial
			slot2 = 1
		elseif slot0.graffitiMO.state == Activity161Enum.graffitiState.Normal then
			slot1 = slot0.normalMaterial
			slot2 = 1
		end
	else
		slot1 = (slot0.graffitiMO.state ~= Activity161Enum.graffitiState.IsFinished or nil) and slot0.normalMaterial
	end

	slot0.picture:LoadImage(ResUrl.getGraffitiIcon(string.format("%s_manual", slot0.config.picture)), slot0.setNativeSize, slot0)

	slot0.imagePicture.material = slot1

	ZProj.UGUIHelper.SetColorAlpha(slot0.imagePicture, slot2)
end

function slot0.setNativeSize(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0.picture.gameObject)
	ZProj.UGUIHelper.SetImageSize(slot0.simageEffect.gameObject)
end

function slot0.refreshUnlockState(slot0, slot1)
	if slot0.isUnlock and slot0.isUnlock ~= (slot1 == Activity161Enum.unlockState) then
		gohelper.setActive(slot0.goUnlockEffect, true)
		slot0:playUnlockEffect()
	else
		gohelper.setActive(slot0.goUnlockEffect, false)
		gohelper.setActive(slot0.goUnlockEffect1, false)
	end
end

function slot0.toUnlockGraffiti(slot0, slot1)
	if slot1.id == slot0.elementId then
		gohelper.setActive(slot0.goLockTime, false)
		slot0:refreshItem()
	end
end

function slot0.playUnlockEffect(slot0)
	slot0.isNewUnlock = true

	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardView)
	slot0:refreshPicture()
	gohelper.setActive(slot0.goUnlockEffect1, true)
end

function slot0.resetPicture(slot0)
	slot0.isNewUnlock = false

	gohelper.setActive(slot0.goUnlockEffect, false)
	gohelper.setActive(slot0.goUnlockEffect1, false)
	slot0:refreshPicture()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity2_0DungeonGraffitiDrawView then
		if slot0.graffitiMO.state == Activity161Enum.graffitiState.IsFinished and slot0.oldState ~= slot0.graffitiMO.state then
			gohelper.setActive(slot0.goFinishEffect, true)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

			slot0.oldState = slot0.graffitiMO.state
		end
	else
		gohelper.setActive(slot0.goFinishEffect, false)
	end
end

function slot0.destroy(slot0)
	slot0.picture:UnLoadImage()
	slot0.simageEffect:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.freshUnlockTime, slot0)
	slot0:__onDispose()
end

return slot0
