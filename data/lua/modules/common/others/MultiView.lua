module("modules.common.others.MultiView", package.seeall)

local var_0_0 = class("MultiView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewGO = nil
	arg_1_0.viewContainer = nil
	arg_1_0.viewParam = nil
	arg_1_0.viewName = nil
	arg_1_0.tabContainer = nil
	arg_1_0.rootGO = nil
	arg_1_0._views = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._views then
		for iter_2_0, iter_2_1 in pairs(arg_2_0._views) do
			iter_2_1:__onInit()

			iter_2_1.viewGO = arg_2_0.viewGO
			iter_2_1.viewContainer = arg_2_0.viewContainer
			iter_2_1.viewParam = arg_2_0.viewParam
			iter_2_1.viewName = arg_2_0.viewName
			iter_2_1.tabContainer = arg_2_0.tabContainer
			iter_2_1.rootGO = arg_2_0.rootGO

			iter_2_1:onInitView()
		end
	end
end

function var_0_0.addEvents(arg_3_0)
	if arg_3_0._views then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._views) do
			iter_3_1:addEvents()
		end
	end
end

function var_0_0.onOpen(arg_4_0)
	if arg_4_0._views then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._views) do
			iter_4_1:onOpen()
		end
	end
end

function var_0_0.onTabSwitchOpen(arg_5_0)
	if arg_5_0._views then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._views) do
			if iter_5_1.onTabSwitchOpen then
				iter_5_1:onTabSwitchOpen()
			end
		end
	end
end

function var_0_0.onOpenFinish(arg_6_0)
	if arg_6_0._views then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._views) do
			iter_6_1:onOpenFinish()
		end
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	if arg_7_0._views then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._views) do
			iter_7_1:onUpdateParam()
		end
	end
end

function var_0_0.onClickModalMask(arg_8_0)
	if arg_8_0._views then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._views) do
			iter_8_1:onClickModalMask()
		end
	end
end

function var_0_0.onClose(arg_9_0)
	if arg_9_0._views then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._views) do
			iter_9_1:onClose()
		end
	end
end

function var_0_0.onTabSwitchClose(arg_10_0, arg_10_1)
	if arg_10_0._views then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._views) do
			if iter_10_1.onTabSwitchClose then
				iter_10_1:onTabSwitchClose(arg_10_1)
			end
		end
	end
end

function var_0_0.onCloseFinish(arg_11_0)
	if arg_11_0._views then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._views) do
			iter_11_1:onCloseFinish()
		end
	end
end

function var_0_0.removeEvents(arg_12_0)
	if arg_12_0._views then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._views) do
			iter_12_1:removeEvents()
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._views then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._views) do
			iter_13_1:onDestroyView()
			iter_13_1:__onDispose()
		end
	end
end

function var_0_0.callChildrenFunc(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._views then
		local var_14_0

		for iter_14_0, iter_14_1 in pairs(arg_14_0._views) do
			local var_14_1 = iter_14_1[arg_14_1]

			if var_14_1 then
				var_14_1(iter_14_1, arg_14_2)
			end
		end
	end
end

return var_0_0
