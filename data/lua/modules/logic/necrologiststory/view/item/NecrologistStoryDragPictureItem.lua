module("modules.logic.necrologiststory.view.item.NecrologistStoryDragPictureItem", package.seeall)

local var_0_0 = class("NecrologistStoryDragPictureItem", NecrologistStoryControlItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.goRoot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0.rootTrs = arg_1_0.goRoot.transform
	arg_1_0.goDrag = gohelper.findChild(arg_1_0.viewGO, "root/go_drag")
	arg_1_0.srcPosX, arg_1_0.srcPosY = recthelper.getAnchor(arg_1_0.goDrag.transform)
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "root/go_drag/#select")
	arg_1_0.imgGlow = gohelper.findChildImage(arg_1_0.viewGO, "root/go_drag/#select/glow")
	arg_1_0.imgLight = gohelper.findChildImage(arg_1_0.viewGO, "root/go_drag/#select/light")

	gohelper.setActive(arg_1_0.goSelect, false)
	arg_1_0:addDrag(arg_1_0.goDrag)

	arg_1_0.maskableGraphicList = {}

	local var_1_0 = arg_1_0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.MaskableGraphic), true)

	for iter_1_0 = 0, var_1_0.Length - 1 do
		local var_1_1 = var_1_0[iter_1_0]

		table.insert(arg_1_0.maskableGraphicList, var_1_1)
	end

	arg_1_0.simageNormal = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/go_drag/normal")
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.addDrag(arg_4_0, arg_4_1)
	if arg_4_0._drag then
		return
	end

	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_1)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onBeginDrag, arg_4_0, arg_4_1.transform)
	arg_4_0._drag:AddDragListener(arg_4_0._onDrag, arg_4_0, arg_4_1.transform)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onEndDrag, arg_4_0, arg_4_1.transform)
end

function var_0_0.setDragEnabled(arg_5_0, arg_5_1)
	if arg_5_0._drag then
		arg_5_0._drag.enabled = arg_5_1
	end

	if arg_5_0.storyView then
		arg_5_0.storyView:onDragPicEnable(arg_5_1)
	end
end

function var_0_0.setMaskable(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.maskableGraphicList) do
		iter_6_1.maskable = arg_6_1
	end
end

function var_0_0.onPlayStory(arg_7_0)
	arg_7_0._isFinish = false

	local var_7_0 = arg_7_0._controlParam

	arg_7_0.simageNormal:LoadImage(ResUrl.getNecrologistStoryPicBg(var_7_0), arg_7_0.onSimageNormalLoaded, arg_7_0)
	arg_7_0:setDragEnabled(true)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.StartDragPic)
end

function var_0_0.onSimageNormalLoaded(arg_8_0)
	ZProj.UGUIHelper.SetImageSize(arg_8_0.simageNormal.gameObject)
end

function var_0_0._tweenToPos(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_9_0.posTweenId)

		arg_9_0.posTweenId = nil
	end

	local var_9_0, var_9_1 = recthelper.getAnchor(arg_9_1)

	if math.abs(var_9_0 - arg_9_2.x) > 5 or math.abs(var_9_1 - arg_9_2.y) > 5 then
		arg_9_0.posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_9_1, arg_9_2.x, arg_9_2.y, 0.05)
	else
		recthelper.setAnchor(arg_9_1, arg_9_2.x, arg_9_2.y)
	end
end

function var_0_0._onBeginDrag(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:canDrag() then
		arg_10_0.inDrag = false

		return
	end

	local var_10_0 = recthelper.screenPosToAnchorPos(arg_10_2.position, arg_10_0.rootTrs)

	arg_10_0:_tweenToPos(arg_10_1, var_10_0)

	arg_10_0.inDrag = true

	arg_10_0:setMaskable(false)
	gohelper.setActive(arg_10_0.goSelect, true)
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0:canDrag() then
		arg_11_0.inDrag = false

		return
	end

	local var_11_0 = arg_11_2.position
	local var_11_1 = recthelper.screenPosToAnchorPos(var_11_0, arg_11_0.rootTrs)

	arg_11_0:_tweenToPos(arg_11_1, var_11_1)

	arg_11_0.inDrag = true
end

function var_0_0._onEndDrag(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.inDrag = false

	if not arg_12_0:canDrag() then
		return
	end

	gohelper.setActive(arg_12_0.goSelect, false)
	arg_12_0:killTweenId()

	if arg_12_0:checkIsFinish(arg_12_1) then
		arg_12_0:onDragFinish()
	else
		arg_12_0:setMaskable(true)
		arg_12_0:_tweenToPos(arg_12_1, Vector2(arg_12_0.srcPosX, arg_12_0.srcPosY))
	end
end

function var_0_0.onDragFinish(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_leimi_celebrity_get)
	arg_13_0:setDragEnabled(false)
	arg_13_0.anim:Play("finish", 0, 0)
	TaskDispatcher.runDelay(arg_13_0._delayDeleteItem, arg_13_0, 0.8)
end

function var_0_0._delayDeleteItem(arg_14_0)
	arg_14_0._isFinish = true

	arg_14_0.storyView:delItem(arg_14_0)
end

function var_0_0.canDrag(arg_15_0)
	return not arg_15_0._isFinish
end

function var_0_0.checkIsFinish(arg_16_0, arg_16_1)
	return arg_16_0.storyView:isInLeftArea(arg_16_1)
end

function var_0_0.isDone(arg_17_0)
	return arg_17_0._isFinish
end

function var_0_0.caleHeight(arg_18_0)
	return 400
end

function var_0_0.killTweenId(arg_19_0)
	if arg_19_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_19_0.moveTweenId)

		arg_19_0.moveTweenId = nil
	end

	if arg_19_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_19_0.posTweenId)

		arg_19_0.posTweenId = nil
	end
end

function var_0_0.onDestroy(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._delayDeleteItem, arg_20_0)
	arg_20_0:killTweenId()

	if arg_20_0._drag then
		arg_20_0._drag:RemoveDragBeginListener()
		arg_20_0._drag:RemoveDragListener()
		arg_20_0._drag:RemoveDragEndListener()
	end

	arg_20_0.simageNormal:UnLoadImage()
end

function var_0_0.getResPath()
	return "ui/viewres/dungeon/rolestory/necrologiststorydragpictureitem.prefab"
end

return var_0_0
