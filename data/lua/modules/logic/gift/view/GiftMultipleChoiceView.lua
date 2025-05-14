module("modules.logic.gift.view.GiftMultipleChoiceView", package.seeall)

local var_0_0 = class("GiftMultipleChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_item")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_ok")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._txtquantity = gohelper.findChildText(arg_1_0.viewGO, "root/quantity/#txt_quantity")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnokOnClick(arg_4_0)
	local var_4_0 = GiftModel.instance:getMultipleChoiceIndex()

	if var_4_0 == 0 then
		GameFacade.showToast(ToastEnum.GiftMultipleChoice)
	else
		arg_4_0:closeThis()

		local var_4_1 = {}
		local var_4_2 = {
			materialId = arg_4_0.viewParam.param.id,
			quantity = arg_4_0.viewParam.quantity
		}

		table.insert(var_4_1, var_4_2)
		ItemRpc.instance:sendUseItemRequest(var_4_1, var_4_0 - 1)
	end
end

function var_0_0._btncloseClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._contentGrid = gohelper.findChild(arg_6_0.viewGO, "root/#scroll_item/itemcontent"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	arg_6_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_setPropItems()

	arg_7_0._txtquantity.text = arg_7_0.viewParam.quantity
end

function var_0_0.onClose(arg_8_0)
	GiftModel.instance:reset()
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._setPropItems(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = string.split(ItemModel.instance:getItemConfig(arg_10_0.viewParam.param.type, arg_10_0.viewParam.param.id).effect, "|")

	arg_10_0._contentGrid.enabled = #var_10_1 < 6

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = MaterialDataMO.New()
		local var_10_3 = string.split(iter_10_1, "#")

		var_10_2.index = iter_10_0
		var_10_2.materilType = tonumber(var_10_3[1])
		var_10_2.materilId = tonumber(var_10_3[2])
		var_10_2.quantity = arg_10_0.viewParam.quantity * tonumber(var_10_3[3])

		if GiftModel.instance:isGiftNeed(var_10_2.materilId) then
			GiftModel.instance:setMultipleChoiceIndex(var_10_2.index)
		end

		table.insert(var_10_0, var_10_2)
	end

	GiftMultipleChoiceListModel.instance:setPropList(var_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg1:UnLoadImage()
	arg_11_0._simagebg2:UnLoadImage()
end

return var_0_0
