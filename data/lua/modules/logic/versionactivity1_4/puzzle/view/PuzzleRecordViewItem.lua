module("modules.logic.versionactivity1_4.puzzle.view.PuzzleRecordViewItem", package.seeall)

local var_0_0 = class("PuzzleRecordViewItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0.txtRecord = gohelper.findChildText(arg_4_0.viewGO, "")
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetIndex()
	local var_7_1 = arg_7_1:GetRecord()

	arg_7_0.txtRecord.text = var_7_0 .. "." .. var_7_1
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
