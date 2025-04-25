module("modules.logic.versionactivity2_5.autochess.view.AutoChessBadgeView", package.seeall)

slot0 = class("AutoChessBadgeView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollBadge = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll_Badge")
	slot0._goBadgeContent = gohelper.findChild(slot0.viewGO, "root/#scroll_Badge/viewport/#go_BadgeContent")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._scrollBadgeGo = slot0._scrollBadge.gameObject
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollBadgeGo)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._scrollBadgeGo)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollBadgeGo, DungeonMapEpisodeAudio, slot0._scrollBadge)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)

	slot0.actId = Activity182Model.instance:getCurActId()
	slot0.actMo = Activity182Model.instance:getActMo()
	slot0.rankCoList = lua_auto_chess_rank.configDict[slot0.actId]
	slot0.curIndex = 0

	slot0:delayInit()
	TaskDispatcher.runRepeat(slot0.delayInit, slot0, 0.1)
end

function slot0.delayInit(slot0)
	slot0.curIndex = slot0.curIndex + 1

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadgeContent), AutoChessBadgeItem):setData(slot0.rankCoList[slot0.curIndex].rankId, slot0.actMo.score, AutoChessBadgeItem.ShowType.BadgeView)

	if slot0.curIndex >= #slot0.rankCoList then
		TaskDispatcher.cancelTask(slot0.delayInit, slot0)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayInit, slot0)

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

function slot0._onDragBeginHandler(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEndHandler(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

return slot0
