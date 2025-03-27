module("modules.logic.fight.view.FightSimplePolarizationLevelView", package.seeall)

slot0 = class("FightSimplePolarizationLevelView", FightBaseView)

function slot0.onInitView(slot0)
	slot0._click = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_level")
	slot0._nameText = gohelper.findChildText(slot0.viewGO, "name")
	slot0._levelText = gohelper.findChildText(slot0.viewGO, "level")
	slot0._tips = gohelper.findChild(slot0.viewGO, "#go_leveltip")
	slot0._btnClose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_leveltip/#btn_close")
	slot0._title = gohelper.findChildText(slot0.viewGO, "#go_leveltip/bg/#txt_title")
	slot0._desc = gohelper.findChildText(slot0.viewGO, "#go_leveltip/bg/#txt_dec")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0._click, slot0._onClick)
	slot0:com_registClick(slot0._btnClose, slot0._onBtnClose)
	slot0:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, slot0._onRefreshSimplePolarizationLevel)
	slot0:com_registFightEvent(FightEvent.TouchFightViewScreen, slot0._onTouchFightViewScreen)
end

function slot0._onTouchFightViewScreen(slot0)
	gohelper.setActive(slot0._tips, false)
end

function slot0._onBtnClose(slot0)
	gohelper.setActive(slot0._tips, false)
end

function slot0._onClick(slot0)
	if FightDataHelper.stageMgr:inReplay() then
		return
	end

	gohelper.setActive(slot0._tips, true)
end

function slot0._onRefreshSimplePolarizationLevel(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot1 = FightDataHelper.tempMgr.simplePolarizationLevel or 0
	slot0._levelText.text = "LV." .. slot1

	if lua_simple_polarization.configDict[slot1] then
		slot0._nameText.text = slot2.name
		slot0._title.text = slot2.name
		slot0._desc.text = HeroSkillModel.instance:skillDesToSpot(slot2.desc, "#c56131", "#7c93ad")
	else
		logError("减震表找不到等级:" .. slot1)
	end
end

return slot0
