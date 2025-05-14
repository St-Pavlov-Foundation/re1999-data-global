module("modules.logic.investigate.view.InvestigateRoleStoryView", package.seeall)

local var_0_0 = class("InvestigateRoleStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_fullbg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_title")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_desc")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_desc/viewport/content/#txt_dec")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._id = arg_7_0.viewParam
	arg_7_0._config = lua_investigate_info.configDict[arg_7_0._id]
	arg_7_0._txttitle.text = arg_7_0._config.desc
	arg_7_0._txtdec.text = arg_7_0._config.conclusionDesc

	arg_7_0._simagefullbg:LoadImage(arg_7_0._config.conclusionBg)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_mln_unlock)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
