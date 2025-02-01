module("modules.logic.fight.view.FightEditorStateLastRoundLogView", package.seeall)

slot0 = class("FightEditorStateLastRoundLogView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnListRoot = gohelper.findChild(slot0.viewGO, "btnScrill/Viewport/Content")
	slot0._btnModel = gohelper.findChild(slot0._btnListRoot, "btnModel")
	slot0._logText = gohelper.findChildText(slot0.viewGO, "ScrollView/Viewport/Content/logText")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:com_createObjList(slot0._onBtnItemShow, {
		{
			name = "复制"
		}
	}, slot0._btnListRoot, slot0._btnModel)

	if not GameSceneMgr.instance:getCurScene().fightLog then
		return
	end

	if not slot2:getLastRoundProto() then
		slot0._logText.text = "没有数据"

		return
	end

	slot0._strList = {}

	slot0:addLog("回合" .. slot3.round)
	slot0:addLog(tostring(slot3.proto))

	slot0._logText.text = FightEditorStateLogView.processStr(table.concat(slot0._strList, "\n"))
end

function slot0._onBtnItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "text").text = slot2.name

	slot0:addClickCb(gohelper.findChildClick(slot1, "btn"), slot0["_onBtnClick" .. slot3], slot0)
end

function slot0._onBtnClick1(slot0)
	ZProj.UGUIHelper.CopyText(slot0._logText.text)
end

function slot0.addLog(slot0, slot1)
	table.insert(slot0._strList, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
