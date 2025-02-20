module("modules.logic.social.view.SocialHeroItem", package.seeall)

slot0 = class("SocialHeroItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imagerare = gohelper.findChildImage(slot1, "Role/#image_Rare")
	slot0._imagecareer = gohelper.findChildImage(slot1, "Role/#image_Career")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot1, "Role/#simage_HeroIcon")
	slot5 = "Lv/#txt_Lv"
	slot0._txtlv = gohelper.findChildTextMesh(slot1, slot5)

	for slot5 = 1, 5 do
		slot0["_goexSkillFull" .. slot5] = gohelper.findChild(slot1, "Lv/SuZao/" .. slot5 .. "/FG")
	end

	slot5 = "Rank"
	slot0._gorank = gohelper.findChild(slot1, slot5)

	for slot5 = 1, 3 do
		slot0["_gorank" .. slot5] = gohelper.findChild(slot0._gorank, "rank" .. slot5)
	end
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.updateMo(slot0, slot1)
	slot0:setActive(true)

	slot2 = slot1.level
	slot3 = slot1.exSkillLevel
	slot4 = lua_character.configDict[slot1.heroId]

	if slot1.skin == 0 then
		slot5 = slot4.skinId
	end

	slot7, slot8 = HeroConfig.instance:getShowLevel(slot2)

	slot0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(lua_skin.configDict[slot5].headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot4.career))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. CharacterEnum.Star[slot4.rare])

	if slot8 == 1 then
		gohelper.setActive(slot0._gorank, false)
	else
		slot12 = true

		gohelper.setActive(slot0._gorank, slot12)

		for slot12 = 1, 3 do
			gohelper.setActive(slot0["_gorank" .. slot12], slot12 == slot8 - 1)
		end
	end

	for slot12 = 1, 5 do
		gohelper.setActive(slot0["_goexSkillFull" .. slot12], slot12 <= slot3)
	end

	slot0._txtlv.text = "Lv." .. slot7
end

function slot0.onDestroy(slot0)
	slot0._simageheroicon:UnLoadImage()
end

return slot0
