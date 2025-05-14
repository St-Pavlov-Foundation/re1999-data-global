module("modules.logic.character.view.CharacterTalentStatItem", package.seeall)

local var_0_0 = class("CharacterTalentStatItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "slot/#go_normal")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "slot/#image_icon")
	arg_1_0._imageglow = gohelper.findChildImage(arg_1_0.viewGO, "slot/#image_glow")
	arg_1_0._gohot = gohelper.findChild(arg_1_0.viewGO, "slot/#go_hot")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._imagepercent = gohelper.findChildImage(arg_1_0.viewGO, "#image_percent")
	arg_1_0._txtpercent = gohelper.findChildText(arg_1_0.viewGO, "#txt_percent")

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
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0:removeEvents()
end

function var_0_0.onStart(arg_8_0)
	return
end

function var_0_0.onDestroy(arg_9_0)
	return
end

function var_0_0.onRefreshMo(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = arg_10_1:getStyleTagIcon()
	local var_10_2, var_10_3 = arg_10_1:getStyleTag()

	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_10_0._imageicon, var_10_1, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_10_0._imageglow, var_10_0, true)

	arg_10_0._txtname.text = var_10_2

	local var_10_4 = arg_10_1:getUnlockPercent() * 0.01

	arg_10_0._txtpercent.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), string.format("%.1f", var_10_4))
	arg_10_0._imagepercent.fillAmount = var_10_4 * 0.01

	gohelper.setActive(arg_10_0._gohot, arg_10_1:isHotUnlock())

	local var_10_5 = arg_10_1:isHotUnlock() and 1 or 2
	local var_10_6 = CharacterTalentStyleEnum.StatType[var_10_5]

	arg_10_0._imagepercent.color = GameUtil.parseColor(var_10_6.ProgressColor)
	arg_10_0._txtpercent.color = GameUtil.parseColor(var_10_6.TxtColor)
end

return var_0_0
