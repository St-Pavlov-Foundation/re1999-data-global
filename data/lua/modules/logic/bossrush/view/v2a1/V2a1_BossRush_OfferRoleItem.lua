module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleItem", package.seeall)

slot0 = class("V2a1_BossRush_OfferRoleItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "role/#image_rare")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "role/#image_career")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "role/#txt_name")
	slot0._txtnameEn = gohelper.findChildText(slot0.viewGO, "role/#txt_name/#txt_nameEn")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._uiclick = SLFramework.UGUI.UIClickListener.Get(slot0._goclick)

	slot0._uiclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0._btnclickOnClick(slot0)
	BossRushEnhanceRoleViewListModel.instance:setSelect(slot0._mo.characterId)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simageheroicon:UnLoadImage()
	slot0._uiclick:RemoveClickListener()
end

function slot0._refreshItem(slot0)
	slot2 = HeroConfig.instance:getHeroCO(slot0._mo.characterId)

	slot0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(SkinConfig.instance:getSkinCo(slot2.skinId).headIcon))

	slot0._txtname.text = slot2.name
	slot0._txtnameEn.text = slot2.nameEng

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot2.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. CharacterEnum.Color[slot2.rare])
end

return slot0
