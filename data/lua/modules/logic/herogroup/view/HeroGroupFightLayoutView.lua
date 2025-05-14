module("modules.logic.herogroup.view.HeroGroupFightLayoutView", package.seeall)

local var_0_0 = class("HeroGroupFightLayoutView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.DefaultOffsetX = -130

function var_0_0.checkNeedSetOffset(arg_4_0)
	return false
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goHeroGroupContain = gohelper.findChild(arg_5_0.viewGO, "herogroupcontain")
	arg_5_0.heroGroupContainRectTr = arg_5_0.goHeroGroupContain:GetComponent(gohelper.Type_RectTransform)
	arg_5_0.containerAnimator = arg_5_0.goHeroGroupContain:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.heroItemList = {}

	for iter_5_0 = 1, 4 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.bgRectTr = gohelper.findChildComponent(arg_5_0.viewGO, "herogroupcontain/hero/bg" .. iter_5_0, gohelper.Type_RectTransform)
		var_5_0.posGoTr = gohelper.findChildComponent(arg_5_0.viewGO, "herogroupcontain/area/pos" .. iter_5_0, gohelper.Type_RectTransform)
		var_5_0.bgX = recthelper.getAnchorX(var_5_0.bgRectTr)
		var_5_0.posX = recthelper.getAnchorX(var_5_0.posGoTr)

		table.insert(arg_5_0.heroItemList, var_5_0)
	end

	arg_5_0.replayFrameRectTr = gohelper.findChildComponent(arg_5_0.viewGO, "#go_container/#go_replayready/#simage_replayframe", gohelper.Type_RectTransform)
	arg_5_0.replayFrameWidth = recthelper.getWidth(arg_5_0.replayFrameRectTr)
	arg_5_0.replayFrameX = recthelper.getAnchorX(arg_5_0.replayFrameRectTr)
	arg_5_0.tipRectTr = gohelper.findChildComponent(arg_5_0.viewGO, "#go_container/#go_replayready/tip", gohelper.Type_RectTransform)
	arg_5_0.tipX = recthelper.getAnchorX(arg_5_0.tipRectTr)

	arg_5_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnCreateHeroItemDone, arg_5_0.onCreateHeroItemDone, arg_5_0)
end

function var_0_0.onCreateHeroItemDone(arg_6_0)
	for iter_6_0 = 1, 4 do
		arg_6_0.heroItemList[iter_6_0].heroItemRectTr = gohelper.findChildComponent(arg_6_0.goHeroGroupContain, "hero/item" .. iter_6_0, gohelper.Type_RectTransform)
	end

	arg_6_0:setUIPos()
end

function var_0_0.setUIPos(arg_7_0)
	if not arg_7_0:checkNeedSetOffset() then
		return
	end

	arg_7_0.containerAnimator.enabled = false

	for iter_7_0 = 1, 4 do
		local var_7_0 = arg_7_0.heroItemList[iter_7_0]

		recthelper.setAnchorX(var_7_0.bgRectTr, var_7_0.bgX + var_0_0.DefaultOffsetX)
		recthelper.setAnchorX(var_7_0.posGoTr, var_7_0.posX + var_0_0.DefaultOffsetX)

		local var_7_1 = var_7_0.heroItemRectTr

		if not gohelper.isNil(var_7_1) then
			local var_7_2 = recthelper.rectToRelativeAnchorPos(var_7_0.posGoTr.position, arg_7_0.heroGroupContainRectTr)

			recthelper.setAnchor(var_7_1, var_7_2.x, var_7_2.y)
		end
	end

	recthelper.setWidth(arg_7_0.replayFrameRectTr, 1340)
	recthelper.setAnchorX(arg_7_0.replayFrameRectTr, -60)
	recthelper.setAnchorX(arg_7_0.tipRectTr, -630)
end

function var_0_0.resetUIPos(arg_8_0)
	for iter_8_0 = 1, 4 do
		local var_8_0 = arg_8_0.heroItemList[iter_8_0]

		recthelper.setAnchorX(var_8_0.bgRectTr, var_8_0.bgX)
		recthelper.setAnchorX(var_8_0.posGoTr, var_8_0.posX)

		local var_8_1 = var_8_0.heroItemRectTr

		if not gohelper.isNil(var_8_1) then
			local var_8_2 = recthelper.rectToRelativeAnchorPos(var_8_0.posGoTr.position, arg_8_0.heroGroupContainRectTr)

			recthelper.setAnchor(var_8_1, var_8_2.x, var_8_2.y)
		end
	end

	recthelper.setWidth(arg_8_0.replayFrameRectTr, arg_8_0.replayFrameWidth)
	recthelper.setAnchorX(arg_8_0.replayFrameRectTr, arg_8_0.replayFrameX)
	recthelper.setAnchorX(arg_8_0.tipRectTr, arg_8_0.tipX)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
