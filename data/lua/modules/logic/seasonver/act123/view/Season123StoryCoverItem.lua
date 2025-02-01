module("modules.logic.seasonver.act123.view.Season123StoryCoverItem", package.seeall)

slot0 = class("Season123StoryCoverItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.param = slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.storyId = slot0.param.storyId
	slot0.config = slot0.param.storyConfig
	slot0.actId = slot0.param.actId
	slot0.canvasGroup = gohelper.findChild(slot0.go, "go_root"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.txtStageNum = gohelper.findChildText(slot0.go, "go_root/NumMask/txt_Num")
	slot0.txtTitle = gohelper.findChildText(slot0.go, "go_root/txt_Title")
	slot0.txtTitleEn = gohelper.findChildText(slot0.go, "go_root/txt_TitleEn")
	slot0.goArrow = gohelper.findChild(slot0.go, "go_root/go_arrow")
	slot0.goLocked = gohelper.findChild(slot0.go, "go_Locked")
	slot0.animLocked = ZProj.ProjAnimatorPlayer.Get(slot0.goLocked)
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.onClickCoverItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
end

slot0.unlockDelayTime = 1.16

function slot0.refreshItem(slot0)
	slot0.isPass = Season123Model.instance:getActInfo(slot0.actId).stageMap[slot0.config.condition] and slot1.isPass
	slot0.isUnlock = Season123ProgressUtils.isStageUnlock(slot0.actId, slot0.config.condition) and slot0.isPass == true
	slot0.canvasGroup.alpha = slot0.isUnlock and 1 or 0.5
	slot0.txtStageNum.text = slot0.config.storyId
	slot0.txtTitle.text = slot0.config.title
	slot0.txtTitleEn.text = slot0.config.titleEn
end

function slot0.onClickCoverItem(slot0)
	if slot0.isUnlock then
		Season123Controller.instance:dispatchEvent(Season123Event.OnCoverItemClick, {
			storyId = slot0.storyId
		})
	else
		GameFacade.showToast(ToastEnum.SeasonStageNotPass)
	end
end

function slot0.refreshUnlockState(slot0, slot1)
	if slot0.isUnlock and slot0.isUnlock ~= slot1 then
		gohelper.setActive(slot0.goLocked, not slot1)
		UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
		UIBlockMgr.instance:startBlock("playCoverItemUnlockAnim")
		TaskDispatcher.runDelay(slot0.playUnlockAnim, slot0, uv0.unlockDelayTime)
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		gohelper.setActive(slot0.goLocked, not slot0.isUnlock)
	end
end

function slot0.playUnlockAnim(slot0)
	slot0.animLocked:Play(UIAnimationName.Unlock, slot0.onUnlockAnimDone, slot0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_tale_unlock)
end

function slot0.onUnlockAnimDone(slot0)
	gohelper.setActive(slot0.goLocked, not slot0.isUnlock)
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
end

function slot0.destroy(slot0)
	slot0:__onDispose()
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
	TaskDispatcher.cancelTask(slot0.playUnlockAnim, slot0)
end

return slot0
