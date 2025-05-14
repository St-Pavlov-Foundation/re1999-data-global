module("modules.logic.gift.view.OptionalGiftMultipleChoiceView", package.seeall)

local var_0_0 = class("OptionalGiftMultipleChoiceView", GiftMultipleChoiceView)

function var_0_0._btnokOnClick(arg_1_0)
	if GiftModel.instance:getMultipleChoiceIndex() == 0 then
		GameFacade.showToast(ToastEnum.GiftMultipleChoice)
	else
		local var_1_0 = GiftModel.instance:getMultipleChoiceId()

		arg_1_0:closeThis()

		local var_1_1 = {}
		local var_1_2 = {
			materialId = arg_1_0.viewParam.param.id,
			quantity = arg_1_0.viewParam.quantity
		}

		table.insert(var_1_1, var_1_2)
		ItemRpc.instance:sendUseItemRequest(var_1_1, var_1_0)
	end
end

function var_0_0._setPropItems(arg_2_0)
	local var_2_0 = {}

	arg_2_0.giftIds = GiftMultipleChoiceListModel.instance:getOptionalGiftIdList(arg_2_0.viewParam.param.id)
	arg_2_0._contentGrid.enabled = #arg_2_0.giftIds < 6

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.giftIds) do
		local var_2_1 = MaterialDataMO.New()

		var_2_1.index = iter_2_0
		var_2_1.materilType = 1
		var_2_1.materilId = iter_2_1
		var_2_1.quantity = arg_2_0.viewParam.quantity * 1

		if GiftModel.instance:isGiftNeed(var_2_1.materilId) then
			GiftModel.instance:setMultipleChoiceIndex(iter_2_0)
			GiftModel.instance:setMultipleChoiceId(iter_2_1)
		end

		table.insert(var_2_0, var_2_1)
	end

	GiftMultipleChoiceListModel.instance:setPropList(var_2_0)
end

return var_0_0
