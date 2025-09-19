module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_1", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView2_1", HandbookSkinSuitDetailViewBase)
local var_0_1 = 20011

function var_0_0.onInitView(arg_1_0)
	HandbookSkinSuitDetailViewBase.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._viewMatCtrl = arg_4_0.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	if arg_5_0._viewMatCtrl then
		arg_5_0._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)
	end

	arg_5_0._skinThemeGroupId = var_5_0 and var_5_0.skinThemeGroupId or var_0_1
	arg_5_0._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(arg_5_0._skinThemeGroupId)

	local var_5_1 = arg_5_0._skinSuitCfg.skinContain

	arg_5_0._skinIdList = string.splitToNumber(var_5_1, "|")

	arg_5_0:_getPhotoRootGo(#arg_5_0._skinIdList)
	arg_5_0:_refreshSkinItems()
	arg_5_0:_refreshDesc()
	arg_5_0:_refreshBg()
end

function var_0_0.refreshUI(arg_6_0)
	return
end

function var_0_0.refreshBtnStatus(arg_7_0)
	return
end

function var_0_0._refreshDesc(arg_8_0)
	arg_8_0._textSkinThemeDescr.text = arg_8_0._skinSuitCfg.des
end

function var_0_0._refreshBg(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
