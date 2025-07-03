module("modules.logic.fight.view.rightlayout.FightViewRightBottomElementsLayout", package.seeall)

local var_0_0 = class("FightViewRightBottomElementsLayout", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRightBottomRoot = gohelper.findChild(arg_1_0.viewGO, "root/right_elements/bottom")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RightBottomElements_ShowElement, arg_2_0.showElement, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RightBottomElements_HideElement, arg_2_0.hideElement, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.showElementDict = {}
	arg_4_0.elementGoDict = arg_4_0:getUserDataTb_()

	for iter_4_0, iter_4_1 in pairs(FightRightBottomElementEnum.Elements) do
		local var_4_0 = gohelper.findChild(arg_4_0.goRightBottomRoot, FightRightBottomElementEnum.ElementsNodeName[iter_4_1])

		arg_4_0.elementGoDict[iter_4_1] = var_4_0

		gohelper.setAsLastSibling(var_4_0)
		gohelper.setActive(var_4_0, false)

		local var_4_1 = var_4_0:GetComponent(gohelper.Type_RectTransform)
		local var_4_2 = FightRightBottomElementEnum.ElementsSizeDict[iter_4_1]

		recthelper.setSize(var_4_1, var_4_2.x, var_4_2.y)
	end
end

function var_0_0.getElementContainer(arg_5_0, arg_5_1)
	return arg_5_0.elementGoDict[arg_5_1]
end

function var_0_0.showElement(arg_6_0, arg_6_1)
	arg_6_0.showElementDict[arg_6_1] = true

	arg_6_0:refreshLayout()
end

function var_0_0.hideElement(arg_7_0, arg_7_1)
	arg_7_0.showElementDict[arg_7_1] = nil

	arg_7_0:refreshLayout()
end

function var_0_0.refreshLayout(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(FightRightBottomElementEnum.Priority) do
		local var_8_0 = arg_8_0.showElementDict[iter_8_1]

		gohelper.setActive(arg_8_0.elementGoDict[iter_8_1], var_8_0)

		if var_8_0 then
			gohelper.setAsFirstSibling(arg_8_0.elementGoDict[iter_8_1])
		end
	end
end

return var_0_0
