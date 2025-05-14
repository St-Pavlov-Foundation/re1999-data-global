module("modules.logic.rouge.dlc.101.view.RougeMainView_1_101", package.seeall)

local var_0_0 = class("RougeMainView_1_101", BaseViewExtended)

var_0_0.AssetUrl = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
var_0_0.ParentObjPath = "Right/#go_dlc/#go_dlc_101/go_limiterroot/go_pos"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0:getParentView().viewGO, "Right/#go_dlc/#go_dlc_101/go_limiterroot/btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

local var_0_1 = 61

function var_0_0.createAndInitDLCRes(arg_4_0)
	arg_4_0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0.viewGO, RougeLimiterBuffEntry)

	arg_4_0._buffEntry:refreshUI(true)
	arg_4_0._buffEntry:setDifficultyTxtFontSize(var_0_1)
	arg_4_0._buffEntry:setInteractable(false)
	AudioMgr.instance:trigger(AudioEnum.UI.ShowRougeLimiter)
end

function var_0_0._btnclickOnClick(arg_5_0)
	if RougeModel.instance:inRouge() then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	RougeDLCController101.instance:openRougeLimiterView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:createAndInitDLCRes()
end

return var_0_0
