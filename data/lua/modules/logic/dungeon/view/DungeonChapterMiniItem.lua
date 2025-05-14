module("modules.logic.dungeon.view.DungeonChapterMiniItem", package.seeall)

local var_0_0 = class("DungeonChapterMiniItem", DungeonChapterItem)

function var_0_0._setLockStatus(arg_1_0, arg_1_1)
	var_0_0.super._setLockStatus(arg_1_0, arg_1_1)

	if not arg_1_0._goSpecial then
		arg_1_0._goSpecial = gohelper.findChild(arg_1_0.viewGO, "anim/image_Special")
	end

	if not arg_1_1 then
		local var_1_0 = luaLang(DungeonEnum.SpecialMainPlot[arg_1_0._mo.id])

		if not arg_1_0._txtSpecial then
			arg_1_0._txtSpecial = gohelper.findChildTextMesh(arg_1_0.viewGO, "anim/image_Special/txt_Special")
		end

		arg_1_0._txtSpecial.text = var_1_0
	end

	gohelper.setActive(arg_1_0._goSpecial, not arg_1_1)
end

function var_0_0._getInAnimName(arg_2_0)
	return "dungeonchapterminiitem_in"
end

function var_0_0._getUnlockAnimName(arg_3_0)
	return "dungeonchapterminiitem_unlock"
end

function var_0_0._getIdleAnimName(arg_4_0)
	return "dungeonchapterminiitem_idle"
end

function var_0_0._getCloseAnimName(arg_5_0)
	return "dungeonchapterminiitem_close"
end

return var_0_0
