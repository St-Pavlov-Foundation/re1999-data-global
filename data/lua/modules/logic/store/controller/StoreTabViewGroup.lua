module("modules.logic.store.controller.StoreTabViewGroup", package.seeall)

local var_0_0 = class("StoreTabViewGroup", TabViewGroup)

function var_0_0.onOpen(arg_1_0)
	arg_1_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_1_0._toSwitchTab, arg_1_0)

	local var_1_0 = arg_1_0.viewParam and type(arg_1_0.viewParam) == "table" and arg_1_0.viewParam.defaultTabIds and arg_1_0.viewParam.defaultTabIds[arg_1_0._tabContainerId] or 1

	arg_1_0:_openTabView(var_1_0)
end

function var_0_0._toSwitchTab(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == arg_2_0._tabContainerId then
		arg_2_0:_openTabView(arg_2_2)
	end
end

function var_0_0._openTabView(arg_3_0, arg_3_1)
	arg_3_0:_closeTabView()

	arg_3_0._curTabId = arg_3_1

	if arg_3_0._tabAbLoaders[arg_3_0._curTabId] then
		arg_3_0:_setVisible(arg_3_0._curTabId, true)
		arg_3_0._tabViews[arg_3_0._curTabId]:onOpenInternal()
	else
		local var_3_0 = MultiAbLoader.New()

		arg_3_0._tabAbLoaders[arg_3_0._curTabId] = var_3_0

		local var_3_1 = arg_3_0.viewContainer:getSetting().tabRes

		for iter_3_0, iter_3_1 in pairs(lua_store_recommend.configDict) do
			if iter_3_1.isCustomLoad == 1 and iter_3_1.prefab == arg_3_0._curTabId then
				var_3_1[arg_3_0._tabContainerId][iter_3_1.prefab] = {
					string.format("ui/viewres/%s.prefab", iter_3_1.res)
				}
				arg_3_0._tabViews[arg_3_0._curTabId] = _G[iter_3_1.className].New()
				arg_3_0._tabViews[arg_3_0._curTabId].config = iter_3_1
			end
		end

		local var_3_2 = var_3_1 and var_3_1[arg_3_0._tabContainerId] and var_3_1[arg_3_0._tabContainerId][arg_3_0._curTabId]

		if var_3_2 then
			UIBlockMgr.instance:startBlock(arg_3_0._UIBlockKey)
			var_3_0:setPathList(var_3_2)
			var_3_0:startLoad(arg_3_0._finishCallback, arg_3_0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", arg_3_0._tabContainerId, arg_3_0._curTabId))
		end
	end
end

return var_0_0
