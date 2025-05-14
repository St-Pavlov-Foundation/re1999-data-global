module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandChessSelf", package.seeall)

local var_0_0 = class("FairyLandChessSelf", FairyLandElementBase)

function var_0_0.getElementId(arg_1_0)
	return 0
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.rootGo = gohelper.findChild(arg_2_0._go, "root")
	arg_2_0.imgChess = gohelper.findChildImage(arg_2_0.rootGo, "image_Chess")
	arg_2_0.goChess = gohelper.findChild(arg_2_0.rootGo, "image_Chess")
	arg_2_0.imgChessRoot = gohelper.findChild(arg_2_0.rootGo, "chessRoot")
	arg_2_0.animationEvent = arg_2_0.rootGo:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_2_0.animator = arg_2_0.rootGo:GetComponent(typeof(UnityEngine.Animator))

	arg_2_0.animationEvent:AddEventListener("stair", arg_2_0._onStairCallback, arg_2_0)
	arg_2_0.animationEvent:AddEventListener("finish", arg_2_0._onMoveFinishCallback, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
end

function var_0_0._onStairCallback(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_role_move)

	arg_3_0._config.pos = arg_3_0._config.pos + 1

	FairyLandController.instance:dispatchEvent(FairyLandEvent.DoStairAnim, arg_3_0._config.pos)
end

function var_0_0._onMoveFinishCallback(arg_4_0)
	arg_4_0._config.pos = FairyLandModel.instance:getStairPos()

	arg_4_0:updatePos()

	arg_4_0.animator.enabled = false

	recthelper.setAnchor(arg_4_0.goChess.transform, 0, -107)

	arg_4_0._moveing = false

	if FairyLandModel.instance:isFinishFairyLand() then
		StoryController.instance:playStory(100718, nil, FairyLandController.endFairyLandStory)
	end
end

function var_0_0._onOpenView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.StoryFrontView and FairyLandModel.instance:isFinishFairyLand() then
		ViewMgr.instance:closeView(ViewName.FairyLandView)
	end
end

function var_0_0.move(arg_6_0)
	arg_6_0.animator.enabled = true

	arg_6_0.animator:Play("click", 0, 0)

	arg_6_0._moveing = true
end

function var_0_0.isMoveing(arg_7_0)
	return arg_7_0._moveing
end

function var_0_0.onFinish(arg_8_0)
	return
end

function var_0_0.onDestroyElement(arg_9_0)
	arg_9_0.animationEvent:RemoveEventListener("stair")
	arg_9_0.animationEvent:RemoveEventListener("finish")
end

function var_0_0.getClickGO(arg_10_0)
	return arg_10_0.goChess
end

function var_0_0.playDialog(arg_11_0)
	arg_11_0.animator.enabled = true

	arg_11_0.animator:Play("jump", 0, 0)
end

return var_0_0
