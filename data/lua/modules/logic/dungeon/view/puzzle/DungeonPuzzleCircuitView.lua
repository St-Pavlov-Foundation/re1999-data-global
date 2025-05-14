module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuitView", package.seeall)

local var_0_0 = class("DungeonPuzzleCircuitView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._gobasepoint = gohelper.findChild(arg_1_0.viewGO, "#go_basepoint")
	arg_1_0._gocube = gohelper.findChild(arg_1_0.viewGO, "#go_basepoint/#go_cube")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goedit = gohelper.findChild(arg_1_0.viewGO, "#go_edit")
	arg_1_0._btnexport = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#btn_export")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnexport:AddClickListener(arg_2_0._btnexportOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnexport:RemoveClickListener()
end

function var_0_0._btnexportOnClick(arg_4_0)
	DungeonPuzzleCircuitModel.instance:debugData()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg1:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_beijingtu"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getDungeonPuzzleBg("bg_caozuotai"))
	gohelper.setActive(arg_6_0._goedit, false)
end

function var_0_0._onDropValueChanged(arg_7_0, arg_7_1)
	DungeonPuzzleCircuitModel.instance:setEditIndex(arg_7_1)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onCloseFinish(arg_10_0)
	if arg_10_0._dropView then
		arg_10_0._dropView:RemoveOnValueChanged()
	end

	local var_10_0 = DungeonPuzzleCircuitModel.instance:getElementCo()

	if var_10_0 and DungeonMapModel.instance:hasMapPuzzleStatus(var_10_0.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, var_10_0.id)
	end

	DungeonPuzzleCircuitModel.instance:release()
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg1:UnLoadImage()
	arg_11_0._simagebg2:UnLoadImage()
end

return var_0_0
