module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleItem", package.seeall)

local var_0_0 = class("EliminateSelectRoleItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "#go_Role")
	arg_1_0._goRoleSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Role/#go_RoleSelected")
	arg_1_0._imageRoleBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_Role/#image_RoleBG")
	arg_1_0._imageRoleHPBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_Role/#image_RoleHPBG")
	arg_1_0._imageRoleHPFG = gohelper.findChildImage(arg_1_0.viewGO, "#go_Role/#image_RoleHPFG")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Role/image/#simage_Role")
	arg_1_0._imageRoleHPNumBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_Role/#image_RoleHPNumBG")
	arg_1_0._txtRoleHP = gohelper.findChildText(arg_1_0.viewGO, "#go_Role/#image_RoleHPNumBG/#txt_RoleHP")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Role/#go_Locked")
	arg_1_0._goRoleName1 = gohelper.findChild(arg_1_0.viewGO, "RoleName/#go_RoleName1")
	arg_1_0._txtRoleName = gohelper.findChildText(arg_1_0.viewGO, "RoleName/#go_RoleName1/#txt_RoleName")
	arg_1_0._goRoleName2 = gohelper.findChild(arg_1_0.viewGO, "RoleName/#go_RoleName2")
	arg_1_0._txtRoleName2 = gohelper.findChildText(arg_1_0.viewGO, "RoleName/#go_RoleName2/#txt_RoleName2")
	arg_1_0._goAssist = gohelper.findChild(arg_1_0.viewGO, "#go_Assist")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0.viewGO)
	arg_4_0._rawWidth = recthelper.getWidth(arg_4_0.viewGO.transform)
	arg_4_0._scaleWidth = 330
	arg_4_0._animator = arg_4_0.viewGO:GetComponent("Animator")
end

function var_0_0._onClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not arg_5_0._isUnlock then
		return
	end

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ClickCharacter, arg_5_0._index)
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0._click:AddClickListener(arg_6_0._onClick, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._config = arg_8_1
	arg_8_0._index = arg_8_2
	arg_8_0._isPreset = EliminateTeamSelectionModel.instance:isPreset()
	arg_8_0._isUnlock = EliminateTeamSelectionModel.instance:hasCharacterOrPreset(arg_8_0._config.id)

	gohelper.setActive(arg_8_0._goLocked, not arg_8_0._isUnlock)

	if arg_8_0._isUnlock and not EliminateMapController.hasOnceActionKey(EliminateMapEnum.PrefsKey.RoleUnlock, arg_8_0._config.id) then
		EliminateMapController.setOnceActionKey(EliminateMapEnum.PrefsKey.RoleUnlock, arg_8_0._config.id)
		gohelper.setActive(arg_8_0._goLocked, true)
		arg_8_0._goLocked:GetComponent("Animator"):Play("unlock")
	end

	arg_8_0._txtRoleName.text = arg_8_0._config.name
	arg_8_0._txtRoleName2.text = arg_8_0._config.name
	arg_8_0._txtRoleHP.text = arg_8_0._config.hp

	arg_8_0._simageRole:LoadImage(ResUrl.getHeadIconSmall(arg_8_0._config.resPic))
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._imageRoleBG.gameObject, not arg_8_0._isUnlock)
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._simageRole.gameObject, not arg_8_0._isUnlock)
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._imageRoleHPBG.gameObject, not arg_8_0._isUnlock)
	gohelper.setActive(arg_8_0._imageRoleHPFG, arg_8_0._isUnlock)
	gohelper.setActive(arg_8_0._imageRoleHPNumBG, arg_8_0._isUnlock)
end

function var_0_0.isUnlocked(arg_9_0)
	return arg_9_0._isUnlock
end

function var_0_0.getConfig(arg_10_0)
	return arg_10_0._config
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._isSelected

	arg_11_0._isSelected = arg_11_1

	gohelper.setActive(arg_11_0._goRoleSelected, arg_11_1)
	gohelper.setActive(arg_11_0._goRoleName1, arg_11_1 and arg_11_0._isUnlock)
	gohelper.setActive(arg_11_0._goRoleName2, not arg_11_1 and arg_11_0._isUnlock)
	recthelper.setWidth(arg_11_0.viewGO.transform, arg_11_1 and arg_11_0._scaleWidth or arg_11_0._rawWidth)

	local var_11_1 = arg_11_1 and 1.3 or 1

	transformhelper.setLocalScale(arg_11_0._goRole.transform, var_11_1, var_11_1, 1)

	if arg_11_0._isSelected then
		arg_11_0._animator:Play("select")
	elseif var_11_0 then
		arg_11_0._animator:Play("unselect")
	else
		arg_11_0._animator:Play("idle")
	end

	gohelper.setActive(arg_11_0._goAssist, arg_11_0._isSelected and arg_11_0._isPreset)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageRole:UnLoadImage()
end

return var_0_0
