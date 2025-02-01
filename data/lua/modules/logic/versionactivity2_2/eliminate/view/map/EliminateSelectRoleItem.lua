module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleItem", package.seeall)

slot0 = class("EliminateSelectRoleItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goRole = gohelper.findChild(slot0.viewGO, "#go_Role")
	slot0._goRoleSelected = gohelper.findChild(slot0.viewGO, "#go_Role/#go_RoleSelected")
	slot0._imageRoleBG = gohelper.findChildImage(slot0.viewGO, "#go_Role/#image_RoleBG")
	slot0._imageRoleHPBG = gohelper.findChildImage(slot0.viewGO, "#go_Role/#image_RoleHPBG")
	slot0._imageRoleHPFG = gohelper.findChildImage(slot0.viewGO, "#go_Role/#image_RoleHPFG")
	slot0._simageRole = gohelper.findChildSingleImage(slot0.viewGO, "#go_Role/image/#simage_Role")
	slot0._imageRoleHPNumBG = gohelper.findChildImage(slot0.viewGO, "#go_Role/#image_RoleHPNumBG")
	slot0._txtRoleHP = gohelper.findChildText(slot0.viewGO, "#go_Role/#image_RoleHPNumBG/#txt_RoleHP")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Role/#go_Locked")
	slot0._goRoleName1 = gohelper.findChild(slot0.viewGO, "RoleName/#go_RoleName1")
	slot0._txtRoleName = gohelper.findChildText(slot0.viewGO, "RoleName/#go_RoleName1/#txt_RoleName")
	slot0._goRoleName2 = gohelper.findChild(slot0.viewGO, "RoleName/#go_RoleName2")
	slot0._txtRoleName2 = gohelper.findChildText(slot0.viewGO, "RoleName/#go_RoleName2/#txt_RoleName2")
	slot0._goAssist = gohelper.findChild(slot0.viewGO, "#go_Assist")

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
	slot0._rawWidth = recthelper.getWidth(slot0.viewGO.transform)
	slot0._scaleWidth = 330
	slot0._animator = slot0.viewGO:GetComponent("Animator")
end

function slot0._onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not slot0._isUnlock then
		return
	end

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ClickCharacter, slot0._index)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._index = slot2
	slot0._isPreset = EliminateTeamSelectionModel.instance:isPreset()
	slot0._isUnlock = EliminateTeamSelectionModel.instance:hasCharacterOrPreset(slot0._config.id)

	gohelper.setActive(slot0._goLocked, not slot0._isUnlock)

	if slot0._isUnlock and not EliminateMapController.hasOnceActionKey(EliminateMapEnum.PrefsKey.RoleUnlock, slot0._config.id) then
		EliminateMapController.setOnceActionKey(EliminateMapEnum.PrefsKey.RoleUnlock, slot0._config.id)
		gohelper.setActive(slot0._goLocked, true)
		slot0._goLocked:GetComponent("Animator"):Play("unlock")
	end

	slot0._txtRoleName.text = slot0._config.name
	slot0._txtRoleName2.text = slot0._config.name
	slot0._txtRoleHP.text = slot0._config.hp

	slot0._simageRole:LoadImage(ResUrl.getHeadIconSmall(slot0._config.resPic))
	ZProj.UGUIHelper.SetGrayscale(slot0._imageRoleBG.gameObject, not slot0._isUnlock)
	ZProj.UGUIHelper.SetGrayscale(slot0._simageRole.gameObject, not slot0._isUnlock)
	ZProj.UGUIHelper.SetGrayscale(slot0._imageRoleHPBG.gameObject, not slot0._isUnlock)
	gohelper.setActive(slot0._imageRoleHPFG, slot0._isUnlock)
	gohelper.setActive(slot0._imageRoleHPNumBG, slot0._isUnlock)
end

function slot0.isUnlocked(slot0)
	return slot0._isUnlock
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.onSelect(slot0, slot1)
	slot2 = slot0._isSelected
	slot0._isSelected = slot1

	gohelper.setActive(slot0._goRoleSelected, slot1)
	gohelper.setActive(slot0._goRoleName1, slot1 and slot0._isUnlock)
	gohelper.setActive(slot0._goRoleName2, not slot1 and slot0._isUnlock)
	recthelper.setWidth(slot0.viewGO.transform, slot1 and slot0._scaleWidth or slot0._rawWidth)

	slot3 = slot1 and 1.3 or 1

	transformhelper.setLocalScale(slot0._goRole.transform, slot3, slot3, 1)

	if slot0._isSelected then
		slot0._animator:Play("select")
	elseif slot2 then
		slot0._animator:Play("unselect")
	else
		slot0._animator:Play("idle")
	end

	gohelper.setActive(slot0._goAssist, slot0._isSelected and slot0._isPreset)
end

function slot0.onDestroyView(slot0)
	slot0._simageRole:UnLoadImage()
end

return slot0
