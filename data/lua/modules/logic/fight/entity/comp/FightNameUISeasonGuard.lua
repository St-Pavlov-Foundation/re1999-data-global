module("modules.logic.fight.entity.comp.FightNameUISeasonGuard", package.seeall)

local var_0_0 = class("FightNameUISeasonGuard", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._parentView = arg_1_1
	arg_1_0._entity = arg_1_0._parentView.entity
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1

	gohelper.setActive(arg_2_1, true)

	arg_2_0._shieldText = gohelper.findChildText(arg_2_1, "#txt_Shield")
	arg_2_0._aniPlayer = SLFramework.AnimatorPlayer.Get(arg_2_1)
	arg_2_0._ani = gohelper.onceAddComponent(arg_2_1, typeof(UnityEngine.Animator))

	arg_2_0:_refreshUI()
	FightController.instance:registerCallback(FightEvent.EntityGuardChange, arg_2_0._onEntityGuardChange, arg_2_0)

	arg_2_0._btnGuardTran = gohelper.findChild(arg_2_1, "btn_guard").transform
	arg_2_0._btnGuard = gohelper.findChildClick(arg_2_0.viewGO, "btn_guard")

	arg_2_0:addClickCb(arg_2_0._btnGuard, arg_2_0._onBtnGuardClick, arg_2_0)
	FightController.instance:registerCallback(FightEvent.StageChanged, arg_2_0._onStageChanged, arg_2_0)
end

function var_0_0._onBtnGuardClick(arg_3_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	local var_3_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local var_3_1, var_3_2 = recthelper.rectToRelativeAnchorPos2(arg_3_0._btnGuardTran.position, var_3_0.transform)

	FightController.instance:dispatchEvent(FightEvent.ShowSeasonGuardIntro, arg_3_0._entity.id, var_3_1, var_3_2)
end

function var_0_0._onEntityGuardChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == arg_4_0._entity.id then
		arg_4_0:_refreshUI()

		if arg_4_2 == -1 then
			arg_4_0:_playAni("shake1")
		elseif arg_4_2 < -1 then
			arg_4_0:_playAni("shake2")
		else
			arg_4_0:_refreshAni()
		end
	end
end

function var_0_0._refreshAni(arg_5_0)
	if not arg_5_0.viewGO then
		return
	end

	local var_5_0 = arg_5_0._entity:getMO()

	if not var_5_0 then
		gohelper.setActive(arg_5_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_5_0.viewGO, true)

	if var_5_0.guard == 1 then
		if arg_5_0._curAniName == "idle3" then
			arg_5_0:_playAni("idle3_out")
		else
			arg_5_0:_playIdle("idle2")
		end
	elseif var_5_0.guard > 1 then
		if arg_5_0._curAniName == "idle3" then
			arg_5_0:_playAni("idle3_out")
		else
			arg_5_0:_playIdle("idle")
		end
	elseif arg_5_0._curAniName ~= "idle3" and arg_5_0._curAniName ~= "idle3_in" then
		arg_5_0:_playAni("idle3_in")
	else
		arg_5_0:_playIdle("idle3")
	end
end

function var_0_0._playIdle(arg_6_0, arg_6_1)
	arg_6_0._curAniName = arg_6_1
	arg_6_0._ani.enabled = true

	arg_6_0._ani:Play(arg_6_1)
end

function var_0_0._playAni(arg_7_0, arg_7_1)
	arg_7_0._curAniName = arg_7_1

	arg_7_0._aniPlayer:Play(arg_7_1, arg_7_0._refreshAni, arg_7_0)
end

function var_0_0._refreshUI(arg_8_0)
	local var_8_0 = arg_8_0._entity:getMO()

	arg_8_0._shieldText.text = var_8_0.guard
end

function var_0_0._onStageChanged(arg_9_0)
	arg_9_0:_refreshAni()
end

function var_0_0.releaseSelf(arg_10_0)
	FightController.instance:unregisterCallback(FightEvent.EntityGuardChange, arg_10_0._onEntityGuardChange, arg_10_0)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, arg_10_0._onStageChanged, arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
