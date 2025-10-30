module("modules.logic.season.view3_0.Season3_0StoryCoverItem", package.seeall)

local var_0_0 = class("Season3_0StoryCoverItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.storyId = arg_2_0.param.storyId
	arg_2_0.config = arg_2_0.param.storyConfig
	arg_2_0.actId = arg_2_0.param.actId
	arg_2_0.canvasGroup = gohelper.findChild(arg_2_0.go, "go_root"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_2_0.txtStageNum = gohelper.findChildText(arg_2_0.go, "go_root/NumMask/txt_Num")
	arg_2_0.txtTitle = gohelper.findChildText(arg_2_0.go, "go_root/txt_Title")
	arg_2_0.txtTitleEn = gohelper.findChildText(arg_2_0.go, "go_root/txt_TitleEn")
	arg_2_0.goArrow = gohelper.findChild(arg_2_0.go, "go_root/go_arrow")
	arg_2_0.goLocked = gohelper.findChild(arg_2_0.go, "go_Locked")
	arg_2_0.animLocked = ZProj.ProjAnimatorPlayer.Get(arg_2_0.goLocked)
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_0.go, "btn_click")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.btnClick:AddClickListener(arg_3_0.onClickCoverItem, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0.btnClick:RemoveClickListener()
end

var_0_0.unlockDelayTime = 1.16

function var_0_0.refreshItem(arg_5_0)
	arg_5_0.isUnlock = Activity104Model.instance:isStagePassed(arg_5_0.config.condition)
	arg_5_0.canvasGroup.alpha = arg_5_0.isUnlock and 1 or 0.5
	arg_5_0.txtStageNum.text = arg_5_0.config.storyId
	arg_5_0.txtTitle.text = arg_5_0.config.title
	arg_5_0.txtTitleEn.text = arg_5_0.config.titleEn
end

function var_0_0.onClickCoverItem(arg_6_0)
	if arg_6_0.isUnlock then
		Activity104Controller.instance:dispatchEvent(Activity104Event.OnCoverItemClick, {
			storyId = arg_6_0.storyId
		})
	else
		GameFacade.showToast(ToastEnum.SeasonStoryNotOpen)
	end
end

function var_0_0.refreshUnlockState(arg_7_0, arg_7_1)
	if arg_7_0.isUnlock and arg_7_0.isUnlock ~= arg_7_1 then
		gohelper.setActive(arg_7_0.goLocked, not arg_7_1)
		UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
		UIBlockMgr.instance:startBlock("playCoverItemUnlockAnim")
		TaskDispatcher.runDelay(arg_7_0.playUnlockAnim, arg_7_0, var_0_0.unlockDelayTime)
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		gohelper.setActive(arg_7_0.goLocked, not arg_7_0.isUnlock)
	end
end

function var_0_0.playUnlockAnim(arg_8_0)
	arg_8_0.animLocked:Play(UIAnimationName.Unlock, arg_8_0.onUnlockAnimDone, arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_tale_unlock)
end

function var_0_0.onUnlockAnimDone(arg_9_0)
	gohelper.setActive(arg_9_0.goLocked, not arg_9_0.isUnlock)
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
end

function var_0_0.destroy(arg_10_0)
	arg_10_0:__onDispose()
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
	TaskDispatcher.cancelTask(arg_10_0.playUnlockAnim, arg_10_0)
end

return var_0_0
