module("modules.logic.meilanni.view.MeilanniEventView", package.seeall)

local var_0_0 = class("MeilanniEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goeventlist = gohelper.findChild(arg_1_0.viewGO, "#go_eventlist")

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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._episodeInfoUpdate(arg_6_0)
	if arg_6_0._mapInfo:getCurEpisodeInfo() ~= arg_6_0._episodeInfo then
		MeilanniAnimationController.instance:addDelayCall(arg_6_0._updateElements, arg_6_0, nil, MeilanniEnum.showElementTime, MeilanniAnimationController.showElementsLayer)
	else
		arg_6_0:_updateElements()
	end
end

function var_0_0._updateElements(arg_7_0)
	local var_7_0 = arg_7_0._mapInfo:getCurEpisodeInfo()
	local var_7_1 = var_7_0 ~= arg_7_0._episodeInfo

	if var_7_0.isFinish then
		arg_7_0:_removeAllElements()

		return
	end

	if var_7_1 then
		arg_7_0:_removeAllElements()
	end

	if not var_7_1 then
		arg_7_0:_showElements(false)

		return
	end

	TaskDispatcher.cancelTask(arg_7_0._delayShowElements, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._delayShowElements, arg_7_0, 0.5)
end

function var_0_0._delayShowElements(arg_8_0)
	arg_8_0:_showElements(true)
end

function var_0_0._resetMap(arg_9_0)
	arg_9_0:_updateElements()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, arg_10_0._episodeInfoUpdate, arg_10_0)
	arg_10_0:addEventCb(MeilanniController.instance, MeilanniEvent.setElementsVisible, arg_10_0._setElementsVisible, arg_10_0)
	arg_10_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_10_0._resetMap, arg_10_0)
	arg_10_0:addEventCb(MeilanniController.instance, MeilanniEvent.getInfo, arg_10_0._getInfo, arg_10_0)

	arg_10_0._mapId = arg_10_0.viewParam.mapId
	arg_10_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_10_0._mapId)
	arg_10_0._eventList = arg_10_0:getUserDataTb_()

	arg_10_0:_showElements(true)
end

function var_0_0._getInfo(arg_11_0)
	if arg_11_0._mapInfo.isFinish then
		arg_11_0:_removeAllElements()
	end
end

function var_0_0.mapIsFinish(arg_12_0)
	if arg_12_0._mapInfo.isFinish or arg_12_0._mapInfo.score <= 0 then
		return true
	end
end

function var_0_0.onOpenFinish(arg_13_0)
	return
end

function var_0_0._openBattleElement(arg_14_0)
	local var_14_0 = MeilanniModel.instance:getBattleElementId()

	if not var_14_0 then
		return
	end

	MeilanniModel.instance:setBattleElementId(nil)

	local var_14_1 = arg_14_0._eventList[var_14_0]

	if not var_14_1 then
		return
	end

	local var_14_2 = var_14_1._info
	local var_14_3 = var_14_2.eventId

	if var_14_2:getType() == MeilanniEnum.ElementType.Battle then
		return
	end

	var_14_1:_onClick()
end

function var_0_0._removeAllElements(arg_15_0)
	if not arg_15_0._episodeInfo then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._episodeInfo.events) do
		arg_15_0:_removeElement(iter_15_1)
	end
end

function var_0_0._showElements(arg_16_0, arg_16_1)
	if arg_16_0:mapIsFinish() then
		return
	end

	local var_16_0

	arg_16_0._episodeInfo = arg_16_0._mapInfo:getCurEpisodeInfo()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._episodeInfo.events) do
		if iter_16_1.isFinish then
			arg_16_0:_removeElement(iter_16_1)
		else
			local var_16_1 = arg_16_0:_addElement(iter_16_1)

			if iter_16_1.index > 0 then
				var_16_0 = var_16_1
			end
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0._eventList) do
		if not arg_16_0._episodeInfo:getEventInfo(iter_16_2) then
			arg_16_0:_removeElementById(iter_16_2)
		end
	end

	if var_16_0 then
		for iter_16_4, iter_16_5 in pairs(arg_16_0._eventList) do
			if iter_16_5 ~= var_16_0 then
				gohelper.setActive(iter_16_5.viewGO, false)
			end
		end
	end

	if arg_16_1 then
		arg_16_0:_elementFadeIn()
	end

	arg_16_0:_checkActPointStatus()
end

function var_0_0._oneElementFadeIn(arg_17_0)
	local var_17_0 = arg_17_0[1]
	local var_17_1 = arg_17_0[2]

	if var_17_0._episodeInfo.isFinish and not var_17_0._episodeInfo.confirm then
		return
	end

	gohelper.setActive(var_17_1.viewGO, true)
	var_17_1:playAnim("appear")
	var_17_1:setClickEnabled(false)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_open)
end

function var_0_0._oneElementFadeInFinish(arg_18_0)
	local var_18_0 = arg_18_0[1]

	for iter_18_0, iter_18_1 in ipairs(var_18_0._fadeList) do
		iter_18_1:setClickEnabled(true)
	end

	var_18_0:_openBattleElement()
end

function var_0_0._elementFadeIn(arg_19_0)
	local var_19_0 = arg_19_0:getUserDataTb_()

	for iter_19_0, iter_19_1 in pairs(arg_19_0._eventList) do
		if iter_19_1.viewGO.activeSelf then
			gohelper.setActive(iter_19_1.viewGO, false)
			table.insert(var_19_0, iter_19_1)
		end
	end

	table.sort(var_19_0, var_0_0._sort)
	arg_19_0:_stopShowSequence()

	arg_19_0._showSequence = FlowSequence.New()

	arg_19_0._showSequence:addWork(TimerWork.New(0.5))

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		arg_19_0._showSequence:addWork(FunctionWork.New(var_0_0._oneElementFadeIn, {
			arg_19_0,
			iter_19_3
		}))

		if iter_19_2 ~= #var_19_0 then
			arg_19_0._showSequence:addWork(TimerWork.New(0.5))
		end
	end

	arg_19_0._showSequence:addWork(TimerWork.New(0.8))
	arg_19_0._showSequence:addWork(FunctionWork.New(var_0_0._oneElementFadeInFinish, {
		arg_19_0
	}))

	arg_19_0._fadeList = var_19_0

	arg_19_0._showSequence:registerDoneListener(arg_19_0._stopShowSequence, arg_19_0)
	arg_19_0._showSequence:start()
end

function var_0_0._stopShowSequence(arg_20_0)
	if arg_20_0._showSequence then
		arg_20_0._showSequence:destroy()

		arg_20_0._showSequence = nil
	end
end

function var_0_0._sort(arg_21_0, arg_21_1)
	return arg_21_0._eventId < arg_21_1._eventId
end

function var_0_0._addElement(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.eventId
	local var_22_1 = arg_22_0._eventList[var_22_0]

	if var_22_1 then
		var_22_1:updateInfo(arg_22_1)

		return var_22_1
	end

	local var_22_2 = arg_22_0.viewContainer:getSetting().otherRes[1]
	local var_22_3 = arg_22_0:getResInst(var_22_2, arg_22_0._goeventlist, var_22_0)
	local var_22_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_3, MeilanniEventItem)

	arg_22_0._eventList[var_22_0] = var_22_4

	var_22_4:updateInfo(arg_22_1)

	return var_22_4
end

function var_0_0._removeElement(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.eventId

	arg_23_0:_removeElementById(var_23_0)
end

function var_0_0._removeElementById(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._eventList[arg_24_1]

	if not var_24_0 then
		return
	end

	arg_24_0._eventList[arg_24_1] = nil

	var_24_0:dispose()
end

function var_0_0._setElementsVisible(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._eventList) do
		if iter_25_1 ~= arg_25_2 then
			if not iter_25_1.viewGO.activeSelf and arg_25_1 then
				gohelper.setActive(iter_25_1.viewGO, true)
				iter_25_1:playAnim("appear")
				iter_25_1:setPhotoVisible(true)
			end

			if iter_25_1:isSelected() then
				iter_25_1:setSelected(false)
			else
				iter_25_1:playAnim(arg_25_1 and "appear" or "disappear")
				iter_25_1:setPhotoVisible(arg_25_1)
			end
		end

		iter_25_1:setClickEnabled(arg_25_1)
	end
end

function var_0_0._checkActPointStatus(arg_26_0)
	local var_26_0 = arg_26_0._mapInfo:getCurEpisodeInfo().leftActPoint
	local var_26_1 = 0
	local var_26_2 = 0

	for iter_26_0, iter_26_1 in pairs(arg_26_0._eventList) do
		if iter_26_1:isSpecialType() then
			var_26_2 = var_26_2 + 1
		else
			var_26_1 = var_26_1 + 1
		end
	end

	local var_26_3 = var_26_0 - var_26_2

	for iter_26_2, iter_26_3 in pairs(arg_26_0._eventList) do
		if not iter_26_3:isSpecialType() then
			iter_26_3:setGray(var_26_3 > 0)
		end
	end
end

function var_0_0.onClose(arg_27_0)
	arg_27_0:_stopShowSequence()
	TaskDispatcher.cancelTask(arg_27_0._delayShowElements, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

return var_0_0
