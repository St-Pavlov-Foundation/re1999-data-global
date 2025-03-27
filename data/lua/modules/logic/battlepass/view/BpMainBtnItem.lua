module("modules.logic.battlepass.view.BpMainBtnItem", package.seeall)

slot0 = class("BpMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = gohelper.cloneInPlace(slot1)

	gohelper.setActive(slot0.go, true)

	slot0._imgGo = gohelper.findChild(slot0.go, "bg")
	slot0._imgitem = gohelper.findChildImage(slot0._imgGo, "")
	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.getClickWithAudio(slot0._imgGo, AudioEnum.UI.play_ui_role_pieces_open)

	slot0:_initReddotitem(slot0.go)

	slot0._goexpup = gohelper.findChild(slot0.go, "#go_expup")

	gohelper.setActive(slot0._goexpup, BpModel.instance:isShowExpUp())

	if BpConfig.instance:getBpCO(BpModel.instance.id) and slot2.isSp then
		gohelper.setActive(gohelper.findChild(slot0.go, "link"), true)
	end

	slot0:addEvent()
	slot0:_refreshItem()
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

	BpController.instance:openBattlePassView()
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "icon_3", true)
	slot0._redDot:refreshDot()
end

function slot0.destroy(slot0)
	slot0:removeEvent()
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot.show
end

function slot0._initReddotitem(slot0, slot1)
	slot0._redDot = RedDotController.instance:addRedDot(gohelper.findChild(slot1, "go_activityreddot"), RedDotEnum.DotNode.BattlePass)

	return

	for slot8 = 1, gohelper.findChild(slot1, "go_activityreddot/#go_special_reds").transform.childCount do
		gohelper.setActive(slot3:GetChild(slot8 - 1).gameObject, false)
	end

	slot5 = gohelper.findChild(slot2, "#go_bp_red")
	slot0._redDot = RedDotController.instance:addRedDotTag(slot5, RedDotEnum.DotNode.BattlePass, false, slot0._onRefreshDot, slot0)
	slot0._btnitem2 = gohelper.getClickWithAudio(slot5, AudioEnum.UI.play_ui_role_pieces_open)
end

function slot0._onRefreshDot(slot0, slot1)
	slot2 = RedDotModel.instance:isDotShow(slot1.dotId, 0)
	slot1.show = slot2

	gohelper.setActive(slot1.go, slot2)
	gohelper.setActive(slot0._imgGo, not slot2)
end

return slot0
