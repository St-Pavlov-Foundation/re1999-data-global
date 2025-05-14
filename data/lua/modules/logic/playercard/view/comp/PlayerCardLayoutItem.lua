module("modules.logic.playercard.view.comp.PlayerCardLayoutItem", package.seeall)

local var_0_0 = class("PlayerCardLayoutItem", LuaCompBase)

var_0_0.TweenDuration = 0.16

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._param = arg_1_1
	arg_1_0.viewRoot = arg_1_1.viewRoot.transform
	arg_1_0.layout = arg_1_1.layout
	arg_1_0.cardComp = arg_1_1.cardComp
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.transform = arg_2_1.transform
	arg_2_0.goPut = gohelper.findChild(arg_2_1, "card/put")
	arg_2_0.frame = gohelper.findChild(arg_2_1, "frame")
	arg_2_0.goCard = gohelper.findChild(arg_2_1, "card")
	arg_2_0.animCard = arg_2_0.goCard:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.trsCard = arg_2_0.goCard.transform
	arg_2_0.goSelect = gohelper.findChild(arg_2_1, "card/select")
	arg_2_0.goTop = gohelper.findChild(arg_2_1, "card/top")
	arg_2_0.trsTop = arg_2_0.goTop.transform
	arg_2_0.goDown = gohelper.findChild(arg_2_1, "card/down")
	arg_2_0.trsDown = arg_2_0.goDown.transform
	arg_2_0.canvasGroup = gohelper.onceAddComponent(arg_2_0.goCard, gohelper.Type_CanvasGroup)
	arg_2_0.goBlack = gohelper.findChild(arg_2_1, "card/blackmask")
	arg_2_0.goDrag = gohelper.findChild(arg_2_1, "card/drag")

	arg_2_0:AddDrag(arg_2_0.goDrag)
	gohelper.setActive(arg_2_0.frame, false)
	gohelper.setActive(arg_2_0.goSelect, false)
end

function var_0_0.getCenterScreenPosY(arg_3_0)
	local var_3_0, var_3_1 = recthelper.uiPosToScreenPos2(arg_3_0.trsCard)

	return var_3_1
end

function var_0_0.isInArea(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = recthelper.uiPosToScreenPos2(arg_4_0.trsTop)
	local var_4_2, var_4_3 = recthelper.uiPosToScreenPos2(arg_4_0.trsDown)

	return arg_4_1 <= var_4_1 and var_4_3 <= arg_4_1
end

function var_0_0.getLayoutGO(arg_5_0)
	return arg_5_0.go
end

function var_0_0.addEventListeners(arg_6_0)
	return
end

function var_0_0.removeEventListeners(arg_7_0)
	return
end

function var_0_0.getLayoutKey(arg_8_0)
	return arg_8_0._param.layoutKey
end

function var_0_0.setLayoutIndex(arg_9_0, arg_9_1)
	arg_9_0.index = arg_9_1
end

function var_0_0.exchangeIndex(arg_10_0, arg_10_1)
	arg_10_0.index, arg_10_1.index = arg_10_1.index, arg_10_0.index
end

function var_0_0.setEditMode(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.frame, arg_11_1)
	gohelper.setActive(arg_11_0.goSelect, arg_11_1)

	if arg_11_1 then
		arg_11_0.animCard:Play("wiggle")
	end
end

function var_0_0.AddDrag(arg_12_0, arg_12_1)
	if arg_12_0._drag or gohelper.isNil(arg_12_1) then
		return
	end

	arg_12_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_12_1)

	arg_12_0._drag:AddDragBeginListener(arg_12_0._onBeginDrag, arg_12_0)
	arg_12_0._drag:AddDragListener(arg_12_0._onDrag, arg_12_0)
	arg_12_0._drag:AddDragEndListener(arg_12_0._onEndDrag, arg_12_0)
end

function var_0_0.canDrag(arg_13_0)
	return true
end

function var_0_0._onBeginDrag(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0:canDrag() then
		arg_14_0.inDrag = false

		return
	end

	if arg_14_0.inDrag then
		return
	end

	gohelper.addChildPosStay(arg_14_0.viewRoot, arg_14_0.goCard)
	gohelper.setAsLastSibling(arg_14_0.goCard)
	gohelper.setAsLastSibling(arg_14_0.go)
	arg_14_0:killTweenId()

	local var_14_0 = recthelper.screenPosToAnchorPos(arg_14_2.position, arg_14_0.viewRoot)

	arg_14_0:_tweenToPos(arg_14_0.trsCard, var_14_0)

	arg_14_0.inDrag = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)

	if arg_14_0.layout then
		arg_14_0.layout:startUpdate(arg_14_0)
	end
end

function var_0_0._onDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:canDrag() then
		arg_15_0.inDrag = false

		return
	end

	if not arg_15_0.inDrag then
		return
	end

	local var_15_0 = recthelper.screenPosToAnchorPos(arg_15_2.position, arg_15_0.viewRoot)

	arg_15_0:_tweenToPos(arg_15_0.trsCard, var_15_0)

	arg_15_0.inDrag = true
end

function var_0_0._onEndDrag(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.inDrag then
		return
	end

	arg_16_0.inDrag = false

	local var_16_0 = recthelper.rectToRelativeAnchorPos(arg_16_0.frame.transform.position, arg_16_0.viewRoot)

	UIBlockMgr.instance:startBlock("PlayerCardLayoutItem")
	arg_16_0:_tweenToPos(arg_16_0.trsCard, var_16_0, arg_16_0.onEndDragTweenCallback, arg_16_0)

	if arg_16_0.layout then
		arg_16_0.layout:closeUpdate()
	end
end

function var_0_0.onEndDragTweenCallback(arg_17_0)
	UIBlockMgr.instance:endBlock("PlayerCardLayoutItem")
	gohelper.addChildPosStay(arg_17_0.go, arg_17_0.goCard)
	gohelper.setAsLastSibling(arg_17_0.goCard)
	gohelper.setActive(arg_17_0.goPut, false)
	gohelper.setActive(arg_17_0.goPut, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._tweenToPos(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0:killTweenId()

	local var_18_0, var_18_1 = recthelper.getAnchor(arg_18_1)

	if math.abs(var_18_0 - arg_18_2.x) > 10 or math.abs(var_18_1 - arg_18_2.y) > 10 then
		arg_18_0.posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_18_1, arg_18_2.x, arg_18_2.y, var_0_0.TweenDuration, arg_18_3, arg_18_4)
	else
		recthelper.setAnchor(arg_18_1, arg_18_2.x, arg_18_2.y)

		if arg_18_3 then
			arg_18_3(arg_18_4)
		end
	end
end

function var_0_0.killTweenId(arg_19_0)
	if arg_19_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_19_0.posTweenId)

		arg_19_0.posTweenId = nil
	end
end

function var_0_0.updateAlpha(arg_20_0, arg_20_1)
	arg_20_0.canvasGroup.alpha = arg_20_1
end

function var_0_0.getHeight(arg_21_0)
	if arg_21_0.cardComp and arg_21_0.cardComp.getLayoutHeight then
		return arg_21_0.cardComp:getLayoutHeight()
	else
		return recthelper.getHeight(arg_21_0.go.transform)
	end
end

function var_0_0.onStartDrag(arg_22_0)
	arg_22_0:updateAlpha(arg_22_0.inDrag and 1 or 0.6)

	if arg_22_0.inDrag then
		arg_22_0.animCard:Play("idle")
	end

	gohelper.setActive(arg_22_0.goBlack, not arg_22_0.inDrag)
end

function var_0_0.onEndDrag(arg_23_0)
	arg_23_0:updateAlpha(1)
	arg_23_0.animCard:Play("wiggle")
	gohelper.setActive(arg_23_0.goBlack, false)
end

function var_0_0.onDestroy(arg_24_0)
	if arg_24_0._drag then
		arg_24_0._drag:RemoveDragBeginListener()
		arg_24_0._drag:RemoveDragListener()
		arg_24_0._drag:RemoveDragEndListener()
	end

	arg_24_0:killTweenId()
	UIBlockMgr.instance:endBlock("PlayerCardLayoutItem")
end

return var_0_0
