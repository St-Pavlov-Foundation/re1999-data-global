module("modules.logic.dungeon.view.map.DungeonMapEquipEntry", package.seeall)

slot0 = class("DungeonMapEquipEntry", BaseView)

function slot0.onInitView(slot0)
	slot0._goentryItem = gohelper.findChild(slot0.viewGO, "#go_res/entry/#go_entryItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goentry = gohelper.findChild(slot0.viewGO, "#go_res/entry")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._chapterId = slot0.viewParam.chapterId

	slot0:_showEntryItem()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(slot0._goentry, false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(slot0._goentry, true)
	end
end

function slot0._showEntryItem(slot0)
	if DungeonConfig.instance:getChapterCO(slot0._chapterId).type ~= DungeonEnum.ChapterType.Equip then
		return
	end

	for slot6, slot7 in ipairs(DungeonMapModel.instance:getEquipSpChapters()) do
		slot8 = gohelper.cloneInPlace(slot0._goentryItem)
		slot9 = MonoHelper.addLuaComOnceToGo(slot8, DungeonMapEquipEntryItem, {
			slot6,
			slot7
		})

		gohelper.setActive(slot8, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
