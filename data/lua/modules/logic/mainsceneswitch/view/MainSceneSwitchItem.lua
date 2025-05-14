﻿module("modules.logic.mainsceneswitch.view.MainSceneSwitchItem", package.seeall)

local var_0_0 = class("MainSceneSwitchItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_icon")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_Locked")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_reddot")
	arg_1_0._goTag = gohelper.findChild(arg_1_0.viewGO, "#go_Tag")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")

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
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._animatorPlayer.animator.enabled = false
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._onClick(arg_7_0)
	if arg_7_0._isSelect then
		return
	end

	if arg_7_0._showReddot then
		MainSceneSwitchController.closeSceneReddot(arg_7_0._mo.id)
		arg_7_0:_updateReddot()
	end

	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ClickSwitchItem, arg_7_0._mo, arg_7_0._index)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0._simageicon:LoadImage(ResUrl.getMainSceneSwitchIcon(arg_8_1.icon))

	local var_8_0 = MainSceneSwitchModel.instance:getCurSceneId() == arg_8_0._mo.id

	gohelper.setActive(arg_8_0._goTag, var_8_0)

	local var_8_1 = MainSceneSwitchListModel.instance:getSelectedCellIndex() == arg_8_0._index

	arg_8_0:onSelect(var_8_1)

	if var_8_0 then
		if var_8_1 then
			recthelper.setAnchorY(arg_8_0._goTag.transform, 55)
		else
			recthelper.setAnchorY(arg_8_0._goTag.transform, 40)
		end
	end

	local var_8_2 = MainSceneSwitchModel.getSceneStatus(arg_8_0._mo.id) == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(arg_8_0._goLocked, not var_8_2)
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._simageicon.gameObject, not var_8_2)
	arg_8_0:_updateReddot()
end

function var_0_0._updateReddot(arg_9_0)
	arg_9_0._showReddot = MainSceneSwitchController.sceneHasReddot(arg_9_0._mo.id)

	gohelper.setActive(arg_9_0._goreddot, arg_9_0._showReddot)
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._isSelect

	arg_10_0._isSelect = arg_10_1

	arg_10_0._goselected:SetActive(arg_10_1)

	if var_10_0 ~= nil and var_10_0 ~= arg_10_1 then
		arg_10_0._animPlaying = true

		if arg_10_1 then
			arg_10_0._animatorPlayer:Play("select", arg_10_0._onAnimDone, arg_10_0)
		else
			arg_10_0._animatorPlayer:Play("unselect", arg_10_0._onAnimDone, arg_10_0)
		end
	end

	if arg_10_0._animPlaying then
		return
	end

	arg_10_0:_onAnimDone()
end

function var_0_0._onAnimDone(arg_11_0)
	arg_11_0._animPlaying = false

	local var_11_0 = arg_11_0._isSelect and 1 or MainSceneSwitchEnum.ItemUnSelectedScale

	transformhelper.setLocalScale(arg_11_0._gonormal.transform, var_11_0, var_11_0, 1)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageicon:UnLoadImage()
end

return var_0_0
