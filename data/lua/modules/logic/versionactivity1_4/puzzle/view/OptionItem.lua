module("modules.logic.versionactivity1_4.puzzle.view.OptionItem", package.seeall)

local var_0_0 = class("OptionItem", LuaCompBase)
local var_0_1 = {
	-45,
	-37,
	-27,
	-17,
	-5,
	13,
	21
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.transParent = arg_1_1.transform.parent
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_1, "img_ItemIcon")
	arg_1_0._uiclick = SLFramework.UGUI.UIClickListener.Get(arg_1_0.go)

	arg_1_0._uiclick:AddClickListener(arg_1_0._btnclickOnClick, arg_1_0)

	arg_1_0._uidrag = SLFramework.UGUI.UIDragListener.Get(arg_1_0.go)

	arg_1_0._uidrag:AddDragBeginListener(arg_1_0._onDragBegin, arg_1_0)
	arg_1_0._uidrag:AddDragListener(arg_1_0._onDrag, arg_1_0)
	arg_1_0._uidrag:AddDragEndListener(arg_1_0._onDragEnd, arg_1_0)

	arg_1_0.anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.imageyy = gohelper.findChildImage(arg_1_0.go, "img_ItemIcon_yy")
	arg_1_0.goWrong = gohelper.findChild(arg_1_1, "go_Wrong")
	arg_1_0.txtNum = gohelper.findChildText(arg_1_1, "txt_Num")
	arg_1_0.isDrag = false
	arg_1_0.operList = Role37PuzzleModel.instance:getOperList()
	arg_1_0.maxOper = Role37PuzzleModel.instance:getMaxOper()
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0._uiclick:RemoveClickListener()
	arg_2_0._uidrag:RemoveDragBeginListener()
	arg_2_0._uidrag:RemoveDragListener()
	arg_2_0._uidrag:RemoveDragEndListener()
end

function var_0_0.initParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.isFinal = arg_3_4
	arg_3_0.viewRootGO = arg_3_3
	arg_3_0.viewRootTrans = arg_3_3.transform
	arg_3_0.frameItemList = arg_3_2

	arg_3_0:updateIndex(arg_3_1)
	arg_3_0:refreshSprite()
	arg_3_0:calculateDefalutPos()
	arg_3_0:_setDefalutPos(false)

	arg_3_0.frameWidth = recthelper.getWidth(arg_3_2[1].go.transform)
	arg_3_0.frameHeight = recthelper.getHeight(arg_3_2[1].go.transform)

	gohelper.setActive(arg_3_0.txtNum, true)
end

function var_0_0.refreshSprite(arg_4_0)
	local var_4_0 = arg_4_0.operList[arg_4_0._index]

	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_4_0.imageIcon, Role37PuzzleModel.instance:getShapeImage(var_4_0))
	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_4_0.imageyy, Role37PuzzleModel.instance:getShapeImage(var_4_0) .. "_yy")

	if arg_4_0.isFinal then
		local var_4_1 = var_0_1[var_4_0]

		recthelper.setAnchorY(arg_4_0.imageIcon.transform, var_4_1)
		recthelper.setAnchorY(arg_4_0.imageyy.transform, var_4_1)
	end
end

function var_0_0.updateIndex(arg_5_0, arg_5_1)
	arg_5_0._index = arg_5_1
end

function var_0_0.calculateDefalutPos(arg_6_0)
	local var_6_0 = arg_6_0.frameItemList[arg_6_0._index].go

	arg_6_0.defalutPos = recthelper.rectToRelativeAnchorPos(var_6_0.transform.position, arg_6_0.transParent)
end

function var_0_0._btnclickOnClick(arg_7_0)
	if arg_7_0._isDrag then
		return
	end

	Role37PuzzleModel.instance:removeOption(arg_7_0._index)
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._isDrag = true

	arg_8_0.anim:Play("in", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_drag)
	gohelper.addChildPosStay(arg_8_0.viewRootGO, arg_8_0.go)
end

function var_0_0._onDrag(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = recthelper.screenPosToAnchorPos(arg_9_2.position, arg_9_0.viewRootTrans)

	recthelper.setAnchor(arg_9_0.transform, var_9_0.x, var_9_0.y)
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._isDrag = false

	arg_10_0.anim:Play("put", 0, 0)
	ZProj.TweenHelper.KillByObj(arg_10_0.go)

	local var_10_0 = recthelper.screenPosToAnchorPos(arg_10_2.position, arg_10_0.viewRootTrans)

	for iter_10_0 = 1, arg_10_0.maxOper do
		local var_10_1 = arg_10_0.frameItemList[iter_10_0].go
		local var_10_2 = recthelper.rectToRelativeAnchorPos(var_10_1.transform.position, arg_10_0.viewRootTrans)
		local var_10_3 = math.abs(var_10_2.x - var_10_0.x)
		local var_10_4 = math.abs(var_10_2.y - var_10_0.y)

		if var_10_3 < arg_10_0.frameWidth / 2 and var_10_4 < arg_10_0.frameHeight / 2 then
			gohelper.addChildPosStay(arg_10_0.transParent.gameObject, arg_10_0.go)

			if iter_10_0 == arg_10_0._index then
				arg_10_0:_setDefalutPos(true)
			else
				Role37PuzzleModel.instance:exchangeOption(arg_10_0._index, iter_10_0)
			end

			arg_10_0:_playEndAduio()

			return
		end
	end

	Role37PuzzleModel.instance:removeOption(arg_10_0._index)
end

function var_0_0._setDefalutPos(arg_11_0, arg_11_1)
	if arg_11_1 then
		ZProj.TweenHelper.DOAnchorPos(arg_11_0.transform, arg_11_0.defalutPos.x, arg_11_0.defalutPos.y, 0.2)
	else
		recthelper.setAnchor(arg_11_0.transform, arg_11_0.defalutPos.x, arg_11_0.defalutPos.y)
	end
end

function var_0_0.setError(arg_12_0, arg_12_1)
	if arg_12_0.goWrong then
		gohelper.setActive(arg_12_0.goWrong, arg_12_1)
	end
end

function var_0_0.setNum(arg_13_0, arg_13_1)
	if arg_13_0.txtNum then
		arg_13_0.txtNum.text = arg_13_1 < 10 and "0" .. arg_13_1 or arg_13_1
	end
end

function var_0_0._playEndAduio(arg_14_0)
	if Activity130Model.instance:getCurEpisodeId() == 7 then
		local var_14_0 = Role37PuzzleModel.instance:getOperAudioId(arg_14_0.operList[arg_14_0._index])

		AudioEffectMgr.instance:playAudio(var_14_0)
	else
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_put)
	end
end

return var_0_0
