module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonBaseGroupItem", package.seeall)

slot0 = class("Act183DungeonBaseGroupItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goselect = gohelper.findChild(slot0.go, "go_select")
	slot0._txtselecttitle = gohelper.findChildText(slot0.go, "go_select/txt_title")
	slot0._gounselect = gohelper.findChild(slot0.go, "go_unselect")
	slot0._txtunselecttitle = gohelper.findChildText(slot0.go, "go_unselect/txt_title")
	slot0._golock = gohelper.findChild(slot0.go, "go_lock")
	slot0._imagelockicon = gohelper.findChildImage(slot0.go, "go_lock/icon")
	slot0._txtlocktitle = gohelper.findChildText(slot0.go, "go_lock/txt_title")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
	slot0._imageselect = gohelper.findChildImage(slot0.go, "go_select/image_Selected")
	slot0._imageunselect = gohelper.findChildImage(slot0.go, "go_unselect/image_UnSelected")
	slot0._imagelock = gohelper.findChildImage(slot0.go, "go_lock/image_Locked")
	slot0._gofinished = gohelper.findChild(slot0.go, "go_finished")
	slot0._goselect_normaleffect = gohelper.findChild(slot0.go, "go_select/vx_normal")
	slot0._goselect_hardeffect = gohelper.findChild(slot0.go, "go_select/vx_hard")
	slot0._animfinish = gohelper.onceAddComponent(slot0._gofinished, gohelper.Type_Animator)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickSwitchGroup, slot0._onClickSwitchGroup, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnGroupAllTaskFinished, slot0._onGroupAllTaskFinished, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not slot0._isUnlock then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	gohelper.setActive(slot0._goselect_normaleffect, slot0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(slot0._goselect_hardeffect, slot0._groupType == Act183Enum.GroupType.HardMain)

	if slot0._groupType ~= Act183Enum.GroupType.Daily then
		Act183Helper.saveLastEnterMainGroupTypeInLocal(Act183Model.instance:getActivityId(), slot0._groupType)
	end

	Act183Controller.instance:dispatchEvent(Act183Event.OnClickSwitchGroup, slot0._groupId)
end

function slot0._onClickSwitchGroup(slot0, slot1)
	slot0:onSelect(slot0._groupId == slot1)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._groupMo = slot1
	slot0._groupId = slot1:getGroupId()
	slot0._groupType = slot1:getGroupType()
	slot0._status = slot1:getStatus()
	slot0._index = slot2
	slot0._isUnlock = slot0._status ~= Act183Enum.GroupStatus.Locked

	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._golock, not slot0._isUnlock)
	slot0:refreshTitleAndBg()
	slot0:refreshGroupTaskProgress()
end

function slot0.refreshTitleAndBg(slot0)
	slot1 = ""
	slot2 = "#E1E1E1"
	slot3 = "#969696"
	slot4 = ""
	slot5 = ""

	if slot0._groupType == Act183Enum.GroupType.NormalMain then
		slot1 = luaLang("act183dungeonview_normalmainepisode")
		slot4 = "v2a5_challenge_dungeon_normaltabselected"
		slot5 = "v2a5_challenge_dungeon_normaltabunselected"
	elseif slot0._groupType == Act183Enum.GroupType.HardMain then
		slot1 = luaLang("act183dungeonview_hardmainepisode")
		slot2 = "#C04E40"
		slot3 = "#C04E40"
		slot4 = "v2a5_challenge_dungeon_hardtabselected"
		slot5 = "v2a5_challenge_dungeon_hardtabunselected"
	else
		slot1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act183dungeonview_dailyepisode"), GameUtil.getRomanNums(slot0._index))
		slot4 = "v2a5_challenge_dungeon_dailytabselected"
		slot5 = "v2a5_challenge_dungeon_dailytabunselected"
	end

	slot0._txtselecttitle.text = slot1
	slot0._txtunselecttitle.text = slot1
	slot0._txtlocktitle.text = slot1

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtselecttitle, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtunselecttitle, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagelockicon, slot3)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtselecttitle, 1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtunselecttitle, 0.5)
	UISpriteSetMgr.instance:setChallengeSprite(slot0._imageselect, slot4)
	UISpriteSetMgr.instance:setChallengeSprite(slot0._imageunselect, slot5)
	UISpriteSetMgr.instance:setChallengeSprite(slot0._imagelock, slot5)
	gohelper.setActive(slot0._goselect_normaleffect, slot0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(slot0._goselect_hardeffect, slot0._groupType == Act183Enum.GroupType.HardMain)
end

function slot0._onFinishTask(slot0)
	slot0:refreshGroupTaskProgress()
end

function slot0.refreshGroupTaskProgress(slot0)
	slot1, slot2 = Act183Helper.getGroupEpisodeTaskProgress(slot0._groupId)

	gohelper.setActive(slot0._gofinished, slot1 <= slot2)
end

function slot0._onGroupAllTaskFinished(slot0, slot1)
	if slot0._groupId ~= slot1 then
		return
	end

	slot0._animfinish:Play("in", 0, 0)
end

function slot0.onUnlock(slot0)
end

function slot0.onLocked(slot0)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot0._isUnlock and slot1)
	gohelper.setActive(slot0._gounselect, slot0._isUnlock and not slot1)
end

function slot0.getHeight(slot0)
	return recthelper.getHeight(slot0.go.transform)
end

function slot0.onDestroy(slot0)
end

return slot0
