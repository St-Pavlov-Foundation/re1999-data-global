module("modules.logic.rouge.view.RougeScrollAudioView", package.seeall)

slot0 = class("RougeScrollAudioView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._scrollviewPath = slot1
end

function slot0.onInitView(slot0)
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, slot0._scrollviewPath or "#scroll_view")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollview.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._scrollview.gameObject)

	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollview.gameObject, DungeonMapEpisodeAudio, slot0._scrollview)
end

function slot0._onDragBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end
end

return slot0
