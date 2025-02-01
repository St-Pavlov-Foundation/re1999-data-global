module("modules.logic.skin.view.SkinOffsetSkinItem", package.seeall)

slot0 = class("SkinOffsetSkinItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0.txtskinname = gohelper.findChildText(slot0.viewGO, "#txt_skinname")

	slot0:addEventCb(SkinOffsetController.instance, SkinOffsetController.Event.OnSelectSkinChange, slot0.refreshSelect, slot0)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClick(slot0)
	if slot0.isSelect then
		return
	end

	SkinOffsetSkinListModel.instance:setSelectSkin(slot0.mo.skinId)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.getClick(slot0.viewGO)

	slot0.click:AddClickListener(slot0.onClick, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0.goselect, false)

	slot0.txtskinname.text = slot1.skinId .. "#" .. slot1.skinName
	slot0.mo = slot1

	slot0:refreshSelect()
end

function slot0.getMo(slot0)
	return slot0.mo
end

function slot0.refreshSelect(slot0)
	slot0.isSelect = SkinOffsetSkinListModel.instance:isSelect(slot0.mo.skinId)

	gohelper.setActive(slot0.goselect, slot0.isSelect)
end

function slot0.onDestroyView(slot0)
	slot0.click:RemoveClickListener()
end

return slot0
