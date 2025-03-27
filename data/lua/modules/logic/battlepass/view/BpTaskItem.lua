module("modules.logic.battlepass.view.BpTaskItem", package.seeall)

slot0 = class("BpTaskItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtTaskDesc = gohelper.findChildText(slot0.go, "#txt_taskdes")
	slot0._txtTaskTotal = gohelper.findChildText(slot0.go, "#txt_taskdes/#txt_total")
	slot0._goNotFinish = gohelper.findChildButtonWithAudio(slot0.go, "#go_notget/#btn_notfinishbg")
	slot0._goFinishBg = gohelper.findChildButtonWithAudio(slot0.go, "#go_notget/#btn_finishbg", AudioEnum.UI.play_ui_permit_receive_button)
	slot0._simageFinish2 = gohelper.findChildSingleImage(slot0.go, "#go_notget/#btn_finishbg/#simage_getmask")
	slot0._goAllFinish = gohelper.findChild(slot0.go, "#go_notget/#go_allfinish")
	slot0._simageFinish = gohelper.findChildSingleImage(slot0.go, "#go_notget/#go_allfinish/#simage_getmask")
	slot0._gobonus = gohelper.findChild(slot0.go, "#go_bonus")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.go, "#simage_bg")
	slot0._goremaintime = gohelper.findChild(slot0.go, "#go_remaintime")
	slot0._txtremaintime = gohelper.findChildTextMesh(slot0.go, "#go_remaintime/bg/icon/#txt_remaintime")
	slot0._goturnback = gohelper.findChild(slot0.go, "#go_turnback")
	slot0._gonewbie = gohelper.findChild(slot0.go, "#go_newbie")

	slot0._simageFinish:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	slot0._simageFinish2:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))

	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._gobonusItem = gohelper.findChild(slot0._gobonus, "#go_item")
	slot0._gobonusExpup = gohelper.findChild(slot0._gobonus, "#go_expup")
	slot0._gobonusExpupTxt = gohelper.findChildText(slot0._gobonusExpup, "#txt_num")
end

function slot0.addEventListeners(slot0)
	slot0._goNotFinish:AddClickListener(slot0._goNotFinishOnClick, slot0)
	slot0._goFinishBg:AddClickListener(slot0._goFinishBgOnClick, slot0)
	slot0:addEventCb(slot0._view.viewContainer, BpEvent.OnTaskFinishAnim, slot0.playFinishAnim, slot0)
	slot0:addEventCb(slot0._view.viewContainer, BpEvent.TapViewOpenAnimBegin, slot0.onTabOpen, slot0)
	slot0:addEventCb(slot0._view.viewContainer, BpEvent.TapViewCloseAnimBegin, slot0.onTabClose, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._goNotFinish:RemoveClickListener()
	slot0._goFinishBg:RemoveClickListener()
	slot0:removeEventCb(slot0._view.viewContainer, BpEvent.OnTaskFinishAnim, slot0.playFinishAnim, slot0)
	slot0:removeEventCb(slot0._view.viewContainer, BpEvent.TapViewOpenAnimBegin, slot0.onTabOpen, slot0)
	slot0:removeEventCb(slot0._view.viewContainer, BpEvent.TapViewCloseAnimBegin, slot0.onTabClose, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0._txtTaskDesc.text = slot0.mo.config.desc
	slot0._txtTaskTotal.text = string.format("%s/%s", slot0.mo.progress, slot0.mo.config.maxProgress)
	slot2 = slot0.mo.progress
	slot3 = slot0.mo.config.maxProgress
	slot4 = slot0.mo.config.loopType <= 2 and BpModel.instance:isWeeklyScoreFull()

	gohelper.setActive(slot0._goNotFinish.gameObject, not slot4 and slot2 < slot3 and slot0.mo.config.jumpId > 0)
	gohelper.setActive(slot0._goFinishBg.gameObject, not slot4 and slot3 <= slot2 and slot0.mo.finishCount == 0)
	gohelper.setActive(slot0._goAllFinish, slot4 or slot0.mo.finishCount > 0)
	gohelper.setActive(slot0._goturnback, slot1.config.turnbackTask)
	gohelper.setActive(slot0._gonewbie, slot1.config.newbieTask)

	slot5 = -1

	if not string.nilorempty(slot0.mo.config.startTime) and not string.nilorempty(slot0.mo.config.endTime) and slot0.mo.finishCount <= 0 then
		slot5 = TimeUtil.stringToTimestamp(slot0.mo.config.endTime) - ServerTime.now()
	end

	if slot5 > 0 then
		gohelper.setActive(slot0._goremaintime, true)

		if slot5 > 3600 then
			slot0._txtremaintime.text = formatLuaLang("remain", string.format("%d%s%d%s", math.floor(slot5 / 86400), luaLang("time_day"), math.floor(slot5 % 86400 / 3600), luaLang("time_hour")))
		else
			slot0._txtremaintime.text = luaLang("not_enough_one_hour")
		end
	else
		gohelper.setActive(slot0._goremaintime, false)
	end

	if not slot0.bonusItem then
		slot7 = IconMgr.instance:getCommonPropItemIcon(slot0._gobonusItem)

		gohelper.setAsFirstSibling(slot7.go)
		slot7:setMOValue(1, BpEnum.ScoreItemId, GameUtil.calcByDeltaRate1000AsInt(slot0.mo.config.bonusScore, slot0.mo.config.bonusScoreTimes), nil, true)
		slot7:setCountFontSize(36)
		slot7:setScale(0.54)
		slot7:SetCountLocalY(42)
		slot7:SetCountBgHeight(22)
		slot7:showStackableNum2()
		slot7:setHideLvAndBreakFlag(true)
		slot7:hideEquipLvAndBreak(true)

		slot0.bonusItem = slot7
	else
		slot0.bonusItem:setMOValue(1, BpEnum.ScoreItemId, slot6, nil, true)
	end

	slot0:_refreshExpup()
end

function slot0.onTabClose(slot0, slot1)
	if slot1 == 2 then
		slot0._animator:Play(UIAnimationName.Close)
	end
end

function slot0.onTabOpen(slot0, slot1)
	if slot1 == 2 then
		slot0._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0._goNotFinishOnClick(slot0)
	if slot0.mo.config.jumpId ~= 0 then
		GameFacade.jump(slot1)
	end
end

function slot0._goFinishBgOnClick(slot0)
	UIBlockMgr.instance:startBlock("BpTaskItemFinish")
	TaskDispatcher.runDelay(slot0.finishTask, slot0, BpEnum.TaskMaskTime)
	slot0._view.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim, slot0._index)
end

function slot0.playFinishAnim(slot0, slot1)
	if slot1 and slot1 ~= slot0._index then
		return
	end

	if not slot0._goFinishBg.gameObject.activeSelf then
		return
	end

	slot0._animator:Play("get", 0, 0)
end

function slot0.finishTask(slot0)
	TaskDispatcher.cancelTask(slot0.finishTask, slot0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(slot0.mo.id)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.finishTask, slot0)

	if slot0.bonusItem then
		slot0.bonusItem:onDestroy()
	end

	slot0._simageFinish:UnLoadImage()
	slot0._simageFinish2:UnLoadImage()
end

function slot0._refreshExpup(slot0)
	if 1000 + (slot0.mo.config.bonusScoreTimes or 0) > 1000 then
		slot0._gobonusExpupTxt.text = GameUtil.convertToPercentStr(slot3)
	end

	gohelper.setActive(slot0._gobonusExpup, slot4)
end

return slot0
