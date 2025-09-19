module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTargetResultItem", package.seeall)

local var_0_0 = class("MoLiDeErTargetResultItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "#txt_Target")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_Target/#img_Icon")
	arg_1_0._goIconFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#img_Icon/#Star_ani")
	arg_1_0._goTitleFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#saoguang")
	arg_1_0._goIconFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#img_Icon/#Star_ani")
	arg_1_0._goTitleFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#saoguang")
	arg_1_0._goTitleFailFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#go_TargetFinished")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.refreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = string.splitToNumber(arg_5_2, "#")
	local var_5_1 = var_5_0[1]
	local var_5_2 = arg_5_4:getTargetProgress(arg_5_3)
	local var_5_3
	local var_5_4

	if var_5_1 == MoLiDeErEnum.TargetType.RoundFinishAll or var_5_1 == MoLiDeErEnum.TargetType.RoundFinishAny then
		var_5_4 = MoLiDeErHelper.getRealRound(var_5_0[2], arg_5_3 == MoLiDeErEnum.TargetId.Main)
		var_5_3 = GameUtil.getSubPlaceholderLuaLang(arg_5_1, {
			var_5_4
		})
	else
		var_5_3 = arg_5_1
	end

	arg_5_0._txtTarget.text = MoLiDeErHelper.getTargetTitleByProgress(var_5_2, var_5_3)

	arg_5_0:refreshState(arg_5_3, arg_5_4, var_5_4, arg_5_5)
end

function var_0_0.refreshState(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_2:getTargetProgress(arg_6_1)
	local var_6_1 = MoLiDeErHelper.getTargetState(var_6_0)

	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_6_0._imageIcon, string.format("v2a8_molideer_game_targeticon_0%s_%s", arg_6_1, var_6_1))

	local var_6_2 = var_6_1 == MoLiDeErEnum.ProgressChangeType.Success

	gohelper.setActive(arg_6_0._goTitleFx, arg_6_4 and var_6_2)
	gohelper.setActive(arg_6_0._goIconFx, arg_6_4 and var_6_2)

	if var_6_2 and arg_6_4 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_gudu_input_right)
	end

	gohelper.setActive(arg_6_0._goTitleFailFx, arg_6_4 and not var_6_2)
end

function var_0_0.setActive(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.viewGO, arg_7_1)
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
