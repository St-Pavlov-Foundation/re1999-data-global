module("modules.logic.meilanni.view.MeilanniDialogView", package.seeall)

slot0 = class("MeilanniDialogView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrolldialog = gohelper.findChildScrollRect(slot0.viewGO, "top_right/#scroll_dialog")
	slot0._goscrollcontainer = gohelper.findChild(slot0.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer/#go_scrollcontent")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")
	slot0._goblockhelp = gohelper.findChild(slot0.viewGO, "top_left_block/#go_block_help")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnresetOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewportHeight = recthelper.getHeight(gohelper.findChild(slot0.viewGO, "top_right/#scroll_dialog/viewport").transform)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._dialogItemMap = slot0:getUserDataTb_()
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._mapId = MeilanniModel.instance:getCurMapId()
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)

	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.clickEventItem, slot0._clickEventItem, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, slot0._episodeInfoUpdate, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.dialogChange, slot0._dialogChange, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetDialogPos, slot0._resetDialogPos, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.dialogClose, slot0._dialogClose, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
	slot0:addEventCb(MeilanniAnimationController.instance, MeilanniEvent.dialogListAnimChange, slot0._dialogListAnimChange, slot0)
	slot0:_showAllEpisodeHistory()
end

function slot0._dialogListAnimChange(slot0, slot1)
	gohelper.setActive(slot0._goblock, slot1)
	gohelper.setActive(slot0._goblockhelp, slot1)
	TaskDispatcher.cancelTask(slot0._hideBlock, slot0)

	if slot1 then
		TaskDispatcher.runDelay(slot0._hideBlock, slot0, 20)
	else
		slot0:_dialogChange()
	end
end

function slot0._hideBlock(slot0)
	gohelper.setActive(slot0._goblock, false)
	gohelper.setActive(slot0._goblockhelp, false)
end

function slot0._resetMap(slot0)
	slot0._dialogItemMap = slot0:getUserDataTb_()
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._episodeInfo = nil

	gohelper.destroyAllChildren(slot0._goscrollcontent)
	recthelper.setHeight(slot0._goscrollcontainer.transform, slot0._viewportHeight)

	slot0._scrolldialog.verticalNormalizedPosition = 1

	slot0:_showAllEpisodeHistory()
end

function slot0._dialogClose(slot0)
	slot0:_delayRefreshDialog(0.1)
end

function slot0._dialogChange(slot0, slot1)
	slot0:_delayRefreshDialog(0.1)
end

function slot0._delayRefreshDialog(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._refreshDialog, slot0)
	TaskDispatcher.runDelay(slot0._refreshDialog, slot0, slot1)
end

function slot0._resetDialogPos(slot0)
	if slot0._tweenFloatId then
		return
	end

	slot0:_tweenScroll(slot0._scrolldialog.verticalNormalizedPosition, 0, slot0._tweenFrame)
end

function slot0._refreshDialog(slot0)
	recthelper.setHeight(slot0._goscrollcontainer.transform, recthelper.getHeight(slot0._goscrollcontent.transform))
	slot0:_adjustContainerHeight()

	if slot0._prevHeight then
		if MeilanniAnimationController.instance:isPlaying() then
			slot2 = math.max(recthelper.getHeight(slot0._goscrollcontainer.transform), slot0._prevHeight)
		elseif slot2 < slot0._prevHeight and slot0._prevHeight - slot2 <= 160 then
			slot2 = slot0._prevHeight
		end
	end

	recthelper.setHeight(slot0._goscrollcontainer.transform, slot2)

	slot0._prevHeight = slot2

	slot0:_startTween()
end

function slot0._startTween(slot0)
	if recthelper.getHeight(slot0._goscrollcontent.transform) <= slot0._viewportHeight then
		slot0:_tweenScroll(recthelper.getAnchorY(slot0._goscrollcontainer.transform), math.max(slot1 - slot0._viewportHeight, 0), slot0._tweenFrameAnchorY)
	else
		slot0:_tweenScroll(slot0._scrolldialog.verticalNormalizedPosition, 0, slot0._tweenFrame)
	end
end

function slot0._tweenScroll(slot0, slot1, slot2, slot3)
	if not slot0._firstTween then
		slot0._firstTween = true

		slot0:_tweenFinish()

		return
	end

	if slot1 == slot2 then
		return
	end

	if slot0._tweenFloatId then
		ZProj.TweenHelper.KillById(slot0._tweenFloatId)
	end

	slot0._tweenFloatId = ZProj.TweenHelper.DOTweenFloat(slot1, slot2, 0.8, slot3, slot0._tweenFinish, slot0, nil, EaseType.OutQuint)
end

function slot0._tweenFrameAnchorY(slot0, slot1)
	recthelper.setAnchorY(slot0._goscrollcontainer.transform, slot1)
end

function slot0._tweenFrame(slot0, slot1)
	slot0._scrolldialog.verticalNormalizedPosition = slot1
end

function slot0._tweenFinish(slot0)
	slot0._scrolldialog.verticalNormalizedPosition = 0
	slot0._tweenFloatId = nil
end

function slot0._adjustContainerHeight(slot0)
	slot1 = nil

	for slot5 = #slot0._dialogItemList, 1, -1 do
		if gohelper.isNil(slot0._dialogItemList[slot5].viewGO) or not slot6:getEpisodeInfo() then
			table.remove(slot0._dialogItemList, slot5)
		elseif slot6:isTopDialog() then
			slot1 = slot6

			break
		end
	end

	if slot1 then
		recthelper.setHeight(slot0._goscrollcontainer.transform, math.max(math.abs(recthelper.getAnchorY(slot1.viewGO.transform)) + slot0._viewportHeight, recthelper.getHeight(slot0._goscrollcontainer.transform)))
	end
end

function slot0._episodeInfoUpdate(slot0, slot1)
	slot2 = slot0._mapInfo:getCurEpisodeInfo()

	if slot0._episodeInfo then
		if slot1 then
			MeilanniAnimationController.instance:addDelayCall(slot0._showEventHistoryDelay, slot0, {
				slot0._mapInfo:getEpisodeInfo(slot0._episodeInfo.episodeId),
				slot1
			}, MeilanniEnum.selectedTime, MeilanniAnimationController.historyLayer)
		end

		if slot0._episodeInfo.isFinish and slot0._episodeInfo.confirm then
			if slot0:_checkShowEpisodeSkipDialogs(slot0._episodeInfo) then
				MeilanniAnimationController.instance:addDelayCall(slot0._delayCallShowEpisodeSkipDialogs, slot0, slot0._episodeInfo, MeilanniEnum.skipTime, MeilanniAnimationController.epilogueLayer)
			end

			if slot0:_checkShowEpilogue(slot0._episodeInfo) then
				MeilanniAnimationController.instance:addDelayCall(slot0._showEpilogue, slot0, slot0._episodeInfo, MeilanniEnum.epilogueTime, MeilanniAnimationController.epilogueLayer)
			end
		end
	end

	if slot0:_checkShowPreface(slot2) then
		MeilanniAnimationController.instance:addDelayCall(slot0._showPreface, slot0, slot2, MeilanniEnum.prefaceTime, MeilanniAnimationController.prefaceLayer)
	end

	if slot0:_showConfirm(slot2) then
		MeilanniAnimationController.instance:addDelayCall(slot0._delayCallCheckConfirm, slot0, slot2, MeilanniEnum.confirmTime, MeilanniAnimationController.prefaceLayer)
	end

	MeilanniAnimationController.instance:addDelayCall(slot0._dispatchGuideDayEvent, slot0, nil, 0, MeilanniAnimationController.prefaceLayer)
	MeilanniAnimationController.instance:endAnimation(MeilanniAnimationController.endLayer)
end

function slot0._delayCallCheckConfirm(slot0, slot1)
	slot0:_showEndDialog(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
end

function slot0._checkConfirm(slot0, slot1)
	if slot0:_showConfirm(slot1) then
		slot0:_showEndDialog(slot1)
	end
end

function slot0._showConfirm(slot0, slot1)
	if slot1 and slot1.isFinish and not slot1.confirm then
		return true
	end

	if not slot1.isFinish and not slot1.confirm and MeilanniModel.instance:getMapInfo(slot0._mapId).score <= 0 then
		return true
	end
end

function slot0._dispatchGuideDayEvent(slot0)
	if not slot0._mapInfo:getCurEpisodeInfo() then
		return
	end

	if slot1.episodeId == 10101 then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.guideEnterMapDay1)
	elseif slot1.episodeId == 10102 then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.guideEnterMapDay2)
	end
end

function slot0._clickEventItem(slot0, slot1)
	slot2 = slot1._info

	if slot2:getType() == MeilanniEnum.ElementType.Battle then
		MeilanniController.instance:startBattle(slot2.eventId)
	elseif slot4 == MeilanniEnum.ElementType.Dialog then
		slot5 = slot0._mapInfo:getCurEpisodeInfo()

		if slot5.leftActPoint - slot5.specialEventNum <= 0 and slot2.config.type == 0 then
			GameFacade.showToast(ToastEnum.MeilanniDialog)

			return
		end

		slot1:setSelected(true)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, false, slot1)
		slot0:_playDialog(slot1)
	end
end

function slot0._playDialog(slot0, slot1)
	slot2 = slot0._mapInfo:getCurEpisodeInfo()
	slot3 = slot0:_getCacheDialogItem(slot2, slot1._eventId)

	slot3:playDialog(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)

	slot3.viewGO.name = string.format("meilannidialogitem_%s_%s", slot2.episodeId, slot1._eventId)
end

function slot0._getCacheDialogItem(slot0, slot1, slot2)
	if slot0._dialogItemMap[slot2] and gohelper.isNil(slot3.viewGO) then
		slot3 = nil
	end

	slot3 = slot3 or slot0:_getDialogItem(slot1)
	slot0._dialogItemMap[slot2] = slot3

	return slot3
end

function slot0._showEmeny(slot0, slot1)
	if slot0._episodeInfo and slot1.episodeId == slot0._episodeInfo.episodeId then
		return
	end

	slot2 = slot0._episodeInfo

	if slot1.episodeConfig.showBoss == 1 and slot2 and slot2.episodeConfig.showBoss ~= 1 then
		TaskDispatcher.cancelTask(slot0._showBossInfoView, slot0)
		TaskDispatcher.runDelay(slot0._showBossInfoView, slot0, 0.8)
	end
end

function slot0._showBossInfoView(slot0)
	MeilanniController.instance:openMeilanniBossInfoView({
		mapId = slot0._mapId
	})
end

function slot0._showPreface(slot0, slot1)
	if slot0._episodeInfo and slot1.episodeId == slot0._episodeInfo.episodeId then
		return
	end

	slot0._episodeInfo = slot1

	if string.nilorempty(slot1.episodeConfig.preface) then
		return
	end

	slot3 = slot0:_getDialogItem(slot1)

	slot3:playDesc(slot2.preface)

	slot3.viewGO.name = string.format("meilannidialogitem_%s_preface", slot1.episodeId)
end

function slot0._checkShowPreface(slot0, slot1)
	if slot0._episodeInfo and slot1.episodeId == slot0._episodeInfo.episodeId then
		return
	end

	if string.nilorempty(slot1.episodeConfig.preface) then
		return
	end

	return true
end

function slot0._showEpilogue(slot0, slot1)
	if not slot0:_checkShowEpilogue(slot1) then
		return
	end

	slot0:_getDialogItem(slot1):showEpilogue(slot1.episodeConfig.epilogue)
end

function slot0._checkShowEpilogue(slot0, slot1)
	if not slot1 then
		return
	end

	if string.nilorempty(slot1.episodeConfig.epilogue) then
		return
	end

	return true
end

function slot0._showDialogHistory(slot0, slot1, slot2, slot3, slot4)
	slot0:_getCacheDialogItem(slot1, slot2.eventId):showHistory(slot2, slot3, slot4)
end

function slot0._showSkipDialog(slot0, slot1, slot2, slot3, slot4)
	slot0:_getDialogItem(slot1):showSkipDialog(slot2, slot3, slot4)
end

function slot0._showEndDialog(slot0, slot1, slot2, slot3, slot4)
	slot0:_getDialogItem(slot1):showEndDialog(slot2)
end

function slot0._getDialogItem(slot0, slot1)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goscrollcontent), MeilanniDialogItem)

	slot4:setEpisodeInfo(slot1)
	table.insert(slot0._dialogItemList, slot4)

	return slot4
end

function slot0._showAllEpisodeHistory(slot0)
	slot5 = -1

	MeilanniModel.instance:setDialogItemFadeIndex(slot5)

	for slot5, slot6 in ipairs(slot0._mapInfo.episodeInfos) do
		if slot5 == #slot0._mapInfo.episodeInfos then
			MeilanniModel.instance:setDialogItemFadeIndex(0)
			slot0:_showEpisodeHistory(slot6)
			slot0:_checkConfirm(slot6)
		else
			slot0:_showEpisodeHistory(slot6)
		end
	end

	MeilanniModel.instance:setDialogItemFadeIndex(nil)
	slot0:_dispatchGuideDayEvent()
end

function slot0._showEpisodeHistory(slot0, slot1)
	slot0:_showPreface(slot1)

	slot3 = 1

	for slot7, slot8 in ipairs(slot1.historylist) do
		if slot1:getEventInfo(slot8.eventId).interactParam[slot8.index + 1][1] == MeilanniEnum.ElementType.Dialog then
			slot0:_showDialogHistory(slot1, slot11, slot10, slot3)

			if nil ~= slot9 then
				slot2 = slot9
				slot3 = slot3 + 1
			end
		end
	end

	if slot1.isFinish and slot1.confirm then
		slot0:_showEpisodeSkipDialogs(slot1)
		slot0:_showEpilogue(slot1)
	end
end

function slot0._showEventHistoryDelay(slot0, slot1)
	slot0:_showEventHistory(slot1[1], slot1[2])
end

function slot0._showEventHistory(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if slot0._dialogItemMap[slot2] then
		slot3:clearConfig()
	end

	for slot7, slot8 in ipairs(slot1.historylist) do
		if slot8.eventId == slot2 and slot1:getEventInfo(slot9).interactParam[slot8.index + 1][1] == MeilanniEnum.ElementType.Dialog then
			slot0:_showDialogHistory(slot1, slot11, slot10)
		end
	end
end

function slot0._delayCallShowEpisodeSkipDialogs(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
	slot0:_showEpisodeSkipDialogs(slot1)
	slot0:_delayRefreshDialog(0)
end

function slot0._showEpisodeSkipDialogs(slot0, slot1)
	if not slot1.isFinish then
		return
	end

	slot2 = slot1.historyLen + 1

	for slot6, slot7 in ipairs(slot1.events) do
		if not slot7.isFinish and slot7:getSkipDialog() then
			slot0:_showSkipDialog(slot1, slot7, nil, slot2)

			slot2 = slot2 + 1
		end
	end
end

function slot0._checkShowEpisodeSkipDialogs(slot0, slot1)
	if not slot1.isFinish then
		return
	end

	slot2 = slot1.historyLen + 1

	for slot6, slot7 in ipairs(slot1.events) do
		if not slot7.isFinish and slot7:getSkipDialog() then
			return true
		end
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(MeilanniController.instance, MeilanniEvent.clickEventItem, slot0._clickEventItem, slot0)
	slot0:removeEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, slot0._episodeInfoUpdate, slot0)
	slot0:removeEventCb(MeilanniController.instance, MeilanniEvent.dialogChange, slot0._dialogChange, slot0)
	slot0:removeEventCb(MeilanniController.instance, MeilanniEvent.resetDialogPos, slot0._resetDialogPos, slot0)
	slot0:removeEventCb(MeilanniController.instance, MeilanniEvent.dialogClose, slot0._dialogClose, slot0)
	slot0:removeEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
	TaskDispatcher.cancelTask(slot0._refreshDialog, slot0)
	TaskDispatcher.cancelTask(slot0._showBossInfoView, slot0)
	TaskDispatcher.cancelTask(slot0._hideBlock, slot0)

	if slot0._tweenFloatId then
		ZProj.TweenHelper.KillById(slot0._tweenFloatId)
	end

	MeilanniAnimationController.instance:close()
end

function slot0.onDestroyView(slot0)
end

return slot0
