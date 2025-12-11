module("modules.logic.fight.fightcomponent.FightViewComponent", package.seeall)

local var_0_0 = class("FightViewComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.inner_childViews = {}
end

function var_0_0.openSubView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, ...)
	if not arg_2_1.IS_FIGHT_BASE_VIEW then
		return arg_2_0:openSubViewForBaseView(arg_2_1, arg_2_2, arg_2_3, ...)
	end

	local var_2_0 = arg_2_0.PARENT_ROOT_OBJECT
	local var_2_1 = arg_2_0:newClass(arg_2_1, ...)

	var_2_1.viewName = var_2_0.viewName
	var_2_1.viewContainer = var_2_0.viewContainer
	var_2_1.PARENT_VIEW = var_2_0

	if type(arg_2_2) == "string" then
		arg_2_3 = arg_2_3 or var_2_0.viewGO

		arg_2_0:com_loadAsset(arg_2_2, arg_2_0._onViewGOLoadFinish, {
			handle = var_2_1,
			parent_obj = arg_2_3
		})
	else
		var_2_1.viewGO = arg_2_2
		var_2_1.GAMEOBJECT = arg_2_2

		var_2_1:inner_startView()
	end

	table.insert(arg_2_0.inner_childViews, var_2_1)

	return var_2_1
end

function var_0_0._onViewGOLoadFinish(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_2:GetResource()
	local var_3_1 = gohelper.clone(var_3_0, arg_3_3.parent_obj)
	local var_3_2 = arg_3_3.handle

	var_3_2.viewGO = var_3_1
	var_3_2.GAMEOBJECT = var_3_1

	var_3_2:inner_startView()
end

function var_0_0.openSubViewForBaseView(arg_4_0, arg_4_1, arg_4_2, ...)
	if not arg_4_0.inner_childForBaseView then
		arg_4_0.inner_childForBaseView = {}
	end

	local var_4_0 = arg_4_1.New(...)

	var_4_0.viewName = arg_4_0.viewName
	var_4_0.viewContainer = arg_4_0.viewContainer
	var_4_0.PARENT_VIEW = arg_4_0

	var_4_0:__onInit()

	var_4_0.viewGO = arg_4_2

	var_4_0:onInitViewInternal()
	var_4_0:addEventsInternal()
	var_4_0:onOpenInternal()
	var_4_0:onOpenFinishInternal()
	table.insert(arg_4_0.inner_childForBaseView, var_4_0)

	return var_4_0
end

function var_0_0.openExclusiveView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, ...)
	return arg_5_0:openSignExclusiveView(1, arg_5_1, arg_5_2, arg_5_3, arg_5_4, ...)
end

function var_0_0.openSignExclusiveView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, ...)
	if not arg_6_0.exclusive_tab then
		arg_6_0.exclusive_tab = {}
		arg_6_0.exclusive_opening = {}
	end

	arg_6_1 = arg_6_1 or 1
	arg_6_0.exclusive_tab[arg_6_1] = arg_6_0.exclusive_tab[arg_6_1] or {}

	local var_6_0 = arg_6_0.exclusive_tab[arg_6_1][arg_6_0.exclusive_opening[arg_6_1]]

	if var_6_0 then
		if arg_6_2 == arg_6_0.exclusive_opening[arg_6_1] then
			return var_6_0
		end

		arg_6_0:hideExclusiveView(var_6_0, arg_6_1, arg_6_2)
	end

	if arg_6_0.exclusive_tab[arg_6_1][arg_6_2] then
		arg_6_0:setExclusiveViewVisible(arg_6_0.exclusive_tab[arg_6_1][arg_6_2], true)

		arg_6_0.exclusive_opening[arg_6_1] = arg_6_2

		return arg_6_0.exclusive_tab[arg_6_1][arg_6_2]
	end

	local var_6_1 = arg_6_0:openSubView(arg_6_3, arg_6_4, arg_6_5, ...)

	var_6_1.internalExclusiveSign = arg_6_1
	var_6_1.internalExclusiveID = arg_6_2
	arg_6_0.exclusive_tab[arg_6_1][arg_6_2] = var_6_1
	arg_6_0.exclusive_opening[arg_6_1] = arg_6_2

	return var_6_1
end

function var_0_0.hideExclusiveGroup(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or 1

	if arg_7_0.exclusive_opening and arg_7_0.exclusive_opening[arg_7_1] then
		arg_7_0:hideExclusiveView(arg_7_0.exclusive_tab[arg_7_1][arg_7_0.exclusive_opening[arg_7_1]])
	end
end

function var_0_0.hideExclusiveView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_2 = arg_8_2 or 1
	arg_8_1 = arg_8_1 or arg_8_0.exclusive_tab[arg_8_2][arg_8_3]

	if arg_8_0.exclusive_opening[arg_8_1.internalExclusiveSign] == arg_8_1.internalExclusiveID then
		arg_8_0.exclusive_opening[arg_8_1.internalExclusiveSign] = nil
	end

	arg_8_0:setExclusiveViewVisible(arg_8_1, false)
end

function var_0_0.setExclusiveViewVisible(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1.onSetExclusiveViewVisible then
		arg_9_1:onSetExclusiveViewVisible(arg_9_2)
	else
		arg_9_1:setViewVisibleInternal(arg_9_2)
	end
end

function var_0_0.killAllSubView(arg_10_0)
	if arg_10_0.inner_childForBaseView then
		for iter_10_0 = #arg_10_0.inner_childForBaseView, 1, -1 do
			local var_10_0 = arg_10_0.inner_childForBaseView[iter_10_0]

			var_10_0:onCloseInternal()
			var_10_0:onCloseFinishInternal()
			var_10_0:removeEventsInternal()
			var_10_0:onDestroyViewInternal()
			var_10_0:__onDispose()
		end

		arg_10_0.inner_childForBaseView = nil
	end

	for iter_10_1 = #arg_10_0.inner_childViews, 1, -1 do
		local var_10_1 = arg_10_0.inner_childViews[iter_10_1]

		if not var_10_1.IS_DISPOSED then
			var_10_1:onCloseInternal()
			var_10_1:onCloseFinishInternal()
			var_10_1:removeEventsInternal()
			var_10_1:onDestroyViewInternal()
			var_10_1:disposeSelf()
		end
	end
end

function var_0_0.onDestructor(arg_11_0)
	arg_11_0:killAllSubView()
end

return var_0_0
