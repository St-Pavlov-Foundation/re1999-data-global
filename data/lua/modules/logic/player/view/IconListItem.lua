module("modules.logic.player.view.IconListItem", package.seeall)

slot0 = class("IconListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simageheadIcon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_headIcon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "#simage_headIcon/#go_framenode")
	slot0._gochoosing = gohelper.findChild(slot0.viewGO, "#go_choosing")
	slot0._goblackShadow = gohelper.findChild(slot0.viewGO, "#go_blackShadow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._portraitclick:AddClickListener(slot0._selectPortrait, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, slot0._onSelectPortrait, slot0)
end

function slot0.removeEvents(slot0)
	slot0._portraitclick:RemoveClickListener()
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, slot0._onSelectPortrait, slot0)
end

function slot0._editableInitView(slot0)
	slot0._goportrait = gohelper.findChild(slot0.viewGO, "#simage_headIcon")
	slot0._portraitclick = SLFramework.UGUI.UIClickListener.Get(slot0._goportrait)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._selectPortrait(slot0)
	IconTipModel.instance:setSelectIcon(slot0._mo.id)
end

function slot0._onSelectPortrait(slot0, slot1)
	gohelper.setActive(slot0._gochoosing, slot0._mo.id == slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadIcon)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.id)
	gohelper.setActive(slot0._gochoosing, slot1.id == IconTipModel.instance:getSelectIcon())
end

function slot0.onDestroyView(slot0)
	slot0._simageheadIcon:UnLoadImage()
end

return slot0
