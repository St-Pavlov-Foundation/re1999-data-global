module("modules.logic.playercard.view.PlayerCardCharacterSwitchItem", package.seeall)

slot0 = class("PlayerCardCharacterSwitchItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gorandom = gohelper.findChild(slot0.viewGO, "#go_random")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_name")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClick(slot0)
	if slot0._isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)
	slot0._view:selectCell(slot0._index, true)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchHero, {
		slot0._heroId,
		slot0._skinId,
		slot0._mo.isRandom
	})
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._skinId = slot0._mo.skinId
	slot0._heroId = nil

	gohelper.setActive(slot0._gorandom, slot0._mo.isRandom)
	gohelper.setActive(slot0._gonormal, not slot0._mo.isRandom)

	if slot0._mo.isRandom then
		return
	end

	slot0._config = slot0._mo.heroMO.config
	slot0._heroId = slot0._mo.heroMO.heroId
	slot0._txtname.text = slot0._config.name

	slot0._simageicon:LoadImage(ResUrl.getHeadIconSmall(slot0._skinId))
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0._goselected:SetActive(slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
