module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskView", package.seeall)

local var_0_0 = class("VersionActivity1_5RevivalTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheroTabList = gohelper.findChild(arg_1_0.viewGO, "#go_heroTabList")
	arg_1_0._goTabItem = gohelper.findChild(arg_1_0.viewGO, "#go_heroTabList/#go_TabItem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goTabItem, false)

	arg_4_0.heroTabItemList = {}
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = false

	for iter_6_0, iter_6_1 in ipairs(VersionActivity1_5RevivalTaskModel.instance:getTaskMoList()) do
		local var_6_1 = VersionActivity1_5HeroTabItem.createItem(gohelper.cloneInPlace(arg_6_0._goTabItem), iter_6_1)

		table.insert(arg_6_0.heroTabItemList, var_6_1)

		if not var_6_0 and iter_6_1:isUnlock() then
			var_6_0 = true

			VersionActivity1_5RevivalTaskModel.instance:setSelectHeroTaskId(iter_6_1.id)
		end
	end
end

function var_0_0.onClose(arg_7_0)
	VersionActivity1_5RevivalTaskModel.instance:clearSelectTaskId()
end

function var_0_0.onDestroyView(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroTabItemList) do
		iter_8_1:destroy()
	end

	arg_8_0.heroTabItemList = nil
end

return var_0_0
