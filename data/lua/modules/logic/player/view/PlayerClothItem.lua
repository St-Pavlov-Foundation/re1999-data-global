module("modules.logic.player.view.PlayerClothItem", package.seeall)

slot0 = class("PlayerClothItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._bg = gohelper.findChildImage(slot1, "bg")
	slot0._imgBg = gohelper.findChildSingleImage(slot1, "skillicon")
	slot0._inUseGO = gohelper.findChild(slot1, "inuse")
	slot0._beSelectedGO = gohelper.findChild(slot1, "beselected")
	slot0._clickThis = gohelper.getClick(slot1)
end

function slot0.addEventListeners(slot0)
	slot0._clickThis:AddClickListener(slot0._onClickThis, slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._onChangeClothId, slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0._onChangeClothId, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickThis:RemoveClickListener()
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._onChangeClothId, slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0._onChangeClothId, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot2 = lua_cloth.configDict[slot1.clothId]

	slot0._imgBg:LoadImage(ResUrl.getPlayerClothIcon(tostring(slot1.clothId)))

	if slot0._view:getFirstSelect() == slot1 then
		slot0:onSelect(true)
	end

	slot0:_updateOnUse()
end

function slot0._updateOnUse(slot0)
	slot2 = PlayerClothListViewModel.instance:getGroupModel() and slot1:getCurGroupMO()

	gohelper.setActive(slot0._beSelectedGO, slot0._isSelect)
	gohelper.setActive(slot0._inUseGO, (PlayerClothModel.instance:getSpEpisodeClothID() or slot2 and slot2.clothId) == slot0.mo.clothId)
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0:_updateOnUse()
end

function slot0._onChangeClothId(slot0)
	slot0:_updateOnUse()
end

function slot0._onClickThis(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return
	end

	if not slot0._isSelect then
		PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, slot0.mo.clothId)
	end
end

return slot0
