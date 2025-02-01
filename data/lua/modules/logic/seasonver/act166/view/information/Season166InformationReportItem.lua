module("modules.logic.seasonver.act166.view.information.Season166InformationReportItem", package.seeall)

slot0 = class("Season166InformationReportItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.animItem = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot2 = gohelper.findChild(slot0.go, "image_Line")
	slot0.lockedCtrl = slot2:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0.animPlayer = SLFramework.AnimatorPlayer.Get(slot2)
	slot0.simagePic = gohelper.findChildSingleImage(slot0.go, "image_Line/image_ReportPic")
	slot0.goLock = gohelper.findChild(slot0.go, "image_Line/#go_Locked")
	slot0.goLockTips = gohelper.findChild(slot0.goLock, "#go_LockTips")
	slot0.txtLockTips = gohelper.findChildTextMesh(slot0.goLock, "#go_LockTips/image_LockTips/#txt_LockTips")
	slot0.goLockIcon = gohelper.findChild(slot0.goLock, "image_LockedIcon")
	slot0.simagePicLocked = gohelper.findChildSingleImage(slot0.goLock, "image_ReportLockedPic")
	slot0.goSchdule = gohelper.findChild(slot0.go, "Schdule")
	slot0.animSchdule = slot0.goSchdule:GetComponent(typeof(UnityEngine.Animator))
	slot0.goSchduleItem = gohelper.findChild(slot0.goSchdule, "#go_Item")

	gohelper.setActive(slot0.goSchduleItem, false)

	slot0.schduleItems = {}
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.go)
	slot0.goreddot = gohelper.findChild(slot0.go, "image_Line/#go_reddot")
	slot0.gonewReddot = gohelper.findChild(slot0.go, "image_Line/#go_infoNewReddot")
	slot0.canShowNew = false
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.onClickItem, slot0)
	Season166Controller.instance:registerCallback(Season166Event.OnAnalyInfoSuccess, slot0.refreshReddot, slot0)
end

function slot0.onClickItem(slot0)
	if not slot0.config then
		return
	end

	if not (Season166Model.instance:getActInfo(slot0.activityId) and slot1:getInformationMO(slot0.infoId)) then
		GameFacade.showToast(ToastEnum.Season166ReportNotUnlock)

		return
	end

	slot3 = {
		actId = slot0.activityId,
		infoId = slot0.infoId,
		unlockState = slot0.unlockState
	}

	ViewMgr.instance:openView(ViewName.Season166InformationAnalyView, slot3)

	slot0.canShowNew = false

	Season166Controller.instance:dispatchEvent(Season166Event.ClickInfoReportItem, slot3)
	slot0:refreshUnlockState(Season166Enum.UnlockState)
end

function slot0.refreshUI(slot0, slot1)
	slot0.config = slot1

	gohelper.setActive(slot0.go, slot1 ~= nil)

	if not slot1 then
		return
	end

	slot0.activityId = slot0.config.activityId
	slot0.infoId = slot0.config.infoId

	slot0.simagePic:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_1.png", slot0.infoId))
	slot0.simagePicLocked:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_0.png", slot0.infoId))

	slot3 = Season166Model.instance:getActInfo(slot0.activityId) and slot2:getInformationMO(slot0.infoId)
	slot0.unlockState = slot3 and Season166Enum.UnlockState or Season166Enum.LockState

	gohelper.setActive(slot0.goLockIcon, not slot3)
	slot0:refreshSchdule(slot3)
	gohelper.setActive(slot0.goLockTips, slot0.unlockState == Season166Enum.LockState)

	if slot0.unlockState == Season166Enum.LockState then
		slot0.txtLockTips.text = slot0.config.unlockDes
	end

	slot0:playOpenAnim()
end

function slot0.playOpenAnim(slot0)
	if slot0.hasPlayOpen then
		return
	end

	slot0.hasPlayOpen = true

	slot0.animItem:SetBool("isUnlock", slot0.unlockState == Season166Enum.UnlockState)

	if slot0.unlockState == Season166Enum.UnlockState then
		slot0.animItem:Play("open")
	else
		slot0.animItem:Play("unlock")
	end
end

function slot0.refreshSchdule(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0.goSchdule, false)
		slot0:_setImgValue(0)

		return
	end

	gohelper.setActive(slot0.goSchdule, true)

	slot6 = #(Season166Config.instance:getSeasonInfoAnalys(slot0.activityId, slot0.infoId) or {})

	for slot6 = 1, math.max(#slot0.schduleItems, slot6) do
		slot0:refreshSchduleItem(slot0.schduleItems[slot6] or slot0:createSchduleItem(slot6), slot2[slot6], slot1.stage)
	end

	slot0:_setImgValue(slot1.stage / #slot2)
end

function slot0._setImgValue(slot0, slot1)
	slot0.lockedCtrl:GetIndexProp(2, 2)

	slot2 = slot0.lockedCtrl.vector_03
	slot0.lockedCtrl.vector_03 = Vector4.New(slot1, 0.05, 0, 0)

	slot0.lockedCtrl:SetIndexProp(2, 2)
end

function slot0.createSchduleItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0.goSchduleItem, string.format("schdule%s", slot1))
	slot2.goStatus0 = gohelper.findChild(slot2.go, "image_status0")
	slot2.goStatus = gohelper.findChild(slot2.go, "#image_status")
	slot0.schduleItems[slot1] = slot2

	return slot2
end

function slot0.refreshSchduleItem(slot0, slot1, slot2, slot3)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goStatus, slot2.stage <= slot3)
end

function slot0.refreshUnlockState(slot0, slot1)
	if slot0.unlockState == Season166Enum.UnlockState and slot0.unlockState ~= slot1 then
		slot0.canShowNew = true
	else
		slot0.canShowNew = false
	end

	slot0:refreshReddot()
end

function slot0.refreshUnlockAnimState(slot0, slot1)
	if (slot1[slot0.infoId] or Season166Enum.LockState) == Season166Enum.LockState and slot0.unlockState == Season166Enum.UnlockState and (Season166Model.instance:getActInfo(slot0.activityId) and slot3:getInformationMO(slot0.infoId)).stage == 0 then
		Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey, slot0.infoId, Season166Enum.UnlockState)
		gohelper.setActive(slot0.goLockIcon, true)
		gohelper.setActive(slot0.goSchdule, false)
		TaskDispatcher.runDelay(slot0._playUnlockAnim, slot0, 1.6)
	end
end

function slot0._playUnlockAnim(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wangshi_argus_level_open)
	slot0.animPlayer:Play("unlock", slot0.onUnlockAnimPlayFinish, slot0)
	gohelper.setActive(slot0.goSchdule, true)
	slot0.animSchdule:Play("open")
end

function slot0.onUnlockAnimPlayFinish(slot0)
	gohelper.setActive(slot0.goLockIcon, false)
end

function slot0.refreshFinishAnimState(slot0, slot1)
	if slot0.unlockState == Season166Enum.LockState then
		return
	end

	if (slot1[slot0.infoId] or Season166Enum.LockState) == Season166Enum.LockState and (Season166Model.instance:getActInfo(slot0.activityId) and slot4:getInformationMO(slot0.infoId)).stage >= #(Season166Config.instance:getSeasonInfoAnalys(slot0.activityId, slot0.infoId) or {}) then
		Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey, slot0.infoId, Season166Enum.UnlockState)
		gohelper.setActive(slot0.goLock, true)
		AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
		slot0.animPlayer:Play("finish", slot0.onFinishAnimPlayFinish, slot0)
	end
end

function slot0.onFinishAnimPlayFinish(slot0)
end

function slot0.refreshReddot(slot0)
	RedDotController.instance:addRedDot(slot0.goreddot, RedDotEnum.DotNode.Season166InfoSmallReward, slot0.infoId, slot0.checkReddotShow, slot0)
end

function slot0.checkReddotShow(slot0, slot1)
	slot1:defaultRefreshDot()

	if slot0.canShowNew then
		gohelper.setActive(slot0.gonewReddot, true)
		gohelper.setActive(slot0.goreddot, false)
	else
		gohelper.setActive(slot0.goreddot, true)
		gohelper.setActive(slot0.gonewReddot, false)
		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
	Season166Controller.instance:unregisterCallback(Season166Event.OnAnalyInfoSuccess, slot0.refreshReddot, slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._playUnlockAnim, slot0)
	slot0.simagePic:UnLoadImage()
	slot0.simagePicLocked:UnLoadImage()
	slot0:__onDispose()
end

return slot0
