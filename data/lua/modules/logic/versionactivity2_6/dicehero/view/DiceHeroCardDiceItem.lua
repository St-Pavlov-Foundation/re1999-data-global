module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroCardDiceItem", package.seeall)

local var_0_0 = class("DiceHeroCardDiceItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._icon = gohelper.findChildImage(arg_1_1, "")
	arg_1_0._txtdicenum = gohelper.findChildTextMesh(arg_1_1, "#txt_dicenum")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._canvasGroup = gohelper.onceAddComponent(arg_1_1, typeof(UnityEngine.CanvasGroup))
end

function var_0_0.addEventListeners(arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, arg_2_0.refreshUI, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, arg_3_0.refreshUI, arg_3_0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._ruleInfo = arg_4_1
	arg_4_0._cardMo = arg_4_2
	arg_4_0._index = arg_4_3

	local var_4_0 = arg_4_0._ruleInfo[1]
	local var_4_1 = arg_4_0._ruleInfo[2]

	if var_4_0 == 0 then
		var_4_0 = 8
	end

	local var_4_2 = lua_dice_suit.configDict[var_4_0]
	local var_4_3 = lua_dice_point.configDict[var_4_1]

	if var_4_2 then
		local var_4_4 = string.split(var_4_2.icon2, "#")
		local var_4_5 = arg_4_2.matchNums[1] or 0

		UISpriteSetMgr.instance:setDiceHeroSprite(arg_4_0._icon, var_4_5 < arg_4_0._index and var_4_4[2] or var_4_4[1])
	end

	if var_4_3 then
		arg_4_0._txtdicenum.text = var_4_3.txt
	end

	arg_4_0:refreshUI()
end

function var_0_0.refreshUI(arg_5_0)
	if DiceHeroFightModel.instance:getGameData().curSelectCardMo == arg_5_0._cardMo then
		local var_5_0 = arg_5_0._cardMo.curSelectUids[arg_5_0._index]

		gohelper.setActive(arg_5_0._goselect, var_5_0)

		arg_5_0._canvasGroup.alpha = var_5_0 and 1 or 0.4
	else
		gohelper.setActive(arg_5_0._goselect, false)

		arg_5_0._canvasGroup.alpha = 1
	end
end

return var_0_0
