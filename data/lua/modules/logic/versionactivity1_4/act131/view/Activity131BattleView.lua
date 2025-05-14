module("modules.logic.versionactivity1_4.act131.view.Activity131BattleView", package.seeall)

local var_0_0 = class("Activity131BattleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/#txt_info")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#btn_closetip")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/right/go_fight/#btn_fight")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosetip:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	return
end

function var_0_0._btnfightOnClick(arg_5_0)
	Activity131Controller.instance:enterFight(arg_5_0.episodeCfg)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_6_0._doClose, arg_6_0, 0.233)
end

function var_0_0._doClose(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._viewAnim = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)

	local var_10_0 = tonumber(arg_10_0.viewContainer.viewParam)

	arg_10_0.episodeCfg = DungeonConfig.instance:getEpisodeCO(var_10_0)

	if arg_10_0.episodeCfg then
		arg_10_0._txttitle.text = arg_10_0.episodeCfg.name
		arg_10_0._txtinfo.text = arg_10_0.episodeCfg.desc
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
