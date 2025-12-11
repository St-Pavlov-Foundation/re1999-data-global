module("modules.logic.versionactivity2_7.act191.view.Act191CollectionGetView", package.seeall)

local var_0_0 = class("Act191CollectionGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goOldItem = gohelper.findChild(arg_1_0.viewGO, "result/collection_before/#go_OldItem")
	arg_1_0._goNewItem = gohelper.findChild(arg_1_0.viewGO, "result/collection_after/#go_NewItem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "result/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	if arg_2_0.canExit then
		arg_2_0:closeThis()
	end
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:addEventCb(Activity191Controller.instance, Activity191Event.ClickCollectionItem, arg_3_0.onClickCollectionItem, arg_3_0)

	local var_3_0 = arg_3_0.viewParam.oldIdList

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = gohelper.cloneInPlace(arg_3_0._goOldItem)
		local var_3_2 = arg_3_0:getResInst(Activity191Enum.PrefabPath.CollectionItem, var_3_1)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_3_2, Act191CollectionItem):setData({
			uid = 0,
			itemId = iter_3_1
		})
	end

	gohelper.setActive(arg_3_0._goOldItem, false)

	local var_3_3 = arg_3_0.viewParam.newIdList

	for iter_3_2, iter_3_3 in ipairs(var_3_3) do
		local var_3_4 = gohelper.cloneInPlace(arg_3_0._goNewItem)
		local var_3_5 = arg_3_0:getResInst(Activity191Enum.PrefabPath.CollectionItem, var_3_4)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_3_5, Act191CollectionItem):setData({
			uid = 0,
			itemId = iter_3_3
		})
	end

	gohelper.setActive(arg_3_0._goNewItem, false)
	TaskDispatcher.runDelay(arg_3_0.delaySet, arg_3_0, 2)
end

function var_0_0.delaySet(arg_4_0)
	arg_4_0.canExit = true
end

function var_0_0.onClickCollectionItem(arg_5_0, arg_5_1, arg_5_2)
	Activity191Controller.instance:openCollectionTipView({
		itemId = arg_5_2
	})
end

function var_0_0.onDestroyView(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.delaySet, arg_6_0)
end

return var_0_0
