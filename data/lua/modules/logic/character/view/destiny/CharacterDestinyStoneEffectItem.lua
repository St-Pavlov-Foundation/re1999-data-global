module("modules.logic.character.view.destiny.CharacterDestinyStoneEffectItem", package.seeall)

local var_0_0 = class("CharacterDestinyStoneEffectItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_unlock")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_unlock/#txt_desc")
	arg_1_0._gounlocktip = gohelper.findChild(arg_1_0.viewGO, "#go_unlocktip")
	arg_1_0._txtunlocktips = gohelper.findChildText(arg_1_0.viewGO, "#go_unlocktip/#txt_unlocktips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()

	arg_5_0._unlockInfoItems = arg_5_0:getUserDataTb_()
	arg_5_0._lockInfoItems = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0.viewGO, true)
	gohelper.setActive(arg_5_0._gounlock, false)
	gohelper.setActive(arg_5_0._gounlocktip, false)
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0:removeEvents()
end

function var_0_0.onUpdateMo(arg_8_0, arg_8_1)
	if arg_8_1.curUseStoneId == 0 then
		return
	end

	local var_8_0 = arg_8_1.rank

	arg_8_0._mo = arg_8_1

	local var_8_1 = CharacterDestinyConfig.instance:getDestinyFacetCo(arg_8_1.curUseStoneId)

	if var_8_1 then
		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			local var_8_2 = var_8_0 >= iter_8_1.level and arg_8_0:_getUnlockItem(iter_8_0) or arg_8_0:_getLockItem(iter_8_0)

			var_8_2.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_2.txt.gameObject, SkillDescComp)

			var_8_2.skillDesc:updateInfo(var_8_2.txt, iter_8_1.desc, arg_8_1.heroId)
			var_8_2.skillDesc:setTipParam(0, Vector2(380, 100))
			gohelper.setSibling(var_8_2.go, iter_8_0)
		end

		for iter_8_2, iter_8_3 in pairs(arg_8_0._unlockInfoItems) do
			gohelper.setActive(iter_8_3.go, iter_8_2 <= var_8_0)
		end

		for iter_8_4, iter_8_5 in pairs(arg_8_0._lockInfoItems) do
			gohelper.setActive(iter_8_5.go, var_8_0 < iter_8_4 and iter_8_4 <= #var_8_1)
		end
	end
end

function var_0_0._getUnlockItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._unlockInfoItems[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()

		local var_9_1 = gohelper.cloneInPlace(arg_9_0._gounlock, "unlock" .. arg_9_1)

		var_9_0.go = var_9_1
		var_9_0.txt = gohelper.findChildText(var_9_1, "#txt_desc")
		arg_9_0._unlockInfoItems[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0._getLockItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._lockInfoItems[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()

		local var_10_1 = gohelper.cloneInPlace(arg_10_0._gounlocktip, "lock" .. arg_10_1)

		var_10_0.go = var_10_1
		var_10_0.txt = gohelper.findChildText(var_10_1, "#txt_unlocktips")
		arg_10_0._lockInfoItems[arg_10_1] = var_10_0
	end

	return var_10_0
end

return var_0_0
