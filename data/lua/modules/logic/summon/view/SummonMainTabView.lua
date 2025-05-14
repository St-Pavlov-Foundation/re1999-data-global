module("modules.logic.summon.view.SummonMainTabView", package.seeall)

local var_0_0 = class("SummonMainTabView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_drag")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_category")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_ui/#go_category/#scroll_category")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gosummonmaincategoryitem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/#go_summonmaincategoryitem")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._tabItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._tabItems) do
		gohelper.setActive(iter_5_1.go, true)
		iter_5_1.component:onDestroyView()
		gohelper.destroy(iter_5_1.go)
	end

	arg_5_0._tabItems = nil
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, arg_6_0._handleTabSet, arg_6_0)
	arg_6_0:addEventCb(SummonController.instance, SummonEvent.guideScrollShowEquipPool, arg_6_0._guideScrollShowEquipPool, arg_6_0)
	arg_6_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
	arg_6_0:setOpenFlag()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
end

function var_0_0._guideScrollShowEquipPool(arg_7_0)
	arg_7_0._scrollcategory.verticalNormalizedPosition = 0
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:killTween()
	SummonMainModel.instance:releaseViewData()
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = SummonMainCategoryListModel.instance:getList()
	local var_9_1 = {}
	local var_9_2 = arg_9_0:refreshTabGroupByType(var_9_0, SummonEnum.ResultType.Char, 1, var_9_1)
	local var_9_3 = arg_9_0:refreshTabGroupByType(var_9_0, SummonEnum.ResultType.Equip, var_9_2, var_9_1)

	ZProj.UGUIHelper.RebuildLayout(arg_9_0._scrollcategory.content.transform)

	for iter_9_0, iter_9_1 in pairs(arg_9_0._tabItems) do
		if not var_9_1[iter_9_1] then
			gohelper.setActive(iter_9_1.go, false)
			iter_9_1.component:cleanData()
		end
	end
end

function var_0_0.refreshTabGroupByType(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = 0
	local var_10_1 = arg_10_3

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if SummonMainModel.getResultType(iter_10_1.originConf) == arg_10_2 then
			local var_10_2 = arg_10_0:getOrCreateItem(var_10_1)

			gohelper.setActive(var_10_2.go, true)
			gohelper.setAsLastSibling(var_10_2.go)
			var_10_2.component:onUpdateMO(iter_10_1)

			arg_10_4[var_10_2] = true
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1
end

function var_0_0.setOpenFlag(arg_11_0)
	local var_11_0 = SummonMainModel.instance:getCurId()

	if var_11_0 and SummonMainModel.instance.flagModel then
		SummonMainModel.instance.flagModel:cleanFlag(var_11_0)
	end
end

function var_0_0.getOrCreateItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._tabItems[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.go = gohelper.cloneInPlace(arg_12_0._gosummonmaincategoryitem, "tabitem_" .. tostring(arg_12_1))
		var_12_0.rect = var_12_0.go.transform
		var_12_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0.go, SummonMainCategoryItem)
		var_12_0.component.viewGO = var_12_0.go

		var_12_0.component:onInitView()
		var_12_0.component:addEvents()
		var_12_0.component:customAddEvent()

		arg_12_0._tabItems[arg_12_1] = var_12_0
	end

	return var_12_0
end

var_0_0.TweenTimeCategory = 0.1

function var_0_0._handleTabSet(arg_13_0, arg_13_1)
	local var_13_0 = SummonMainModel.instance:getCurADPageIndex()

	if var_13_0 then
		local var_13_1 = arg_13_0._tabIndex == nil

		arg_13_0._tabIndex = var_13_0

		arg_13_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 3, var_13_0)
		arg_13_0:refreshUI()
		arg_13_0:scrollToCurTab(var_13_1, arg_13_1)
		logNormal(string.format("set summon pool to [%s]", SummonMainModel.instance:getCurId()))
	end
end

function var_0_0.scrollToCurTab(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = SummonMainModel.instance:getCurPool()
	local var_14_1
	local var_14_2 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0._tabItems) do
		local var_14_3 = iter_14_1.component:getData()

		if var_14_3 and var_14_3.originConf.id == var_14_0.id then
			var_14_1 = iter_14_1
			var_14_2 = iter_14_0 - 1

			break
		end
	end

	if not var_14_1 then
		return
	end

	local var_14_4 = recthelper.getHeight(arg_14_0._scrollcategory.content.transform)
	local var_14_5 = recthelper.getAnchorY(var_14_1.rect)

	if var_14_4 <= 0 then
		return
	end

	local var_14_6 = arg_14_0._scrollcategory.verticalNormalizedPosition
	local var_14_7 = 1 - var_14_2 / (#arg_14_0._tabItems - 1)

	if arg_14_1 or arg_14_2 then
		arg_14_0._scrollcategory.verticalNormalizedPosition = var_14_7
	else
		arg_14_0:killTween()

		arg_14_0._tweenIdCategory = ZProj.TweenHelper.DOTweenFloat(var_14_6, var_14_7, var_0_0.TweenTimeCategory, arg_14_0.onTweenCategory, arg_14_0.onTweenFinishCategory, arg_14_0)
	end
end

function var_0_0.onTweenCategory(arg_15_0, arg_15_1)
	if not gohelper.isNil(arg_15_0._scrollcategory) then
		arg_15_0._scrollcategory.verticalNormalizedPosition = arg_15_1
	end
end

function var_0_0.onTweenFinishCategory(arg_16_0)
	arg_16_0:killTween()
end

function var_0_0.killTween(arg_17_0)
	if arg_17_0._tweenIdCategory then
		ZProj.TweenHelper.KillById(arg_17_0._tweenIdCategory)

		arg_17_0._tweenIdCategory = nil
	end
end

return var_0_0
