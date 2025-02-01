module("modules.logic.dungeon.view.DungeonMapOtherBtnView", package.seeall)

slot0 = class("DungeonMapOtherBtnView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._btnequipstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_equipstore")
	slot0._txtequipstore = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_equipstore/#txt_equipstore")
	slot0._txtequipstoreen = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_equipstore/#txt_equipstoreen")
	slot0._gorolestory = gohelper.findChild(slot0.viewGO, "#go_rolestory")
	slot0._btnrolestory = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolestory/#btn_review")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnequipstore:AddClickListener(slot0._btnEquipStoreOnClick, slot0)
	slot0._btnrolestory:AddClickListener(slot0._btnRoleStoryOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnequipstore:RemoveClickListener()
	slot0._btnrolestory:RemoveClickListener()
end

function slot0._btnRoleStoryOnClick(slot0)
	RoleStoryController.instance:openReviewView()
end

function slot0._btnEquipStoreOnClick(slot0)
	StoreController.instance:openStoreView(StoreEnum.SummonEquipExchange)
end

function slot0._editableInitView(slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0:refreshUI()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0:refreshUI()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0._txtequipstore.text = luaLang("equip_store_name")
	slot0._txtequipstoreen.text = "PSYCHUBE SHOP"

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.isEquipDungeon = DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Equip

	gohelper.setActive(slot0._gotopright, slot0.isEquipDungeon and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView))
	gohelper.setActive(slot0._gorolestory, not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and DungeonModel.instance:chapterListIsRoleStory() and RoleStoryModel.instance:isShowReplayStoryBtn())
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
