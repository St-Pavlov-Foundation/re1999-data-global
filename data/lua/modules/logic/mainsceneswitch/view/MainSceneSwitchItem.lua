module("modules.logic.mainsceneswitch.view.MainSceneSwitchItem", package.seeall)

slot0 = class("MainSceneSwitchItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_icon")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_normal/#go_Locked")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_normal/#go_reddot")
	slot0._goTag = gohelper.findChild(slot0.viewGO, "#go_Tag")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")

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
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._animatorPlayer.animator.enabled = false
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClick(slot0)
	if slot0._isSelect then
		return
	end

	if slot0._showReddot then
		MainSceneSwitchController.closeSceneReddot(slot0._mo.id)
		slot0:_updateReddot()
	end

	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ClickSwitchItem, slot0._mo, slot0._index)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._simageicon:LoadImage(ResUrl.getMainSceneSwitchIcon(slot1.icon))

	slot2 = MainSceneSwitchModel.instance:getCurSceneId() == slot0._mo.id

	gohelper.setActive(slot0._goTag, slot2)
	slot0:onSelect(MainSceneSwitchListModel.instance:getSelectedCellIndex() == slot0._index)

	if slot2 then
		if slot3 then
			recthelper.setAnchorY(slot0._goTag.transform, 55)
		else
			recthelper.setAnchorY(slot0._goTag.transform, 40)
		end
	end

	slot5 = MainSceneSwitchModel.getSceneStatus(slot0._mo.id) == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(slot0._goLocked, not slot5)
	ZProj.UGUIHelper.SetGrayscale(slot0._simageicon.gameObject, not slot5)
	slot0:_updateReddot()
end

function slot0._updateReddot(slot0)
	slot0._showReddot = MainSceneSwitchController.sceneHasReddot(slot0._mo.id)

	gohelper.setActive(slot0._goreddot, slot0._showReddot)
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0._goselected:SetActive(slot1)

	if slot0._isSelect ~= nil and slot2 ~= slot1 then
		slot0._animPlaying = true

		if slot1 then
			slot0._animatorPlayer:Play("select", slot0._onAnimDone, slot0)
		else
			slot0._animatorPlayer:Play("unselect", slot0._onAnimDone, slot0)
		end
	end

	if slot0._animPlaying then
		return
	end

	slot0:_onAnimDone()
end

function slot0._onAnimDone(slot0)
	slot0._animPlaying = false
	slot1 = slot0._isSelect and 1 or MainSceneSwitchEnum.ItemUnSelectedScale

	transformhelper.setLocalScale(slot0._gonormal.transform, slot1, slot1, 1)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
