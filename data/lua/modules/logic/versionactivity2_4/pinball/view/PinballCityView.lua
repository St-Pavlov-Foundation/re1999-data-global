module("modules.logic.versionactivity2_4.pinball.view.PinballCityView", package.seeall)

slot0 = class("PinballCityView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_start")
	slot0._btnrest = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_rest")
	slot0._gorestgery = gohelper.findChild(slot0.viewGO, "Right/#btn_rest/gery")
	slot0._btnend = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_end")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_task")
	slot0._gotaskred = gohelper.findChild(slot0.viewGO, "Right/#btn_task/#go_reddotreward")
	slot0._txtDay = gohelper.findChildTextMesh(slot0.viewGO, "Top/#txt_day")
	slot0._topCurrencyRoot = gohelper.findChild(slot0.viewGO, "Top/#go_currency")
	slot0._leftCurrencyRoot = gohelper.findChild(slot0.viewGO, "Left/#go_currency")
	slot0._leftCurrencyItem = gohelper.findChild(slot0.viewGO, "Left/#go_currency/go_item")
	slot0._btnmood = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_mood/#btn_mood")
	slot0._imagemoodicon = gohelper.findChildImage(slot0.viewGO, "Left/#go_mood/#btn_mood/#simage_icon")
	slot0._imagemood1 = gohelper.findChildImage(slot0.viewGO, "Left/#go_mood/#btn_mood/#simage_progress1")
	slot0._imagemood2 = gohelper.findChildImage(slot0.viewGO, "Left/#go_mood/#btn_mood/#simage_progress2")
	slot0._imagemood2_eff = gohelper.findChildImage(slot0.viewGO, "Left/#go_mood/#btn_mood/#simage_progress2/#simage_progress2_eff")
	slot0._btntip = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_mood/#btn_tips")
	slot0._gotipright = gohelper.findChild(slot0.viewGO, "Left/#go_mood/#go_tipright")
	slot0._gotiptop = gohelper.findChild(slot0.viewGO, "Left/#go_mood/#go_tiptop")
	slot0._txttiptopnum = gohelper.findChildTextMesh(slot0.viewGO, "Left/#go_mood/#go_tiptop/layout/#txt_num")
	slot0._txtrighttips = gohelper.findChildTextMesh(slot0.viewGO, "Left/#go_mood/#go_tipright/#scroll_dec/Viewport/Content/#txt_desc")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_mood/#go_tipright/#btn_close")
	slot0._anim = gohelper.findChildAnim(slot0.viewGO, "")
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._onStartClick, slot0)
	slot0._btnrest:AddClickListener(slot0._onRestClick, slot0)
	slot0._btnend:AddClickListener(slot0._onEndClick, slot0)
	slot0._btntask:AddClickListener(slot0._onTaskClick, slot0)
	slot0._btnclosetip:AddClickListener(slot0.closeTips, slot0)
	slot0._btnmood:AddClickListener(slot0._openCloseTopTips, slot0)
	slot0._btntip:AddClickListener(slot0._openCloseRightTips, slot0)
	PinballController.instance:registerCallback(PinballEvent.EndRound, slot0._refreshUI, slot0)
	PinballController.instance:registerCallback(PinballEvent.OperChange, slot0._refreshUI, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshMood, slot0)
	PinballController.instance:registerCallback(PinballEvent.OperBuilding, slot0._refreshMood, slot0)
	PinballController.instance:registerCallback(PinballEvent.LearnTalent, slot0._refreshMood, slot0)
	slot0.viewContainer:registerCallback(PinballEvent.ClickScene, slot0.closeTips, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.closeTips, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.onViewClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnrest:RemoveClickListener()
	slot0._btnend:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
	slot0._btnclosetip:RemoveClickListener()
	slot0._btnmood:RemoveClickListener()
	slot0._btntip:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, slot0._refreshUI, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OperChange, slot0._refreshUI, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshMood, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OperBuilding, slot0._refreshMood, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.LearnTalent, slot0._refreshMood, slot0)
	slot0.viewContainer:unregisterCallback(PinballEvent.ClickScene, slot0.closeTips, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.closeTips, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onViewClose, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
	gohelper.setActive(slot0._leftCurrencyItem, false)
	RedDotController.instance:addRedDot(slot0._gotaskred, RedDotEnum.DotNode.V2a4PinballTaskRed)
	slot0:closeTips()
	slot0:createCurrencyItem()
	slot0:_refreshUI()
	PinballStatHelper.instance:resetCityDt()
	PinballController.instance:sendGuideMainLv()
end

function slot0.onViewClose(slot0, slot1)
	if slot1 == ViewName.PinballDayEndView or slot1 == ViewName.PinballGameView then
		slot0._anim.enabled = true

		slot0._anim:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
		TaskDispatcher.runDelay(slot0._openAnimFinish, slot0, 1.84)
	end
end

function slot0._openAnimFinish(slot0)
	slot0._anim.enabled = false
end

function slot0.closeTips(slot0)
	gohelper.setActive(slot0._gotipright, false)
	gohelper.setActive(slot0._btntip, true)
	gohelper.setActive(slot0._gotiptop, false)
end

function slot0._openCloseTopTips(slot0)
	gohelper.setActive(slot0._gotipright, false)
	gohelper.setActive(slot0._btntip, true)
	gohelper.setActive(slot0._gotiptop, not slot0._gotiptop.activeSelf)
end

function slot0._openCloseRightTips(slot0)
	gohelper.setActive(slot0._gotipright, not slot0._gotipright.activeSelf)
	gohelper.setActive(slot0._btntip, not slot0._gotipright.activeSelf)
	gohelper.setActive(slot0._gotiptop, false)
end

function slot0.createCurrencyItem(slot0)
	for slot5, slot6 in ipairs({
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.currency, slot0._topCurrencyRoot), PinballCurrencyItem):setCurrencyType(slot6)
	end

	for slot6, slot7 in ipairs({
		PinballEnum.ResType.Food,
		PinballEnum.ResType.Play
	}) do
		slot8 = gohelper.cloneInPlace(slot0._leftCurrencyItem)

		gohelper.setActive(slot8, true)
		MonoHelper.addNoUpdateLuaComOnceToGo(slot8, PinballCurrencyItem2):setCurrencyType(slot7)
	end
end

function slot0._refreshUI(slot0)
	slot1 = PinballModel.instance.oper ~= PinballEnum.OperType.None

	gohelper.setActive(slot0._btnstart, not slot1)
	gohelper.setActive(slot0._btnrest, not slot1)
	gohelper.setActive(slot0._btnend, slot1)
	gohelper.setActive(slot0._gorestgery, PinballModel.instance.restCdDay > 0)

	slot0._txtDay.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), PinballModel.instance.day)

	slot0:_refreshMood()
end

function slot0._refreshMood(slot0)
	if PinballModel.instance:getResNum(PinballEnum.ResType.Food) < PinballModel.instance:getTotalFoodCost() then
		if PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.NoFoodAddComplaint) ~= 0 then
			table.insert({}, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_food_not_enough"), 0 + 1, slot4))

			slot1 = 0 + slot4
		end
	elseif PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.FoodEnoughSubComplaint) ~= 0 then
		table.insert(slot2, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_food_enough"), slot3 + 1, slot4))

		slot1 = slot1 - slot4
	end

	if PinballModel.instance:getResNum(PinballEnum.ResType.Play) < PinballModel.instance:getTotalPlayDemand() then
		if PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.NoPlayAddComplaint) ~= 0 then
			table.insert(slot2, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_play_not_enough"), slot3 + 1, slot4))

			slot1 = slot1 + slot4
		end
	elseif PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.PlayEnoughSubComplaint) ~= 0 then
		table.insert(slot2, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_play_enough"), slot3 + 1, slot4))

		slot1 = slot1 - slot4
	end

	if PinballModel.instance.oper == PinballEnum.OperType.Rest and PinballModel.instance.restCdDay <= 0 and PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.RestSubComplaint) ~= 0 then
		table.insert(slot2, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_rest"), slot3 + 1, slot4))

		slot1 = slot1 - slot4
	end

	slot0._txtrighttips.text = table.concat(slot2, "\n")
	slot4 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	slot5 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold)
	slot6 = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
	slot7 = Mathf.Clamp(slot1 + slot6, 0, slot4)
	slot8 = 1

	if slot4 <= slot6 then
		slot8 = 3
	elseif slot5 <= slot6 then
		slot8 = 2
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot0._imagemoodicon, "v2a4_tutushizi_heart_" .. slot8)
	UISpriteSetMgr.instance:setAct178Sprite(slot0._imagemood2, "v2a4_tutushizi_heartprogress_" .. slot8)

	if slot7 < slot6 then
		UISpriteSetMgr.instance:setAct178Sprite(slot0._imagemood1, "v2a4_tutushizi_heartprogress_" .. slot8)
	else
		UISpriteSetMgr.instance:setAct178Sprite(slot0._imagemood1, "v2a4_tutushizi_heartprogress_4")
	end

	if slot6 / slot4 > slot7 / slot4 then
		slot10 = slot9
		slot9 = slot10
	end

	slot0._imagemood1.fillAmount = slot10
	slot0._imagemood2.fillAmount = slot9
	slot0._imagemood2_eff.fillAmount = slot9

	if slot6 == slot7 then
		slot0._txttiptopnum.text = string.format("%s/%s", slot6, slot4)
	elseif slot7 < slot6 then
		slot0._txttiptopnum.text = string.format("%s<#6EC47F>（-%s）</color>/%s", slot6, slot6 - slot7, slot4)
	else
		slot0._txttiptopnum.text = string.format("%s<#D85B5B>（+%s）</color>/%s", slot6, slot7 - slot6, slot4)
	end
end

function slot0._onStartClick(slot0)
	ViewMgr.instance:openView(ViewName.PinballMapSelectView)
end

function slot0._onRestClick(slot0)
	if PinballModel.instance.restCdDay > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.PinballRestConfirm2, MsgBoxEnum.BoxType.Yes_No, slot0.onYesClick, nil, , slot0)

		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.PinballRestConfirm, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, slot0.onYesClick, nil, , slot0)
end

function slot0.onYesClick(slot0)
	Activity178Rpc.instance:sendAct178Rest(VersionActivity2_4Enum.ActivityId.Pinball)
end

function slot0._onEndClick(slot0)
	Activity178Rpc.instance:sendAct178EndRound(VersionActivity2_4Enum.ActivityId.Pinball)
end

function slot0._onTaskClick(slot0)
	ViewMgr.instance:openView(ViewName.PinballTaskView)
end

function slot0.onClose(slot0)
	PinballStatHelper.instance:sendExitCity()
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.cancelTask(slot0._openAnimFinish, slot0)
end

return slot0
