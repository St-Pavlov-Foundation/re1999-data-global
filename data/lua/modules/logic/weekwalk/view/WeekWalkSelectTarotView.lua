module("modules.logic.weekwalk.view.WeekWalkSelectTarotView", package.seeall)

slot0 = class("WeekWalkSelectTarotView", BaseView)
slot0.delaySwitchViewTime = 0.33

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_line")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ok")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	WeekwalkRpc.instance:sendMarkShowBuffRequest()
	slot0:closeThis()
end

function slot0._btnokOnClick(slot0)
	slot0:_confirmSelect()
end

function slot0._editableInitView(slot0)
	slot0._itemList = slot0:getUserDataTb_()

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beibao00.png"))

	slot4 = ResUrl.getWeekWalkBg

	slot0._simageline:LoadImage(slot4("btn_01.png"))

	slot0._gotarotitems = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = gohelper.findChild(slot0.viewGO, "#go_container/weekwalktarotitem" .. slot4)

		table.insert(slot0._gotarotitems, slot5)
		gohelper.setActive(slot5, slot4 == 1)
	end

	gohelper.addUIClickAudio(slot0._btnok.gameObject, AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnConfirmBindingBuff, slot0._updateViewSwithTime, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._buffId = slot0.viewParam.buffId

	slot0:_refreshUI({
		slot0._buffId
	})
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.TarotReply, slot0._onTarotReply, slot0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_cardappear)
end

function slot0._refreshUI(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0._gotarotitems and slot0._gotarotitems[slot5]
		slot8 = slot7 and MonoHelper.addNoUpdateLuaComOnceToGo(slot7, WeekWalkTarotItem)

		slot8:onUpdateMO({
			tarotId = slot6,
			config = lua_weekwalk_buff.configDict[slot6]
		}, true)
		slot8:setClickCallback(slot0._onTarotSelect, slot0)
		table.insert(slot0._itemList, slot8)
	end
end

function slot0._onTarotSelect(slot0, slot1)
end

function slot0._doOnTarotSelect(slot0, slot1)
	if slot0._selectItem then
		transformhelper.setLocalScale(slot0._selectItem.viewGO.transform, 1, 1, 1)
	end

	slot0._selectTarotInfo = slot1.info
	slot0._selectItem = slot1

	transformhelper.setLocalScale(slot0._selectItem.viewGO.transform, 1.2, 1.2, 1)
end

function slot0._confirmSelect(slot0)
	if not slot0._selectTarotInfo then
		return
	end

	if slot0._selectTarotInfo.config.type == WeekWalkEnum.BuffType.Pray then
		if WeekWalkCardListModel.instance:verifyCondition(slot0._selectTarotInfo.tarotId) then
			WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickTarot, slot0._selectItem.viewGO)
			TaskDispatcher.runDelay(slot0._delayToSwitchView, slot0, uv0.delaySwitchViewTime)
		end

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickTarot, slot0._selectItem.viewGO)
	WeekwalkRpc.instance:sendWeekwalkBuffRequest(slot0._selectTarotInfo.tarotId, 0, 0)
end

function slot0._delayToSwitchView(slot0)
	WeekWalkController.instance:openWeekWalkBuffBindingView(slot0._selectTarotInfo)
end

function slot0._onTarotReply(slot0, slot1)
	WeekWalkModel.instance:setBuffReward(nil)
	TaskDispatcher.runDelay(slot0._delayToCloseThis, slot0, uv0.delaySwitchViewTime)
end

function slot0._delayToCloseThis(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayToSwitchView, slot0)
	TaskDispatcher.cancelTask(slot0._delayToCloseThis, slot0)
end

function slot0._updateViewSwithTime(slot0, slot1)
	uv0.delaySwitchViewTime = slot1 or 0
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnConfirmBindingBuff, slot0._updateViewSwithTime, slot0)
end

return slot0
