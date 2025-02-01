module("modules.logic.summon.view.variant.SummonCharacterProbUpVer221", package.seeall)

slot0 = class("SummonCharacterProbUpVer221", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_2_2/v2a2_tianshinana/v2a2_tianshinana_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_tianshinana/v2a2_tianshinana_rolebg.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_bottom")
	slot0._simagedec1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_dec1")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_ad1")
	slot0._simagefront = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_front")
	slot0._simagedec2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_dec2")
	slot0._txtticket = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_shop/#txt_num")
	slot0._btnshop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_shop/#btn_shop")

	if slot0._btnshop then
		slot0._btnshop:AddClickListener(slot0._btnshopOnClick, slot0)
	end

	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
	slot0._simagedec1:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._simagefront:UnLoadImage()
	slot0._simagedec2:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	if slot0._btnshop then
		slot0._btnshop:RemoveClickListener()
	end

	uv0.super.onDestroyView(slot0)
end

function slot0.onItemChanged(slot0)
	uv0.super.onItemChanged(slot0)
	slot0:refreshTicket()
end

function slot0._refreshView(slot0)
	uv0.super._refreshView(slot0)
	slot0:refreshTicket()
end

function slot0.refreshTicket(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2 = 0

	if slot1.ticketId ~= 0 then
		slot2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot1.ticketId)
	end

	slot0._txtticket.text = tostring(slot2)
end

function slot0._btnshopOnClick(slot0)
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.Summon)
end

return slot0
