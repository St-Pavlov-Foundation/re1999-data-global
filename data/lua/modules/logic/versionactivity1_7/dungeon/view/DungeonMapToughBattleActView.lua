module("modules.logic.versionactivity1_7.dungeon.view.DungeonMapToughBattleActView", package.seeall)

slot0 = class("DungeonMapToughBattleActView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_toughbattle")
	slot0._gotoughbattle = gohelper.findChild(slot0.viewGO, "#go_toughbattle/#go_toughbattle")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_toughbattle/#go_toughbattle/#btn_entry")
	slot0._gochallenge = gohelper.findChild(slot0.viewGO, "#go_toughbattle/#go_toughbattle/#btn_entry/go_challenge")
	slot0._gored = gohelper.findChild(slot0.viewGO, "#go_toughbattle/#go_toughbattle/#go_reddot")
	slot0._anim = slot0._gotoughbattle:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0.onClickToughBattle, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, slot0.onActStateChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, slot0.onActStateChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
end

function slot0.refreshView(slot0)
	slot0.chapterId = slot0.viewParam.chapterId

	slot0:onActStateChange()
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V1a9ToughBattle)

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		slot0._anim:Play("close", 0, 1)
	else
		slot0._anim:Play("open", 0, 0)
	end
end

function slot0.onOpen(slot0)
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0._anim:Play("close", 0, 0)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0._anim:Play("open", 0, 0)
	end
end

function slot0.setEpisodeListVisible(slot0, slot1)
	if slot1 and slot0:isShowRoot() then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("close", 0, 0)
	end
end

function slot0.isShowRoot(slot0)
	if ToughBattleModel.instance:getActIsOnline() and slot0.chapterId == DungeonEnum.ChapterId.Main1_7 then
		return true
	end
end

function slot0.onActStateChange(slot0)
	if slot0:isShowRoot() then
		gohelper.setActive(slot0._gotoughbattle, true)
		gohelper.setActive(slot0._goroot, true)
		gohelper.setActive(slot0._gochallenge, ToughBattleModel.instance:getActInfo().openChallenge)
	else
		gohelper.setActive(slot0._gotoughbattle, false)
		gohelper.setActive(slot0._goroot, false)
	end
end

function slot0.onClickToughBattle(slot0)
	ToughBattleModel.instance:setIsJumpActElement(true)

	if not slot0:isInMain_7_28() then
		JumpController.instance:jumpByParam("4#10728#1")
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, ToughBattleEnum.ActElementId)
end

function slot0.isInMain_7_28(slot0)
	if not slot0.viewContainer:getMapScene() then
		return false
	end

	if not slot2._mapCfg then
		return false
	end

	return slot3.id == ToughBattleEnum.MapId_7_28
end

return slot0
