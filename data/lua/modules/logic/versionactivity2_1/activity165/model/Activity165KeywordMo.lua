module("modules.logic.versionactivity2_1.activity165.model.Activity165KeywordMo", package.seeall)

local var_0_0 = class("Activity165KeywordMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.keywordCo = nil
	arg_1_0.keywordId = nil
	arg_1_0.isUsed = nil
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0.keywordCo = arg_2_1
	arg_2_0.keywordId = arg_2_1.keywordId
end

function var_0_0.setUsed(arg_3_0, arg_3_1)
	arg_3_0.isUsed = arg_3_1
end

function var_0_0.onReset(arg_4_0)
	arg_4_0.isUsed = nil
end

return var_0_0
