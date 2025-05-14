module("modules.logic.summon.view.SummonView", package.seeall)

local var_0_0 = class("SummonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._imageskiptxt = gohelper.findChildImage(arg_1_0.viewGO, "#btn_skip/#image_skiptxt")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#btn_skip/#image_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	local var_4_0 = UnityEngine.Input.mousePosition

	if GamepadController.instance.getMousePosition then
		var_4_0 = GamepadController.instance:getMousePosition()
	end

	local var_4_1 = recthelper.screenPosToAnchorPos(var_4_0, arg_4_0.viewGO.transform)
	local var_4_2 = {
		st = var_4_1
	}

	SummonController.instance:trackSummonClientEvent(true, var_4_2)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._btnskip.gameObject, false)
end

function var_0_0._initSummonView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	logNormal("SummonView onUpdateParam")
end

function var_0_0.onOpen(arg_8_0)
	logNormal("SummonView onOpen")
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, arg_8_0._handleSelectTab, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.startDraw, arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	SummonMainModel.instance:updateLastPoolId()
	arg_8_0:_handleSelectTab()
end

function var_0_0.startDraw(arg_9_0)
	gohelper.setActive(arg_9_0._btnskip.gameObject, not SummonController.instance:isInSummonGuide() and not SummonModel.instance:getSendEquipFreeSummon())
end

function var_0_0._handleSelectTab(arg_10_0)
	local var_10_0 = SummonController.instance:getLastPoolId()
	local var_10_1 = SummonMainModel.getResultTypeById(var_10_0)

	arg_10_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, var_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.onClose(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Close)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return var_0_0
