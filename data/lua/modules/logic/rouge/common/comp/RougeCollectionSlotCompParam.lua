module("modules.logic.rouge.common.comp.RougeCollectionSlotCompParam", package.seeall)

local var_0_0 = pureTable("RougeCollectionSlotCompParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.cellWidth = 20
	arg_1_0.cellHeight = 20
	arg_1_0.isNeedShowIcon = false
	arg_1_0.cellLineNameMap = {
		[RougeEnum.LineState.Grey] = "rouge_bagline_yellow",
		[RougeEnum.LineState.Green] = "rouge_bagline_green"
	}
	arg_1_0.cls = RougeCollectionCompCellItem
end

function var_0_0.getLine(arg_2_0, arg_2_1)
	return arg_2_0.cellLineNameMap and arg_2_0.cellLineNameMap[arg_2_1]
end

return var_0_0
