module("modules.logic.fight.view.magiccircle.FightMagicCircleNormal", package.seeall)

local var_0_0 = class("FightMagicCircleNormal", FightMagicCircleBaseItem)

function var_0_0.initView(arg_1_0)
	arg_1_0._text = gohelper.findChildText(arg_1_0.go, "#txt_task")
	arg_1_0._red = gohelper.findChild(arg_1_0.go, "#txt_task/red")
	arg_1_0._blue = gohelper.findChild(arg_1_0.go, "#txt_task/blue")
	arg_1_0._red_round_num = gohelper.findChildText(arg_1_0.go, "#txt_task/red/#txt_num")
	arg_1_0._blue_round_num = gohelper.findChildText(arg_1_0.go, "#txt_task/blue/#txt_num")
	arg_1_0._redUpdate = gohelper.findChild(arg_1_0.go, "update_red")
	arg_1_0._blueUpdate = gohelper.findChild(arg_1_0.go, "update_blue")
	arg_1_0._textTr = arg_1_0._text.transform
	arg_1_0._click = gohelper.getClickWithDefaultAudio(arg_1_0.go)

	arg_1_0._click:AddClickListener(arg_1_0.onClickSelf, arg_1_0)
end

function var_0_0.onClickSelf(arg_2_0)
	local var_2_0 = arg_2_0._text.preferredHeight
	local var_2_1 = arg_2_0._textTr.position

	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, var_2_0, var_2_1)
end

function var_0_0.onCreateMagic(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.onCreateMagic(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:playAnim("open")
end

function var_0_0.refreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._text.text = arg_4_2.name

	local var_4_0 = FightHelper.getMagicSide(arg_4_1.createUid)

	gohelper.setActive(arg_4_0._red, var_4_0 == FightEnum.EntitySide.EnemySide)
	gohelper.setActive(arg_4_0._blue, var_4_0 == FightEnum.EntitySide.MySide)

	local var_4_1 = var_4_0 == FightEnum.EntitySide.MySide and "#547ca6" or "#9f4f4f"

	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._text, var_4_1)

	local var_4_2 = arg_4_1.round == -1 and "∞" or arg_4_1.round

	arg_4_0._red_round_num.text = var_4_2
	arg_4_0._blue_round_num.text = var_4_2

	if var_4_0 == FightEnum.EntitySide.MySide then
		gohelper.setActive(arg_4_0._blueUpdate, false)
		gohelper.setActive(arg_4_0._blueUpdate, true)
	else
		gohelper.setActive(arg_4_0._redUpdate, false)
		gohelper.setActive(arg_4_0._redUpdate, true)
	end
end

function var_0_0.destroy(arg_5_0)
	if arg_5_0._click then
		arg_5_0._click:RemoveClickListener()
	end

	var_0_0.super.destroy(arg_5_0)
end

return var_0_0
