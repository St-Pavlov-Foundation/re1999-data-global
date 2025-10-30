module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_2", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView2_2", HandbookSkinSuitDetailViewBase)
local var_0_1 = 20012

function var_0_0.onInitView(arg_1_0)
	HandbookSkinSuitDetailViewBase.onInitView(arg_1_0)
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0.viewGO)
end

function var_0_0.onOpen(arg_3_0)
	HandbookSkinSuitDetailViewBase.onOpen(arg_3_0)
	arg_3_0:_getPhotoRootGo(#arg_3_0._skinIdList)
	arg_3_0:_refreshSkinItems()
	arg_3_0:_refreshDesc()
	arg_3_0:_refreshBg()
end

function var_0_0._refreshDesc(arg_4_0)
	HandbookSkinSuitDetailViewBase._refreshDesc(arg_4_0)
end

function var_0_0._refreshBg(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

return var_0_0
