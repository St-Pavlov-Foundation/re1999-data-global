module("modules.logic.dungeon.view.map.DungeonMapEquipEntry", package.seeall)

local var_0_0 = class("DungeonMapEquipEntry", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goentryItem = gohelper.findChild(arg_1_0.viewGO, "#go_res/entry/#go_entryItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goentry = gohelper.findChild(arg_4_0.viewGO, "#go_res/entry")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._chapterId = arg_6_0.viewParam.chapterId

	arg_6_0:_showEntryItem()
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0._onOpenView, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(arg_7_0._goentry, false)
	end
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(arg_8_0._goentry, true)
	end
end

function var_0_0._showEntryItem(arg_9_0)
	if DungeonConfig.instance:getChapterCO(arg_9_0._chapterId).type ~= DungeonEnum.ChapterType.Equip then
		return
	end

	local var_9_0 = DungeonMapModel.instance:getEquipSpChapters()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._goentryItem)
		local var_9_2 = MonoHelper.addLuaComOnceToGo(var_9_1, DungeonMapEquipEntryItem, {
			iter_9_0,
			iter_9_1
		})

		gohelper.setActive(var_9_1, true)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
