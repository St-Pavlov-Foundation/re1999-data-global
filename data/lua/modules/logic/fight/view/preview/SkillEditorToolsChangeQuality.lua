module("modules.logic.fight.view.preview.SkillEditorToolsChangeQuality", package.seeall)

slot0 = class("SkillEditorToolsChangeQuality", BaseViewExtended)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onBtnClick(slot0)
	slot0:getParentView():hideToolsBtnList()
	gohelper.setActive(slot0._btn, true)
end

function slot0.onOpen(slot0)
	slot0:getParentView():addToolBtn("画质", slot0._onBtnClick, slot0)

	slot0._btn = slot0:getParentView():addToolViewObj("画质")
	slot0._item = gohelper.findChild(slot0._btn, "variant")

	slot0:_showData()
end

function slot0._showData(slot0)
	slot0:com_createObjList(slot0._onItemShow, {
		ModuleEnum.Performance.High,
		ModuleEnum.Performance.Middle,
		ModuleEnum.Performance.Low
	}, slot0._btn, slot0._item)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildText(slot1, "Text")
	slot5 = ""

	if slot2 == ModuleEnum.Performance.High then
		slot5 = "高"
	elseif slot2 == ModuleEnum.Performance.Middle then
		slot5 = "中"
	elseif slot2 == ModuleEnum.Performance.Low then
		slot5 = "低"
	end

	slot4.text = slot5

	slot0:addClickCb(gohelper.getClick(slot1), slot0._onItemClick, slot0, slot2)
end

function slot0._onItemClick(slot0, slot1)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(slot1)
	FightEffectPool.dispose()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
