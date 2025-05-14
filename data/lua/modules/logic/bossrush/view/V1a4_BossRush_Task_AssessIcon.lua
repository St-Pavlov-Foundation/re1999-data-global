module("modules.logic.bossrush.view.V1a4_BossRush_Task_AssessIcon", package.seeall)

local var_0_0 = class("V1a4_BossRush_Task_AssessIcon", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goAssessEmpty = gohelper.findChild(arg_1_1, "#go_AssessEmpty")
	arg_1_0._goNotEmpty = gohelper.findChild(arg_1_1, "#go_NotEmpty")
	arg_1_0._goVxCircle = gohelper.findChild(arg_1_1, "#go_NotEmpty/#go_vx_circle")
	arg_1_0._imageAssessIcon = gohelper.findChildSingleImage(arg_1_1, "#go_NotEmpty/#image_AssessIcon")
	arg_1_0._goAssessIconS = gohelper.findChildSingleImage(arg_1_1, "#go_NotEmpty/#go_AssessIcon_s")
	arg_1_0._goAssessIconSS = gohelper.findChildSingleImage(arg_1_1, "#go_NotEmpty/#go_AssessIcon_ss")
	arg_1_0._goAssessIconSSS = gohelper.findChildSingleImage(arg_1_1, "#go_NotEmpty/#go_AssessIcon_sss")
	arg_1_0._goAssessIconSSSS = gohelper.findChildSingleImage(arg_1_1, "#go_NotEmpty/#go_AssessIcon_sss2")
	arg_1_0._goAssessIcon = arg_1_0._imageAssessIcon.gameObject

	gohelper.setActive(arg_1_0._goAssessIcon, false)
	gohelper.setActive(arg_1_0._goAssessIconS, false)
	gohelper.setActive(arg_1_0._goAssessIconSS, false)
	gohelper.setActive(arg_1_0._goAssessIconSSS, false)
	gohelper.setActive(arg_1_0._goAssessIconSSSS, false)
	gohelper.setActive(arg_1_0._goVxCircle, false)
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1, var_2_2 = BossRushConfig.instance:getAssessSpriteName(arg_2_1, arg_2_2, arg_2_3)
	local var_2_3 = var_2_0 == ""
	local var_2_4 = arg_2_0["_goAssessIcon" .. var_2_2] or arg_2_0._imageAssessIcon

	gohelper.setActive(var_2_4.gameObject, true)

	local var_2_5 = var_2_4:GetComponent(gohelper.Type_Image)

	if not var_2_3 then
		var_2_4:LoadImage(ResUrl.getV1a4BossRushAssessIcon(var_2_0), function()
			if arg_2_3 then
				var_2_5:SetNativeSize()
			end
		end)
	end

	if var_2_1 >= 5 then
		gohelper.setActive(arg_2_0._goVxCircle, true)
	end

	gohelper.setActive(arg_2_0._goAssessEmpty, var_2_3)
	gohelper.setActive(arg_2_0._goNotEmpty, not var_2_3)
end

function var_0_0.onDestroyView(arg_4_0)
	arg_4_0._imageAssessIcon:UnLoadImage()
	arg_4_0._goAssessIconS:UnLoadImage()
	arg_4_0._goAssessIconSS:UnLoadImage()
	arg_4_0._goAssessIconSSS:UnLoadImage()
	arg_4_0._goAssessIconSSSS:UnLoadImage()
end

return var_0_0
