module("modules.logic.achievement.view.AchievementMainIcon", package.seeall)

slot0 = class("AchievementMainIcon", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1

	slot0:initComponents()
end

function slot0.initComponents(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#image_icon")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._index = gohelper.findChildText(slot0.viewGO, "#go_select/#txt_index")
	slot0._goBadgeBG = gohelper.findChild(slot0.viewGO, "#go_BadgeBG")
	slot0._goBadgeGetBG = gohelper.findChild(slot0.viewGO, "#go_BadgeGetBG")
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.setData(slot0, slot1)
	slot0.taskCO = slot1
	slot0._animClipName = nil
	slot0._isBgVisible = true

	slot0:refreshUI()
end

function slot0.getTaskCO(slot0)
	return slot0.taskCO
end

function slot0.setIsLocked(slot0, slot1)
	gohelper.setActive(slot0._goLocked, slot1)
end

function slot0.setIconColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageicon, slot1 or "#FFFFFF")
end

function slot0.setIconVisible(slot0, slot1)
	gohelper.setActive(slot0._imageicon.gameObject, slot1)
end

function slot0.setBgVisible(slot0, slot1)
	slot0._isBgVisible = slot1

	slot0:refreshBg()
end

function slot0.refreshBg(slot0)
	slot1 = false

	if slot0._isBgVisible then
		slot1 = AchievementModel.instance:isAchievementTaskFinished(slot0.taskCO and slot0.taskCO.id)
	end

	gohelper.setActive(slot0._goBadgeBG.gameObject, slot0._isBgVisible and not slot1)
	gohelper.setActive(slot0._goBadgeGetBG.gameObject, slot0._isBgVisible and slot1)
end

function slot0.setNameTxtAlpha(slot0, slot1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtname, slot1 or 1)
end

function slot0.setNameTxtVisible(slot0, slot1)
	gohelper.setActive(slot0._txtname, slot1)
end

function slot0.setSelectIconVisible(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.setSelectIndex(slot0, slot1)
	slot0._index.text = tostring(slot1)
end

function slot0.refreshUI(slot0)
	if AchievementConfig.instance:getAchievement(slot0.taskCO.achievementId) then
		slot0._txtname.text = slot1.name
	end

	slot0._simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. slot0.taskCO.icon))
	slot0:refreshBg()
end

function slot0.setClickCall(slot0, slot1, slot2, slot3)
	slot0._clickCallback = slot1
	slot0._clickCallbackObj = slot2
	slot0._clickParam = slot3

	if not slot0._btnself then
		slot0._btnself = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_self")

		slot0._btnself:AddClickListener(slot0.onClickSelf, slot0)
	end
end

function slot0.onClickSelf(slot0)
	if slot0._clickCallback then
		slot0._clickCallback(slot0._clickCallbackObj, slot0._clickParam)
	end
end

slot0.AnimClip = {
	New = "unlock",
	Idle = "idle",
	Loop = "loop"
}

function slot0.playAnim(slot0, slot1)
	slot0._animator:Play(slot1, 0, 0)
end

function slot0.isPlaingAnimClip(slot0, slot1)
	return slot0._animator:GetCurrentAnimatorStateInfo(0):IsName(slot1)
end

function slot0.dispose(slot0)
	slot0._clickCallback = nil
	slot0._clickCallbackObj = nil
	slot0._clickParam = nil

	if slot0._btnself then
		slot0._btnself:RemoveClickListener()

		slot0._btnself = nil
	end

	slot0._simageicon:UnLoadImage()
	slot0:__onDispose()
end

return slot0
