module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDialogStep", package.seeall)

local var_0_0 = class("TianShiNaNaDialogStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = TianShiNaNaEntityMgr.instance:getEntity(arg_1_0._data.interactId)

	if var_1_0 and var_1_0.checkActive then
		var_1_0._unitMo:setActive(true)
		var_1_0:checkActive()
	end

	if arg_1_0._data.dialogueId == 0 then
		return arg_1_0:onDone(true)
	end

	arg_1_0:beginPlayDialog()
end

function var_0_0.beginPlayDialog(arg_2_0)
	local var_2_0 = TianShiNaNaConfig.instance:getBubbleCo(VersionActivity2_2Enum.ActivityId.TianShiNaNa, arg_2_0._data.dialogueId)

	if not var_2_0 then
		logError("天使娜娜对话配置不存在" .. arg_2_0._data.dialogueId)
		arg_2_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onViewClose, arg_2_0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaTalkView, var_2_0)
end

function var_0_0._onViewClose(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.TianShiNaNaTalkView then
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_4_0._onViewClose, arg_4_0)
end

return var_0_0
