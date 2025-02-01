module("modules.logic.fight.view.FightCardDescItem", package.seeall)

slot0 = class("FightCardDescItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormalcard = gohelper.findChild(slot0.viewGO, "#go_normalcard")
	slot0._gosupercard = gohelper.findChild(slot0.viewGO, "#go_supercard")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageList = slot0:getUserDataTb_()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._mo = slot1
	slot0._isSuperCard = slot2

	if slot0._isSuperCard then
		slot0:onRefreshUI(slot0._gosupercard)
	else
		slot0:onRefreshUI(slot0._gonormalcard)
	end

	gohelper.setActive(slot0._gonormalcard, not slot0._isSuperCard)
	gohelper.setActive(slot0._gosupercard, slot0._isSuperCard)
end

function slot0.onRefreshUI(slot0, slot1)
	slot3 = gohelper.findChildSingleImage(slot1, "attribute")
	slot4 = gohelper.findChildText(slot1, "nameen")
	slot5 = gohelper.findChildText(slot1, "nameen/name")
	slot6 = gohelper.findChildText(slot1, "desc")
	slot7 = gohelper.findChildImage(slot1, "tagIcon")

	gohelper.findChildSingleImage(slot1, "card"):LoadImage(ResUrl.getFightCardDescIcon(slot0._mo.card1))

	if not string.nilorempty(slot0._mo.attribute) then
		slot3:LoadImage(ResUrl.getAttributeIcon(slot0._mo.attribute))
	end

	slot4.text = slot0._mo.cardname_en
	slot5.text = slot0._mo.cardname
	slot6.text = slot0._mo.carddescription2

	UISpriteSetMgr.instance:setFightSprite(slot7, slot0._mo.card2)
	gohelper.setActive(slot3.gameObject, not slot0._isSuperCard)
	gohelper.setActive(slot7.gameObject, not slot0._isSuperCard)
	table.insert(slot0._simageList, slot2)
	table.insert(slot0._simageList, slot3)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._simageList) do
		slot5:UnLoadImage()
	end
end

return slot0
