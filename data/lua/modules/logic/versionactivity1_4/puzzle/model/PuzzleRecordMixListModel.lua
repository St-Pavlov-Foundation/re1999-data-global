module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordMixListModel", package.seeall)

local var_0_0 = class("PuzzleRecordMixListModel", MixScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._infos = nil
end

function var_0_0.setRecordList(arg_2_0, arg_2_1)
	arg_2_0._infos = arg_2_1

	arg_2_0:setList(arg_2_1)
end

function var_0_0.getInfoList(arg_3_0, arg_3_1)
	local var_3_0 = {}

	if not arg_3_0._infos or #arg_3_0._infos <= 0 then
		return var_3_0
	end

	local var_3_1 = gohelper.findChildText(arg_3_1, "Viewport/Content/RecordItem")
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._infos) do
		local var_3_3 = 0
		local var_3_4 = GameUtil.filterRichText(iter_3_1:GetRecord())
		local var_3_5 = GameUtil.getTextHeightByLine(var_3_1, var_3_4 .. "   ", 37.1) + 20

		table.insert(var_3_0, SLFramework.UGUI.MixCellInfo.New(var_3_2, var_3_5, nil))
	end

	return var_3_0
end

function var_0_0.clearData(arg_4_0)
	arg_4_0._infos = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
