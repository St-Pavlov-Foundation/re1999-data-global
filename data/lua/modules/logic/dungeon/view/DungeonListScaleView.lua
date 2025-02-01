module("modules.logic.dungeon.view.DungeonListScaleView", package.seeall)

slot0 = class("DungeonListScaleView", BaseView)

function slot0.onInitView(slot0)
	slot0._csScrollScale = SLFramework.UGUI.ListScrollScale.GetWithPath(slot0.viewGO, "chapterlist/#scroll_chapter")
end

function slot0.onDestroyView(slot0)
	slot0._csScrollScale = nil
end

return slot0
