module("modules.logic.rouge.map.view.map.RougeMapEntrustView", package.seeall)

local var_0_0 = class("RougeMapEntrustView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnEntrust = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_entrust")
	arg_1_0._goEntrustContainer = gohelper.findChild(arg_1_0.viewGO, "Left/#go_entrustcontainer")
	arg_1_0._txtEntrustDesc = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_entrustcontainer/#txt_entrustdesc")
	arg_1_0._btnHideEntrust = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_entrustcontainer/#btn_hideentrust")
	arg_1_0._gocangeteffect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_entrust/#effect_canget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEntrust:AddClickListener(arg_2_0._btnEntrustOnClick, arg_2_0)
	arg_2_0._btnHideEntrust:AddClickListener(arg_2_0._btnHideEntrustOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEntrust:RemoveClickListener()
	arg_3_0._btnHideEntrust:RemoveClickListener()
end

function var_0_0._btnEntrustOnClick(arg_4_0)
	if not arg_4_0.hadEntrust then
		return
	end

	arg_4_0.status = RougeMapEnum.EntrustStatus.Detail

	arg_4_0:refreshStatus()
end

function var_0_0._btnHideEntrustOnClick(arg_5_0)
	if not arg_5_0.hadEntrust then
		return
	end

	arg_5_0:closeEntrust()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.goEntrustBtn = arg_6_0._btnEntrust.gameObject
	arg_6_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_6_0._goEntrustContainer)

	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onEntrustChange, arg_6_0.onEntrustChange, arg_6_0)
end

function var_0_0.onEntrustChange(arg_7_0)
	arg_7_0:tryShowEntrust()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:tryShowEntrust()
end

function var_0_0.tryShowEntrust(arg_9_0)
	arg_9_0.status = RougeMapEnum.EntrustStatus.Detail

	arg_9_0:updateHadEntrust()
	arg_9_0:refreshEntrust()

	if arg_9_0.hadEntrust then
		TaskDispatcher.cancelTask(arg_9_0.closeEntrust, arg_9_0)
		TaskDispatcher.runDelay(arg_9_0.closeEntrust, arg_9_0, RougeMapEnum.ChangeEntrustTime)
	end
end

function var_0_0.closeEntrust(arg_10_0)
	if arg_10_0.closing then
		return
	end

	arg_10_0.closing = true

	arg_10_0.animatorPlayer:Play("close", arg_10_0.onCloseAnimDone, arg_10_0)
end

function var_0_0.onCloseAnimDone(arg_11_0)
	arg_11_0.closing = nil
	arg_11_0.status = RougeMapEnum.EntrustStatus.Brief

	arg_11_0:refreshStatus()
	arg_11_0:refreshEffect()
end

function var_0_0.updateHadEntrust(arg_12_0)
	local var_12_0 = RougeMapModel.instance:getEntrustId()

	arg_12_0.entrustId = var_12_0
	arg_12_0.hadEntrust = var_12_0 ~= nil
	arg_12_0.entrustProgress = RougeMapModel.instance:getEntrustProgress()
	arg_12_0.isFinished = arg_12_0.entrustProgress and arg_12_0.entrustProgress >= 1
end

function var_0_0.refreshEntrust(arg_13_0)
	if not arg_13_0.hadEntrust then
		arg_13_0:hideEntrust()

		return
	end

	local var_13_0 = lua_rouge_entrust.configDict[arg_13_0.entrustId]
	local var_13_1 = lua_rouge_entrust_desc.configDict[var_13_0.type]

	arg_13_0:refreshStatus()
	arg_13_0:initEntrustDescHandle()
	arg_13_0:refreshEffect()

	local var_13_2 = arg_13_0.entrustTypeHandleDict[var_13_0.type]

	arg_13_0._txtEntrustDesc.text = var_13_2 and var_13_2(arg_13_0, var_13_0, var_13_1) or ""
end

function var_0_0.refreshStatus(arg_14_0)
	gohelper.setActive(arg_14_0.goEntrustBtn, arg_14_0.status == RougeMapEnum.EntrustStatus.Brief)
	gohelper.setActive(arg_14_0._goEntrustContainer, arg_14_0.status == RougeMapEnum.EntrustStatus.Detail)
end

function var_0_0.refreshEffect(arg_15_0)
	local var_15_0 = false

	gohelper.setActive(arg_15_0._gocangeteffect, var_15_0)

	if var_15_0 then
		TaskDispatcher.cancelTask(arg_15_0.hideCangetEffect, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0.hideCangetEffect, arg_15_0, RougeMapEnum.FinishEntrustEffect)
	end
end

function var_0_0.hideCangetEffect(arg_16_0)
	gohelper.setActive(arg_16_0._gocangeteffect, false)
end

function var_0_0.hideEntrust(arg_17_0)
	gohelper.setActive(arg_17_0.goEntrustBtn, false)
	gohelper.setActive(arg_17_0._goEntrustContainer, false)
end

function var_0_0.initEntrustDescHandle(arg_18_0)
	if arg_18_0.entrustTypeHandleDict then
		return
	end

	arg_18_0.entrustTypeHandleDict = {
		[RougeMapEnum.EntrustEventType.MakeMoney] = arg_18_0.makeMoneyHandle,
		[RougeMapEnum.EntrustEventType.CostMoney] = arg_18_0.costMoneyHandle,
		[RougeMapEnum.EntrustEventType.Event] = arg_18_0.eventHandle,
		[RougeMapEnum.EntrustEventType.Curse] = arg_18_0.curseHandle,
		[RougeMapEnum.EntrustEventType.CostPower] = arg_18_0.costPowerHandle,
		[RougeMapEnum.EntrustEventType.MakePower] = arg_18_0.makePowerHandle,
		[RougeMapEnum.EntrustEventType.FinishEvent] = arg_18_0.finishEventHandle,
		[RougeMapEnum.EntrustEventType.GetCollection] = arg_18_0.getCollectionHandle,
		[RougeMapEnum.EntrustEventType.LevelUpSpCollection] = arg_18_0.levelupSpCollectionHandle
	}
end

function var_0_0.makeMoneyHandle(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = tonumber(arg_19_1.param)
	local var_19_1 = RougeMapModel.instance:getEntrustProgress()
	local var_19_2 = arg_19_0:getDesc(arg_19_2, var_19_0 <= var_19_1)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_19_2, var_19_0, var_19_1)
end

function var_0_0.costMoneyHandle(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = tonumber(arg_20_1.param)
	local var_20_1 = RougeMapModel.instance:getEntrustProgress()
	local var_20_2 = arg_20_0:getDesc(arg_20_2, var_20_0 <= var_20_1)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_20_2, var_20_0, var_20_1)
end

function var_0_0.eventHandle(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = RougeMapModel.instance:getEntrustProgress()
	local var_21_1 = string.split(arg_21_1.param, "|")
	local var_21_2 = string.splitToNumber(var_21_1[1], "#")

	for iter_21_0 = 1, #var_21_2 do
		var_21_2[iter_21_0] = lua_rouge_event_type.configDict[var_21_2[iter_21_0]].name
	end

	local var_21_3 = tonumber(var_21_1[2])
	local var_21_4 = arg_21_0:getDesc(arg_21_2, var_21_3 <= var_21_0)

	return GameUtil.getSubPlaceholderLuaLangThreeParam(var_21_4, var_21_3, table.concat(var_21_2, "_"), var_21_0)
end

function var_0_0.curseHandle(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_2.desc
end

function var_0_0.costPowerHandle(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = tonumber(arg_23_1.param)
	local var_23_1 = RougeMapModel.instance:getEntrustProgress()
	local var_23_2 = arg_23_0:getDesc(arg_23_2, var_23_0 <= var_23_1)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_23_2, var_23_0, var_23_1)
end

function var_0_0.makePowerHandle(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = tonumber(arg_24_1.param)
	local var_24_1 = RougeMapModel.instance:getEntrustProgress()
	local var_24_2 = arg_24_0:getDesc(arg_24_2, var_24_0 <= var_24_1)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_24_2, var_24_0, var_24_1)
end

function var_0_0.finishEventHandle(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = RougeMapModel.instance:getEntrustProgress()
	local var_25_1 = arg_25_0:getDesc(arg_25_2, var_25_0 >= 1)
	local var_25_2 = tonumber(arg_25_1.param)
	local var_25_3 = RougeMapConfig.instance:getRougeEvent(var_25_2)

	return GameUtil.getSubPlaceholderLuaLangOneParam(var_25_1, var_25_3.name)
end

function var_0_0.getCollectionHandle(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = tonumber(arg_26_1.param)
	local var_26_1 = RougeMapModel.instance:getEntrustProgress()
	local var_26_2 = arg_26_0:getDesc(arg_26_2, var_26_0 <= var_26_1)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_26_2, var_26_0, var_26_1)
end

function var_0_0.levelupSpCollectionHandle(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = tonumber(arg_27_1.param)
	local var_27_1 = RougeMapModel.instance:getEntrustProgress()
	local var_27_2 = arg_27_0:getDesc(arg_27_2, var_27_0 <= var_27_1)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_27_2, var_27_0, var_27_1)
end

function var_0_0.getDesc(arg_28_0, arg_28_1, arg_28_2)
	return arg_28_2 and arg_28_1.finishDesc or arg_28_1.desc
end

function var_0_0.onClose(arg_29_0)
	arg_29_0.closing = nil

	TaskDispatcher.cancelTask(arg_29_0.closeEntrust, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.hideCangetEffect, arg_29_0)
end

return var_0_0
