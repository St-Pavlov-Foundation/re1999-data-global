module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPaperView", package.seeall)

local var_0_0 = class("SportsNewsPaperView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#txt_content")
	arg_1_0._btnstartbtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_startbtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstartbtn:AddClickListener(arg_2_0._btnstartbtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstartbtn:RemoveClickListener()
end

function var_0_0._btnstartbtnOnClick(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.actId
	local var_4_1 = SportsNewsModel.instance:getFirstHelpKey(var_4_0)

	PlayerPrefsHelper.setString(var_4_1, "watched")
	arg_4_0:closeThis()
	HelpController.instance:showHelp(HelpEnum.HelpId.SportsNews)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
