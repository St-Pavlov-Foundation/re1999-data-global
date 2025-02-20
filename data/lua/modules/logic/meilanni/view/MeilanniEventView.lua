module("modules.logic.meilanni.view.MeilanniEventView", package.seeall)

slot0 = class("MeilanniEventView", BaseView)

function slot0.onInitView(slot0)
	slot0._goeventlist = gohelper.findChild(slot0.viewGO, "#go_eventlist")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._episodeInfoUpdate(slot0)
	if slot0._mapInfo:getCurEpisodeInfo() ~= slot0._episodeInfo then
		MeilanniAnimationController.instance:addDelayCall(slot0._updateElements, slot0, nil, MeilanniEnum.showElementTime, MeilanniAnimationController.showElementsLayer)
	else
		slot0:_updateElements()
	end
end

function slot0._updateElements(slot0)
	slot2 = slot0._mapInfo:getCurEpisodeInfo() ~= slot0._episodeInfo

	if slot1.isFinish then
		slot0:_removeAllElements()

		return
	end

	if slot2 then
		slot0:_removeAllElements()
	end

	if not slot2 then
		slot0:_showElements(false)

		return
	end

	TaskDispatcher.cancelTask(slot0._delayShowElements, slot0)
	TaskDispatcher.runDelay(slot0._delayShowElements, slot0, 0.5)
end

function slot0._delayShowElements(slot0)
	slot0:_showElements(true)
end

function slot0._resetMap(slot0)
	slot0:_updateElements()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, slot0._episodeInfoUpdate, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.setElementsVisible, slot0._setElementsVisible, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.getInfo, slot0._getInfo, slot0)

	slot0._mapId = slot0.viewParam.mapId
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)
	slot0._eventList = slot0:getUserDataTb_()

	slot0:_showElements(true)
end

function slot0._getInfo(slot0)
	if slot0._mapInfo.isFinish then
		slot0:_removeAllElements()
	end
end

function slot0.mapIsFinish(slot0)
	if slot0._mapInfo.isFinish or slot0._mapInfo.score <= 0 then
		return true
	end
end

function slot0.onOpenFinish(slot0)
end

function slot0._openBattleElement(slot0)
	if not MeilanniModel.instance:getBattleElementId() then
		return
	end

	MeilanniModel.instance:setBattleElementId(nil)

	if not slot0._eventList[slot1] then
		return
	end

	slot3 = slot2._info
	slot4 = slot3.eventId

	if slot3:getType() == MeilanniEnum.ElementType.Battle then
		return
	end

	slot2:_onClick()
end

function slot0._removeAllElements(slot0)
	if not slot0._episodeInfo then
		return
	end

	for slot4, slot5 in ipairs(slot0._episodeInfo.events) do
		slot0:_removeElement(slot5)
	end
end

function slot0._showElements(slot0, slot1)
	if slot0:mapIsFinish() then
		return
	end

	slot2 = nil
	slot0._episodeInfo = slot0._mapInfo:getCurEpisodeInfo()

	for slot6, slot7 in ipairs(slot0._episodeInfo.events) do
		if slot7.isFinish then
			slot0:_removeElement(slot7)
		elseif slot7.index > 0 then
			slot2 = slot0:_addElement(slot7)
		end
	end

	for slot6, slot7 in pairs(slot0._eventList) do
		if not slot0._episodeInfo:getEventInfo(slot6) then
			slot0:_removeElementById(slot6)
		end
	end

	if slot2 then
		for slot6, slot7 in pairs(slot0._eventList) do
			if slot7 ~= slot2 then
				gohelper.setActive(slot7.viewGO, false)
			end
		end
	end

	if slot1 then
		slot0:_elementFadeIn()
	end

	slot0:_checkActPointStatus()
end

function slot0._oneElementFadeIn(slot0)
	slot2 = slot0[2]

	if slot0[1]._episodeInfo.isFinish and not slot1._episodeInfo.confirm then
		return
	end

	gohelper.setActive(slot2.viewGO, true)
	slot2:playAnim("appear")
	slot2:setClickEnabled(false)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_open)
end

function slot0._oneElementFadeInFinish(slot0)
	for slot5, slot6 in ipairs(slot0[1]._fadeList) do
		slot6:setClickEnabled(true)
	end

	slot1:_openBattleElement()
end

function slot0._elementFadeIn(slot0)
	slot1 = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(slot0._eventList) do
		if slot6.viewGO.activeSelf then
			gohelper.setActive(slot6.viewGO, false)
			table.insert(slot1, slot6)
		end
	end

	table.sort(slot1, uv0._sort)
	slot0:_stopShowSequence()

	slot0._showSequence = FlowSequence.New()
	slot5 = TimerWork.New

	slot0._showSequence:addWork(slot5(0.5))

	for slot5, slot6 in ipairs(slot1) do
		slot0._showSequence:addWork(FunctionWork.New(uv0._oneElementFadeIn, {
			slot0,
			slot6
		}))

		if slot5 ~= #slot1 then
			slot0._showSequence:addWork(TimerWork.New(0.5))
		end
	end

	slot0._showSequence:addWork(TimerWork.New(0.8))
	slot0._showSequence:addWork(FunctionWork.New(uv0._oneElementFadeInFinish, {
		slot0
	}))

	slot0._fadeList = slot1

	slot0._showSequence:registerDoneListener(slot0._stopShowSequence, slot0)
	slot0._showSequence:start()
end

function slot0._stopShowSequence(slot0)
	if slot0._showSequence then
		slot0._showSequence:destroy()

		slot0._showSequence = nil
	end
end

function slot0._sort(slot0, slot1)
	return slot0._eventId < slot1._eventId
end

function slot0._addElement(slot0, slot1)
	if slot0._eventList[slot1.eventId] then
		slot3:updateInfo(slot1)

		return slot3
	end

	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goeventlist, slot2), MeilanniEventItem)
	slot0._eventList[slot2] = slot3

	slot3:updateInfo(slot1)

	return slot3
end

function slot0._removeElement(slot0, slot1)
	slot0:_removeElementById(slot1.eventId)
end

function slot0._removeElementById(slot0, slot1)
	if not slot0._eventList[slot1] then
		return
	end

	slot0._eventList[slot1] = nil

	slot2:dispose()
end

function slot0._setElementsVisible(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._eventList) do
		if slot7 ~= slot2 then
			if not slot7.viewGO.activeSelf and slot1 then
				gohelper.setActive(slot7.viewGO, true)
				slot7:playAnim("appear")
				slot7:setPhotoVisible(true)
			end

			if slot7:isSelected() then
				slot7:setSelected(false)
			else
				slot7:playAnim(slot1 and "appear" or "disappear")
				slot7:setPhotoVisible(slot1)
			end
		end

		slot7:setClickEnabled(slot1)
	end
end

function slot0._checkActPointStatus(slot0)
	slot2 = slot0._mapInfo:getCurEpisodeInfo().leftActPoint
	slot3 = 0

	for slot8, slot9 in pairs(slot0._eventList) do
		if slot9:isSpecialType() then
			slot4 = 0 + 1
		else
			slot3 = slot3 + 1
		end
	end

	for slot8, slot9 in pairs(slot0._eventList) do
		if not slot9:isSpecialType() then
			slot9:setGray(slot2 - slot4 > 0)
		end
	end
end

function slot0.onClose(slot0)
	slot0:_stopShowSequence()
	TaskDispatcher.cancelTask(slot0._delayShowElements, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
