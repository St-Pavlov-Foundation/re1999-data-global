module("modules.logic.season.view1_2.Season1_2EquipFloatTouch", package.seeall)

local var_0_0 = class("Season1_2EquipFloatTouch", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._goctrlPath = arg_4_1
	arg_4_0._gotouchPath = arg_4_2
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goctrl = gohelper.findChild(arg_5_0.viewGO, arg_5_0._goctrlPath)
	arg_5_0._gotouch = gohelper.findChild(arg_5_0.viewGO, arg_5_0._gotouchPath)
	arg_5_0._tfTouch = arg_5_0._gotouch.transform
	arg_5_0._tfCtrl = arg_5_0._goctrl.transform
	arg_5_0._originX, arg_5_0._originY, arg_5_0._originZ = transformhelper.getLocalRotation(arg_5_0._tfTouch)
	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._gotouch)

	arg_5_0._drag:AddDragBeginListener(arg_5_0.onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragListener(arg_5_0.onDrag, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0.onDragEnd, arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0:killTween()

	if arg_6_0._drag then
		arg_6_0._drag:RemoveDragBeginListener()
		arg_6_0._drag:RemoveDragListener()
		arg_6_0._drag:RemoveDragEndListener()

		arg_6_0._drag = nil
	end
end

function var_0_0.onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2.position

	arg_8_0:killTween()

	local var_8_1 = recthelper.screenPosToAnchorPos(var_8_0, arg_8_0._tfTouch)

	arg_8_0._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(arg_8_0._tfCtrl, 0, 0, 0, 0.7, nil, nil, nil, EaseType.OutCirc)
end

var_0_0.Range_Rotaion_Min_X = -25
var_0_0.Range_Rotaion_Max_X = 25
var_0_0.Range_Rotaion_Min_Y = -25
var_0_0.Range_Rotaion_Max_Y = 25

function var_0_0.onDrag(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position
	local var_9_1 = 250
	local var_9_2 = recthelper.screenPosToAnchorPos(var_9_0, arg_9_0._tfTouch)
	local var_9_3 = Mathf.Clamp(var_9_2.x / var_9_1, -1, 1) * 0.5 + 0.5
	local var_9_4 = Mathf.Clamp(-var_9_2.y / var_9_1, -1, 1) * 0.5 + 0.5
	local var_9_5 = Mathf.Lerp(var_0_0.Range_Rotaion_Min_X, var_0_0.Range_Rotaion_Max_X, var_9_3)
	local var_9_6 = Mathf.Lerp(var_0_0.Range_Rotaion_Min_Y, var_0_0.Range_Rotaion_Max_Y, var_9_4)

	arg_9_0:killTween()

	arg_9_0._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(arg_9_0._tfCtrl, var_9_6, var_9_5, 0, 0.3, nil, nil, nil, EaseType.Linear)
end

function var_0_0.killTween(arg_10_0)
	if arg_10_0._tweenRotationId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenRotationId)

		arg_10_0._tweenRotationId = nil
	end
end

return var_0_0
