module("modules.logic.seasonver.act166.view.Season166ResultHeroItem", package.seeall)

slot0 = class("Season166ResultHeroItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._gohero = gohelper.findChild(slot1, "heroitemani")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot1, "heroitemani/hero/charactericon")
	slot0._imagecareer = gohelper.findChildImage(slot1, "heroitemani/hero/career")
	slot0._gorank1 = gohelper.findChild(slot1, "heroitemani/hero/vertical/layout/rankobj/rank1")
	slot0._gorank2 = gohelper.findChild(slot1, "heroitemani/hero/vertical/layout/rankobj/rank2")
	slot0._gorank3 = gohelper.findChild(slot1, "heroitemani/hero/vertical/layout/rankobj/rank3")
	slot0._txtlv = gohelper.findChildText(slot1, "heroitemani/hero/vertical/layout/lv/lvnum")
	slot0._gostar1 = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star1")
	slot0._gostar2 = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star2")
	slot0._gostar3 = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star3")
	slot0._gostar4 = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star4")
	slot0._gostar5 = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star5")
	slot0._gostar6 = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star6")
	slot0._goequip = gohelper.findChild(slot1, "heroitemani/equip")
	slot0._imageequiprare = gohelper.findChildImage(slot1, "heroitemani/equip/equiprare")
	slot0._imageequipicon = gohelper.findChildImage(slot1, "heroitemani/equip/equipicon")
	slot0._txtequiplvl = gohelper.findChildText(slot1, "heroitemani/equip/equiplv/txtequiplv")
	slot0._goEmpty = gohelper.findChild(slot1, "empty")
end

function slot0.setData(slot0, slot1, slot2)
	slot0.heroMo = slot1
	slot0.equipMo = slot2

	slot0:_refreshHero()
	slot0:_refreshEquip()
	gohelper.setActive(slot0._gohero, true)
	gohelper.setActive(slot0._goEmpty, false)
end

function slot0._refreshHero(slot0)
	if not slot0.heroMo then
		logError("heroMo is nil")

		return
	end

	slot0._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(FightConfig.instance:getSkinCO(slot1.skin).retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot1.config.career))

	slot0._txtlv.text, slot7 = HeroConfig.instance:getShowLevel(slot1.level or 0)

	slot0:_refreshLevelList()
	slot0:_refreshStarList()
end

function slot0._refreshEquip(slot0)
	if not slot0.equipMo then
		gohelper.setActive(slot0._goequip, false)

		return
	end

	slot2 = slot1.config

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._imageequipicon, slot2.icon)
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imageequiprare, "bianduixingxian_" .. tostring(slot2.rare))

	slot0._txtequiplvl.text = slot1.level
end

function slot0._refreshLevelList(slot0)
	slot3, slot4 = HeroConfig.instance:getShowLevel(slot0.heroMo and slot1.level or 0)

	for slot8 = 1, 3 do
		gohelper.setActive(slot0["_gorank" .. slot8], slot8 == slot4 - 1)
	end
end

function slot0._refreshStarList(slot0)
	for slot6 = 1, 6 do
		gohelper.setActive(slot0["_gostar" .. slot6], slot6 <= (slot0.heroMo.config and slot1.config.rare or -1) + 1)
	end
end

function slot0.onDestroy(slot0)
	slot0._simageheroicon:UnLoadImage()
end

return slot0
