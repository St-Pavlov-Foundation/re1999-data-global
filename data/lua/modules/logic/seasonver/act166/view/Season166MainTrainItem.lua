module("modules.logic.seasonver.act166.view.Season166MainTrainItem", package.seeall)

slot0 = class("Season166MainTrainItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.param = slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.actId = slot0.param.actId
	slot0.trainId = slot0.param.trainId
	slot0.config = slot0.param.config
	slot0.anim = slot0.go:GetComponent(gohelper.Type_Animator)
	slot0.goFinish = gohelper.findChild(slot0.go, "go_finish")
	slot0.imageFinishBg = gohelper.findChildImage(slot0.go, "go_finish/image_finishbg")
	slot0.goFinishEffect = gohelper.findChild(slot0.go, "go_finish/fe_01")
	slot0.goSpFinishEffect = gohelper.findChild(slot0.go, "go_finish/fe_02")
	slot0.govxEffect1 = gohelper.findChild(slot0.go, "vx_ink_01")
	slot0.govxEffect2 = gohelper.findChild(slot0.go, "vx_ink_02")
	slot0.goNormal = gohelper.findChild(slot0.go, "go_normal")
	slot0.imageNormalBg = gohelper.findChildImage(slot0.go, "go_normal/image_normalbg")
	slot0.goLock = gohelper.findChild(slot0.go, "go_lock")
	slot0.golockbg = gohelper.findChild(slot0.go, "go_lock/bg")
	slot0.imageLockBg = gohelper.findChildImage(slot0.go, "go_lock/bg")
	slot0.goLockMask = gohelper.findChild(slot0.go, "go_lock/go_lockMask")
	slot0.gounlockTip = gohelper.findChild(slot0.go, "go_lock/unlockTip")
	slot0.txtStarNum = gohelper.findChildText(slot0.go, "go_lock/unlockTip/txt_starNum")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")

	slot0:initTitleInfo(slot0.goFinish)
	slot0:initTitleInfo(slot0.goNormal)
	slot0:initTitleInfo(slot0.goLock)
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.onClickTrainItem, slot0)
end

function slot0.onClickTrainItem(slot0)
	slot1 = {
		actId = slot0.actId,
		trainId = slot0.trainId,
		config = slot0.config,
		viewType = Season166Enum.WordTrainType
	}

	if not slot0.canUnlock then
		if not slot0.isUnlockTime and slot0.config.type == Season166Enum.TrainSpType then
			GameFacade.showToast(ToastEnum.Season166TrainTimeLock)
		else
			GameFacade.showToast(ToastEnum.Season166TrainStarLock)
		end
	else
		Season166Controller.instance:openSeasonTrainView(slot1)
	end
end

function slot0.refreshUI(slot0)
	slot0.isFinish = Season166TrainModel.instance:checkIsFinish(slot0.actId, slot0.trainId)
	slot0.canUnlock = Season166TrainModel.instance:getUnlockTrainInfoMap(slot0.actId)[slot0.trainId]
	slot0.unlockState = slot0.canUnlock and Season166Enum.UnlockState or Season166Enum.LockState
	slot0.isUnlockTime = Season166TrainModel.instance:isHardEpisodeUnlockTime(slot0.actId)
	slot0.txtStarNum.text = slot0.config.needStar
	slot2 = slot0.config.type == Season166Enum.TrainSpType
	slot3 = slot2 and "season_main_stage_2_0" or "season_main_stage_1_0"

	UISpriteSetMgr.instance:setSeason166Sprite(slot0.imageFinishBg, slot2 and "season_main_stage_2_1" or "season_main_stage_1_2", true)
	UISpriteSetMgr.instance:setSeason166Sprite(slot0.imageNormalBg, slot3, true)
	UISpriteSetMgr.instance:setSeason166Sprite(slot0.imageLockBg, slot3, true)
	gohelper.setActive(slot0.goFinish, slot0.isFinish)

	if slot2 then
		gohelper.setActive(slot0.gounlockTip, slot0.isUnlockTime)
	else
		gohelper.setActive(slot0.gounlockTip, not slot0.canUnlock)
	end

	gohelper.setActive(slot0.goLockMask, not slot0.isUnlockTime and slot2)
	gohelper.setActive(slot0.goLock, not slot0.canUnlock)
	gohelper.setActive(slot0.govxEffect1, slot0.canUnlock)
	gohelper.setActive(slot0.govxEffect2, slot0.canUnlock)
	ZProj.UGUIHelper.SetGrayscale(slot0.golockbg, not slot0.canUnlock)
	gohelper.setActive(slot0.goNormal, slot0.canUnlock and not slot0.isFinish)
	gohelper.setActive(slot0.goSpFinishEffect, slot0.isFinish and slot2)
	gohelper.setActive(slot0.goFinishEffect, slot0.isFinish and not slot2)
end

function slot0.initTitleInfo(slot0, slot1)
	gohelper.findChildText(slot1, "txt_title").text = slot0.config.name
	gohelper.findChildText(slot1, "txt_index").text = string.format("St.%d", slot0.trainId)
end

function slot0.getUnlockState(slot0)
	return slot0.unlockState
end

function slot0.refreshUnlockState(slot0, slot1)
	if slot0.canUnlock and slot0.unlockState ~= slot1 then
		if slot0.isFinish then
			slot0.anim:Play(UIAnimationName.Finish, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_resonate_fm)
		else
			slot0.anim:Play(UIAnimationName.Unlock, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_wangshi_argus_level_open)
		end
	end
end

function slot0.getFinishState(slot0)
	return slot0.isFinish
end

function slot0.playFinishEffect(slot0)
	if slot0.isFinish then
		slot0.anim:Play(UIAnimationName.Finish, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_resonate_fm)
	end
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
