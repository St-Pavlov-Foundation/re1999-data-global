module("modules.logic.handbook.view.HandbookSkinSuitDetailView1_9", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView1_9", HandbookSkinSuitDetailViewBase)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._viewMatCtrl = arg_1_0.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function var_0_0.onOpen(arg_2_0)
	HandbookSkinSuitDetailViewBase.onOpen(arg_2_0)

	if not arg_2_0._isSuitSwitch and arg_2_0._viewMatCtrl then
		arg_2_0._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)
	end

	arg_2_0:_getPhotoRootGo(#arg_2_0._skinIdList)
	arg_2_0:_refreshSkinItems()
	arg_2_0:_refreshDesc()
	arg_2_0:_refreshBg()
end

function var_0_0.onDestroyView(arg_3_0)
	return
end

return var_0_0
