module("modules.logic.mainuiswitch.view.SwitchMainUIEagleAnimView", package.seeall)

local var_0_0 = class("SwitchMainUIEagleAnimView", MainEagleAnimView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onclick, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.ClickEagle, arg_2_0._onclick, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.ClickEagle, arg_3_0._onclick, arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.refreshUI(arg_4_0, arg_4_1)
	TaskDispatcher.cancelTask(arg_4_0._normalAnimFinish, arg_4_0)

	arg_4_1 = arg_4_1 or MainUISwitchModel.instance:getCurUseUI()

	if arg_4_0._showSkinId == arg_4_1 then
		return
	end

	arg_4_0._showSkinId = arg_4_1

	local var_4_0 = arg_4_1 and arg_4_1 == MainUISwitchEnum.Skin.Sp01

	gohelper.setActive(arg_4_0._gospine, var_4_0)

	if not var_4_0 then
		if arg_4_0._uiSpine then
			arg_4_0._loadSpine = false

			gohelper.destroy(arg_4_0._uiSpine:getSpineGo())

			arg_4_0._spineSkeleton = nil
		end

		if arg_4_0._uiBottomSpine then
			arg_4_0._loadBottomSpine = false

			gohelper.destroy(arg_4_0._uiBottomSpine:getSpineGo())

			arg_4_0._bottomSpineSkeleton = nil
		end

		gohelper.setActive(arg_4_0._goeagleani, false)
	else
		gohelper.setActive(arg_4_0._goeagleani, arg_4_0._animName == MainUISwitchEnum.EagleAnim.Hover)
		arg_4_0:_initBgSpine()
	end
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._btnList = arg_5_0:getUserDataTb_()

	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left/#btn_quest"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left/#btn_storage"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left/#btn_bank"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left/#btn_mail"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left/#btn_hide"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left/#btn_switchrole"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "left_top/playerinfos/info/#btn_playerinfo"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "#btn_bgm"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "limitedshow/#btn_limitedshow"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "right/#btn_room"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "right/#btn_power"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "right/#btn_role"))
	table.insert(arg_5_0._btnList, gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "right/#btn_summon"))
	table.insert(arg_5_0._btnList, SLFramework.UGUI.UIClickListener.Get(gohelper.findChild(arg_5_0.viewGO, "#go_lightspinecontrol")))
end

function var_0_0._btnMainViewOnClick(arg_6_0)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickMainViewBtn)
end

return var_0_0
