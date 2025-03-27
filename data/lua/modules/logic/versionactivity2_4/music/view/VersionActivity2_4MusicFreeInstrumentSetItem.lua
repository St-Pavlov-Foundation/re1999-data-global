module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetItem", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeInstrumentSetItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnroot = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_root")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#btn_root/#go_select")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "#btn_root/#go_unselect")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#btn_root/#image_icon")
	slot0._imageselectframe = gohelper.findChildImage(slot0.viewGO, "#btn_root/#image_selectframe")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_root/#btn_click")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnroot:AddClickListener(slot0._btnrootOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnroot:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._showIndex then
		slot0._parentView:removeInstrument(slot0._mo.id)

		return
	end

	slot0._parentView:addInstrument(slot0._mo.id)
end

function slot0._btnrootOnClick(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._mo = slot1
	slot0._parentView = slot2
	slot0._txtname.text = slot0._mo.name

	slot0:updateIndex()
	UISpriteSetMgr.instance:setMusicSprite(slot0._imageicon, "v2a4_bakaluoer_freeinstrument_icon_t_" .. slot1.icon)
end

function slot0.updateIndex(slot0)
	slot0._showIndex = tabletool.indexOf(slot0._parentView._indexList, slot0._mo.id) ~= nil

	gohelper.setActive(slot0._imageselectframe, slot0._showIndex)
	gohelper.setActive(slot0._goselect, slot0._showIndex)
	gohelper.setActive(slot0._gounselect, not slot0._showIndex)

	if slot0._showIndex then
		UISpriteSetMgr.instance:setMusicSprite(slot0._imageselectframe, "v2a4_bakaluoer_freeinstrument_set_num" .. slot1)
	end

	slot2 = slot0._imageicon.color
	slot2.a = slot0._showIndex and 1 or 0.35
	slot0._imageicon.color = slot2
	slot0._txtname.color = GameUtil.parseColor(slot0._showIndex and "#ebf0f4" or "#728698")
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
