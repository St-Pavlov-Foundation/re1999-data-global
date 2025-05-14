module("modules.logic.summon.view.variant.SummonCharacterProbUpVer253", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer253", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_1_6/quniang/full/v1a6_quniang_summon_fullbg.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._goShop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_shop")
	arg_1_0._txtticket = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_shop/#txt_num")
	arg_1_0._btnshop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_shop/#btn_shop")

	if arg_1_0._btnshop then
		arg_1_0._btnshop:AddClickListener(arg_1_0._btnshopOnClick, arg_1_0)
	end

	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

function var_0_0.onDestroyView(arg_4_0)
	if arg_4_0._btnshop then
		arg_4_0._btnshop:RemoveClickListener()
	end

	var_0_0.super.onDestroyView(arg_4_0)
end

function var_0_0.onItemChanged(arg_5_0)
	var_0_0.super.onItemChanged(arg_5_0)
	arg_5_0:refreshTicket()
end

function var_0_0._refreshView(arg_6_0)
	var_0_0.super._refreshView(arg_6_0)
	arg_6_0:refreshTicket()
end

function var_0_0.refreshTicket(arg_7_0)
	local var_7_0 = SummonMainModel.instance:getCurPool()

	if not var_7_0 then
		return
	end

	local var_7_1 = 0

	if var_7_0.ticketId ~= 0 then
		local var_7_2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_7_0.ticketId)

		arg_7_0._txtticket.text = tostring(var_7_2)
	end

	gohelper.setActive(arg_7_0._goShop, var_7_0.ticketId ~= 0)
end

function var_0_0._btnshopOnClick(arg_8_0)
	local var_8_0 = StoreEnum.StoreId.LimitStore

	StoreController.instance:checkAndOpenStoreView(var_8_0)
end

return var_0_0
