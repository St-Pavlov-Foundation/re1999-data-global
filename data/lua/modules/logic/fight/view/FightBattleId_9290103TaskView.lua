module("modules.logic.fight.view.FightBattleId_9290103TaskView", package.seeall)

local var_0_0 = class("FightBattleId_9290103TaskView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._descText = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#txt_title")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "#image_star")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onConstructor(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_refreshData()
end

local var_0_1 = 6295031

function var_0_0._onBuffUpdate(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 ~= var_0_1 then
		return
	end

	arg_6_0:_refreshData()
end

var_0_0.TempEnemyList = {}

function var_0_0._refreshData(arg_7_0)
	local var_7_0 = var_0_0.TempEnemyList

	tabletool.clear(var_7_0)

	local var_7_1 = FightDataHelper.entityMgr:getEnemyNormalList(var_7_0)
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_3 = iter_7_1:getBuffDic()

		for iter_7_2, iter_7_3 in pairs(var_7_3) do
			if iter_7_3.buffId == var_0_1 then
				var_7_2 = var_7_2 + iter_7_3.layer
			end
		end
	end

	arg_7_0._descText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("battle_id_9290103_task_text"), var_7_2)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
