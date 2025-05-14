module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTipsView", package.seeall)

local var_0_0 = class("V1a6_CachotTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txttips1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_tips1")
	arg_1_0._txttips2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_tips2")
	arg_1_0._goWin = gohelper.findChild(arg_1_0.viewGO, "#win")
	arg_1_0._goFail = gohelper.findChild(arg_1_0.viewGO, "#fail")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.style or V1a6_CachotEnum.TipStyle.Normal
	local var_4_1
	local var_4_2

	arg_4_0._txttips1.text = ""
	arg_4_0._txttips2.text = ""

	if var_4_0 == V1a6_CachotEnum.TipStyle.Normal then
		var_4_1 = arg_4_0._txttips1

		local var_4_3 = "v1a6_cachot_tipsbg2"

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_popups_prompt)
	elseif var_4_0 == V1a6_CachotEnum.TipStyle.ChangeConclusion then
		var_4_1 = arg_4_0._txttips2

		local var_4_4 = "v1a6_cachot_tipsbg1"

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_newendings_enter)
	end

	gohelper.setActive(arg_4_0._goFail, var_4_0 == V1a6_CachotEnum.TipStyle.ChangeConclusion)
	gohelper.setActive(arg_4_0._goWin, var_4_0 == V1a6_CachotEnum.TipStyle.Normal)

	if arg_4_0.viewParam.strExtra then
		var_4_1.text = GameUtil.getSubPlaceholderLuaLang(arg_4_0.viewParam.str, arg_4_0.viewParam.strExtra)
	else
		var_4_1.text = arg_4_0.viewParam.str
	end
end

function var_0_0.onClose(arg_5_0)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Tips)
end

return var_0_0
