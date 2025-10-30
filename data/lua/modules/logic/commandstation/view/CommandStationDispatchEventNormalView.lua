module("modules.logic.commandstation.view.CommandStationDispatchEventNormalView", package.seeall)

local var_0_0 = class("CommandStationDispatchEventNormalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goDispatchEvent = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent")
	arg_1_0._goDispatchDetail = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchDetail")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchDetail/#txt_Title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchDetail/Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnDispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchDetail/#btn_Dispatch")
	arg_1_0._btnHaveDispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchDetail/#btn_HaveDispatch")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchDetail/Role/#simage_hero")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnDispatch:AddClickListener(arg_2_0._btnDispatchOnClick, arg_2_0)
	arg_2_0._btnHaveDispatch:AddClickListener(arg_2_0._btnHaveDispatchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnDispatch:RemoveClickListener()
	arg_3_0._btnHaveDispatch:RemoveClickListener()
end

function var_0_0._btnDispatchOnClick(arg_4_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.ClickDispatch)
end

function var_0_0._btnHaveDispatchOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._btnHaveDispatch, false)

	arg_6_0._animator = arg_6_0.viewGO:GetComponent("Animator")
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchChangeTab, arg_8_0._onDispatchChangeTab, arg_8_0)
end

function var_0_0._onDispatchChangeTab(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._isShow and not arg_9_1 and arg_9_2 ~= nil then
		if not arg_9_0._oldEventConfig then
			return
		end

		arg_9_0:_updateEventInfo(arg_9_0._oldEventConfig)
		arg_9_0._animator:Play(arg_9_2 and "switchleft" or "switchright", 0, 0)
		TaskDispatcher.cancelTask(arg_9_0._afterSwitchUpdateEventInfo, arg_9_0)
		TaskDispatcher.runDelay(arg_9_0._afterSwitchUpdateEventInfo, arg_9_0, 0.167)
	end
end

function var_0_0._afterSwitchUpdateEventInfo(arg_10_0)
	arg_10_0:_updateEventInfo(arg_10_0._eventConfig)
end

function var_0_0.onTabSwitchOpen(arg_11_0)
	if not arg_11_0._isShow then
		arg_11_0._animator:Play("open", 0, 0)
	end

	arg_11_0._isShow = true
	arg_11_0._oldEventConfig = arg_11_0._eventConfig
	arg_11_0._eventConfig = arg_11_0.viewContainer:getCurrentEventConfig()

	arg_11_0:_updateEventInfo(arg_11_0._eventConfig)
end

function var_0_0.onTabSwitchClose(arg_12_0)
	arg_12_0._isShow = false
end

function var_0_0._updateEventInfo(arg_13_0, arg_13_1)
	local var_13_0 = string.splitToNumber(arg_13_1.eventTextId, "#")
	local var_13_1 = arg_13_1.id
	local var_13_2 = CommandStationModel.instance:getDispatchEventInfo(var_13_1)
	local var_13_3 = var_13_2 and var_13_2:hasGetReward()

	gohelper.setActive(arg_13_0._btnHaveDispatch, var_13_3)
	gohelper.setActive(arg_13_0._btnDispatch, not var_13_3)

	local var_13_4 = var_13_3 and var_13_0[2] or var_13_0[1]
	local var_13_5 = var_13_4 and lua_copost_event_text.configDict[var_13_4]

	arg_13_0._txtDescr.text = var_13_5 and var_13_5.text
	arg_13_0._txtTitle.text = arg_13_1.eventTitleId

	arg_13_0._simagehero:LoadImage(ResUrl.getHeadIconSmall(arg_13_1.charaProfile))
end

function var_0_0.onClose(arg_14_0)
	arg_14_0._animator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(arg_14_0._afterSwitchUpdateEventInfo, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
