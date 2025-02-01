module("modules.common.others.UISimpleScrollViewItem", package.seeall)

slot0 = class("UISimpleScrollViewItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0._parentClass = slot1
end

function slot0.startLogic(slot0, slot1, slot2)
	slot0._obj_root = slot1
	slot0._csListScroll = SLFramework.UGUI.ListScrollView.Get(slot1)
	slot0._scroll_param = slot2 or ListScrollParam.New()
end

function slot0.useDefaultParam(slot0, slot1, slot2, slot3)
	slot0._scroll_param.scrollDir = slot1
	slot0._scroll_param.lineCount = slot2
	slot3 = slot3 or slot0._obj_root:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	slot0._scroll_param.cellWidth = slot3.cellSize.x
	slot0._scroll_param.cellHeight = slot3.cellSize.y
	slot0._scroll_param.cellSpaceH = slot3.spacing.x
	slot0._scroll_param.cellSpaceV = slot3.spacing.y

	slot0:setSpace(0, 0)
end

function slot0.setCreateParam(slot0, slot1, slot2)
	slot0._scroll_param.frameUpdateMs = slot1
	slot0._scroll_param.minUpdateCountInFrame = slot2
end

function slot0.setSpace(slot0, slot1, slot2)
	slot0._scroll_param.startSpace = slot1
	slot0._scroll_param.endSpace = slot2
end

function slot0.setClass(slot0, slot1)
	slot0._tar_class = slot1
end

function slot0.setData(slot0, slot1)
	slot0._data = slot1

	if not slot0._init_finish then
		slot0._init_finish = true

		slot0:useScrollParam()
	end

	slot0._csListScroll:UpdateTotalCount(#slot0._data)
end

function slot0.useScrollParam(slot0)
	slot0._csListScroll:Init(slot0._scroll_param.scrollDir, slot0._scroll_param.lineCount, slot0._scroll_param.cellWidth, slot0._scroll_param.cellHeight, slot0._scroll_param.cellSpaceH, slot0._scroll_param.cellSpaceV, slot0._scroll_param.startSpace, slot0._scroll_param.endSpace, slot0._scroll_param.sortMode, slot0._scroll_param.frameUpdateMs, slot0._scroll_param.minUpdateCountInFrame, slot0._onUpdateCell, slot0.onUpdateFinish, nil, slot0)
end

function slot0.setObjItem(slot0, slot1)
	slot0._obj_item = slot1
end

function slot0.setItemViewGOPath(slot0, slot1)
	slot0._viewGO_path = slot1
end

function slot0.setUpdateFinishCallback(slot0, slot1)
	slot0._finish_callback = slot1
end

function slot0._onUpdateCell(slot0, slot1, slot2)
	slot0._item_list = slot0._item_list or {}

	if not slot0._item_list[slot2 + 1] then
		if slot0._obj_item then
			if slot0._viewGO_path then
				slot5 = gohelper.findChild(gohelper.clone(slot0._obj_item, slot1, LuaListScrollView.PrefabInstName), slot0._viewGO_path)
			end

			slot4 = slot0._parentClass:openSubView(slot0._tar_class, slot5)
		else
			slot4 = slot0._parentClass:openSubView(slot0._tar_class, slot1)
		end

		slot0._item_list[slot3] = slot4
	end

	slot4._index = slot3

	slot4:onScrollItemRefreshData(slot0._data[slot3])
end

function slot0.onUpdateFinish(slot0)
	if slot0._finish_callback then
		slot0._finish_callback(slot0._parentClass)
	end
end

function slot0.releaseSelf(slot0)
	slot0._item_list = nil
	slot0.tar_class = nil
	slot0._parentClass = nil
	slot0._finish_callback = nil
	slot0._data = nil
	slot0._tar_class = nil
	slot0._scroll_param = nil

	slot0._csListScroll:Clear()
end

return slot0
