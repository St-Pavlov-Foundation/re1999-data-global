module("modules.logic.versionactivity2_4.pinball.view.PinballCityView", package.seeall)

local var_0_0 = class("PinballCityView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_start")
	arg_1_0._btnrest = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_rest")
	arg_1_0._gorestgery = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_rest/gery")
	arg_1_0._btnend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_end")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_task")
	arg_1_0._gotaskred = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_task/#go_reddotreward")
	arg_1_0._txtDay = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/#txt_day")
	arg_1_0._topCurrencyRoot = gohelper.findChild(arg_1_0.viewGO, "Top/#go_currency")
	arg_1_0._leftCurrencyRoot = gohelper.findChild(arg_1_0.viewGO, "Left/#go_currency")
	arg_1_0._leftCurrencyItem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_currency/go_item")
	arg_1_0._btnmood = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_mood/#btn_mood")
	arg_1_0._imagemoodicon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_mood/#btn_mood/#simage_icon")
	arg_1_0._imagemood1 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_mood/#btn_mood/#simage_progress1")
	arg_1_0._imagemood2 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_mood/#btn_mood/#simage_progress2")
	arg_1_0._imagemood2_eff = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_mood/#btn_mood/#simage_progress2/#simage_progress2_eff")
	arg_1_0._btntip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_mood/#btn_tips")
	arg_1_0._gotipright = gohelper.findChild(arg_1_0.viewGO, "Left/#go_mood/#go_tipright")
	arg_1_0._gotiptop = gohelper.findChild(arg_1_0.viewGO, "Left/#go_mood/#go_tiptop")
	arg_1_0._txttiptopnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_mood/#go_tiptop/layout/#txt_num")
	arg_1_0._txtrighttips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_mood/#go_tipright/#scroll_dec/Viewport/Content/#txt_desc")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_mood/#go_tipright/#btn_close")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._onStartClick, arg_2_0)
	arg_2_0._btnrest:AddClickListener(arg_2_0._onRestClick, arg_2_0)
	arg_2_0._btnend:AddClickListener(arg_2_0._onEndClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._onTaskClick, arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0.closeTips, arg_2_0)
	arg_2_0._btnmood:AddClickListener(arg_2_0._openCloseTopTips, arg_2_0)
	arg_2_0._btntip:AddClickListener(arg_2_0._openCloseRightTips, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.EndRound, arg_2_0._refreshUI, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OperChange, arg_2_0._refreshUI, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_2_0._refreshMood, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OperBuilding, arg_2_0._refreshMood, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.LearnTalent, arg_2_0._refreshMood, arg_2_0)
	arg_2_0.viewContainer:registerCallback(PinballEvent.ClickScene, arg_2_0.closeTips, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0.closeTips, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0.onViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnrest:RemoveClickListener()
	arg_3_0._btnend:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnclosetip:RemoveClickListener()
	arg_3_0._btnmood:RemoveClickListener()
	arg_3_0._btntip:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, arg_3_0._refreshUI, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.OperChange, arg_3_0._refreshUI, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_3_0._refreshMood, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.OperBuilding, arg_3_0._refreshMood, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.LearnTalent, arg_3_0._refreshMood, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(PinballEvent.ClickScene, arg_3_0.closeTips, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0.closeTips, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0.onViewClose, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
	gohelper.setActive(arg_4_0._leftCurrencyItem, false)
	RedDotController.instance:addRedDot(arg_4_0._gotaskred, RedDotEnum.DotNode.V2a4PinballTaskRed)
	arg_4_0:closeTips()
	arg_4_0:createCurrencyItem()
	arg_4_0:_refreshUI()
	PinballStatHelper.instance:resetCityDt()
	PinballController.instance:sendGuideMainLv()
end

function var_0_0.onViewClose(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.PinballDayEndView or arg_5_1 == ViewName.PinballGameView then
		arg_5_0._anim.enabled = true

		arg_5_0._anim:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
		TaskDispatcher.runDelay(arg_5_0._openAnimFinish, arg_5_0, 1.84)
	end
end

function var_0_0._openAnimFinish(arg_6_0)
	arg_6_0._anim.enabled = false
end

function var_0_0.closeTips(arg_7_0)
	gohelper.setActive(arg_7_0._gotipright, false)
	gohelper.setActive(arg_7_0._btntip, true)
	gohelper.setActive(arg_7_0._gotiptop, false)
end

function var_0_0._openCloseTopTips(arg_8_0)
	gohelper.setActive(arg_8_0._gotipright, false)
	gohelper.setActive(arg_8_0._btntip, true)
	gohelper.setActive(arg_8_0._gotiptop, not arg_8_0._gotiptop.activeSelf)
end

function var_0_0._openCloseRightTips(arg_9_0)
	gohelper.setActive(arg_9_0._gotipright, not arg_9_0._gotipright.activeSelf)
	gohelper.setActive(arg_9_0._btntip, not arg_9_0._gotipright.activeSelf)
	gohelper.setActive(arg_9_0._gotiptop, false)
end

function var_0_0.createCurrencyItem(arg_10_0)
	local var_10_0 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:getResInst(arg_10_0.viewContainer._viewSetting.otherRes.currency, arg_10_0._topCurrencyRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, PinballCurrencyItem):setCurrencyType(iter_10_1)
	end

	local var_10_2 = {
		PinballEnum.ResType.Food,
		PinballEnum.ResType.Play
	}

	for iter_10_2, iter_10_3 in ipairs(var_10_2) do
		local var_10_3 = gohelper.cloneInPlace(arg_10_0._leftCurrencyItem)

		gohelper.setActive(var_10_3, true)
		MonoHelper.addNoUpdateLuaComOnceToGo(var_10_3, PinballCurrencyItem2):setCurrencyType(iter_10_3)
	end
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = PinballModel.instance.oper ~= PinballEnum.OperType.None

	gohelper.setActive(arg_11_0._btnstart, not var_11_0)
	gohelper.setActive(arg_11_0._btnrest, not var_11_0)
	gohelper.setActive(arg_11_0._btnend, var_11_0)
	gohelper.setActive(arg_11_0._gorestgery, PinballModel.instance.restCdDay > 0)

	arg_11_0._txtDay.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), PinballModel.instance.day)

	arg_11_0:_refreshMood()
end

function var_0_0._refreshMood(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = {}
	local var_12_2 = 0

	if PinballModel.instance:getTotalFoodCost() > PinballModel.instance:getResNum(PinballEnum.ResType.Food) then
		local var_12_3 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.NoFoodAddComplaint)

		if var_12_3 ~= 0 then
			var_12_2 = var_12_2 + 1

			table.insert(var_12_1, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_food_not_enough"), var_12_2, var_12_3))

			var_12_0 = var_12_0 + var_12_3
		end
	else
		local var_12_4 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.FoodEnoughSubComplaint)

		if var_12_4 ~= 0 then
			var_12_2 = var_12_2 + 1

			table.insert(var_12_1, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_food_enough"), var_12_2, var_12_4))

			var_12_0 = var_12_0 - var_12_4
		end
	end

	if PinballModel.instance:getTotalPlayDemand() > PinballModel.instance:getResNum(PinballEnum.ResType.Play) then
		local var_12_5 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.NoPlayAddComplaint)

		if var_12_5 ~= 0 then
			var_12_2 = var_12_2 + 1

			table.insert(var_12_1, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_play_not_enough"), var_12_2, var_12_5))

			var_12_0 = var_12_0 + var_12_5
		end
	else
		local var_12_6 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.PlayEnoughSubComplaint)

		if var_12_6 ~= 0 then
			var_12_2 = var_12_2 + 1

			table.insert(var_12_1, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_play_enough"), var_12_2, var_12_6))

			var_12_0 = var_12_0 - var_12_6
		end
	end

	if PinballModel.instance.oper == PinballEnum.OperType.Rest and PinballModel.instance.restCdDay <= 0 then
		local var_12_7 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.RestSubComplaint)

		if var_12_7 ~= 0 then
			local var_12_8 = var_12_2 + 1

			table.insert(var_12_1, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_rest"), var_12_8, var_12_7))

			var_12_0 = var_12_0 - var_12_7
		end
	end

	arg_12_0._txtrighttips.text = table.concat(var_12_1, "\n")

	local var_12_9 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	local var_12_10 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold)
	local var_12_11 = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
	local var_12_12 = var_12_0 + var_12_11
	local var_12_13 = Mathf.Clamp(var_12_12, 0, var_12_9)
	local var_12_14 = 1

	if var_12_9 <= var_12_11 then
		var_12_14 = 3
	elseif var_12_10 <= var_12_11 then
		var_12_14 = 2
	end

	UISpriteSetMgr.instance:setAct178Sprite(arg_12_0._imagemoodicon, "v2a4_tutushizi_heart_" .. var_12_14)
	UISpriteSetMgr.instance:setAct178Sprite(arg_12_0._imagemood2, "v2a4_tutushizi_heartprogress_" .. var_12_14)

	if var_12_13 < var_12_11 then
		UISpriteSetMgr.instance:setAct178Sprite(arg_12_0._imagemood1, "v2a4_tutushizi_heartprogress_" .. var_12_14)
	else
		UISpriteSetMgr.instance:setAct178Sprite(arg_12_0._imagemood1, "v2a4_tutushizi_heartprogress_4")
	end

	local var_12_15 = var_12_11 / var_12_9
	local var_12_16 = var_12_13 / var_12_9

	if var_12_16 < var_12_15 then
		var_12_15, var_12_16 = var_12_16, var_12_15
	end

	arg_12_0._imagemood1.fillAmount = var_12_16
	arg_12_0._imagemood2.fillAmount = var_12_15
	arg_12_0._imagemood2_eff.fillAmount = var_12_15

	if var_12_11 == var_12_13 then
		arg_12_0._txttiptopnum.text = string.format("%s/%s", var_12_11, var_12_9)
	elseif var_12_13 < var_12_11 then
		arg_12_0._txttiptopnum.text = string.format("%s<#6EC47F>（-%s）</color>/%s", var_12_11, var_12_11 - var_12_13, var_12_9)
	else
		arg_12_0._txttiptopnum.text = string.format("%s<#D85B5B>（+%s）</color>/%s", var_12_11, var_12_13 - var_12_11, var_12_9)
	end
end

function var_0_0._onStartClick(arg_13_0)
	ViewMgr.instance:openView(ViewName.PinballMapSelectView)
end

function var_0_0._onRestClick(arg_14_0)
	if PinballModel.instance.restCdDay > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.PinballRestConfirm2, MsgBoxEnum.BoxType.Yes_No, arg_14_0.onYesClick, nil, nil, arg_14_0)

		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.PinballRestConfirm, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, arg_14_0.onYesClick, nil, nil, arg_14_0)
end

function var_0_0.onYesClick(arg_15_0)
	Activity178Rpc.instance:sendAct178Rest(VersionActivity2_4Enum.ActivityId.Pinball)
end

function var_0_0._onEndClick(arg_16_0)
	Activity178Rpc.instance:sendAct178EndRound(VersionActivity2_4Enum.ActivityId.Pinball)
end

function var_0_0._onTaskClick(arg_17_0)
	ViewMgr.instance:openView(ViewName.PinballTaskView)
end

function var_0_0.onClose(arg_18_0)
	PinballStatHelper.instance:sendExitCity()
	gohelper.setActive(arg_18_0.viewGO, false)
	TaskDispatcher.cancelTask(arg_18_0._openAnimFinish, arg_18_0)
end

return var_0_0
