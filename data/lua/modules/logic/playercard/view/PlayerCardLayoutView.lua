module("modules.logic.playercard.view.PlayerCardLayoutView", package.seeall)

slot0 = class("PlayerCardLayoutView", BaseView)

function slot0.onInitView(slot0)
	slot0.goCard = gohelper.findChild(slot0.viewGO, "Card")
	slot0.goPlayerInfo = gohelper.findChild(slot0.goCard, "#go_playerinfo")
	slot0.goAssit = gohelper.findChild(slot0.goCard, "#go_assit")
	slot0.goChapter = gohelper.findChild(slot0.goCard, "#go_chapter")
	slot0.goCardGroup = gohelper.findChild(slot0.goCard, "#go_cardgroup")
	slot0.goAchievement = gohelper.findChild(slot0.goCard, "#go_achievement")

	slot0:loadRight()
	slot0:initRightLayout()

	slot0.btnConfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0.animator = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnConfirm, slot0.onClicConfirm, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.playCloseAnim(slot0)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.CloseLayout)
	slot0.animator:Play("close", slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:closeThis()
end

function slot0.onClicConfirm(slot0)
	if slot0:getCardInfo() then
		PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(slot2:getSetting({
			[PlayerCardEnum.SettingKey.RightLayout] = slot0.rightLayout:getLayoutData()
		}))
	end

	slot0:playCloseAnim()
end

function slot0.initRightLayout(slot0)
	slot0.rightLayout = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goCard, PlayerCardLayout)
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
	slot0.rightLayout:setEditMode(true)
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
	slot4.compType = PlayerCardEnum.CompType.Layout
	slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot6, slot2, slot4)

	table.insert(slot0.compList, slot7)

	return slot7
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
	slot1 = slot0:getCardInfo()

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
