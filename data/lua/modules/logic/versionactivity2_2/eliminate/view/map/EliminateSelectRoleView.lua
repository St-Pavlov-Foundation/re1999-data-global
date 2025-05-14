module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleView", package.seeall)

local var_0_0 = class("EliminateSelectRoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._scrollRoleList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_RoleList")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_RoleList/Viewport/#go_Content")
	arg_1_0._goRoleSkill = gohelper.findChild(arg_1_0.viewGO, "Tips/Skill/#go_RoleSkill")
	arg_1_0._goRoleSkillBG = gohelper.findChild(arg_1_0.viewGO, "Tips/Skill/#go_RoleSkill/#go_RoleSkillBG")
	arg_1_0._simageSkill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Tips/Skill/#go_RoleSkill/image/#simage_Skill")
	arg_1_0._imageRoleSkillFG = gohelper.findChildImage(arg_1_0.viewGO, "Tips/Skill/#go_RoleSkill/#image_RoleSkillFG")
	arg_1_0._goRoleSkillClick = gohelper.findChild(arg_1_0.viewGO, "Tips/Skill/#go_RoleSkill/#go_RoleSkillClick")
	arg_1_0._txtSkillName = gohelper.findChildText(arg_1_0.viewGO, "Tips/Skill/image_SkillName/#txt_SkillName")
	arg_1_0._txtCost = gohelper.findChildText(arg_1_0.viewGO, "Tips/Skill/#txt_Cost")
	arg_1_0._txtCostNum = gohelper.findChildText(arg_1_0.viewGO, "Tips/Skill/#txt_Cost/#txt_CostNum")
	arg_1_0._txtSkill1 = gohelper.findChildText(arg_1_0.viewGO, "Tips/Skill/#txt_Skill1")
	arg_1_0._txtSkill2 = gohelper.findChildText(arg_1_0.viewGO, "Tips/Skill/#txt_Skill2")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnLeftOnClick(arg_4_0)
	if arg_4_0._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	arg_4_0._roleIndex = arg_4_0._roleIndex - 1

	arg_4_0:_updateSelectedItem()
end

function var_0_0._btnRightOnClick(arg_5_0)
	if arg_5_0._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	arg_5_0._roleIndex = arg_5_0._roleIndex + 1

	arg_5_0:_updateSelectedItem()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	EliminateTeamSelectionModel.instance:setSelectedCharacterId(arg_6_0._characterConfigList[arg_6_0._roleIndex].id)
	EliminateMapController.instance:openEliminateSelectChessMenView()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._tipsAnimator = gohelper.findChild(arg_7_0.viewGO, "Tips"):GetComponent("Animator")
	arg_7_0._isPreset = EliminateTeamSelectionModel.instance:isPreset()
	arg_7_0._roleIndex = 1
	arg_7_0._maxRoleIndex = 1

	arg_7_0:_initItems()
	arg_7_0:_initSelectCharacter()

	arg_7_0._imageSkill = arg_7_0._simageSkill.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

	arg_7_0:_updateSelectedItem()
	arg_7_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.ClickCharacter, arg_7_0.onClickCharacter, arg_7_0)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.ComeShow)
end

function var_0_0.onClickCharacter(arg_8_0, arg_8_1)
	if arg_8_0._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	arg_8_0._roleIndex = arg_8_1

	arg_8_0:_updateSelectedItem()
end

function var_0_0._initItems(arg_9_0)
	arg_9_0._roleList = arg_9_0:getUserDataTb_()
	arg_9_0._characterConfigList = EliminateTeamSelectionModel.instance:getCharacterList()

	local var_9_0 = arg_9_0.viewContainer:getSetting().otherRes[1]

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._characterConfigList) do
		local var_9_1 = arg_9_0:getResInst(var_9_0, arg_9_0._goContent)

		var_9_1.name = "item_" .. tostring(iter_9_1.id)

		local var_9_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, EliminateSelectRoleItem)

		var_9_2:onUpdateMO(iter_9_1, iter_9_0)
		table.insert(arg_9_0._roleList, var_9_2)

		if var_9_2:isUnlocked() then
			arg_9_0._maxRoleIndex = iter_9_0
		end
	end
end

function var_0_0._initSelectCharacter(arg_10_0)
	if arg_10_0._isPreset then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._characterConfigList) do
			if EliminateTeamSelectionModel.instance:isPresetCharacter(iter_10_1.id) then
				arg_10_0._roleIndex = iter_10_0

				break
			end
		end

		return
	end

	local var_10_0 = EliminateMapController.getPrefsString(EliminateMapEnum.PrefsKey.RoleSelected, "")
	local var_10_1 = tonumber(var_10_0)

	if not var_10_1 then
		return
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0._characterConfigList) do
		if iter_10_3.id == var_10_1 then
			arg_10_0._roleIndex = iter_10_2

			break
		end
	end
end

function var_0_0._updateSelectedItem(arg_11_0)
	local var_11_0 = arg_11_0._roleIndex > 1
	local var_11_1 = arg_11_0._roleIndex < arg_11_0._maxRoleIndex
	local var_11_2 = var_11_0 or var_11_1

	arg_11_0._btnLeft.button.interactable = var_11_0 and not arg_11_0._isPreset
	arg_11_0._btnRight.button.interactable = var_11_1 and not arg_11_0._isPreset

	gohelper.setActive(arg_11_0._btnLeft, var_11_2)
	gohelper.setActive(arg_11_0._btnRight, var_11_2)
	arg_11_0:_selectRoleItem(arg_11_0._roleList[arg_11_0._roleIndex])
	arg_11_0._tipsAnimator:Play("open", 0, 0)
end

function var_0_0._selectRoleItem(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._roleList) do
		iter_12_1:onSelect(false)
	end

	arg_12_1:onSelect(true)
	ZProj.UGUIHelper.RebuildLayout(arg_12_0._goContent.transform)

	local var_12_0 = arg_12_1:getConfig()
	local var_12_1 = arg_12_0:_getFirstSkillConfig(var_12_0.activeSkillIds)

	if var_12_1 then
		arg_12_0._txtCostNum.text = var_12_1.cost
		arg_12_0._txtSkill1.text = EliminateLevelModel.instance.formatString(var_12_1.desc, EliminateTeamChessEnum.PreBattleFormatType)
		arg_12_0._txtSkillName.text = var_12_1.name

		UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_12_0._imageSkill, var_12_1.icon)
	else
		arg_12_0._txtCostNum.text = ""
		arg_12_0._txtSkill1.text = ""
		arg_12_0._txtSkillName.text = ""
	end

	arg_12_0._txtSkill2.text = arg_12_0:_getSkillDesc(var_12_0.passiveSkillIds)
end

function var_0_0._getSkillDesc(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:_getFirstSkillConfig(arg_13_1)

	return var_13_0 and EliminateLevelModel.instance.formatString(var_13_0.desc, EliminateTeamChessEnum.PreBattleFormatType) or ""
end

function var_0_0._getFirstSkillConfig(arg_14_0, arg_14_1)
	local var_14_0 = string.splitToNumber(arg_14_1, "#")[1]

	return lua_character_skill.configDict[var_14_0]
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	return
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
