module("modules.logic.survival.view.handbook.SurvivalHandbookNpcComp", package.seeall)

local var_0_0 = class("SurvivalHandbookNpcComp", SurvivalHandbookViewComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentView = arg_1_1
	arg_1_0.handBookType = SurvivalEnum.HandBookType.Npc
	arg_1_0.handBookDatas = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.scroll = gohelper.findChild(arg_2_1, "#scroll")
	arg_2_0.npc = gohelper.findChild(arg_2_1, "#npc")
	arg_2_0.goNpcInfoRoot = gohelper.findChild(arg_2_1, "#npc")
	arg_2_0.btnPeople = gohelper.findChildButtonWithAudio(arg_2_1, "tab/#btnPeople")
	arg_2_0.btnLaplace = gohelper.findChildButtonWithAudio(arg_2_1, "tab/#btnLaplace")
	arg_2_0.btnFoundation = gohelper.findChildButtonWithAudio(arg_2_1, "tab/#btnFoundation")
	arg_2_0.btnZeno = gohelper.findChildButtonWithAudio(arg_2_1, "tab/#btnZeno")
	arg_2_0.tabs = {}

	local var_2_0 = {
		"#btnFoundation",
		"#btnLaplace",
		"#btnZeno",
		"#btnPeople"
	}
	local var_2_1 = SurvivalEnum.HandBookNpcSubType
	local var_2_2 = {
		var_2_1.Foundation,
		var_2_1.Laplace,
		var_2_1.Zeno,
		var_2_1.People
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_3 = gohelper.findChildButtonWithAudio(arg_2_1, "tab/" .. iter_2_1)
		local var_2_4 = gohelper.findChild(var_2_3.gameObject, "#go_Selected")
		local var_2_5 = gohelper.findChild(var_2_3.gameObject, "#go_redDot")
		local var_2_6 = var_2_2[iter_2_0]
		local var_2_7 = arg_2_0:getUserDataTb_()

		var_2_7.btnClick = var_2_3
		var_2_7.go_selected = var_2_4
		var_2_7.subType = var_2_6

		table.insert(arg_2_0.tabs, var_2_7)
		gohelper.setActive(var_2_4, false)
		RedDotController.instance:addRedDot(var_2_5, RedDotEnum.DotNode.SurvivalHandbookNpc, var_2_6)
	end

	local var_2_8 = arg_2_0._parentView.viewContainer:getSetting().otherRes.survivalrewardinheritnpcitem

	arg_2_0._item = arg_2_0._parentView:getResInst(var_2_8, arg_2_0.go)

	recthelper.setWidth(arg_2_0._item.transform, 1250)
	gohelper.setActive(arg_2_0._item, false)

	arg_2_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.scroll, SurvivalSimpleListPart, {
		minUpdate = 6
	})

	arg_2_0._simpleList:setCellUpdateCallBack(arg_2_0._createItem, arg_2_0, SurvivalRewardInheritNpcItem, arg_2_0._item)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:selectTab(1, true)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0:selectTab(nil)
end

function var_0_0.addEventListeners(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tabs) do
		arg_5_0:addClickCb(iter_5_1.btnClick, arg_5_0.onClickTab, arg_5_0, iter_5_0)
	end
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.onClickTab(arg_8_0, arg_8_1)
	arg_8_0:selectTab(arg_8_1)
end

function var_0_0._createItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1:updateMo(arg_9_2, nil, arg_9_0.onClickItem, arg_9_0)
end

function var_0_0.onClickItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.mo

	if var_10_0.isUnlock then
		ViewMgr.instance:openView(ViewName.SurvivalHandbookInfoView, {
			handBookType = arg_10_0.handBookType,
			handBookDatas = arg_10_0.handBookDatas,
			select = arg_10_0:getIndex(var_10_0)
		})
	end
end

function var_0_0.refreshList(arg_11_0, arg_11_1)
	if arg_11_0.curSelect == nil then
		arg_11_0._simpleList:setList({})

		return
	end

	tabletool.clear(arg_11_0.handBookDatas)

	local var_11_0 = SurvivalHandbookModel.instance:getHandBookDatas(arg_11_0.handBookType, arg_11_0.tabs[arg_11_0.curSelect].subType)

	table.sort(var_11_0, SurvivalHandbookModel.instance.handBookSortFunc)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.isUnlock then
			table.insert(arg_11_0.handBookDatas, iter_11_1)
		end
	end

	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = 5

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_4 = {
			survivalHandbookMo = iter_11_3
		}

		table.insert(var_11_2, var_11_4)

		if iter_11_2 % var_11_3 == 0 or iter_11_2 == #var_11_0 then
			local var_11_5 = iter_11_2 ~= #var_11_0
			local var_11_6 = {
				viewContainer = arg_11_0._parentView.viewContainer,
				listData = tabletool.copy(var_11_2),
				isShowLine = var_11_5
			}

			table.insert(var_11_1, var_11_6)
			tabletool.clear(var_11_2)
		end
	end

	if arg_11_1 then
		arg_11_0._simpleList:setOpenAnimation(0.03)
	end

	arg_11_0._simpleList:setList(var_11_1)
end

function var_0_0.getIndex(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.handBookDatas) do
		if arg_12_1 == iter_12_1 then
			return iter_12_0
		end
	end
end

function var_0_0.selectTab(arg_13_0, arg_13_1, arg_13_2)
	if (not arg_13_1 or not arg_13_0.curSelect or arg_13_0.curSelect ~= arg_13_1) and (not not arg_13_1 or not not arg_13_0.curSelect) then
		if arg_13_0.curSelect then
			gohelper.setActive(arg_13_0.tabs[arg_13_0.curSelect].go_selected, false)
		end

		arg_13_0.curSelect = arg_13_1

		if arg_13_0.curSelect then
			SurvivalHandbookController.instance:markNewHandbook(arg_13_0.handBookType, arg_13_0.tabs[arg_13_0.curSelect].subType)
			gohelper.setActive(arg_13_0.tabs[arg_13_0.curSelect].go_selected, true)
		end

		arg_13_0:refreshList(arg_13_2)
	end
end

return var_0_0
