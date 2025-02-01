module("modules.logic.activity.view.show.ActivityClassShowView", package.seeall)

slot0 = class("ActivityClassShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "title/#txt_desc")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/rewardPreview/#scroll_reward")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
end

slot0.ShowCount = 1
slot0.unlimitDay = 42

function slot0._btnjumpOnClick(slot0)
	if not DungeonModel.instance:getLastEpisodeShowData() then
		return
	end

	if TeachNoteModel.instance:isTeachNoteUnlock() then
		slot4 = slot1.chapterId

		TeachNoteModel.instance:setJumpEnter(false)
		DungeonController.instance:jumpDungeon({
			chapterType = lua_chapter.configDict[slot4].type,
			chapterId = slot4,
			episodeId = slot1.id
		})
	else
		GameFacade.showToast(ToastEnum.ClassShow)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_class_bg"))
	gohelper.setActive(slot0._gorewarditem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._rewardItems = slot0:getUserDataTb_()

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._config = ActivityConfig.instance:getActivityShowTaskList(slot0._actId, 1)
	slot0._txtdesc.text = slot0._config.actDesc
	slot1, slot2 = ActivityModel.instance:getRemainTime(slot0._actId)
	slot0._txttime.text = uv0.unlimitDay < slot1 and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), slot1, slot2)

	for slot7 = 1, #string.split(slot0._config.showBonus, "|") do
		if not slot0._rewardItems[slot7] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.clone(slot0._gorewarditem, slot0._gorewardContent, "rewarditem" .. slot7)
			slot8.item = IconMgr.instance:getCommonPropItemIcon(slot8.go)

			table.insert(slot0._rewardItems, slot8)
		end

		gohelper.setActive(slot0._rewardItems[slot7].go, true)

		slot9 = string.splitToNumber(slot3[slot7], "#")

		slot0._rewardItems[slot7].item:setMOValue(slot9[1], slot9[2], slot9[3])
		slot0._rewardItems[slot7].item:isShowCount(slot9[4] == uv0.ShowCount)
		slot0._rewardItems[slot7].item:setCountFontSize(56)
		slot0._rewardItems[slot7].item:setHideLvAndBreakFlag(true)
		slot0._rewardItems[slot7].item:hideEquipLvAndBreak(true)
	end

	for slot7 = #slot3 + 1, #slot0._rewardItems do
		gohelper.setActive(slot0._rewardItems[slot7].go, false)
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.DungeonMapView then
		TeachNoteController.instance:enterTeachNoteView(nil, false)
		ViewMgr.instance:closeView(ViewName.ActivityWelfareView, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
