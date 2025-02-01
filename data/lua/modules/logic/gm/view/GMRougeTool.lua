module("modules.logic.gm.view.GMRougeTool", package.seeall)

slot0 = class("GMRougeTool", BaseView)

function slot0.onInitView(slot0)
	slot0.btnRougeMapEditor = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/rouMap/btnRougeMapEditor")
	slot0.btnEnterTestMap = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/rouMap/btnEnterTestMap")
	slot0.showAreaToggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/rouMap1/showNodeClickAreaToggle")
	slot0.btnEditPathSelectMap = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/rouMap1/btnEditPathSelectMap")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0.showAreaToggle.isOn = RougeEditorController.instance:getIsShowing()
end

function slot0.addEvents(slot0)
	slot0.btnRougeMapEditor:AddClickListener(slot0.onClickRougeMapEditor, slot0)
	slot0.btnEnterTestMap:AddClickListener(slot0.onClickEnterTestMap, slot0)
	slot0.showAreaToggle:AddOnValueChanged(slot0.onToggleValueChanged, slot0)

	if slot0.btnEditPathSelectMap then
		slot0.btnEditPathSelectMap:AddClickListener(slot0.onClickRougeSelectMapEditor, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0.btnRougeMapEditor:RemoveClickListener()
	slot0.btnEnterTestMap:RemoveClickListener()
	slot0.showAreaToggle:RemoveOnValueChanged()

	if slot0.btnEditPathSelectMap then
		slot0.btnEditPathSelectMap:RemoveClickListener()
	end
end

function slot0.onClickRougeMapEditor(slot0)
	RougeEditorController.instance:enterRougeMapEditor()
	slot0:closeThis()
end

function slot0.onClickEnterTestMap(slot0)
	RougeMapModel.instance.inited = false

	GMRpc.instance:sendGMRequest("rougeMapInitTest 1", slot0.onReceiveRpc, slot0)
end

function slot0.onReceiveRpc(slot0)
	RougeEditorController.instance:enterRougeTestMap()
	slot0:closeThis()
end

function slot0.onToggleValueChanged(slot0)
	if slot0.showAreaToggle.isOn then
		RougeEditorController.instance:showNodeClickArea()
	else
		RougeEditorController.instance:hideNodeClickArea()
	end
end

function slot0.onClickRougeSelectMapEditor(slot0)
	RougeEditorController.instance:enterPathSelectMapEditorView()
	slot0:closeThis()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
