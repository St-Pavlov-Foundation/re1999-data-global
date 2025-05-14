module("modules.logic.rouge.dlc.101.view.RougeResultReView_1_101", package.seeall)

local var_0_0 = class("RougeResultReView_1_101", BaseViewExtended)

var_0_0.AssetUrl = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
var_0_0.ParentObjPath = "Left/#go_dlc/#go_dlc_101/#go_limiterroot"
var_0_0.LimiterDifficultyFontSize = 144

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golimiteritem = gohelper.findChild(arg_1_0.viewGO, "#go_dlc_101")

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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0._reviewInfo and arg_5_0._reviewInfo:getLimiterRiskValue() or 0

	arg_5_0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0.viewGO, RougeResultReViewLimiterBuff, var_5_0)

	arg_5_0._buffEntry:setDifficultyTxtFontSize(var_0_0.LimiterDifficultyFontSize)
	arg_5_0._buffEntry:setDifficultyVisible(false)
	arg_5_0._buffEntry:refreshUI()
	arg_5_0._buffEntry:setInteractable(false)
end

function var_0_0.onRefreshViewParam(arg_6_0, arg_6_1)
	arg_6_0._reviewInfo = arg_6_1 and arg_6_1.reviewInfo
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
