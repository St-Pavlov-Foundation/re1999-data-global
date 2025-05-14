module("modules.logic.explore.view.unit.ExploreUnitDialogueView", package.seeall)

local var_0_0 = class("ExploreUnitDialogueView", ExploreUnitBaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._offsetY2d = 200

	var_0_0.super.ctor(arg_1_0, arg_1_1, "ui/viewres/explore/explorebubbleview.prefab")
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.txt = gohelper.findChildTextMesh(arg_2_0.viewGO, "go_btns/tip")
	arg_2_0._anim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_3_0._onTouchScreen, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_4_0._onTouchScreen, arg_4_0)
end

function var_0_0._onTouchScreen(arg_5_0)
	if arg_5_0._tweenId then
		return
	end

	arg_5_0._anim:Play("close")
	AudioMgr.instance:trigger(AudioEnum.Explore.BubbleHide)

	arg_5_0._tweenId = ZProj.TweenHelper.DOScale(arg_5_0.viewGO.transform, 0, 0, 0, 0.5, arg_5_0.closeThis, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.txt.text = ""

	transformhelper.setLocalScale(arg_6_0.viewGO.transform, 0, 0, 0)

	arg_6_0._tweenId = ZProj.TweenHelper.DOScale(arg_6_0.viewGO.transform, 1, 1, 1, 0.5, arg_6_0.onTweenOpenEnd, arg_6_0)

	if arg_6_0._id then
		arg_6_0:setDialogueId(arg_6_0._id)
	end

	arg_6_0._anim:Play("open")
	AudioMgr.instance:trigger(AudioEnum.Explore.BubbleShow)
end

function var_0_0.onTweenOpenEnd(arg_7_0)
	arg_7_0._tweenId = nil
end

function var_0_0.setDialogueId(arg_8_0, arg_8_1)
	arg_8_0._id = arg_8_1

	if not arg_8_0.txt then
		return
	end

	local var_8_0 = lua_explore_bubble.configDict[arg_8_1].content

	arg_8_0.txt.text = var_8_0
end

function var_0_0.onDestroy(arg_9_0)
	if arg_9_0._tweenId then
		ZProj.TweenHelper.KillById(arg_9_0._tweenId)

		arg_9_0._tweenId = nil
	end

	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
