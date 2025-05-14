module("modules.logic.activity.view.LinkageActivity_BaseView", package.seeall)

local var_0_0 = class("LinkageActivity_BaseView", Activity101SignViewBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0._pageItemList = {}
	arg_1_0._curPageIndex = false
end

function var_0_0.onDestroyView(arg_2_0)
	GameUtil.onDestroyViewMemberList(arg_2_0, "_pageItemList")
	Activity101SignViewBase._internal_onDestroy(arg_2_0)
end

function var_0_0.addEvents(arg_3_0)
	var_0_0.super.addEvents(arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	var_0_0.super.removeEvents(arg_4_0)
end

function var_0_0.selectedPage(arg_5_0, arg_5_1)
	if arg_5_0._curPageIndex == arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0._curPageIndex

	arg_5_0._curPageIndex = arg_5_1

	arg_5_0:onSelectedPage(arg_5_1, var_5_0)
end

function var_0_0.getPage(arg_6_0, arg_6_1)
	return arg_6_0._pageItemList[arg_6_1]
end

function var_0_0.addPage(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3.New({
		parent = arg_7_0,
		baseViewContainer = arg_7_0.viewContainer
	})

	var_7_0:setIndex(arg_7_1)
	var_7_0:init(arg_7_2)
	table.insert(arg_7_0._pageItemList, var_7_0)

	return var_7_0
end

function var_0_0.getLinkageActivityCO(arg_8_0)
	return ActivityType101Config.instance:getLinkageActivityCO(arg_8_0:actId())
end

function var_0_0.onStart(arg_9_0)
	assert(false, "please override this function")
end

function var_0_0.onSelectedPage(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getPage(arg_10_1)
	local var_10_1

	if arg_10_2 then
		var_10_1 = arg_10_0:getPage(arg_10_2)

		var_10_1:setActive(false)
	end

	var_10_0:setActive(true)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._pageItemList) do
		iter_10_1:onPostSelectedPage(var_10_0, var_10_1)
	end
end

function var_0_0.onRefresh(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._pageItemList) do
		iter_11_1:onUpdateMO()
	end
end

return var_0_0
