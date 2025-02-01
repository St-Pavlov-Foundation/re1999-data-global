module("modules.logic.prototest.view.ProtoTestFileItem", package.seeall)

slot0 = class("ProtoTestFileItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtFileName = gohelper.findChildText(slot1, "Txt_casefile")
	slot0._btnRecover = gohelper.findChildButtonWithAudio(slot1, "Btn_recover")
	slot0._btnLoad = gohelper.findChildButtonWithAudio(slot1, "Btn_load")
	slot0._btnAppend = gohelper.findChildButtonWithAudio(slot1, "Btn_append")
end

function slot0.addEventListeners(slot0)
	slot0._btnRecover:AddClickListener(slot0._onClickBtnRecover, slot0)
	slot0._btnLoad:AddClickListener(slot0._onClickBtnLoad, slot0)
	slot0._btnAppend:AddClickListener(slot0._onClickBtnAppend, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnRecover:RemoveClickListener()
	slot0._btnLoad:RemoveClickListener()
	slot0._btnAppend:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtFileName.text = slot1.id .. ". " .. slot1.fileName
end

function slot0._onClickBtnRecover(slot0)
	ProtoTestMgr.instance:saveToFile(slot0._mo.fileName, ProtoTestCaseModel.instance:getList())
end

function slot0._onClickBtnLoad(slot0)
	for slot5, slot6 in ipairs(ProtoTestMgr.instance:readFromFile(slot0._mo.fileName)) do
		slot6.id = slot5
	end

	ProtoTestCaseModel.instance:setList(slot1)
end

function slot0._onClickBtnAppend(slot0)
	for slot7, slot8 in ipairs(ProtoTestMgr.instance:readFromFile(slot0._mo.fileName)) do
		slot8.id = slot7 + #ProtoTestCaseModel.instance:getList()

		table.insert(slot2, slot8)
	end

	ProtoTestCaseModel.instance:setList(slot2)
end

return slot0
