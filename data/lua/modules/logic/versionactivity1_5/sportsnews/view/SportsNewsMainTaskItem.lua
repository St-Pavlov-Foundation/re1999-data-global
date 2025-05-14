module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsMainTaskItem", package.seeall)

local var_0_0 = class("SportsNewsMainTaskItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounlocked = gohelper.findChild(arg_1_0.viewGO, "go_unlocked")
	arg_1_0._imageItemBG1 = gohelper.findChildImage(arg_1_0.viewGO, "go_unlocked/#image_ItemBG1")
	arg_1_0._gounlockedpic = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_unlocked/#go_unlockedpic")
	arg_1_0._txtunlocktitle = gohelper.findChildText(arg_1_0.viewGO, "go_unlocked/#txt_unlocktitle")
	arg_1_0._scrollunlockdesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_unlocked/#scroll_unlockdesc")
	arg_1_0._txtunlockdescr = gohelper.findChildText(arg_1_0.viewGO, "go_unlocked/#scroll_unlockdesc/Viewport/#txt_unlockdescr")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "go_locked")
	arg_1_0._imageItemBG2 = gohelper.findChildImage(arg_1_0.viewGO, "go_locked/#image_ItemBG2")
	arg_1_0._golockedpic = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_locked/#go_lockedpic")
	arg_1_0._txtlocktitle = gohelper.findChildText(arg_1_0.viewGO, "go_locked/#txt_locktitle")
	arg_1_0._scrolllockdesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_locked/#scroll_lockdesc")
	arg_1_0._txtlockdescr = gohelper.findChildText(arg_1_0.viewGO, "go_locked/#scroll_lockdesc/Viewport/#txt_lockdescr")
	arg_1_0._btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_locked/#btn_Finish/Click")
	arg_1_0._btnGo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_locked/#btn_Go/Click")
	arg_1_0._goRedPoint = gohelper.findChild(arg_1_0.viewGO, "#go_RedPoint")
	arg_1_0._goFinish = gohelper.findChild(arg_1_0.viewGO, "go_locked/#btn_Finish")
	arg_1_0._goGo = gohelper.findChild(arg_1_0.viewGO, "go_locked/#btn_Go")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_unlocked/#btn_Info/Click")
	arg_1_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnFinish:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
	arg_2_0._btnGo:AddClickListener(arg_2_0._btnGoOnClick, arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0:addEventCb(SportsNewsController.instance, SportsNewsEvent.OnCutTab, arg_2_0.onCutTab, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnFinish:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0:removeEventCb(SportsNewsController.instance, SportsNewsEvent.OnCutTab, arg_3_0.onCutTab, arg_3_0)
end

function var_0_0._btnFinishOnClick(arg_4_0)
	if arg_4_0._playingAnim then
		return
	end

	local var_4_0 = VersionActivity1_5Enum.ActivityId.SportsNews

	SportsNewsModel.instance:finishOrder(var_4_0, arg_4_0.orderMO.id)
	arg_4_0:playAnim()
end

function var_0_0._btnGoOnClick(arg_5_0)
	if arg_5_0._playingAnim then
		return
	end

	SportsNewsController.instance:jumpToFinishTask(arg_5_0.orderMO, nil, arg_5_0)
end

function var_0_0._btnInfoOnClick(arg_6_0)
	if arg_6_0._playingAnim then
		return
	end

	if arg_6_0.orderMO.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
		local var_6_0 = VersionActivity1_5Enum.ActivityId.SportsNews

		SportsNewsModel.instance:onReadEnd(var_6_0, arg_6_0.orderMO.id)
	end

	ViewMgr.instance:openView(ViewName.SportsNewsReadView, {
		orderMO = arg_6_0.orderMO
	})
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtunlocktitle.overflowMode = TMPro.TextOverflowModes.Ellipsis
	arg_7_0._txtunlockdescr.overflowMode = TMPro.TextOverflowModes.Ellipsis
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0:removeEvents()
	arg_11_0._gounlockedpic:UnLoadImage()
	arg_11_0._golockedpic:UnLoadImage()
end

function var_0_0.initData(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.viewGO = arg_12_1
	arg_12_0.index = arg_12_2

	arg_12_0:onInitView()
	arg_12_0:addEvents()
end

function var_0_0.onRefresh(arg_13_0, arg_13_1)
	arg_13_0.orderMO = arg_13_1

	if not arg_13_0._playingAnim then
		arg_13_0._anim.enabled = true

		arg_13_0._anim:Play(UIAnimationName.Idle, 0, 0)
	end

	if arg_13_0.orderMO.status == ActivityWarmUpEnum.OrderStatus.Finished then
		arg_13_0:unlockState()

		if arg_13_0:isCanPlayAnim() then
			arg_13_0:playAnim()
		end
	else
		arg_13_0:lockState()
	end
end

function var_0_0._onJumpFinish(arg_14_0)
	return
end

function var_0_0.unlockState(arg_15_0)
	gohelper.setActive(arg_15_0._gounlocked, true)
	gohelper.setActive(arg_15_0._golocked, arg_15_0._playingAnim)

	local var_15_0 = arg_15_0.orderMO.cfg.name
	local var_15_1 = arg_15_0.orderMO.cfg.desc

	arg_15_0._txtunlocktitle.text = var_15_0
	arg_15_0._txtunlockdescr.text = var_15_1
	arg_15_0._scrollunlockdesc:GetComponent(gohelper.Type_LimitedScrollRect).verticalNormalizedPosition = 1

	local var_15_2 = arg_15_0.orderMO.cfg.bossPic

	arg_15_0._gounlockedpic:LoadImage(ResUrl.getV1a5News(var_15_2))
end

function var_0_0.lockState(arg_16_0)
	gohelper.setActive(arg_16_0._gounlocked, false)
	gohelper.setActive(arg_16_0._golocked, true)

	local var_16_0 = arg_16_0.orderMO.status

	gohelper.setActive(arg_16_0._goFinish, var_16_0 == ActivityWarmUpEnum.OrderStatus.Collected)
	gohelper.setActive(arg_16_0._goGo, var_16_0 == ActivityWarmUpEnum.OrderStatus.Accepted)

	local var_16_1 = arg_16_0.orderMO.cfg.name
	local var_16_2
	local var_16_3 = string.format(luaLang("v1a5_news_order_goto_title"), arg_16_0.orderMO.cfg.location)

	arg_16_0._txtlocktitle.text = var_16_1
	arg_16_0._txtlockdescr.text = var_16_3
	arg_16_0._scrolllockdesc:GetComponent(gohelper.Type_LimitedScrollRect).verticalNormalizedPosition = 1

	local var_16_4 = arg_16_0.orderMO.cfg.bossPic

	arg_16_0._golockedpic:LoadImage(ResUrl.getV1a5News(var_16_4))
end

var_0_0.UI_CLICK_BLOCK_KEY = "SportsNewsMainTaskItemClick"

function var_0_0.playAnim(arg_17_0)
	arg_17_0._playingAnim = true

	arg_17_0:setUnlockPrefs(arg_17_0.orderMO.id)
	gohelper.setActive(arg_17_0._gounlocked, true)
	gohelper.setActive(arg_17_0._golocked, true)
	arg_17_0._animatorPlayer:Play(UIAnimationName.Unlock, arg_17_0.onFinishUnlockAnim, arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.ui_v1a5_news.play_ui_wulu_complete_burn)
end

function var_0_0.onFinishUnlockAnim(arg_18_0)
	gohelper.setActive(arg_18_0._golocked, false)
	gohelper.setActive(arg_18_0._gounlocked, true)

	arg_18_0._playingAnim = nil

	arg_18_0:onRefresh(arg_18_0.orderMO)
end

function var_0_0.isCanPlayAnim(arg_19_0)
	return arg_19_0:getUnlockPrefs(arg_19_0.orderMO.id) == 0
end

var_0_0.DayUnlockPrefs = "v1a5_news_prefs_order"

function var_0_0.getUnlockPrefs(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0.DayUnlockPrefs .. arg_20_1

	return (SportsNewsModel.instance:getPrefs(var_20_0))
end

function var_0_0.setUnlockPrefs(arg_21_0, arg_21_1)
	local var_21_0 = var_0_0.DayUnlockPrefs .. arg_21_1

	SportsNewsModel.instance:setPrefs(var_21_0)
end

function var_0_0.onCutTab(arg_22_0, arg_22_1)
	if arg_22_0._playingAnim then
		arg_22_0._anim:Play(UIAnimationName.Unlock, 0, 0)

		arg_22_0._anim.enabled = false

		arg_22_0:onFinishUnlockAnim()
	end
end

return var_0_0
