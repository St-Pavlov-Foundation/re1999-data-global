module("modules.logic.equip.view.EquipTeamItem", package.seeall)

local var_0_0 = class("EquipTeamItem", CharacterEquipItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._click = gohelper.getClickWithAudio(arg_1_0.viewGO)

	arg_1_0._click:AddClickListener(arg_1_0._onClick, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_1_0._setSelected, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_1_0._setSelected, arg_1_0)
end

function var_0_0._onClick(arg_2_0)
	local var_2_0 = EquipTeamListModel.instance:getEquipTeamPos(arg_2_0._mo.uid)

	EquipController.instance:openEquipTeamShowView({
		arg_2_0._mo.uid,
		var_2_0 == EquipTeamListModel.instance:getCurPosIndex()
	})
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	arg_2_0._view:selectCell(arg_2_0._index, true)
end

function var_0_0._showHeroIcon(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._commonEquipIcon._goinuse:SetActive(true)

	local var_3_0 = arg_3_2:getHeroByIndex(arg_3_1 + 1)

	if var_3_0 then
		local var_3_1 = HeroModel.instance:getById(var_3_0)

		if not var_3_1 then
			return
		end

		if not arg_3_0._heroicon then
			arg_3_0._heroicon = IconMgr.instance:getCommonHeroIcon(arg_3_0._commonEquipIcon._goinuse)

			arg_3_0._heroicon:isShowStar(false)
			arg_3_0._heroicon:isShowBreak(false)
			arg_3_0._heroicon:isShowRare(false)
			arg_3_0._heroicon:setMaskVisible(false)
			arg_3_0._heroicon:setLvVisible(false)
			arg_3_0._heroicon:isShowCareerIcon(false)
			arg_3_0._heroicon:isShowRareIcon(false)
			arg_3_0._heroicon:setScale(0.27)
			arg_3_0._heroicon:setAnchor(-53.7, 3)
		end

		arg_3_0._heroicon:onUpdateMO(var_3_1)
		gohelper.setActive(arg_3_0._heroicon.go, true)
	end
end

function var_0_0.onSelect(arg_4_0, arg_4_1)
	arg_4_0._commonEquipIcon:onSelect(arg_4_1)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1)

	if arg_5_0._heroicon then
		gohelper.setActive(arg_5_0._heroicon.go, false)
	end

	arg_5_0._commonEquipIcon._goinuse:SetActive(false)
	arg_5_0._commonEquipIcon._gointeam:SetActive(false)
	arg_5_0._commonEquipIcon:isShowEquipSkillCarrerIcon(true)
	arg_5_0._commonEquipIcon:setSelectUIVisible(true)

	local var_5_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0:getAllPosEquips()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1.equipUid) do
			if iter_5_3 == arg_5_0._mo.uid then
				arg_5_0:_showHeroIcon(iter_5_0, var_5_0)

				return
			end
		end
	end
end

function var_0_0._setSelected(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= ViewName.EquipTeamShowView then
		return
	end

	if arg_6_0._mo.uid ~= arg_6_2[1] then
		return
	end

	arg_6_0._view:selectCell(arg_6_2[2] and arg_6_0._index or 1, true)
end

return var_0_0
