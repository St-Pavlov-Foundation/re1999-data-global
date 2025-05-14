module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalResultView", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRevivalResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipswindow = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goteamprepareitem = gohelper.findChild(arg_1_0.viewGO, "#go_teamprepareitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0._initPresetItem(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes[1]
	local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._goteamprepareitem)

	arg_7_0._item = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, V1a6_CachotRoleRevivalPresetItem)
end

function var_0_0._initPrepareItem(arg_8_0)
	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[2]
	local var_8_1 = arg_8_0:getResInst(var_8_0, arg_8_0._goteamprepareitem)
	local var_8_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, V1a6_CachotRoleRevivalPrepareItem)

	var_8_2:hideDeadStatus(true)

	arg_8_0._item = var_8_2
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._mo = arg_9_0.viewParam[1]

	arg_9_0:_initPrepareItem()
	arg_9_0._item:onUpdateMO(arg_9_0._mo)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
