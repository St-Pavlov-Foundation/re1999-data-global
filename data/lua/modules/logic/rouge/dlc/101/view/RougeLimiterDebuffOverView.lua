module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffOverView", package.seeall)

slot0 = class("RougeLimiterDebuffOverView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollviews = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_views")
	slot0._godebuffitem = gohelper.findChild(slot0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem")
	slot0._imagedebufficon = gohelper.findChildImage(slot0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#image_debufficon")
	slot0._txtbufflevel = gohelper.findChildText(slot0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_bufflevel")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_name")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initScroll()
end

function slot0.initScroll(slot0)
	if not slot0._scrollView then
		slot1 = ListScrollParam.New()
		slot1.scrollGOPath = "#scroll_views"
		slot1.prefabType = ScrollEnum.ScrollPrefabFromView
		slot1.prefabUrl = "#scroll_views/Viewport/Content/#go_debuffitem"
		slot1.cellClass = RougeLimiterDebuffOverListItem
		slot1.scrollDir = ScrollEnum.ScrollDirV
		slot1.lineCount = 2
		slot1.cellWidth = 756
		slot1.cellHeight = 200
		slot0._scrollView = LuaListScrollView.New(RougeLimiterDebuffOverListModel.instance, slot1)

		slot0:addChildView(slot0._scrollView)
	end

	RougeLimiterDebuffOverListModel.instance:onInit(slot0.viewParam and slot0.viewParam.limiterIds)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
