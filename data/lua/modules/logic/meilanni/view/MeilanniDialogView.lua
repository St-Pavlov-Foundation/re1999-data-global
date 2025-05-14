module("modules.logic.meilanni.view.MeilanniDialogView", package.seeall)

local var_0_0 = class("MeilanniDialogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrolldialog = gohelper.findChildScrollRect(arg_1_0.viewGO, "top_right/#scroll_dialog")
	arg_1_0._goscrollcontainer = gohelper.findChild(arg_1_0.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer/#go_scrollcontent")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._goblockhelp = gohelper.findChild(arg_1_0.viewGO, "top_left_block/#go_block_help")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnresetOnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "top_right/#scroll_dialog/viewport")

	arg_5_0._viewportHeight = recthelper.getHeight(var_5_0.transform)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._dialogItemMap = arg_7_0:getUserDataTb_()
	arg_7_0._dialogItemList = arg_7_0:getUserDataTb_()
	arg_7_0._mapId = MeilanniModel.instance:getCurMapId()
	arg_7_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_7_0._mapId)

	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.clickEventItem, arg_7_0._clickEventItem, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, arg_7_0._episodeInfoUpdate, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.dialogChange, arg_7_0._dialogChange, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetDialogPos, arg_7_0._resetDialogPos, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.dialogClose, arg_7_0._dialogClose, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_7_0._resetMap, arg_7_0)
	arg_7_0:addEventCb(MeilanniAnimationController.instance, MeilanniEvent.dialogListAnimChange, arg_7_0._dialogListAnimChange, arg_7_0)
	arg_7_0:_showAllEpisodeHistory()
end

function var_0_0._dialogListAnimChange(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goblock, arg_8_1)
	gohelper.setActive(arg_8_0._goblockhelp, arg_8_1)
	TaskDispatcher.cancelTask(arg_8_0._hideBlock, arg_8_0)

	if arg_8_1 then
		TaskDispatcher.runDelay(arg_8_0._hideBlock, arg_8_0, 20)
	else
		arg_8_0:_dialogChange()
	end
end

function var_0_0._hideBlock(arg_9_0)
	gohelper.setActive(arg_9_0._goblock, false)
	gohelper.setActive(arg_9_0._goblockhelp, false)
end

function var_0_0._resetMap(arg_10_0)
	arg_10_0._dialogItemMap = arg_10_0:getUserDataTb_()
	arg_10_0._dialogItemList = arg_10_0:getUserDataTb_()
	arg_10_0._episodeInfo = nil

	gohelper.destroyAllChildren(arg_10_0._goscrollcontent)
	recthelper.setHeight(arg_10_0._goscrollcontainer.transform, arg_10_0._viewportHeight)

	arg_10_0._scrolldialog.verticalNormalizedPosition = 1

	arg_10_0:_showAllEpisodeHistory()
end

function var_0_0._dialogClose(arg_11_0)
	arg_11_0:_delayRefreshDialog(0.1)
end

function var_0_0._dialogChange(arg_12_0, arg_12_1)
	arg_12_0:_delayRefreshDialog(0.1)
end

function var_0_0._delayRefreshDialog(arg_13_0, arg_13_1)
	TaskDispatcher.cancelTask(arg_13_0._refreshDialog, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._refreshDialog, arg_13_0, arg_13_1)
end

function var_0_0._resetDialogPos(arg_14_0)
	if arg_14_0._tweenFloatId then
		return
	end

	local var_14_0 = arg_14_0._scrolldialog.verticalNormalizedPosition
	local var_14_1 = 0

	arg_14_0:_tweenScroll(var_14_0, var_14_1, arg_14_0._tweenFrame)
end

function var_0_0._refreshDialog(arg_15_0)
	local var_15_0 = recthelper.getHeight(arg_15_0._goscrollcontent.transform)

	recthelper.setHeight(arg_15_0._goscrollcontainer.transform, var_15_0)
	arg_15_0:_adjustContainerHeight()

	local var_15_1 = recthelper.getHeight(arg_15_0._goscrollcontainer.transform)

	if arg_15_0._prevHeight then
		if MeilanniAnimationController.instance:isPlaying() then
			var_15_1 = math.max(var_15_1, arg_15_0._prevHeight)
		elseif var_15_1 < arg_15_0._prevHeight and arg_15_0._prevHeight - var_15_1 <= 160 then
			var_15_1 = arg_15_0._prevHeight
		end
	end

	recthelper.setHeight(arg_15_0._goscrollcontainer.transform, var_15_1)

	arg_15_0._prevHeight = var_15_1

	arg_15_0:_startTween()
end

function var_0_0._startTween(arg_16_0)
	local var_16_0 = recthelper.getHeight(arg_16_0._goscrollcontent.transform)

	if var_16_0 <= arg_16_0._viewportHeight then
		local var_16_1 = recthelper.getAnchorY(arg_16_0._goscrollcontainer.transform)
		local var_16_2 = math.max(var_16_0 - arg_16_0._viewportHeight, 0)

		arg_16_0:_tweenScroll(var_16_1, var_16_2, arg_16_0._tweenFrameAnchorY)
	else
		local var_16_3 = arg_16_0._scrolldialog.verticalNormalizedPosition
		local var_16_4 = 0

		arg_16_0:_tweenScroll(var_16_3, var_16_4, arg_16_0._tweenFrame)
	end
end

function var_0_0._tweenScroll(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0._firstTween then
		arg_17_0._firstTween = true

		arg_17_0:_tweenFinish()

		return
	end

	if arg_17_1 == arg_17_2 then
		return
	end

	if arg_17_0._tweenFloatId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenFloatId)
	end

	arg_17_0._tweenFloatId = ZProj.TweenHelper.DOTweenFloat(arg_17_1, arg_17_2, 0.8, arg_17_3, arg_17_0._tweenFinish, arg_17_0, nil, EaseType.OutQuint)
end

function var_0_0._tweenFrameAnchorY(arg_18_0, arg_18_1)
	recthelper.setAnchorY(arg_18_0._goscrollcontainer.transform, arg_18_1)
end

function var_0_0._tweenFrame(arg_19_0, arg_19_1)
	arg_19_0._scrolldialog.verticalNormalizedPosition = arg_19_1
end

function var_0_0._tweenFinish(arg_20_0)
	arg_20_0._scrolldialog.verticalNormalizedPosition = 0
	arg_20_0._tweenFloatId = nil
end

function var_0_0._adjustContainerHeight(arg_21_0)
	local var_21_0

	for iter_21_0 = #arg_21_0._dialogItemList, 1, -1 do
		local var_21_1 = arg_21_0._dialogItemList[iter_21_0]

		if gohelper.isNil(var_21_1.viewGO) or not var_21_1:getEpisodeInfo() then
			table.remove(arg_21_0._dialogItemList, iter_21_0)
		elseif var_21_1:isTopDialog() then
			var_21_0 = var_21_1

			break
		end
	end

	if var_21_0 then
		local var_21_2 = var_21_0.viewGO.transform
		local var_21_3 = recthelper.getAnchorY(var_21_2)
		local var_21_4 = math.abs(var_21_3) + arg_21_0._viewportHeight
		local var_21_5 = recthelper.getHeight(arg_21_0._goscrollcontainer.transform)
		local var_21_6 = math.max(var_21_4, var_21_5)

		recthelper.setHeight(arg_21_0._goscrollcontainer.transform, var_21_6)
	end
end

function var_0_0._episodeInfoUpdate(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._mapInfo:getCurEpisodeInfo()

	if arg_22_0._episodeInfo then
		if arg_22_1 then
			MeilanniAnimationController.instance:addDelayCall(arg_22_0._showEventHistoryDelay, arg_22_0, {
				arg_22_0._mapInfo:getEpisodeInfo(arg_22_0._episodeInfo.episodeId),
				arg_22_1
			}, MeilanniEnum.selectedTime, MeilanniAnimationController.historyLayer)
		end

		if arg_22_0._episodeInfo.isFinish and arg_22_0._episodeInfo.confirm then
			if arg_22_0:_checkShowEpisodeSkipDialogs(arg_22_0._episodeInfo) then
				MeilanniAnimationController.instance:addDelayCall(arg_22_0._delayCallShowEpisodeSkipDialogs, arg_22_0, arg_22_0._episodeInfo, MeilanniEnum.skipTime, MeilanniAnimationController.epilogueLayer)
			end

			if arg_22_0:_checkShowEpilogue(arg_22_0._episodeInfo) then
				MeilanniAnimationController.instance:addDelayCall(arg_22_0._showEpilogue, arg_22_0, arg_22_0._episodeInfo, MeilanniEnum.epilogueTime, MeilanniAnimationController.epilogueLayer)
			end
		end
	end

	if arg_22_0:_checkShowPreface(var_22_0) then
		MeilanniAnimationController.instance:addDelayCall(arg_22_0._showPreface, arg_22_0, var_22_0, MeilanniEnum.prefaceTime, MeilanniAnimationController.prefaceLayer)
	end

	if arg_22_0:_showConfirm(var_22_0) then
		MeilanniAnimationController.instance:addDelayCall(arg_22_0._delayCallCheckConfirm, arg_22_0, var_22_0, MeilanniEnum.confirmTime, MeilanniAnimationController.prefaceLayer)
	end

	MeilanniAnimationController.instance:addDelayCall(arg_22_0._dispatchGuideDayEvent, arg_22_0, nil, 0, MeilanniAnimationController.prefaceLayer)
	MeilanniAnimationController.instance:endAnimation(MeilanniAnimationController.endLayer)
end

function var_0_0._delayCallCheckConfirm(arg_23_0, arg_23_1)
	arg_23_0:_showEndDialog(arg_23_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
end

function var_0_0._checkConfirm(arg_24_0, arg_24_1)
	if arg_24_0:_showConfirm(arg_24_1) then
		arg_24_0:_showEndDialog(arg_24_1)
	end
end

function var_0_0._showConfirm(arg_25_0, arg_25_1)
	if arg_25_1 and arg_25_1.isFinish and not arg_25_1.confirm then
		return true
	end

	local var_25_0 = MeilanniModel.instance:getMapInfo(arg_25_0._mapId)

	if not arg_25_1.isFinish and not arg_25_1.confirm and var_25_0.score <= 0 then
		return true
	end
end

function var_0_0._dispatchGuideDayEvent(arg_26_0)
	local var_26_0 = arg_26_0._mapInfo:getCurEpisodeInfo()

	if not var_26_0 then
		return
	end

	if var_26_0.episodeId == 10101 then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.guideEnterMapDay1)
	elseif var_26_0.episodeId == 10102 then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.guideEnterMapDay2)
	end
end

function var_0_0._clickEventItem(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1._info
	local var_27_1 = var_27_0.eventId
	local var_27_2 = var_27_0:getType()

	if var_27_2 == MeilanniEnum.ElementType.Battle then
		MeilanniController.instance:startBattle(var_27_1)
	elseif var_27_2 == MeilanniEnum.ElementType.Dialog then
		local var_27_3 = arg_27_0._mapInfo:getCurEpisodeInfo()

		if var_27_3.leftActPoint - var_27_3.specialEventNum <= 0 and var_27_0.config.type == 0 then
			GameFacade.showToast(ToastEnum.MeilanniDialog)

			return
		end

		arg_27_1:setSelected(true)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, false, arg_27_1)
		arg_27_0:_playDialog(arg_27_1)
	end
end

function var_0_0._playDialog(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._mapInfo:getCurEpisodeInfo()
	local var_28_1 = arg_28_0:_getCacheDialogItem(var_28_0, arg_28_1._eventId)

	var_28_1:playDialog(arg_28_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)

	var_28_1.viewGO.name = string.format("meilannidialogitem_%s_%s", var_28_0.episodeId, arg_28_1._eventId)
end

function var_0_0._getCacheDialogItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._dialogItemMap[arg_29_2]

	if var_29_0 and gohelper.isNil(var_29_0.viewGO) then
		var_29_0 = nil
	end

	var_29_0 = var_29_0 or arg_29_0:_getDialogItem(arg_29_1)
	arg_29_0._dialogItemMap[arg_29_2] = var_29_0

	return var_29_0
end

function var_0_0._showEmeny(arg_30_0, arg_30_1)
	if arg_30_0._episodeInfo and arg_30_1.episodeId == arg_30_0._episodeInfo.episodeId then
		return
	end

	local var_30_0 = arg_30_0._episodeInfo

	if arg_30_1.episodeConfig.showBoss == 1 and var_30_0 and var_30_0.episodeConfig.showBoss ~= 1 then
		TaskDispatcher.cancelTask(arg_30_0._showBossInfoView, arg_30_0)
		TaskDispatcher.runDelay(arg_30_0._showBossInfoView, arg_30_0, 0.8)
	end
end

function var_0_0._showBossInfoView(arg_31_0)
	MeilanniController.instance:openMeilanniBossInfoView({
		mapId = arg_31_0._mapId
	})
end

function var_0_0._showPreface(arg_32_0, arg_32_1)
	if arg_32_0._episodeInfo and arg_32_1.episodeId == arg_32_0._episodeInfo.episodeId then
		return
	end

	arg_32_0._episodeInfo = arg_32_1

	local var_32_0 = arg_32_1.episodeConfig

	if string.nilorempty(var_32_0.preface) then
		return
	end

	local var_32_1 = arg_32_0:_getDialogItem(arg_32_1)

	var_32_1:playDesc(var_32_0.preface)

	var_32_1.viewGO.name = string.format("meilannidialogitem_%s_preface", arg_32_1.episodeId)
end

function var_0_0._checkShowPreface(arg_33_0, arg_33_1)
	if arg_33_0._episodeInfo and arg_33_1.episodeId == arg_33_0._episodeInfo.episodeId then
		return
	end

	local var_33_0 = arg_33_1.episodeConfig

	if string.nilorempty(var_33_0.preface) then
		return
	end

	return true
end

function var_0_0._showEpilogue(arg_34_0, arg_34_1)
	if not arg_34_0:_checkShowEpilogue(arg_34_1) then
		return
	end

	local var_34_0 = arg_34_1.episodeConfig

	arg_34_0:_getDialogItem(arg_34_1):showEpilogue(var_34_0.epilogue)
end

function var_0_0._checkShowEpilogue(arg_35_0, arg_35_1)
	if not arg_35_1 then
		return
	end

	local var_35_0 = arg_35_1.episodeConfig

	if string.nilorempty(var_35_0.epilogue) then
		return
	end

	return true
end

function var_0_0._showDialogHistory(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	arg_36_0:_getCacheDialogItem(arg_36_1, arg_36_2.eventId):showHistory(arg_36_2, arg_36_3, arg_36_4)
end

function var_0_0._showSkipDialog(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0:_getDialogItem(arg_37_1):showSkipDialog(arg_37_2, arg_37_3, arg_37_4)
end

function var_0_0._showEndDialog(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	arg_38_0:_getDialogItem(arg_38_1):showEndDialog(arg_38_2)
end

function var_0_0._getDialogItem(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.viewContainer:getSetting().otherRes[2]
	local var_39_1 = arg_39_0:getResInst(var_39_0, arg_39_0._goscrollcontent)
	local var_39_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_39_1, MeilanniDialogItem)

	var_39_2:setEpisodeInfo(arg_39_1)
	table.insert(arg_39_0._dialogItemList, var_39_2)

	return var_39_2
end

function var_0_0._showAllEpisodeHistory(arg_40_0)
	local var_40_0 = #arg_40_0._mapInfo.episodeInfos

	MeilanniModel.instance:setDialogItemFadeIndex(-1)

	for iter_40_0, iter_40_1 in ipairs(arg_40_0._mapInfo.episodeInfos) do
		if iter_40_0 == var_40_0 then
			MeilanniModel.instance:setDialogItemFadeIndex(0)
			arg_40_0:_showEpisodeHistory(iter_40_1)
			arg_40_0:_checkConfirm(iter_40_1)
		else
			arg_40_0:_showEpisodeHistory(iter_40_1)
		end
	end

	MeilanniModel.instance:setDialogItemFadeIndex(nil)
	arg_40_0:_dispatchGuideDayEvent()
end

function var_0_0._showEpisodeHistory(arg_41_0, arg_41_1)
	arg_41_0:_showPreface(arg_41_1)

	local var_41_0
	local var_41_1 = 1

	for iter_41_0, iter_41_1 in ipairs(arg_41_1.historylist) do
		local var_41_2 = iter_41_1.eventId
		local var_41_3 = iter_41_1.index
		local var_41_4 = arg_41_1:getEventInfo(var_41_2)

		if var_41_4.interactParam[var_41_3 + 1][1] == MeilanniEnum.ElementType.Dialog then
			arg_41_0:_showDialogHistory(arg_41_1, var_41_4, var_41_3, var_41_1)

			if var_41_0 ~= var_41_2 then
				var_41_0 = var_41_2
				var_41_1 = var_41_1 + 1
			end
		end
	end

	if arg_41_1.isFinish and arg_41_1.confirm then
		arg_41_0:_showEpisodeSkipDialogs(arg_41_1)
		arg_41_0:_showEpilogue(arg_41_1)
	end
end

function var_0_0._showEventHistoryDelay(arg_42_0, arg_42_1)
	arg_42_0:_showEventHistory(arg_42_1[1], arg_42_1[2])
end

function var_0_0._showEventHistory(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_2 then
		return
	end

	local var_43_0 = arg_43_0._dialogItemMap[arg_43_2]

	if var_43_0 then
		var_43_0:clearConfig()
	end

	for iter_43_0, iter_43_1 in ipairs(arg_43_1.historylist) do
		local var_43_1 = iter_43_1.eventId

		if var_43_1 == arg_43_2 then
			local var_43_2 = iter_43_1.index
			local var_43_3 = arg_43_1:getEventInfo(var_43_1)

			if var_43_3.interactParam[var_43_2 + 1][1] == MeilanniEnum.ElementType.Dialog then
				arg_43_0:_showDialogHistory(arg_43_1, var_43_3, var_43_2)
			end
		end
	end
end

function var_0_0._delayCallShowEpisodeSkipDialogs(arg_44_0, arg_44_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
	arg_44_0:_showEpisodeSkipDialogs(arg_44_1)
	arg_44_0:_delayRefreshDialog(0)
end

function var_0_0._showEpisodeSkipDialogs(arg_45_0, arg_45_1)
	if not arg_45_1.isFinish then
		return
	end

	local var_45_0 = arg_45_1.historyLen + 1

	for iter_45_0, iter_45_1 in ipairs(arg_45_1.events) do
		if not iter_45_1.isFinish and iter_45_1:getSkipDialog() then
			arg_45_0:_showSkipDialog(arg_45_1, iter_45_1, nil, var_45_0)

			var_45_0 = var_45_0 + 1
		end
	end
end

function var_0_0._checkShowEpisodeSkipDialogs(arg_46_0, arg_46_1)
	if not arg_46_1.isFinish then
		return
	end

	local var_46_0 = arg_46_1.historyLen + 1

	for iter_46_0, iter_46_1 in ipairs(arg_46_1.events) do
		if not iter_46_1.isFinish and iter_46_1:getSkipDialog() then
			return true
		end
	end
end

function var_0_0.onClose(arg_47_0)
	arg_47_0:removeEventCb(MeilanniController.instance, MeilanniEvent.clickEventItem, arg_47_0._clickEventItem, arg_47_0)
	arg_47_0:removeEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, arg_47_0._episodeInfoUpdate, arg_47_0)
	arg_47_0:removeEventCb(MeilanniController.instance, MeilanniEvent.dialogChange, arg_47_0._dialogChange, arg_47_0)
	arg_47_0:removeEventCb(MeilanniController.instance, MeilanniEvent.resetDialogPos, arg_47_0._resetDialogPos, arg_47_0)
	arg_47_0:removeEventCb(MeilanniController.instance, MeilanniEvent.dialogClose, arg_47_0._dialogClose, arg_47_0)
	arg_47_0:removeEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_47_0._resetMap, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._refreshDialog, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._showBossInfoView, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._hideBlock, arg_47_0)

	if arg_47_0._tweenFloatId then
		ZProj.TweenHelper.KillById(arg_47_0._tweenFloatId)
	end

	MeilanniAnimationController.instance:close()
end

function var_0_0.onDestroyView(arg_48_0)
	return
end

return var_0_0
