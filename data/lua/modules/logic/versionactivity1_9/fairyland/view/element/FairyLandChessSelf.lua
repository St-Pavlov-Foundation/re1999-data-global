module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandChessSelf", package.seeall)

slot0 = class("FairyLandChessSelf", FairyLandElementBase)

function slot0.getElementId(slot0)
	return 0
end

function slot0.onInitView(slot0)
	slot0.rootGo = gohelper.findChild(slot0._go, "root")
	slot0.imgChess = gohelper.findChildImage(slot0.rootGo, "image_Chess")
	slot0.goChess = gohelper.findChild(slot0.rootGo, "image_Chess")
	slot0.imgChessRoot = gohelper.findChild(slot0.rootGo, "chessRoot")
	slot0.animationEvent = slot0.rootGo:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0.animator = slot0.rootGo:GetComponent(typeof(UnityEngine.Animator))

	slot0.animationEvent:AddEventListener("stair", slot0._onStairCallback, slot0)
	slot0.animationEvent:AddEventListener("finish", slot0._onMoveFinishCallback, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0._onStairCallback(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_role_move)

	slot0._config.pos = slot0._config.pos + 1

	FairyLandController.instance:dispatchEvent(FairyLandEvent.DoStairAnim, slot0._config.pos)
end

function slot0._onMoveFinishCallback(slot0)
	slot0._config.pos = FairyLandModel.instance:getStairPos()

	slot0:updatePos()

	slot0.animator.enabled = false

	recthelper.setAnchor(slot0.goChess.transform, 0, -107)

	slot0._moveing = false

	if FairyLandModel.instance:isFinishFairyLand() then
		StoryController.instance:playStory(100718, nil, FairyLandController.endFairyLandStory)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.StoryFrontView and FairyLandModel.instance:isFinishFairyLand() then
		ViewMgr.instance:closeView(ViewName.FairyLandView)
	end
end

function slot0.move(slot0)
	slot0.animator.enabled = true

	slot0.animator:Play("click", 0, 0)

	slot0._moveing = true
end

function slot0.isMoveing(slot0)
	return slot0._moveing
end

function slot0.onFinish(slot0)
end

function slot0.onDestroyElement(slot0)
	slot0.animationEvent:RemoveEventListener("stair")
	slot0.animationEvent:RemoveEventListener("finish")
end

function slot0.getClickGO(slot0)
	return slot0.goChess
end

function slot0.playDialog(slot0)
	slot0.animator.enabled = true

	slot0.animator:Play("jump", 0, 0)
end

return slot0
