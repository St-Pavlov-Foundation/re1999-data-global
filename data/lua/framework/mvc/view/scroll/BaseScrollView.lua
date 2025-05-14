module("framework.mvc.view.scroll.BaseScrollView", package.seeall)

local var_0_0 = class("BaseScrollView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._model = arg_1_1
	arg_1_0._emptyParam = arg_1_2
	arg_1_0._isShowing = false
	arg_1_0._needRefresh = true
	arg_1_0._emptyGO = nil
	arg_1_0._emptyHandler = nil
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._model then
		arg_2_0._model:addScrollView(arg_2_0)
	end

	if arg_2_0._emptyParam then
		if arg_2_0._emptyParam.prefabType == ScrollEnum.ScrollPrefabFromView then
			arg_2_0._emptyGO = gohelper.findChild(arg_2_0.viewGO, arg_2_0._emptyParam.prefabUrl)
		else
			local var_2_0 = gohelper.findChild(arg_2_0.viewGO, arg_2_0._emptyParam.parentPath)

			if not var_2_0 then
				logError("empty go parent cannot find: " .. arg_2_0._emptyParam.parentPath)
			end

			arg_2_0._emptyGO = arg_2_0:getResInst(arg_2_0._emptyParam.prefabUrl, var_2_0)

			if not arg_2_0._emptyGO then
				logError("empty res cannot find: " .. arg_2_0._emptyParam.prefabUrl)
			end
		end

		arg_2_0._emptyHandler = arg_2_0._emptyParam.handleClass.New()

		if not arg_2_0._emptyHandler then
			logError("empty handler cannot find: " .. (arg_2_0._emptyParam.handleClass and arg_2_0._emptyParam.handleClass.__cname or arg_2_0.viewContainer.viewName))
		end
	end

	if arg_2_0._param and arg_2_0._param.scrollGOPath and GameResMgr.IsFromEditorDir then
		local var_2_1 = gohelper.findChild(arg_2_0.viewGO, arg_2_0._param.scrollGOPath)
		local var_2_2 = gohelper.create2d(var_2_1, arg_2_0._param.prefabUrl)

		gohelper.setSibling(var_2_2, 0)
	end
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._isShowing = true

	if arg_3_0._needRefresh then
		arg_3_0:refreshScroll()
	end
end

function var_0_0.onCloseFinish(arg_4_0)
	arg_4_0._isShowing = false
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._model then
		arg_5_0._model:removeScrollView(arg_5_0)

		arg_5_0._model = nil
	end

	if arg_5_0._emptyGO then
		gohelper.destroy(arg_5_0._emptyGO)

		arg_5_0._emptyGO = nil
		arg_5_0._emptyParam = nil
		arg_5_0._emptyHandler = nil
	end
end

function var_0_0.onModelUpdate(arg_6_0)
	if arg_6_0._isShowing then
		arg_6_0:refreshScroll()
	else
		arg_6_0._needRefresh = true
	end
end

function var_0_0.refreshScroll(arg_7_0)
	arg_7_0._needRefresh = false
end

function var_0_0.updateEmptyGO(arg_8_0, arg_8_1)
	if arg_8_0._emptyGO then
		gohelper.setActive(arg_8_0._emptyGO, arg_8_1 <= 0)

		if arg_8_1 <= 0 then
			arg_8_0._emptyHandler:refreshEmptyView(arg_8_0._emptyGO, arg_8_0._emptyParam.params)
		end
	end
end

return var_0_0
