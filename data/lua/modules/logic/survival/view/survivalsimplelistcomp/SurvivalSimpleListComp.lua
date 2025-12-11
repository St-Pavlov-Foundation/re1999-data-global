module("modules.logic.survival.view.survivalsimplelistcomp.SurvivalSimpleListComp", package.seeall)

local var_0_0 = class("SurvivalSimpleListComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1.listScrollParam
	arg_1_0.viewContainer = arg_1_1.viewContainer
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.scrollRect = arg_2_1:GetComponent(gohelper.Type_ScrollRect)
	arg_2_0.scrollDir = arg_2_0.scrollRect.vertical and ScrollEnum.ScrollDirV or ScrollEnum.ScrollDirH
	arg_2_0.content = arg_2_0.scrollRect.content
	arg_2_0.csListScroll = SLFramework.UGUI.ListScrollView.Get(arg_2_1)

	arg_2_0.csListScroll:Init(arg_2_0.scrollDir, arg_2_0.param.lineCount, arg_2_0.param.cellWidth, arg_2_0.param.cellHeight, arg_2_0.param.cellSpaceH, arg_2_0.param.cellSpaceV, arg_2_0.param.startSpace, arg_2_0.param.endSpace, arg_2_0.param.sortMode, arg_2_0.param.frameUpdateMs, arg_2_0.param.minUpdateCountInFrame, arg_2_0.onUpdateCell, nil, nil, arg_2_0)

	if arg_2_0.param.cloneRef then
		gohelper.setActive(arg_2_0.param.cloneRef, false)
	end
end

function var_0_0.setRes(arg_3_0, arg_3_1)
	arg_3_0.res = arg_3_1
end

function var_0_0.setList(arg_4_0, arg_4_1)
	arg_4_0.items = {}
	arg_4_0.datas = arg_4_1

	arg_4_0.csListScroll:UpdateTotalCount(#arg_4_1)
end

function var_0_0.onUpdateCell(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 + 1

	local var_5_0 = gohelper.findChild(arg_5_1, "instGo")
	local var_5_1

	if not var_5_0 then
		if type(arg_5_0.res) == "string" then
			var_5_0 = arg_5_0.viewContainer:getResInst(arg_5_0.res, arg_5_1, "instGo")
		else
			var_5_0 = gohelper.clone(arg_5_0.res, arg_5_1, "instGo")
		end

		gohelper.setActive(var_5_0, true)

		var_5_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, arg_5_0.param.cellClass, arg_5_0.viewContainer)
	else
		var_5_1 = MonoHelper.getLuaComFromGo(var_5_0, arg_5_0.param.cellClass, arg_5_0.viewContainer)
	end

	if arg_5_0.items[arg_5_2] and arg_5_0.items[arg_5_2] ~= var_5_1 then
		arg_5_0.items[arg_5_2]:hideItem()
	end

	arg_5_0.items[arg_5_2] = var_5_1

	local var_5_2 = arg_5_2 == arg_5_0.select

	var_5_1:showItem(arg_5_0.datas[arg_5_2], arg_5_2, var_5_2)
	var_5_1:setSelect(arg_5_0.select == arg_5_2)
end

function var_0_0.getItems(arg_6_0)
	return arg_6_0.items
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	if (not arg_7_1 or not arg_7_0.select or arg_7_0.select ~= arg_7_1) and (not not arg_7_1 or not not arg_7_0.select) then
		if arg_7_0.select and arg_7_0.items[arg_7_0.select] then
			arg_7_0.items[arg_7_0.select]:setSelect(false)
		end

		arg_7_0.select = arg_7_1

		if arg_7_0.select and arg_7_0.items[arg_7_0.select] then
			arg_7_0.items[arg_7_0.select]:setSelect(true)
		end

		if arg_7_0.onSelectCallBack then
			arg_7_0.onSelectCallBack(arg_7_0.onSelectCallBackContext, arg_7_0.select)
		end
	end
end

function var_0_0.setSelectCallBack(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.onSelectCallBack = arg_8_1
	arg_8_0.onSelectCallBackContext = arg_8_2
end

function var_0_0.getSelect(arg_9_0)
	return arg_9_0.select
end

return var_0_0
