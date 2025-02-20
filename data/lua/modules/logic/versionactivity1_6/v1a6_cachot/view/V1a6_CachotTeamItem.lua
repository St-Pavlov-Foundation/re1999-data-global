module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamItem", package.seeall)

slot0 = class("V1a6_CachotTeamItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gorole = gohelper.findChild(slot0.viewGO, "#go_role")
	slot0._gorolenone = gohelper.findChild(slot0.viewGO, "#go_role/#go_rolenone")
	slot0._goroleunselect = gohelper.findChild(slot0.viewGO, "#go_role/#go_roleunselect")
	slot0._goroledead = gohelper.findChild(slot0.viewGO, "#go_role/#go_roledead")
	slot0._goroleselect = gohelper.findChild(slot0.viewGO, "#go_role/#go_roleselect")
	slot0._simagerolehead = gohelper.findChildSingleImage(slot0.viewGO, "#go_role/#go_roleselect/mask/#simage_rolehead")
	slot0._godeadmask = gohelper.findChildSingleImage(slot0.viewGO, "#go_role/#go_roleselect/mask/deadmask")
	slot0._careericon = gohelper.findChildImage(slot0.viewGO, "#go_role/#go_roleselect/mask/career")
	slot0._txtroleLv1 = gohelper.findChildText(slot0.viewGO, "#go_role/#go_roleselect/#txt_roleLv1")
	slot0._txtroleLv2 = gohelper.findChildText(slot0.viewGO, "#go_role/#go_roleselect/#txt_roleLv2")
	slot0._txtrolename = gohelper.findChildText(slot0.viewGO, "#go_role/#go_roleselect/#txt_rolename")
	slot0._gotalentnone = gohelper.findChild(slot0.viewGO, "#go_role/#go_roleselect/none")
	slot0._gohp = gohelper.findChild(slot0.viewGO, "#go_role/#go_roleselect/#go_hp")
	slot0._sliderhp = gohelper.findChildSlider(slot0.viewGO, "#go_role/#go_roleselect/#go_hp/#slider_hp")
	slot0._btnroleclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_role/#btn_roleclick")
	slot0._goheart = gohelper.findChild(slot0.viewGO, "#go_heart")
	slot0._goheartnone = gohelper.findChild(slot0.viewGO, "#go_heart/#go_heartnone")
	slot0._goheartunselect = gohelper.findChild(slot0.viewGO, "#go_heart/#go_heartunselect")
	slot0._goheartselect = gohelper.findChild(slot0.viewGO, "#go_heart/#go_heartselect")
	slot0._simageheart = gohelper.findChildSingleImage(slot0.viewGO, "#go_heart/#go_heartselect/#simage_heart")
	slot0._txtheartLv = gohelper.findChildText(slot0.viewGO, "#go_heart/#go_heartselect/#simage_heart/#txt_heartLv")
	slot0._btnheartclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_heart/#btn_heartclick")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "#go_cost")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "#go_cost/#txt_cost")
	slot0._txtmax = gohelper.findChildText(slot0.viewGO, "#go_cost/#txt_max")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._goselect2 = gohelper.findChild(slot0.viewGO, "#go_select2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnroleclick:AddClickListener(slot0._btnroleclickOnClick, slot0)
	slot0._btnheartclick:AddClickListener(slot0._btnheartclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnroleclick:RemoveClickListener()
	slot0._btnheartclick:RemoveClickListener()
end

function slot0._btnselectOnClick(slot0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnClickTeamItem, slot0._mo)
end

function slot0._btnheartclickOnClick(slot0)
	slot0:_onClickEquip()
end

function slot0._btnroleclickOnClick(slot0)
	slot0:_openHeroGroupEditView()
end

function slot0._onClickEquip(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		V1a6_CachotEquipInfoTeamListModel.instance:setSeatLevel(slot0._seatLevel)
		V1a6_CachotController.instance:openV1a6_CachotEquipInfoTeamShowView({
			seatLevel = slot0._seatLevel,
			heroGroupMo = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO(),
			heroMo = slot0._heroMO,
			equipMo = slot0._equipMO,
			posIndex = slot0._mo.id - 1,
			fromView = EquipEnum.FromViewEnum.FromCachotHeroGroupView
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function slot0._openHeroGroupEditView(slot0)
	slot1 = slot0._mo.id

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, {
		singleGroupMOId = slot1,
		originalHeroUid = V1a6_CachotHeroSingleGroupModel.instance:getHeroUid(slot1),
		equips = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO():getPosEquips(slot1 - 1).equipUid,
		heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Init,
		seatLevel = slot0._seatLevel
	})
end

function slot0.setHpVisible(slot0, slot1)
	gohelper.setActive(slot0._gohp, slot1)
end

function slot0.setInteractable(slot0, slot1)
	slot0._interactable = slot1
end

function slot0.setSelectEnable(slot0, slot1)
	if not slot0._btnselect then
		slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_select")

		slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	end

	gohelper.setActive(slot0._btnselect, slot1)
end

function slot0.setSelected(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.setCost(slot0, slot1)
	gohelper.setActive(slot0._txtcost, slot1)
	gohelper.setActive(slot0._txtmax, not slot1)

	slot0._txtcost.text = slot1

	gohelper.setActive(slot0._gocost, true)
end

function slot0._setSeatIndex(slot0, slot1)
	slot0._seatIndex = slot1
end

function slot0.getSeatIndex(slot0)
	return slot0._seatIndex
end

function slot0._setSeatLevel(slot0, slot1)
	slot0._qualityLevel = slot1

	if not slot0._quality then
		slot0._quality = gohelper.findChildImage(slot0.viewGO, "quality")
		slot0._qualityEffectList = slot0:getUserDataTb_()

		for slot8 = 1, gohelper.findChild(slot0.viewGO, "quality_effect").transform.childCount do
			slot9 = slot3:GetChild(slot8 - 1)
			slot0._qualityEffectList[slot9.name] = slot9
		end
	end

	slot7 = slot1
	slot6 = "v1a6_cachot_quality_0" .. slot7

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._quality, slot6)

	for slot6, slot7 in pairs(slot0._qualityEffectList) do
		gohelper.setActive(slot7, slot6 == "effect_0" .. slot1)
	end
end

function slot0.showSelectEffect(slot0)
	if not slot0._selectedEffect then
		slot0._selectedEffect = gohelper.findChild(slot0.viewGO, "effect_select")
	end

	gohelper.setActive(slot0._selectedEffect, false)
	gohelper.setActive(slot0._selectedEffect, true)
end

function slot0._editableInitView(slot0)
	slot4 = "#go_heart/#go_heartselect/#simage_heart"
	slot0._heartImg = gohelper.findChildImage(slot0.viewGO, slot4)
	slot0._goStarList = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._goStarList, gohelper.findChild(slot0.viewGO, "#go_role/#go_roleselect/rare/go_rare" .. slot4))
	end

	slot0._rankList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		table.insert(slot0._rankList, gohelper.findChildImage(slot0.viewGO, "#go_role/#go_roleselect/rankobj/rank" .. slot4))
	end

	gohelper.setActive(slot0._gohp, false)
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, slot0._changeEquip, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, slot0._changeEquip, slot0)
end

function slot0._changeEquip(slot0, slot1)
	slot0:_updateEquip()
end

function slot0.getMo(slot0)
	return slot0._mo
end

function slot0.getHeroMo(slot0)
	return slot0._heroMO
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._heroMO = slot1:getHeroMO()

	if V1a6_CachotTeamModel.instance:getSeatInfo(slot1) then
		slot0:_setSeatIndex(slot2[1])

		slot0._seatLevel = slot2[2]

		slot0:_setSeatLevel(slot0._seatLevel)
	else
		slot0._seatLevel = nil
	end

	slot0:_updateHero()
	slot0:_updateEquip()
end

function slot0._updateHp(slot0)
	if not slot0._heroMO then
		slot0:setHpVisible(false)

		return
	end

	slot0:setHpVisible(true)

	slot3 = V1a6_CachotModel.instance:getTeamInfo():getHeroHp(slot0._heroMO.heroId) and slot2.life or 0

	slot0._sliderhp:SetValue(slot3 / 1000)
	slot0:_showDeadStatus(slot3 <= 0)
end

function slot0._showDeadStatus(slot0, slot1)
	gohelper.setActive(slot0._goroledead, slot1)
	gohelper.setActive(slot0._godeadmask, slot1)

	slot8, slot9, slot4 = transformhelper.getLocalPos(slot0._simagerolehead.transform)

	transformhelper.setLocalPos(slot0._simagerolehead.transform, slot8, slot9, slot1 and 1 or 0)
end

function slot0.tweenHp(slot0, slot1, slot2, slot3)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenStartValue = slot1
	slot0._tweenEndValue = slot2
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot3, slot0._tweenUpdate, slot0._tweenEnd, slot0, nil, EaseType.Linear)

	slot0:_tweenUpdate(0)
end

function slot0._tweenUpdate(slot0, slot1)
	slot0._sliderhp:SetValue(Mathf.Lerp(slot0._tweenStartValue, slot0._tweenEndValue, slot1) / 1000)
end

function slot0._updateHero(slot0)
	gohelper.setActive(slot0._btnroleclick, slot0._interactable)

	slot1 = not slot0._heroMO and not slot0._interactable

	gohelper.setActive(slot0._gorolenone, slot1)
	gohelper.setActive(slot0._goroleunselect, not slot1 and not slot0._heroMO)
	gohelper.setActive(slot0._goroleselect, not slot1 and slot0._heroMO)

	if not slot0._heroMO then
		return
	end

	slot4, slot5 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(slot0._heroMO, slot0._seatLevel)
	slot6 = slot0._heroMO.level ~= slot4
	slot7 = slot0._heroMO.talent ~= slot5

	slot0._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(SkinConfig.instance:getSkinCo(slot0._heroMO.skin).headIcon))
	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._careericon, "v1a6_cachot_career_" .. slot0._heroMO.config.career)

	slot0._txtrolename.text = slot0._heroMO.config.name
	slot0._talentIcon = slot0._talentIcon or gohelper.findChildImage(slot0._txtroleLv2.gameObject, "icon")
	slot0._talentIcon.color = slot7 and GameUtil.parseColor("#81abe5") or Color.white
	slot0._txtroleLv2.text = "<size=17>LV</size>." .. tostring(slot5)

	if slot7 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtroleLv2, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtroleLv2, "#e6e6e6")
	end

	for slot13, slot14 in ipairs(slot0._goStarList) do
		gohelper.setActive(slot14, slot13 <= CharacterEnum.Star[slot0._heroMO.config.rare])
	end

	slot10, slot11 = HeroConfig.instance:getShowLevel(slot4)
	slot12 = CharacterEnum.TalentRank <= slot11 and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)

	gohelper.setActive(slot0._txtroleLv2, slot12)
	gohelper.setActive(slot0._gotalentnone, not slot12)

	slot0._txtroleLv1.text = "<size=17>LV</size>." .. tostring(slot10)

	if slot6 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtroleLv1, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtroleLv1, "#e6e6e6")
	end

	for slot16, slot17 in ipairs(slot0._rankList) do
		slot18 = slot16 == slot11 - 1

		gohelper.setActive(slot17, slot18)

		if slot18 then
			slot17.color = slot6 and GameUtil.parseColor("#81abe5") or Color.white
		end
	end
end

function slot0._getEquipMO(slot0)
	if slot0._mo then
		slot0._equipMO = EquipModel.instance:getEquip(V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO():getPosEquips(slot0._mo.id - 1).equipUid[1])
	end
end

function slot0.hideEquipNone(slot0)
	slot0._hideEquipNone = true
end

function slot0._updateEquip(slot0)
	gohelper.setActive(slot0._btnheartclick, slot0._interactable)
	slot0:_getEquipMO()

	slot1 = not slot0._equipMO and not slot0._interactable

	gohelper.setActive(slot0._goheartnone, slot1 and not slot0._hideEquipNone)
	gohelper.setActive(slot0._goheartunselect, not slot1 and not slot0._equipMO)
	gohelper.setActive(slot0._goheartselect, not slot1 and slot0._equipMO)

	if slot0._equipMO then
		slot0._txtheartLv.text = "LV." .. slot2

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._heartImg, slot0._equipMO.config.icon)

		if slot0._equipMO.level ~= V1a6_CachotTeamModel.instance:getEquipMaxLevel(slot0._equipMO, slot0._seatLevel) then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtheartLv, "#bfdaff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtheartLv, "#A8A8A8")
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagerolehead:UnLoadImage()

	if slot0._btnselect then
		slot0._btnselect:RemoveClickListener()
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
