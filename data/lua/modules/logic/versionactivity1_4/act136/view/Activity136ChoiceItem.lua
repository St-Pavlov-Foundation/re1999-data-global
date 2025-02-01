module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceItem", package.seeall)

slot0 = class("Activity136ChoiceItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._txtnum = gohelper.findChildText(slot0._go, "num/#txt_num")
	slot0._btnClick = gohelper.getClickWithAudio(gohelper.findChild(slot0._go, "go_click"), AudioEnum.UI.UI_vertical_first_tabs_click)
	slot0._goSelected = gohelper.findChild(slot0._go, "select")
	slot0._imagerare = gohelper.findChildImage(slot0._go, "role/rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._go, "role/heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0._go, "role/career")
	slot0._txtname = gohelper.findChildText(slot0._go, "role/name")
	slot0._txtnameen = gohelper.findChildText(slot0._go, "role/name/nameEn")
	slot0._isSelected = false

	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0._btnClick:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClick:RemoveClickListener()
end

function slot0._onClick(slot0)
	if not Activity136Model.instance:isActivity136InOpen(true) then
		return
	end

	if Activity136Model.instance:hasReceivedCharacter() then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	slot4 = nil

	if not slot0._isSelected then
		slot4 = slot0._mo and slot0._mo.id
	end

	slot0._view:selectCell(slot0._index, slot3)
	Activity136Controller.instance:dispatchEvent(Activity136Event.SelectCharacter, slot4)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not HeroConfig.instance:getHeroCO(slot0._mo.id) then
		logError("Activity136CharacterItem.onUpdateMO error, characterCfg is nil, id:" .. tostring(slot0._mo.id))

		return
	end

	if not SkinConfig.instance:getSkinCo(slot2.skinId) then
		logError("Activity136CharacterItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(slot2.skinId))

		return
	end

	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot3.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot2.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. CharacterEnum.Color[slot2.rare])

	slot0._txtname.text = slot2.name
	slot0._txtnameen.text = slot2.nameEng
	slot4 = 0

	if not string.nilorempty(slot2.duplicateItem) and string.split(slot5, "|")[1] then
		slot8 = string.splitToNumber(slot7, "#")
		slot4 = ItemModel.instance:getItemQuantity(slot8[1], slot8[2])
	end

	slot6 = nil
	slot0._txtnum.text = (not HeroModel.instance:getByHeroId(slot0._mo.id) or formatLuaLang("has_num", slot7.exSkillLevel + 1 + slot4)) and luaLang("not_has")
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelected = slot1

	gohelper.setActive(slot0._goSelected, slot0._isSelected)
end

function slot0.onDestroy(slot0)
	slot0._isSelected = false

	slot0._simageicon:UnLoadImage()
	slot0:removeEvents()
end

return slot0
