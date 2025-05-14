module("modules.logic.toughbattle.view.ToughBattleWordView", package.seeall)

local var_0_0 = class("ToughBattleWordView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._root = gohelper.findChild(arg_1_0.viewGO, "root/#go_words")
	arg_1_0._item = gohelper.findChild(arg_1_0.viewGO, "root/#go_words/item")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._wordRes = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes.word, arg_2_0._root)

	gohelper.setActive(arg_2_0._item, false)
	gohelper.setActive(arg_2_0._wordRes, false)
	TaskDispatcher.runRepeat(arg_2_0._createWord, arg_2_0, ToughBattleEnum.WordInterval, -1)
	arg_2_0:_createWord()
end

function var_0_0._createWord(arg_3_0)
	if not arg_3_0._nowPosIndex then
		arg_3_0._nowPosIndex = math.random(1, #ToughBattleEnum.WordPlace)
	else
		local var_3_0 = math.random(1, #ToughBattleEnum.WordPlace - 1)

		if var_3_0 >= arg_3_0._nowPosIndex then
			var_3_0 = var_3_0 + 1
		end

		arg_3_0._nowPosIndex = var_3_0
	end

	arg_3_0._coIndexSort = arg_3_0._coIndexSort or {}

	if arg_3_0._coIndexSort[1] then
		arg_3_0._nowCoIndex = table.remove(arg_3_0._coIndexSort, 1)
	else
		for iter_3_0 = 1, #lua_siege_battle_word.configList do
			arg_3_0._coIndexSort[iter_3_0] = iter_3_0
		end

		arg_3_0._coIndexSort = GameUtil.randomTable(arg_3_0._coIndexSort)

		if arg_3_0._nowCoIndex == arg_3_0._coIndexSort[1] then
			arg_3_0._nowCoIndex = table.remove(arg_3_0._coIndexSort, 2)
		else
			arg_3_0._nowCoIndex = table.remove(arg_3_0._coIndexSort, 1)
		end
	end

	local var_3_1 = gohelper.cloneInPlace(arg_3_0._item)

	gohelper.setActive(var_3_1, true)

	local var_3_2 = ToughBattleEnum.WordPlace[arg_3_0._nowPosIndex]

	recthelper.setAnchor(var_3_1.transform, var_3_2.x, var_3_2.y)
	MonoHelper.addNoUpdateLuaComOnceToGo(var_3_1, ToughBattleWordComp, {
		co = lua_siege_battle_word.configList[arg_3_0._nowCoIndex],
		res = arg_3_0._wordRes
	})
end

function var_0_0.onClose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._createWord, arg_4_0)
end

return var_0_0
