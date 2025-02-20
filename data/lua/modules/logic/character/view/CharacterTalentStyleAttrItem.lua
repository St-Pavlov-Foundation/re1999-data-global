module("modules.logic.character.view.CharacterTalentStyleAttrItem", package.seeall)

slot0 = class("CharacterTalentStyleAttrItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_new")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_num")
	slot0._txtchange = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_num/#txt_change")
	slot0._imagechange = gohelper.findChildImage(slot0.viewGO, "#txt_name/#txt_num/#image_change")
	slot0._godelete = gohelper.findChild(slot0.viewGO, "#go_delete")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()

	slot0._canvasgroup = slot1:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

function slot0.onRefreshMo(slot0, slot1, slot2)
	slot3 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key))
	slot4 = nil
	slot5 = slot2.isDelete and 0 or slot2.value
	slot0._txtnum.text = slot3.type ~= 1 and slot5 * 0.1 .. "%" or math.floor(slot5)
	slot0._txtname.text = slot3.name

	gohelper.setActive(slot0._gobg.gameObject, slot1 % 2 == 0)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imageicon, "icon_att_" .. slot3.id, true)
	slot0:_showAttrChage(slot2)
end

function slot0._showAttrChage(slot0, slot1)
	slot2 = 0

	if slot1.isNew then
		slot2 = 3
	end

	if slot1.isDelete then
		slot2 = 4
	end

	if slot1.changeNum then
		slot2 = slot1.changeNum > 0 and 1 or 2
	end

	slot3 = CharacterTalentStyleEnum.AttrChange[slot2]
	slot0._txtnum.color = GameUtil.parseColor(slot3.NumColor)

	if not string.nilorempty(slot3.ChangeImage) then
		UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imagechange, slot3.ChangeImage)
	end

	gohelper.setActive(slot0._imagechange.gameObject, slot4)

	if not string.nilorempty(slot3.ChangeText) then
		slot0._txtchange.text = slot3.ChangeText
		slot0._txtchange.color = GameUtil.parseColor(slot3.ChangeColor)
	end

	slot0._canvasgroup.alpha = slot3.Alpha or 1

	gohelper.setActive(slot0._txtchange.gameObject, slot5)
	gohelper.setActive(slot0._gonew.gameObject, slot1.isNew)
	gohelper.setActive(slot0._godelete.gameObject, slot1.isDelete)
end

return slot0
