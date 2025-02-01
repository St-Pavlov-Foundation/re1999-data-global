module("modules.logic.equip.view.EquipTeamItem", package.seeall)

slot0 = class("EquipTeamItem", CharacterEquipItem)

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._setSelected, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._setSelected, slot0)
end

function slot0._onClick(slot0)
	EquipController.instance:openEquipTeamShowView({
		slot0._mo.uid,
		EquipTeamListModel.instance:getEquipTeamPos(slot0._mo.uid) == EquipTeamListModel.instance:getCurPosIndex()
	})
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	slot0._view:selectCell(slot0._index, true)
end

function slot0._showHeroIcon(slot0, slot1, slot2)
	slot0._commonEquipIcon._goinuse:SetActive(true)

	if slot2:getHeroByIndex(slot1 + 1) then
		if not HeroModel.instance:getById(slot3) then
			return
		end

		if not slot0._heroicon then
			slot0._heroicon = IconMgr.instance:getCommonHeroIcon(slot0._commonEquipIcon._goinuse)

			slot0._heroicon:isShowStar(false)
			slot0._heroicon:isShowBreak(false)
			slot0._heroicon:isShowRare(false)
			slot0._heroicon:setMaskVisible(false)
			slot0._heroicon:setLvVisible(false)
			slot0._heroicon:isShowCareerIcon(false)
			slot0._heroicon:isShowRareIcon(false)
			slot0._heroicon:setScale(0.27)
			slot0._heroicon:setAnchor(-53.7, 3)
		end

		slot0._heroicon:onUpdateMO(slot4)
		gohelper.setActive(slot0._heroicon.go, true)
	end
end

function slot0.onSelect(slot0, slot1)
	slot0._commonEquipIcon:onSelect(slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)

	if slot0._heroicon then
		gohelper.setActive(slot0._heroicon.go, false)
	end

	slot0._commonEquipIcon._goinuse:SetActive(false)
	slot0._commonEquipIcon._gointeam:SetActive(false)
	slot0._commonEquipIcon:isShowEquipSkillCarrerIcon(true)
	slot0._commonEquipIcon:setSelectUIVisible(true)

	if not HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	for slot7, slot8 in pairs(slot2:getAllPosEquips()) do
		for slot12, slot13 in pairs(slot8.equipUid) do
			if slot13 == slot0._mo.uid then
				slot0:_showHeroIcon(slot7, slot2)

				return
			end
		end
	end
end

function slot0._setSelected(slot0, slot1, slot2)
	if slot1 ~= ViewName.EquipTeamShowView then
		return
	end

	if slot0._mo.uid ~= slot2[1] then
		return
	end

	slot0._view:selectCell(slot2[2] and slot0._index or 1, true)
end

return slot0
