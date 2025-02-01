module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleView", package.seeall)

slot0 = class("EliminateSelectRoleView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._scrollRoleList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_RoleList")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_RoleList/Viewport/#go_Content")
	slot0._goRoleSkill = gohelper.findChild(slot0.viewGO, "Tips/Skill/#go_RoleSkill")
	slot0._goRoleSkillBG = gohelper.findChild(slot0.viewGO, "Tips/Skill/#go_RoleSkill/#go_RoleSkillBG")
	slot0._simageSkill = gohelper.findChildSingleImage(slot0.viewGO, "Tips/Skill/#go_RoleSkill/image/#simage_Skill")
	slot0._imageRoleSkillFG = gohelper.findChildImage(slot0.viewGO, "Tips/Skill/#go_RoleSkill/#image_RoleSkillFG")
	slot0._goRoleSkillClick = gohelper.findChild(slot0.viewGO, "Tips/Skill/#go_RoleSkill/#go_RoleSkillClick")
	slot0._txtSkillName = gohelper.findChildText(slot0.viewGO, "Tips/Skill/image_SkillName/#txt_SkillName")
	slot0._txtCost = gohelper.findChildText(slot0.viewGO, "Tips/Skill/#txt_Cost")
	slot0._txtCostNum = gohelper.findChildText(slot0.viewGO, "Tips/Skill/#txt_Cost/#txt_CostNum")
	slot0._txtSkill1 = gohelper.findChildText(slot0.viewGO, "Tips/Skill/#txt_Skill1")
	slot0._txtSkill2 = gohelper.findChildText(slot0.viewGO, "Tips/Skill/#txt_Skill2")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Left")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Right")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnLeftOnClick(slot0)
	if slot0._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	slot0._roleIndex = slot0._roleIndex - 1

	slot0:_updateSelectedItem()
end

function slot0._btnRightOnClick(slot0)
	if slot0._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	slot0._roleIndex = slot0._roleIndex + 1

	slot0:_updateSelectedItem()
end

function slot0._btnconfirmOnClick(slot0)
	EliminateTeamSelectionModel.instance:setSelectedCharacterId(slot0._characterConfigList[slot0._roleIndex].id)
	EliminateMapController.instance:openEliminateSelectChessMenView()
end

function slot0._editableInitView(slot0)
	slot0._tipsAnimator = gohelper.findChild(slot0.viewGO, "Tips"):GetComponent("Animator")
	slot0._isPreset = EliminateTeamSelectionModel.instance:isPreset()
	slot0._roleIndex = 1
	slot0._maxRoleIndex = 1

	slot0:_initItems()
	slot0:_initSelectCharacter()

	slot0._imageSkill = slot0._simageSkill.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

	slot0:_updateSelectedItem()
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.ClickCharacter, slot0.onClickCharacter, slot0)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.ComeShow)
end

function slot0.onClickCharacter(slot0, slot1)
	if slot0._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	slot0._roleIndex = slot1

	slot0:_updateSelectedItem()
end

function slot0._initItems(slot0)
	slot0._roleList = slot0:getUserDataTb_()
	slot0._characterConfigList = EliminateTeamSelectionModel.instance:getCharacterList()

	for slot5, slot6 in ipairs(slot0._characterConfigList) do
		slot7 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContent)
		slot7.name = "item_" .. tostring(slot6.id)
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, EliminateSelectRoleItem)

		slot8:onUpdateMO(slot6, slot5)
		table.insert(slot0._roleList, slot8)

		if slot8:isUnlocked() then
			slot0._maxRoleIndex = slot5
		end
	end
end

function slot0._initSelectCharacter(slot0)
	if slot0._isPreset then
		for slot4, slot5 in ipairs(slot0._characterConfigList) do
			if EliminateTeamSelectionModel.instance:isPresetCharacter(slot5.id) then
				slot0._roleIndex = slot4

				break
			end
		end

		return
	end

	if not tonumber(EliminateMapController.getPrefsString(EliminateMapEnum.PrefsKey.RoleSelected, "")) then
		return
	end

	for slot6, slot7 in ipairs(slot0._characterConfigList) do
		if slot7.id == slot2 then
			slot0._roleIndex = slot6

			break
		end
	end
end

function slot0._updateSelectedItem(slot0)
	slot1 = slot0._roleIndex > 1
	slot2 = slot0._roleIndex < slot0._maxRoleIndex
	slot3 = slot1 or slot2
	slot0._btnLeft.button.interactable = slot1 and not slot0._isPreset
	slot0._btnRight.button.interactable = slot2 and not slot0._isPreset

	gohelper.setActive(slot0._btnLeft, slot3)
	gohelper.setActive(slot0._btnRight, slot3)
	slot0:_selectRoleItem(slot0._roleList[slot0._roleIndex])
	slot0._tipsAnimator:Play("open", 0, 0)
end

function slot0._selectRoleItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._roleList) do
		slot6:onSelect(false)
	end

	slot1:onSelect(true)
	ZProj.UGUIHelper.RebuildLayout(slot0._goContent.transform)

	if slot0:_getFirstSkillConfig(slot1:getConfig().activeSkillIds) then
		slot0._txtCostNum.text = slot3.cost
		slot0._txtSkill1.text = EliminateLevelModel.instance.formatString(slot3.desc, EliminateTeamChessEnum.PreBattleFormatType)
		slot0._txtSkillName.text = slot3.name

		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageSkill, slot3.icon)
	else
		slot0._txtCostNum.text = ""
		slot0._txtSkill1.text = ""
		slot0._txtSkillName.text = ""
	end

	slot0._txtSkill2.text = slot0:_getSkillDesc(slot2.passiveSkillIds)
end

function slot0._getSkillDesc(slot0, slot1)
	return slot0:_getFirstSkillConfig(slot1) and EliminateLevelModel.instance.formatString(slot2.desc, EliminateTeamChessEnum.PreBattleFormatType) or ""
end

function slot0._getFirstSkillConfig(slot0, slot1)
	return lua_character_skill.configDict[string.splitToNumber(slot1, "#")[1]]
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
