module("modules.logic.toughbattle.view.ToughBattleRoleItem", package.seeall)

local var_0_0 = class("ToughBattleRoleItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._imgrole = gohelper.findChildImage(arg_1_1, "#simage_rolehead")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.initData(arg_4_0, arg_4_1)
	arg_4_0._isNew = arg_4_1.isNewGet
	arg_4_0._co = arg_4_1.co

	if arg_4_0._co and not arg_4_0._isNew then
		UISpriteSetMgr.instance:setToughBattleRoleSprite(arg_4_0._imgrole, "roleheadpic0" .. arg_4_0._co.sort)
	else
		UISpriteSetMgr.instance:setToughBattleRoleSprite(arg_4_0._imgrole, "roleheadempty")
	end
end

function var_0_0.playFirstAnim(arg_5_0)
	if arg_5_0._isNew then
		arg_5_0._anim:Play("get", 0, 0)
		TaskDispatcher.runDelay(arg_5_0._delaySetIcon, arg_5_0, 0.3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_gather)
	else
		arg_5_0._anim:Play("idle")
	end
end

function var_0_0._delaySetIcon(arg_6_0)
	UISpriteSetMgr.instance:setToughBattleRoleSprite(arg_6_0._imgrole, "roleheadpic0" .. arg_6_0._co.sort)
end

function var_0_0.setClickCallBack(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._clickCallBack = arg_7_1
	arg_7_0._callobj = arg_7_2
end

function var_0_0._onClick(arg_8_0)
	if not arg_8_0._co then
		GameFacade.showToast(ToastEnum.ToughBattleClickEmptyHero)

		return
	end

	if arg_8_0._clickCallBack then
		arg_8_0._clickCallBack(arg_8_0._callobj, arg_8_0._co)
	end
end

function var_0_0.setSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1 and arg_9_1 == arg_9_0._co)
end

function var_0_0.onDestroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delaySetIcon, arg_10_0)

	arg_10_0._clickCallBack = nil
	arg_10_0._callobj = nil
end

return var_0_0
