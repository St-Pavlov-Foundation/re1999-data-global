module("modules.logic.investigate.view.InvestigateClueView", package.seeall)

local var_0_0 = class("InvestigateClueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_role")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "#go_role1")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_role1/#simage_role1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_role1/#simage_role2")
	arg_1_0._simagerole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_role1/#simage_role3")
	arg_1_0._txtrole = gohelper.findChildText(arg_1_0.viewGO, "#txt_role")

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

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = lua_investigate_info.configDict[arg_5_0.viewParam.id]

	if not var_5_0 then
		return
	end

	arg_5_0._txtrole.text = var_5_0.unlockDesc

	local var_5_1 = var_5_0.entrance == 1

	gohelper.setActive(arg_5_0._simagerole, not var_5_1)
	gohelper.setActive(arg_5_0._gorole1, var_5_1)

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(lua_investigate_info.configList) do
			if iter_5_1.group == var_5_0.group then
				local var_5_2 = arg_5_0["_simagerole" .. iter_5_0]

				if var_5_2 then
					var_5_2:LoadImage(iter_5_1.icon)
				end
			end
		end
	else
		arg_5_0._simagerole:LoadImage(var_5_0.icon)
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_leimi_celebrity_get)
end

function var_0_0.onClose(arg_6_0)
	if arg_6_0.viewParam.isGet then
		InvestigateController.instance:dispatchEvent(InvestigateEvent.ShowGetEffect)
	end
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagerole:UnLoadImage()
end

return var_0_0
