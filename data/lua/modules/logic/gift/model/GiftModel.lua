module("modules.logic.gift.model.GiftModel", package.seeall)

local var_0_0 = class("GiftModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._multipleChoiceIndex = 0
	arg_1_0._multipleChoiceId = 0
	arg_1_0._needProps = {}
end

function var_0_0.reset(arg_2_0)
	arg_2_0._multipleChoiceIndex = 0
	arg_2_0._multipleChoiceId = 0
	arg_2_0._needProps = {}
end

function var_0_0.setMultipleChoiceIndex(arg_3_0, arg_3_1)
	arg_3_0._multipleChoiceIndex = arg_3_1
end

function var_0_0.getMultipleChoiceIndex(arg_4_0)
	return arg_4_0._multipleChoiceIndex
end

function var_0_0.setMultipleChoiceId(arg_5_0, arg_5_1)
	arg_5_0._multipleChoiceId = arg_5_1
end

function var_0_0.getMultipleChoiceId(arg_6_0)
	return arg_6_0._multipleChoiceId
end

function var_0_0.setNeedGift(arg_7_0, arg_7_1)
	table.insert(arg_7_0._needProps, arg_7_1)
end

function var_0_0.isGiftNeed(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._needProps) do
		if iter_8_1 == arg_8_1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
