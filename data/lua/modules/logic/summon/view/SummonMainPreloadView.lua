module("modules.logic.summon.view.SummonMainPreloadView", package.seeall)

local var_0_0 = class("SummonMainPreloadView", TabViewGroup)

function var_0_0.preloadTab(arg_1_0, arg_1_1)
	arg_1_0._tabIdPreloadList = arg_1_1
	arg_1_0._tabAbPreloaders = {}
end

function var_0_0.onOpen(arg_2_0)
	if not arg_2_0._tabIdPreloadList then
		return
	end

	arg_2_0:addPreloadTab(arg_2_0._tabIdPreloadList[1])
	var_0_0.super.onOpen(arg_2_0)
end

function var_0_0.checkPreload(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._tabIdPreloadList) do
		arg_3_0:addPreloadTab(iter_3_1)
	end
end

function var_0_0.addPreloadTab(arg_4_0, arg_4_1)
	if not arg_4_0._tabAbLoaders[arg_4_1] and not arg_4_0._tabAbPreloaders[arg_4_1] then
		local var_4_0 = MultiAbLoader.New()

		arg_4_0._tabAbPreloaders[arg_4_1] = var_4_0

		local var_4_1 = arg_4_0.viewContainer:getSetting().tabRes
		local var_4_2 = var_4_1 and var_4_1[arg_4_0._tabContainerId] and var_4_1[arg_4_0._tabContainerId][arg_4_1]

		if var_4_2 then
			var_4_0:setPathList(var_4_2)
			var_4_0:startLoad(arg_4_0._onItemPreloaded, arg_4_0)
		else
			logError(string.format("SummonMainPreloadView no res: tabContainerId_%d, tabId_%d", arg_4_0._tabContainerId, arg_4_1))
		end
	end
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._tabAbPreloaders) do
		if arg_5_0._tabAbLoaders[iter_5_0] ~= iter_5_1 then
			iter_5_1:dispose()
		end
	end

	arg_5_0._tabAbPreloaders = nil

	var_0_0.super.onDestroyView(arg_5_0)
end

function var_0_0._openTabView(arg_6_0, arg_6_1)
	if not arg_6_0._tabAbLoaders[arg_6_1] then
		local var_6_0 = arg_6_0._tabAbPreloaders[arg_6_1]

		if var_6_0 and not var_6_0.isLoading then
			arg_6_0:_closeTabView()

			arg_6_0._curTabId = arg_6_1
			arg_6_0._tabAbLoaders[arg_6_0._curTabId] = var_6_0

			arg_6_0:_finishCallback(var_6_0)

			return
		end
	end

	var_0_0.super._openTabView(arg_6_0, arg_6_1)
end

function var_0_0._onItemPreloaded(arg_7_0, arg_7_1)
	return
end

return var_0_0
