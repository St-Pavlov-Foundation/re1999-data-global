module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTipItem", package.seeall)

local var_0_0 = class("MoLiDeErTipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#txt_Tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._animator = gohelper.findChildComponent(arg_2_0.viewGO, "", gohelper.Type_Animator)
end

function var_0_0.setMsg(arg_3_0, arg_3_1)
	arg_3_0._txtTips.text = arg_3_1
end

function var_0_0.appearAnimation(arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.onAnimTimeEnd, arg_4_0, MoLiDeErEnum.DelayTime.TipHide)
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.viewGO, arg_5_1)
end

function var_0_0.onAnimTimeEnd(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onAnimTimeEnd, arg_6_0)
	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameTipRecycle, arg_6_0)
end

function var_0_0.reset(arg_7_0)
	arg_7_0:setActive(false)
	TaskDispatcher.cancelTask(arg_7_0.onAnimTimeEnd, arg_7_0)
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0, arg_8_0.onAnimTimeEnd)
end

return var_0_0
