module("modules.logic.store.view.ClothesStoreDragView", package.seeall)

local var_0_0 = class("ClothesStoreDragView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/bg/characterSpine/#go_skincontainer")
	arg_1_0._skincontainerCanvasGroup = gohelper.findChildComponent(arg_1_0.viewGO, "#go_has/character/bg/characterSpine/#go_skincontainer", typeof(UnityEngine.CanvasGroup))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#go_has/drag")

	gohelper.setActive(var_1_0, true)

	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(var_1_0)

	arg_1_0._drag:AddDragBeginListener(arg_1_0._onViewDragBegin, arg_1_0)
	arg_1_0._drag:AddDragListener(arg_1_0._onViewDrag, arg_1_0)
	arg_1_0._drag:AddDragEndListener(arg_1_0._onViewDragEnd, arg_1_0)

	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onViewDragBegin(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._startPos = arg_4_2.position.x

	arg_4_0._animator:Play("switchout", 0, 0)
	arg_4_0:setShaderKeyWord(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function var_0_0._onViewDrag(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2.position.x
	local var_5_1 = 1
	local var_5_2 = recthelper.getAnchorX(arg_5_0._goskincontainer.transform) + arg_5_2.delta.x * var_5_1

	recthelper.setAnchorX(arg_5_0._goskincontainer.transform, var_5_2)

	local var_5_3 = 0.007

	arg_5_0._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(arg_5_0._startPos - var_5_0) * var_5_3
end

function var_0_0._onViewDragEnd(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = StoreClothesGoodsItemListModel.instance:getSelectIndex()
	local var_6_1 = StoreClothesGoodsItemListModel.instance:getCount()
	local var_6_2 = arg_6_2.position.x
	local var_6_3

	if var_6_2 > arg_6_0._startPos and var_6_2 - arg_6_0._startPos >= 100 then
		var_6_3 = var_6_0 - 1

		if var_6_3 == 0 then
			var_6_3 = var_6_1
		end
	elseif var_6_2 < arg_6_0._startPos and arg_6_0._startPos - var_6_2 >= 100 then
		var_6_3 = var_6_0 + 1

		if var_6_1 < var_6_3 then
			var_6_3 = 1
		end
	end

	arg_6_0._skincontainerCanvasGroup.alpha = 1

	arg_6_0:setShaderKeyWord(true)
	TaskDispatcher.cancelTask(arg_6_0.disAbleShader, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.disAbleShader, arg_6_0, 0.33)

	if var_6_3 then
		StoreClothesGoodsItemListModel.instance:setSelectIndex(var_6_3, true)
	else
		recthelper.setAnchor(arg_6_0._goskincontainer.transform, 0, 0)
		arg_6_0._animator:Play("switchin", 0, 0)
	end
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.setShaderKeyWord(arg_8_0, arg_8_1)
	if arg_8_1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.disAbleShader(arg_9_0)
	arg_9_0:setShaderKeyWord(false)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.disAbleShader, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.disAbleShader, arg_11_0)

	if arg_11_0._drag then
		arg_11_0._drag:RemoveDragBeginListener()
		arg_11_0._drag:RemoveDragEndListener()
		arg_11_0._drag:RemoveDragListener()
	end
end

return var_0_0
