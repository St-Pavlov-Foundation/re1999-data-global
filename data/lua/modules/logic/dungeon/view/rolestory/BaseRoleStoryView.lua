module("modules.logic.dungeon.view.rolestory.BaseRoleStoryView", package.seeall)

local var_0_0 = class("BaseRoleStoryView", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.parentGO = arg_1_1
	arg_1_0.isShow = false

	arg_1_0:onInit()
end

function var_0_0._loadPrefab(arg_2_0)
	if arg_2_0._loader then
		return
	end

	if not arg_2_0.resPathList then
		return
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.resPathList) do
		table.insert(var_2_0, iter_2_1)
	end

	arg_2_0._abLoader = MultiAbLoader.New()

	arg_2_0._abLoader:setPathList(var_2_0)
	arg_2_0._abLoader:startLoad(arg_2_0._onLoaded, arg_2_0)
end

function var_0_0._onLoaded(arg_3_0)
	local var_3_0 = arg_3_0._abLoader:getAssetItem(arg_3_0.resPathList.mainRes):GetResource(arg_3_0.resPathList.mainRes)

	arg_3_0.viewGO = gohelper.clone(var_3_0, arg_3_0.parentGO, arg_3_0.viewName)

	if not arg_3_0.viewGO then
		return
	end

	arg_3_0:onInitView()
	arg_3_0:addEvents()

	if arg_3_0.isShow then
		arg_3_0:show(true)
	else
		arg_3_0:hide(true)
	end
end

function var_0_0.getResInst(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0._abLoader:getAssetItem(arg_4_1)

	if var_4_0 then
		local var_4_1 = var_4_0:GetResource(arg_4_1)

		if var_4_1 then
			return gohelper.clone(var_4_1, arg_4_2, arg_4_3)
		else
			logError(arg_4_0.__cname .. " prefab not exist: " .. arg_4_1)
		end
	else
		logError(arg_4_0.__cname .. " resource not load: " .. arg_4_1)
	end

	return nil
end

function var_0_0.show(arg_5_0, arg_5_1)
	if arg_5_0.isShow and not arg_5_1 then
		return
	end

	arg_5_0.isShow = true

	if not arg_5_0.viewGO then
		arg_5_0:_loadPrefab()

		return
	end

	gohelper.setActive(arg_5_0.viewGO, true)
	arg_5_0:onShow()
end

function var_0_0.hide(arg_6_0, arg_6_1)
	if not arg_6_0.isShow and not arg_6_1 then
		return
	end

	arg_6_0.isShow = false

	if not arg_6_0.viewGO then
		return
	end

	gohelper.setActive(arg_6_0.viewGO, false)
	arg_6_0:onHide()
end

function var_0_0.destory(arg_7_0)
	arg_7_0:removeEvents()
	arg_7_0:onDestroyView()

	if arg_7_0._abLoader then
		arg_7_0._abLoader:dispose()

		arg_7_0._abLoader = nil
	end

	if arg_7_0.viewGO then
		gohelper.destroy(arg_7_0.viewGO)

		arg_7_0.viewGO = nil
	end

	arg_7_0:__onDispose()
end

function var_0_0.onInit(arg_8_0)
	return
end

function var_0_0.onInitView(arg_9_0)
	return
end

function var_0_0.addEvents(arg_10_0)
	return
end

function var_0_0.removeEvents(arg_11_0)
	return
end

function var_0_0.onShow(arg_12_0)
	return
end

function var_0_0.onHide(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
