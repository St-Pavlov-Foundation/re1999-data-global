module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailItem", package.seeall)

slot0 = class("Activity132CollectDetailItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._viewGO = slot1
	slot0._goTips = gohelper.findChild(slot1, "tips")
	slot0._txtLock = gohelper.findChildTextMesh(slot0._goTips, "txt_Lock")
	slot0._goDesc = gohelper.findChild(slot1, "txtDesc")
	slot0._txtDesc = slot0._goDesc:GetComponent(gohelper.Type_TextMesh)
	slot0._animTxt = slot0._goDesc:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.setData(slot0, slot1, slot2)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0._viewGO, false)

		return
	end

	gohelper.setActive(slot0._viewGO, true)
	slot0:refreshState()
end

function slot0.refreshState(slot0)
	if not slot0.data then
		return
	end

	slot0._txtDesc.text = slot0.data:getContent()
	slot0._txtLock.text = slot0.data:getUnlockDesc()

	gohelper.setActive(slot0._goTips, Activity132Model.instance:getContentState(slot0.data.activityId, slot0.data.contentId) ~= Activity132Enum.ContentState.Unlock)
	gohelper.setActive(slot0._goDesc, slot1 == Activity132Enum.ContentState.Unlock)
end

function slot0.playUnlock(slot0)
	slot0:refreshState()
	slot0._animTxt:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
