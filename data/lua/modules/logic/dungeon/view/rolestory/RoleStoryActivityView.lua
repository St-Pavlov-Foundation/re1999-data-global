module("modules.logic.dungeon.view.rolestory.RoleStoryActivityView", package.seeall)

slot0 = class("RoleStoryActivityView", BaseView)

function slot0.onInitView(slot0)
	slot0._actViewGO = gohelper.findChild(slot0.viewGO, "actview")
	slot0.btnMonster = gohelper.findChildButtonWithAudio(slot0._actViewGO, "BG/#simage_frame")
	slot0.simageMonster = gohelper.findChildSingleImage(slot0._actViewGO, "BG/#simage_frame/#simage_photo")
	slot0.itemPos = gohelper.findChild(slot0._actViewGO, "BG/itemPos")
	slot0.timeTxt = gohelper.findChildTextMesh(slot0._actViewGO, "timebg/#txt_time")
	slot0.btnEnter = gohelper.findChildButtonWithAudio(slot0._actViewGO, "#btn_enter")
	slot0.goEnterRed = gohelper.findChild(slot0._actViewGO, "#btn_enter/#go_reddot")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0._actViewGO, "BG/title/ani/#txt_title")
	slot0.txtTitleEn = gohelper.findChildTextMesh(slot0._actViewGO, "BG/title/ani/#txt_en")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnEnter:AddClickListener(slot0._btnenterOnClick, slot0)
	slot0.btnMonster:AddClickListener(slot0._btnenterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnEnter:RemoveClickListener()
	slot0.btnMonster:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	RedDotController.instance:addRedDot(slot0.goEnterRed, RedDotEnum.DotNode.RoleStoryChallenge)
end

function slot0._btnscoreOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function slot0._btnenterOnClick(slot0)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeMainViewShow, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.refreshView(slot0)
	slot0.storyId = RoleStoryModel.instance:getCurActStoryId()
	slot0.storyMo = RoleStoryModel.instance:getById(slot0.storyId)

	if not slot0.storyMo then
		return
	end

	slot0:refreshMonsterItem()
	slot0:refreshRoleItem()
	slot0:refreshLeftTime()
	slot0:refreshTitle()
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshLeftTime, slot0, 1)
end

function slot0.refreshTitle(slot0)
	if not slot0.storyMo then
		return
	end

	slot1 = slot0.storyMo.cfg.name
	slot3 = GameUtil.utf8sub(slot1, 1, 1)
	slot4 = ""
	slot5 = ""

	if GameUtil.utf8len(slot1) > 1 then
		slot4 = GameUtil.utf8sub(slot1, 2, 2)
	end

	if slot2 > 3 then
		slot5 = GameUtil.utf8sub(slot1, 4, slot2 - 3)
	end

	slot0.txtTitle.text = string.format("<size=99>%s</size><size=70>%s</size>%s", slot3, slot4, slot5)
	slot0.txtTitleEn.text = slot0.storyMo.cfg.nameEn
end

function slot0.refreshMonsterItem(slot0)
	if not slot0.storyMo then
		return
	end

	slot0.simageMonster:LoadImage(string.format("singlebg/dungeon/rolestory_photo_singlebg/%s_2.png", slot0.storyMo.cfg.monster_pic))
end

function slot0.refreshRoleItem(slot0)
	if not slot0.roleItem then
		slot1 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot0.itemPos)
		slot0.roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, RoleStoryActivityItem)

		slot0.roleItem:initInternal(slot1, slot0)
	end

	slot0.roleItem:onUpdateMO(slot0.storyMo)
end

function slot0.refreshLeftTime(slot0)
	if not slot0.storyMo then
		return
	end

	slot2, slot3 = slot1:getActTime()

	if slot3 - ServerTime.now() > 0 then
		slot0.timeTxt.text = slot0:_getTimeText(slot4)
	else
		TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
end

function slot0._getTimeText(slot0, slot1)
	slot2, slot3, slot4, slot5 = TimeUtil.secondsToDDHHMMSS(slot1)

	if LangSettings.instance:isEn() then
		slot6 = luaLang("time_day") .. " "
		slot7 = luaLang("time_hour2") .. " "
		slot8 = luaLang("time_minute2") .. " "
		slot9 = luaLang("activity_remain") .. " "
	end

	slot10 = "<color=#f09a5a>%s</color>%s<color=#f09a5a>%s</color>%s"
	slot11 = nil

	return slot9 .. ((slot2 <= 0 or string.format(slot10, slot2, slot6, slot3, luaLang("time_hour2"))) and (slot3 <= 0 or string.format(slot10, slot3, slot7, slot4, luaLang("time_minute2"))) and string.format(slot10, slot4, slot8, slot5, luaLang("time_second")))
end

return slot0
