module("modules.logic.gm.view.GMRougeTool", package.seeall)

local var_0_0 = class("GMRougeTool", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnRougeMapEditor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/rouMap/btnRougeMapEditor")
	arg_1_0.btnEnterTestMap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/rouMap/btnEnterTestMap")
	arg_1_0.showAreaToggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/rouMap1/showNodeClickAreaToggle")
	arg_1_0.btnEditPathSelectMap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/rouMap1/btnEditPathSelectMap")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.showAreaToggle.isOn = RougeEditorController.instance:getIsShowing()
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0.btnRougeMapEditor:AddClickListener(arg_3_0.onClickRougeMapEditor, arg_3_0)
	arg_3_0.btnEnterTestMap:AddClickListener(arg_3_0.onClickEnterTestMap, arg_3_0)
	arg_3_0.showAreaToggle:AddOnValueChanged(arg_3_0.onToggleValueChanged, arg_3_0)

	if arg_3_0.btnEditPathSelectMap then
		arg_3_0.btnEditPathSelectMap:AddClickListener(arg_3_0.onClickRougeSelectMapEditor, arg_3_0)
	end
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0.btnRougeMapEditor:RemoveClickListener()
	arg_4_0.btnEnterTestMap:RemoveClickListener()
	arg_4_0.showAreaToggle:RemoveOnValueChanged()

	if arg_4_0.btnEditPathSelectMap then
		arg_4_0.btnEditPathSelectMap:RemoveClickListener()
	end
end

function var_0_0.onClickRougeMapEditor(arg_5_0)
	RougeEditorController.instance:enterRougeMapEditor()
	arg_5_0:closeThis()
end

function var_0_0.onClickEnterTestMap(arg_6_0)
	RougeMapModel.instance.inited = false

	GMRpc.instance:sendGMRequest("rougeMapInitTest 1", arg_6_0.onReceiveRpc, arg_6_0)
end

function var_0_0.onReceiveRpc(arg_7_0)
	RougeEditorController.instance:enterRougeTestMap()
	arg_7_0:closeThis()
end

function var_0_0.onToggleValueChanged(arg_8_0)
	if arg_8_0.showAreaToggle.isOn then
		RougeEditorController.instance:showNodeClickArea()
	else
		RougeEditorController.instance:hideNodeClickArea()
	end
end

function var_0_0.onClickRougeSelectMapEditor(arg_9_0)
	RougeEditorController.instance:enterPathSelectMapEditorView()
	arg_9_0:closeThis()
end

function var_0_0.onOpen(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
