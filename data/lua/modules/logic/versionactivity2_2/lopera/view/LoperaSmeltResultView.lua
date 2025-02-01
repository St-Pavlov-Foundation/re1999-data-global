module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltResultView", package.seeall)

slot0 = class("LoperaSmeltResultView", BaseView)
slot1 = LoperaEnum.MapCfgIdx
slot2 = VersionActivity2_2Enum.ActivityId.Lopera
slot3 = "<color=#21631a>%s</color>"
slot4 = {
	Done = 2,
	Smelting = 1
}
slot5 = 2

function slot0.onInitView(slot0)
	slot0._goStage1 = gohelper.findChild(slot0.viewGO, "#go_Stage1")
	slot0._goStage2 = gohelper.findChild(slot0.viewGO, "#go_Stage2")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Stage2/#btn_Close")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "#go_Stage2/#scroll_List/Viewport/Content/#go_Item")
	slot0._goItemRoot = gohelper.findChild(slot0.viewGO, "#go_Stage2/#scroll_List/Viewport/Content")

	gohelper.setActive(slot0._goItem, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.GoodItemClick, slot0._onClickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam

	slot0:changeViewStage(uv0.Smelting)
	TaskDispatcher.runDelay(slot0.changeViewDoneStage, slot0, uv1)
end

function slot0.refreshStageView(slot0)
	gohelper.setActive(slot0._goStage1, slot0._curStage == uv0.Smelting)
	gohelper.setActive(slot0._goStage2, slot0._curStage == uv0.Done)

	if slot0._curStage == uv0.Done then
		slot0:refreshProductItems()
	end
end

function slot0.changeViewDoneStage(slot0)
	slot0:changeViewStage(uv0.Done)
end

function slot0.changeViewStage(slot0, slot1)
	slot0._curStage = slot1

	slot0:refreshStageView()
end

function slot0.refreshProductItems(slot0)
	slot1 = {}

	if not Activity168Model.instance:getItemChangeDict() then
		return
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7 > 0 then
			slot1[#slot1 + 1] = {
				id = slot6,
				num = slot7
			}
		end
	end

	gohelper.CreateObjList(slot0, slot0._createItem, slot1, slot0._goItemRoot, slot0._goItem, LoperaGoodsItem)
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateData(Activity168Config.instance:getGameItemCfg(uv0, slot2.id), slot2.num, slot3)
end

function slot0._onClickItem(slot0, slot1)
	gohelper.setActive(slot0._tipsGo, true)

	slot3 = slot0._tipsGo.transform

	slot3:SetParent(gohelper.findChild(slot0._goItemRoot, slot1).transform, true)
	recthelper.setAnchorX(slot3, 320)
	recthelper.setAnchorY(slot3, -30)
	slot3:SetParent(slot0.viewGO.transform, true)
	slot0:_refreshGoodItemTips(slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
