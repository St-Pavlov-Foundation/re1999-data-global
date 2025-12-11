module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_0", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView3_0", HandbookSkinSuitDetailViewBase)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
end

function var_0_0.onOpen(arg_2_0)
	HandbookSkinSuitDetailViewBase.onOpen(arg_2_0)
	arg_2_0:_getPhotoRootGo(#arg_2_0._skinIdList)
	arg_2_0:_refreshSkinItems()
	arg_2_0:_refreshDesc()
	arg_2_0:_refreshBg()
end

return var_0_0
