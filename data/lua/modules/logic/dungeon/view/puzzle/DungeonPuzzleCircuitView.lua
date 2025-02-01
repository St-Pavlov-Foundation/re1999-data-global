module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuitView", package.seeall)

slot0 = class("DungeonPuzzleCircuitView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._gobasepoint = gohelper.findChild(slot0.viewGO, "#go_basepoint")
	slot0._gocube = gohelper.findChild(slot0.viewGO, "#go_basepoint/#go_cube")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goedit = gohelper.findChild(slot0.viewGO, "#go_edit")
	slot0._btnexport = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#btn_export")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnexport:AddClickListener(slot0._btnexportOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnexport:RemoveClickListener()
end

function slot0._btnexportOnClick(slot0)
	DungeonPuzzleCircuitModel.instance:debugData()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_beijingtu"))
	slot0._simagebg2:LoadImage(ResUrl.getDungeonPuzzleBg("bg_caozuotai"))
	gohelper.setActive(slot0._goedit, false)
end

function slot0._onDropValueChanged(slot0, slot1)
	DungeonPuzzleCircuitModel.instance:setEditIndex(slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onCloseFinish(slot0)
	if slot0._dropView then
		slot0._dropView:RemoveOnValueChanged()
	end

	if DungeonPuzzleCircuitModel.instance:getElementCo() and DungeonMapModel.instance:hasMapPuzzleStatus(slot1.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot1.id)
	end

	DungeonPuzzleCircuitModel.instance:release()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
