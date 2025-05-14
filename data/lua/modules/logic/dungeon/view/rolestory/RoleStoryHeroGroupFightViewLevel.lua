module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightViewLevel", package.seeall)

local var_0_0 = class("RoleStoryHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function var_0_0._showEnemyList(arg_1_0)
	var_0_0.super._showEnemyList(arg_1_0)

	arg_1_0._txtrecommendlevel.text = luaLang("common_none")
end

function var_0_0._onEnemyItemShow(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = gohelper.findChildImage(arg_2_1, "icon")
	local var_2_1 = gohelper.findChild(arg_2_1, "icon/kingIcon")
	local var_2_2 = gohelper.findChildTextMesh(arg_2_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_2_0, "lssx_" .. tostring(arg_2_2.career))

	var_2_2.text = ""

	gohelper.setActive(var_2_1, arg_2_3 <= arg_2_0._enemy_boss_end_index)
end

return var_0_0
