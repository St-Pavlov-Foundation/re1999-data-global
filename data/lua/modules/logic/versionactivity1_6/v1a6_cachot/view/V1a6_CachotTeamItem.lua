module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamItem", package.seeall)

local var_0_0 = class("V1a6_CachotTeamItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorole = gohelper.findChild(arg_1_0.viewGO, "#go_role")
	arg_1_0._gorolenone = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_rolenone")
	arg_1_0._goroleunselect = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_roleunselect")
	arg_1_0._goroledead = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_roledead")
	arg_1_0._goroleselect = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_roleselect")
	arg_1_0._simagerolehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_role/#go_roleselect/mask/#simage_rolehead")
	arg_1_0._godeadmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_role/#go_roleselect/mask/deadmask")
	arg_1_0._careericon = gohelper.findChildImage(arg_1_0.viewGO, "#go_role/#go_roleselect/mask/career")
	arg_1_0._txtroleLv1 = gohelper.findChildText(arg_1_0.viewGO, "#go_role/#go_roleselect/#txt_roleLv1")
	arg_1_0._txtroleLv2 = gohelper.findChildText(arg_1_0.viewGO, "#go_role/#go_roleselect/#txt_roleLv2")
	arg_1_0._txtrolename = gohelper.findChildText(arg_1_0.viewGO, "#go_role/#go_roleselect/#txt_rolename")
	arg_1_0._gotalentnone = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_roleselect/none")
	arg_1_0._gohp = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_roleselect/#go_hp")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_0.viewGO, "#go_role/#go_roleselect/#go_hp/#slider_hp")
	arg_1_0._btnroleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_role/#btn_roleclick")
	arg_1_0._goheart = gohelper.findChild(arg_1_0.viewGO, "#go_heart")
	arg_1_0._goheartnone = gohelper.findChild(arg_1_0.viewGO, "#go_heart/#go_heartnone")
	arg_1_0._goheartunselect = gohelper.findChild(arg_1_0.viewGO, "#go_heart/#go_heartunselect")
	arg_1_0._goheartselect = gohelper.findChild(arg_1_0.viewGO, "#go_heart/#go_heartselect")
	arg_1_0._simageheart = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_heart/#go_heartselect/#simage_heart")
	arg_1_0._txtheartLv = gohelper.findChildText(arg_1_0.viewGO, "#go_heart/#go_heartselect/#simage_heart/#txt_heartLv")
	arg_1_0._btnheartclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_heart/#btn_heartclick")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_cost")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "#go_cost/#txt_cost")
	arg_1_0._txtmax = gohelper.findChildText(arg_1_0.viewGO, "#go_cost/#txt_max")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._goselect2 = gohelper.findChild(arg_1_0.viewGO, "#go_select2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnroleclick:AddClickListener(arg_2_0._btnroleclickOnClick, arg_2_0)
	arg_2_0._btnheartclick:AddClickListener(arg_2_0._btnheartclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnroleclick:RemoveClickListener()
	arg_3_0._btnheartclick:RemoveClickListener()
end

function var_0_0._btnselectOnClick(arg_4_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnClickTeamItem, arg_4_0._mo)
end

function var_0_0._btnheartclickOnClick(arg_5_0)
	arg_5_0:_onClickEquip()
end

function var_0_0._btnroleclickOnClick(arg_6_0)
	arg_6_0:_openHeroGroupEditView()
end

function var_0_0._onClickEquip(arg_7_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)

		local var_7_0 = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()
		local var_7_1 = {
			seatLevel = arg_7_0._seatLevel,
			heroGroupMo = var_7_0,
			heroMo = arg_7_0._heroMO,
			equipMo = arg_7_0._equipMO,
			posIndex = arg_7_0._mo.id - 1,
			fromView = EquipEnum.FromViewEnum.FromCachotHeroGroupView
		}

		V1a6_CachotEquipInfoTeamListModel.instance:setSeatLevel(arg_7_0._seatLevel)
		V1a6_CachotController.instance:openV1a6_CachotEquipInfoTeamShowView(var_7_1)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._openHeroGroupEditView(arg_8_0)
	local var_8_0 = arg_8_0._mo.id
	local var_8_1 = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO():getPosEquips(var_8_0 - 1).equipUid
	local var_8_2 = {
		singleGroupMOId = var_8_0,
		originalHeroUid = V1a6_CachotHeroSingleGroupModel.instance:getHeroUid(var_8_0),
		equips = var_8_1,
		heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Init,
		seatLevel = arg_8_0._seatLevel
	}

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, var_8_2)
end

function var_0_0.setHpVisible(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._gohp, arg_9_1)
end

function var_0_0.setInteractable(arg_10_0, arg_10_1)
	arg_10_0._interactable = arg_10_1
end

function var_0_0.setSelectEnable(arg_11_0, arg_11_1)
	if not arg_11_0._btnselect then
		arg_11_0._btnselect = gohelper.findChildButtonWithAudio(arg_11_0.viewGO, "btn_select")

		arg_11_0._btnselect:AddClickListener(arg_11_0._btnselectOnClick, arg_11_0)
	end

	gohelper.setActive(arg_11_0._btnselect, arg_11_1)
end

function var_0_0.setSelected(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goselect, arg_12_1)
end

function var_0_0.setCost(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._txtcost, arg_13_1)
	gohelper.setActive(arg_13_0._txtmax, not arg_13_1)

	arg_13_0._txtcost.text = arg_13_1

	gohelper.setActive(arg_13_0._gocost, true)
end

function var_0_0._setSeatIndex(arg_14_0, arg_14_1)
	arg_14_0._seatIndex = arg_14_1
end

function var_0_0.getSeatIndex(arg_15_0)
	return arg_15_0._seatIndex
end

function var_0_0._setSeatLevel(arg_16_0, arg_16_1)
	arg_16_0._qualityLevel = arg_16_1

	if not arg_16_0._quality then
		arg_16_0._quality = gohelper.findChildImage(arg_16_0.viewGO, "quality")
		arg_16_0._qualityEffectList = arg_16_0:getUserDataTb_()

		local var_16_0 = gohelper.findChild(arg_16_0.viewGO, "quality_effect").transform
		local var_16_1 = var_16_0.childCount

		for iter_16_0 = 1, var_16_1 do
			local var_16_2 = var_16_0:GetChild(iter_16_0 - 1)

			arg_16_0._qualityEffectList[var_16_2.name] = var_16_2
		end
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_16_0._quality, "v1a6_cachot_quality_0" .. arg_16_1)

	local var_16_3 = "effect_0" .. arg_16_1

	for iter_16_1, iter_16_2 in pairs(arg_16_0._qualityEffectList) do
		gohelper.setActive(iter_16_2, iter_16_1 == var_16_3)
	end
end

function var_0_0.showSelectEffect(arg_17_0)
	if not arg_17_0._selectedEffect then
		arg_17_0._selectedEffect = gohelper.findChild(arg_17_0.viewGO, "effect_select")
	end

	gohelper.setActive(arg_17_0._selectedEffect, false)
	gohelper.setActive(arg_17_0._selectedEffect, true)
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._heartImg = gohelper.findChildImage(arg_18_0.viewGO, "#go_heart/#go_heartselect/#simage_heart")
	arg_18_0._goStarList = arg_18_0:getUserDataTb_()

	for iter_18_0 = 1, 6 do
		local var_18_0 = gohelper.findChild(arg_18_0.viewGO, "#go_role/#go_roleselect/rare/go_rare" .. iter_18_0)

		table.insert(arg_18_0._goStarList, var_18_0)
	end

	arg_18_0._rankList = arg_18_0:getUserDataTb_()

	for iter_18_1 = 1, 3 do
		local var_18_1 = gohelper.findChildImage(arg_18_0.viewGO, "#go_role/#go_roleselect/rankobj/rank" .. iter_18_1)

		table.insert(arg_18_0._rankList, var_18_1)
	end

	gohelper.setActive(arg_18_0._gohp, false)
end

function var_0_0._editableAddEvents(arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_19_0._changeEquip, arg_19_0)
end

function var_0_0._editableRemoveEvents(arg_20_0)
	arg_20_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_20_0._changeEquip, arg_20_0)
end

function var_0_0._changeEquip(arg_21_0, arg_21_1)
	arg_21_0:_updateEquip()
end

function var_0_0.getMo(arg_22_0)
	return arg_22_0._mo
end

function var_0_0.getHeroMo(arg_23_0)
	return arg_23_0._heroMO
end

function var_0_0.onUpdateMO(arg_24_0, arg_24_1)
	arg_24_0._mo = arg_24_1
	arg_24_0._heroMO = arg_24_1:getHeroMO()

	local var_24_0 = V1a6_CachotTeamModel.instance:getSeatInfo(arg_24_1)

	if var_24_0 then
		arg_24_0:_setSeatIndex(var_24_0[1])

		arg_24_0._seatLevel = var_24_0[2]

		arg_24_0:_setSeatLevel(arg_24_0._seatLevel)
	else
		arg_24_0._seatLevel = nil
	end

	arg_24_0:_updateHero()
	arg_24_0:_updateEquip()
end

function var_0_0._updateHp(arg_25_0)
	if not arg_25_0._heroMO then
		arg_25_0:setHpVisible(false)

		return
	end

	arg_25_0:setHpVisible(true)

	local var_25_0 = V1a6_CachotModel.instance:getTeamInfo():getHeroHp(arg_25_0._heroMO.heroId)
	local var_25_1 = var_25_0 and var_25_0.life or 0

	arg_25_0._sliderhp:SetValue(var_25_1 / 1000)
	arg_25_0:_showDeadStatus(var_25_1 <= 0)
end

function var_0_0._showDeadStatus(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._goroledead, arg_26_1)
	gohelper.setActive(arg_26_0._godeadmask, arg_26_1)

	local var_26_0, var_26_1, var_26_2 = transformhelper.getLocalPos(arg_26_0._simagerolehead.transform)

	transformhelper.setLocalPos(arg_26_0._simagerolehead.transform, var_26_0, var_26_1, arg_26_1 and 1 or 0)
end

function var_0_0.tweenHp(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_0._tweenId then
		ZProj.TweenHelper.KillById(arg_27_0._tweenId)

		arg_27_0._tweenId = nil
	end

	arg_27_0._tweenStartValue = arg_27_1
	arg_27_0._tweenEndValue = arg_27_2
	arg_27_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_27_3, arg_27_0._tweenUpdate, arg_27_0._tweenEnd, arg_27_0, nil, EaseType.Linear)

	arg_27_0:_tweenUpdate(0)
end

function var_0_0._tweenUpdate(arg_28_0, arg_28_1)
	arg_28_0._sliderhp:SetValue(Mathf.Lerp(arg_28_0._tweenStartValue, arg_28_0._tweenEndValue, arg_28_1) / 1000)
end

function var_0_0._updateHero(arg_29_0)
	gohelper.setActive(arg_29_0._btnroleclick, arg_29_0._interactable)

	local var_29_0 = not arg_29_0._heroMO and not arg_29_0._interactable

	gohelper.setActive(arg_29_0._gorolenone, var_29_0)
	gohelper.setActive(arg_29_0._goroleunselect, not var_29_0 and not arg_29_0._heroMO)
	gohelper.setActive(arg_29_0._goroleselect, not var_29_0 and arg_29_0._heroMO)

	if not arg_29_0._heroMO then
		return
	end

	local var_29_1 = arg_29_0._heroMO.level
	local var_29_2 = arg_29_0._heroMO.talent
	local var_29_3, var_29_4 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_29_0._heroMO, arg_29_0._seatLevel)
	local var_29_5 = var_29_1 ~= var_29_3
	local var_29_6 = var_29_2 ~= var_29_4
	local var_29_7 = SkinConfig.instance:getSkinCo(arg_29_0._heroMO.skin)

	arg_29_0._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(var_29_7.headIcon))
	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_29_0._careericon, "v1a6_cachot_career_" .. arg_29_0._heroMO.config.career)

	arg_29_0._txtrolename.text = arg_29_0._heroMO.config.name
	arg_29_0._talentIcon = arg_29_0._talentIcon or gohelper.findChildImage(arg_29_0._txtroleLv2.gameObject, "icon")
	arg_29_0._talentIcon.color = var_29_6 and GameUtil.parseColor("#81abe5") or Color.white
	arg_29_0._txtroleLv2.text = "<size=17>LV</size>." .. tostring(var_29_4)

	if var_29_6 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtroleLv2, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtroleLv2, "#e6e6e6")
	end

	local var_29_8 = CharacterEnum.Star[arg_29_0._heroMO.config.rare]

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._goStarList) do
		gohelper.setActive(iter_29_1, iter_29_0 <= var_29_8)
	end

	local var_29_9, var_29_10 = HeroConfig.instance:getShowLevel(var_29_3)
	local var_29_11 = var_29_10 >= CharacterEnum.TalentRank and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)

	gohelper.setActive(arg_29_0._txtroleLv2, var_29_11)
	gohelper.setActive(arg_29_0._gotalentnone, not var_29_11)

	arg_29_0._txtroleLv1.text = "<size=17>LV</size>." .. tostring(var_29_9)

	if var_29_5 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtroleLv1, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtroleLv1, "#e6e6e6")
	end

	for iter_29_2, iter_29_3 in ipairs(arg_29_0._rankList) do
		local var_29_12 = iter_29_2 == var_29_10 - 1

		gohelper.setActive(iter_29_3, var_29_12)

		if var_29_12 then
			iter_29_3.color = var_29_5 and GameUtil.parseColor("#81abe5") or Color.white
		end
	end
end

function var_0_0._getEquipMO(arg_30_0)
	if arg_30_0._mo then
		local var_30_0 = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO():getPosEquips(arg_30_0._mo.id - 1).equipUid[1]

		arg_30_0._equipMO = EquipModel.instance:getEquip(var_30_0)
	end
end

function var_0_0.hideEquipNone(arg_31_0)
	arg_31_0._hideEquipNone = true
end

function var_0_0._updateEquip(arg_32_0)
	gohelper.setActive(arg_32_0._btnheartclick, arg_32_0._interactable)
	arg_32_0:_getEquipMO()

	local var_32_0 = not arg_32_0._equipMO and not arg_32_0._interactable

	gohelper.setActive(arg_32_0._goheartnone, var_32_0 and not arg_32_0._hideEquipNone)
	gohelper.setActive(arg_32_0._goheartunselect, not var_32_0 and not arg_32_0._equipMO)
	gohelper.setActive(arg_32_0._goheartselect, not var_32_0 and arg_32_0._equipMO)

	if arg_32_0._equipMO then
		local var_32_1 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(arg_32_0._equipMO, arg_32_0._seatLevel)
		local var_32_2 = arg_32_0._equipMO.level ~= var_32_1

		arg_32_0._txtheartLv.text = "LV." .. var_32_1

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_32_0._heartImg, arg_32_0._equipMO.config.icon)

		if var_32_2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._txtheartLv, "#bfdaff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._txtheartLv, "#A8A8A8")
		end
	end
end

function var_0_0.onSelect(arg_33_0, arg_33_1)
	return
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagerolehead:UnLoadImage()

	if arg_34_0._btnselect then
		arg_34_0._btnselect:RemoveClickListener()
	end

	if arg_34_0._tweenId then
		ZProj.TweenHelper.KillById(arg_34_0._tweenId)

		arg_34_0._tweenId = nil
	end
end

return var_0_0
