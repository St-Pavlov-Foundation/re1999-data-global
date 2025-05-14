module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPageTabItem", package.seeall)

local var_0_0 = class("SportsNewsPageTabItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "#image_bg")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._txtselect = gohelper.findChildText(arg_1_0.viewGO, "#go_select/#txt_select")
	arg_1_0._txtselectnum = gohelper.findChildText(arg_1_0.viewGO, "#go_select/#txt_selectnum")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "#go_unselect")
	arg_1_0._txtunselect = gohelper.findChildText(arg_1_0.viewGO, "#go_unselect/#txt_unselect")
	arg_1_0._txtunselectnum = gohelper.findChildText(arg_1_0.viewGO, "#go_unselect/#txt_unselectnum")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._imagelockbg = gohelper.findChildImage(arg_1_0._golock, "image_lockbg")
	arg_1_0._imageanilockbg = gohelper.findChildImage(arg_1_0._golock, "ani/image_lockbg")
	arg_1_0._txtlock = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/#txt_lock")
	arg_1_0._txtlocknum = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/#txt_locknum")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_redpoint")
	arg_1_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0:getTabStatus() == SportsNewsEnum.PageTabStatus.UnSelect then
		ActivityWarmUpController.instance:switchTab(arg_4_0._index)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnCutTab, 1)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:removeEvents()
	TaskDispatcher.cancelTask(arg_9_0.runDelayCallBack, arg_9_0)
end

function var_0_0.initData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._index = arg_10_1
	arg_10_0.viewGO = arg_10_2

	arg_10_0:onInitView()
	arg_10_0:addEvents()

	local var_10_0 = arg_10_0._index == 4 and 2 or 1
	local var_10_1 = "v1a5_news_tabbtnlock0" .. var_10_0

	UISpriteSetMgr.instance:setNewsSprite(arg_10_0._imagelockbg, var_10_1, true)
	UISpriteSetMgr.instance:setNewsSprite(arg_10_0._imageanilockbg, var_10_1, true)

	arg_10_0._txtselectnum.text = arg_10_1
	arg_10_0._txtunselectnum.text = arg_10_1
	arg_10_0._txtlocknum.text = arg_10_1

	arg_10_0:playTabAnim()
end

function var_0_0.onRefresh(arg_11_0)
	local var_11_0 = arg_11_0:getTabStatus()

	arg_11_0:enableStatusGameobj()

	local var_11_1
	local var_11_2 = var_11_0 == SportsNewsEnum.PageTabStatus.Select and "v1a5_news_tabbtnselect" or "v1a5_news_tabbtnnormal"

	UISpriteSetMgr.instance:setNewsSprite(arg_11_0._imagebg, var_11_2, true)
end

function var_0_0.enableStatusGameobj(arg_12_0)
	local var_12_0 = arg_12_0:getTabStatus()
	local var_12_1 = var_12_0 == SportsNewsEnum.PageTabStatus.Lock
	local var_12_2 = var_12_0 == SportsNewsEnum.PageTabStatus.Select
	local var_12_3 = var_12_0 == SportsNewsEnum.PageTabStatus.UnSelect

	gohelper.setActive(arg_12_0._golock, arg_12_0._playingAnim or var_12_1)
	gohelper.setActive(arg_12_0._imagebg.gameObject, not var_12_1)
	gohelper.setActive(arg_12_0._goselect, var_12_2)
	gohelper.setActive(arg_12_0._gounselect, var_12_3)
end

function var_0_0.getTabStatus(arg_13_0)
	local var_13_0 = ActivityWarmUpModel.instance:getCurrentDay()
	local var_13_1 = ActivityWarmUpModel.instance:getSelectedDay() == arg_13_0._index

	if var_13_0 < arg_13_0._index then
		return SportsNewsEnum.PageTabStatus.Lock
	elseif var_13_1 then
		return SportsNewsEnum.PageTabStatus.Select
	else
		return SportsNewsEnum.PageTabStatus.UnSelect
	end
end

function var_0_0.enableRedDot(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	gohelper.setActive(arg_14_0._goreddot, arg_14_1)

	if arg_14_1 then
		RedDotController.instance:addRedDot(arg_14_0._goreddot, arg_14_2, arg_14_3)
	end
end

function var_0_0.playTabAnim(arg_15_0)
	local var_15_0 = arg_15_0:isCanPlayAnim()

	TaskDispatcher.cancelTask(arg_15_0.runDelayCallBack, arg_15_0)

	if var_15_0 then
		arg_15_0._playingAnim = true

		arg_15_0:enableStatusGameobj()
		arg_15_0._animatorPlayer:Play(UIAnimationName.Unlock, arg_15_0.onFinishUnlockAnim, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0.runDelayCallBack, arg_15_0, 1)
	end
end

function var_0_0.runDelayCallBack(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.runDelayCallBack, arg_16_0)

	arg_16_0._playingAnim = nil

	arg_16_0:setUnlockPrefs(arg_16_0._index)
end

function var_0_0.onFinishUnlockAnim(arg_17_0)
	arg_17_0:enableStatusGameobj()
end

function var_0_0.isCanPlayAnim(arg_18_0)
	local var_18_0 = ActivityWarmUpModel.instance:getCurrentDay()
	local var_18_1 = arg_18_0:getUnlockPrefs(arg_18_0._index)

	return var_18_0 >= arg_18_0._index and var_18_1 == 0
end

var_0_0.DayUnlockPrefs = "v1a5_news_prefs_day_tab"

function var_0_0.getUnlockPrefs(arg_19_0, arg_19_1)
	local var_19_0 = var_0_0.DayUnlockPrefs .. arg_19_1

	return (SportsNewsModel.instance:getPrefs(var_19_0))
end

function var_0_0.setUnlockPrefs(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0.DayUnlockPrefs .. arg_20_1

	SportsNewsModel.instance:setPrefs(var_20_0)
end

return var_0_0
