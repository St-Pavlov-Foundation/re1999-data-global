module("modules.logic.versionactivity1_4.puzzle.view.OptionItem", package.seeall)

slot0 = class("OptionItem", LuaCompBase)
slot1 = {
	-45,
	-37,
	-27,
	-17,
	-5,
	13,
	21
}

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.transform = slot1.transform
	slot0.transParent = slot1.transform.parent
	slot0.imageIcon = gohelper.findChildImage(slot1, "img_ItemIcon")
	slot0._uiclick = SLFramework.UGUI.UIClickListener.Get(slot0.go)

	slot0._uiclick:AddClickListener(slot0._btnclickOnClick, slot0)

	slot0._uidrag = SLFramework.UGUI.UIDragListener.Get(slot0.go)

	slot0._uidrag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._uidrag:AddDragListener(slot0._onDrag, slot0)
	slot0._uidrag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0.anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0.imageyy = gohelper.findChildImage(slot0.go, "img_ItemIcon_yy")
	slot0.goWrong = gohelper.findChild(slot1, "go_Wrong")
	slot0.txtNum = gohelper.findChildText(slot1, "txt_Num")
	slot0.isDrag = false
	slot0.operList = Role37PuzzleModel.instance:getOperList()
	slot0.maxOper = Role37PuzzleModel.instance:getMaxOper()
end

function slot0.onDestroy(slot0)
	slot0._uiclick:RemoveClickListener()
	slot0._uidrag:RemoveDragBeginListener()
	slot0._uidrag:RemoveDragListener()
	slot0._uidrag:RemoveDragEndListener()
end

function slot0.initParam(slot0, slot1, slot2, slot3, slot4)
	slot0.isFinal = slot4
	slot0.viewRootGO = slot3
	slot0.viewRootTrans = slot3.transform
	slot0.frameItemList = slot2

	slot0:updateIndex(slot1)
	slot0:refreshSprite()
	slot0:calculateDefalutPos()
	slot0:_setDefalutPos(false)

	slot0.frameWidth = recthelper.getWidth(slot2[1].go.transform)
	slot0.frameHeight = recthelper.getHeight(slot2[1].go.transform)

	gohelper.setActive(slot0.txtNum, true)
end

function slot0.refreshSprite(slot0)
	slot1 = slot0.operList[slot0._index]

	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0.imageIcon, Role37PuzzleModel.instance:getShapeImage(slot1))
	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0.imageyy, Role37PuzzleModel.instance:getShapeImage(slot1) .. "_yy")

	if slot0.isFinal then
		slot2 = uv0[slot1]

		recthelper.setAnchorY(slot0.imageIcon.transform, slot2)
		recthelper.setAnchorY(slot0.imageyy.transform, slot2)
	end
end

function slot0.updateIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.calculateDefalutPos(slot0)
	slot0.defalutPos = recthelper.rectToRelativeAnchorPos(slot0.frameItemList[slot0._index].go.transform.position, slot0.transParent)
end

function slot0._btnclickOnClick(slot0)
	if slot0._isDrag then
		return
	end

	Role37PuzzleModel.instance:removeOption(slot0._index)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isDrag = true

	slot0.anim:Play("in", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_drag)
	gohelper.addChildPosStay(slot0.viewRootGO, slot0.go)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0.viewRootTrans)

	recthelper.setAnchor(slot0.transform, slot3.x, slot3.y)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._isDrag = false
	slot7 = 0

	slot0.anim:Play("put", 0, slot7)
	ZProj.TweenHelper.KillByObj(slot0.go)

	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0.viewRootTrans)

	for slot7 = 1, slot0.maxOper do
		slot9 = recthelper.rectToRelativeAnchorPos(slot0.frameItemList[slot7].go.transform.position, slot0.viewRootTrans)

		if math.abs(slot9.x - slot3.x) < slot0.frameWidth / 2 and math.abs(slot9.y - slot3.y) < slot0.frameHeight / 2 then
			gohelper.addChildPosStay(slot0.transParent.gameObject, slot0.go)

			if slot7 == slot0._index then
				slot0:_setDefalutPos(true)
			else
				Role37PuzzleModel.instance:exchangeOption(slot0._index, slot7)
			end

			slot0:_playEndAduio()

			return
		end
	end

	Role37PuzzleModel.instance:removeOption(slot0._index)
end

function slot0._setDefalutPos(slot0, slot1)
	if slot1 then
		ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.defalutPos.x, slot0.defalutPos.y, 0.2)
	else
		recthelper.setAnchor(slot0.transform, slot0.defalutPos.x, slot0.defalutPos.y)
	end
end

function slot0.setError(slot0, slot1)
	if slot0.goWrong then
		gohelper.setActive(slot0.goWrong, slot1)
	end
end

function slot0.setNum(slot0, slot1)
	if slot0.txtNum then
		slot0.txtNum.text = slot1 < 10 and "0" .. slot1 or slot1
	end
end

function slot0._playEndAduio(slot0)
	if Activity130Model.instance:getCurEpisodeId() == 7 then
		AudioEffectMgr.instance:playAudio(Role37PuzzleModel.instance:getOperAudioId(slot0.operList[slot0._index]))
	else
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_put)
	end
end

return slot0
