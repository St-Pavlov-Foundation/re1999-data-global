module("modules.logic.fight.view.FightEditorStateView", package.seeall)

slot0 = class("FightEditorStateView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnListRoot = gohelper.findChild(slot0.viewGO, "root/topLeft/ScrollView/Viewport/Content")
	slot0._btnModel = gohelper.findChild(slot0._btnListRoot, "btnModel")
	slot0._center = gohelper.findChild(slot0.viewGO, "root/center")
	slot0._closeBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/topRight/Button")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._closeBtn, slot0._onBtnClose, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:com_createObjList(slot0._onBtnItemShow, {
		{
			name = "最后一回合"
		},
		{
			name = "战场日志"
		}
	}, slot0._btnListRoot, slot0._btnModel)
	slot0:_onBtnClick1()
end

function slot0._onBtnItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "text").text = slot2.name

	slot0:addClickCb(gohelper.findChildClick(slot1, "btn"), slot0["_onBtnClick" .. slot3], slot0)
end

function slot0._onBtnClick1(slot0)
	slot0:openExclusiveView(nil, 1, FightEditorStateLastRoundLogView, "ui/viewres/fight/fighteditorstatelogview.prefab", slot0._center)
end

function slot0._onBtnClick2(slot0)
	slot0:openExclusiveView(nil, 2, FightEditorStateLogView, "ui/viewres/fight/fighteditorstatelogview.prefab", slot0._center)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
