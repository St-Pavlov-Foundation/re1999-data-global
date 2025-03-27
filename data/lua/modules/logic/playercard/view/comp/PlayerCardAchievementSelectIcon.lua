module("modules.logic.playercard.view.comp.PlayerCardAchievementSelectIcon", package.seeall)

slot0 = class("PlayerCardAchievementSelectIcon", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0.iconGO = slot2

	slot0:initComponents()
end

function slot0.initComponents(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._icon = AchievementMainIcon.New()

	slot0._icon:init(slot0.iconGO)
	slot0._icon:setClickCall(slot0.onClickSelf, slot0)
	gohelper.addChild(slot0._goicon, slot0.iconGO)
end

function slot0.setData(slot0, slot1)
	slot0.taskCO = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._icon:setData(slot0.taskCO)
	slot0._icon:setBgVisible(true)

	slot1 = PlayerCardAchievementSelectListModel.instance:isSingleSelected(slot0.taskCO.id)

	slot0._icon:setSelectIconVisible(slot1)

	if slot1 then
		slot0._icon:setSelectIndex(PlayerCardAchievementSelectListModel.instance:getSelectOrderIndex(slot0.taskCO.id))
	end
end

function slot0.onClickSelf(slot0)
	PlayerCardAchievementSelectController.instance:changeSingleSelect(slot0.taskCO.id)
	AudioMgr.instance:trigger(PlayerCardAchievementSelectListModel.instance:isSingleSelected(slot0.taskCO.id) and AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone)
end

function slot0.dispose(slot0)
	if slot0._icon then
		slot0._icon:dispose()
	end

	slot0:__onDispose()
end

return slot0
