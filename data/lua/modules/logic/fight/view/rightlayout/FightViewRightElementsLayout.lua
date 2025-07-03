module("modules.logic.fight.view.rightlayout.FightViewRightElementsLayout", package.seeall)

local var_0_0 = class("FightViewRightElementsLayout", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRightRoot = gohelper.findChild(arg_1_0.viewGO, "root/right_elements/top")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RightElements_ShowElement, arg_2_0.showElement, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RightElements_HideElement, arg_2_0.hideElement, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.showElementDict = {}
	arg_4_0.preShowElementDict = {}
	arg_4_0.tempElementHeightDict = {}
	arg_4_0.tweenIdList = {}
	arg_4_0.elementGoDict = arg_4_0:getUserDataTb_()
	arg_4_0.elementRectTrDict = arg_4_0:getUserDataTb_()

	for iter_4_0, iter_4_1 in pairs(FightRightElementEnum.Elements) do
		local var_4_0 = gohelper.findChild(arg_4_0.goRightRoot, FightRightElementEnum.ElementsNodeName[iter_4_1])

		arg_4_0.elementGoDict[iter_4_1] = var_4_0
		arg_4_0.elementRectTrDict[iter_4_1] = var_4_0:GetComponent(gohelper.Type_RectTransform)

		gohelper.setAsLastSibling(var_4_0)
		gohelper.setActive(var_4_0, false)

		local var_4_1 = FightRightElementEnum.ElementsSizeDict[iter_4_1]

		recthelper.setSize(arg_4_0.elementRectTrDict[iter_4_1], var_4_1.x, var_4_1.y)
	end

	local var_4_2 = arg_4_0.goRightRoot:GetComponent(gohelper.Type_RectTransform)

	arg_4_0.maxHeight = recthelper.getHeight(var_4_2)
end

function var_0_0.getElementContainer(arg_5_0, arg_5_1)
	return arg_5_0.elementGoDict[arg_5_1]
end

function var_0_0.showElement(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.showElementDict[arg_6_1] = true
	arg_6_0.tempElementHeightDict[arg_6_1] = arg_6_2

	arg_6_0:refreshLayout()
end

function var_0_0.hideElement(arg_7_0, arg_7_1)
	arg_7_0.showElementDict[arg_7_1] = nil
	arg_7_0.tempElementHeightDict[arg_7_1] = nil

	arg_7_0:refreshLayout()
end

function var_0_0.refreshLayout(arg_8_0)
	arg_8_0:clearTweenId()

	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in ipairs(FightRightElementEnum.Priority) do
		local var_8_4 = arg_8_0.showElementDict[iter_8_1]

		if var_8_4 then
			gohelper.setActive(arg_8_0.elementGoDict[iter_8_1], true)

			local var_8_5 = arg_8_0:getElementWidth(iter_8_1)
			local var_8_6 = arg_8_0:getElementHeight(iter_8_1)

			if var_8_3 < 1 or var_8_1 + var_8_6 <= arg_8_0.maxHeight then
				if var_8_2 < var_8_5 then
					var_8_2 = var_8_5
				end
			else
				var_8_0 = var_8_0 + var_8_2
				var_8_1 = 0
				var_8_3 = 0
			end

			recthelper.setSize(arg_8_0.elementRectTrDict[iter_8_1], var_8_5, var_8_6)

			if arg_8_0.preShowElementDict[iter_8_1] then
				local var_8_7 = ZProj.TweenHelper.DOAnchorPos(arg_8_0.elementRectTrDict[iter_8_1], -var_8_0, -var_8_1, FightRightElementEnum.AnchorTweenDuration)

				table.insert(arg_8_0.tweenIdList, var_8_7)
			else
				recthelper.setAnchor(arg_8_0.elementRectTrDict[iter_8_1], -var_8_0, -var_8_1)
			end

			var_8_3 = var_8_3 + 1
			var_8_1 = var_8_1 + var_8_6

			gohelper.setAsLastSibling(arg_8_0.elementGoDict[iter_8_1])
		else
			gohelper.setActive(arg_8_0.elementGoDict[iter_8_1], false)
		end

		arg_8_0.preShowElementDict[iter_8_1] = var_8_4
	end
end

function var_0_0.getElementHeight(arg_9_0, arg_9_1)
	if arg_9_0.tempElementHeightDict[arg_9_1] then
		return arg_9_0.tempElementHeightDict[arg_9_1]
	end

	return FightRightElementEnum.ElementsSizeDict[arg_9_1].y
end

function var_0_0.getElementWidth(arg_10_0, arg_10_1)
	return FightRightElementEnum.ElementsSizeDict[arg_10_1].x
end

function var_0_0.clearTweenId(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.tweenIdList) do
		ZProj.TweenHelper.KillById(iter_11_1)
	end

	tabletool.clear(arg_11_0.tweenIdList)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0:clearTweenId()
end

return var_0_0
