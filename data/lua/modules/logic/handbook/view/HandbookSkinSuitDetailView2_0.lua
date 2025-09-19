module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_0", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView2_0", HandbookSkinSuitDetailViewBase)
local var_0_1 = 20010

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
	HandbookSkinSuitDetailViewBase._refreshDesc(arg_8_0)
end

function var_0_0._refreshBg(arg_9_0)
	return
end

function var_0_0._refreshSkinItems(arg_10_0)
	arg_10_0._skinItemList = {}

	for iter_10_0 = 1, #arg_10_0._skinIdList do
		local var_10_0 = arg_10_0._skinItemGoList[iter_10_0]

		if var_10_0 then
			local var_10_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0, HandbookSkinItem, arg_10_0)

			var_10_1:refreshItem(arg_10_0._skinIdList[iter_10_0])
			table.insert(arg_10_0._skinItemList, var_10_1)
		end
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
