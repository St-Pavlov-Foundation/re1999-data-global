module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotGuideDragTip", package.seeall)

local var_0_0 = class("V1a6_CachotGuideDragTip", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "#guide")

	arg_2_0._gohand = gohelper.findChild(var_2_0, "shou")
	arg_2_0._guideAnimator = var_2_0:GetComponent("Animator")
	arg_2_0._guideblock = gohelper.findChild(arg_2_0.viewGO, "guideblock")

	gohelper.setActive(arg_2_0._guideblock, false)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.GuideDragTip, arg_3_0._guideDragTip, arg_3_0)
	arg_3_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.PlayerMove, arg_3_0._playerMove, arg_3_0)
end

function var_0_0._playerMove(arg_4_0)
	return
end

function var_0_0._guideDragTip(arg_5_0, arg_5_1)
	local var_5_0 = tonumber(arg_5_1)

	if var_5_0 == V1a6_CachotEnum.GuideDragTipType.Left then
		gohelper.setActive(arg_5_0._guideAnimator.gameObject, true)
		gohelper.setActive(arg_5_0._guideblock, true)
		arg_5_0._guideAnimator:Play("left")
	elseif var_5_0 == V1a6_CachotEnum.GuideDragTipType.Right then
		gohelper.setActive(arg_5_0._guideAnimator.gameObject, true)
		gohelper.setActive(arg_5_0._guideblock, true)
		arg_5_0._guideAnimator:Play("right")
	else
		gohelper.setActive(arg_5_0._guideAnimator.gameObject, false)
		gohelper.setActive(arg_5_0._guideblock, false)
	end
end

function var_0_0.isShowDragTip(arg_6_0)
	return arg_6_0._guideblock.activeSelf
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
