module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroupItem1", package.seeall)

local var_0_0 = class("V1a4_BossRush_HeroGroupItem1", V1a4_BossRush_HeroGroupItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gohero = gohelper.findChild(arg_1_1, "#go_hero")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_1, "#go_hero/#simage_heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_1, "#go_hero/#image_career")
	arg_1_0._gorank1 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/layout/rankobj/#go_rank1")
	arg_1_0._gorank2 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/layout/rankobj/#go_rank2")
	arg_1_0._gorank3 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/layout/rankobj/#go_rank3")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_1, "#go_hero/layout/vertical/layout/level/#txt_lv")
	arg_1_0._gostar1 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/go_starList/#go_star1")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/go_starList/#go_star2")
	arg_1_0._gostar3 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/go_starList/#go_star3")
	arg_1_0._gostar4 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/go_starList/#go_star4")
	arg_1_0._gostar5 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/go_starList/#go_star5")
	arg_1_0._gostar6 = gohelper.findChild(arg_1_1, "#go_hero/layout/vertical/go_starList/#go_star6")
	arg_1_0._goequip = gohelper.findChild(arg_1_1, "#go_hero/layout/#go_equip")
	arg_1_0._imageequiprare = gohelper.findChildImage(arg_1_1, "#go_hero/layout/#go_equip/#image_equiprare")
	arg_1_0._imageequipicon = gohelper.findChildImage(arg_1_1, "#go_hero/layout/#go_equip/#image_equipicon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._starList = arg_2_0:_initGoList("_gostar")
	arg_2_0._rankList = arg_2_0:_initGoList("_gorank")
end

function var_0_0.onSetData(arg_3_0)
	arg_3_0:_refreshHeroByDefault()
	arg_3_0:_refreshEquip()
	arg_3_0:refreshLevelList(arg_3_0._rankList)
	arg_3_0:refreshShowLevel(arg_3_0._txtlv)
	arg_3_0:refreshStarList(arg_3_0._starList)
end

function var_0_0._refreshEquip(arg_4_0)
	if not arg_4_0._equipMo then
		gohelper.setActive(arg_4_0._goequip, false)

		return
	end

	local var_4_0 = arg_4_0:getEquipIconSpriteName()

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_4_0._imageequipicon, var_4_0)

	local var_4_1 = arg_4_0:getEquipRareSprite()

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_4_0._imageequiprare, var_4_1)
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0._simageheroicon:UnLoadImage()
end

return var_0_0
