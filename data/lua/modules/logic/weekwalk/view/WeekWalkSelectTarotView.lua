module("modules.logic.weekwalk.view.WeekWalkSelectTarotView", package.seeall)

local var_0_0 = class("WeekWalkSelectTarotView", BaseView)

var_0_0.delaySwitchViewTime = 0.33

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_line")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ok")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	WeekwalkRpc.instance:sendMarkShowBuffRequest()
	arg_4_0:closeThis()
end

function var_0_0._btnokOnClick(arg_5_0)
	arg_5_0:_confirmSelect()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._itemList = arg_6_0:getUserDataTb_()

	arg_6_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beibao00.png"))
	arg_6_0._simageline:LoadImage(ResUrl.getWeekWalkBg("btn_01.png"))

	arg_6_0._gotarotitems = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#go_container/weekwalktarotitem" .. iter_6_0)

		table.insert(arg_6_0._gotarotitems, var_6_0)
		gohelper.setActive(var_6_0, iter_6_0 == 1)
	end

	gohelper.addUIClickAudio(arg_6_0._btnok.gameObject, AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnConfirmBindingBuff, arg_6_0._updateViewSwithTime, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._buffId = arg_8_0.viewParam.buffId

	arg_8_0:_refreshUI({
		arg_8_0._buffId
	})
	arg_8_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.TarotReply, arg_8_0._onTarotReply, arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_cardappear)
end

function var_0_0._refreshUI(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = arg_9_0._gotarotitems and arg_9_0._gotarotitems[iter_9_0]
		local var_9_1 = var_9_0 and MonoHelper.addNoUpdateLuaComOnceToGo(var_9_0, WeekWalkTarotItem)
		local var_9_2 = {}

		var_9_2.config, var_9_2.tarotId = lua_weekwalk_buff.configDict[iter_9_1], iter_9_1

		var_9_1:onUpdateMO(var_9_2, true)
		var_9_1:setClickCallback(arg_9_0._onTarotSelect, arg_9_0)
		table.insert(arg_9_0._itemList, var_9_1)
	end
end

function var_0_0._onTarotSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0._doOnTarotSelect(arg_11_0, arg_11_1)
	if arg_11_0._selectItem then
		transformhelper.setLocalScale(arg_11_0._selectItem.viewGO.transform, 1, 1, 1)
	end

	arg_11_0._selectTarotInfo = arg_11_1.info
	arg_11_0._selectItem = arg_11_1

	transformhelper.setLocalScale(arg_11_0._selectItem.viewGO.transform, 1.2, 1.2, 1)
end

function var_0_0._confirmSelect(arg_12_0)
	if not arg_12_0._selectTarotInfo then
		return
	end

	if arg_12_0._selectTarotInfo.config.type == WeekWalkEnum.BuffType.Pray then
		if WeekWalkCardListModel.instance:verifyCondition(arg_12_0._selectTarotInfo.tarotId) then
			WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickTarot, arg_12_0._selectItem.viewGO)
			TaskDispatcher.runDelay(arg_12_0._delayToSwitchView, arg_12_0, var_0_0.delaySwitchViewTime)
		end

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickTarot, arg_12_0._selectItem.viewGO)
	WeekwalkRpc.instance:sendWeekwalkBuffRequest(arg_12_0._selectTarotInfo.tarotId, 0, 0)
end

function var_0_0._delayToSwitchView(arg_13_0)
	WeekWalkController.instance:openWeekWalkBuffBindingView(arg_13_0._selectTarotInfo)
end

function var_0_0._onTarotReply(arg_14_0, arg_14_1)
	WeekWalkModel.instance:setBuffReward(nil)
	TaskDispatcher.runDelay(arg_14_0._delayToCloseThis, arg_14_0, var_0_0.delaySwitchViewTime)
end

function var_0_0._delayToCloseThis(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayToSwitchView, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayToCloseThis, arg_16_0)
end

function var_0_0._updateViewSwithTime(arg_17_0, arg_17_1)
	var_0_0.delaySwitchViewTime = arg_17_1 or 0
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagebg:UnLoadImage()
	arg_18_0._simageline:UnLoadImage()
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnConfirmBindingBuff, arg_18_0._updateViewSwithTime, arg_18_0)
end

return var_0_0
