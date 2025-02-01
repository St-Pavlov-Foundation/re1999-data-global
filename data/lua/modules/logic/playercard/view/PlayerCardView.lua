module("modules.logic.playercard.view.PlayerCardView", package.seeall)

slot0 = class("PlayerCardView", BaseView)

function slot0.onInitView(slot0)
	slot0.goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0.btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail/#btn_click")
	slot0.goPlayerInfo = gohelper.findChild(slot0.goRight, "#go_playerinfo")
	slot0.goAssit = gohelper.findChild(slot0.goRight, "#go_assit")
	slot0.goChapter = gohelper.findChild(slot0.goRight, "#go_chapter")
	slot0.goCardGroup = gohelper.findChild(slot0.goRight, "#go_cardgroup")
	slot0.goAchievement = gohelper.findChild(slot0.goRight, "#go_achievement")

	slot0:loadRight()
	slot0:initRightLayout()

	slot0.gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0.btnCloseTips = gohelper.findChildButtonWithAudio(slot0.gotips, "#btn_close")
	slot0.goTipsNode = gohelper.findChild(slot0.gotips, "node")
	slot0.btnLayout = gohelper.findChildButtonWithAudio(slot0.goTipsNode, "#btn_layout")
	slot0.btnChangeSkin = gohelper.findChildButtonWithAudio(slot0.goTipsNode, "#btn_changeskin")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnCloseTips, slot0.onClickCloseTips, slot0)
	slot0:addClickCb(slot0.btnLayout, slot0.onClickLayout, slot0)
	slot0:addClickCb(slot0.btnChangeSkin, slot0.onClickChangeSkin, slot0)
	slot0:addClickCb(slot0.btnDetail, slot0.onClickDetail, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.PlayerbassinfoChange, slot0.onPlayerBaseInfoChange, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, slot0.refreshView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowListBtn, slot0.onShowListBtn, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onShowListBtn(slot0, slot1)
	gohelper.setActive(slot0.gotips, true)

	slot3, slot4 = recthelper.rectToRelativeAnchorPos2(slot1.transform.position, slot0.gotips.transform)

	recthelper.setAnchor(slot0.goTipsNode.transform, slot3 - 190, slot4 - 105)
end

function slot0.onClickCloseTips(slot0)
	gohelper.setActive(slot0.gotips, false)
end

function slot0.onClickLayout(slot0)
	gohelper.setActive(slot0.gotips, false)
	ViewMgr.instance:openView(ViewName.PlayerCardLayoutView, {
		userId = slot0.userId
	})
end

function slot0.onClickChangeSkin(slot0)
	gohelper.setActive(slot0.gotips, false)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowTheme)
end

function slot0.onClickDetail(slot0)
	if not slot0:getCardInfo() then
		return
	end

	slot0:closeThis()
	PlayerController.instance:openPlayerView(slot1:getPlayerInfo(), slot1:isSelf())
end

function slot0.initRightLayout(slot0)
	slot0.rightLayout = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goRight, PlayerCardLayout)
	slot1 = {}

	table.insert(slot1, slot0:getLayoutItem(slot0.goAssit, PlayerCardEnum.RightLayout.Assit))
	table.insert(slot1, slot0:getLayoutItem(slot0.goChapter, PlayerCardEnum.RightLayout.Chapter))
	table.insert(slot1, slot0:getLayoutItem(slot0.goCardGroup, PlayerCardEnum.RightLayout.CardGroup, PlayerCardLayoutItemCardGroup, slot0.cardGroupComp))
	table.insert(slot1, slot0:getLayoutItem(slot0.goAchievement, PlayerCardEnum.RightLayout.Achievement))
	slot0.rightLayout:setLayoutList(slot1)
end

function slot0.getLayoutItem(slot0, slot1, slot2, slot3, slot4)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot1, slot3 or PlayerCardLayoutItem, {
		layoutKey = slot2,
		viewRoot = slot0.viewGO,
		layout = slot0.rightLayout,
		cardComp = slot4
	})
end

function slot0.refreshLayout(slot0, slot1)
	slot0.rightLayout:setEditMode(false)
	slot0.rightLayout:setData(slot1:getLayoutData())
end

function slot0.loadRight(slot0)
	slot0.compList = {}
	slot1 = slot0.viewContainer:getSetting().otherRes

	slot0:loadGO(slot0.goPlayerInfo, PlayerCardPlayerInfo, slot1.infoview)
	slot0:loadGO(slot0.goAssit, PlayerCardAssit, slot1.assitview)
	slot0:loadGO(slot0.goChapter, PlayerCardChapter, slot1.chapterview)
	slot0:loadGO(slot0.goAchievement, PlayerCardAchievement, slot1.achieveview, {
		itemRes = slot0.viewContainer:getRes(slot1.achieveitem)
	})

	slot0.cardGroupComp = slot0:loadGO(slot0.goCardGroup, PlayerCardCardGroup, slot1.groupview, {
		itemRes = slot0.viewContainer:getRes(slot1.carditem)
	})
end

function slot0.loadGO(slot0, slot1, slot2, slot3, slot4)
	gohelper.setAsFirstSibling(slot0:getResInst(slot3, gohelper.findChild(slot1, "card") or slot1))

	slot4 = slot4 or {}
	slot4.compType = PlayerCardEnum.CompType.Normal
	slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot6, slot2, slot4)

	table.insert(slot0.compList, slot7)

	return slot7
end

function slot0.onPlayerBaseInfoChange(slot0, slot1)
	if slot1.userId == slot0.userId then
		slot0:refreshView()
	end
end

function slot0.onOpen(slot0)
	slot0:_updateParam()
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:_updateParam()
	slot0:refreshView()
end

function slot0._updateParam(slot0)
	slot0.userId = slot0.viewParam.userId
end

function slot0.getCardInfo(slot0)
	return PlayerCardModel.instance:getCardInfo(slot0.userId)
end

function slot0.refreshView(slot0)
	if not slot0:getCardInfo() then
		return
	end

	slot0:refreshCompList(slot1)
	slot0:refreshLayout(slot1)
end

function slot0.refreshCompList(slot0, slot1)
	if not slot0.compList then
		return
	end

	for slot5, slot6 in ipairs(slot0.compList) do
		slot6:refreshView(slot1)
	end
end

function slot0.onClose(slot0)
end

return slot0
