module("modules.logic.versionactivity1_4.puzzle.view.PuzzleRecordItem", package.seeall)

local var_0_0 = class("PuzzleRecordItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtRecord = gohelper.findChildText(arg_1_1, "")
	arg_1_0._txtRecordNum = gohelper.findChildTextMesh(arg_1_1, "txt_RecordNum")
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

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._txtRecordNum.text = arg_5_1:GetIndex()
	arg_5_0._txtRecord.text = arg_5_1:GetRecord()
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	return
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
