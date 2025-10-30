module("modules.logic.versionactivity3_0.karong.view.KaRongRoleTagView", package.seeall)

local var_0_0 = class("KaRongRoleTagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goPage1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Page1")
	arg_1_0._txtName1 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page1/Data/txt_Name/#txt_Name1")
	arg_1_0._txtNum1 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page1/Data/txt_Num/#txt_Num1")
	arg_1_0._txtDate1 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page1/Data/txt_Date/#txt_Date1")
	arg_1_0._txtBlood1 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page1/Data/txt_Blood/#txt_Blood1")
	arg_1_0._goPage2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Page2")
	arg_1_0._txtName2 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page2/Data/txt_Name/#txt_Name2")
	arg_1_0._txtNum2 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page2/Data/txt_Num/#txt_Num2")
	arg_1_0._txtDate2 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page2/Data/txt_Date/#txt_Date2")
	arg_1_0._txtBlood2 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Page2/Data/txt_Blood/#txt_Blood2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_role_culture_open)

	if arg_3_0.viewParam then
		local var_3_0 = VersionActivity3_0Enum.ActivityId.KaRong
		local var_3_1 = Activity176Config.instance:getDogTagCfg(var_3_0, arg_3_0.viewParam)

		if var_3_1 then
			arg_3_0._txtName1.text = var_3_1.content1
			arg_3_0._txtDate1.text = var_3_1.content2
			arg_3_0._txtNum1.text = var_3_1.content3
			arg_3_0._txtBlood1.text = var_3_1.content4
		end
	end
end

return var_0_0
