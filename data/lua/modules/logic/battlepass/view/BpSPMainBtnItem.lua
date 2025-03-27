module("modules.logic.battlepass.view.BpSPMainBtnItem", package.seeall)

slot0 = class("BpSPMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = gohelper.cloneInPlace(slot1)
	slot0._goexpup = gohelper.findChild(slot0.go, "#go_expup")

	gohelper.setActive(slot0._goexpup, BpModel.instance:isShowExpUp())
	gohelper.setActive(slot0.go, true)

	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.getClickWithAudio(gohelper.findChild(slot0.go, "bg"), AudioEnum.UI.play_ui_role_pieces_open)
	slot0._reddotitem = gohelper.findChild(slot0.go, "go_activityreddot")

	slot0:_refreshItem()
	slot0:addEvent()
end

function slot0.addEvent(slot0)
	slot0._btnitem:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEvent(slot0)
	slot0._btnitem:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView(true)
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "icon_6")

	slot0._redDot = RedDotController.instance:addRedDot(slot0._reddotitem, RedDotEnum.DotNode.BattlePassSPMain)
end

function slot0.destroy(slot0)
	slot0:removeEvent()
	gohelper.destroy(slot0.go)

	slot0.go = nil
	slot0._imgitem = nil
	slot0._btnitem = nil
	slot0._reddotitem = nil
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot and slot0._redDot.isShowRedDot
end

return slot0
