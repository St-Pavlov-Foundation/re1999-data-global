module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightViewLevel", package.seeall)

slot0 = class("RoleStoryHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function slot0._showEnemyList(slot0)
	uv0.super._showEnemyList(slot0)

	slot0._txtrecommendlevel.text = luaLang("common_none")
end

function slot0._onEnemyItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "icon"), "lssx_" .. tostring(slot2.career))

	gohelper.findChildTextMesh(slot1, "enemycount").text = ""

	gohelper.setActive(gohelper.findChild(slot1, "icon/kingIcon"), slot3 <= slot0._enemy_boss_end_index)
end

return slot0
