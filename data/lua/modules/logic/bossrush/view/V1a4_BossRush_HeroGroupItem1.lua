module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroupItem1", package.seeall)

slot0 = class("V1a4_BossRush_HeroGroupItem1", V1a4_BossRush_HeroGroupItemBase)

function slot0.init(slot0, slot1)
	slot0._gohero = gohelper.findChild(slot1, "#go_hero")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot1, "#go_hero/#simage_heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot1, "#go_hero/#image_career")
	slot0._gorank1 = gohelper.findChild(slot1, "#go_hero/layout/vertical/layout/rankobj/#go_rank1")
	slot0._gorank2 = gohelper.findChild(slot1, "#go_hero/layout/vertical/layout/rankobj/#go_rank2")
	slot0._gorank3 = gohelper.findChild(slot1, "#go_hero/layout/vertical/layout/rankobj/#go_rank3")
	slot0._txtlv = gohelper.findChildText(slot1, "#go_hero/layout/vertical/layout/level/#txt_lv")
	slot0._gostar1 = gohelper.findChild(slot1, "#go_hero/layout/vertical/go_starList/#go_star1")
	slot0._gostar2 = gohelper.findChild(slot1, "#go_hero/layout/vertical/go_starList/#go_star2")
	slot0._gostar3 = gohelper.findChild(slot1, "#go_hero/layout/vertical/go_starList/#go_star3")
	slot0._gostar4 = gohelper.findChild(slot1, "#go_hero/layout/vertical/go_starList/#go_star4")
	slot0._gostar5 = gohelper.findChild(slot1, "#go_hero/layout/vertical/go_starList/#go_star5")
	slot0._gostar6 = gohelper.findChild(slot1, "#go_hero/layout/vertical/go_starList/#go_star6")
	slot0._goequip = gohelper.findChild(slot1, "#go_hero/layout/#go_equip")
	slot0._imageequiprare = gohelper.findChildImage(slot1, "#go_hero/layout/#go_equip/#image_equiprare")
	slot0._imageequipicon = gohelper.findChildImage(slot1, "#go_hero/layout/#go_equip/#image_equipicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._starList = slot0:_initGoList("_gostar")
	slot0._rankList = slot0:_initGoList("_gorank")
end

function slot0.onSetData(slot0)
	slot0:_refreshHeroByDefault()
	slot0:_refreshEquip()
	slot0:refreshLevelList(slot0._rankList)
	slot0:refreshShowLevel(slot0._txtlv)
	slot0:refreshStarList(slot0._starList)
end

function slot0._refreshEquip(slot0)
	if not slot0._equipMo then
		gohelper.setActive(slot0._goequip, false)

		return
	end

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._imageequipicon, slot0:getEquipIconSpriteName())
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imageequiprare, slot0:getEquipRareSprite())
end

function slot0.onDestroy(slot0)
	slot0._simageheroicon:UnLoadImage()
end

return slot0
