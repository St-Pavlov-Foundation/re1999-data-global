module("modules.logic.bossrush.view.V1a4_BossRush_AssessIcon", package.seeall)

local var_0_0 = class("V1a4_BossRush_AssessIcon", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goAssessEmpty = gohelper.findChild(arg_1_1, "#go_AssessEmpty")
	arg_1_0._goNotEmpty = gohelper.findChild(arg_1_1, "#go_NotEmpty")
	arg_1_0._imageAssessIcon = gohelper.findChildSingleImage(arg_1_1, "#go_NotEmpty/#image_AssessIcon")
	arg_1_0._imageAssessIconTran = arg_1_0._imageAssessIcon:GetComponent(gohelper.Type_RectTransform)
	arg_1_0._goAssessEmptyTran = arg_1_0._goAssessEmpty.transform
	arg_1_0.lastLevel = nil
end

local var_0_1 = 1.6842105263157894

function var_0_0.setIconSize(arg_2_0, arg_2_1)
	recthelper.setSize(arg_2_0._imageAssessIconTran, arg_2_1, arg_2_1)
	recthelper.setSize(arg_2_0._goAssessEmptyTran, arg_2_1 * var_0_1, arg_2_1)
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0, var_3_1 = BossRushConfig.instance:getAssessSpriteName(arg_3_1, arg_3_2, arg_3_3)
	local var_3_2 = var_3_0 == ""
	local var_3_3 = var_3_1 > 0 and var_3_1 ~= arg_3_0.lastLevel

	if not var_3_2 then
		local var_3_4 = arg_3_3 and 1.2 or 1

		transformhelper.setLocalScale(arg_3_0._imageAssessIcon.transform, var_3_4, var_3_4, var_3_4)
		arg_3_0._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(var_3_0))
	end

	gohelper.setActive(arg_3_0._goAssessEmpty, var_3_2)
	gohelper.setActive(arg_3_0._goNotEmpty, not var_3_2)

	if var_3_3 then
		arg_3_0:playVX()

		arg_3_0.lastLevel = var_3_1
	end
end

function var_0_0.playVX(arg_4_0)
	if arg_4_0._parentView and arg_4_0._isPlayVX then
		TaskDispatcher.cancelTask(arg_4_0.delayDisVX, arg_4_0)
		arg_4_0._parentView:playVX()
		TaskDispatcher.runDelay(arg_4_0.delayDisVX, arg_4_0, 0.8)
	end
end

function var_0_0.delayDisVX(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayDisVX, arg_5_0)

	if arg_5_0._parentView and arg_5_0._isPlayVX then
		arg_5_0._parentView:stopVX()
	end
end

function var_0_0.initData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._parentView = arg_6_1
	arg_6_0._isPlayVX = arg_6_2

	TaskDispatcher.cancelTask(arg_6_0.delayDisVX, arg_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:onDestroyView()
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._imageAssessIcon:UnLoadImage()
end

return var_0_0
