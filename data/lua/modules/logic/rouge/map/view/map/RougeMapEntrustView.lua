module("modules.logic.rouge.map.view.map.RougeMapEntrustView", package.seeall)

slot0 = class("RougeMapEntrustView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnEntrust = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_entrust")
	slot0._goEntrustContainer = gohelper.findChild(slot0.viewGO, "Left/#go_entrustcontainer")
	slot0._txtEntrustDesc = gohelper.findChildText(slot0.viewGO, "Left/#go_entrustcontainer/#txt_entrustdesc")
	slot0._btnHideEntrust = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_entrustcontainer/#btn_hideentrust")
	slot0._gocangeteffect = gohelper.findChild(slot0.viewGO, "Left/#btn_entrust/#effect_canget")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEntrust:AddClickListener(slot0._btnEntrustOnClick, slot0)
	slot0._btnHideEntrust:AddClickListener(slot0._btnHideEntrustOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEntrust:RemoveClickListener()
	slot0._btnHideEntrust:RemoveClickListener()
end

function slot0._btnEntrustOnClick(slot0)
	if not slot0.hadEntrust then
		return
	end

	slot0.status = RougeMapEnum.EntrustStatus.Detail

	slot0:refreshStatus()
end

function slot0._btnHideEntrustOnClick(slot0)
	if not slot0.hadEntrust then
		return
	end

	slot0:closeEntrust()
end

function slot0._editableInitView(slot0)
	slot0.goEntrustBtn = slot0._btnEntrust.gameObject
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._goEntrustContainer)

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onEntrustChange, slot0.onEntrustChange, slot0)
end

function slot0.onEntrustChange(slot0)
	slot0:tryShowEntrust()
end

function slot0.onOpen(slot0)
	slot0:tryShowEntrust()
end

function slot0.tryShowEntrust(slot0)
	slot0.status = RougeMapEnum.EntrustStatus.Detail

	slot0:updateHadEntrust()
	slot0:refreshEntrust()

	if slot0.hadEntrust then
		TaskDispatcher.cancelTask(slot0.closeEntrust, slot0)
		TaskDispatcher.runDelay(slot0.closeEntrust, slot0, RougeMapEnum.ChangeEntrustTime)
	end
end

function slot0.closeEntrust(slot0)
	if slot0.closing then
		return
	end

	slot0.closing = true

	slot0.animatorPlayer:Play("close", slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0.closing = nil
	slot0.status = RougeMapEnum.EntrustStatus.Brief

	slot0:refreshStatus()
	slot0:refreshEffect()
end

function slot0.updateHadEntrust(slot0)
	slot1 = RougeMapModel.instance:getEntrustId()
	slot0.entrustId = slot1
	slot0.hadEntrust = slot1 ~= nil
	slot0.entrustProgress = RougeMapModel.instance:getEntrustProgress()
	slot0.isFinished = slot0.entrustProgress and slot0.entrustProgress >= 1
end

function slot0.refreshEntrust(slot0)
	if not slot0.hadEntrust then
		slot0:hideEntrust()

		return
	end

	slot1 = lua_rouge_entrust.configDict[slot0.entrustId]

	slot0:refreshStatus()
	slot0:initEntrustDescHandle()
	slot0:refreshEffect()

	slot0._txtEntrustDesc.text = slot0.entrustTypeHandleDict[slot1.type] and slot3(slot0, slot1, lua_rouge_entrust_desc.configDict[slot1.type]) or ""
end

function slot0.refreshStatus(slot0)
	gohelper.setActive(slot0.goEntrustBtn, slot0.status == RougeMapEnum.EntrustStatus.Brief)
	gohelper.setActive(slot0._goEntrustContainer, slot0.status == RougeMapEnum.EntrustStatus.Detail)
end

function slot0.refreshEffect(slot0)
	slot1 = false

	gohelper.setActive(slot0._gocangeteffect, slot1)

	if slot1 then
		TaskDispatcher.cancelTask(slot0.hideCangetEffect, slot0)
		TaskDispatcher.runDelay(slot0.hideCangetEffect, slot0, RougeMapEnum.FinishEntrustEffect)
	end
end

function slot0.hideCangetEffect(slot0)
	gohelper.setActive(slot0._gocangeteffect, false)
end

function slot0.hideEntrust(slot0)
	gohelper.setActive(slot0.goEntrustBtn, false)
	gohelper.setActive(slot0._goEntrustContainer, false)
end

function slot0.initEntrustDescHandle(slot0)
	if slot0.entrustTypeHandleDict then
		return
	end

	slot0.entrustTypeHandleDict = {
		[RougeMapEnum.EntrustEventType.MakeMoney] = slot0.makeMoneyHandle,
		[RougeMapEnum.EntrustEventType.CostMoney] = slot0.costMoneyHandle,
		[RougeMapEnum.EntrustEventType.Event] = slot0.eventHandle,
		[RougeMapEnum.EntrustEventType.Curse] = slot0.curseHandle,
		[RougeMapEnum.EntrustEventType.CostPower] = slot0.costPowerHandle,
		[RougeMapEnum.EntrustEventType.MakePower] = slot0.makePowerHandle,
		[RougeMapEnum.EntrustEventType.FinishEvent] = slot0.finishEventHandle,
		[RougeMapEnum.EntrustEventType.GetCollection] = slot0.getCollectionHandle,
		[RougeMapEnum.EntrustEventType.LevelUpSpCollection] = slot0.levelupSpCollectionHandle
	}
end

function slot0.makeMoneyHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0:getDesc(slot2, tonumber(slot1.param) <= RougeMapModel.instance:getEntrustProgress()), slot3, slot4)
end

function slot0.costMoneyHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0:getDesc(slot2, tonumber(slot1.param) <= RougeMapModel.instance:getEntrustProgress()), slot3, slot4)
end

function slot0.eventHandle(slot0, slot1, slot2)
	slot3 = RougeMapModel.instance:getEntrustProgress()

	for slot9 = 1, #string.splitToNumber(string.split(slot1.param, "|")[1], "#") do
		slot5[slot9] = lua_rouge_event_type.configDict[slot5[slot9]].name
	end

	return GameUtil.getSubPlaceholderLuaLangThreeParam(slot0:getDesc(slot2, tonumber(slot4[2]) <= slot3), slot6, table.concat(slot5, "_"), slot3)
end

function slot0.curseHandle(slot0, slot1, slot2)
	return slot2.desc
end

function slot0.costPowerHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0:getDesc(slot2, tonumber(slot1.param) <= RougeMapModel.instance:getEntrustProgress()), slot3, slot4)
end

function slot0.makePowerHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0:getDesc(slot2, tonumber(slot1.param) <= RougeMapModel.instance:getEntrustProgress()), slot3, slot4)
end

function slot0.finishEventHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0:getDesc(slot2, RougeMapModel.instance:getEntrustProgress() >= 1), RougeMapConfig.instance:getRougeEvent(tonumber(slot1.param)).name)
end

function slot0.getCollectionHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0:getDesc(slot2, tonumber(slot1.param) <= RougeMapModel.instance:getEntrustProgress()), slot3, slot4)
end

function slot0.levelupSpCollectionHandle(slot0, slot1, slot2)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0:getDesc(slot2, tonumber(slot1.param) <= RougeMapModel.instance:getEntrustProgress()), slot3, slot4)
end

function slot0.getDesc(slot0, slot1, slot2)
	return slot2 and slot1.finishDesc or slot1.desc
end

function slot0.onClose(slot0)
	slot0.closing = nil

	TaskDispatcher.cancelTask(slot0.closeEntrust, slot0)
	TaskDispatcher.cancelTask(slot0.hideCangetEffect, slot0)
end

return slot0
