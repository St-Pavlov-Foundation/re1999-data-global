module("modules.logic.achievement.view.AchievementEntryView", package.seeall)

slot0 = class("AchievementEntryView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "go_righttop/Total/#txt_total")
	slot0._txtlevel1 = gohelper.findChildText(slot0.viewGO, "go_righttop/Level1/#txt_level1")
	slot0._txtlevel2 = gohelper.findChildText(slot0.viewGO, "go_righttop/Level2/#txt_level2")
	slot0._txtlevel3 = gohelper.findChildText(slot0.viewGO, "go_righttop/Level3/#txt_level3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_mainfullbg"))

	slot0._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity
	}
	slot0._typeItems = {}
end

function slot0.onDestroyView(slot0)
	AchievementEntryController.instance:onCloseView()

	for slot4, slot5 in pairs(slot0._typeItems) do
		slot5.btnself:RemoveClickListener()
		slot5.simageicon:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
end

function slot0.onOpen(slot0)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, slot0.refreshCategoryItems, slot0)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievementState, slot0.updateAchievementState, slot0)
	AchievementEntryController.instance:onOpenView()
	slot0:refreshUI()
end

function slot0.updateAchievementState(slot0)
	AchievementEntryController.instance:updateAchievementState()
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, slot0.refreshCategoryItems, slot0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievementState, slot0.updateAchievementState, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshCategoryItems()
	slot0:refreshLevelCollect()
end

slot0.LevelNum = 3

function slot0.refreshLevelCollect(slot0)
	slot4 = AchievementEntryModel.instance
	slot4 = slot4.getTotalFinishedCount
	slot0._txttotal.text = tostring(slot4(slot4))

	for slot4 = 1, uv0.LevelNum do
		slot0["_txtlevel" .. tostring(slot4)].text = string.format("%s", AchievementEntryModel.instance:getLevelCount(slot4))
	end
end

function slot0.refreshCategoryItems(slot0)
	for slot4, slot5 in ipairs(slot0._focusTypes) do
		slot0:refreshCategoryItem(slot4, slot5)
	end
end

function slot0.refreshCategoryItem(slot0, slot1, slot2)
	slot3 = slot0:getOrCreateCategory(slot1)
	slot4, slot5 = AchievementEntryModel.instance:getFinishCount(slot2)
	slot3.txtprogress.text = string.format("<color=#c9c9c9><size=56>%s</size><size=40>/</size></color>%s", slot4, slot5)
	slot3.txtname.text = luaLang("achievemententryview_type_" .. slot2)

	slot3.simageicon:LoadImage(ResUrl.getAchievementIcon("achievement_mainitem" .. slot1))
end

function slot0.getOrCreateCategory(slot0, slot1)
	if not slot0._typeItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.findChild(slot0.viewGO, "go_books/#go_item" .. tostring(slot1))
		slot2.txtprogress = gohelper.findChildText(slot2.go, "#txt_progress")
		slot2.txtname = gohelper.findChildText(slot2.go, "#txt_name")
		slot2.btnself = gohelper.findChildButtonWithAudio(slot2.go, "#btn_self")

		slot2.btnself:AddClickListener(slot0.onClickCategory, slot0, slot1)

		slot2.reddot = RedDotController.instance:addRedDot(gohelper.findChild(slot2.go, "go_reddot"), RedDotEnum.DotNode.AchievementFinish, slot0._focusTypes[slot1])
		slot2.simageicon = gohelper.findChildSingleImage(slot2.go, "#btn_self")
		slot0._typeItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClickCategory(slot0, slot1)
	AchievementController.instance:openAchievementMainView(slot0._focusTypes[slot1])
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
end

return slot0
