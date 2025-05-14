module("modules.logic.seasonver.act166.view.Season166MainTrainItem", package.seeall)

local var_0_0 = class("Season166MainTrainItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.actId = arg_2_0.param.actId
	arg_2_0.trainId = arg_2_0.param.trainId
	arg_2_0.config = arg_2_0.param.config
	arg_2_0.anim = arg_2_0.go:GetComponent(gohelper.Type_Animator)
	arg_2_0.goFinish = gohelper.findChild(arg_2_0.go, "go_finish")
	arg_2_0.imageFinishBg = gohelper.findChildImage(arg_2_0.go, "go_finish/image_finishbg")
	arg_2_0.goFinishEffect = gohelper.findChild(arg_2_0.go, "go_finish/fe_01")
	arg_2_0.goSpFinishEffect = gohelper.findChild(arg_2_0.go, "go_finish/fe_02")
	arg_2_0.govxEffect1 = gohelper.findChild(arg_2_0.go, "vx_ink_01")
	arg_2_0.govxEffect2 = gohelper.findChild(arg_2_0.go, "vx_ink_02")
	arg_2_0.goNormal = gohelper.findChild(arg_2_0.go, "go_normal")
	arg_2_0.imageNormalBg = gohelper.findChildImage(arg_2_0.go, "go_normal/image_normalbg")
	arg_2_0.goLock = gohelper.findChild(arg_2_0.go, "go_lock")
	arg_2_0.golockbg = gohelper.findChild(arg_2_0.go, "go_lock/bg")
	arg_2_0.imageLockBg = gohelper.findChildImage(arg_2_0.go, "go_lock/bg")
	arg_2_0.goLockMask = gohelper.findChild(arg_2_0.go, "go_lock/go_lockMask")
	arg_2_0.gounlockTip = gohelper.findChild(arg_2_0.go, "go_lock/unlockTip")
	arg_2_0.txtStarNum = gohelper.findChildText(arg_2_0.go, "go_lock/unlockTip/txt_starNum")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_0.go, "btn_click")

	arg_2_0:initTitleInfo(arg_2_0.goFinish)
	arg_2_0:initTitleInfo(arg_2_0.goNormal)
	arg_2_0:initTitleInfo(arg_2_0.goLock)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.btnClick:AddClickListener(arg_3_0.onClickTrainItem, arg_3_0)
end

function var_0_0.onClickTrainItem(arg_4_0)
	local var_4_0 = {
		actId = arg_4_0.actId,
		trainId = arg_4_0.trainId,
		config = arg_4_0.config,
		viewType = Season166Enum.WordTrainType
	}

	if not arg_4_0.canUnlock then
		if not arg_4_0.isUnlockTime and arg_4_0.config.type == Season166Enum.TrainSpType then
			GameFacade.showToast(ToastEnum.Season166TrainTimeLock)
		else
			GameFacade.showToast(ToastEnum.Season166TrainStarLock)
		end
	else
		Season166Controller.instance:openSeasonTrainView(var_4_0)
	end
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0.isFinish = Season166TrainModel.instance:checkIsFinish(arg_5_0.actId, arg_5_0.trainId)
	arg_5_0.canUnlock = Season166TrainModel.instance:getUnlockTrainInfoMap(arg_5_0.actId)[arg_5_0.trainId]
	arg_5_0.unlockState = arg_5_0.canUnlock and Season166Enum.UnlockState or Season166Enum.LockState
	arg_5_0.isUnlockTime = Season166TrainModel.instance:isHardEpisodeUnlockTime(arg_5_0.actId)
	arg_5_0.txtStarNum.text = arg_5_0.config.needStar

	local var_5_0 = arg_5_0.config.type == Season166Enum.TrainSpType
	local var_5_1 = var_5_0 and "season_main_stage_2_0" or "season_main_stage_1_0"
	local var_5_2 = var_5_0 and "season_main_stage_2_1" or "season_main_stage_1_2"

	UISpriteSetMgr.instance:setSeason166Sprite(arg_5_0.imageFinishBg, var_5_2, true)
	UISpriteSetMgr.instance:setSeason166Sprite(arg_5_0.imageNormalBg, var_5_1, true)
	UISpriteSetMgr.instance:setSeason166Sprite(arg_5_0.imageLockBg, var_5_1, true)
	gohelper.setActive(arg_5_0.goFinish, arg_5_0.isFinish)

	if var_5_0 then
		gohelper.setActive(arg_5_0.gounlockTip, arg_5_0.isUnlockTime)
	else
		gohelper.setActive(arg_5_0.gounlockTip, not arg_5_0.canUnlock)
	end

	gohelper.setActive(arg_5_0.goLockMask, not arg_5_0.isUnlockTime and var_5_0)
	gohelper.setActive(arg_5_0.goLock, not arg_5_0.canUnlock)
	gohelper.setActive(arg_5_0.govxEffect1, arg_5_0.canUnlock)
	gohelper.setActive(arg_5_0.govxEffect2, arg_5_0.canUnlock)
	ZProj.UGUIHelper.SetGrayscale(arg_5_0.golockbg, not arg_5_0.canUnlock)
	gohelper.setActive(arg_5_0.goNormal, arg_5_0.canUnlock and not arg_5_0.isFinish)
	gohelper.setActive(arg_5_0.goSpFinishEffect, arg_5_0.isFinish and var_5_0)
	gohelper.setActive(arg_5_0.goFinishEffect, arg_5_0.isFinish and not var_5_0)
end

function var_0_0.initTitleInfo(arg_6_0, arg_6_1)
	local var_6_0 = gohelper.findChildText(arg_6_1, "txt_title")
	local var_6_1 = gohelper.findChildText(arg_6_1, "txt_index")

	var_6_0.text = arg_6_0.config.name
	var_6_1.text = string.format("St.%d", arg_6_0.trainId)
end

function var_0_0.getUnlockState(arg_7_0)
	return arg_7_0.unlockState
end

function var_0_0.refreshUnlockState(arg_8_0, arg_8_1)
	if arg_8_0.canUnlock and arg_8_0.unlockState ~= arg_8_1 then
		if arg_8_0.isFinish then
			arg_8_0.anim:Play(UIAnimationName.Finish, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_resonate_fm)
		else
			arg_8_0.anim:Play(UIAnimationName.Unlock, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_wangshi_argus_level_open)
		end
	end
end

function var_0_0.getFinishState(arg_9_0)
	return arg_9_0.isFinish
end

function var_0_0.playFinishEffect(arg_10_0)
	if arg_10_0.isFinish then
		arg_10_0.anim:Play(UIAnimationName.Finish, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_resonate_fm)
	end
end

function var_0_0.removeEventListeners(arg_11_0)
	arg_11_0.btnClick:RemoveClickListener()
end

function var_0_0.destroy(arg_12_0)
	arg_12_0:__onDispose()
end

return var_0_0
