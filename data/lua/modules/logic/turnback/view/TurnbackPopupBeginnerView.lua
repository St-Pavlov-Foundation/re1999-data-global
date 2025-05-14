module("modules.logic.turnback.view.TurnbackPopupBeginnerView", package.seeall)

local var_0_0 = class("TurnbackPopupBeginnerView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosubview = gohelper.findChild(arg_1_0.viewGO, "#go_subview")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	NavigateMgr.instance:addEscape(ViewName.TurnbackPopupBeginnerView, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	NavigateMgr.instance:removeEscape(ViewName.TurnbackPopupBeginnerView, arg_3_0._btncloseOnClick, arg_3_0)
end

local var_0_1 = {
	TurnbackPopupRewardView
}

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0.viewIndex = arg_4_0.viewIndex + 1

	if var_0_1[arg_4_0.viewIndex] then
		arg_4_0:openSubPopupView(arg_4_0.viewIndex)
	else
		arg_4_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.openSubPopupView(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[arg_6_0.viewIndex]

	if arg_6_0.viewObjDict[var_6_0] then
		gohelper.setActive(arg_6_0.viewObjDict[var_6_0], true)
	end

	local var_6_1 = {
		callbackObject = arg_6_0,
		closeCallback = arg_6_0._btncloseOnClick
	}

	arg_6_0:openExclusiveView(nil, arg_6_1, var_0_1[arg_6_1], arg_6_0.viewObjDict[var_6_0] or var_6_0, arg_6_0._gosubview, var_6_1)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.viewObjDict = arg_8_0:getUserDataTb_()

	arg_8_0:com_loadListAsset(arg_8_0.viewContainer:getSetting().otherRes, arg_8_0._assetLoaded, arg_8_0.onLoadFinish)
end

function var_0_0._assetLoaded(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetResource()
	local var_9_1 = gohelper.clone(var_9_0, arg_9_0.viewGO)

	gohelper.setActive(var_9_1, false)

	arg_9_0.viewObjDict[arg_9_1.ResPath] = var_9_1
end

function var_0_0.onLoadFinish(arg_10_0)
	arg_10_0.viewIndex = 1

	arg_10_0:openSubPopupView(arg_10_0.viewIndex)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
