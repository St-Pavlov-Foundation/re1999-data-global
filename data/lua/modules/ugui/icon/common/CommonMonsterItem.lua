module("modules.ugui.icon.common.CommonMonsterItem", package.seeall)

slot0 = class("CommonMonsterItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._callback = nil
	slot0._callbackObj = nil
	slot0._btnClick = nil
	slot0._lvTxt = gohelper.findChildText(slot1, "lvltxt") or gohelper.findChildText(slot1, "verticalList/lvnum")
	slot0._nameCnTxt = gohelper.findChildText(slot1, "namecn")
	slot0._cardIcon = gohelper.findChildSingleImage(slot1, "charactericon")
	slot0._careerIcon = gohelper.findChildImage(slot1, "career")
	slot0._rareObj = gohelper.findChild(slot1, "rareobj")
	slot0._rareIconImage = gohelper.findChildImage(slot1, "cardrare")
	slot0._front = gohelper.findChildImage(slot1, "front")
	slot0._rankObj = gohelper.findChild(slot1, "rankobj")

	slot0:_initObj()
end

function slot0._initObj(slot0)
	if slot0._rareObj then
		slot0._rareGos = slot0:getUserDataTb_()

		for slot4 = 1, 5 do
			slot0._rareGos[slot4] = gohelper.findChild(slot0._rareObj, "rare" .. tostring(slot4))
		end
	end

	slot0._rankGOs = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		table.insert(slot0._rankGOs, gohelper.findChild(slot0._rankObj, "rank" .. slot4))
	end
end

function slot0._fillStarContent(slot0, slot1)
	slot2, slot3 = HeroConfig.instance:getShowLevel(slot1)

	for slot7 = 1, 3 do
		gohelper.setActive(slot0._rankGOs[slot7], slot7 == slot3 - 1)
	end
end

function slot0.addClickListener(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2

	if not slot0._btnClick then
		slot0._btnClick = SLFramework.UGUI.UIClickListener.Get(slot0.go)
	end

	slot0._btnClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeClickListener(slot0)
	slot0._callback = nil
	slot0._callbackObj = nil

	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end
end

function slot0.removeEventListeners(slot0)
	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._monsterCO = slot1
	slot0._lvTxt.text = HeroConfig.instance:getShowLevel(slot1.level)

	if slot0._nameCnTxt then
		slot0._nameCnTxt.text = slot1.name
	end

	if FightConfig.instance:getSkinCO(slot1.skinId) then
		slot0._cardIcon:LoadImage(ResUrl.getHeadIconLarge(slot3.retangleIcon))
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._careerIcon, "lssx_" .. tostring(slot1.career))
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._front, "bg_pz00" .. "1")

	if slot0._rareObj then
		slot0:_fillRareContent(slot1.rare)
		gohelper.setActive(slot0._rareObj, slot1.rare >= 0)
	end

	if slot0._nameCnTxt then
		gohelper.setActive(slot0._nameCnTxt.gameObject, not string.nilorempty(slot1.name))
	end

	if slot0._rankObj then
		slot0:_fillStarContent(slot1.level)
	end
end

function slot0._fillRareContent(slot0, slot1)
	for slot5 = 1, 5 do
		gohelper.setActive(slot0._rareGos[slot5], slot5 <= slot1)
	end
end

function slot0._onItemClick(slot0)
	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot0._monsterCO)
		else
			slot0._callback(slot0._monsterCO)
		end
	end
end

function slot0.onDestroy(slot0)
	slot0._cardIcon:UnLoadImage()
end

return slot0
