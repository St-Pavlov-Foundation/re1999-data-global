module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightRuleTipView", package.seeall)

slot0 = class("Season123_1_9FightRuleTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close1")
	slot0._btnClose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close2")
	slot0._goLabel = gohelper.findChild(slot0.viewGO, "root/top/#btn_label")
	slot0._goCard = gohelper.findChild(slot0.viewGO, "root/top/#btn_card")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_rightbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose1:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnClose2:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose1:RemoveClickListener()
	slot0._btnClose2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.labelTab = slot0:createTab(slot0._goLabel, Activity123Enum.RuleTab.Rule)
	slot0.cardTab = slot0:createTab(slot0._goCard, Activity123Enum.RuleTab.Card)

	slot0._simageleftbg:LoadImage(ResUrl.getSeasonIcon("img_bg_light2.png"))
	slot0._simagerightbg:LoadImage(ResUrl.getSeasonIcon("img_bg_light1.png"))
end

function slot0._btncloseOnClick(slot0)
	slot0:_closeView()
end

function slot0._closeView(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._ruleList = SeasonFightRuleView.getRuleList()
	slot0._cardList = Season123Model.instance:getFightCardDataList()

	if #slot0._ruleList > 0 then
		slot0:switchTab(Activity123Enum.RuleTab.Rule)
	else
		slot0:switchTab(Activity123Enum.RuleTab.Card)
	end

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0.createTab(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = slot1
	slot3.tabType = slot2
	slot3.goUnSelect = gohelper.findChild(slot1, "unselect")
	slot3.goSelect = gohelper.findChild(slot1, "selected")
	slot3.btn = gohelper.findButtonWithAudio(slot1)

	slot3.btn:AddClickListener(slot0.onClickTab, slot0, slot3)

	return slot3
end

function slot0.updateTab(slot0, slot1, slot2, slot3)
	if slot2 then
		slot4 = slot0.tabType == slot1.tabType

		gohelper.setActive(slot1.go, true)
		gohelper.setActive(slot1.goSelect, slot4)
		gohelper.setActive(slot1.goUnSelect, not slot4)
	else
		gohelper.setActive(slot1.go, false)
	end
end

function slot0.destroyTab(slot0, slot1)
	if slot1 then
		slot1.btn:RemoveClickListener()
	end
end

function slot0.onClickTab(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:switchTab(slot1.tabType)
end

function slot0.switchTab(slot0, slot1)
	if slot0.tabType == slot1 then
		return
	end

	slot0.tabType = slot1
	slot3 = slot0:getTabActive(slot0.cardTab.tabType)

	if slot0:getTabActive(slot0.labelTab.tabType) then
		slot4 = 0 + 1
	end

	if slot3 then
		slot4 = slot4 + 1
	end

	slot0:updateTab(slot0.labelTab, slot2, slot4)
	slot0:updateTab(slot0.cardTab, slot3, slot4)
	slot0.viewContainer:switchTab(slot1)
end

function slot0.getTabActive(slot0, slot1)
	if slot1 == Activity123Enum.RuleTab.Card then
		return slot0._cardList and #slot0._cardList > 0
	end

	return slot0._ruleList and #slot0._ruleList > 0
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:destroyTab(slot0.labelTab)
	slot0:destroyTab(slot0.cardTab)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
